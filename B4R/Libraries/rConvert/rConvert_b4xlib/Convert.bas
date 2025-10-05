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
' Date:         2025-09-30
' Version:		1.1.0
' License:      MIT
#End Region

#Region Function Index (one-liners)
' -- Bytes --
' ByteToBool(bytes)            		: First byte "1" > True, else False.
' ByteToInt(bytes)             		: ASCII digit byte "0"-"9" > integer 0–9.
' BytesToHex(bytes)            		: Byte array > hex string.
' OneByteToHex(byte)				: Convert single byte to HEX string.
' TwoBytesToHex(b1,b2)				: Convert 2 bytes to HEX string.
' ReverseBytes(b)					: Reverse byte order in array.

' -- Bool --
' BoolToString(state)          		: True > "1", False > "0".
' BoolToOnOff(state)           		: True > "ON", False > "OFF".
' OnOffToBool(value)           		: "ON"/"On"/"on"/"oN" > True.
' IntToBool(value)			   		: Convert int to bool.

' -- UInt --
' UIntToBytes(value)           		: 16-bit unsigned > little-endian bytes.
' BytesToUInt(b)               		: Little-endian 2 bytes > unsigned 16-bit.

' -- ULong --
' ULongToBytes(value)          		: 32-bit unsigned > little-endian bytes.
' BytesToULong(b)              		: Little-endian 4 bytes > unsigned 32-bit.

' -- Float --
' FloatToBytes(value)          		: 32-bit float > little-endian bytes.
' BytesToFloat(b)              		: Little-endian 4 bytes > 32-bit float.

' -- Bin --
' ByteToBin(b)						: Convert 0–255 byte > "xxxxxxxx" binary string.
' NibbleToBin(nibble)				: Convert 0–15 nibble > "xxxx" binary string.

' -- BCD --
' ByteToBCD(value)					: Decimal 0–99 > single-byte BCD.
' ByteToBCDBin(value)				: Decimal 0–99 > BCD > binary string.
' BCDToByte(b)						: Single-byte BCD > decimal 0–99.
' UIntToBCDArray(value)				: UInt 0–9999 > 2-byte BCD array.
' BCDArrayToUInt(b)					: 2-byte BCD array > integer 0–9999.

' -- Checksum --
' XORChecksum(b)					: XOR of all bytes.

' -- Endianness --
' SwapUInt16(value)					: Swap 2-byte unsigned integer.
' SwapUInt32(value)					: Swap 4-byte unsigned integer.
' SwapUInt16ToBytes(value)			: UInt16 > reversed 2-byte array.
' BytesToUInt16Swapped(b)			: Reversed 2-byte array > UInt16.
' SwapUInt32ToBytes(value)			: UInt32 > reversed 4-byte array.
' BytesToUInt32Swapped(b)			: Reversed 4-byte array > UInt32.

' -- String --
' StringTrim(s)                		: Trim spaces/tabs from both ends.
' ToUpperCase(s)               		: ASCII lowercase > uppercase.
' ToLowerCase(s)               		: ASCII uppercase > lowercase.
' EqualsIgnoreCase(s1,s2)      		: Compare ignoring ASCII case.
' ReplaceString(orig,search,repl)	: Replace all occurrences in byte array.
' GetSplitCount(buffer)				: Get number of items from CSV string.
' AsciiBufferToInt(buffer)			: Convert buffer containing ASCII digits to an integer.
#End Region

#Region Numeric Ranges Reference
'| Type       | Size      | Min (AVR / Other) | Max (AVR / Other) | Min (ESP32)             | Max (ESP32)            | Notes                                                            |
'| ---------- | --------- | ----------------- | ----------------- | ----------------------- | ---------------------- | ---------------------------------------------------------------- |
'| Byte       | 8-Bit     | 0                 | 255               | 0                       | 255                    | Unsigned                                                         |
'| Int16      | 16-Bit    | -32,768           | 32,767            | -32,768                 | 32,767                 | Signed 16-Bit                                                    |
'| UInt16     | 16-Bit    | 0                 | 65,535            | 0                       | 65,535                 | Unsigned 16-Bit stored in ULong                                  |
'| ULong      | 32-Bit    | 0                 | 4,294,967,295     | 0                       | 4,294,967,295          | Unsigned 32-Bit                                                  |
'| Float      | 32-Bit    | -3.4028235E38     | 3.4028235E38      | -3.4028235E38           | 3.4028235E38           | Single-precision                                                 |
'| Double     | AVR/Other | -3.4028235E38     | 3.4028235E38      | -1.7976931348623157E308 | 1.7976931348623157E308 | On AVR/UNO/MEGA: same As Float (32-Bit); on ESP32: 64-Bit double |
#End Region

Sub Process_Globals

	' Constants for numeric ranges
	' Based on Arduino / C standard integer sizes

    ' -------------------------
    ' Integer types
    ' -------------------------
    ' Byte (unsigned 8-bit)
    Public Const BYTE_MIN As Byte = 0
    Public Const BYTE_MAX As Byte = 255

    ' Int (signed 16-bit)
    Public Const INT16_MIN As Int = -32768
    Public Const INT16_MAX As Int = 32767

    ' UInt16 (unsigned 16-bit, stored in ULong in B4R)
    Public Const UINT16_MIN As ULong = 0
    Public Const UINT16_MAX As ULong = 65535

    ' ULong (unsigned 32-bit)
    Public Const UINT32_MIN As ULong = 0
    Public Const UINT32_MAX As ULong = 4294967295

    ' -------------------------
    ' Floating point types
    ' -------------------------
    ' Float (4-byte single precision)
    Public Const FLOAT_MIN As Float = -3.4028235E38
    Public Const FLOAT_MAX As Float = 3.4028235E38

    ' Double (platform-dependent)
    #If ESP32
        ' ESP32: 64-bit double
        Public Const DOUBLE_MIN As Double = -1.7976931348623157E308
        Public Const DOUBLE_MAX As Double = 1.7976931348623157E308
    #Else
        ' AVR / smaller boards: double same as float (32-bit)
        Public Const DOUBLE_MIN As Double = -3.4028235E38
        Public Const DOUBLE_MAX As Double = 3.4028235E38
    #End If
	
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
	If b == Null Or b.Length < 2 Then Return 0
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

#Region Bin
'----------------------------------------------
' ByteToBin
' Convert any byte (0–255) to an 8-bit binary string.
'----------------------------------------------
Public Sub ByteToBin(b As Byte) As String
	Dim bits(8) As Byte
	For i = 0 To 7
		bits(i) = 48 + Bit.And(Bit.ShiftRight(b, 7 - i), 1)  ' ASCII '0' = 48
	Next
	Return bc.StringFromBytes(bits)
End Sub

'----------------------------------------------
' NibbleToBin
' Convert a 4-bit nibble (0–15) to a 4-character binary string.
'----------------------------------------------
Public Sub NibbleToBin(nibble As Byte) As String
	If nibble > 15 Then Return "Invalid"
    
	Dim bits(4) As Byte
	For i = 0 To 3
		bits(i) = 48 + Bit.And(Bit.ShiftRight(nibble, 3 - i), 1)  ' ASCII '0' = 48
	Next
	Return bc.StringFromBytes(bits)
End Sub
#End Region

#Region BCD
' BCD, or Binary-Coded Decimal, is a number system where each decimal digit (0-9) is represented by a four-bit binary code. 
' Unlike standard binary, BCD uses codes 0000 to 1001, leaving codes 1010 to 1111 unused for each digit.
' Digit-by-digit encoding: Instead of converting an entire decimal number into a single binary value, BCD converts each decimal digit individually into its four-Bit binary equivalent. 
' Example: The decimal number 15 is represented As 0001 (For 1) And 0101 (For 5) in BCD, resulting in 00010101. 
' No rounding errors:
' BCD ensures precise decimal encoding without any rounding errors, which is crucial in applications like financial calculations

'----------------------------------------------
' ByteToBCD
' Convert 0–99 decimal to single-byte BCD.
' Returns 0xFF if out of range.
'----------------------------------------------
Public Sub ByteToBCD(value As Byte) As Byte
    If value > 99 Then Return 0xFF
    Return Bit.Or(Bit.ShiftLeft(value / 10, 4), value Mod 10)
End Sub

'----------------------------------------------
' ByteToBCDBin
' Convert decimal byte (0-99) to BCD, then return 8-bit binary string
' Example: 15 -> 0x15 -> "00010101"
'----------------------------------------------
Public Sub ByteToBCDBin(value As Byte) As String
	Dim bcd As Byte = ByteToBCD(value)
	If bcd = 0xFF Then Return "Invalid"

	Dim bits(8) As Byte
	' Loop over the bits and extract
	For i = 0 To 7
		' 48 + Bit converts 0/1 To ASCII '0'/'1'
		bits(i) = 48 + Bit.And(Bit.ShiftRight(bcd, 7 - i), 1)  ' ASCII '0' = 48
	Next
	Return bc.StringFromBytes(bits)
End Sub

'----------------------------------------------
' BCDToByte
' Convert single-byte BCD to decimal 0–99
'----------------------------------------------
Public Sub BCDToByte(b As Byte) As Byte
    Return Bit.ShiftRight(b, 4) * 10 + Bit.And(b, 0x0F)
End Sub

'----------------------------------------------
' UIntToBCDArray
' Convert integer 0–9999 to BCD byte array (high-to-low)
' Example: 1985 -> [0x19, 0x85]
' Returns Null if value > 9999
'----------------------------------------------
Public Sub UIntToBCDArray(value As ULong) As Byte()
    If value > 9999 Then Return Null
    Dim b(2) As Byte   ' 2 bytes = 4 digits
    b(0) = ByteToBCD(value / 100)      ' high two digits
    b(1) = ByteToBCD(value Mod 100)    ' low two digits
    Return b
End Sub

'----------------------------------------------
' BCDArrayToUInt
' Convert 2-byte BCD array to integer
'----------------------------------------------
Public Sub BCDArrayToUInt(b() As Byte) As ULong
    If b.Length < 2 Then Return 0
    Return BCDToByte(b(0)) * 100 + BCDToByte(b(1))
End Sub
#End Region

#Region Checksum
'----------------------------------------------
' XORChecksum: returns XOR of all bytes
'----------------------------------------------
Public Sub XORChecksum(b() As Byte) As Byte
	Dim c As Byte = 0
	For i = 0 To b.Length - 1
		c = Bit.Xor(c, b(i))
	Next
	Return c
End Sub
#End Region

#Region Endianness
' SwapUIntNN moves the bytes around.
' Examples:
' Input 23 (0x0017) -> Swap = 5888 (0x1700)
' Input = 0x1234 (4660 decimal) -> Swap = 0x3412 (13330 decimal)

' Swap logic explained for 16-bit value 23 on Arduino UNO.
' DEC 23 is swapped DEC 5888.
' Step 1 – 16-Bit representation
' On AVR, an UInt16 value of 23 is stored As:
' 0x0017   (hex)   ->   [00000000 00010111] (binary)
' LSB = 0x17 (23 decimal), MSB = 0x00
' Step 2 – Swap the bytes
' Swapping LSB/MSB gives:
' 0x1700   (hex)   ->   [00010111 00000000] (binary)
' Step 3 – Decimal interpretation
' 0x1700 in decimal = 5888

'----------------------------------------------
' SwapUInt16: swap byte order of 16-bit unsigned integer
' Byte order b(0)b(1) -> b(1)b(0)
'----------------------------------------------
Public Sub SwapUInt16(value As ULong) As ULong
	Return Bit.Or(Bit.ShiftLeft(Bit.And(value, 0xFF), 8), Bit.And(Bit.ShiftRight(value, 8), 0xFF))
End Sub

'----------------------------------------------
' SwapUInt32: swap byte order of 32-bit unsigned integer
' Byte order b(0)b(1)b(2)b(3) -> b(3)b(2)b(1)b(0)
'----------------------------------------------
Public Sub SwapUInt32(value As ULong) As ULong
	Dim b(4) As Byte
	b(0) = Bit.And(value, 0xFF)
	b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)
	b(2) = Bit.And(Bit.ShiftRight(value, 16), 0xFF)
	b(3) = Bit.And(Bit.ShiftRight(value, 24), 0xFF)
	Return Bit.Or(Bit.Or(Bit.ShiftLeft(b(0), 24), Bit.ShiftLeft(b(1), 16)), Bit.Or(Bit.ShiftLeft(b(2), 8), b(3)))
End Sub

'----------------------------------------------
' SwapUInt16ToBytes: convert UInt16 to reversed byte array
' Example: value=0x0017 -> [0x17, 0x00]
'----------------------------------------------
Public Sub SwapUInt16ToBytes(value As ULong) As Byte()
	Dim b(2) As Byte
	b(0) = Bit.And(value, 0xFF)                      ' low byte
	b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)   ' high byte
	Return b
End Sub

'----------------------------------------------
' BytesToUInt16Swapped: convert reversed byte array back to UInt16
' Example: [0x17, 0x00] -> 0x0017 = 23
'----------------------------------------------
Public Sub BytesToUInt16Swapped(b() As Byte) As ULong
	If b.Length < 2 Then Return 0
	Return Bit.Or(Bit.And(b(0), 0xFF), Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
End Sub


'----------------------------------------------
' SwapUInt32ToBytes: convert UInt32 to reversed byte array
' Example: value=0x12345678 -> [0x78, 0x56, 0x34, 0x12]
'----------------------------------------------
Public Sub SwapUInt32ToBytes(value As ULong) As Byte()
	Dim b(4) As Byte
	b(0) = Bit.And(value, 0xFF)
	b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)
	b(2) = Bit.And(Bit.ShiftRight(value, 16), 0xFF)
	b(3) = Bit.And(Bit.ShiftRight(value, 24), 0xFF)
	Return b
End Sub

'----------------------------------------------
' BytesToUInt32Swapped: convert reversed byte array back to UInt32
' Example: [0x78, 0x56, 0x34, 0x12] -> 0x12345678
'----------------------------------------------
Public Sub BytesToUInt32Swapped(b() As Byte) As ULong
	If b.Length < 4 Then Return 0
	Dim result As ULong = 0
	result = Bit.Or(result, Bit.And(b(0), 0xFF))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(2), 0xFF), 16))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(3), 0xFF), 24))
	Return result
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

'----------------------------------------------
' AsciiBufferToInt
' Convert buffer containing ASCII digits to an integer
' Example: [57,48] -> 90, [49,56,48] -> 180
'----------------------------------------------
Public Sub AsciiBufferToInt(Buffer() As Byte) As Int
	Dim value As Int = 0
	For i = 0 To Buffer.Length - 1
		Dim digit As Int = Buffer(i) - 48   ' '0' = 48
		If digit < 0 Or digit > 9 Then
			Return -1   ' invalid input
		End If
		value = value * 10 + digit
	Next
	Return value
End Sub
#End Region
