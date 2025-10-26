B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:         Convert.bas
' Brief:        Code module with various conversions
' Notes:		On ESP32, ESP8266, Arduino AVR, B4R ByteConverter uses the MCU’s native endian.
'				Most ARM/AVR microcontrollers are little-endian, so ByteConv.DoublesToBytes produces little-endian bytes.
'				Use the method ReverseBytes to change endian.
' DependsOn:    rRandomAccessFile 1.91 or higher.
' Author:       Robert W.B. Linn
' Date:         See Process_Globals VERSION
' Version:		1.4.0
' License:      MIT
#End Region

#Region Function Index (one-liners)
'-- Bytes --
'ByteToBool(bytes) : First byte "1" > True, Else False.
'ByteToInt(bytes) : ASCII digit byte "0"-"9" > integer 0–9.
'BytesToHex(bytes) : Byte Array > hex string.
'OneByteToHex(byte) : Convert single byte To HEX string.
'TwoBytesToHex(b1,b2) : Convert 2 bytes To HEX string.
'ReverseBytes(b) : Reverse byte order in Array.
'BytesToString(b): Convert bytes to string.
'
'-- Bool --
'BoolToString(state) : True > "1", False > "0".
'BoolToOnOff(state) : True > "ON", False > "OFF".
'OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.
'IntToBool(value) : Convert int To bool.
'
'-- UInt --
'UIntToBytes(value) : 16-Bit unsigned > little-endian bytes.
'BytesToUInt(b) : Little-endian 2 bytes > unsigned 16-Bit.
'UIntToHex(value) : Converts an UInt To HEX string with 2 bytes.
'
'-- ULong --
'ULongToBytes(value) : 32-Bit unsigned > little-endian bytes.
'BytesToULong(b) : Little-endian 4 bytes > unsigned 32-Bit.
'ULongToHex(value) : Converts an ULong To HEX string with 4 bytes.
'
'-- Float --
'FloatToBytes(value) : 32-Bit float > little-endian bytes.
'BytesToFloat(b) : Little-endian 4 bytes > 32-Bit float.
'  
'-- Bin --
'ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.
'BytesToBin(b()) : Converts byte array to a binary string representation.
'NibbleToBin(nibble) : Convert 0–15 nibble > "xxxx" binary string.
'BinToDec(string): Converts a binary string like "11100011" > 227.
'
'-- BCD --
'ByteToBCD(value) : Decimal 0–99 > single-byte BCD.
'ByteToBCDBin(value) : Decimal 0–99 > BCD > binary string.
'BCDToByte(b) : Single-byte BCD > decimal 0–99.
'UIntToBCDArray(value) : UInt 0–9999 > 2-byte BCD Array.
'BCDArrayToUInt(b) : 2-byte BCD Array > integer 0–9999.
'
'-- Checksum --
'XORChecksum(b) : XOR of all bytes.
'
'-- Endianness --
'SwapUInt16(value) : Swap 2-byte unsigned integer.
'SwapUInt32(value) : Swap 4-byte unsigned integer.
'SwapUInt16ToBytes(value) : UInt16 > reversed 2-byte Array.
'BytesToUInt16Swapped(b) : Reversed 2-byte Array > UInt16.
'SwapUInt32ToBytes(value) : UInt32 > reversed 4-byte Array.
'BytesToUInt32Swapped(b) : Reversed 4-byte Array > UInt32.
'
'-- String --
'StringTrim(s) : Trim spaces/tabs from both ends.
'ToUpperCase(s) : ASCII lowercase > uppercase.
'ToLowerCase(s) : ASCII uppercase > lowercase.
'EqualsIgnoreCase(s1,s2) : Compare ignoring ASCII Case.
'ReplaceString(orig,search,repl) : Replace all occurrences in byte Array.
'AsciiBufferToInt(buffer) : Convert buffer containing ASCII digits To an integer.
'
'-- Modbus CRC-16 --
'ModbusCRC16(frame) : Calculate CRC16 (Modbus RTU) And Return As 2-byte Array in little-endian order: [low byte, high byte].
'ModbusCRC16UInt(frame) : Calculate CRC16 (Modbus RTU) And Return As numeric 16-Bit value [high byte, low byte].
'ModbusCRC16TransmittedFrame(frame) : Append CRC16 To the end of a frame (low byte first, high byte second).
'ModbusCheckCRC16 : Validate that a frame ends with the correct Modbus CRC.
'ModbusCRC16Test(frame) : Test the Modbus CRC16 functions For a frame.
'
'-- BitWise ---
'SetBit(b, index, on) : Sets Or clears a Bit in a byte at the given index.
'ToggleBit(b, index) : Flips (toggles) a Bit in a byte at the given index.
'GetBit(b, index) : Tests If a Bit at the given index in a byte is set.
'ByteToBitsString(b) : Converts a single byte To an 8-character binary string (same As ByteToBin).
'BytesToBitsString)b()) : Converts a byte Array To a binary string representation (same As BytesToBin).
'
' -- CSV Parsing --
'CSVCountItems: Get the number of items from a CSV string.
'CSVToBytes: Split number items from a CSV string to a byte array.
'CSVToInts: Split number items from a CSV string to an int array.
'CSVToUInts: Split number items from a CSV string to an uint array.
'CSVToULongs: Split number items from a CSV string to an ulong array.
'CSVToFloats: Split number items from a CSV string to a floats array.
'
' -- Misc --
'DirectionToString(direction) : Convert direction given as byte to string.
'MillisToBytes(millis): Convert milliseconds to hh:mm:ss string
'----------------------------------------------
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

	Public VERSION As ULong = 20251023

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
	
	' Modbus RTU
	Private Const MODBUS_POLYNOMIAL As ULong = 0xA001

	' Split option to allow empty string as 0
	Public SplitAllowEmptyAsZero As Boolean = True

	' Byte converter instance (from lib rRandomAccessFile) for conversions between bytes and strings
	' Public so it can be accessed from this module.
	Public ByteConv As ByteConverter
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
	Return ByteConv.HexFromBytes(bytes)
End Sub

'----------------------------------------------
' OneByteToHex
' Convert single byte to HEX string.
'----------------------------------------------
Public Sub OneByteToHex(b As Byte) As String
	Return ByteConv.HexFromBytes(Array As Byte(b))
End Sub

'----------------------------------------------
' TwoBytesToHex
' Convert 2 bytes to HEX string.
'----------------------------------------------
Public Sub TwoBytesToHex(b1 As Byte, b2 As Byte) As String
	Return ByteConv.HexFromBytes(Array As Byte(b1, b2))
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

'----------------------------------------------
' BytesToString
' Convert bytes to string.
'----------------------------------------------
Public Sub BytesToString(bytes() As Byte) As String
	Return ByteConv.StringFromBytes(bytes)
End Sub
#End Region

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
' UIntToBytesEndian
' Converts an unsigned 16-bit integer (ULong, lower 2 bytes used) to a byte array (big or little-endian).
' b(0) = LSB, b(1) = MSB
'----------------------------------------------
Public Sub UIntToBytesEndian(value As ULong, littleendian As Boolean) As Byte()
	Dim b(2) As Byte
	If littleendian Then
		b(0) = Bit.And(value, 0xFF)                     ' Low byte
		b(1) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)  ' High byte
	Else
		b(0) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)  ' Low byte
		b(1) = Bit.And(value, 0xFF)                     ' High byte
	End If
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

'----------------------------------------------
' UIntToHex
' Converts an UInt to HEX string with 2 bytes.
'----------------------------------------------
Public Sub UIntToHex(value As UInt) As String
	
	Return ByteConv.HexFromBytes(UIntToBytes(value))
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

'----------------------------------------------
' ULongToHex
' Converts an ULong to HEX string with 4 bytes.
'----------------------------------------------
Public Sub ULongToHex(value As ULong) As String
	Return ByteConv.HexFromBytes(ULongToBytes(value))
End Sub
#End Region

#Region Float
'----------------------------------------------
' FloatToBytes
' Convert Float (4 bytes, IEEE 754) to bytes
'----------------------------------------------
Public Sub FloatToBytes(f As Float) As Byte()
	Dim b() As Byte = ByteConv.DoublesToBytes(Array As Double(f))
	Return b
End Sub

'----------------------------------------------
' BytesToFloat
' Convert bytes to Float (IEEE 754)
'----------------------------------------------
Public Sub BytesToFloat(b() As Byte) As Float
	Dim d() As Double = ByteConv.DoublesFromBytes(b)
	Log("[BytesToFloat] b=", ByteConv.HexFromBytes(b), ", result length=", d.Length)
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
Public Sub ByteToBin(b As Byte) As Byte()
	Dim bits(8) As Byte
	For i = 0 To 7
		bits(i) = 48 + Bit.And(Bit.ShiftRight(b, 7 - i), 1)  ' ASCII '0' = 48
	Next
	Return bits
End Sub

'----------------------------------------------
' BytesToBin
' Converts a byte array to a binary string representation.
' Each byte is represented by 8 bits in "01010101" format.
' Returns: Concatenated string of all bits.
' Example: BytesToBin(Array As Byte(5,170)) > "0000010110101010"
'----------------------------------------------
Public Sub BytesToBin(bytes() As Byte) As Byte()
	' Get the number of bytes = array length
	Dim nrofbytes As UInt = bytes.Length
	
	' Define the size of the bits array
	Dim bitsarraylen As UInt = nrofbytes * 8
	
	' Define the bits array
	Dim bits(bitsarraylen) As Byte
	
	' Loop over the bytes
	For j = 0 To nrofbytes - 1
		Dim b As Byte = bytes(j)
		For i = 0 To 7
			bits(j * 8 + i) = 48 + Bit.And(Bit.ShiftRight(b, 7 - i), 1)  ' ASCII '0' = 48
		Next
	Next
	Return bits
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
	Return ByteConv.StringFromBytes(bits)
End Sub

'----------------------------------------------
' BinToDec
' Converts a binary string like "11100011" > 227.
' binstr: String to convert. Must be of type string and not bytes().
'----------------------------------------------
Public Sub BinToDec(binstr As String) As UInt
	Dim result As UInt = 0
	Dim i As Int
	Dim b() As Byte = binstr.GetBytes
	For i = 0 To binstr.Length - 1
		Dim c As Byte = b(i)
		result = result * 2
		If c = Asc("1") Then result = result + 1
	Next
	Return result
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
Public Sub ByteToBCD(value As Byte) As UInt
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
	Return ByteConv.StringFromBytes(bits)
End Sub

'----------------------------------------------
' BCDToByte
' Convert single-byte BCD to decimal 0–99
'----------------------------------------------
Public Sub BCDToByte(b As Byte) As UInt
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
Public Sub BCDArrayToUInt(b() As Byte) As UInt
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
Public Sub SwapUInt16(value As UInt) As UInt
    Return Bit.Or(Bit.ShiftLeft(Bit.And(value, 0xFF), 8), Bit.ShiftRight(Bit.And(value, 0xFF00), 8))
End Sub

'----------------------------------------------
' SwapUInt32: swap byte order of 32-bit unsigned integer
' Byte order b(0)b(1)b(2)b(3) -> b(3)b(2)b(1)b(0)
'----------------------------------------------
Public Sub SwapUInt32(value As ULong) As ULong
    Return Bit.Or(Bit.ShiftLeft(Bit.And(value, 0xFF), 24), _
           Bit.Or(Bit.ShiftLeft(Bit.And(Bit.ShiftRight(value, 8), 0xFF), 16), _
           Bit.Or(Bit.ShiftLeft(Bit.And(Bit.ShiftRight(value, 16), 0xFF), 8), _
                  Bit.And(Bit.ShiftRight(value, 24), 0xFF))))
End Sub

'----------------------------------------------
' SwapUInt16ToBytes: convert UInt16 to reversed byte array
' Example: value=0x0017 -> [0x17, 0x00]
'----------------------------------------------
Public Sub SwapUInt16ToBytes(value As UInt) As Byte()
    Dim b(2) As Byte
    b(0) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)
    b(1) = Bit.And(value, 0xFF)
    Return b
End Sub

'----------------------------------------------
' BytesToUInt16Swapped: convert reversed byte array back to UInt16
' Example: [0x17, 0x00] -> 0x0017 = 23
'----------------------------------------------
Public Sub BytesToUInt16Swapped(b() As Byte) As UInt
	If b.Length < 2 Then Return 0
	Return Bit.Or(Bit.And(b(0), 0xFF), Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
End Sub

'----------------------------------------------
' SwapUInt32ToBytes: convert UInt32 to reversed byte array
' Example: value=0x12345678 -> [0x78, 0x56, 0x34, 0x12]
'----------------------------------------------
Public Sub SwapUInt32ToBytes(value As ULong) As Byte()
	Dim b(4) As Byte
	b(0) = Bit.And(Bit.ShiftRight(value, 24), 0xFF)
	b(1) = Bit.And(Bit.ShiftRight(value, 16), 0xFF)
	b(2) = Bit.And(Bit.ShiftRight(value, 8), 0xFF)
	b(3) = Bit.And(value, 0xFF)
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
	Return ByteConv.StringFromBytes(result)
End Sub

'----------------------------------------------
' StringTrimCRLF
' Removes leading and trailing spaces, tabs, CR, and LF characters.
' ASCII codes:
'   Space = 32
'   Tab   = 9
'   CR    = 13
'   LF    = 10
'----------------------------------------------
Public Sub StringTrimCRLF(s As String) As String
	Dim b() As Byte = s.GetBytes
	Dim startIndex As Int = 0
	Dim endIndex As Int = b.Length - 1

	Do While startIndex <= endIndex And (b(startIndex) = 32 Or b(startIndex) = 9 Or b(startIndex) = 13 Or b(startIndex) = 10)
		startIndex = startIndex + 1
	Loop

	Do While endIndex >= startIndex And (b(endIndex) = 32 Or b(endIndex) = 9 Or b(endIndex) = 13 Or b(endIndex) = 10)
		endIndex = endIndex - 1
	Loop

	If startIndex > endIndex Then Return ""

	Dim trimmedLength As Int = endIndex - startIndex + 1
	Dim result(trimmedLength) As Byte
	For i = 0 To trimmedLength - 1
		result(i) = b(startIndex + i)
	Next
	Return ByteConv.StringFromBytes(result)
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
	Return ByteConv.StringFromBytes(b)
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
	Return ByteConv.StringFromBytes(b)
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

#Region ModbusCRC16
' ------------------------------------------------------------
' ModbusCRC16 Functions for B4R
' This library uses the Modbus RTU CRC-16 algorithm, which is equivalent to the IBM CRC-16 (poly 0xA001), with initial value 0xFFFF and little-endian transmission order (low byte first).
'
' Example
' Frame To send (without CRC):	01 03 00 00 00 0A
' Calculated CRC:				
'	Numeric (big-endian):		0xCDC5 (decimal 52677)
'	Bytes (low, high): 			C5 CD
' Transmitted CRC: 				C5 CD (little-endian, low byte high byte)
' Transmitted frame: 			01 03 00 00 00 0A C5 CD
'------------------------------------------------------------

' ------------------------------------------------------------
' ModbusCRC16
' Calculate Modbus RTU CRC-16.
' Returns array [low, high].
' ------------------------------------------------------------
Public Sub ModbusCRC16(frame() As Byte) As Byte()
	Dim CRC As UInt = 0xFFFF
    
	For i = 0 To frame.Length - 1
		CRC = Bit.Xor(CRC, frame(i))
		For j = 0 To 7
			If Bit.And(CRC, 1) <> 0 Then
				CRC = Bit.ShiftRight(CRC, 1)
				CRC = Bit.Xor(CRC, MODBUS_POLYNOMIAL)
			Else
				CRC = Bit.ShiftRight(CRC, 1)
			End If
		Next
	Next
    
	Dim result(2) As Byte
	result(0) = Bit.And(CRC, 0xFF)                  ' Low byte
	result(1) = Bit.And(Bit.ShiftRight(CRC, 8), 0xFF) ' High byte
	Return result
End Sub

' ------------------------------------------------------------
' ModbusCRC16UInt
' Numeric representation swaps the byte order to match usual 16-Bit notation.
' Return CRC as numeric 16-bit value for debugging.
' Example: 0xCDC5 = 52677 
' Converts [low, high] > numeric: (high<<8) | low = 0xCD<<8 | 0xC5 = 0xCDC5 = 52677 decimal.
' ------------------------------------------------------------
Public Sub ModbusCRC16UInt(frame() As Byte) As ULong
	Dim crcBytes() As Byte = ModbusCRC16(frame)   ' [low, high]
	Dim low As ULong  = crcBytes(0)
	Dim high As ULong = crcBytes(1)
	' Swap
	Dim result As ULong = Bit.Or(Bit.ShiftLeft(high, 8), low)  ' high<<8 | low
	Return result
End Sub

' ------------------------------------------------------------
' ModbusCRC16TransmittedFrame
' Modbus standard: send low byte first, then high byte:
' Append CRC (low, high) to data frame.
' ------------------------------------------------------------
Public Sub ModbusCRC16TransmittedFrame(frame() As Byte) As Byte()
	Dim crcBytes() As Byte = ModbusCRC16(frame)
	Dim out(frame.Length + 2) As Byte
	ByteConv.ArrayCopy2(frame, 0, out, 0, frame.Length)
	out(frame.Length)     = crcBytes(0)   ' Low byte
	out(frame.Length + 1) = crcBytes(1)   ' High byte
	Return out
End Sub

' ------------------------------------------------------------
' ModbusCRC16Check
' Verify frame ends with correct CRC.
' Return 1=true or 0=false
' ------------------------------------------------------------
Public Sub ModbusCRC16Check(frame() As Byte) As Boolean
	If frame = Null Or frame.Length < 3 Then Return False
    
	Dim data(frame.Length - 2) As Byte
	ByteConv.ArrayCopy2(frame, 0, data, 0, frame.Length - 2)
    
	Dim expected() As Byte = ModbusCRC16(data)
	Return expected(0) = frame(frame.Length - 2) And _
           expected(1) = frame(frame.Length - 1)
End Sub
#End Region

#Region BitWise
'----------------------------------------------
' SetBit
' Sets or clears a bit in a byte at the given index.
' b: Input byte value.
' index: Bit index (0–7).
' on: True to set the bit, False to clear it.
' Returns: The modified byte.
' Example: SetBit(0, 3, True) > 8 (0b00001000)
'----------------------------------------------
Public Sub SetBit(b As Byte, index As Int, on As Boolean) As Byte
	If on Then
		Return Bit.Or(b, Bit.ShiftLeft(1, index))
	Else
		Return Bit.And(b, Bit.Not(Bit.ShiftLeft(1, index)))
	End If
End Sub

'----------------------------------------------
' ToggleBit
' Flips (toggles) a bit in a byte at the given index.
' b: Input byte value.
' index: Bit index (0–7).
' Returns: The modified byte.
' Example: ToggleBit(8, 3) > 0 (0b00000000)
'----------------------------------------------
Public Sub ToggleBit(b As Byte, index As Int) As Byte
	Dim mask As Byte = Bit.ShiftLeft(1, index)
	If Bit.And(b, mask) = 0 Then
		Return Bit.Or(b, mask)
	Else
		Return Bit.And(b, Bit.Not(mask))
	End If
End Sub

'----------------------------------------------
' GetBit
' Tests if a bit at the given index in a byte is set.
' b: Input byte value.
' index: Bit index (0–7).
' Returns: True if the bit is set, otherwise False.
' Example: GetBit(8, 3) > True
'----------------------------------------------
Public Sub GetBit(b As Byte, index As Int) As Boolean
	Dim mask As Byte = Bit.ShiftLeft(1, index)
	Return Bit.And(b, mask) = mask
End Sub

'----------------------------------------------
' ByteToBitsString (same as ByteToBin)
' Converts a single byte to an 8-character binary string.
' Returns: "01010101" representation of the byte.
' Example: ByteToBitsString(170) > "10101010"
'----------------------------------------------
Public Sub ByteToBitsString(b As Byte) As Byte()
	Return ByteToBin(b)
End Sub

'----------------------------------------------
' BytesToBitsString
' Converts a byte array to a binary string representation.
' Each byte is represented by 8 bits in "01010101" format.
' Returns: Concatenated string of all bits.
' Example: BytesToBitsString(Array As Byte(5,170)) > "0000010110101010"
'----------------------------------------------
Public Sub BytesToBitsString(bytes() As Byte) As Byte()
	Return BytesToBin(bytes)
End Sub
#End Region

'====================================================
' CSV Parsing Utilities
'====================================================
#Region CSV Parsing Utilities
'----------------------------------------------
' CSVCountItems
' Counts number of items in a CSV (or delimited) string.
'----------------------------------------------
Public Sub CSVCountItems(buffer() As Byte, separator As String) As Int	'ignore
	Dim count As Int
	For Each item() As Byte In ByteConv.Split(buffer, separator)
		count = count + 1
	Next
	Return count
End Sub

'----------------------------------------------
' CSVCheckValue
' Common helper: converts bytes to string, trims spaces,
' and validates empty fields. Private.
'----------------------------------------------
Private Sub CSVCheckValue(item() As Byte, index As Int, tag As String) As String
	Dim str As String = ByteConv.StringFromBytes(item)
	str = StringTrim(str)

	If str.Length = 0 Then
		If SplitAllowEmptyAsZero Then
			Return "0"
		Else
			Log("[", tag, "][E] Empty item at index ", index, " not allowed.")
			Return ""
		End If
	End If
	Return str
End Sub

'----------------------------------------------
' CSVToBytes
' Converts CSV to Byte() array.
'----------------------------------------------
Public Sub CSVToBytes(buffer() As Byte, separator As String) As Byte()
	Dim count As Int = CSVCountItems(buffer, separator)
	Dim result(count) As Byte
	Dim error() As Byte
	Dim counter As Int

	For Each item() As Byte In ByteConv.Split(buffer, separator)
		Dim str As String = CSVCheckValue(item, counter, "CSVToBytes")
		If str = "" Then Return error

		If IsNumber(str) Then
			Dim num As Int = str
			If num < BYTE_MIN Or num > BYTE_MAX Then
				Log("[CSVToBytes][E] Item ", str, " (index ", counter, _
					") out of range ", BYTE_MIN, "–", BYTE_MAX, ".")
				Return error
			End If
			result(counter) = num
		Else
			Log("[CSVToBytes][E] Item ", str, " (index ", counter, ") is not a number.")
			Return error
		End If
		counter = counter + 1
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToInts
' Converts CSV to Int() array.
'----------------------------------------------
Public Sub CSVToInts(buffer() As Byte, separator As String) As Int()
	Dim count As Int = CSVCountItems(buffer, separator)
	Dim result(count) As Int
	Dim error() As Int
	Dim counter As Int

	For Each item() As Byte In ByteConv.Split(buffer, separator)
		Dim str As String = CSVCheckValue(item, counter, "CSVToInts")
		If str = "" Then Return error

		If IsNumber(str) Then
			Dim num As Int = str
			If num < INT16_MIN Or num > INT16_MAX Then
				Log("[CSVToInts][E] Item ", str, " (index ", counter, _
					") out of range ", INT16_MIN, "–", INT16_MAX, ".")
				Return error
			End If
			result(counter) = num
		Else
			Log("[CSVToInts][E] Item ", str, " (index ", counter, ") is not a number.")
			Return error
		End If
		counter = counter + 1
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToUInts
' Converts CSV to UInt() array.
'----------------------------------------------
Public Sub CSVToUInts(buffer() As Byte, separator As String) As UInt()
	Dim count As Int = CSVCountItems(buffer, separator)
	Dim result(count) As UInt
	Dim error() As UInt
	Dim counter As Int

	For Each item() As Byte In ByteConv.Split(buffer, separator)
		Dim str As String = CSVCheckValue(item, counter, "CSVToUInts")
		If str = "" Then Return error

		If IsNumber(str) Then
			Dim num As Float = str
			If num < 0 Or num > UINT16_MAX Then
				Log("[CSVToUInts][E] Item ", str, " (index ", counter, _
					") out of range 0–", UINT16_MAX, ".")
				Return error
			End If
			result(counter) = num
		Else
			Log("[CSVToUInts][E] Item ", str, " (index ", counter, ") is not a number.")
			Return error
		End If
		counter = counter + 1
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToULongs
' Converts CSV to ULong() array.
'----------------------------------------------
Public Sub CSVToULongs(buffer() As Byte, separator As String) As ULong()
	Dim count As Int = CSVCountItems(buffer, separator)
	Dim result(count) As ULong
	Dim error() As ULong
	Dim counter As Int

	For Each item() As Byte In ByteConv.Split(buffer, separator)
		Dim str As String = CSVCheckValue(item, counter, "CSVToULongs")
		If str = "" Then Return error

		If IsNumber(str) Then
			result(counter) = str
		Else
			Log("[CSVToULongs][E] Item ", str, " (index ", counter, ") is not a number.")
			Return error
		End If
		counter = counter + 1
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToFloats
' Converts CSV to Float() array.
'----------------------------------------------
Public Sub CSVToFloats(buffer() As Byte, separator As String) As Float()
	Dim count As Int = CSVCountItems(buffer, separator)
	Dim result(count) As Float
	Dim error() As Float
	Dim counter As Int

	For Each item() As Byte In ByteConv.Split(buffer, separator)
		Dim str As String = CSVCheckValue(item, counter, "CSVToFloats")
		If str = "" Then Return error

		If IsNumber(str) Then
			result(counter) = str
		Else
			Log("[CSVToFloats][E] Item ", str, " (index ", counter, ") is not a number.")
			Return error
		End If
		counter = counter + 1
	Next
	Return result
End Sub
#End Region

#Region Misc
'----------------------------------------------
' MillisToBytes
' Convert milliseconds to hh:mm:ss string
' Returns: String hh:mm:ss
'----------------------------------------------
Public Sub MillisToBytes(ms As Long) As String
	Dim totalSec As Long = ms / 1000
	Dim hours As Int = totalSec / 3600
	Dim minutes As Int = (totalSec Mod 3600) / 60
	Dim seconds As Int = totalSec Mod 60

	' hh:mm:ss -> always 8 chars
	Dim b(8) As Byte

	' Hours
	b(0) = 48 + hours / 10      ' tens digit
	b(1) = 48 + hours Mod 10    ' units digit
	b(2) = 58                    ' ':'

	' Minutes
	b(3) = 48 + minutes / 10
	b(4) = 48 + minutes Mod 10
	b(5) = 58

	' Seconds
	b(6) = 48 + seconds / 10
	b(7) = 48 + seconds Mod 10

	' Convert byte array to string
	Return BytesToString(b)
End Sub

'----------------------------------------------
' DirectionToString
' Convert direction given as byte to string.
' direction: byte 0-3 right, left, up, down
' Returns: String Direction
'----------------------------------------------
Public Sub DirectionToString(direction As Byte) As String
	Select direction
		Case 0: Return "RIGHT"
		Case 1: Return "LEFT"
		Case 2: Return "UP"
		Case 3: Return "DOWN"
		Case Else
			Return ""
	End Select
End Sub
#End Region
