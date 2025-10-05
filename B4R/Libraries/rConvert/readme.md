### rConvert by rwblinn
### 10/01/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**   

---

  
  
**Brief**   
**rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with microcontrollers, sensors, and communication protocols.   
  
It includes simple methods for converting between:   
- Unsigned integers (UInt, ULong) and byte arrays   
- Floats and byte arrays (IEEE 754)   
- Numbers and formatted strings   
- Bytes and hexadecimal strings   
- Common convenience helpers (e.g. On/Off → Boolean)  
- Constants for numeric ranges with reference table.  
- Endianness, Checksum, BCD, Bin.  
  
The goal is to keep the routines small, efficient, and compatible with B4R’s limitations (no StringBuilder, limited standard libraries, etc.), so you can drop them into any project.   
  

---

  
**Files**  
The *rConvert.zip* archive contains the library (b4xlib).  
  

---

  
**Install**  
Copy the *rConvert* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
  

---

  
**Example Selected Functions**  

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
  
    ' UInt > Bytes (2)  
    testuint = 10  
    testbytes = Convert.UIntToBytes(testuint)  
    Log("[UIntToBytes] int=", testuint, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [UIntToBytes] int=10, result hex=0A00, length=2  
  
    ' Bytes > UInt Note: byte array must be length 2  
    testbytes = Array As Byte(0x0A, 0x00)  
    testuint = Convert.BytesToUInt(testbytes)  
    Log("[BytesToUInt] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testuint)  
    ' [BytesToUInt] bytes=0A00, length=2, uint=10  
  
    ' ULong > Bytes (4)  
    testulong = 10  
    testbytes = Convert.ULongToBytes(testulong)  
    Log("[ULongToBytes] long=", testulong, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [ULongToBytes] long=10, result hex=0A000000, length=4  
  
    ' Bytes > ULong Note: byte array must be length 4  
    testbytes = Array As Byte(0x0A,0x00,0x00,0x00)  
    testulong = Convert.BytesToULong(testbytes)  
    Log("[BytesToULong] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result ulong=", testulong)  
    ' [BytesToULong] bytes=0A000000, length=4, ulong=10  
  
    ' ULong > String Note: casts numeric types through Double formatting.  
    Dim teststring As String = testulong  
    Log("[ULongToString Cast] ulong=", testulong, " > result teststring=", teststring)  
    ' [ULongToString Cast] ulong=10, teststring=10.00  
  
    ' ULong > String Note: Uses numberformat  
    Dim teststring As String = NumberFormat(testulong, 0, 0)  
    Log("[ULongToString NumberFormat] ulong=", testulong, " > result teststring=", teststring)  
    ' [ULongToString NumberFormat] ulong=10, teststring=10  
  
    ' Float to bytes  
    testfloat = 18.58  
    testbytes = Convert.FloatToBytes(testfloat)  
    Log("[FloatToBytes] float=", testfloat, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [FloatToBytes] float=18.5800, result hex=D7A39441  
  
    ' Two Bytes to Hex  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, " > result hex=", Convert.TwoBytesToHex(b1, b2))  
    ' [TwoBytesToHex] b1=10, b2=15, result hex=0A0F  
  
    ' BCD  
    testbyte = 15  
    Log("[ByteToBCD] byte=",testbyte, " > result hex=0x", Convert.OneByteToHex(Convert.ByteToBCD(testbyte)), ", bin=", Convert.ByteToBCDBin(testbyte))  
    ' [ByteToBCD] byte=15 > result hex=0x15, bin=00010101  
     
    ' Bin  
    testbyte = 0x43    ' DEC 67  
    Log("[ByteToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.ByteToBin(testbyte))  
    ' [ByteToBin] byte=67, hex=0x43 > result bin=01000011  
  
    testbyte = 0x0A ' DEC 10  
    Log("[NibbleToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.NibbleToBin(testbyte))  
    ' [NibbleToBin] byte=10, hex=0x0A > result bin=1010  
  
    ' Boolean  
    ' OnOff to Boolean  
    Log("OnOffToBool] on > result ", Convert.OnOffToBool("on"), ", off > result ", Convert.OnOffToBool("off"))  
    ' OnOffToBool] on=1, off=0  
     
    ' XORChecksum  
    testbytes = Array As Byte(0x0A, 0x0B)  
    testbyte = Convert.XORChecksum(testbytes)  
    Log("[XORChecksum] bytes=", Convert.BytesToHex(testbytes), " > result byte=", Convert.OneByteToHex(testbyte))  
    ' [XORChecksum] bytes=0A0B > result byte=01  
  
    ' Swap  
    testuint = 23  
    Log("[SwapUInt16] uint=", testuint, " > result uint=", Convert.SwapUInt16(testuint))  
    ' [SwapUInt16] uint=23 > result uint=5888  
  
    testbytes = Convert.SwapUInt16ToBytes(testuint)  
    Log("[SwapUInt16] uint=", testuint, " > result bytes=", Convert.OneByteToHex(testbytes(0)), Convert.OneByteToHex(testbytes(1)))  
    ' [SwapUInt16ToBytes] uint=23 > result bytes=1700  
End Sub
```

  
  
**Function Index**  
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
  
– ULong –  
ULongToBytes(value) : 32-bit unsigned > little-endian bytes.  
BytesToULong(b) : Little-endian 4 bytes > unsigned 32-bit.  
  
– Float –  
FloatToBytes(value) : 32-bit float > little-endian bytes.  
BytesToFloat(b) : Little-endian 4 bytes > 32-bit float.  
  
– Bin –  
ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.  
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
  

---

  
**License**  
MIT License.