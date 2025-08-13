### MCP3204 12bit ADC with ESP32 by embedded
### 11/19/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/144260/)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Public CSPin As Pin  
    Public Timer1 As Timer  
    Public rs As RandomAccessFile  
    Dim ADC As UInt  
    Dim ADC_H As UInt  
    Dim FINAL_ADC As UInt  
  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    CSPin.Initialize(15, CSPin.MODE_OUTPUT)  
  
   
   
    SPI.CheckIfThisBoardIsSupported  
  
    '===========================================================================================  
    '===========================================================================================  
    '===========================================================================================  
    '       CHANGE HERE THE PIN NUMBERS (SCK, MISO, MOSI, CS)  
    '===========================================================================================  
    '===========================================================================================  
    SPI.ESP32_SPI_Set_Pins(18,19,23,15)  
    SPI.CSPinDeActivate(SPI.CS__SPI)  
    '===========================================================================================  
    '===========================================================================================  
    '===========================================================================================  
  
   
    Timer1.Initialize("Timer1_Tick",100)  
    Timer1.Enabled=True  
  
   
   
End Sub  
  
Sub Timer1_Tick  
    Log("TIMER RUNNING")  
    read_mcp3204  
End Sub  
  
  
  
Private Sub read_mcp3204  
      
   
      
   
    'SPI.DisableInterrupts  
    SPI.Begin_Transaction(1000000, SPI.MSBFIRST, SPI.SPI_MODE2)  
   
    SPI.CSPinActivate(CSPin)  
    SPI.Transfer_Byte(0x06)  
    Dim Lowbyte,Highbyte As Byte  
    Highbyte=SPI.Transfer_Byte(0x00)  
    Lowbyte=SPI.Transfer_Byte(0x00)  
    Highbyte=Bit.And(Highbyte,15)  
    Log("High byte=",Highbyte)  
    Log("Low byte=",Lowbyte)  
    SPI.CSPinDeActivate(CSPin)  
    ADC=Lowbyte  
    ADC_H=Highbyte  
    ADC_H=Bit.ShiftLeft(ADC_H,8)  
    FINAL_ADC=Bit.Or(ADC_H,ADC)  
    Log("adc value FINAL=",FINAL_ADC)  
    SPI.End_Transaction  
    'SPI.EnableInterrupts  
End Sub
```