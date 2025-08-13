### Writing & Reading Serial EEPROM 24C512 With Arduino Uno Using rWire by embedded
### 01/18/2024
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/158706/)

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private Wire As WireMaster  
    Dim bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    Wire.Initialize  
    Write_EEPROM  
End Sub  
  
Sub Write_EEPROM  
    Wire.WriteTo2(0x50,True,Array As Byte(00,00,01,02,03,04))'Writing 1,2,3,4 from memory address 00  
    Log("WRITING COMPLETE")  
    Delay(3000)  
    READ_EEPROM  
End Sub  
  
Sub READ_EEPROM  
    Dim b() As Byte  
    Wire.WriteTo2(0x50,True,Array As Byte(0,0))'24c512 set register pointer to 00 memory address  
    b=Wire.RequestFrom(0x50,4)'read first memory address  
    Log(bc.HexFromBytes(b))   'display it in string  
    Log("reading complete")  
End Sub
```