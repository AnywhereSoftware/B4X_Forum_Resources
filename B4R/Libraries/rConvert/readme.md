### rConvert by rwblinn
### 10/04/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**  

---

  
  
**Brief  
rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with microcontrollers, sensors, and communication protocols.  
  
It includes simple methods for converting between:  
- Unsigned integers (UInt, ULong) and byte arrays.  
- Floats and byte arrays (IEEE 754).  
- Numbers and formatted strings.  
- Bytes and hexadecimal strings.  
- Common convenience helpers (e.g. On/Off → Boolean).  
- Endianness, Checksum, BCD, Bin, Modbus, BitWise operations.  
- Constants for numeric ranges with reference table.  
  
The goal is to keep the routines small, efficient, and compatible with B4R’s limitations (no StringBuilder, limited standard libraries, etc.), so you can drop them into any project.  
  
- Developed with B4R 4.00 (64 bit), arduino-cli 1.2.2.  
- Tested with an Arduino UNO.  
  

---

  
**Files**  
The *rConvert.zip* archive contains the library (b4xlib).  
  

---

  
**Install**  
Copy the *rConvert* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
  

---

  
**Example Selected Functions with Log output**  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "*****", CRLF)  
    Log(CRLF, "[Main.AppStart]", CRLF)  
  
    Dim testuint As UInt  
    Dim testulong As ULong  
    Dim testfloat As Float  
    Dim testbyte As Byte  
    Dim testbytes() As Byte  
  
    ' ————————————————————  
    ' UInt > Bytes (2)  
    ' ————————————————————  
    testuint = 10  
    testbytes = Convert.UIntToBytes(testuint)  
    Log("[UIntToBytes] int=", testuint, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [UIntToBytes] int=10, result hex=0A00, length=2  
  
    ' ————————————————————  
    ' Bytes > UInt - Note: byte array must be length 2  
    ' ————————————————————  
    testbytes = Array As Byte(0x0A, 0x00)  
    testuint = Convert.BytesToUInt(testbytes)  
    Log("[BytesToUInt] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testuint)  
    ' [BytesToUInt] bytes=0A00, length=2, uint=10  
  
    ' ————————————————————  
    ' ULong > Bytes (4)  
    ' ————————————————————  
    testulong = 10  
    testbytes = Convert.ULongToBytes(testulong)  
    Log("[ULongToBytes] long=", testulong, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [ULongToBytes] long=10, result hex=0A000000, length=4  
  
    ' ————————————————————  
    ' Bytes > ULong - Note: byte array must be length 4  
    ' ————————————————————  
    testbytes = Array As Byte(0x0A,0x00,0x00,0x00)  
    testulong = Convert.BytesToULong(testbytes)  
    Log("[BytesToULong] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result ulong=", testulong)  
    ' [BytesToULong] bytes=0A000000, length=4, ulong=10  
  
    ' ————————————————————  
    ' ULong > String - Note: casts numeric types through Double formatting.  
    ' ————————————————————  
    Dim teststring As String = testulong  
    Log("[ULongToString Cast] ulong=", testulong, " > result teststring=", teststring)  
    ' [ULongToString Cast] ulong=10, teststring=10.00  
  
    ' ————————————————————  
    ' ULong > String - Note: Uses numberformat  
    ' ————————————————————  
    Dim teststring As String = NumberFormat(testulong, 0, 0)  
    Log("[ULongToString NumberFormat] ulong=", testulong, " > result teststring=", teststring)  
    ' [ULongToString NumberFormat] ulong=10, teststring=10  
  
    ' ————————————————————  
    ' Float to bytes  
    ' ————————————————————  
    testfloat = 18.58  
    testbytes = Convert.FloatToBytes(testfloat)  
    Log("[FloatToBytes] float=", testfloat, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [FloatToBytes] float=18.5800, result hex=D7A39441  
  
    ' ————————————————————  
    ' Two Bytes to Hex  
    ' ————————————————————  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, " > result hex=", Convert.TwoBytesToHex(b1, b2))  
    ' [TwoBytesToHex] b1=10, b2=15, result hex=0A0F  
  
    ' ————————————————————  
    ' BCD  
    ' ————————————————————  
    testbyte = 15  
    Log("[ByteToBCD] byte=",testbyte, " > result hex=0x", Convert.OneByteToHex(Convert.ByteToBCD(testbyte)), ", bin=", Convert.ByteToBCDBin(testbyte))  
    ' [ByteToBCD] byte=15 > result hex=0x15, bin=00010101  
    
    ' ————————————————————  
    ' Bin  
    ' ————————————————————  
    testbyte = 0x43    ' DEC 67  
    Log("[ByteToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.ByteToBin(testbyte))  
    ' [ByteToBin] byte=67, hex=0x43 > result bin=01000011  
  
    testbyte = 0x0A ' DEC 10  
    Log("[NibbleToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.NibbleToBin(testbyte))  
    ' [NibbleToBin] byte=10, hex=0x0A > result bin=1010  
  
    ' ————————————————————  
    ' Boolean  
    ' ————————————————————  
    ' OnOff to Boolean  
    Log("OnOffToBool] on > result ", Convert.OnOffToBool("on"), ", off > result ", Convert.OnOffToBool("off"))  
    ' OnOffToBool] on=1, off=0  
    
    ' ————————————————————  
    ' XORChecksum  
    ' ————————————————————  
    testbytes = Array As Byte(0x0A, 0x0B)  
    testbyte = Convert.XORChecksum(testbytes)  
    Log("[XORChecksum] bytes=", Convert.BytesToHex(testbytes), " > result byte=", Convert.OneByteToHex(testbyte))  
    ' [XORChecksum] bytes=0A0B > result byte=01  
  
    ' ————————————————————  
    ' Swap  
    ' ————————————————————  
    testuint = 23  
    Log("[SwapUInt16] uint=", testuint, " > result uint=", Convert.SwapUInt16(testuint))  
    ' [SwapUInt16] uint=23 > result uint=5888  
  
    testbytes = Convert.SwapUInt16ToBytes(testuint)  
    Log("[SwapUInt16] uint=", testuint, " > result bytes=", Convert.OneByteToHex(testbytes(0)), Convert.OneByteToHex(testbytes(1)))  
    ' [SwapUInt16ToBytes] uint=23 > result bytes=1700  
  
    ' ————————————————————  
    ' ModbusCRC16Test  
    ' Test Modbus RTU CRC16 functions for a frame.  
    ' Example Frame: 01 03 00 00 00 0A  
    ' ModbusCRC16() > returns [low, high] for transmission.  
    ' ModbusCRC16UInt() > numeric CRC For debugging (bytes swapped in 16-Bit value).  
    ' ModbusCRC16TransmittedFrame() > ready-to-send frame.  
    ' ModbusCheckCRC16() > validates a received frame.  
    ' ————————————————————  
    Dim frame() As Byte = Array As Byte(0x01, 0x03, 0x00, 0x00, 0x00, 0x0A)  
    Log("[ModbusCRC16Test] Frame=" , Convert.BytesToHex(frame))  
    
    ' 1) CRC as bytes [low, high]  
    ' ModbusCRC16() returns the CRC in little-endian order: [low, high].  
    ' Low byte = C5, High byte = CD.  
    Dim crcBytes() As Byte = Convert.ModbusCRC16(frame)  
    Log("[ModbusCRC16] CRC bytes [low, high]=", Convert.BytesToHex(crcBytes))  
    
    ' 2) CRC as numeric 16-bit  
    ' ModbusCRC16UInt() converts [low, high] > numeric: (high<<8) | low = 0xCD<<8 | 0xC5 = 0xCDC5 = 52677.  
    ' This is normal: numeric representation swaps the byte order to match usual 16-Bit notation.  
    Dim crcNum As ULong = Convert.ModbusCRC16UInt(frame)  
    Log("[ModbusCRC16UInt] CRC numeric=0x" , Convert.BytesToHex(Array As Byte(Bit.ShiftRight(crcNum, 8), Bit.And(crcNum, 0xFF))), " (decimal=" , crcNum , ")")  
    
    ' 3) Transmitted frame (frame + CRC)  
    ' The transmitted frame sends [low, high]: C5 CD appended after the frame.  
    Dim tx() As Byte = Convert.ModbusCRC16TransmittedFrame(frame)  
    Log("[ModbusCRC16TransmittedFrame] Transmitted frame=" , Convert.BytesToHex(tx))  
    
    ' 4) Check CRC  
    ' Means true, the CRC matches.  
    Dim valid As Boolean = Convert.ModbusCRC16Check(tx)  
    Log("[ModbusCRC16Check] CRC valid (1=true)? " , valid)  
    
    ' ————————————————————  
    ' Bit wise  
    ' ————————————————————  
    ' Note: for the 8 bits 87654321, the bit index is 76543210  
    ' SetBit  
    Dim b As Byte = 0                ' 00000000  
    b = Convert.SetBit(b, 3, True)    ' Set bit 3 >  00001000 (8)  
    Log("[SetBit] Set bit 3 for value 0. result=", b)  
    ' [SetBit] Set bit 3 for value 0. result=8  
    
    b = Convert.SetBit(b, 3, False)    ' Clear bit 3 > 00000000 (0)  
    Log("[SetBit] Clear bit 3 for value 8. result=", b)  
    ' [SetBit] Clear bit 3 for value 8. result=0  
  
    ' ToggleBit  
    Dim b As Byte = 8                ' 00001000  
    b = Convert.ToggleBit(b, 3)        ' Toggle bit 3 > 00000000 (0)  
    Log("[ToggleBit] Toggle bit 3 for value 8. result=", b)  
    ' [ToggleBit] Toggle bit 3 for value 0. result=0  
  
    b = Convert.ToggleBit(b, 1)        ' Toggle bit 1 > 00000010 (2)  
    Log("[ToggleBit] Toggle bit 1 for value 0. result=", b)  
    ' [ToggleBit] Toggle bit 1 for value 0. result=2  
  
    ' GetBit  
    Dim b As Byte = 8                ' 00001000  
    Log("[GetBit] Get bit 3 for value 8=", Convert.GetBit(b, 3))            
    ' [GetBit] Get bit 3 for value 8=1    '1=True (bit 3 is set)  
    
    Log("[GetBit] Get bit 2 for value 8=", Convert.GetBit(b, 2))            
    ' [GetBit] Get bit 2 for value 8=0    '0=False (bit 2 is not set)  
  
    ' ByteToBitsString  
    Dim b As Byte = 170              ' Decimal 170 = 0xAA = 10101010  
    Log("[ByteToBitsString] b=",b, ", bitsstring=", Convert.ByteToBitsString(b))  
    ' [ByteToBitsString] b=170, bitsstring=10101010  
    
    ' BytesToBitsString  
    Dim arr() As Byte = Array As Byte(5, 170)  
    Log("[BytesToBitsString] Byte 1=5 (00000101), byte 2=170 (10101010). result=", Convert.BytesToBitsString(arr))  
    ' [BytesToBitsString] Byte 1=5 (00000101), byte 2=170 (10101010). result=0000010110101010  
End Sub
```

  
  

---

  
  
**Function Index**  

```B4X
– Bytes –  
ByteToBool(bytes) : First byte "1" > True, else False.  
ByteToInt(bytes) : ASCII digit byte "0"-"9" > integer 0–9.  
BytesToHex(bytes) : Byte array > hex string.  
OneByteToHex(byte) : Convert single byte to HEX string.  
TwoBytesToHex(b1,b2) : Convert 2 bytes to HEX string.  
ReverseBytes(b) : Reverse byte order in array.  
  
– Bool –  
BoolToString(state) : True > "1", False > "0".  
BoolToOnOff(state) : True > "ON", False > "OFF".  
OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.  
IntToBool(value) : Convert int to bool.  
  
– UInt –  
UIntToBytes(value) : 16-bit unsigned > little-endian bytes.  
BytesToUInt(b) : Little-endian 2 bytes > unsigned 16-bit.  
UIntToHex(value) : Converts an UInt to HEX string with 2 bytes.  
  
– ULong –  
ULongToBytes(value) : 32-bit unsigned > little-endian bytes.  
BytesToULong(b) : Little-endian 4 bytes > unsigned 32-bit.  
ULongToHex(value) : Converts an ULong to HEX string with 4 bytes.  
  
– Float –  
FloatToBytes(value) : 32-bit float > little-endian bytes.  
BytesToFloat(b) : Little-endian 4 bytes > 32-bit float.  
   
– Bin –  
ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.  
BytesToBin(b()) : Converts a byte array to a binary string representation.  
NibbleToBin(nibble) : Convert 0–15 nibble > "xxxx" binary string.  
  
– BCD –  
ByteToBCD(value) : Decimal 0–99 > single-byte BCD.  
ByteToBCDBin(value) : Decimal 0–99 > BCD > binary string.  
BCDToByte(b) : Single-byte BCD > decimal 0–99.  
UIntToBCDArray(value) : UInt 0–9999 > 2-byte BCD array.  
BCDArrayToUInt(b) : 2-byte BCD array > integer 0–9999.  
  
– Checksum –  
XORChecksum(b) : XOR of all bytes.  
  
– Endianness –  
SwapUInt16(value) : Swap 2-byte unsigned integer.  
SwapUInt32(value) : Swap 4-byte unsigned integer.  
SwapUInt16ToBytes(value) : UInt16 > reversed 2-byte array.  
BytesToUInt16Swapped(b) : Reversed 2-byte array > UInt16.  
SwapUInt32ToBytes(value) : UInt32 > reversed 4-byte array.  
BytesToUInt32Swapped(b) : Reversed 4-byte array > UInt32.  
  
– String –  
StringTrim(s) : Trim spaces/tabs from both ends.  
ToUpperCase(s) : ASCII lowercase > uppercase.  
ToLowerCase(s) : ASCII uppercase > lowercase.  
EqualsIgnoreCase(s1,s2) : Compare ignoring ASCII case.  
ReplaceString(orig,search,repl) : Replace all occurrences in byte array.  
GetSplitCount(buffer) : Get number of items from CSV string.  
AsciiBufferToInt(buffer) : Convert buffer containing ASCII digits to an integer.  
  
– Modbus CRC-16 –  
ModbusCRC16(frame) : Calculate CRC16 (Modbus RTU) and return as 2-byte array in little-endian order: [low byte, high byte].  
ModbusCRC16UInt(frame) : Calculate CRC16 (Modbus RTU) and return as numeric 16-bit value [high byte, low byte].  
ModbusCRC16TransmittedFrame(frame) : Append CRC16 to the end of a frame (low byte first, high byte second).  
ModbusCheckCRC16 : Validate that a frame ends with the correct Modbus CRC.  
ModbusCRC16Test(frame) : Test the Modbus CRC16 functions for a frame.  
  
– BitWise —  
SetBit(b, index, on) : Sets or clears a bit in a byte at the given index.  
ToggleBit(b, index) : Flips (toggles) a bit in a byte at the given index.  
GetBit(b, index) : Tests if a bit at the given index in a byte is set.  
ByteToBitsString(b) : Converts a single byte to an 8-character binary string (same as ByteToBin).  
BytesToBitsString)b()) : Converts a byte array to a binary string representation (same as BytesToBin).
```

  
  

---

  
  
**Licence**  
MIT.