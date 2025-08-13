B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Extracted from BalConverter App version 2.30
Sub Class_Globals
	Public Const CINT = 1, CSTRING = 2, CMAP = 3, ENDOFMAP = 4, BOOL = 5, CCOLOR = 6, _
		CFLOAT = 7, CACHED_STRING = 9, RECT32 = 11, CNULL = 12 As Byte
	Private byteConv As ByteConverter
	Public mToBIL As Boolean
End Sub


Public Sub Initialize
	byteConv.LittleEndian = True
	mToBIL = False
End Sub

Public Sub ConvertBalToMap(Dir As String, FileName As String) As Map
	Dim design As Map
	#if B4J
		design = ConvertBalToMapInMemory(Dir, FileName)
	#Else if B4A
		design.Initialize
	#End If
	Return design
End Sub

Public Sub ConvertBalToMapInMemory(Dir As String, FileName As String) As Map
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
