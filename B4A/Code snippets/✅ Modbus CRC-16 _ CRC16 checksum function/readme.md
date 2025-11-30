### ✅ Modbus CRC-16 / CRC16 checksum function by Peter Simpson
### 11/28/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/169463/)

**SubName:** Modbus CRC-16 is used to ensure data integrity in Modbus RTU (**R**emote **T**erminal **U**nit) communications.  
**Description:** This function takes a command message Bytes and performs the necessary bitwise operations to generate a **16-bit CRC checksum**, and outputs this checksum as a hexadecimal string.  
  
The following code calculates the Modbus RTU CRC-16 (LSB-first / little-endian), the standard CRC (**C**yclic **R**edundancy **C**heck) used for Modbus frames.  
  
Let's use **010107DE000A** as an example to calculated it's Modbus CRC-16 value, which is **43DD**.  

```B4X
    Dim BC As ByteConverter  
    Dim Data() As Byte = BC.HexToBytes("010107DE000A")  
    Log(CalcModbusCRC(Data))
```

  

```B4X
Sub CalcModbusCRC(Bytes() As Byte) As String  
    Dim CRCr As Int = 0xFFFF  
    For i = 0 To Bytes.Length - 1  
        CRCr = Bit.Xor(CRCr, Bit.And(Bytes(i), 0xFF))  
        For j = 0 To 7  
            If (Bit.And(CRCr, 1) = 1) Then  
                CRCr = Bit.Xor(Bit.ShiftRight(CRCr, 1), 0xA001)  
            Else  
                CRCr = Bit.ShiftRight(CRCr, 1)  
            End If  
        Next  
    Next  
   
    'Low byte first (Modbus standard)  
    Dim low As Int = Bit.And(CRCr, 0xFF)  
    Dim high As Int = Bit.And(Bit.ShiftRight(CRCr, 8), 0xFF)  
  
    Return Bit.ToHexString(high).ToUpperCase & Bit.ToHexString(low).ToUpperCase  
End Sub
```

  
  
The full Modbus RTU frame that would be transmitted is 01 01 07 DE 00 0A **43 DD**.  
  
**Here is the byte by byte Breakdown**  
[TABLE]  
[TR]  
[TH]Hex Value[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]01[/TD]  
[TD]Slave Address (Unit ID): The address of the device being targeted.[/TD]  
[/TR]  
[TR]  
[TD]01[/TD]  
[TD]Function Code: Read Coils (Discrete Outputs).[/TD]  
[/TR]  
[TR]  
[TD]07DE[/TD]  
[TD]Starting Address: The address of the first coil to read (7DE hex = 2014 decimal).[/TD]  
[/TR]  
[TR]  
[TD]000A[/TD]  
[TD]Quantity: The number of coils to read (0A hex = 10 decimal).[/TD]  
[/TR]  
[TR]  
[TD]**43**[/TD]  
[TD]**CRC** Low Byte: The Least Significant Byte of the CRC.[/TD]  
[/TR]  
[TR]  
[TD]**DD**[/TD]  
  
[TD][TABLE]  
[TR]  
[TD]**CRC** High Byte: The Most Significant Byte of the CRC.[/TD]  
[/TR]  
[/TABLE][/TD]  
[/TR]  
[/TABLE]  
  
  
**Enjoy…**