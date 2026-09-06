B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' ================================================================
' File:         Convert.bas
' Brief:        Code module with various conversions
' Author:      	Robert W.B. Linn (c) 2025-2026 MIT
' Date:         20260903
' Version:		1.7.0
' Hardware:		Arduino UNO, UNOR4, ESP32
' Software:		B4R 4.00 (64 bit), arduino-cli 1.3.1, ESP32 Board Manager 3.3.11
' DependsOn:    rRandomAccessFile 1.91 or higher.
' Conditionals	Following conditional symbols to support specific MCU's:
'				ESP32 - Compile specific methods for the ESP32 MCU's
' Notes:		On ESP32, ESP8266, Arduino AVR, B4R ByteConverter uses the MCU’s native endian.
'				Most ARM/AVR microcontrollers are little-endian, so ByteConv.DoublesToBytes produces little-endian bytes.
'				The IEEE-754 defines a standard bit format, but the byte-order of that format is dependent on the host machine.
'				Use the method ReverseBytes to change endian.
' ================================================================
#End Region

#Region Function Index (one-liners)
'-- ByteWise --
'ByteToBool(byte) : Byte 0 | 1 > True, Else False.
'AsciiByteToBool(byte) : Byte "1" > True, Byte "0" > False.
'AsciiBytesToBool(byte) : First Byte "1" > True, Byte "0" > False.
'AsciiByteToInt(byte) : Ascii digit Byte "0"-"9" > Integer 0–9.
'ByteToHex(byte): Single Byte > HEX string.
'BytesToHex(bytes) : Byte Array > HEX string.
'TwoBytesToHex(b1,b2) : Two bytes > HEX string.
'ReverseBytes(b) : Reverse Byte order Byte Array.
'SliceBytes(b,i,n) : Extract a portion of a byte array.
'ConcatBytes(b1,b2) : Concatenate two byte arrays into a new single byte array.
'IndexOf(b, index) : Search for the first occurrence of a specific byte value.
'GetByte(b, index) : Get a byte at a specific index with safety checking.
'ByteToBits(b) : Convert a single byte into an array of 8 Booleans (bits).
'BitsToByte(b()) : Convert an array of 8 Booleans (bits) back into a single byte.
'ShiftArrayBytesLeft(b) : Shift all bytes across an array to the left by a specified number of positions.
'ShiftArrayBytesRight(b) : Shift all bytes across an array to the right by a specified number of positions.
'ByteArrayCompare(b1,b2) : Compare two byte arrays for exact equality.
'
'-- Bool --
'BoolToString(state) : True > "1", False > "0".
'BoolToOnOff(state) : True > "ON", False > "OFF".
'OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.
'BoolToTrueFalse(value) : "True" or "False".
'IntToBool(value) : Convert Int 0, 1 > Bool.
'BoolToByte : Converts a Boolean value > Byte 1 (True) or 0 (False).
'
'-- Int --
'TwoBytesToInt(bytes, littleendian): Convert 2 Bytes > Signed Int with endian support
'
'-- UInt --
'UIntToBytes(value) : 16-Bit unsigned Int > little-endian Bytes.
'BytesToUInt(b) : Little-endian 2 bytes > unsigned 16-Bit.
'TwoBytesToUInt(b, littleendian): Convert 2 bytes > unsigned Int (0..65535) with endian support
'UIntToHex(value) : Converts an UInt > HEX string with 2 bytes.
'UIntFromString : Converts a string > Unsigned 16-bit integer (UInt).
'
'-- ULong --
'ULongToBytes(value) : 32-Bit unsigned > little-endian bytes.
'BytesToULong(b) : Little-endian 4 bytes > unsigned 32-Bit.
'ULongToHex(value) : Converts an ULong > HEX string with 4 bytes.
'ULongFromString : Converts a string > Unsigned 32-bit integer (ULong).
'
'-- Float --
'FloatToBytes(value) : 32-Bit float > little-endian bytes.
'BytesToFloat(b) : Little-endian 4 bytes > 32-Bit float.
'  
'-- Double 64-bit (ESP32 only) ---
'D64Millis - Fetches the True 13-digit absolute Unix epoch milliseconds from the hardware.
'D64ToBytes(d) - Convert large Double into the 8-byte global Array `D64Buffer`. **Note**: Tiny rounding steps may occur on high values during inline B4R math operations (e.g., a difference of 9984ms instead of exactly 10000ms).
'D64ToString(d) - Format any large Double safely into the global Array `D64String` As printable text characters To bypass standard B4R Log `ovf` limitations.
'D64ToHex(d) - Convert large Double into a 16-character hexadecimal string, with option To swap byte-order To Little- Or Big-Endian.
'
'-- Bin --
'ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.
'BytesToBin(b()) : Converts byte array > Binary string representation.
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
'ToUpperCase(s) : Ascii lowercase > uppercase.
'ToLowerCase(s) : Ascii uppercase > lowercase.
'EqualsIgnoreCase(s1,s2) : Compare ignoring Ascii Case.
'ReplaceString(orig,search,repl) : Replace all occurrences in Byte Array.
'AsciiBufferToInt(buffer) : Convert buffer containing Ascii digits > Integer.
'
'-- Modbus CRC-16 --
'ModbusCRC16(frame) : Calculate CRC16 (Modbus RTU) > return As 2-byte Array in little-endian order: [low byte, high byte].
'ModbusCRC16UInt(frame) : Calculate CRC16 (Modbus RTU) > return As numeric 16-Bit value [high byte, low byte].
'ModbusCRC16TransmittedFrame(frame) : Append CRC16 > end of a frame (low byte first, high byte second).
'ModbusCheckCRC16 : Validate that a frame ends with the correct Modbus CRC.
'ModbusCRC16Test(frame) : Test the Modbus CRC16 functions for a frame.
'
'-- BitWise ---
' SetBit(b,i) : Sets a specific bit index in a byte to HIGH (1).
' ClearBit(b, i) : Clears a specific bit index in a byte to LOW (0).
'ToggleBit(b, index) : Flips (toggles) a Bit in a byte at the given index.
'GetBit(b, index) : Tests Bit at the given index in a byte is set (true, 1).
'TestBit(b, index) : Alias for GetBit.
'ByteToBitsString(b) : Converts a single byte > 8-character binary string (same As ByteToBin).
'BytesToBitsString(b) : Converts a byte Array > binary string representation (same As BytesToBin).
'GetBitIndices(b,bool) : Get the positions (0 to 7) of all bits that are either HIGH or LOW.
'SetBitIndices(b): Create a single byte by setting specific bit positions to HIGH (1).
'ClearBitIndices(b) : Create a single byte where specified bit positions are cleared to LOW (0).
'CountActiveBits(b, bool) : Count how many bits inside a byte are set to HIGH or LOW.
'ShiftArrayBitsLeft(b) : Shift all bits across a whole byte array to the left by 1 bit position.
'ShiftArrayBitsRight(b) : Shift all bits across a whole byte array to the right by 1 bit position.
'
' -- CSV Parsing --
'CSVCountItems: Get the number of items from a CSV string.
'CSVToBytes: Split number items from a CSV string > Byte Array.
'CSVToInts: Split number items from a CSV string > Int Array.
'CSVToUInts: Split number items from a CSV string > UInt Array.
'CSVToULongs: Split number items from a CSV string > ULong Array.
'CSVToFloats: Split number items from a CSV string > Float Array.
'
' -- Color Conversion
'RGBToColor: Convert RGB colors 0-255 > ULong.
'ColorToRGB: Convert color ULong > Byte Array (length 3) with RGB colors 0-255.

' -- Misc --
'DirectionToString(direction) : Convert direction given as Byte > String.
'MillisToTimeString(millis): Convert milliseconds > hh:mm:ss string
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

	' Version and build
	' 1 (Major): Incremented For massive rewrites Or breaking API signature updates.
	' 7 (Minor): Incremented when adding new functionalities that are backward-compatible.
	' 0 (Patch): Incremented For small backward-compatible bug fixes.
	Public Const VERSION 			As String = "1.7.0 - Build 20260903"

	' Constants for numeric ranges
	' Based on Arduino / C standard integer sizes

    ' -------------------------
    ' Integer types
    ' -------------------------
    ' Byte (unsigned 8-bit)
    Public Const BYTE_MIN 			As Byte = 0
    Public Const BYTE_MAX 			As Byte = 255

    ' Int (signed 16-bit)
    Public Const INT16_MIN 			As Int = -32768
    Public Const INT16_MAX 			As Int = 32767

    ' UInt16 (unsigned 16-bit, stored in ULong in B4R)
    Public Const UINT16_MIN 		As ULong = 0
    Public Const UINT16_MAX 		As ULong = 65535

    ' ULong (unsigned 32-bit)
    Public Const UINT32_MIN 		As ULong = 0
    Public Const UINT32_MAX			As ULong = 4294967295

	' D64 (double 64-bit ESP32 only)
    ' Receive the 64-bit value from Inline C
    Public D64Val As Double
	' Raw 8-byte buffer register
	Public D64Buffer(8) As Byte
	' Raw 16-byte HEX string register
	Public D64String(16) As Byte
	
    ' -------------------------
    ' Floating point types
    ' -------------------------
    ' Float (4-byte single precision)
    Public Const FLOAT_MIN 			As Float = -3.4028235E38
    Public Const FLOAT_MAX			As Float = 3.4028235E38

    ' Double (platform-dependent)
    #If ESP32
        ' ESP32: 64-bit double
        Public Const DOUBLE_MIN 	As Double = -1.7976931348623157E308
        Public Const DOUBLE_MAX 	As Double = 1.7976931348623157E308
    #Else
        ' AVR / smaller boards: double same as float (32-bit)
        Public Const DOUBLE_MIN		As Double = -3.4028235E38
        Public Const DOUBLE_MAX		As Double = 3.4028235E38
    #End If
	
	' Modbus RTU
	Private Const MODBUS_POLYNOMIAL	As ULong = 0xA001

	' CSV Parser
	' Split option to allow empty string as 0
	Public SplitAllowEmptyAsZero 	As Boolean = True
	Public CSVParserResult			As Boolean = False

	' Byte converter instance (from lib rRandomAccessFile) for conversions between bytes and strings
	' Public so it can be accessed from this module.
	Public ByteConv 				As ByteConverter
End Sub

' ================================================================
' BYTEWISE
' ================================================================
#Region ByteWise
'----------------------------------------------
' ByteToBool
' Converts byte 0 | 1 to a Boolean value.
' Returns True if byte is 1, otherwise False.
'----------------------------------------------
Public Sub ByteToBool(b As Byte) As Boolean
	Return IIf(b == 1, True, False)
End Sub

'----------------------------------------------
' AsciiByteToBool
' Converts the Ascii byte to a Boolean value.
' Assumes the byte represents the Ascii character "0" (48) or "1" (49).
' Returns True if byte is "1", otherwise False.
'----------------------------------------------
Public Sub AsciiByteToBool(b As Byte) As Boolean
	Return IIf(b == 49, True, False)
End Sub

'----------------------------------------------
' AsciiBytesToBool
' Converts the first Ascii byte of an array to a Boolean value.
' Assumes the byte represents the Ascii character "0" (48) or "1" (49).
' Returns True if byte is "1", otherwise False.
'----------------------------------------------
Public Sub AsciiBytesToBool(bytes() As Byte) As Boolean
	If bytes == Null Or bytes.Length == 0 Then Return False
	Return IIf(bytes(0) == 49, True, False)
End Sub

'----------------------------------------------
' AsciiByteToInt
' Converts the first byte of an array containing an Ascii digit ('0'–'9') to an integer value (0–9).
'----------------------------------------------
Public Sub AsciiByteToInt(bytes() As Byte) As Int
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
' ByteToHex
' Convert single byte to HEX string.
'----------------------------------------------
Public Sub ByteToHex(b As Byte) As String
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
' Parameter:
'	b() - Byte Array
' Returns:
'	Byte Array
' Example: Two byte array [0x0A, 0x1F] > [0x0A, 0x1F]
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
' SliceBytes
' Extract a portion of a byte array.
' Parameter:
'	b() - Source Byte Array
'	StartIndex - The zero-based starting index
'	Length - The number of bytes to extract
' Returns:
'	Byte Array
' Example: 
'	SliceBytes(Array As Byte(0x0A, 0x1F, 0x2E, 0x3D), 1, 2)
'	[0x0A, 0x1F, 0x2E, 0x3D], Start 1, Length 2 > [0x1F, 0x2E]
'----------------------------------------------
Public Sub SliceBytes(b() As Byte, StartIndex As Int, Length As Int) As Byte()
	' Validate input parameters for B4R stability
	If StartIndex < 0 Or StartIndex >= b.Length Or Length <= 0 Then
		Dim EmptyArray(0) As Byte
		Return EmptyArray
	End If
	
	' Prevent index out of bounds if Length is too large
	Dim ActualLength As Int = Length
	If StartIndex + ActualLength > b.Length Then
		ActualLength = b.Length - StartIndex
	End If
	
	Dim r(ActualLength) As Byte
	For i = 0 To ActualLength - 1
		r(i) = b(StartIndex + i)
	Next
	Return r
End Sub

'----------------------------------------------
' ConcatBytes
' Concatenate two byte arrays into a new single byte array.
' Parameter:
'	b1() - First Byte Array
'	b2() - Second Byte Array
' Returns:
'	Byte Array
' Example: b1=[0x0A, 0x1F], b2=[0x2E, 0x3D] > [0x0A, 0x1F, 0x2E, 0x3D]
'----------------------------------------------
Public Sub ConcatBytes(b1() As Byte, b2() As Byte) As Byte()
	Dim TotalLength As Int = b1.Length + b2.Length
	Dim r(TotalLength) As Byte
	
	' Copy first array
	For i = 0 To b1.Length - 1
		r(i) = b1(i)
	Next
	
	' Copy second array
	For i = 0 To b2.Length - 1
		r(b1.Length + i) = b2(i)
	Next
	
	Return r
End Sub

'----------------------------------------------
' IndexOf
' Search for the first occurrence of a specific byte value.
' Parameter:
'	b() - Byte Array to search within
'	Value - The byte value to search for
' Returns:
'	Int - The zero-based index of the first occurrence, or -1 if not found
' Example: b=[0x0A, 0x1F, 0x2E], Value=0x1F > 1
'----------------------------------------------
Public Sub IndexOf(b() As Byte, Value As Byte) As Int
	For i = 0 To b.Length - 1
		If b(i) = Value Then
			Return i
		End If
	Next
	Return -1
End Sub

'----------------------------------------------
' GetByte
' Get a byte at a specific index with safety checking.
' Parameter:
'	b() - Byte Array
'	Index - The zero-based index to read
' Returns:
'	Byte - The byte value, or 0x00 if out of bounds
'----------------------------------------------
Public Sub GetByte(b() As Byte, Index As Int) As Byte
	If Index < 0 Or Index >= b.Length Then
		Return 0x00
	End If
	Return b(Index)
End Sub

'----------------------------------------------
' ByteToBits
' Convert a single byte into an array of 8 Booleans (bits).
' Index 0 is the Most Significant Bit (MSB, bit 7), Index 7 is the LSB (bit 0).
' Parameter:
'	Value - The byte to convert
' Returns:
'	Boolean Array of length 8
' Example: Value = 0x81 (10000001) > [True, False, False, False, False, False, False, True]
'----------------------------------------------
Public Sub ByteToBits(b As Byte) As Boolean()
	Dim r(8) As Boolean
	
	' Mask each bit from MSB (bit 7) down to LSB (bit 0)
	r(0) = ((Bit.And(b, 0x80)) <> 0)
	r(1) = ((Bit.And(b, 0x40)) <> 0)
	r(2) = ((Bit.And(b, 0x20)) <> 0)
	r(3) = ((Bit.And(b, 0x10)) <> 0)
	r(4) = ((Bit.And(b, 0x08)) <> 0)
	r(5) = ((Bit.And(b, 0x04)) <> 0)
	r(6) = ((Bit.And(b, 0x02)) <> 0)
	r(7) = ((Bit.And(b, 0x01)) <> 0)
	
	Return r
End Sub

'----------------------------------------------
' BitsToByte
' Convert an array of 8 Booleans (bits) back into a single byte.
' Index 0 is the Most Significant Bit (MSB, bit 7), Index 7 is the LSB (bit 0).
' Parameter:
'	Bits() - Boolean Array of length 8
' Returns:
'	Byte - The consolidated byte value (returns 0x00 if input array is invalid)
' Example: [True, False, False, False, False, False, False, True] > 0x81
'----------------------------------------------
Public Sub BitsToByte(Bits() As Boolean) As Byte
	' Safety check for B4R stability
	If Bits.Length < 8 Then Return 0x00
	
	Dim r As Int = 0
	
	' Shift and combine each boolean bit into the integer accumulator
	If Bits(0) Then r = Bit.Or(r, 0x80)
	If Bits(1) Then r = Bit.Or(r, 0x40)
	If Bits(2) Then r = Bit.Or(r, 0x20)
	If Bits(3) Then r = Bit.Or(r, 0x10)
	If Bits(4) Then r = Bit.Or(r, 0x08)
	If Bits(5) Then r = Bit.Or(r, 0x04)
	If Bits(6) Then r = Bit.Or(r, 0x02)
	If Bits(7) Then r = Bit.Or(r, 0x01)
	
	' Cast back to a single byte
	Return r
End Sub

'----------------------------------------------
' ShiftArrayBytesRight
' Shift all bytes across an array to the right by a specified number of positions.
' Vacated positions at the start are explicitly cleared to 0x00. Returns a new array.
' Parameter:
'	b() - Source Byte Array
'	Positions - Number of byte positions to shift
' Returns:
'	Byte Array - A new shifted byte array
' Example: [0x1A, 0x2B, 0x3C], Positions = 1 > [0x00, 0x1A, 0x2B]
'----------------------------------------------
Public Sub ShiftArrayBytesRight(b() As Byte, Positions As Int) As Byte()
	If b.Length = 0 Or Positions < 0 Then
		Dim EmptyArray(0) As Byte
		Return EmptyArray
	End If

	Dim r(b.Length) As Byte
	
	' Handle absolute fallback if shift exceeds array length
	If Positions >= b.Length Then
		For i = 0 To b.Length - 1
			r(i) = 0x00
		Next
		Return r
	End If
	
	' CRITICAL FIX: Explicitly clear the newly vacated positions at the start
	For i = 0 To Positions - 1
		r(i) = 0x00
	Next
	
	' Copy bytes from source to their new shifted index positions
	For i = 0 To b.Length - 1 - Positions
		r(i + Positions) = b(i)
	Next
	
	Return r
End Sub

'----------------------------------------------
' ShiftArrayBytesLeft
' Shift all bytes across an array to the left by a specified number of positions.
' Vacated positions at the end are explicitly cleared to 0x00. Returns a new array.
' Parameter:
'	b() - Source Byte Array
'	Positions - Number of byte positions to shift
' Returns:
'	Byte Array - A new shifted byte array
' Example: [0x1A, 0x2B, 0x3C], Positions = 1 > [0x2B, 0x3C, 0x00]
'----------------------------------------------
Public Sub ShiftArrayBytesLeft(b() As Byte, Positions As Int) As Byte()
	If b.Length = 0 Or Positions < 0 Then
		Dim EmptyArray(0) As Byte
		Return EmptyArray
	End If

	Dim r(b.Length) As Byte
	
	' Handle absolute fallback if shift exceeds array length
	If Positions >= b.Length Then
		For i = 0 To b.Length - 1
			r(i) = 0x00
		Next
		Return r
	End If
	
	' Copy bytes from source to their new shifted index positions
	For i = Positions To b.Length - 1
		r(i - Positions) = b(i)
	Next
	
	' CRITICAL FIX: Explicitly clear the newly vacated positions at the end
	For i = b.Length - Positions To b.Length - 1
		r(i) = 0x00
	Next
	
	Return r
End Sub

'----------------------------------------------
' ByteArrayCompare
' Compare two byte arrays for exact equality.
' Parameter:
'	b1() - First Byte Array
'	b2() - Second Byte Array
' Returns:
'	Boolean - True if both arrays are identical, otherwise False
' Example: b1=[0x1A, 0x2B], b2=[0x1A, 0x2B] > True
'----------------------------------------------
Public Sub ByteArrayCompare(b1() As Byte, b2() As Byte) As Boolean
	' If lengths don't match, they cannot be identical
	If b1.Length <> b2.Length Then Return False
	
	' Loop through and compare every single byte slot
	For i = 0 To b1.Length - 1
		If b1(i) <> b2(i) Then
			Return False ' Early exit on first mismatch to save CPU cycles
		End If
	Next
	
	' If we reach here, every byte matched perfectly
	Return True
End Sub

#End Region

' ================================================================
' BOOLEAN (BOOL)
' ================================================================
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
' BoolToTrueFalse
' Converts a Boolean value to string "True" or "False".
'----------------------------------------------
Public Sub BoolToTrueFalse(state As Boolean) As String
	If state Then
		Return "True"
	Else
		Return "False"
	End If
End Sub

'----------------------------------------------
' IntToBool
' Convert int to bool.
'----------------------------------------------
Public Sub IntToBool(value As Int) As Boolean
	Return IIf(value == 0, False, True)
End Sub

'----------------------------------------------
' BoolToByte
' Converts a Boolean value to Byte 1 (True) or 0 (False).
'----------------------------------------------
Public Sub BoolToByte(state As Boolean) As Byte
	If state Then
		Return 1
	Else
		Return 0
	End If
End Sub
#End Region

' ================================================================
' INT
' ================================================================
#Region Int
'----------------------------------------------
' TwoBytesToInt
' Convert 2 bytes to signed Int with endian support.
'----------------------------------------------
Public Sub TwoBytesToInt(b() As Byte, littleendian As Boolean) As Int
	If b.Length < 2 Then
		Log("[TwoBytesToInt][E] Expect 2 Bytes")
		Return 0
	End If
	
	Dim hi As Int
	Dim lo As Int
	
	If littleendian Then
		lo = b(0)   ' LSB first
		hi = b(1)
	Else
		hi = b(0)   ' MSB first
		lo = b(1)
	End If
	
	Dim result As Int = Bit.Or(Bit.ShiftLeft(Bit.And(hi, 0xFF), 8), Bit.And(lo, 0xFF))
	
	' signed conversion
	If result > 32767 Then result = result - 65536
	
	Return result
End Sub
#End Region

' ================================================================
' UINT
' ================================================================
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
	If b == Null Or b.Length <> 2 Then Return 0
	Return Bit.Or(Bit.And(b(0), 0xFF), Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
End Sub

'----------------------------------------------
' TwoBytesToUInt
' Convert 2 bytes to unsigned Int (0..65535).
'----------------------------------------------
Public Sub TwoBytesToUInt(b() As Byte, littleendian As Boolean) As UInt
	If b.Length < 2 Then
		Log("[TwoBytesToUInt][E] Expect 2 Bytes")
		Return 0
	End If
	
	Dim hi As Int
	Dim lo As Int
	
	If littleendian Then
		lo = b(0)   ' LSB first
		hi = b(1)
	Else
		hi = b(0)   ' MSB first
		lo = b(1)
	End If
	
	Return Bit.Or(Bit.ShiftLeft(Bit.And(hi, 0xFF), 8), Bit.And(lo, 0xFF))
End Sub
'----------------------------------------------
' UIntToHex
' Converts an UInt to HEX string with 2 bytes.
'----------------------------------------------
Public Sub UIntToHex(value As UInt) As String
	Return ByteConv.HexFromBytes(UIntToBytes(value))
End Sub

'----------------------------------------------
' UIntFromString
' Converts a string to an unsigned 16-bit integer (UInt).
'----------------------------------------------
Public Sub UIntFromString(s() As Byte) As UInt
	Dim str As String = ByteConv.StringFromBytes(s)
	If IsNumber(str) = False Then Return 0
	Dim result As UInt = str
	Return result
End Sub
#End Region

' ================================================================
' ULONG
' ================================================================
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
	If b == Null Or b.Length <> 4 Then Return 0
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

'----------------------------------------------
' ULongFromString
' Converts a string to an unsigned 32-bit long (ULong).
'----------------------------------------------
Public Sub ULongFromString(s() As Byte) As UInt
	If s == Null Or s.Length == 0 Then Return 0
	Dim value As ULong = ByteConv.StringFromBytes(s)
	Return value
End Sub
#End Region

' ================================================================
' FLOAT
' ================================================================
#Region Float
'----------------------------------------------
' FloatToBytes
' Convert Float (4 bytes, IEEE-754) to bytes.
' Note The endianness of a floating-point number is generally determined by the processor architecture.
 ' This means use ReverseBytes(b) to change endian.
'----------------------------------------------
Public Sub FloatToBytes(f As Float) As Byte()
	Dim b(4) As Byte = ByteConv.DoublesToBytes(Array As Double(f))
	Return b
End Sub

'----------------------------------------------
' BytesToFloat
' Convert bytes to Float (IEEE-754)
'----------------------------------------------
Public Sub BytesToFloat(b() As Byte) As Float
	Dim d() As Double = ByteConv.DoublesFromBytes(b)
	If d.Length > 0 Then
		Return d(0)
	Else
		Return -1
	End If
End Sub

'----------------------------------------------
' Convert 2 bytes to scaled float (example: 0.1°C units)
'----------------------------------------------
Public Sub BytesToFloatScaled(b() As Byte, fractions As Byte) As Float
	Dim f As Float = BytesToFloat(b)
	Return Round(f * 10.0)/10.0

'	Dim f As Float = BytesToFloat(b)
'	' Scale
'	Dim s As String = NumberFormat(f, 0, fractions)
'	' Cast
'	f = s
'	Return f
End Sub
#End Region

' ================================================================
' BIN
' ================================================================
#Region Bin
'----------------------------------------------
' ByteToBin
' Convert any byte (0–255) to an 8-bit binary string.
'----------------------------------------------
Public Sub ByteToBin(b As Byte) As Byte()
	Dim bits(8) As Byte
	For i = 0 To 7
		bits(i) = 48 + Bit.And(Bit.ShiftRight(b, 7 - i), 1)  ' Ascii '0' = 48
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
			bits(j * 8 + i) = 48 + Bit.And(Bit.ShiftRight(b, 7 - i), 1)  ' Ascii '0' = 48
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
		bits(i) = 48 + Bit.And(Bit.ShiftRight(nibble, 3 - i), 1)  ' Ascii '0' = 48
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

' ================================================================
' BCD
' ================================================================
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
		' 48 + Bit converts 0/1 To Ascii '0'/'1'
		bits(i) = 48 + Bit.And(Bit.ShiftRight(bcd, 7 - i), 1)  ' Ascii '0' = 48
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

' ================================================================
' CHECKSUM
' ================================================================
#Region Checksum
'----------------------------------------------
' XORChecksum: returns XOR of all bytes
'----------------------------------------------

' XORChecksum
' XOR accumulation with initialization (0) and byte-wise operation
Public Sub XORChecksum(b() As Byte) As Byte
	Dim c As Byte = 0
	For i = 0 To b.Length - 1
		c = Bit.Xor(c, b(i))
	Next
	Return c
End Sub

' AppendXORChecksum
' Calculates XOR and returns the final byte array with checksum as last byte
Public Sub AppendXORChecksum(Frame() As Byte) As Byte()
	Dim out(Frame.Length + 1) As Byte
   	Dim checksum As Byte = XORChecksum(Frame)
	For i = 0 To Frame.Length - 1
		out(i) = Frame(i)
	Next
	out(Frame.Length) = checksum
   	Return out
End Sub
#End Region

' ================================================================
' ENDIANNESS
' ================================================================
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
	If b.Length <> 2 Then Return 0
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
	If b.Length <> 4 Then Return 0
	Dim result As ULong = 0
	result = Bit.Or(result, Bit.And(b(0), 0xFF))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(2), 0xFF), 16))
	result = Bit.Or(result, Bit.ShiftLeft(Bit.And(b(3), 0xFF), 24))
	Return result
End Sub
#End Region

' ================================================================
' STRING
' ================================================================
#Region String
'----------------------------------------------
' StringTrim
' Removes leading and trailing spaces (Ascii 32) and tabs (Ascii 9) from a string.
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
' Ascii codes:
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
' Converts all lowercase Ascii letters (a–z) in a string to uppercase.
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
' Converts all uppercase Ascii letters (A–Z) in a string to lowercase.
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
' Compares two strings for equality ignoring Ascii case.
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
' Convert buffer containing Ascii digits to an integer
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

' ================================================================
' MODBUSCRC16
' ================================================================
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

' ================================================================
' BITWISE
' ================================================================
#Region BitWise
'----------------------------------------------
' GetBit
' Tests if a bit at the given index in a byte is set.
' Bit 0 is the Least Significant Bit (LSB, 0x01), Bit 7 is the MSB (0x80).
' Parameter:
'	b - Input byte value.
' 	index - Bit index (0–7).
' Returns:
'	True if the bit is set, otherwise False.
' Example: GetBit(8, 3) > True
'----------------------------------------------
Public Sub GetBit(b As Byte, index As Int) As Boolean
	' Guard against invalid indices
	If index < 0 Or index > 7 Then Return False
	
	' Using an Int wrapper prevents signed byte overflow at index 7
	Dim mask As Int = Bit.ShiftLeft(1, index)
	Return Bit.And(b, mask) <> 0
End Sub

' TestBit
' Alias for GetBit
Public Sub TestBit(b As Byte, index As Int) As Boolean
	Return GetBit(b, index)
End Sub

'----------------------------------------------
' SetBit
' Sets a specific bit index in a byte to HIGH (1).
' Parameter:
'	b - Input byte value.
' 	index - Bit index (0–7).
' Returns:
'	Byte - The modified byte value.
' Example: SetBit(0x00, 3) > 0x08 (00001000)
'----------------------------------------------
Public Sub SetBit(b As Byte, index As Int) As Byte
	If index < 0 Or index > 7 Then Return b
	Return Bit.Or(b, Bit.ShiftLeft(1, index))
End Sub

'----------------------------------------------
' ClearBit
' Clears a specific bit index in a byte to LOW (0).
' Parameter:
'	b - Input byte value.
' 	index - Bit index (0–7).
' Returns:
'	Byte - The modified byte value.
' Example: ClearBit(0x0F, 3) > 0x07 (00000111)
'----------------------------------------------
Public Sub ClearBit(b As Byte, index As Int) As Byte
	If index < 0 Or index > 7 Then Return b
	Dim mask As Int = Bit.Not(Bit.ShiftLeft(1, index))
	Return Bit.And(b, mask)
End Sub

'----------------------------------------------
' ToggleBit
' Toggles (flips) a specific bit index in a byte.
' Parameter:
'	b - Input byte value.
' 	index - Bit index (0–7).
' Returns:
'	Byte - The modified byte value.
' Example: ToggleBit(0x00, 3) > 0x08, ToggleBit(0x08, 3) > 0x00
'----------------------------------------------
Public Sub ToggleBit(b As Byte, index As Int) As Byte
	If index < 0 Or index > 7 Then Return b
	Return Bit.Xor(b, Bit.ShiftLeft(1, index))
End Sub

'----------------------------------------------
' ByteToBitsString (same as ByteToBin)
' Converts a single byte to an 8-character binary string.
' Parameter:
'	b - Byte
' Returns: 
'	"01010101" representation of the byte.
' Example: ByteToBitsString(170) > "10101010"
'----------------------------------------------
Public Sub ByteToBitsString(b As Byte) As Byte()
	Return ByteToBin(b)
End Sub

'----------------------------------------------
' BytesToBitsString
' Converts a byte array to a binary string representation.
' Each byte is represented by 8 bits in "01010101" format.
' Parameter:
'	bytes() - Array of bytes
' Returns: 
'	byte() - Byte array holding concatenated binary string of all bits.
' Example: BytesToBitsString(Array As Byte(5,170)) > "0000010110101010"
'----------------------------------------------
Public Sub BytesToBitsString(bytes() As Byte) As Byte()
	Return BytesToBin(bytes)
End Sub

'----------------------------------------------
' GetBitIndices
' Get the positions (0 to 7) of all bits that are either HIGH or LOW.
' Bit 0 is the Least Significant Bit (LSB, 0x01), Bit 7 is the MSB (0x80).
' Parameter:
'	Value - The byte to scan
'	SearchHigh - True to get indices of HIGH bits (1), False for LOW bits (0)
' Returns:
'	Byte Array matching the exact count of found bits
' Example: Value = 0x64 (Bits 2, 5, 6 are HIGH), SearchHigh = True > [2, 5, 6]
'----------------------------------------------
Public Sub GetBitIndices(Value As Byte, SearchHigh As Boolean) As Byte()
	' Pass 1: Count how many bits match the target state to size our array
	Dim Count As Int = 0
	Dim Mask As Int = 1
	For i = 0 To 7
		Dim IsHigh As Boolean = (Bit.And(Value, Mask) <> 0)
		If IsHigh = SearchHigh Then
			Count = Count + 1
		End If
		Mask = Mask * 2 ' Move to the next bit position (0x01 -> 0x02 -> 0x04...)
	Next
	
	' Allocate the exact target array size required for B4R stability
	Dim r(Count) As Byte
	Dim TargetIdx As Int = 0
	
	' Pass 2: Populate the array with the matching bit indices
	Mask = 1
	For i = 0 To 7
		Dim IsHigh As Boolean = (Bit.And(Value, Mask) <> 0)
		If IsHigh = SearchHigh Then
			r(TargetIdx) = i
			TargetIdx = TargetIdx + 1
		End If
		Mask = Mask * 2
	Next
	
	Return r
End Sub

'----------------------------------------------
' SetBitIndices
' Create a single byte by setting specific bit positions to HIGH (1).
' Bit 0 is the Least Significant Bit (LSB, 0x01), Bit 7 is the MSB (0x80).
' Parameter:
'	Indices() - Byte Array containing positions to set (0 to 7)
' Returns:
'	Byte - The calculated byte value
' Example: Indices = [2, 5, 6] > 0x64 (01100100)
'----------------------------------------------
Public Sub SetBitIndices(Indices() As Byte) As Byte
	' Return 0x00 early if the input array is empty
	If Indices.Length = 0 Then Return 0x00
	
	Dim r As Int = 0
	
	' Loop through each index and mask it into the result
	For i = 0 To Indices.Length - 1
		Dim Idx As Byte = Indices(i)
		
		' Explicit safety bounds for microcontroller stability
		If Idx >= 0 And Idx <= 7 Then
			' Bit.ShiftLeft(1, Idx) creates the exact mask (e.g. Idx 2 -> 0x04)
			r = Bit.Or(r, Bit.ShiftLeft(1, Idx))
		End If
	Next
	
	Return r
End Sub

'----------------------------------------------
' CountActiveBits
' Count how many bits inside a byte are set to HIGH or LOW.
' Also known as the Hamming weight or population count.
' Parameter:
'	Value - The byte to analyze
'	SearchHigh - True to count HIGH bits (1), False to count LOW bits (0)
' Returns:
'	Int - The total number of matching bits (0 to 8)
' Example: Value = 0x81 (10000001), SearchHigh = True > 2
'----------------------------------------------
Public Sub CountActiveBits(Value As Byte, SearchHigh As Boolean) As Int
	Dim Count As Int = 0
	Dim Mask As Int = 1
	
	' Loop through all 8 bits
	For i = 0 To 7
		Dim IsHigh As Boolean = (Bit.And(Value, Mask) <> 0)
		If IsHigh = SearchHigh Then
			Count = Count + 1
		End If
		Mask = Mask * 2 ' Fast bit-shift via multiplication
	Next
	
	Return Count
End Sub

'----------------------------------------------
' ClearBitIndices
' Create a single byte where specified bit positions are cleared to LOW (0).
' All other bit positions remain HIGH (1).
' Bit 0 is the Least Significant Bit (LSB, 0x01), Bit 7 is the MSB (0x80).
' Parameter:
'	Indices() - Byte Array containing positions to clear (0 to 7)
' Returns:
'	Byte - The calculated byte value (returns 0xFF if input array is empty)
' Example: Indices = > 0x9B (10011011)
'----------------------------------------------
Public Sub ClearBitIndices(Indices() As Byte) As Byte
	' Return 0xFF (all bits high) early if the input array is empty
	If Indices.Length = 0 Then Return 0xFF
	
	' Start with all bits set to 1
	Dim r As Int = 0xFF
	
	' Loop through each index and clear it from the result
	For i = 0 To Indices.Length - 1
		Dim Idx As Byte = Indices(i)
		
		' Explicit safety bounds for microcontroller stability
		If Idx >= 0 And Idx <= 7 Then
			' Shift 1 to the index position to create a target mask
			Dim Mask As Int = Bit.ShiftLeft(1, Idx)
			' Invert the mask so the target bit becomes 0 and all others become 1
			Dim InvertedMask As Int = Bit.Not(Mask)
			' Apply via bitwise AND to force the target bit to 0
			r = Bit.And(r, InvertedMask)
		End If
	Next
	
	Return r
End Sub

' Notes for clarity using example clearing bits 2,5,6:
' 1. The Starting Point
' Set all bits set To HIGH (1):
' Binary: 1 1 1 1 1 1 1 1 (Decimal: 255)
' 2. Clearing the Indices
' Count positions from right to left (Bit 0 To Bit 7):
'							7 6 5 4 3 2 1 0
' Clear Bit 2 (value 4):	1 1 1 1 1 0 1 1
' Clear Bit 5 (value 32):	1 1 0 1 1 0 1 1
' Clear Bit 6 (value 64):	1 0 0 1 1 0 1 1
' 3. Calculating the Final Value
' Check remaining active bits in 10011011:
' Bit 7 (128),Bit 4 (16),Bit 3 (8),Bit 1 (2),Bit 0 (1)
' 128 + 16 + 8 + 2 + 1 = 155 DEC, 98 HEX

'----------------------------------------------
' ShiftArrayBitsLeft
' Shift all bits across a whole byte array to the left by 1 bit position.
' Vacated bit at the end becomes 0. Returns a new array.
' Parameter:
'	b() - Source Byte Array
' Returns:
'	Byte Array - A new shifted byte array
' Example: [0x80, 0x01] shifted left becomes [0x00, 0x02]
'----------------------------------------------
Public Sub ShiftArrayBitsLeft(b() As Byte) As Byte()
	' Handle empty input gracefully
	If b.Length = 0 Then
		Dim EmptyArray(0) As Byte
		Return EmptyArray
	End If

	' Create a completely new target array to protect original memory
	Dim r(b.Length) As Byte
	Dim Carry As Int = 0
	
	' Process from the last byte down to the first byte
	For i = b.Length - 1 To 0 Step -1
		Dim CurrentByte As Int = b(i)
		
		' Save the bit that will overflow into the next byte (MSB)
		Dim NextCarry As Int = 0
		If Bit.And(CurrentByte, 0x80) <> 0 Then NextCarry = 1
		
		' Shift and merge the carry into the new array buffer
		Dim Shifted As Int = Bit.ShiftLeft(CurrentByte, 1)
		r(i) = Bit.Or(Shifted, Carry)
		
		Carry = NextCarry
	Next
	
	Return r
End Sub

'----------------------------------------------
' ShiftArrayBitsRight
' Shift all bits across a whole byte array to the right by 1 bit position.
' Vacated bit at the start becomes 0. Returns a new array.
' Parameter:
'	b() - Source Byte Array
' Returns:
'	Byte Array - A new shifted byte array
' Example: [0x01, 0x80] shifted right becomes [0x00, 0xC0]
'----------------------------------------------
Public Sub ShiftArrayBitsRight(b() As Byte) As Byte()
	' Handle empty input gracefully
	If b.Length = 0 Then
		Dim EmptyArray(0) As Byte
		Return EmptyArray
	End If

	' Create a completely new target array to protect original memory
	Dim r(b.Length) As Byte
	Dim Carry As Int = 0
	
	' Process from the first byte up to the last byte
	For i = 0 To b.Length - 1
		Dim CurrentByte As Int = b(i)
		
		' Save the bit that will overflow into the next byte (LSB)
		Dim NextCarry As Int = 0
		If Bit.And(CurrentByte, 0x01) <> 0 Then NextCarry = 0x80
		
		' Shift right, clean sign extension, and merge carry into the new buffer
		Dim Shifted As Int = Bit.And(Bit.ShiftRight(CurrentByte, 1), 0x7F)
		r(i) = Bit.Or(Shifted, Carry)
		
		Carry = NextCarry
	Next
	
	Return r
End Sub
#End Region

'====================================================
' CSVPARSING
'====================================================
#Region CSV Parsing Utilities
' Notes
' - No Pointer Slicing: It scans the original array element by element via buffer(i), avoiding the unaligned internal windows created by ByteConv.Split.
' - 32-Bit Alignment Bound: Passing the output through SafeCheckValue ensures the substring is cleanly copied to a fresh, perfectly word-aligned 4-byte segment in RAM.
' - AVR-Safe Null Prevention: Returning Dim errArray(0) As Int prevents accidental null pointer dereferences on older platforms like the Uno R3 or Arduino Mega.

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
' and validates empty fields.
'----------------------------------------------
Public Sub CSVCheckValue(item() As Byte, index As Int, tag As String) As String
	Dim str As String = ByteConv.StringFromBytes(item)
	' Log("[Convert.CSVCheckValue] string=", str)

	Dim cleanstr As String = StringTrim(str)
	' Log("[Convert.CSVCheckValue] stringtrim=", cleanstr)

	If cleanstr.Length = 0 Then
		If SplitAllowEmptyAsZero Then
			Return "0"
		Else
			Log("[", tag, "][E] Empty item at index ", index, " not allowed.")
			Return ""
		End If
	End If
	Return cleanstr
End Sub

' CSVGetItem
' Get an items from the CSV string at position n (1-numer of items)
Public Sub CSVGetItem(s() As Byte, sep As String, n As Int) As Byte()
	Dim bc As ByteConverter
	Dim sepBytes() As Byte = sep.GetBytes
	Dim slength As Int = sepBytes.Length
	
	Dim lastk As Int = 0
	Dim k As Int = -1
	
	' Loop up to n-1 to find the start pointer of our item
	For j = 1 To n
		' Find where the current item ends
		k = bc.IndexOf2(s, sepBytes, lastk)
		
		' If we reached our target field index (n)
		If j = n Then
			' If no trailing separator exists, the item ends at the absolute end of the buffer
			If k = -1 Then k = s.Length
			
			' Extract the raw sliced block securely into word-aligned bounds
			Dim rawCell() As Byte = bc.SubString2(s, lastk, k)
			If rawCell.Length > 0 Then
				' Perform an inline safe byte trim operation
				Return TrimByteArray(rawCell)
			Else
				' rawCell = Array As Byte(0x30)
			End If
		End If
		
		' If we hit the end of the string before reaching item 'n', it's not available
		If k = -1 Then Exit
		
		' Advance start index past the separator token
		lastk = k + slength
	Next
	
	Return "n/a"
End Sub

' TrimByteArray
' Helper Fast byte-level trimmer to keep safe from string/pointer crashes
Private Sub TrimByteArray(b() As Byte) As Byte()
	Dim bc As ByteConverter
	Dim startIndex As Int = 0
	Dim endIndex As Int = b.Length - 1

	' Skip leading spaces and tabs
	Do While startIndex <= endIndex And (b(startIndex) = 32 Or b(startIndex) = 9)
		startIndex = startIndex + 1
	Loop

	' Skip trailing spaces, tabs, carriage returns, and line feeds
	Do While endIndex >= startIndex And (b(endIndex) = 32 Or b(endIndex) = 9 Or b(endIndex) = 13 Or b(endIndex) = 10)
		endIndex = endIndex - 1
	Loop

	' Guard: If the item was empty or only contained whitespace, return empty array
	If startIndex > endIndex Then
		Dim empty(0) As Byte
		Return empty
	End If

	' Returns a perfectly memory-aligned slice copy
	Return bc.SubString2(b, startIndex, endIndex + 1)
End Sub

'----------------------------------------------
' CSVToBytes
' Converts CSV to Byte() array.
'----------------------------------------------
Public Sub CSVToBytes(buffer() As Byte, separator As String) As Byte()
	Dim count As Int = CSVCountItems(buffer, separator)
	Log("[CSVToBytes] buffer=", ByteConv.StringFromBytes(buffer), " count=", count)

	CSVParserResult = True

	If count = 0 Then
		Dim failureResult(1) As Byte = Array As Byte(0xFF)
		CSVParserResult = False
		Return failureResult
	End If
	
	Dim result(count) As Byte

	For i = 1 To count
		Dim item() As Byte = CSVGetItem(buffer, separator, i)
		' Check if the parsed field is completely empty
		If item.Length = 0 Then
			If SplitAllowEmptyAsZero Then
				result(i - 1) = 0
				Continue ' Proceed to the next field
			Else
				Log("[CSVToBytes][E] Empty item at index ", i, " not allowed.")
				CSVParserResult = False
				Return result
			End If
		End If

		Dim itemStr As String = ByteConv.StringFromBytes(item)
		
		If IsNumber(itemStr) Then
			Dim parsedNum As Int = itemStr
			If parsedNum < BYTE_MIN Or parsedNum > BYTE_MAX Then
				Log("[CSVToBytes][E] Item at index ", i, " (value: ", parsedNum, ") out of range.")
				CSVParserResult = False
				Return result
			End If
			result(i - 1) = parsedNum
		Else
			Log("[CSVToBytes][E] Item at index ", i, " is not a number.")
			CSVParserResult = False
			Return result
		End If
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToInts
' Converts CSV to Int() array.
'----------------------------------------------
Public Sub CSVToInts(buffer() As Byte, separator As String) As Int()
	Dim count As Int = CSVCountItems(buffer, separator)
	CSVParserResult = True

	If count = 0 Then
		Dim failureResult(1) As Int = Array As Int(0)
		CSVParserResult = False
		Return failureResult
	End If
	
	Dim result(count) As Int

	For i = 1 To count
		Dim item() As Byte = CSVGetItem(buffer, separator, i)
		
		If item.Length = 0 Then
			If SplitAllowEmptyAsZero Then
				result(i - 1) = 0
				Continue
			Else
				Log("[CSVToInts][E] Empty item at index ", i, " not allowed.")
				CSVParserResult = False
				Return result
			End If
		End If

		Dim itemStr As String = ByteConv.StringFromBytes(item)
		
		If IsNumber(itemStr) Then
			Dim parsedNum As Long = itemStr
			If parsedNum < INT16_MIN Or parsedNum > INT16_MAX Then
				Log("[CSVToInts][E] Item at index ", i, " out of range.")
				CSVParserResult = False
				Return result
			End If
			result(i - 1) = parsedNum
		Else
			Log("[CSVToInts][E] Item at index ", i, " is not a number.")
			CSVParserResult = False
			Return result
		End If
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToUInts
' Converts CSV to UInt() array.
'----------------------------------------------
Public Sub CSVToUInts(buffer() As Byte, separator As String) As UInt()
	Dim count As Int = CSVCountItems(buffer, separator)
	CSVParserResult = True

	If count = 0 Then
		Dim failureResult(1) As UInt = Array As UInt(0)
		CSVParserResult = False
		Return failureResult
	End If
	
	Dim result(count) As UInt

	For i = 1 To count
		Dim item() As Byte = CSVGetItem(buffer, separator, i)
		
		If item.Length = 0 Then
			If SplitAllowEmptyAsZero Then
				result(i - 1) = 0
				Continue
			Else
				Log("[CSVToUInts][E] Empty item at index ", i, " not allowed.")
				CSVParserResult = False
				Return result
			End If
		End If

		Dim itemStr As String = ByteConv.StringFromBytes(item)
		
		If IsNumber(itemStr) Then
			Dim parsedNum As Long = itemStr
			If parsedNum < 0 Or parsedNum > UINT16_MAX Then
				Log("[CSVToUInts][E] Item at index ", i, " out of range.")
				CSVParserResult = False
				Return result
			End If
			result(i - 1) = parsedNum
		Else
			Log("[CSVToUInts][E] Item at index ", i, " is not a number.")
			CSVParserResult = False
			Return result
		End If
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToULongs
' Converts CSV to ULong() array.
'----------------------------------------------
Public Sub CSVToULongs(buffer() As Byte, separator As String) As ULong()
	Dim count As Int = CSVCountItems(buffer, separator)
	CSVParserResult = True

	If count = 0 Then
		Dim failureResult(1) As ULong = Array As ULong(0)
		CSVParserResult = False
		Return failureResult
	End If
	
	Dim result(count) As ULong

	For i = 1 To count
		Dim item() As Byte = CSVGetItem(buffer, separator, i)
		
		If item.Length = 0 Then
			If SplitAllowEmptyAsZero Then
				result(i - 1) = 0
				Continue
			Else
				Log("[CSVToULongs][E] Empty item at index ", i, " not allowed.")
				CSVParserResult = False
				Return result
			End If
		End If

		Dim itemStr As String = ByteConv.StringFromBytes(item)
		
		If IsNumber(itemStr) Then
			result(i - 1) = itemStr
		Else
			Log("[CSVToULongs][E] Item at index ", i, " is not a number.")
			CSVParserResult = False
			Return result
		End If
	Next
	Return result
End Sub

'----------------------------------------------
' CSVToFloats
' Converts CSV to Float() array.
'----------------------------------------------
Public Sub CSVToFloats(buffer() As Byte, separator As String) As Float()
	Dim count As Int = CSVCountItems(buffer, separator)
	CSVParserResult = True

	If count = 0 Then
		Dim failureResult(1) As Float = Array As Float(0.0)
		CSVParserResult = False
		Return failureResult
	End If
	
	Dim result(count) As Float

	For i = 1 To count
		Dim item() As Byte = CSVGetItem(buffer, separator, i)
		
		If item.Length = 0 Then
			If SplitAllowEmptyAsZero Then
				result(i - 1) = 0.0
				Continue
			Else
				Log("[CSVToFloats][E] Empty item at index ", i, " not allowed.")
				CSVParserResult = False
				Return result
			End If
		End If

		Dim itemStr As String = ByteConv.StringFromBytes(item)
		
		If IsNumber(itemStr) Then
			result(i - 1) = itemStr
		Else
			Log("[CSVToFloats][E] Item at index ", i, " is not a number.")
			CSVParserResult = False
			Return result
		End If
	Next
	Return result
End Sub
#End Region

'====================================================
' Color Conversions
'====================================================
#Region Color Conversions
'----------------------------------------------
' RGBToColor
' Convert RGB colors 0-255 to ULong.
' Parameter:
'	r - Red 0-255
'	g - Green 0-255
'	b - Blue 0-255
' Returns:
'	Color ULong
'----------------------------------------------
Public Sub RGBToColor(r As Byte, g As Byte, b As Byte) As ULong
	Return Bit.Or(Bit.ShiftLeft(r, 16), Bit.Or(Bit.ShiftLeft(g, 8), b))
End Sub

'----------------------------------------------
' ColorToRGB
' Convert color ULong to Byte Array (length 3) with RGB colors 0-255.
' Parameter:
'	color - Value ULong
' Returns:
'	Byte Array (length 3) with RGB colors 0-255.
'----------------------------------------------
Public Sub ColorToRGB(color As ULong) As Byte()
	Dim rgb(3) As Byte
	rgb(0) = Bit.And(Bit.ShiftRight(color, 16), 0xFF)
	rgb(1) = Bit.And(Bit.ShiftRight(color, 8), 0xFF)
	rgb(2) = Bit.And(color, 0xFF)
	Return rgb
End Sub
#End Region

'====================================================
' MISC CONVERSIONS AND UTILITIES
'====================================================
#Region Misc
'----------------------------------------------
' MillisToTimeString
' Convert milliseconds to hh:mm:ss string
' Parameter:
'	ms - Milliseconds
' Returns: String hh:mm:ss
'----------------------------------------------
Public Sub MillisToTimeString(ms As Long) As String
	Dim totalSec	As Long = ms / 1000
	Dim hours 		As Int = totalSec / 3600
	Dim minutes 	As Int = (totalSec Mod 3600) / 60
	Dim seconds 	As Int = totalSec Mod 60

	' hh:mm:ss -> always 8 chars
	Dim b(8) As Byte				' byte range 0-7 for 8 bytes

	' Hours
	b(0) = 48 + hours / 10      	' tens digit
	b(1) = 48 + hours Mod 10    	' units digit
	b(2) = 58                    	' colon ":"

	' Minutes
	b(3) = 48 + minutes / 10
	b(4) = 48 + minutes Mod 10
	b(5) = 58

	' Seconds
	b(6) = 48 + seconds / 10
	b(7) = 48 + seconds Mod 10

	' Convert byte array to string
	Return ByteConv.StringFromBytes(b)
End Sub

'----------------------------------------------
' DirectionToString
' Convert direction given as byte to uppercase string.
' Parameters
' 	direction: Byte  0=right, 1=left, 2=up, 3=down
' Returns: String Direction RIGHT, LEFT, UP, DOWN or empty
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

' ================================================================
' D64
' ================================================================
#Region D64
'====================================================
' D64 - ESP32 64-bit data type only
' ESP32 - a double is a true 64-Bit IEEE 754 precision floating-point number And is exactly 8 bytes long (unlike 8-Bit AVR Arduinos where double is only 4 bytes).
' Endianness: The ESP32 uses Little-Endian. The least significant byte is stored at the lowest memory address (byteArray[0]). 
' If receiving device Or protocol expects Big-Endian, ensure To reverse the Array order before sending.
' Note on Math Precision:
' Because B4R processes standard inline calculations (like Millis + 10000) through a temporary 32-bit single-precision layer, notice tiny rounding 
' steps (e.g., a difference of 9984 instead of exactly 10000). 
' This is a normal characteristic of B4R's core variable handling and is OK for time tracking!
'====================================================

#If ESP32

' D64Millis
' Gets the absolute Unix time epoch in milliseconds as a Double.
' Perfect for high-precision time tracking and native B4R math.
' Fetches the absolute Unix time epoch in milliseconds as a Double
' Parameter:
'	None
' Returns:
'	Double
Public Sub D64Millis() As Double
	RunNative("D64Millis", Null)
	Return D64Val
End Sub

' D64ToBytes
' Extracts the raw 8-byte layout of an ESP32 double into the global 8-byte array D64Buffer
' Parameter:
'	Value - Double
' Returns:
'	Global var D64Buffer(8) As Byte
Public Sub D64ToBytes(Value As Double) As Byte()
	RunNative("D64ToBytes", Value)
	Return D64Buffer
End Sub

' D64ToHex
' Convert the 64-bit double to a 16-character HEX string (with option to reverse as Big-Endian)
' Parameter:
'    Value - Double
'    BigEndian - True to reverse the byte-order
' Returns:
'    String - 16-character HEX
Public Sub D64ToHex(Value As Double, BigEndian As Boolean) As String
	RunNative("D64ToBytes", Value)
	If BigEndian Then
		Return ByteConv.HexFromBytes(ReverseBytes(D64Buffer))
	Else
		Return ByteConv.HexFromBytes(D64Buffer)
	End If
End Sub

' D64ToString
' Extracts the raw 8-byte layout of an ESP32 double into the global array D64String
' Parameter:
'	Value - Double
' Returns:
'	Global var D64String(16) As Byte
Public Sub D64ToString(Value As Double) As Byte()
	RunNative("D64ToString", Value)
	Return D64String
End Sub
#End Region

'----------------------------------------------
' D64 INLINE C ESP32
'----------------------------------------------
#If C

// Convert time millis to global b4r double 64-bit as long long integer
void D64Millis(B4R::Object* args) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    
    // Calculate 64-bit milliseconds
	// tv.tv_sec is a real 64-bit integer (time_t)
	// It is casted to a int64_t and then multiply by 1000LL (a literal 64-bit Long Long integer).
    int64_t ms = ((int64_t)tv.tv_sec * 1000LL) + ((int64_t)tv.tv_usec / 1000LL);
    
    // Assign the value directly to the global B4R Double variable without wrapper macros
    // Use the lowercase class name variable (see src for reference)
    b4r_convert::_d64val = (double)ms;
}

// Convert double value into global array D64Buffer(8) As Byte
// Argument must be 10-digits (i.e. 1786176213) and NOT 13-digits.
// Example: Double 1786176208896
// Output in Little-Endian order (from Byte 7 down to Byte 0):0x00 0x00 0x01 0x9F 0xE0 0x66 0x00 0x00
// Called via: RunNative("D64ToBytes", MillisNow)
void D64ToBytes(B4R::Object* args) {
    // Extract the double value from the B4R argument wrapper
    double val = args->toDouble();
    
    // Convert the floating-point double into a raw 64-bit integer
    // Use round() here too just in case floating point inaccuracies skewed the value
    int64_t raw_integer = (int64_t)round(val); 
   
    // Copy the 8 bytes of the int64_t directly into the B4R global data buffer
    // This removes the intermediate local array loop entirely
    memcpy(b4r_convert::_d64buffer->data, &raw_integer, sizeof(int64_t));
}

// Convert double value into global array D64String(16) As Byte
// Argument must be 10-digits (i.e. 1786176213) and NOT 13-digits.
// Formats ANY B4R Double into the global text byte array with almost 100% precision
// Called via: RunNative("D64ToString", MillisNow)
void D64ToString(B4R::Object* args) {
	// Cast argument to double
    double val = args->toDouble();
    
    // Round to nearest whole number to ensure floating-point precision stays intact
    int64_t raw_integer = (int64_t)round(val); 
    
    // Format the 64-bit integer directly as a text string using %lld
    char textBuffer[16];
    snprintf(textBuffer, sizeof(textBuffer), "%lld", raw_integer);
    
    // Clear the global B4R array with zeros first to prevent ghost characters
    memset(b4r_convert::_d64string->data, 0, b4r_convert::_d64string->length);
    
    // Copy the text characters straight into the global B4R byte array
    int bytesToCopy = strlen(textBuffer) < b4r_convert::_d64string->length ? 
                      strlen(textBuffer) : b4r_convert::_d64string->length;
    
	// Update the global array               
    memcpy(b4r_convert::_d64string->data, textBuffer, bytesToCopy);
}

// Directly prints the whole number to the serial log
/*
void PrintMillisDouble(B4R::Object* args) {
    double val = args->toDouble();
    Serial.printf("%.0f", val);
}
*/
#End If		// Inline C
#End If 	// ESP32 Conditional
#End Region	// ESP32
