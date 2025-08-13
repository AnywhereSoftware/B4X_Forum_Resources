B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.5
@EndOfDesignText@
'version 1.00
'Class module
Sub Class_Globals
	Private const T_UINT_1 = 1, T_UINT_2 = 2, T_UINT_4 = 3, T_NINT_1 = 4, T_NINT_2 = 5, _
		T_INT_4 = 6, T_FLOAT_4 = 7, T_STRING = 8, T_LONG_BYTES = 9, T_SHORT_BYTES = 0x40, T_SMALL_UINT = 0x80 As Int
	Private const MARK_BEGIN = 0x7E, MARK_END = 0x7F As Byte
	Private raf As RandomAccessFile
	Private smallbuffer(4) As Byte
	Private out As OutputStream
End Sub

Public Sub Initialize
	
End Sub

'Converts an array of objects to an array of bytes.
'Supported types: numbers, strings and arrays of bytes
'Notes: Booleans will be converted to 0 or 1.
'Longs are treated as unsigned numbers.
Public Sub ConvertArrayToBytes (Objects() As Object) As Byte()
	raf.Initialize3(smallbuffer, True)
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	WriteByte(MARK_BEGIN)
	WriteByte(Objects.Length)
	For i = 0 To Objects.Length - 1
		Dim o As Object = Objects(i)
		'convert to unsigned byte
		If o Is Byte Then 
			o = Bit.And(0xFF, o)
		Else if o Is Boolean Then
			Dim bool1 As Boolean = o
			If bool1 Then o = 1 Else o = 0
		End If
		If o Is Double Or o Is Float Then
			raf.WriteFloat(o, 0)
			WriteByte(T_FLOAT_4)
			WriteRaf(4)
		Else if o Is Long Then
			WriteByte (T_UINT_4)
			Dim llng As Long = o
			raf.WriteInt(llng, 0)
			WriteRaf(4)
		Else If o Is Int Or o Is Short Or o Is Byte Then
			Dim num As Int = o
			If Bit.And(T_SMALL_UINT - 1, num) = num Then
				WriteByte (Bit.Or(T_SMALL_UINT, num))
			Else If Bit.And(num, 0xFF) = num Then
				WriteByte (T_UINT_1)
				WriteByte (num)
			Else If Bit.And(num, 0xFFFF) = num Then
				WriteByte (T_UINT_2)
				raf.WriteShort(num, 0)
				WriteRaf(2)
			Else If Bit.And(num, 0xFFFFFF00) = 0xFFFFFF00 Then
				WriteByte(T_NINT_1)
				WriteByte(num)
			Else If Bit.And(num, 0xFFFF0000) = 0xFFFF0000 Then
				WriteByte(T_NINT_2)
				raf.WriteShort(num, 0)
				WriteRaf(2)
			Else
				WriteByte(T_INT_4)
				raf.WriteInt(num, 0)
				WriteRaf(4)
			End If
		Else if o Is String Then
			WriteByte(T_STRING)
			Dim s As String = o
			Dim b() As Byte = s.GetBytes("UTF8")
			out.WriteBytes(b, 0, b.Length)
			WriteByte(0)
		Else if (IsDevTool("B4i") And GetType(o) = "B4IArray") Or GetType(o) = "[B" Then
			Dim b() As Byte = o
			If b.Length < T_SHORT_BYTES Then
				WriteByte(Bit.Or(T_SHORT_BYTES, b.Length))
			Else
				WriteByte(T_LONG_BYTES)
				raf.WriteShort(b.Length, 0)
				WriteRaf(2)
			End If
			out.WriteBytes(b, 0, b.Length)
		Else
			Log($"Invalid value: ${o}"$)
		End If
	Next
	WriteByte(MARK_END)
	Return out.ToBytesArray
End Sub

Private Sub WriteByte(b As Byte)
	out.WriteBytes(Array As Byte(b), 0, 1)
End Sub

Private Sub WriteRaf (Length As Int)
	out.WriteBytes(smallbuffer, 0, Length)
End Sub

'Converts previous serialized bytes to an array of objects.
'Returns an empty array of the input is invalid. Make sure to check the array length.
Public Sub ConvertBytesToArray (Bytes() As Byte) As Object()
	If Bytes.Length = 0 Or Bytes(0) <> MARK_BEGIN Or Bytes(Bytes.Length - 1) <> MARK_END Then
		Log("Invalid input!")
		Return Array()
	End If
	raf.Initialize3(Bytes, True)
	raf.CurrentPosition = 1
	Dim length As Int = raf.ReadUnsignedByte(raf.CurrentPosition)
	Dim result(length) As Object
	For i = 0 To length - 1
		Dim recordType As Int = raf.ReadUnsignedByte(raf.CurrentPosition)
		Dim o As Object
		Select recordType
			Case T_UINT_1
				o = raf.ReadUnsignedByte(raf.CurrentPosition)
			Case T_UINT_2
				o = Bit.And(0xFFFF, raf.ReadShort(raf.CurrentPosition))
			Case T_UINT_4
				Dim lng As Long = raf.ReadInt(raf.CurrentPosition)
				'convert the signed int to unsigned long
				If lng < 0 Then lng = lng + 4294967296
				o = lng
			Case T_INT_4
				o = raf.ReadInt(raf.CurrentPosition)
			Case T_NINT_1
				o = Bit.Or(0xFFFFFF00, raf.ReadSignedByte(raf.CurrentPosition))
			Case T_NINT_2
				o = Bit.Or(0xFFFF0000, raf.ReadShort(raf.CurrentPosition))
			Case T_FLOAT_4
				o = raf.ReadFloat(raf.CurrentPosition)
			Case T_STRING
				For b = raf.CurrentPosition To Bytes.Length - 1
					If Bytes(b) = 0 Then Exit
				Next
				o = BytesToString(Bytes, raf.CurrentPosition, b - raf.CurrentPosition, "utf8")
				raf.CurrentPosition = b + 1
			Case T_LONG_BYTES
				Dim bb(Bit.And(0xFFFF, raf.ReadShort(raf.CurrentPosition))) As Byte
				raf.ReadBytes(bb, 0, bb.Length, raf.CurrentPosition)
				o = bb
			Case Else
				If Bit.And(recordType, T_SMALL_UINT) = T_SMALL_UINT Then
					o = Bit.And(recordType, T_SMALL_UINT - 1)
				Else If Bit.And(recordType, T_SHORT_BYTES) = T_SHORT_BYTES Then
					Dim bb (Bit.And(recordType, T_SHORT_BYTES - 1)) As Byte
					raf.ReadBytes(bb, 0, bb.Length, raf.CurrentPosition)
					o = bb
				Else
					Log("Invalid field: " & recordType)
				End If
		End Select
		result(i) = o
	Next
	Return result
End Sub


