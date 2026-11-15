B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	Type BLLayoutHeader (Version As Int, GridSize As Int, Files As List, DesignerScripts As List, FontAwesome As Boolean, MaterialIcons As Boolean, _
		Variants As List)
	Type BLVariant (Scale As Float, Width As Int, Height As Int)
	Type BLProperty (PropType As Byte, Value As Object)
	Type BLView (DesignerType As String, DisplayType As String, JavaType As String, Name As String, Parent As String, EventName As String, Visible As Boolean, Children As List, _
		VariantValues As List, ExtraProperties As Map)
	Type BLVariantValues (X1 As Int, X2 As Int, Y1 As Int, Y2 As Int, HAnchor As Int, VAnchor As Int)
	Public Const PROP_INT = 1, PROP_STRING = 2, PROP_MAP = 3, PROP_ENDOFMAP = 4, PROP_BOOL = 5, PROP_COLOR = 6, _
		PROP_FLOAT = 7, PROP_CACHED_STRING = 9, PROP_RECT32 = 11, PROP_NULL = 12 As Byte
	Public Const ANCHOR_LEFT = 0, ANCHOR_RIGHT = 1, ANCHOR_BOTH = 2, ANCHOR_TOP = 0, ANCHOR_BOTTOM = 1 As Int
	Private byteConv As ByteConverter
	Public Header As BLLayoutHeader
	Public MainView As BLView
	Public ViewsMap As B4XOrderedMap
	Private ReadingCache() As String
	Private SCRIPT_BUFFER_SIZE = 100000, VIEWS_BUFFER_SIZE = 1000000 As Int
	Private IgnoreKeysDuringDescribe As B4XSet
	Private DefaultValuesIgnored As Map
End Sub

'Call ReadFromBinary to load a binary layout file.
Public Sub Initialize As BLLayout
	Return Me
End Sub

'Writes the layout to a binary layout file.
Public Sub WriteToBinary(Dir As String, FileName As String)
	Dim ToBil As Boolean = FileName.EndsWith(".bil")
	Dim writer As RandomAccessFile
	writer.Initialize2(Dir, FileName, False, True)
	WriteLayoutHeader(writer)
	WriteAllLayout(writer, ToBil)
	writer.WriteByte(IIf(Header.FontAwesome, 1, 0), writer.CurrentPosition)
	writer.WriteByte(IIf(Header.MaterialIcons, 1, 0), writer.CurrentPosition)
	writer.Close
End Sub

'Reads a binary layout file.
Public Sub ReadFromBinary(Dir As String, FileName As String)
	Dim reader As RandomAccessFile
	reader.Initialize2(Dir, FileName, True, True)
	Header = ReadLayoutHeader(reader)
	ReadingCache = LoadStringsCache(reader)
	Dim numberOfVariants As Int = reader.ReadInt(reader.CurrentPosition)
	Header.Variants.Initialize
	For i = 0 To numberOfVariants - 1
		Header.Variants.Add(ReadVariantFromStream(reader))
	Next
	
	Dim m As Map = ReadMap(reader)
	ViewsMap.Initialize
	MainView = ProcessRawMap(m)
	reader.ReadInt(reader.CurrentPosition) '0
	Header.FontAwesome = reader.ReadSignedByte(reader.CurrentPosition) = 1
	Header.MaterialIcons = reader.ReadSignedByte(reader.CurrentPosition) = 1
	reader.Close
End Sub

Private Sub ProcessRawMap(m As Map) As BLView
	Dim res As BLView
	res.Initialize
	res.Name = GetAndRemove(m, "name")
	ViewsMap.Put(res.Name, res)
	res.DesignerType = GetAndRemove(m, "csType")
	res.DisplayType = GetAndRemove(m, "type")
	res.JavaType = GetAndRemove(m, "javaType")
	res.EventName = GetAndRemove(m, "eventName")
	res.Parent = GetAndRemove(m, "parent")
	res.Visible = GetAndRemove(m, "visible")
	GetAndRemove(m, "javaType")
	res.VariantValues.Initialize
	For i = 0 To Header.Variants.Size - 1
		Dim v As Map = GetAndRemove(m, "variant" & i)
		Dim vv As BLVariantValues
		vv.Initialize
		vv.X1 = GetAndRemove(v, "left")
		vv.X2 = GetAndRemove(v, "width")
		vv.Y1 = GetAndRemove(v, "top")
		vv.Y2 = GetAndRemove(v, "height")
		vv.HAnchor = GetAndRemove(v, "hanchor")
		vv.VAnchor = GetAndRemove(v, "vanchor")
		res.VariantValues.Add(vv)
	Next
	Dim kids As Map = GetAndRemove(m, ":kids")
	If Initialized(kids) Then
		res.Children.Initialize
		For i = 0 To kids.Size - 1
			res.Children.Add(ProcessRawMap(kids.Get(i.As(String)).As(BLProperty).Value))
		Next
	End If
	res.ExtraProperties = m
	Return res
End Sub

Private Sub ViewToRawMap (v As BLView) As Map
	Dim m As Map = B4XCollections.MergeMaps(v.ExtraProperties, Null)
	m.Put("name", CreateProperty(v.Name, PROP_CACHED_STRING))
	m.Put("csType", CreateProperty(v.DesignerType, PROP_CACHED_STRING))
	m.Put("javaType", CreateProperty(v.JavaType, PROP_CACHED_STRING))
	m.Put("type", CreateProperty(v.DisplayType, PROP_CACHED_STRING))
	m.Put("eventName", CreateProperty(v.EventName, PROP_CACHED_STRING))
	m.Put("parent", CreateProperty(v.Parent, PROP_CACHED_STRING))
	m.Put("visible", CreateProperty(v.Visible, PROP_BOOL))
	For i = 0 To Header.Variants.Size - 1
		Dim vv As BLVariantValues = v.VariantValues.Get(i)
		Dim vm As Map = CreateMap("left":  CreateProperty(vv.X1, PROP_INT), "width":  CreateProperty(vv.X2, PROP_INT), _
		"top":  CreateProperty(vv.Y1, PROP_INT), "height":  CreateProperty(vv.Y2, PROP_INT), _
			"hanchor":  CreateProperty( vv.HAnchor, PROP_INT), "vanchor": CreateProperty(vv.VAnchor, PROP_INT))
		m.Put("variant" & i, CreateProperty(vm, PROP_MAP))
	Next
	If Initialized(v.Children) Then
		Dim kids As Map = CreateMap()
		For i = 0 To v.Children.Size - 1
			kids.Put(i.As(String), CreateProperty(ViewToRawMap(v.Children.Get(i)), PROP_MAP))
		Next
		m.Put(":kids", CreateProperty(kids, PROP_MAP))
	End If
	Return m
End Sub

Private Sub GetAndRemove(m As Map, key As String) As Object
	Dim o As Object = m.Get(key)
	m.Remove(key)
	Return IIf(o = Null, Null, o.As(BLProperty).Value)
End Sub

Private Sub ReadMap(raf As RandomAccessFile) As Map
	Dim props As Map
	props.Initialize
	Dim stop As Boolean
	Do Until stop
		Dim key As String = ReadCachedString(raf)
		Dim b As Byte = raf.ReadSignedByte(raf.CurrentPosition)
		Dim value As BLProperty
		Select b
			Case PROP_INT
				value = CreateProperty(raf.ReadInt(raf.CurrentPosition), b)
			Case PROP_CACHED_STRING
				value = CreateProperty(ReadCachedString(raf), b)
			Case PROP_STRING
				value = CreateProperty(ReadString(raf), b)
			Case PROP_FLOAT
				value = CreateProperty(raf.ReadFloat(raf.CurrentPosition), b)
			Case PROP_MAP
				value = CreateProperty(ReadMap(raf), b)
			Case PROP_BOOL
				value = CreateProperty((raf.ReadSignedByte(raf.CurrentPosition) = 1), b)
			Case PROP_COLOR
				Dim Data(4) As Byte
				raf.ReadBytes(Data, 0, Data.Length, raf.CurrentPosition)
				value = CreateProperty("0x" & byteConv.HexFromBytes(Data), b)
			Case PROP_ENDOFMAP
				stop = True
			Case PROP_NULL
				value = CreateProperty(Null, b)
			Case PROP_RECT32
				Dim Data(8) As Byte
				raf.ReadBytes(Data, 0, Data.Length, raf.CurrentPosition)
				Dim shorts() As Short = byteConv.ShortsFromBytes(Data)
				Dim sl As List
				sl.Initialize2(shorts)
				value = CreateProperty(sl, b)
			Case Else
				Log("error")
		End Select
		If stop = False Then props.Put(key, value)
	Loop
	Return props
End Sub

Private Sub WriteMap(raf As RandomAccessFile, m As Map, WritingCache As Map, ToBil As Boolean)
	For Each k As String In m.Keys
		Dim val As BLProperty = m.Get(k)
		If ToBil And (val.PropType = PROP_NULL Or val.PropType = PROP_RECT32) Then Continue
		WriteCachedString(raf, WritingCache, k)
		raf.WriteByte(val.PropType, raf.CurrentPosition)
		Select val.PropType
			Case PROP_STRING
				WriteString(raf, val.Value)
			Case PROP_FLOAT
				raf.WriteFloat(val.Value, raf.CurrentPosition)
			Case PROP_COLOR
				Dim hexColor As String = val.Value
				Dim Data() As Byte = byteConv.HexToBytes(hexColor.SubString(2))
				raf.WriteBytes(Data, 0, Data.Length, raf.CurrentPosition)
			Case PROP_RECT32
				Dim sl As List = val.Value
				Dim shorts(4) As Short
				For i = 0 To 3
					shorts(i) = sl.Get(i)
				Next
				Dim Data() As Byte = byteConv.ShortsToBytes(shorts)
				raf.WriteBytes(Data, 0, Data.Length, raf.CurrentPosition)
						
			Case PROP_NULL
				'do nothing
			Case PROP_MAP
				WriteMap(raf, val.Value, WritingCache, ToBil)
				WriteString(raf, "")
				raf.WriteByte(PROP_ENDOFMAP, raf.CurrentPosition)
			Case PROP_INT
				raf.WriteInt(val.Value, raf.CurrentPosition)
			Case PROP_CACHED_STRING
				WriteCachedString(raf, WritingCache, val.Value)
			Case PROP_BOOL
				If val.Value.As(Boolean) Then raf.WriteByte(1, raf.CurrentPosition) Else raf.WriteByte(0, raf.CurrentPosition)
		End Select
	Next
End Sub

Private Sub WriteLayoutHeader(raf As RandomAccessFile)
	Dim version As Int = Header.Version
	raf.WriteInt(version, raf.CurrentPosition)
	Dim stub As Int = raf.CurrentPosition
	raf.WriteInt(0, raf.CurrentPosition) 'stub
	raf.WriteInt(Header.GridSize, raf.CurrentPosition)
	Dim HeaderCache As Map = CreateMap()
	For Each v As BLView In ViewsMap.Values 'fill the cache before it is written
		AddCachedStringIfNeeded(HeaderCache, v.Name)
		AddCachedStringIfNeeded(HeaderCache, v.JavaType)
		AddCachedStringIfNeeded(HeaderCache, v.DesignerType)
	Next
	WriteStringsCache(raf, HeaderCache)
	raf.WriteInt(ViewsMap.Size, raf.CurrentPosition)
	For Each v As BLView In ViewsMap.Values
		WriteCachedString(raf, HeaderCache, v.Name)
		WriteCachedString(raf, HeaderCache, v.JavaType)
		WriteCachedString(raf, HeaderCache, v.DesignerType)
	Next
	Dim files As List = Header.Files
	raf.WriteInt(files.Size, raf.CurrentPosition)
	For Each f As String In files
		WriteString(raf, f)
	Next
	Dim Script() As Byte = WriteScripts()
	raf.WriteInt(Script.Length, raf.CurrentPosition)
	raf.WriteBytes(Script, 0, Script.Length, raf.CurrentPosition)
	Dim position As Int = raf.CurrentPosition
	raf.WriteInt(position - stub - 4, stub)
	raf.CurrentPosition = position
End Sub

Private Sub WriteAllLayout(raf As RandomAccessFile, ToBil As Boolean)
	Dim WritingCache As Map = CreateMap()
	Dim b(VIEWS_BUFFER_SIZE) As Byte
	Dim temp As RandomAccessFile
	temp.Initialize3(b, True)
	temp.WriteInt(Header.Variants.Size, temp.CurrentPosition)
	For Each v As BLVariant In Header.Variants
		WriteVariant(temp, v)
	Next
	WriteMap(temp, ViewToRawMap(MainView), WritingCache, ToBil)
	WriteString(temp, "")
	temp.WriteByte(PROP_ENDOFMAP, temp.CurrentPosition)
	WriteStringsCache(raf, WritingCache)
	raf.WriteBytes(b, 0, temp.CurrentPosition, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
End Sub

Private Sub WriteVariant(temp As RandomAccessFile, v As BLVariant)
	temp.WriteFloat(v.Scale, temp.CurrentPosition)
	temp.WriteInt(v.Width, temp.CurrentPosition)
	temp.WriteInt(v.Height, temp.CurrentPosition)
End Sub

Private Sub ReadLayoutHeader(raf As RandomAccessFile) As BLLayoutHeader
	Dim Data As BLLayoutHeader
	Data.Initialize
	Dim version As Int = raf.ReadInt(raf.CurrentPosition)
	Data.Version = version
	If version < 5 Then
		ThrowException("Version too low")
	End If
	raf.CurrentPosition = raf.CurrentPosition + 4
	Dim gridSize As Int = 10
	If version >= 4 Then gridSize = raf.ReadInt(raf.CurrentPosition)
	Data.GridSize = gridSize
	ReadingCache = LoadStringsCache(raf)
	Dim numberOfControls As Int = raf.ReadInt(raf.CurrentPosition)
	For i = 0 To numberOfControls - 1
		ReadCachedString(raf)
		ReadCachedString(raf)
		ReadCachedString(raf)
	Next
	Dim numberOfFiles As Int = raf.ReadInt(raf.CurrentPosition)
	Dim files As List
	files.Initialize
	For i = 0 To numberOfFiles - 1
		files.Add(ReadString(raf))
	Next
	Data.Files = files
	Data.DesignerScripts = ReadScripts(raf)
	Return Data
End Sub

Private Sub ReadScripts (raf As RandomAccessFile) As List
	Dim rawData(raf.ReadInt(raf.CurrentPosition)) As Byte
	raf.ReadBytes(rawData, 0, rawData.Length, raf.CurrentPosition)
	Dim cs As CompressedStreams
	Dim script As RandomAccessFile
	script.Initialize3(cs.DecompressBytes(rawData, "gzip"), True)
	Dim res As List
	res.Initialize
	res.Add(ReadBinaryString(script)) 'general
	Dim NumberOfVariants As Int = script.ReadInt(script.CurrentPosition)
	For i = 0 To NumberOfVariants - 1
		ReadVariantFromStream(script) 'not used
		res.Add(ReadBinaryString(script))
	Next
	Return res
End Sub

Private Sub WriteScripts () As Byte()
	Dim buffer(SCRIPT_BUFFER_SIZE) As Byte
	Dim temp As RandomAccessFile
	temp.Initialize3(buffer, True)
	WriteBinaryString(temp, Header.DesignerScripts.Get(0))
	Dim ScriptIndex As Int = 1
	temp.WriteInt(Header.Variants.Size, temp.CurrentPosition)
	For Each v As BLVariant In Header.Variants
		WriteVariant(temp, v)
		WriteBinaryString(temp, Header.DesignerScripts.Get(ScriptIndex))
		ScriptIndex = ScriptIndex + 1
	Next
	Dim TrimBuffer(temp.CurrentPosition) As Byte
	Bit.ArrayCopy(buffer, 0, TrimBuffer, 0, temp.CurrentPosition)
	Dim cs As CompressedStreams
	Return cs.CompressBytes(TrimBuffer, "gzip")
End Sub

Private Sub ReadBinaryString (raf As RandomAccessFile) As String
	Dim length As Int
	Dim Shift As Int
	Do While True
		Dim b As Byte = raf.ReadSignedByte(raf.CurrentPosition)
		Dim value As Int = Bit.And(0x7f, b)
		length = length + Bit.ShiftLeft(value, Shift)
		If b = value Then Exit
		Shift = Shift + 7
	Loop
	Dim bb(length) As Byte
	raf.ReadBytes(bb, 0, bb.length, raf.CurrentPosition)
	Return BytesToString(bb, 0, length, "utf8")
End Sub

Private Sub WriteBinaryString (raf As RandomAccessFile, s As String)
	Dim bin As String = Bit.ToBinaryString(s.Length)
	Dim NumberOf7Bits As Int = Ceil(bin.Length / 7)
	For i = 0 To NumberOf7Bits - 1
		Dim b As Byte
		If i < NumberOf7Bits - 1 Then
			b = Bit.ParseInt(bin.SubString(bin.Length - 7), 2)
			b = Bit.Or(0x80, b)
			bin = bin.SubString2(0, bin.Length - 7)
		Else
			b = Bit.ParseInt(bin, 2)
		End If
		raf.WriteByte(b, raf.CurrentPosition)
	Next
	Dim raw() As Byte = s.GetBytes("utf8")
	raf.WriteBytes(raw, 0, raw.Length, raf.CurrentPosition)
End Sub


Private Sub ReadVariantFromStream(raf As RandomAccessFile) As BLVariant
	Return CreateVariant(raf.ReadFloat(raf.CurrentPosition), raf.ReadInt(raf.CurrentPosition), raf.ReadInt(raf.CurrentPosition))
End Sub

Private Sub LoadStringsCache(raf As RandomAccessFile) As String()
	Dim cache(raf.ReadInt(raf.CurrentPosition)) As String
	For i = 0 To cache.Length - 1
		cache(i) = ReadString(raf)
	Next
	Return cache
End Sub

Private Sub WriteStringsCache(raf As RandomAccessFile, WritingCache As Map)
	raf.WriteInt(WritingCache.Size, raf.CurrentPosition)
	For Each s As String In WritingCache.Keys
		WriteString(raf, s)
	Next
End Sub

Private Sub WriteCachedString(raf As RandomAccessFile, WritingCache As Map, s As String)
	raf.WriteInt(AddCachedStringIfNeeded(WritingCache, s), raf.CurrentPosition)
End Sub

Private Sub AddCachedStringIfNeeded (WritingCache As Map, s As String) As Int
	Dim slot As Int = WritingCache.GetDefault(s, -1)
	If slot = -1 Then
		WritingCache.Put(s, WritingCache.Size)
		Return WritingCache.Size - 1
	Else
		Return slot
	End If
End Sub

Private Sub ReadCachedString(raf As RandomAccessFile) As String
	If ReadingCache.Length = 0 Then Return ReadString(raf)
	Dim index As Int = raf.ReadInt(raf.CurrentPosition)
	Return ReadingCache(index)
End Sub

Private Sub WriteString(raf As RandomAccessFile, s As String)
	Dim Data() As Byte = s.GetBytes("UTF8")
	raf.WriteInt(Data.Length, raf.CurrentPosition)
	raf.WriteBytes(Data, 0, Data.Length, raf.CurrentPosition)
End Sub

Private Sub ReadString(raf As RandomAccessFile) As String
	Dim len As Int = raf.ReadInt(raf.CurrentPosition)
	Dim Data(len) As Byte
	raf.ReadBytes(Data, 0, Data.Length, raf.CurrentPosition)
	Return BytesToString(Data, 0, Data.Length, "UTF8")
End Sub

'Creates a BLProperty. Tries to set the property type based on the value type if omitted. For colors, the type must be set explicitly.
Public Sub CreateProperty (Value As Object, PropType As Int = -1) As BLProperty
	If PropType = -1 Then
		If Value = Null Then
			PropType = PROP_NULL
		Else If Value Is String Then
			PropType = PROP_STRING
		Else If Value Is Int Then
			PropType = PROP_INT
		Else If Value Is Double Or Value Is Float Then
			PropType = PROP_FLOAT
		Else If Value Is Map Then
			PropType = PROP_MAP
		Else
			ThrowException("Can't set type automatically. Set it explicitly")
		End If
	End If
	Dim t1 As BLProperty
	t1.Initialize
	t1.PropType = PropType
	t1.Value = Value
	Return t1
End Sub

Public Sub CreateVariant (Scale As Float, Width As Int, Height As Int) As BLVariant
	Dim t1 As BLVariant
	t1.Initialize
	t1.Scale = Scale
	t1.Width = Width
	t1.Height = Height
	Return t1
End Sub

'Returns a property value, not including the common properties that were extracted and assigned to BLView type fields.
Public Sub GetExtra(v As BLView, Key As String, DefaultValue As Object = Null) As Object
	Dim prop As BLProperty = v.ExtraProperties.Get(Key)
	If prop = Null Then Return DefaultValue
	Return IIf(prop.Value = Null, DefaultValue, prop.Value)
End Sub

'Returns a text representation of the layout. Useful for debugging or AI context. Not all properties are kept. Not to be used as a persistent storing format.
Public Sub Describe As String
	IgnoreKeysDuringDescribe = B4XCollections.CreateSet2(Array("hanchor", "vanchor", "height", "width", "left", "top", "csType", _
		"shadow", "customType"))
	DefaultValuesIgnored = CreateMap("enabled": True, "alpha": (1).As(Float), "visible": True, "borderWidth": (0).As(Float), _
		"cornerRadius": (0).As(Float), "orientation": "INHERIT", "duration": 0, "bold": False, "italic": False)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("*** Variants ***").Append(CRLF)
	sb.Append("General script: ").Append(Header.DesignerScripts.Get(0))
	For i = 0 To Header.Variants.Size - 1
		Dim v As BLVariant = Header.Variants.Get(i)
		sb.Append("Variant ").Append(i).Append(": ").Append(v.Width).Append(" x ").Append(v.Height).Append(" (scale=").Append(v.Scale).Append(")")
		sb.Append(CRLF)
		sb.Append("Variant script: ").Append(Header.DesignerScripts.Get(1 + i)).Append(CRLF)
	Next
	sb.Append(" *** Views ***").Append(CRLF)
	DescribeView(sb, MainView, "")
	Return sb.ToString
End Sub

Private Sub DescribeView (sb As StringBuilder, v As BLView, indendation As String)
	Dim TypeProp As String = GetExtra(v, "customType", "")
	If TypeProp = "" Then TypeProp = v.JavaType
	sb.Append(indendation).Append(v.Name).Append(" (").Append(TypeProp & ")").Append(CRLF)
	indendation = indendation & TAB
	sb.Append(indendation).Append("EventName: ").Append(v.EventName).Append(CRLF)
	If v.Parent <> "" Then
		For i = 0 To Header.Variants.Size - 1
			sb.Append(indendation).Append("Variant ").Append(i).Append(": ")
			DescribeVariantValues(sb, v.VariantValues.Get(i))
			sb.Append(CRLF)
		Next
	End If
	DescribePropsMap(sb, v.ExtraProperties, indendation)
	If Initialized(v.Children) Then
		sb.Append(indendation).Append("*** Children ***").Append(CRLF)
		For Each c As BLView In v.Children
			DescribeView(sb, c, indendation)
		Next
	End If
End Sub

Private Sub DescribePropsMap(sb As StringBuilder, m As Map, indendation As String)
	For Each key As String In m.Keys
		If IgnoreKeysDuringDescribe.Contains(key) Then Continue
		Dim prop As BLProperty = m.Get(key)
		If prop.PropType = PROP_NULL Then Continue
		Dim value As Object = prop.Value
		If value = Null Or value = "" Then Continue
		If prop.PropType = PROP_MAP Then
			sb.Append(indendation).Append(key).Append(": ")
			sb.Append(CRLF)
			DescribePropsMap(sb, value, indendation & TAB)
		Else
			Dim d As Object = DefaultValuesIgnored.Get(key)
			If d <> Null And d = value Then Continue
			sb.Append(indendation).Append(key).Append(": ")
			If key = "fontAwesome" Or key = "materialIcons" Then
				Dim b() As Byte = value.As(String).GetBytes
				value = "0x" & byteConv.HexFromBytes(b) & " (UTF-8)"
			End If
			sb.Append(value).Append(CRLF)
		End If
	Next
End Sub

Private Sub DescribeVariantValues(sb As StringBuilder, vv As BLVariantValues)
	sb.Append("HAnchor: ")
	Select vv.HAnchor
		Case ANCHOR_LEFT
			sb.Append("LEFT - left=").Append(vv.X1).Append(", width=").Append(vv.X2)
		Case ANCHOR_RIGHT
			sb.Append("RIGHT - right=").Append(vv.X1).Append(", width=").Append(vv.X2)
		Case ANCHOR_BOTH
			sb.Append("BOTH - left=").Append(vv.X1).Append(", right=").Append(vv.X2)
	End Select
	sb.Append(" | VAnchor: ")
	Select vv.VAnchor
		Case ANCHOR_TOP
			sb.Append("TOP - top=").Append(vv.Y1).Append(", height=").Append(vv.Y2)
		Case ANCHOR_BOTTOM
			sb.Append("BOTTOM - bottom=").Append(vv.Y1).Append(", height=").Append(vv.Y2)
		Case ANCHOR_BOTH
			sb.Append("BOTH - top=").Append(vv.Y1).Append(", bottom=").Append(vv.Y2)
	End Select
End Sub