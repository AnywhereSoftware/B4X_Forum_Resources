### rConvert by rwblinn
### 04/14/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**  

---

  
  
**Brief  
rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with micro controllers, sensors, and communication protocols.  
  
It includes converting methods:  
- Unsigned integers (UInt, ULong) and byte arrays.  
- Floats and byte arrays (IEEE-754).  
- Numbers and formatted strings.  
- Bytes and hexadecimal strings.  
- Common convenience helpers (e.g. On/Off → Boolean).  
- Endianness, Checksum, BCD, Bin, Modbus, BitWise operations.  
- CSV Split into bytes, ints, utins or floats.  
- Misc like MillisToBytes.  
- Constants for numeric ranges with reference table.  
  
The goal is to keep the routines small, efficient, and compatible with B4R’s limitations (no StringBuilder, limited standard libraries, etc.), so you can drop them into any project.  
  
- Developed with B4R 4.00 (64 bit), arduino-cli 1.3.1.  
- Tested with MCU Arduino UNO, Arduino MEGA and ESP32 Wrover Kit.  
  

---

  
**Files**  
The *rConvert.b4xlib* contains the library.  
  

---

  
**Install**  
Copy *rConvert.b4xlib* to your B4R **Additional Libraries** folder.  
  

---

  
**Example Selected Functions (with Log Output)**  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    ' ESP32 requires higher stackbuffer size min 800  
    #StackBufferSize: 800  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
' Main Test App  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "*****", CRLF)  
    Log(CRLF, "[Main.AppStart] Convert ", Convert.VERSION, CRLF)  
  
    TestInt  
    TestUInt  
    TestULong  
    TestFloat  
    TestTwoBytesHex  
    TestBCD  
    TestBinary  
    TestBoolean  
    TestXORChecksum  
    TestSwap  
    TestModbusCRC16  
    TestBitWise  
    TestCSVParsing  
    TestByteConverter  
     
    Log(CRLF, "[Main.AppStart] Done", CRLF)  
End Sub  
  
Private Sub TestInt  
    Dim testvalue As Int  
    Dim testbytes(2) As Byte    ' Array dimension must be set  
  
    Log("=================================")  
    Log("[TestInt] Start")  
     
    ' Bytes 80 00  
    ' little-endian (80 00) > LSB = 0x80, MSB = 0x00 > 0x0080 = 128  
    ' big-endian (80 00) > MSB = 0x80, LSB = 0x00 > 0x8000 = -32768  
    testbytes(0) = 0x80  
    testbytes(1) = 0x00  
    testvalue = Convert.TwoBytesToInt(testbytes, True)  
    Log("[TwoBytesToInt] littleendian bytes=", Convert.BytesToHex(testbytes), " > result int=", testvalue)  
    ' [TwoBytesToInt] littleendian bytes=8000 > result int=128  
    testvalue = Convert.TwoBytesToInt(testbytes, False)  
    Log("[TwoBytesToInt] bigendian bytes=", Convert.BytesToHex(testbytes), " > result int=", testvalue)  
    ' [TwoBytesToInt] bigendian bytes=8000 > result int=-32768  
  
    ' Bytes 7F FF  
    ' little-endian (7F FF) > 0xFF7F = -129  
    ' big-endian (7F FF) > 0x7FFF = 32767  
    testbytes(0) = 0x7F  
    testbytes(1) = 0xFF  
    testvalue = Convert.TwoBytesToInt(testbytes, True)  
    Log("[TwoBytesToInt] little endian bytes=", Convert.BytesToHex(testbytes), " > result int=", testvalue)  
    ' [TwoBytesToInt] little endian bytes=7FFF > result int=-129  
    testvalue = Convert.TwoBytesToInt(testbytes, False)  
    Log("[TwoBytesToInt] big endian bytes=", Convert.BytesToHex(testbytes), " > result int=", testvalue)  
    ' [TwoBytesToInt] big endian bytes=7FFF > result int=32767  
    Log("[TestInt] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestUInt  
    Dim testvalue As UInt  
    Dim testbytes() As Byte  
    Dim teststring As String  
  
    Log("=================================")  
    Log("[TestUInt] Start")  
  
    testvalue = 10  
    testbytes = Convert.UIntToBytes(testvalue)  
    Log("[UIntToBytes] int=", testvalue, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [UIntToBytes] int=10 > result hex=0A00, length=2  
     
    testbytes = Array As Byte(0x0A, 0x00)  
    testvalue = Convert.BytesToUInt(testbytes)  
    Log("[BytesToUInt] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testvalue)  
    ' [BytesToUInt] bytes=0A00, length=2 > result uint=10  
  
    ' 80 00 > little-endian    128  
    testbytes = Array As Byte(0x80, 0x00)  
    testvalue = Convert.TwoBytesToUInt(testbytes, True)  
    Log("[TwoBytesToUInt] littleendian bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testvalue)  
    ' [TwoBytesToUInt] littleendian bytes=8000, length=2 > result uint=128  
     
    ' 80 00 > big-endian 32768  
    testvalue = Convert.TwoBytesToUInt(testbytes, False)  
    Log("[TwoBytesToUInt] bigendian bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testvalue)  
    ' [TwoBytesToUInt] bigendian bytes=8000, length=2 > result uint=32768  
     
    teststring = "200"  
    testvalue = Convert.UIntFromString(teststring)  
    Log("[UIntFromString] string=", teststring, ", length=",teststring.Length," > result uint=", testvalue)  
    ' [UIntFromString] string=200, length=3 > result uint=200  
  
    Log("[TestUInt] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestULong  
    Dim testvalue As ULong  
    Dim testbytes() As Byte  
    Dim teststring As String  
  
    Log("=================================")  
    Log("[TestULong] Start")  
  
    testvalue = 10  
    testbytes = Convert.ULongToBytes(testvalue)  
    Log("[ULongToBytes] long=", testvalue, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [ULongToBytes] long=10 > result hex=0A000000, length=4  
     
    testbytes = Array As Byte(0x0A,0x00,0x00,0x00)  
    testvalue = Convert.BytesToULong(testbytes)  
    Log("[BytesToULong] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result ulong=", testvalue)  
    ' [BytesToULong] bytes=0A000000, length=4 > result ulong=10  
     
    teststring = testvalue  
    Log("[ULongToString Cast] ulong=", testvalue, " > result teststring=", teststring)  
    ' [ULongToString Cast] ulong=10 > result teststring=10.00  
     
    teststring = NumberFormat(testvalue, 0, 0)  
    Log("[ULongToString NumberFormat] ulong=", testvalue, " > result teststring=", teststring)  
    ' [ULongToString NumberFormat] ulong=10 > result teststring=10  
     
    Log("[TestULong] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestFloat  
    Dim testvalue As Float  
    Dim testbytes() As Byte  
  
    Log("=================================")  
    Log("[TestFloat] Start")  
     
    ' 19.58 > little-endian D7A39C41 > big-endian 419CA3D7  
    testvalue = 19.58  
  
    testbytes = Convert.FloatToBytes(testvalue)  
    Log("[FloatToBytes Little-Endian] float=", testvalue, " > result hex=", Convert.BytesToHex(testbytes))  
    ' [FloatToBytes] float=19.5800 > result hex=D7A39C41, length=4  
  
    testbytes = Convert.ReverseBytes(testbytes)  
    Log("[FloatToBytes Big-Endian] float=", testvalue, " > result hex=", Convert.BytesToHex(testbytes))  
    ' [FloatToBytes Big-Endian] float=19.5800 > result hex=419CA3D7  
     
    testbytes = Array As Byte(0X41,0X9C,0XA3,0XD7)  
    ' Ensure to set little-endian if not done in the previous array  
    testbytes = Convert.ReverseBytes(testbytes)  
    testvalue = Convert.BytesToFloatScaled(testbytes, 1)  
    Log("[FloatToBytesScaled] bytes=", Convert.BytesToHex(testbytes), " > result float=", NumberFormat(testvalue, 0, 1))  
    ' [FloatToBytesScaled] bytes=D7A39C41 > result float=19.6000  
  
    Log("[TestFloat] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestTwoBytesHex  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
  
    Log("=================================")  
    Log("[TestTwoBytesHex] Start")  
  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, " > result hex=", Convert.TwoBytesToHex(b1, b2))  
    ' [TwoBytesToHex] b1=10, b2=15 > result hex=0A0F  
     
    Log("[TestTwoBytesHex] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestBCD  
    Dim testbyte As Byte = 15  
  
    Log("=================================")  
    Log("[TestBCD] Start")  
  
    Log("[ByteToBCD] byte=",testbyte, " > result hex=0x", Convert.ByteToHex(Convert.ByteToBCD(testbyte)), ", bin=", Convert.ByteToBCDBin(testbyte))  
    ' [ByteToBCD] byte=15 > result hex=0x15, bin=00010101  
  
    Log("[TestBCD] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestBinary  
    Dim testbyte As Byte  
    Dim teststring As String  
  
    Log("=================================")  
    Log("[TestBinary] Start")  
    testbyte = 0x43  
    Log("[ByteToBin] byte=",testbyte, ", hex=0x", Convert.ByteToHex(testbyte), " > result bin=", Convert.ByteToBin(testbyte))  
    ' [ByteToBin] byte=67, hex=0x43 > result bin=01000011  
     
    testbyte = 0x0A  
    Log("[NibbleToBin] byte=",testbyte, ", hex=0x", Convert.ByteToHex(testbyte), " > result bin=", Convert.NibbleToBin(testbyte))  
    ' [NibbleToBin] byte=10, hex=0x0A > result bin=1010  
     
    teststring = "11100011"  
    Log("[BinToDec] bytes=",teststring.GetBytes, " > result dec=", Convert.BinToDec(teststring))  
    ' [BinToDec] bytes=11100011 > result dec=227  
     
    Log("[TestBinary] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestBoolean  
    Log("=================================")  
    Log("[TestBoolean] Start")  
     
    Log("[OnOffToBool] on > result ", Convert.OnOffToBool("on"), ", off > result ", Convert.OnOffToBool("off"))  
    ' [OnOffToBool] on > result 1, off > result 0  
     
    Log("[BoolToByte] true > result ", Convert.BoolToByte(True), ", false > result ", Convert.BoolToByte(False))  
    ' [BoolToByte] true > result 1, false > result 0  
     
    Log("[TestBoolean] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestXORChecksum  
    Dim testbytes() As Byte = Array As Byte(0x0A, 0x0B)  
    Dim testbyte As Byte  
    Log("=================================")  
  
    Log("[TestXORChecksum] Start")  
  
    testbyte = Convert.XORChecksum(testbytes)  
    Log("[XORChecksum] bytes=", Convert.BytesToHex(testbytes), " > result byte=", Convert.ByteToHex(testbyte))  
    ' [XORChecksum] bytes=0A0B > result byte=01  
     
    testbytes = Array As Byte(0x5A,0x6B,0x02,0x00,0x05,0x02,0x1E,0x00,0x00,0x01)    ' > 2B  
    testbytes = Convert.AppendXORChecksum(testbytes)  
    Log("[AppendXORChecksum] bytes=", Convert.BytesToHex(testbytes), " > result checksum lastbyte=", Convert.ByteToHex(testbytes(testbytes.Length - 1)))  
    ' [AppendXORChecksum] bytes=5A6B020005021E0000012B > result checksum lastbyte=2B  
  
    Log("[TestXORChecksum] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestSwap  
    Dim testvalue As UInt = 23  
    Dim testbytes() As Byte  
    Log("=================================")  
    Log("[TestSwap] Start")  
  
    Log("[SwapUInt16] uint=", testvalue, " > result uint=", Convert.SwapUInt16(testvalue))  
    ' [SwapUInt16] uint=23 > result uint=5888  
     
    testbytes = Convert.SwapUInt16ToBytes(testvalue)  
    Log("[SwapUInt16ToBytes] uint=", testvalue, " > result bytes=", Convert.ByteToHex(testbytes(0)), Convert.ByteToHex(testbytes(1)))  
    ' [SwapUInt16ToBytes] uint=23 > result bytes=0017  
     
    Log("[TestSwap] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestModbusCRC16  
    Dim testframe() As Byte = Array As Byte(0x01, 0x03, 0x00, 0x00, 0x00, 0x0A)  
    Dim testbytes() As Byte  
    Dim crcNum As ULong  
    Dim valid As Boolean  
  
    Log("=================================")  
    Log("[TestModbusCRC16] Start")  
     
    testbytes = Convert.ModbusCRC16(testframe)  
    Log("[ModbusCRC16] frame=", Convert.BytesToHex(testframe), " > result CRC bytes [low, high]=", Convert.BytesToHex(testbytes))  
    ' [ModbusCRC16] frame=01030000000A > result CRC bytes [low, high]=C5CD  
     
    crcNum = Convert.ModbusCRC16UInt(testframe)  
    Log("[ModbusCRC16UInt] frame=", Convert.BytesToHex(testframe), " > result CRC numeric=0x" , Convert.BytesToHex(Array As Byte(Bit.ShiftRight(crcNum, 8), Bit.And(crcNum, 0xFF))), " (decimal=" , crcNum , ")")  
    ' [ModbusCRC16UInt] frame=01030000000A > result CRC numeric=0xCDC5 (decimal=52677)  
     
    testbytes = Convert.ModbusCRC16TransmittedFrame(testframe)  
    Log("[ModbusCRC16TransmittedFrame] frame=", Convert.BytesToHex(testframe), " > result= Transmitted frame=" , Convert.BytesToHex(testbytes))  
    ' [ModbusCRC16TransmittedFrame] frame=01030000000A > result= Transmitted frame=01030000000AC5CD  
     
    valid = Convert.ModbusCRC16Check(testbytes)  
    Log("[ModbusCRC16Check] frame=", Convert.BytesToHex(testbytes), " > result= CRC valid (1=true) " , valid)  
    ' [ModbusCRC16Check] frame=01030000000AC5CD > result= CRC valid (1=true) 1  
  
    Log("[TestModbusCRC16] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestBitWise  
    Dim testbyte As Byte  
    Dim testbytes() As Byte  
    Dim teststring() As Byte  
  
    Log("=================================")  
    Log("[TestBitWise] Start")  
  
    testbyte = 0  
    testbyte = Convert.SetBit(testbyte, 3, True)  
    Log("[SetBit] Set bit 3 from value 0 > result=", testbyte)  
    ' [SetBit] Set bit 3 from value 0 > result=8  
     
    testbyte = Convert.SetBit(testbyte, 3, False)  
    Log("[SetBit] Clear bit 3 from value 8 > result=", testbyte)  
    ' [SetBit] Clear bit 3 from value 8 > result=0  
     
    testbyte = 8  
    testbyte = Convert.ToggleBit(testbyte, 3)  
    Log("[ToggleBit] Toggle bit 3 from DEC value 8 > result=", testbyte)  
    ' [ToggleBit] Toggle bit 3 from DEC value 8 > result=0  
     
    testbyte = Convert.ToggleBit(testbyte, 1)  
    Log("[ToggleBit] Toggle bit 1 from DEC value 0 > result=", testbyte)  
    ' [ToggleBit] Toggle bit 1 from DEC value 0 > result=2  
     
    testbyte = 8  
    Log("[GetBit] Get bit 0 from DEC value 8 > result=", Convert.GetBit(testbyte, 0), " - ", Convert.ByteToBitsString(testbyte))  
    ' [GetBit] Get bit 0 from DEC value 8 > result=0 - 00001000  
    Log("[GetBit] Get bit 2 from DEC value 8 > result=", Convert.GetBit(testbyte, 2), " - ", Convert.ByteToBitsString(testbyte))  
    ' [GetBit] Get bit 2 from DEC value 8 > result=0 - 00001000  
    Log("[GetBit] Get bit 3 from DEC value 8 > result=", Convert.GetBit(testbyte, 3), " - ", Convert.ByteToBitsString(testbyte))  
    ' [GetBit] Get bit 3 from DEC value 8 > result=1 - 00001000  
  
    testbyte = 170  
    teststring = Convert.ByteToBitsString(testbyte)  
    Log("[ByteToBitsString] b=",testbyte, " > result=", teststring, " length=", teststring.Length)  
    ' [ByteToBitsString] b=170 > result=10101010 length=8  
    testbytes = Array As Byte(5, 170)  
    teststring = Convert.BytesToBitsString(testbytes)  
    Log("[BytesToBitsString] Byte 1=5, byte 2=170 > result=", teststring, " length=", teststring.Length)  
    ' [BytesToBitsString] Byte 1=5, byte 2=170 > result=0000010110101010 length=16  
     
    Log("[TestBitWise] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestCSVParsing  
    Log("=================================")  
    Log("[TestCSVParsing] Start")  
  
    ' Set rule to allow empty item as 0.  
    Convert.SplitAllowEmptyAsZero = False  
  
    Dim teststringbytes() As Byte = "1,21,39,   255   ,,"    ' "1,21,39,256" <<< teststring with wrong byte  
    Dim testbytes() As Byte  
    testbytes = Convert.CSVToBytes(teststringbytes, ",")  
    ' [CSVToBytes][E] Empty item at index 4 not allowed.  
    If testbytes.Length > 0 Then  
        For Each byteitem As Int In testbytes  
            Log("[CSVToBytes] ", byteitem)  
        Next  
    Else  
        Log("[CSVToBytes][E] String contains not a number or not a byte item: ", teststringbytes)  
    End If  
  
    Dim teststringints() As Byte = "1,20,300,4000"            ' "1,2,3,4,5, 45000" <<< teststing with wrong int  
    Dim testints() As Int  
    testints = Convert.CSVToInts(teststringints, ",")  
    Log("[CSVToInts] string=", teststringints, " > result=", testints.length, " ints")  
    ' [CSVToInts] string=1,20,300,4000 > result=4 ints  
    If testints.Length > 0 Then  
        For Each intitem As Int In testints  
            Log("[CVSToInts] ", intitem)  
        Next  
'    Else  
'        Log("[CVSToInts][E] String contains not a number or not an int item.")  
    End If  
  
    Dim teststringuints() As Byte = "1,2,3"                    ' "1,2,3,-4,5" <<< testsringwith wrong uint  
    Dim testuints() As UInt  
    testuints = Convert.CSVToUInts(teststringuints, ",")  
    Log("[CSVToUInts] string=", teststringuints, " > result=", testuints.length, " ints")  
    ' [CSVToUInts] string=1,2,3 > result=3 ints  
    If testuints.Length > 0 Then  
        For Each uintitem As UInt In testuints  
            Log("[CSVToUInts] ", uintitem)  
        Next  
'    Else  
'        Log("[CSVToUInts][E] String contains not a number or not an unsigned integer item")  
    End If  
  
    Dim teststringfloats() As Byte = "1,2.234,-3,4.23,5.1"  
    Dim testfloats() As Float  
    testfloats = Convert.CSVToFloats(teststringfloats, ",")  
    Log("[CSVToFloats] string=", teststringfloats, " > result=", testfloats.length, " floats")  
    ' [CSVToFloats] string=1,2.234,-3,4.23,5.1 > result=5 floats  
    If testfloats.Length > 0 Then  
        For Each floatitem As Float In testfloats  
            Log("[CSVToFloats] ", floatitem)  
        Next  
'    Else  
'        Log("[CSVToFloats][E] String contains not a number item.")  
    End If  
  
    Log("[TestCSVParsing] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestByteConverter  
    Dim testbytes() As Byte = Array As Byte(255, 10, 9)  
    Log("=================================")  
    Log("[TestByteConverter] Start")  
    'Dim testbytes() As Byte = Array As Byte(0xFF, 0x0A, 0x09)  
  
    Log("[TestByteConverter] bytes=255,10,9 > result HEX=", Convert.ByteConv.HexFromBytes(testbytes))  
    ' [TestByteConverter] bytes=255,10,9 > result HEX=FF0A09  
  
    Log("[TestByteConverter] Done")  
    Log("=================================")  
End Sub
```

  

---

  
  
**Function Index**  
(Taken from source Convert.bas)  

```B4X
'– Bytes –  
'ByteToBool(byte) : Byte 0 | 1 > True, Else False.  
'AsciiByteToBool(byte) : Byte "1" > True, Byte "0" > False.  
'AsciiBytesToBool(byte) : First Byte "1" > True, Byte "0" > False.  
'AsciiByteToInt(byte) : Ascii digit Byte "0"-"9" > Integer 0–9.  
'ByteToHex(byte): Single Byte > HEX string.  
'BytesToHex(bytes) : Byte Array > HEX string.  
'TwoBytesToHex(b1,b2) : Two bytes > HEX string.  
'ReverseBytes(b) : Reverse Byte order Byte Array.  
'BytesToString(b): Convert Bytes > String.  
'  
'– Bool –  
'BoolToString(state) : True > "1", False > "0".  
'BoolToOnOff(state) : True > "ON", False > "OFF".  
'OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.  
'IntToBool(value) : Convert Int 0, 1 > Bool.  
'BoolToByte : Converts a Boolean value > Byte 1 (True) or 0 (False).  
'  
'– Int –  
'TwoBytesToInt(bytes, littleendian): Convert 2 Bytes > Signed Int with endian support  
'  
'– UInt –  
'UIntToBytes(value) : 16-Bit unsigned Int > little-endian Bytes.  
'BytesToUInt(b) : Little-endian 2 bytes > unsigned 16-Bit.  
'TwoBytesToUInt(b, littleendian): Convert 2 bytes > unsigned Int (0..65535) with endian support  
'UIntToHex(value) : Converts an UInt > HEX string with 2 bytes.  
'UIntFromString : Converts a string > Unsigned 16-bit integer (UInt).  
'  
'– ULong –  
'ULongToBytes(value) : 32-Bit unsigned > little-endian bytes.  
'BytesToULong(b) : Little-endian 4 bytes > unsigned 32-Bit.  
'ULongToHex(value) : Converts an ULong > HEX string with 4 bytes.  
'ULongFromString : Converts a string > Unsigned 32-bit integer (ULong).  
'  
'– Float –  
'FloatToBytes(value) : 32-Bit float > little-endian bytes.  
'BytesToFloat(b) : Little-endian 4 bytes > 32-Bit float.  
'   
'– Bin –  
'ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.  
'BytesToBin(b()) : Converts byte array > Binary string representation.  
'NibbleToBin(nibble) : Convert 0–15 nibble > "xxxx" binary string.  
'BinToDec(string): Converts a binary string like "11100011" > 227.  
'  
'– BCD –  
'ByteToBCD(value) : Decimal 0–99 > single-byte BCD.  
'ByteToBCDBin(value) : Decimal 0–99 > BCD > binary string.  
'BCDToByte(b) : Single-byte BCD > decimal 0–99.  
'UIntToBCDArray(value) : UInt 0–9999 > 2-byte BCD Array.  
'BCDArrayToUInt(b) : 2-byte BCD Array > integer 0–9999.  
'  
'– Checksum –  
'XORChecksum(b) : XOR of all bytes.  
'  
'– Endianness –  
'SwapUInt16(value) : Swap 2-byte unsigned integer.  
'SwapUInt32(value) : Swap 4-byte unsigned integer.  
'SwapUInt16ToBytes(value) : UInt16 > reversed 2-byte Array.  
'BytesToUInt16Swapped(b) : Reversed 2-byte Array > UInt16.  
'SwapUInt32ToBytes(value) : UInt32 > reversed 4-byte Array.  
'BytesToUInt32Swapped(b) : Reversed 4-byte Array > UInt32.  
'  
'– String –  
'StringTrim(s) : Trim spaces/tabs from both ends.  
'ToUpperCase(s) : Ascii lowercase > uppercase.  
'ToLowerCase(s) : Ascii uppercase > lowercase.  
'EqualsIgnoreCase(s1,s2) : Compare ignoring Ascii Case.  
'ReplaceString(orig,search,repl) : Replace all occurrences in Byte Array.  
'AsciiBufferToInt(buffer) : Convert buffer containing Ascii digits > Integer.  
'  
'– Modbus CRC-16 –  
'ModbusCRC16(frame) : Calculate CRC16 (Modbus RTU) > return As 2-byte Array in little-endian order: [low byte, high byte].  
'ModbusCRC16UInt(frame) : Calculate CRC16 (Modbus RTU) > return As numeric 16-Bit value [high byte, low byte].  
'ModbusCRC16TransmittedFrame(frame) : Append CRC16 > end of a frame (low byte first, high byte second).  
'ModbusCheckCRC16 : Validate that a frame ends with the correct Modbus CRC.  
'ModbusCRC16Test(frame) : Test the Modbus CRC16 functions for a frame.  
'  
'– BitWise —  
'SetBit(b, index, on) : Sets Or clears a Bit in a byte at the given index.  
'ToggleBit(b, index) : Flips (toggles) a Bit in a byte at the given index.  
'GetBit(b, index) : Tests If a Bit at the given index in a byte is set.  
'ByteToBitsString(b) : Converts a single byte > 8-character binary string (same As ByteToBin).  
'BytesToBitsString)b()) : Converts a byte Array > binary string representation (same As BytesToBin).  
'  
' – CSV Parsing –  
'CSVCountItems: Get the number of items from a CSV string.  
'CSVToBytes: Split number items from a CSV string > Byte Array.  
'CSVToInts: Split number items from a CSV string > Int Array.  
'CSVToUInts: Split number items from a CSV string > UInt Array.  
'CSVToULongs: Split number items from a CSV string > ULong Array.  
'CSVToFloats: Split number items from a CSV string > Float Array.  
'  
' – Color Conversion  
'RGBToColor: Convert RGB colors 0-255 > ULong.  
'ColorToRGB: Convert color ULong > Byte Array (length 3) with RGB colors 0-255.  
  
' – Misc –  
'DirectionToString(direction) : Convert direction given as Byte > String.  
'MillisToBytes(millis): Convert milliseconds > hh:mm:ss string
```

  

---

  
  
**Licence**  
MIT.  
  
**Attached**  
Library v1.5.0