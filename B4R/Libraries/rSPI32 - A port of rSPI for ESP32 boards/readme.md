### rSPI32 - A port of rSPI for ESP32 boards by hatzisn
### 12/04/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/136588/)

Good evening everyone,  
  
this library was created by [USER=116903]@Gerardo Tenreiro[/USER] and me. It is a port of the rSPI library for ESP32 boards. I cannot test this library because I don't have (yet) an ESP32 board but it has been tested by [USER=116903]@Gerardo Tenreiro[/USER] and I take his word for it that it works. Due to several on-going projects and limited time I had completely forgot it and I am posting it now [USER=116903]@Gerardo Tenreiro[/USER], sorry for the delay.  
  
  
Core for using it:  
  
  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
   
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
   
   
   
    SPI.CheckIfThisBoardIsSupported  
  
    '===========================================================================================  
    '===========================================================================================  
    '===========================================================================================  
    '       CHANGE HERE THE PIN NUMBERS (SCK, MISO, MOSI, CS)  
    '===========================================================================================  
    '===========================================================================================  
    SPI.ESP32_SPI_Set_Pins(18,19,23,27)  
    SPI.CSPinDeActivate(SPI.CS__SPI)      
    '===========================================================================================  
    '===========================================================================================  
    '===========================================================================================  
  
   
    AddLooper("CommunicateThroughSPI")  
  
   
End Sub  
  
  
Private Sub CommunicateThroughSPI  
    Dim D0_V        As Byte  
    Dim D1_V        As Byte  
    Dim D2_V        As Byte  
    Dim Valor_V        As Double  
   
    SPI.Begin_Transaction(1000000, SPI.MSBFIRST, SPI.SPI_MODE1)    
  
    SPI.CSPinActivate(SPI.CS__SPI)  
   
    SPI.Transfer_Byte(81)  
    SPI.Transfer_Byte(3)  
    SPI.Transfer_Byte(1)  
    SPI.Transfer_Byte(0)  
    SPI.Transfer_Byte(240)  
    SPI.Transfer_Byte(1)  
   
    SPI.Transfer_Byte(1)  
     
  
    SPI.End_Transaction  
   
  
    SPI.Begin_Transaction(1000000, SPI.MSBFIRST, SPI.SPI_MODE2)  
   
   
    D0_V = SPI.Transfer_Byte(0)  
    D1_V = SPI.Transfer_Byte(0)  
    D2_V = SPI.Transfer_Byte(0)  
   
  
    SPI.CSPinDeActivate(SPI.CS__SPI)  
   
  
    SPI.End_Transaction  
   
    ' Calcula el Valor en Bruto de Tension  
    Valor_V =(D0_V * 65536) + (D1_V * 256) + D2_V  
    ' Si es un numero Negativo Realiza el Complemento a 2  
    If (D0_V > 128) Then  
        Valor_V = 16777215 - Valor_V  
        Valor_V = Valor_V * -1  
    End If  
    ' Aplica la Escala de Medida  
    Valor_V = Valor_V * SPI.FET  
   
    Log("V=",Valor_V)  
   
    Delay(500)  
   
End Sub
```