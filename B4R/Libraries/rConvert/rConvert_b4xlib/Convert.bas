B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' File:         Conversions.bas
' Brief:        Code module with various conversions
' Notes:		On ESP32, ESP8266, Arduino AVR, B4R ByteConverter uses the MCU’s native endian.
'				Most ARM/AVR microcontrollers are little-endian, so bc.DoublesToBytes produces little-endian bytes.
'				Use the method ReverseBytes to change endian.
' DependsOn:    rRandomAccessFile
' Author:       Robert W.B. Linn
' Date:         2025-08-16
' License:      MIT
'
' Function Index (one-liners)
' -- Bytes --
' ByteToBool(bytes)            		: First byte "1" > True, else False.
' ByteToInt(bytes)             		: ASCII digit byte "0"-"9" > integer 0–9.
' BytesToHex(bytes)            		: Byte array > hex string.
' OneByteToHex(byte)				: Convert single byte to HEX string.
' TwoBytesToHex(b1,b2)				: Convert 2 bytes to HEX string.
'
' -- Bool --
' BoolToString(state)          		: True > "1", False > "0".
' BoolToOnOff(state)           		: True > "ON", False > "OFF".
' OnOffToBool(value)           		: "ON"/"On"/"on"/"oN" > True.
' IntToBool(value)			   		: Convert int to bool.
'
' -- UInt --
' UIntToBytes(value)           		: 16-bit unsigned > little-endian bytes.
' BytesToUInt(b)               		: Little-endian 2 bytes > unsigned 16-bit.
'
' -- ULong --
' ULongToBytes(value)          		: 32-bit unsigned > little-endian bytes.
' BytesToULong(b)              		: Little-endian 4 bytes > unsigned 32-bit.
'
' -- Float --
' FloatToBytes(value)          		: 32-bit float > little-endian bytes.
' BytesToFloat(b)              		: Little-endian 4 bytes > 32-bit float.
'
' -- String --
' StringTrim(s)                		: Trim spaces/tabs from both ends.
' ToUpperCase(s)               		: ASCII lowercase > uppercase.
' ToLowerCase(s)               		: ASCII uppercase > lowercase.
' EqualsIgnoreCase(s1,s2)      		: Compare ignoring ASCII case.
' ReplaceString(orig,search,repl)	: Replace all occurrences in byte array.
' GetSplitCount(buffer)				: Get number of items from CSV string.
#End Region

Private Sub Process_Globals
	' Byte converter instance for conversions between bytes and strings
	Private bc As ByteConverter
End Sub

#Region Bytes
'----------------------------------------------
' ByteToBool
' Converts the first byte of an array to a Boolean value.
' Assumes the byte represents the ASCII character "0" (48) or "1" (49).
' Returns True if byte is "1", otherwise False.
'----------------------------------------------
Public Sub ByteToBool(bytes() As Byte) As Boolean
	Return IIf(bytes(0) == 49, True, False)
End Sub

'----------------------------------------------
' ByteToInt
' Converts the first byte of an array containing an ASCII digit ('0'–'9') to an integer value (0–9).
'----------------------------------------------
Public Sub ByteToInt(bytes() As Byte) As Int
	Return bytes(0) - Asc("0")
End Sub

'----------------------------------------------
' BytesToHex
' Converts a byte array to its hexadecimal string representation.
' Example: [0x0A, 0x1F] > "0A1F"
'----------------------------------------------
Public Sub BytesToHex(bytes() As Byte) As String
	Return bc.HexFromBytes(bytes)
End Sub

'----------------------------------------------
' OneByteToHex
' Convert single byte to HEX string.
'----------------------------------------------
Public Sub OneByteToHex(b As Byte) As String
	Return bc.HexFromBytes(Array As Byte(b))
End Sub

'----------------------------------------------
' TwoBytesToHex
' Convert 2 bytes to HEX string.
'----------------------------------------------
Public Sub TwoBytesToHex(b1 As Byte, b2 As Byte) As String
	Return bc.HexFromBytes(Array As Byte(b1, b2))
End Sub

'----------------------------------------------
' ReverseBytes
' Reverse the bytes of a byte array. This can be used to convert little endian to big endian.
' Example: [0x0A, 0x1F] > "0A1F"
'----------------------------------------------
Public Sub ReverseBytes(b() As Byte) As Byte()
	Dim n As Int = b.Length
	Dim r(n) As Byte
	For i = 0 To n - 1
		r(i) = b(n - 1 - i)
	Next
	Return r
End Sub
#End region

#Region Bool
'----------------------------------------------
' BoolToString
' Converts a Boolean value to string "1" (True) or "0" (False).
'----------------------------------------------
Public Sub BoolToString(state As Boolean) As String
	If state Then
		Return "1"
	Else
		Return "0"
	End If
End Sub

'----------------------------------------------
' BoolToOnOff
' Converts a Boolean value to "ON" (True) or "OFF" (False).
'----------------------------------------------
Public Sub BoolToOnOff(state As Boolean) As String
	If state Then
		Return "ON"
	Else
		Return "OFF"
	End If
End Sub

'----------------------------------------------
' OnOffToBool
' Converts the string "ON" (case-insensitive) to True, otherwise returns False.
' Accepts "ON", "On", "on", "oN" as True.
'----------------------------------------------
Public Sub OnOffToBool(value As String) As Boolean
	If value == "ON" Or value == "On" Or value == "on" Or value == "oN" Then Return True
	Return False
End Sub

'----------------------------------------------
' IntToBool
' Convert int to bool.
'----------------------------------------------
Public Sub IntToBool(value As Int) As Boolean
	Return IIf(value == 0, False, True)
End Sub
#End Region

#Region UInt
'----------------------------------------------
' UIntToBytes
' Converts an unsigned 16-bit integer (ULong, lower 2 bytes used) to a byte array (little-endian).
' b(0) = LSB, b(1) = MSB
'----------------------------------------------
Public Sub UIntToBytes(value As ULong) As Byte()
	Dim b(2) As Byte
	b(0) = Bit.And(value, 0xFF)                     ' Low byte
	b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)  ' High byte
	Return b
End Sub

'----------------------------------------------
' BytesToUInt
' Converts a 2-byte array (little-endian) to an unsigned 16-bit integer (ULong).
'----------------------------------------------
Public Sub BytesToUInt(b() As Byte) As ULong
	If b.Length < 2 Then Return 0
	Return Bit.Or(Bit.And(b(0), 0xFF), Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
End Sub
#End Region

#Region ULong
'----------------------------------------------
' ULongToBytes
' Converts an unsigned 32-bit integer (ULong) to a 4-byte array (little-endian).
'----------------------------------------------
Public Sub ULongToBytes(value As ULong) As Byte()
	Dim b(4) As Byte
	b(0) = Bit.And(value, 0xFF)
	b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)
	b(2) = Bit.And(Bit.ShiftRight(value, 16), 0xFF)
	b(3) = Bit.And(Bit.ShiftRight(value, 24), 0xFF)
	Return b
End Sub

'----------------------------------------------
' BytesToULong
' Converts a 4-byte array (little-endian) to an unsigned 32-bit integer (ULong).
'----------------------------------------------
Public Sub BytesToULong(b() As Byte) As ULong
	If b.Length < 4 Then Return 0
	Dim result As ULong = Bit.And(b(0), 0xFF)
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(2), 0xFF), 16))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(3), 0xFF), 24))
	Return result
End Sub
#End Region

#Region Float
'----------------------------------------------
' FloatToBytes
' Convert Float (4 bytes, IEEE 754) to bytes
'----------------------------------------------
Public Sub FloatToBytes(f As Float) As Byte()
	Dim b() As Byte = bc.DoublesToBytes(Array As Double(f))
	Return b
End Sub

'----------------------------------------------
' BytesToFloat
' Convert bytes to Float (IEEE 754)
'----------------------------------------------
Public Sub BytesToFloat(b() As Byte) As Float
	Dim d() As Double = bc.DoublesFromBytes(b)
	Log("[BytesToFloat] b=", bc.HexFromBytes(b), ", result length=", d.Length)
	If d.Length > 0 Then
		Return d(0)
	Else
		Return -1
	End If
End Sub
#End Region

#Region String
'----------------------------------------------
' StringTrim
' Removes leading and trailing spaces (ASCII 32) and tabs (ASCII 9) from a string.
' Works at the byte-array level to avoid locale issues.
' Returns a new trimmed string.
'----------------------------------------------
Public Sub StringTrim(s As String) As String
	Dim b() As Byte = s.GetBytes
	Dim startIndex As Int = 0
	Dim endIndex As Int = b.Length - 1

	Do While startIndex <= endIndex And (b(startIndex) = 32 Or b(startIndex) = 9)
		startIndex = startIndex + 1
	Loop

	Do While endIndex >= startIndex And (b(endIndex) = 32 Or b(endIndex) = 9)
		endIndex = endIndex - 1
	Loop

	If startIndex > endIndex Then Return ""

	Dim trimmedLength As Int = endIndex - startIndex + 1
	Dim result(trimmedLength) As Byte
	For i = 0 To trimmedLength - 1
		result(i) = b(startIndex + i)
	Next
	Return bc.StringFromBytes(result)
End Sub

'----------------------------------------------
' ToUpperCase
' Converts all lowercase ASCII letters (a–z) in a string to uppercase.
'----------------------------------------------
Public Sub ToUpperCase(s As String) As String
	Dim b() As Byte = s.GetBytes
	For i = 0 To b.Length - 1
		If b(i) >= Asc("a") And b(i) <= Asc("z") Then
			b(i) = b(i) - 32
		End If
	Next
	Return bc.StringFromBytes(b)
End Sub

'----------------------------------------------
' ToLowerCase
' Converts all uppercase ASCII letters (A–Z) in a string to lowercase.
'----------------------------------------------
Public Sub ToLowerCase(s As String) As String
	Dim b() As Byte = s.GetBytes
	For i = 0 To b.Length - 1
		If b(i) >= Asc("A") And b(i) <= Asc("Z") Then
			b(i) = b(i) + 32
		End If
	Next
	Return bc.StringFromBytes(b)
End Sub

'----------------------------------------------
' EqualsIgnoreCase
' Compares two strings for equality ignoring ASCII case.
' Returns True if they match regardless of case.
'----------------------------------------------
Public Sub EqualsIgnoreCase(s1 As String, s2 As String) As Boolean
	Dim b1() As Byte = s1.GetBytes
	Dim b2() As Byte = s2.GetBytes
	If b1.Length <> b2.Length Then Return False

	For i = 0 To b1.Length - 1
		Dim c1 As Byte = b1(i)
		Dim c2 As Byte = b2(i)

		If c1 >= 65 And c1 <= 90 Then c1 = c1 + 32 ' A-Z to a-z
		If c2 >= 65 And c2 <= 90 Then c2 = c2 + 32

		If c1 <> c2 Then Return False
	Next

	Return True
End Sub

'----------------------------------------------
' ReplaceString
' Replaces all occurrences of a search byte sequence with another sequence in a byte array.
' Works at the byte-array level for efficiency.
' Credit: https://www.b4x.com/android/forum/threads/strings-and-bytes.66729/#post-435001
'----------------------------------------------
Public Sub ReplaceString(Original() As Byte, SearchFor() As Byte, ReplaceWith() As Byte) As Byte()
	Dim bc2 As ByteConverter
	Dim c As Int = 0
	Dim i As Int
	If SearchFor.Length <> ReplaceWith.Length Then
		i = bc2.IndexOf(Original, SearchFor)
		Do While i > -1
			c = c + 1
			i = bc2.IndexOf2(Original, SearchFor, i + SearchFor.Length)
		Loop
	End If
	Dim result(Original.Length + c * (ReplaceWith.Length - SearchFor.Length)) As Byte
	Dim prevIndex As Int = 0
	Dim targetIndex As Int = 0
	i = bc2.IndexOf(Original, SearchFor)
	Do While i > -1
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, i - prevIndex)
		targetIndex = targetIndex + i - prevIndex
		bc2.ArrayCopy2(ReplaceWith, 0, result, targetIndex, ReplaceWith.Length)
		targetIndex = targetIndex + ReplaceWith.Length
		prevIndex = i + SearchFor.Length
		i = bc2.IndexOf2(Original, SearchFor, prevIndex)
	Loop
	If prevIndex < Original.Length Then
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, Original.Length - prevIndex)
	End If
	Return result
End Sub

'----------------------------------------------
' GetSplitCount
' Get the number of items from a CSV string.
'----------------------------------------------
Public Sub GetSplitCount(buffer() As Byte) As Int	'ignore
	Dim counter As Int = 0
	For Each item() As Byte In bc.Split(buffer, ",")
		counter = counter + 1
	Next
	Return counter
End Sub
#End Region
