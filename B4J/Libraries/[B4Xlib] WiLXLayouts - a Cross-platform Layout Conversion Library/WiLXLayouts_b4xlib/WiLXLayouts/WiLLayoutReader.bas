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
	Private xui As XUI
End Sub

Public Sub Initialize
	byteConv.LittleEndian = True
	mToBIL = False
End Sub

Public Sub ConvertBxlToMap(Dir As String, FileName As String) As Map
	If Not(File.Exists(Dir, FileName)) Then 
		Dim fpath As String = GetCanonicalPath(Dir, FileName)
		LogColor("ERROR: File not found '" & fpath & "'", xui.Color_Blue)
		ExitApplication
	End If

	Dim design As Map
	design = ConvertBxlToMapInMemory(Dir, FileName)
	Return design
End Sub

Public Sub ConvertBxlToMapInMemory(Dir As String, FileName As String) As Map
	Dim reader As RandomAccessFile
'	Log(Dir & TAB & FileName)
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

Private Sub ReadCachedString(raf As RandomAccessFile, cache() As String) As String
	If cache.Length = 0 Then Return ReadString(raf)
	Return cache(raf.ReadInt(raf.CurrentPosition))
End Sub

Private Sub ReadString(raf As RandomAccessFile) As String
	Dim len As Int = raf.ReadInt(raf.CurrentPosition)
	Dim data(len) As Byte
	raf.ReadBytes(data, 0, data.Length, raf.CurrentPosition)
	Return BytesToString(data, 0, data.Length, "UTF8")
End Sub

Sub GetCanonicalPath(Dir As String, FileName As String) As String
	Dim jo As JavaObject
	Dim fullPath As String = File.Combine(Dir, FileName)
	jo.InitializeNewInstance("java.io.File", Array(fullPath))
	Try
		Dim canonicalPath As String = jo.RunMethod("getCanonicalPath", Null)
		Return canonicalPath
	Catch
		Log("failed: " & LastException.Message)
		Return ""
	End Try
End Sub
