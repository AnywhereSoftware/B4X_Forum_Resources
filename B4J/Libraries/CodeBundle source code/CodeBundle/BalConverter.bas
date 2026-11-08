B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'version 2.30
Sub Class_Globals
	Public Const CINT = 1, CSTRING = 2, CMAP = 3, ENDOFMAP = 4, BOOL = 5, CCOLOR = 6, _
		CFLOAT = 7, CACHED_STRING = 9, RECT32 = 11, CNULL = 12 As Byte
	Private byteConv As ByteConverter
	Private su As StringUtils
	Public mToBIL As Boolean
End Sub


Public Sub Initialize (ToBIL As Boolean)
	byteConv.LittleEndian = True
	mToBIL = ToBIL
End Sub

Public Sub ConvertJsonToBal(Dir As String, FileName As String)
	Log("ConvertJsonToBal: " & FileName)
	Dim bfile As String = FileName.SubString2(0, FileName.Length - 5) 'remove .json
	If File.Exists(Dir, bfile) Then
		File.Copy(Dir, bfile, Dir, bfile & ".bak")
		File.Delete(Dir, bfile)
	End If
	Dim jp As JSONParser
	jp.Initialize(File.ReadString(Dir, FileName))
	Dim Json As Map = jp.NextObject
	ConvertJsonToBalInMemory(Json, Dir, bfile)
End Sub

Public Sub ConvertJsonToBalInMemory(json As Map, Dir As String, FileName As String)
	Dim writer As RandomAccessFile
	writer.Initialize2(Dir, FileName, False, True)
	Dim variants As List = json.Get("Variants")
	WriteLayoutHeader(json.Get("LayoutHeader"), writer, variants)
	WriteAllLayout(writer, variants, json.Get("Data"))
	For Each fnt As String In Array("FontAwesome", "MaterialIcons")
		Dim b As Byte
		If json.GetDefault(fnt, False) = True Then b = 1 Else b = 0
		writer.WriteByte(b, writer.CurrentPosition)
	Next
	writer.Close
End Sub

Public Sub ConvertBalToJson(Dir As String, FileName As String) As Boolean
	Log("ConvertBalToJson: " & FileName)
	Dim jfile As String = FileName  & ".json"
	If File.Exists(Dir, jfile) Then
		File.Copy(Dir, jfile, Dir, jfile & ".bak")
	End If
	Dim design As Map = ConvertBalToJsonInMemory(Dir, FileName)
	If design.IsInitialized = False Then Return False
	Dim jg As JSONGenerator
	jg.Initialize(design)
	File.WriteString(Dir, jfile, jg.ToPrettyString(4))
	Return True
End Sub

Public Sub ConvertBalToJsonInMemory(Dir As String, FileName As String) As Map
	Dim reader As RandomAccessFile
	reader.Initialize2(Dir, FileName, True, True)
	Dim design As Map
	Dim lh As Map = ReadLayoutHeader(reader)
	If lh.Get("Version") < 3 Then
#If UI
		Dim xui As XUI
		xui.MsgboxAsync("Unsupported version: " & FileName, "")
#end if
#If NON_UI
		Log("Unsupported version: " & FileName)
#End If
		Return design
	End If
	design.Initialize
	design.Put("LayoutHeader", lh)
	Dim cache() As String = LoadStringsCache(reader)
	Dim numberOfVariants As Int = reader.ReadInt(reader.CurrentPosition)
	Dim variants As List
	variants.Initialize
	For i = 0 To numberOfVariants - 1
		variants.Add(ReadVariantFromStream(reader))
	Next
	design.Put("Variants", variants)
	design.Put("Data", ReadMap(reader, cache))
	reader.ReadInt(reader.CurrentPosition) '0
	design.Put("FontAwesome", reader.ReadSignedByte(reader.CurrentPosition) = 1)
	design.Put("MaterialIcons", reader.ReadSignedByte(reader.CurrentPosition) = 1)
	reader.Close
	Return design
End Sub

Private Sub ReadMap(raf As RandomAccessFile, cache() As String) As Map
	Dim props As Map
	props.Initialize
	Dim stop As Boolean
	Do Until stop
		Dim key As String = ReadCachedString(raf, cache)
		Dim b As Byte = raf.ReadSignedByte(raf.CurrentPosition)
		Dim value As Object
		Select b
			Case CINT
				value = raf.ReadInt(raf.CurrentPosition)
			Case CACHED_STRING
				value = ReadCachedString(raf, cache)
			Case CSTRING
				value = CreateMap("ValueType": b, "Value": ReadString(raf))
				Log(key & ": " & value)
			Case CFLOAT
				value = CreateMap("ValueType": b, "Value": raf.ReadFloat(raf.CurrentPosition))
			Case CMAP
				value = ReadMap(raf, cache)
			Case BOOL
				value = (raf.ReadSignedByte(raf.CurrentPosition) = 1)
			Case CCOLOR
				Dim data(4) As Byte
				raf.ReadBytes(data, 0, data.Length, raf.CurrentPosition)
				value = CreateMap("ValueType": b, "Value": "0x" & byteConv.HexFromBytes(data))
			Case ENDOFMAP
				stop = True
			Case CNULL
				value = CreateMap("ValueType": b)
			Case RECT32
				Dim data(8) As Byte
				raf.ReadBytes(data, 0, data.Length, raf.CurrentPosition)
				Dim shorts() As Short = byteConv.ShortsFromBytes(data)
				Dim sl As List
				sl.Initialize2(shorts)
				value = CreateMap("ValueType": b, "Value": sl)
			Case Else
				Log("error")
		End Select
		If stop = False Then props.Put(key, value)
	Loop
	Return props
End Sub

Private Sub WriteMap(raf As RandomAccessFile, m As Map, cache As Map)
	For Each k As String In m.Keys
		Dim val As Object = m.Get(k)
		If mToBIL And val Is Map Then
			Dim mval As Map = val
			If mval.ContainsKey("ValueType") Then
				Dim b As Byte = mval.Get("ValueType")
				If b = CNULL Or b = RECT32 Then Continue
			End If
		End If
		WriteCachedString(raf, cache, k)
		If val Is Map Then
			Dim mval As Map = val
			If mval.ContainsKey("ValueType") Then
				Dim b As Byte = mval.Get("ValueType")
				raf.WriteByte(b, raf.CurrentPosition)
				Select b
					Case CSTRING
						WriteString(raf, mval.Get("Value"))
					Case CFLOAT
						raf.WriteFloat(mval.Get("Value"), raf.CurrentPosition)
					Case CCOLOR
						Dim hexColor As String = mval.Get("Value")
						Dim data() As Byte = byteConv.HexToBytes(hexColor.SubString(2))
						raf.WriteBytes(data, 0, data.Length, raf.CurrentPosition)
					Case RECT32
						Dim sl As List = mval.Get("Value")
						Dim shorts(4) As Short
						For i = 0 To 3
							shorts(i) = sl.Get(i)
						Next
						Dim data() As Byte = byteConv.ShortsToBytes(shorts)
						raf.WriteBytes(data, 0, data.Length, raf.CurrentPosition)
						
					Case CNULL
						'do nothing
				End Select
			Else
				'real map
				raf.WriteByte(CMAP, raf.CurrentPosition)
				WriteMap(raf, mval, cache)
				WriteString(raf, "")
				raf.WriteByte(ENDOFMAP, raf.CurrentPosition)
			End If
		Else If val Is Int Then
			raf.WriteByte(CINT, raf.CurrentPosition)
			raf.WriteInt(val, raf.CurrentPosition)
		Else If val Is String Then
			raf.WriteByte(CACHED_STRING, raf.CurrentPosition)
			WriteCachedString(raf, cache, val)
		Else If val Is Boolean Then
			raf.WriteByte(BOOL, raf.CurrentPosition)
			Dim bval As Boolean = val
			If bval Then raf.WriteByte(1, raf.CurrentPosition) Else raf.WriteByte(0, raf.CurrentPosition)
		Else if val = Null Then
			raf.WriteByte(CNULL, raf.CurrentPosition)
		Else
			Log("Error: " & val)
		End If
	Next
	
End Sub

Private Sub WriteLayoutHeader(Header As Map, raf As RandomAccessFile, variants As List)
	Dim version As Int = Header.Get("Version")
	raf.WriteInt(version, raf.CurrentPosition)
	Dim stub As Int = raf.CurrentPosition
	raf.WriteInt(0, raf.CurrentPosition) 'stub
	If version >= 4 Then
		raf.WriteInt(Header.Get("GridSize"), raf.CurrentPosition)
	End If
	Dim temp As RandomAccessFile = CreateTempFile
	Dim cache As Map
	cache.Initialize
	Dim ControlsHeaders As List = Header.Get("ControlsHeaders")
	temp.WriteInt(ControlsHeaders.Size, temp.CurrentPosition)
	For Each c As Map In ControlsHeaders
		WriteCachedString(temp, cache, c.Get("Name"))
		WriteCachedString(temp, cache, c.Get("JavaType"))
		WriteCachedString(temp, cache, c.Get("DesignerType"))
	Next
	WriteStringsCache(raf, cache)
	WriteTempToMain(temp, raf)
	Dim files As List = Header.Get("Files")
	raf.WriteInt(files.Size, raf.CurrentPosition)
	For Each f As String In files
		WriteString(raf, f)
	Next
	Dim su As StringUtils
	Dim ds As Object = Header.Get("DesignerScript")
	Dim Script() As Byte
	If ds Is String Then
		Script = su.DecodeBase64(ds)
		Script(0) = 31
	Else
		Dim scripts As List = ds
		Script = WriteScripts(scripts, variants)
		
	End If
	raf.WriteInt(Script.Length, raf.CurrentPosition)
	raf.WriteBytes(Script, 0, Script.Length, raf.CurrentPosition)
	Dim position As Int = raf.CurrentPosition
	raf.WriteInt(position - stub - 4, stub)
	raf.CurrentPosition = position
End Sub



Private Sub CreateTempFile As RandomAccessFile
	Dim tempFile As String = "bltemp"
	File.Delete(File.DirTemp, tempFile)
	Dim temp As RandomAccessFile
	temp.Initialize2(File.DirTemp, tempFile, False, True)
	Return temp
End Sub

Private Sub WriteTempToMain(temp As RandomAccessFile, raf As RandomAccessFile)
	Dim tempData(temp.CurrentPosition) As Byte
	temp.CurrentPosition = 0
	temp.ReadBytes(tempData, 0, tempData.Length, temp.CurrentPosition)
	temp.Close
	raf.WriteBytes(tempData, 0, tempData.Length, raf.CurrentPosition)
End Sub

Private Sub WriteAllLayout(raf As RandomAccessFile, variants As List, Data As Map)
	Dim cache As Map
	cache.Initialize
	Dim temp As RandomAccessFile = CreateTempFile
	temp.WriteInt(variants.Size, temp.CurrentPosition)
	For Each v As Map In variants
		WriteVariant(temp, v)
	Next
	WriteMap(temp, Data, cache)
	WriteString(temp, "")
	temp.WriteByte(ENDOFMAP, temp.CurrentPosition)
	WriteStringsCache(raf, cache)
	WriteTempToMain(temp, raf)
	raf.WriteInt(0, raf.CurrentPosition)
End Sub

Private Sub WriteVariant(temp As RandomAccessFile, v As Map)
	temp.WriteFloat(v.Get("Scale"), temp.CurrentPosition)
	temp.WriteInt(v.Get("Width"), temp.CurrentPosition)
	temp.WriteInt(v.Get("Height"), temp.CurrentPosition)
End Sub

Private Sub ReadLayoutHeader(raf As RandomAccessFile) As Map
	Dim data As Map
	data.Initialize
	Dim version As Int = raf.ReadInt(raf.CurrentPosition)
	data.Put("Version", version)
	If version < 3 Then
		Return data
	End If
	raf.CurrentPosition = raf.CurrentPosition + 4
	Dim gridSize As Int = 10
	If version >= 4 Then gridSize = raf.ReadInt(raf.CurrentPosition)
	data.Put("GridSize", gridSize)
	Dim cache() As String
	cache = LoadStringsCache(raf)
	Dim numberOfControls As Int = raf.ReadInt(raf.CurrentPosition)
	Dim controls As List
	controls.Initialize
	For i = 0 To numberOfControls - 1
		controls.Add(CreateMap("Name": ReadCachedString(raf, cache), _
			"JavaType": ReadCachedString(raf, cache), _
			"DesignerType": ReadCachedString(raf, cache)))
	Next
	data.Put("ControlsHeaders", controls)
	Dim numberOfFiles As Int = raf.ReadInt(raf.CurrentPosition)
	Dim files As List
	files.Initialize
	For i = 0 To numberOfFiles - 1
		files.Add(ReadString(raf))
	Next
	data.Put("Files", files)
	data.Put("DesignerScript", ReadScripts(raf))
	Return data
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

Private Sub WriteScripts (scripts As List, variants As List) As Byte()
	Dim b(100000) As Byte
	Dim temp As RandomAccessFile
	temp.Initialize3(b, True)
	WriteBinaryString(temp, scripts.Get(0))
	scripts.RemoveAt(0)
	temp.WriteInt(variants.Size, temp.CurrentPosition)
	For Each v As Map In variants
		WriteVariant(temp, v)
		WriteBinaryString(temp, scripts.Get(0))
		scripts.RemoveAt(0)
	Next
	Dim b(temp.CurrentPosition) As Byte
	temp.ReadBytes(b, 0, b.Length, 0)
	Dim cs As CompressedStreams
	Return cs.CompressBytes(b, "gzip")
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




Private Sub ReadVariantFromStream(raf As RandomAccessFile) As Map
	Dim var As Map = CreateMap("Scale": raf.ReadFloat(raf.CurrentPosition), _
		"Width": raf.ReadInt(raf.CurrentPosition), _
		"Height": raf.ReadInt(raf.CurrentPosition))
	Return var
End Sub

Private Sub LoadStringsCache(raf As RandomAccessFile) As String()
	Dim cache(raf.ReadInt(raf.CurrentPosition)) As String
	For i = 0 To cache.Length - 1
		cache(i) = ReadString(raf)
	Next
	Return cache
End Sub 

Private Sub WriteStringsCache(raf As RandomAccessFile, Cache As Map)
	raf.WriteInt(Cache.Size, raf.CurrentPosition)
	For Each s As String In Cache.Keys
		WriteString(raf, s)
	Next
End Sub

Private Sub WriteCachedString(raf As RandomAccessFile, Cache As Map, s As String)
	If Cache.IsInitialized = False Then
		WriteString(raf, s)
	Else
		If Cache.ContainsKey(s) Then
			raf.WriteInt(Cache.Get(s), raf.CurrentPosition)
		Else
			raf.WriteInt(Cache.Size, raf.CurrentPosition)
			Cache.Put(s, Cache.Size)
		End If
	End If
End Sub

Private Sub ReadCachedString(raf As RandomAccessFile, cache() As String) As String
	If cache.Length = 0 Then Return ReadString(raf)
	Return cache(raf.ReadInt(raf.CurrentPosition))
End Sub

Private Sub WriteString(raf As RandomAccessFile, s As String)
	Dim data() As Byte = s.GetBytes("UTF8")
	raf.WriteInt(data.Length, raf.CurrentPosition)
	raf.WriteBytes(data, 0, data.Length, raf.CurrentPosition)
End Sub

Private Sub ReadString(raf As RandomAccessFile) As String
	Dim len As Int = raf.ReadInt(raf.CurrentPosition)
	Dim data(len) As Byte
	raf.ReadBytes(data, 0, data.Length, raf.CurrentPosition)
	Return BytesToString(data, 0, data.Length, "UTF8")
End Sub
