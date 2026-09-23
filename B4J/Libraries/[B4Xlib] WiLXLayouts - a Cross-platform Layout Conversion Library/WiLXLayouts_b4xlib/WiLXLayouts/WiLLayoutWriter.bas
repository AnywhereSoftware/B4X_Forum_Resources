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
	Private xui As XUI
End Sub

Public Sub Initialize (ToBIL As Boolean)
	byteConv.LittleEndian = True
	mToBIL = ToBIL
End Sub

Public Sub ConvertJsonToBxl(js As String, dir As String, fname As String)
	Dim jp As JSONParser
	jp.Initialize(js)
	Dim json As Map = jp.NextObject
	ConvertJsonToBxlInMemory(json, dir, fname)
End Sub

Public Sub ConvertJsonToBxlInMemory(json As Map, dir As String, fname As String)
	Dim writer As RandomAccessFile
	Dim parentDir As String = File.GetFileParent(dir)
	Dim childDir As String = File.GetName(dir)
	If Not(File.Exists(parentDir, childDir)) Then 
		Dim fpath As String = GetCanonicalPath(parentDir, childDir)
		LogColor("ERROR: Target folder not found '" & fpath & "'", xui.Color_Blue)
		ExitApplication
	End If

	writer.Initialize2(dir, fname, False, True)
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
'						Log(mval.Get("Value"))
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

Private Sub WriteString(raf As RandomAccessFile, s As String)
	Dim data() As Byte = s.GetBytes("UTF8")
	raf.WriteInt(data.Length, raf.CurrentPosition)
	raf.WriteBytes(data, 0, data.Length, raf.CurrentPosition)
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
