### rConvert by rwblinn
### 10/23/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**  

---

  
  
**Brief  
rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with microcontrollers, sensors, and communication protocols.  
  
It includes converting methods:  
- Unsigned integers (UInt, ULong) and byte arrays.  
- Floats and byte arrays (IEEE 754).  
- Numbers and formatted strings.  
- Bytes and hexadecimal strings.  
- Common convenience helpers (e.g. On/Off → Boolean).  
- Endianness, Checksum, BCD, Bin, Modbus, BitWise operations.  
- CSV Split into bytes, ints, utins or floats.  
- Misc like MillisToBytes.  
- Constants for numeric ranges with reference table.  
  
The goal is to keep the routines small, efficient, and compatible with B4R’s limitations (no StringBuilder, limited standard libraries, etc.), so you can drop them into any project.  
  
- Developed with B4R 4.00 (64 bit), arduino-cli 1.2.2.  
- Tested with an Arduino UNO, ESP32.  
  

---

  
**Files**  
The *rConvert-NNN.zip* archive contains the library (b4xlib).  
  

---

  
**Install**  
Copy the *rConvert* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
  

---

  
**Example Selected Functions**  

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
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "*****", CRLF)  
    Log(CRLF, "[Main.AppStart] Convert ", Convert.VERSION, CRLF)  
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
  
Private Sub TestUInt  
    Dim testvalue As UInt  
    Dim testbytes() As Byte  
  
    Log("[TestUInt] Start")  
    testvalue = 10  
    testbytes = Convert.UIntToBytes(testvalue)  
    Log("[UIntToBytes] int=", testvalue, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
   
    testbytes = Array As Byte(0x0A, 0x00)  
    testvalue = Convert.BytesToUInt(testbytes)  
    Log("[BytesToUInt] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result uint=", testvalue)  
    Log("[TestUInt] Done")  
End Sub  
  
  
Private Sub TestULong  
    Dim testvalue As ULong  
    Dim testbytes() As Byte  
    Dim teststring As String  
  
    Log("[TestULong] Start")  
    testvalue = 10  
    testbytes = Convert.ULongToBytes(testvalue)  
    Log("[ULongToBytes] long=", testvalue, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
   
    testbytes = Array As Byte(0x0A,0x00,0x00,0x00)  
    testvalue = Convert.BytesToULong(testbytes)  
    Log("[BytesToULong] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length," > result ulong=", testvalue)  
   
    teststring = testvalue  
    Log("[ULongToString Cast] ulong=", testvalue, " > result teststring=", teststring)  
   
    teststring = NumberFormat(testvalue, 0, 0)  
    Log("[ULongToString NumberFormat] ulong=", testvalue, " > result teststring=", teststring)  
    Log("[TestULong] Done")  
End Sub  
  
  
Private Sub TestFloat  
    Dim testvalue As Float  
    Dim testbytes() As Byte  
  
    Log("[TestFloat] Start")  
    testvalue = 18.58  
    testbytes = Convert.FloatToBytes(testvalue)  
    Log("[FloatToBytes] float=", testvalue, " > result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    Log("[TestFloat] Done")  
End Sub  
  
  
Private Sub TestTwoBytesHex  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
    Log("[TestTwoBytesHex] Start")  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, " > result hex=", Convert.TwoBytesToHex(b1, b2))  
    Log("[TestTwoBytesHex] Done")  
End Sub  
  
  
Private Sub TestBCD  
    Dim testbyte As Byte = 15  
    Log("[TestBCD] Start")  
    Log("[ByteToBCD] byte=",testbyte, " > result hex=0x", Convert.OneByteToHex(Convert.ByteToBCD(testbyte)), ", bin=", Convert.ByteToBCDBin(testbyte))  
    Log("[TestBCD] Done")  
End Sub  
  
  
Private Sub TestBinary  
    Dim testbyte As Byte  
    Dim teststring As String  
    Log("[TestBinary] Start")  
    testbyte = 0x43  
    Log("[ByteToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.ByteToBin(testbyte))  
   
    testbyte = 0x0A  
    Log("[NibbleToBin] byte=",testbyte, ", hex=0x", Convert.OneByteToHex(testbyte), " > result bin=", Convert.NibbleToBin(testbyte))  
   
    teststring = "11100011"  
    Log("[BinToDec] bytes=",teststring.GetBytes, ", dec=", Convert.BinToDec(teststring))  
    Log("[TestBinary] Done")  
End Sub  
  
  
Private Sub TestBoolean  
    Log("[TestBoolean] Start")  
    Log("[OnOffToBool] on > result ", Convert.OnOffToBool("on"), ", off > result ", Convert.OnOffToBool("off"))  
    Log("[TestBoolean] Done")  
End Sub  
  
  
Private Sub TestXORChecksum  
    Dim testbytes() As Byte = Array As Byte(0x0A, 0x0B)  
    Dim testbyte As Byte  
    Log("[TestXORChecksum] Start")  
    testbyte = Convert.XORChecksum(testbytes)  
    Log("[XORChecksum] bytes=", Convert.BytesToHex(testbytes), " > result byte=", Convert.OneByteToHex(testbyte))  
    Log("[TestXORChecksum] Done")  
End Sub  
  
  
Private Sub TestSwap  
    Dim testvalue As UInt = 23  
    Dim testbytes() As Byte  
    Log("[TestSwap] Start")  
    Log("[SwapUInt16] uint=", testvalue, " > result uint=", Convert.SwapUInt16(testvalue))  
   
    testbytes = Convert.SwapUInt16ToBytes(testvalue)  
    Log("[SwapUInt16ToBytes] uint=", testvalue, " > result bytes=", Convert.OneByteToHex(testbytes(0)), Convert.OneByteToHex(testbytes(1)))  
    Log("[TestSwap] Done")  
End Sub  
  
  
Private Sub TestModbusCRC16  
    Dim testframe() As Byte = Array As Byte(0x01, 0x03, 0x00, 0x00, 0x00, 0x0A)  
    Dim testbytes() As Byte  
    Dim crcNum As ULong  
    Dim valid As Boolean  
    Log("[TestModbusCRC16] Start")  
   
    Log("[ModbusCRC16Test] Frame=" , Convert.BytesToHex(testframe))  
    testbytes = Convert.ModbusCRC16(testframe)  
    Log("[ModbusCRC16] CRC bytes [low, high]=", Convert.BytesToHex(testbytes))  
   
    crcNum = Convert.ModbusCRC16UInt(testframe)  
    Log("[ModbusCRC16UInt] CRC numeric=0x" , Convert.BytesToHex(Array As Byte(Bit.ShiftRight(crcNum, 8), Bit.And(crcNum, 0xFF))), " (decimal=" , crcNum , ")")  
   
    testbytes = Convert.ModbusCRC16TransmittedFrame(testframe)  
    Log("[ModbusCRC16TransmittedFrame] Transmitted frame=" , Convert.BytesToHex(testbytes))  
   
    valid = Convert.ModbusCRC16Check(testbytes)  
    Log("[ModbusCRC16Check] CRC valid (1=true)? " , valid)  
    Log("[TestModbusCRC16] Done")  
End Sub  
  
  
Private Sub TestBitWise  
    Dim testbyte As Byte  
    Dim testbytes() As Byte  
    Log("[TestBitWise] Start")  
  
    testbyte = 0  
    testbyte = Convert.SetBit(testbyte, 3, True)  
    Log("[SetBit] Set bit 3 for value 0. result=", testbyte)  
   
    testbyte = Convert.SetBit(testbyte, 3, False)  
    Log("[SetBit] Clear bit 3 for value 8. result=", testbyte)  
   
    testbyte = 8  
    testbyte = Convert.ToggleBit(testbyte, 3)  
    Log("[ToggleBit] Toggle bit 3 for value 8. result=", testbyte)  
   
    testbyte = Convert.ToggleBit(testbyte, 1)  
    Log("[ToggleBit] Toggle bit 1 for value 0. result=", testbyte)  
   
    testbyte = 8  
    Log("[GetBit] Get bit 3 for value 8=", Convert.GetBit(testbyte, 3))  
    Log("[GetBit] Get bit 2 for value 8=", Convert.GetBit(testbyte, 2))  
   
    testbyte = 170  
    Log("[ByteToBitsString] b=",testbyte, ", bitsstring=", Convert.ByteToBitsString(testbyte))  
   
    testbytes = Array As Byte(5, 170)  
    Log("[BytesToBitsString] Byte 1=5, byte 2=170. result=", Convert.BytesToBitsString(testbytes))  
    Log("[TestBitWise] Done")  
End Sub  
  
Private Sub TestCSVParsing  
    Log("[TestCSVParsing] Start")  
  
    ' Set rule to allow empty item as 0.  
    Convert.SplitAllowEmptyAsZero = False  
  
    Dim teststringbytes() As Byte = "1,21,39,   255   ,,"    ' "1,21,39,256" <<< teststring with wrong byte  
    Dim testbytes() As Byte  
    testbytes = Convert.CSVToBytes(teststringbytes, ",")  
    Log("[CSVToBytes] string=", teststringbytes, " > result=", testbytes.length, " bytes")  
    If testbytes.Length > 0 Then  
        For Each byteitem As Int In testbytes  
            Log("[CSVToBytes] ", byteitem)  
        Next  
'    Else  
'        Log("[CSVToBytes][E] String contains not a number or not a byte item.")  
    End If  
  
    Dim teststringints() As Byte = "1,20,300,4000"            ' "1,2,3,4,5, 45000" <<< teststing with wrong int  
    Dim testints() As Int  
    testints = Convert.CSVToInts(teststringints, ",")  
    Log("[CSVToInts] string=", teststringints, " > result=", testints.length, " ints")  
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
    If testfloats.Length > 0 Then  
        For Each floatitem As Float In testfloats  
            Log("[CSVToFloats] ", floatitem)  
        Next  
'    Else  
'        Log("[CSVToFloats][E] String contains not a number item.")  
    End If  
  
    Log("[TestCSVParsing] Done")  
End Sub  
  
Private Sub TestByteConverter  
    Dim testbytes() As Byte = Array As Byte(255, 10, 9)  
    Log("[TestByteConverter] bytes=255,10,9 > result HEX=", Convert.ByteConv.HexFromBytes(testbytes))  
End Sub
```

  

---

  
  
**Log Output**  

```B4X
[Main.AppStart] Convert 20251023  
[TestUInt] Start  
[UIntToBytes] int=10 > result hex=0A00, length=2  
[BytesToUInt] bytes=0A00, length=2 > result uint=10  
[TestUInt] Done  
[TestULong] Start  
[ULongToBytes] long=10 > result hex=0A000000, length=4  
[BytesToULong] bytes=0A000000, length=4 > result ulong=10  
[ULongToString Cast] ulong=10 > result teststring=10.00  
[ULongToString NumberFormat] ulong=10 > result teststring=10  
[TestULong] Done  
[TestFloat] Start  
[FloatToBytes] float=18.5800 > result hex=D7A39441, length=4  
[TestFloat] Done  
[TestTwoBytesHex] Start  
[TwoBytesToHex] b1=10, b2=15 > result hex=0A0F  
[TestTwoBytesHex] Done  
[TestBCD] Start  
[ByteToBCD] byte=15 > result hex=0x15, bin=00010101  
[TestBCD] Done  
[TestBinary] Start  
[ByteToBin] byte=67, hex=0x43 > result bin=01000011  
[NibbleToBin] byte=10, hex=0x0A > result bin=1010  
[BinToDec] bytes=11100011, dec=227  
[TestBinary] Done  
[TestBoolean] Start  
[OnOffToBool] on > result 1, off > result 0  
[TestBoolean] Done  
[TestXORChecksum] Start  
[XORChecksum] bytes=0A0B > result byte=01  
[TestXORChecksum] Done  
[TestSwap] Start  
[SwapUInt16] uint=23 > result uint=5888  
[SwapUInt16ToBytes] uint=23 > result bytes=0017  
[TestSwap] Done  
[TestModbusCRC16] Start  
[ModbusCRC16Test] Frame=01030000000A  
[ModbusCRC16] CRC bytes [low, high]=C5CD  
[ModbusCRC16UInt] CRC numeric=0xCDC5 (decimal=52677)  
[ModbusCRC16TransmittedFrame] Transmitted frame=01030000000AC5CD  
[ModbusCRC16Check] CRC valid (1=true)? 1  
[TestModbusCRC16] Done  
[TestBitWise] Start  
[SetBit] Set bit 3 for value 0. result=8  
[SetBit] Clear bit 3 for value 8. result=0  
[ToggleBit] Toggle bit 3 for value 8. result=0  
[ToggleBit] Toggle bit 1 for value 0. result=2  
[GetBit] Get bit 3 for value 8=1  
[GetBit] Get bit 2 for value 8=0  
[ByteToBitsString] b=170, bitsstring=10101010  
[BytesToBitsString] Byte 1=5, byte 2=170. result=0000010110101010  
[TestBitWise] Done  
[TestCSVParsing] Start  
[CSVToBytes][E] Empty item at index 4 not allowed.  
[CSVToBytes] string=1,21,39,   255   ,, > result=0 bytes  
[CSVToInts] string=1,20,300,4000 > result=4 ints  
[CVSToInts] 1  
[CVSToInts] 20  
[CVSToInts] 300  
[CVSToInts] 4000  
[CSVToUInts] string=1,2,3 > result=3 ints  
[CSVToUInts] 1  
[CSVToUInts] 2  
[CSVToUInts] 3  
[CSVToFloats] string=1,2.234,-3,4.23,5.1 > result=5 floats  
[CSVToFloats] 1  
[CSVToFloats] 2.2340  
[CSVToFloats] -3  
[CSVToFloats] 4.2300  
[CSVToFloats] 5.1000  
[TestCSVParsing] Done  
[TestByteConverter] bytes=255,10,9 > result HEX=FF0A09  
[Main.AppStart] Done
```

  

---

  
  
**Function Index**  
(Taken from Convert.bas)  

```B4X
'– Bytes –  
'ByteToBool(bytes) : First byte "1" > True, Else False.  
'ByteToInt(bytes) : ASCII digit byte "0"-"9" > integer 0–9.  
'BytesToHex(bytes) : Byte Array > hex string.  
'OneByteToHex(byte) : Convert single byte To HEX string.  
'TwoBytesToHex(b1,b2) : Convert 2 bytes To HEX string.  
'ReverseBytes(b) : Reverse byte order in Array.  
'BytesToString(b): Convert bytes to string.  
'  
'– Bool –  
'BoolToString(state) : True > "1", False > "0".  
'BoolToOnOff(state) : True > "ON", False > "OFF".  
'OnOffToBool(value) : "ON"/"On"/"on"/"oN" > True.  
'IntToBool(value) : Convert int To bool.  
'  
'– UInt –  
'UIntToBytes(value) : 16-Bit unsigned > little-endian bytes.  
'BytesToUInt(b) : Little-endian 2 bytes > unsigned 16-Bit.  
'UIntToHex(value) : Converts an UInt To HEX string with 2 bytes.  
'  
'– ULong –  
'ULongToBytes(value) : 32-Bit unsigned > little-endian bytes.  
'BytesToULong(b) : Little-endian 4 bytes > unsigned 32-Bit.  
'ULongToHex(value) : Converts an ULong To HEX string with 4 bytes.  
'  
'– Float –  
'FloatToBytes(value) : 32-Bit float > little-endian bytes.  
'BytesToFloat(b) : Little-endian 4 bytes > 32-Bit float.  
'  
'– Bin –  
'ByteToBin(b) : Convert 0–255 byte > "xxxxxxxx" binary string.  
'BytesToBin(b()) : Converts byte array to a binary string representation.  
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
'ToUpperCase(s) : ASCII lowercase > uppercase.  
'ToLowerCase(s) : ASCII uppercase > lowercase.  
'EqualsIgnoreCase(s1,s2) : Compare ignoring ASCII Case.  
'ReplaceString(orig,search,repl) : Replace all occurrences in byte Array.  
'AsciiBufferToInt(buffer) : Convert buffer containing ASCII digits To an integer.  
'  
'– Modbus CRC-16 –  
'ModbusCRC16(frame) : Calculate CRC16 (Modbus RTU) And Return As 2-byte Array in little-endian order: [low byte, high byte].  
'ModbusCRC16UInt(frame) : Calculate CRC16 (Modbus RTU) And Return As numeric 16-Bit value [high byte, low byte].  
'ModbusCRC16TransmittedFrame(frame) : Append CRC16 To the end of a frame (low byte first, high byte second).  
'ModbusCheckCRC16 : Validate that a frame ends with the correct Modbus CRC.  
'ModbusCRC16Test(frame) : Test the Modbus CRC16 functions For a frame.  
'  
'– BitWise —  
'SetBit(b, index, on) : Sets Or clears a Bit in a byte at the given index.  
'ToggleBit(b, index) : Flips (toggles) a Bit in a byte at the given index.  
'GetBit(b, index) : Tests If a Bit at the given index in a byte is set.  
'ByteToBitsString(b) : Converts a single byte To an 8-character binary string (same As ByteToBin).  
'BytesToBitsString)b()) : Converts a byte Array To a binary string representation (same As BytesToBin).  
'  
' – CSV Parsing –  
'CSVCountItems: Get the number of items from a CSV string.  
'CSVToBytes: Split number items from a CSV string to a byte array.  
'CSVToInts: Split number items from a CSV string to an int array.  
'CSVToUInts: Split number items from a CSV string to an uint array.  
'CSVToULongs: Split number items from a CSV string to an ulong array.  
'CSVToFloats: Split number items from a CSV string to a floats array.  
'  
' – Misc –  
'DirectionToString(direction) : Convert direction given as byte to string.  
'MillisToBytes(millis): Convert milliseconds to hh:mm:ss string
```

  

---

  
  
**Licence**  
MIT.