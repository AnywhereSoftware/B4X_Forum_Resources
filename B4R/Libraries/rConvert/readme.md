### rConvert by rwblinn
### 09/03/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**  

---

  
  
**Brief  
rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with micro controllers, sensors, and communication protocols.  
  
It includes converting methods:  
- Unsigned integers (UInt, ULong) and Byte Arrays.  
- Floats, Byte Arrays (IEEE-754).  
- Double 64-bit ESP32 only.  
- Numbers and formatted strings.  
- Bytes and hexadecimal strings.  
- Common convenience helpers (e.g. On/Off → Boolean).  
- Endianness, Checksum, BCD, Bin, Modbus, BitWise operations.  
- CSV Split into bytes, ints, utins or floats.  
- Misc like MillisToBytes.  
- Constants for numeric ranges with reference table.  
  
The goal is to keep the routines small, efficient, and compatible with B4R’s limitations (no StringBuilder, limited standard libraries, etc.), so you can drop them into any project.  
  
- Developed with B4R 4.00 (64 bit), arduino-cli 1.3.1, arduino esp32 board manager 3.3.10  
- Tested with Arduino UNO R3, UNO R4 WiFi, MEGA and ESP32 Wrover Kit.  
  

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
    Log(CRLF, "[Main.AppStart] Basic Example rConvert ", Convert.VERSION, CRLF)  
     
    TestBitWise  
    TestByteWise  
    TestInt  
    TestUInt  
    TestULong  
    TestFloat  
    TestBCD  
    TestBinary  
    TestBoolean  
    TestXORChecksum  
    TestSwap  
    TestModbusCRC16  
    TestCSVParsing  
    TestByteConverter  
    TestMisc  
     
    ' MCU specific using conditional symbols  
    #If ESP32  
    TestD64  
    #End If  
         
    Log(CRLF, "[Main.AppStart] Done", CRLF)  
End Sub  
  
Private Sub TestByteWise  
    Dim testbyte As Byte  
    Dim testbytes() As Byte  
    Dim resultbytes() As Byte  
    Dim resultboolean As Boolean  
    Dim resultbooleans() As Boolean  
     
    Log("=================================")  
    Log("[TestByteWise] Start")  
  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, " > result hex=", Convert.TwoBytesToHex(b1, b2))  
    ' [TwoBytesToHex] b1=10, b2=15 > result hex=0A0F  
      
    testbytes = Array As Byte(0x0A, 0x1F, 0x2E, 0x3D)  
    resultbytes = Convert.SliceBytes(testbytes, 1, 2)  
    Log("[SliceBytes]", _  
        " bytes=", Convert.BytesToHex(testbytes), _  
        " start=1, length=2", _  
        " > result=", Convert.BytesToHex(resultbytes))  
    ' [SliceBytes] bytes=0A1F2E3D start=1, length=2 > result=1F2E  
     
    ' Concat byte arrays  
    Dim ba1() As Byte = Array As Byte(0x01,0x02)  
    Dim ba2() As Byte = Array As Byte(0x03,0x04)  
    resultbytes = Convert.ConcatBytes(ba1, ba2)  
    Log("[ConcatBytes]", _  
        " ba1=", Convert.BytesToHex(ba1), _  
        " ba2=", Convert.BytesToHex(ba2), _  
        " > result=", Convert.BytesToHex(resultbytes), _  
        " length=", resultbytes.length)  
    ' [ConcatBytes] ba1=0102 ba2=0304 > result=01020304 length=4  
     
    testbyte = 0x81  
    resultbooleans = Convert.ByteToBits(testbyte)  
    Log("[ByteToBits] byte=", Convert.ByteToHex(testbyte))  
    For Each b As Boolean In resultbooleans  
        Log("[ByteToBits] ", b, " ", Convert.BoolToTrueFalse(b))  
    Next  
    ' byte=81 8 bits = 10000001 = True, False, False, False, False, False, False, True  
  
    testbyte = Convert.BitsToByte(resultbooleans)  
    Log("[BitsToByte]", _  
        " bits=", Convert.ByteToBin(testbyte), _  
        " byte=", Convert.ByteToHex(testbyte))  
    ' [BitsToByte] bits=10000001 byte=81  
  
    testbytes = Array As Byte(0x1A, 0x2B, 0x3C)  
    resultbytes = Convert.ShiftArrayBytesRight(testbytes, 1)  
    Log("[ShiftArrayBytesRight]", _  
        " testbytes hex=", Convert.BytesToHex(testbytes), _  
        " testbytes bin=", Convert.BytesToBin(testbytes), _  
        " > result hex=", Convert.BytesToHex(resultbytes), _  
        " > result bin=", Convert.BytesToBin(resultbytes))     
  
    testbytes = Array As Byte(0x1A, 0x2B, 0x3C)  
    resultbytes = Array As Byte(0x1A, 0x2B, 0x3D)  
    resultboolean = Convert.ByteArrayCompare(testbytes, resultbytes)  
    Log("[ByteArrayCompare]", _  
        " bytearray1=", Convert.BytesToHex(testbytes), _  
        " bytearray2=", Convert.BytesToHex(resultbytes), _  
        " > result=", resultboolean, " (1=equal else 0=not equal)")     
  
    Log("[TestByteWise] Done")  
    Log("=================================")  
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
    Dim testresult() As Byte  
    Dim teststring() As Byte  
  
    Log("=================================")  
    Log("[TestBitWise] Start")  
  
    testbyte = 0  
    testbyte = Convert.SetBit(testbyte, 3)  
    Log("[SetBit] Set bit 3 from value 0 > result=", testbyte, " ", Convert.ByteToBitsString(testbyte))  
    ' [SetBit] Set bit 3 from value 0 > result=8 00001000  
     
    testbyte = Convert.ClearBit(testbyte, 3)  
    Log("[ClearBit] Clear bit 3 from value 8 > result=", testbyte, " ", Convert.ByteToBitsString(testbyte))  
    ' [ClearBit] Clear bit 3 from value 8 > result=0 00000000  
     
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
  
    testbyte = 0x81  
    testresult = Convert.GetBitIndices(testbyte, True)  
    Log("[GetBitIndices]", _  
        " byte=", Convert.ByteToBitsString(testbyte), _  
        " > result=", Convert.BytesToHex(testresult), _  
        " length=", testresult.Length)  
    ' [GetBitIndices] byte=10000001 > result=0007 length=2  
     
    testbytes = Array As Byte(0x2,0x5,0x6)  
    testbyte = Convert.SetBitIndices(testbytes)  
    Log("[SetBitIndices]", _  
        " bytes=",Convert.BytesToHex(testbytes), _  
        " > result=", Convert.ByteToBitsString(testbyte), " DEC=", testbyte, " HEX=", Convert.ByteToHex(testbyte))  
    ' [SetBitIndices] bytes=020506 > result=01100100 DEC=100 HEX=64  
     
    testbyte = 0x81  
    Log("[CountActiveBits]", _  
        " byte=",Convert.ByteToBitsString(testbyte), _  
        " > result=", Convert.CountActiveBits(testbyte,True))  
    ' [CountActiveBits] byte=10000001 > result=2  
  
    testbytes = Array As Byte(0x2,0x5,0x6)  
    testbyte = Convert.ClearBitIndices(testbytes)  
    Log("[ClearBitIndices]", _  
        " bytes=",Convert.BytesToHex(testbytes), _  
        " > result=", Convert.ByteToBitsString(testbyte), " DEC=", testbyte, " HEX=", Convert.ByteToHex(testbyte))  
    ' [SetBitIndices] bytes=020506 > result=01100100 DEC=100 HEX=64  
  
    testbytes = Array As Byte(0x80, 0x01)  
    testresult = Convert.ShiftArrayBitsLeft(testbytes)  
    Log("[ShiftArrayBitsLeft]", _  
        " bytes=",Convert.BytesToHex(testbytes), _  
        " bin=",Convert.BytesToBitsString(testbytes), _  
        " > result=", Convert.BytesToBitsString(testresult))  
    ' [ShiftArrayBitsLeft] bytes=8001 bin=1000000000000001 > result=0000000000000010  
     
    Log("[TestBitWise] Done")  
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
  
' TestCSVParsing  
' Important: Memory Reclamation: By moving the variables out of one large container routine, B4R completely purges the memory spaces utilized by  
Private Sub TestCSVParsing  
    Log("=================================")  
    Log("[TestCSVParsing] Start")  
  
    ' Rule definition  
    Convert.SplitAllowEmptyAsZero = True  
  
    ' Execute each test block inside its own isolated routine.  
    ' This forces B4R to clear the memory stacks between calls!  
    TestCSVToBytes  
    TestCSVToInts  
    TestCSVToUInts  
    TestCSVToFloats  
  
    Log("[TestCSVParsing] Done")  
    Log("=================================")  
End Sub  
  
Private Sub TestCSVToBytes  
    Dim testbytes() As Byte = Convert.CSVToBytes("1,21,39,255", ",")  
    If Convert.CSVParserResult Then  
        For Each byteitem As Int In testbytes  
            Log("[TestCSVToBytes] ", byteitem)  
        Next  
    Else  
        Log("[TestCSVToBytes][E] Invalid byte item.")  
    End If  
    Log("[TestCSVToBytes] done")  
End Sub  
  
Private Sub TestCSVToInts  
    Dim teststring_ints() As Byte = "1,20,300,4000"  
    Dim testints() As Int = Convert.CSVToInts(teststring_ints, ",")  
    Log("[TestCSVToInts] string=", Convert.ByteConv.StringFromBytes(teststring_ints), " > result=", testints.length, " ints")  
     
    If Convert.CSVParserResult Then  
        For Each intitem As Int In testints  
            Log("[TestCSVToInts] ", intitem)  
        Next  
    Else  
        Log("[TestCSVToInts][E] Invalid int item.")  
    End If  
    Log("[TestCSVToInts] done")  
End Sub  
  
Private Sub TestCSVToUInts  
    Dim teststring_uints() As Byte = "1,2,3"  
    Dim testuints() As UInt = Convert.CSVToUInts(teststring_uints, ",")  
    Log("[TestCSVToUInts] string=", Convert.ByteConv.StringFromBytes(teststring_uints), " > result=", testuints.length, " uints")  
     
    If Convert.CSVParserResult Then  
        For Each uintitem As UInt In testuints  
            Log("[TestCSVToUInts] ", uintitem)  
        Next  
    Else  
        Log("[TestCSVToUInts][E] Invalid uint item.")  
    End If  
    Log("[TestCSVToUInts] done")  
End Sub  
  
Private Sub TestCSVToFloats  
    Dim teststring_floats() As Byte = "1,2.234,-3,4.23,5.1"  
    Dim testfloats() As Float = Convert.CSVToFloats(teststring_floats, ",")  
    Log("[TestCSVToFloats] string=", Convert.ByteConv.StringFromBytes(teststring_floats), " > result=", testfloats.length, " floats")  
     
    If Convert.CSVParserResult Then  
        For Each floatitem As Float In testfloats  
            Log("[TestCSVToFloats] ", floatitem)  
        Next  
    Else  
        Log("[TestCSVToFloats][E] Invalid float item.")  
    End If  
    Log("[TestCSVToFloats] done")  
End Sub  
  
Private Sub TestMisc  
    Log("=================================")  
    Log("[TestMisc] Start")  
     
    Dim m As ULong = Millis + (1 * 60 * 1000) + (20 * 1000)  
    Log("MillisToTimeString]", _  
        " millis=", m, _  
        " > result=", Convert.MillisToTimeString(m))  
    'MillisToTimeString] millis=80062 > result=00:01:20  
  
    Log("[TestMisc] Done")  
    Log("=================================")  
End Sub  
  
' ================================================================  
' 64-BIT ONLY LIKE ESP32  
' ==========================================================  
  
#if ESP32  
Private Sub TestD64  
    Log("=================================")  
    Log("[TestD64] ESP32")  
  
    ' Fetch the 13-digit absolute millisecond timestamp  
    Dim MillisNow As Double = Convert.D64Millis  
    ' Test assignment  
    ' MillisNow = 1786176213  
    Log("[TestD64] Current Time (ms): ", MillisNow)  
  
    ' Convert to 64-bit global D64String  
    Convert.D64ToString(MillisNow)  
    ' Use D64String to bypass the B4R log 'ovf' limitation when logging D64Val  
    Log("[TestD64] Current Time (ms) (string): ", Convert.D64String, " Hex (8-bytes big-endian): ", Convert.D64ToHex(MillisNow, True))  
  
    ' Do native math operations directly but with tiny rounding issues  
    ' ' Adds 10,000 milliseconds (10 seconds)  
    Dim FutureTime As Double = MillisNow + 10000  
    Convert.D64ToString(FutureTime)  
    Log("[TestD64] Future Time  (ms): ", Convert.D64String)  
  
    Dim Difference As Double = FutureTime - MillisNow  
    Convert.D64ToString(Difference)  
    Log("[TestD64] Difference   (ms): ", Convert.D64String)  
  
    Log("[TestD64] ESP32 Done")  
    Log("=================================")  
  
'    Output with 16 ms rounding difference occurred when using large values  
'    [TestD64] Current Time (ms): 1786176256  
'    [TestD64] Current Time (ms) (string): 1786176256 Hex (8-bytes big-endian): 000000006A76E300  
'    [TestD64] Future Time  (ms): 1786186240  
'    [TestD64] Difference   (ms): 9984  
End Sub  
#End If
```

  

---

  
  
**Function Index**  
(Taken from source Convert.bas)  

```B4X
'– ByteWise –  
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
'– Bool –  
'BoolToString(state) : True > "1", False > "0".  
'BoolToOnOff(state) : True > "ON", False > "OFF".  
'OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.  
'BoolToTrueFalse(value) : "True" or "False".  
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
'– Double 64-bit (ESP32 only) —  
'D64Millis - Fetches the True 13-digit absolute Unix epoch milliseconds from the hardware.  
'D64ToBytes(d) - Convert large Double into the 8-byte global Array `D64Buffer`. **Note**: Tiny rounding steps may occur on high values during inline B4R math operations (e.g., a difference of 9984ms instead of exactly 10000ms).  
'D64ToString(d) - Format any large Double safely into the global Array `D64String` As printable text characters To bypass standard B4R Log `ovf` limitations.  
'D64ToHex(d) - Convert large Double into a 16-character hexadecimal string, with option To swap byte-order To Little- Or Big-Endian.  
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
'MillisToTimeString(millis): Convert milliseconds > hh:mm:ss string
```

  

---

  
  
**Licence**  
MIT.  
  
**Attached**  
Library v1.7.0