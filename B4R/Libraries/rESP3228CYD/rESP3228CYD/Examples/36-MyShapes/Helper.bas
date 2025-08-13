B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'Helper
'Code module with various helper methods to be included in programs.
'Depends on library rRandomAccessFile for the ByteConverter.
'Declare all methods as public.
'Date:		20250318
'Author:	Robert W.B. Linn

Sub Process_Globals
	Private bc As ByteConverter
End Sub

#Region HEXFROM
'Get HEX code for a single byte.
'b - Single byte
'Returns HEX code as string
Public Sub HexFromByte(b As Byte) As String
	Return bc.HexFromBytes(Array As Byte(b))
End Sub

Public Sub HexFromInt(i As Int) As String
	Dim b() As Byte = bc.IntsToBytes(Array As Int(i))
	'Log("[HexFromInt]i=", i, ",bytes=",b(0),b(1))
	Return bc.HexFromBytes(b)
End Sub

'Get the HEX value from an ULong.
'Depends on: ByteConverter
Public Sub HexFromULong(value As ULong) As String
	Return bc.HexFromBytes(bc.ULongsToBytes(Array As ULong(value)))
End Sub
#End Region

#Region BYTESFROM
'Get 4 bytes from long.
'Do not use the byteconverter as it converts per default to little endian.
'value - Long value to convert
'littleendian - Flag to set little endian, set to false for big endian
'Returns 4 bytes
Public Sub BytesFromLong(value As Long, littleendian As Boolean) As Byte()
	Dim raf As RandomAccessFile
	'Set the return byte array size = 4
	Dim b(4) As Byte
	raf.Initialize(b, littleendian)
	raf.WriteULong32(value, 0)
	Return b
End Sub

'Get 2 bytes from integer.
'value - Integer value to convert
'littleendian - Flag to set little endian, set to false for big endian
'Returns 2 bytes as uint
Public Sub BytesFromInt(value As Int, littleendian As Boolean) As Byte()
	Dim raf As RandomAccessFile
	'Set the return byte array size = 2
	Dim b(2) As Byte
	raf.Initialize(b, littleendian)
	raf.WriteUInt16(value, 0)
	Return b
End Sub
#End Region

#Region INTFROM
'Get 2 bytes from integer.
'b - Bytes to convert
'Returns int
Public Sub IntFromBytes(b() As Byte) As Int
	Dim ints() As Int = bc.IntsFromBytes(b)
	If ints.Length == 1 Then
		Return ints(0)
	Else
		Return -1
	End If
End Sub
#End Region

#Region DATETIME
'Set timestamp from HHMM to HH:MM with leading 0.
'The conversion is using bytearray setting.
'Example<code>
'lcd.DrawText(lcd.Width, 10, SetTimeStamp(PowerTimeStamp), lcd.TEXT_ALIGN_MIDDLE_RIGHT, 2, lcd.COLOR_BLACK, lcd.BackgroundColor)
'</code>
Public Sub SetTimeStamp(timestamp As UInt) As String
	Dim result(5) As Byte
	Dim resultstr As String = ""
	Dim str As String

	'If there is a timestamp, set result bytearray
	If timestamp > 0 Then
		If timestamp < 1000 Then
			str = JoinStrings(Array As String("0", timestamp))
		Else
			str = timestamp
		End If

		'HHMM > HH:MM
		Dim hh() As Byte = bc.SubString2(str, 0, 3)
		Dim del() As Byte = ":".GetBytes
		Dim mm() As Byte = bc.SubString2(str, 2, 5)

		result(0) = hh(0)
		result(1) = hh(1)
		result(2) = del(0)
		result(3) = mm(0)
		result(4) = mm(1)

		resultstr = bc.StringFromBytes(result)
	End If

	Return resultstr
End Sub
#End Region
