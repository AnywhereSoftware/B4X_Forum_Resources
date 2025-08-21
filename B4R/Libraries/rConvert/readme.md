### rConvert by rwblinn
### 08/16/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168251/)

**B4R Library rConvert**  

---

  
  
**Brief  
rConvert** is a lightweight, open-source helper library for **B4R** that provides practical conversion routines often needed when working with micro-controllers, sensors, and communication protocols.  
  
It includes simple methods for converting between:  
- Unsigned integers (UInt, ULong) and byte arrays  
- Floats and byte arrays (IEEE 754)  
- Numbers and formatted strings  
- Bytes and hexadecimal strings  
- Common convenience helpers (e.g. On/Off > Boolean)  
  

---

  
**Install**  
Copy the *rConvert.b4xlib* into your B4R **Additional Libraries** folder.  
  

---

  
**Example Selected Routines**  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[Main.AppStart]", CRLF)  
  
    Dim testuint As UInt  
    Dim testulong As ULong  
    Dim testfloat As Float  
    Dim testbytes() As Byte  
  
    ' UInt > Bytes (2)  
    testuint = 10  
    testbytes = Convert.UIntToBytes(testuint)  
    Log("[UIntToBytes] int=", testuint, ", result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [UIntToBytes] int=10, result hex=0A00, length=2  
  
    ' Bytes > UInt Note: byte array must be length 2  
    testbytes = Array As Byte(0x0A, 0x00)  
    testuint = Convert.BytesToUInt(testbytes)  
    Log("[BytesToUInt] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length,", uint=", testuint)  
    ' [BytesToUInt] bytes=0A00, length=2, uint=10  
  
    ' ULong > Bytes (4)  
    testulong = 10  
    testbytes = Convert.ULongToBytes(testulong)  
    Log("[ULongToBytes] long=", testulong, ", result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [ULongToBytes] long=10, result hex=0A000000, length=4  
  
    ' Bytes > ULong Note: byte array must be length 4  
    testbytes = Array As Byte(0x0A,0x00,0x00,0x00)  
    testulong = Convert.BytesToULong(testbytes)  
    Log("[BytesToULong] bytes=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length,", ulong=", testulong)  
    ' [BytesToULong] bytes=0A000000, length=4, ulong=10  
  
    ' ULong > String Note: Uses cast  
    Dim teststring As String = testulong  
    Log("[ULongToString Cast] ulong=", testulong, ", teststring=", teststring)  
    ' [ULongToString Cast] ulong=10, teststring=10.00  
  
    ' ULong > String Note: Uses numberformat  
    Dim teststring As String = NumberFormat(testulong, 0, 0)  
    Log("[ULongToString NumberFormat] ulong=", testulong, ", teststring=", teststring)  
    ' [ULongToString NumberFormat] ulong=10, teststring=10.00  
  
    ' Float to bytes  
    testfloat = 18.58  
    testbytes = Convert.FloatToBytes(testfloat)  
    Log("[FloatToBytes] float=", testfloat, ", result hex=", Convert.BytesToHex(testbytes), ", length=",testbytes.Length)  
    ' [FloatToBytes] float=18.5800, result hex=D7A39441  
  
    ' Two Bytes to Hex  
    Dim b1 As Byte = 10  
    Dim b2 As Byte = 15  
    Log("[TwoBytesToHex] b1=", b1, ", b2=", b2, ", result hex=", Convert.TwoBytesToHex(b1, b2))  
    ' [TwoBytesToHex] b1=10, b2=15, result hex=0A0F  
  
    ' OnOff to Bool  
    Log("OnOffToBool] on=", Convert.OnOffToBool("on"), ", off=", Convert.OnOffToBool("off"))  
    ' OnOffToBool] on=1, off=0  
End Sub
```

  
  

---

  
**License**  
MIT