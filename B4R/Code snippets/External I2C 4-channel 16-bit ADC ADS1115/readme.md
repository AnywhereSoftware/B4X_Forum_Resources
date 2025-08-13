### External I2C 4-channel 16-bit ADC ADS1115 by peacemaker
### 01/29/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/158911/)

After checking several libraries for ADS1115 usage (for maximally fast IC reading) i have stopped and chosen [this tutorial](https://www.b4x.com/android/forum/threads/node-red-mqtt-controlling-8-8-digital-inp-out-and-i2c-adc-on-esp32.141371/) (with native B4R code) and prepared an universal module.  
  

- A 3rd MCU pin for interruption when the ADC measurement is finished (excepting 2 pins for I2C bus) is not used
- But delay for waiting the ADC result is used due to the MCU may hang and reboot sometimes if to read asynchronously as fast as needed
- I2C bus speed is set to 800000 bps for better performance (tests show that speed > 800 kbps does not help to read faster)
- Pre-checking that chip is really present on the declared I2C-bus address
- Reading all 4 channels, setup to max samples per second
- After reading - calculating the output values with scale factor of optional resistive divider and needed values range (example code is for measuring positive polarity voltage up to 4V DC)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    esp_ads1115.Start_ads1115  
End Sub
```

  
  

```B4X
'module esp_ads1115  
'v.0.3  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    '**********************************************  
    'ADC I2C  
    Private bc As ByteConverter  
    Private Wire As WireMaster  
    Private deviceaddress As Byte    'ignore, for inline-C  
    Private wireerror As Byte = 55    'ignore, for inline-C  
  
    Private ADC1115 As Byte = 0x48    'default i2c address  
    Private ADC_Address As Byte = ADC1115  
    Private const ADC_Channels As Byte = 4     
    Private Volt(ADC_Channels) As Double    'result voltages  
      
    Private Configs(ADC_Channels) As Int  
    Private Ranges(ADC_Channels) As Double  
                        
    '                             1111 0100 0010 0011    'legend  
    '                              |   |  | |||  |||| - 0011=comparator is disabled  
    '                              |   |  | 000  8 SPS  
    '                              |   |  | 001 16 SPS  
    '                              |   |  | 010 32 SPS  
    '                              |   |  | ….  
    '                              |   |  | 100 128 SPS (default)  
    '                              |   |  | ….  
    '                              |   |  | 111 860 SPS  
    '                              |   |  |  
    '                              |   |  Mode 0=cont. conversion 1=Single-shot  
    '                              |   |  
    '                              |   000 6.144V  
    '                              |   001 4.096V - used this  
    '                              |   010 2.048V (DEFAULT)  
    '                              |   011 1.024V  
    '                              |   100 0.512V  
    '                              |   11x 0.256V  
    '                              000 = AINp=AIN0 And AINn=AIN1 (default)  
    '                              001 = AINp=AIN0 And AINn=AIN3  
    '                              010 = AINp=AIN1 And AINn=AIN3  
    '                              011 = AINp=AIN2 And AINn=AIN3  
    '                              100 = AINp=AIN0 And AINn=GND - used these 4 single polarity  
    '                              101 = AINp=AIN1 And AINn=GND  
    '                              110 = AINp=AIN2 And AINn=GND  
    '                              111 = AINp=AIN3 And AINn=GND  
  
    Private ADCChannel As Byte  
    '**********************************************  
    Private Timer1 As Timer  
    Dim Ready_flag As Boolean  
      
    Private ResistorDividers(ADC_Channels) As Double  
    Private MinValues(ADC_Channels) As Double  
    Private MaxValues(ADC_Channels) As Double  
    Public Values(ADC_Channels) As Double    'result measurements  
End Sub  
  
Sub Start_ads1115  
    '********************************************************  
    Configs(0) =  0xC2E3    '1100 0010 1110 0011    +AN0 -GND 4,096 V  
    Ranges(0) = 4.096  
    Configs(1) =  0xD2E3    '1101 0010 1110 0011    +AN1 -GND 4,096 V  
    Ranges(1) = 4.096  
    Configs(2) =  0xE2E3    '1110 0010 1110 0011    +AN2 -GND 4,096 V  
    Ranges(2) = 4.096  
    Configs(3) =  0xF2E3    '1111 0010 1110 0011    +AN3 -GND 4,096 V  
    Ranges(3) = 4.096  
      
    ResistorDividers(0) = 1    '390 / 270    'kOhm, Rout / Rin  
    ResistorDividers(1) = 1  
    ResistorDividers(2) = 1  
    ResistorDividers(3) = 1  
      
    MinValues(0) = 0        'needed output converted (measured) value range, low limit, channel 0  
    MaxValues(0) = 100        'needed output converted (measured) value range, high limit, channel 0  
    MinValues(1) = 0        'needed output converted (measured) value range, low limit, channel 1  
    MaxValues(1) = 100        'needed output converted (measured) value range, high limit, channel 1  
    MinValues(2) = 0        'needed output converted (measured) value range, low limit, channel 2  
    MaxValues(2) = 100        'needed output converted (measured) value range, high limit, channel 2  
    MinValues(3) = 0        'needed output converted (measured) value range, low limit, channel 3  
    MaxValues(3) = 100        'needed output converted (measured) value range, high limit, channel 3  
      
      
    Wire.Initialize  
      
    Log("Start reading ads1115…")  
    Ready_flag = False  
      
    '——-test if device presents—–  
        deviceaddress = ADC1115  
        RunNative("SetWireClock", 800000)  
        RunNative("icwirebegintransmisson", Null)  
        RunNative("icwireendtransmisson", Null)  
        Dim b(1) As Byte  
        b(0) = ADC1115  
        If wireerror = 0 Then  
            Log("ADC1115 I2C device found at address: 0x", bc.HexFromBytes(b), " (", ADC1115, ")")  
        Else  
            Log("ADC1115 device was not found at 0x", bc.HexFromBytes(b), " (", ADC1115, ")")  
            Return  
        End If  
    '—————————-  
    Set_ADC (Configs(0))  
    ADCChannel = 0  
    ADC_Address = ADC1115  
      
    Timer1.Initialize("Timer1_Tick", 20)    '20 = OK  
    Timer1.Enabled = True  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("esp_ads1115 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    Dim ADCV As Int = ADC_SS_read(Configs(ADCChannel))  
    Volt(ADCChannel) = Convert_2_Volt(ADCV, Ranges(ADCChannel)) / ResistorDividers(ADCChannel)  
    Values(ADCChannel) = doubleMap(Volt(ADCChannel), 0, Ranges(ADCChannel), MinValues(ADCChannel), MaxValues(ADCChannel))  
    Log("Volt(", ADCChannel, ") = ", Volt(ADCChannel), "; ", Values(ADCChannel))  
    ADCChannel = ADCChannel + 1  
    If ADCChannel = ADC_Channels Then  
        Ready_flag = True  
        ADCChannel = 0  
    End If  
End Sub  
  
'Config ADC  
Private Sub Set_ADC (Config As Int)  
    'Set config register 0x1  
    Wire.WriteTo(ADC_Address, Array As Byte(0x1, Bit.HighByte(Config), Bit.LowByte(Config)))  
    'Select ADC conversion register 0x0  
    '                                0x0 = conversion register  
    '                                        |  
    '                                        v  
    Wire.WriteTo(ADC_Address, Array As Byte(0x0))  
End Sub  
  
'Read ADC single shot, return ADC value Int  
Private Sub ADC_SS_read (Config As Int) As Int  
    'Set config register 0x1  
    Config = Bit.Or(Config, 0x0100)  
  
    'ADC config and start conversion  
    Set_ADC(Config)  
  
    'get Samples per Seconds setting  
    Dim SPS As UInt = Bit.ShiftRight(Bit.And(Bit.LowByte(Config), 0xE0),5)  
      
    'conversion time from 125 to 1,16 mS (8 to 860 SPS)  
    Dim Mdelay As UInt  
      
    Select SPS  
        Case 0   '8  
            Mdelay = 1000000 / 8  
        Case 1   '16  
            Mdelay = 1000000 / 16  
        Case 2   '32  
            Mdelay = 1000000 / 32  
        Case 3   '64  
            Mdelay = 1000000 / 64  
        Case 4   '128  
            Mdelay = 1000000 / 128  
        Case 5   '250  
            Mdelay = 1000000 / 250  
        Case 6   '475  
            Mdelay = 1000000 / 475  
        Case 7   '860  
            Mdelay = 1000000 / 860  
    End Select  
    DelayMicroseconds(Mdelay)   'wait for conversion  
    'read ADC  
    Return Read_ADC2  
End Sub  
  
'Read ADC return array High - Low  
Private Sub Read_ADC () As Byte()  
    Return Wire.RequestFrom(ADC_Address, 2)    'High - Low  
End Sub  
  
  
'Read ADC return Int number  
Private Sub Read_ADC2 () As Int  
    Dim data() As Byte = Read_ADC  
    Return Bit.Shiftleft(data(0),8) + data(1)    'Convert array to Int and return it  
End Sub  
  
'Convert ADC number to Volt  
Private Sub Convert_2_Volt (ADC_Value As Int, Range As Float) As Float  
    Return (ADC_Value * Range / 32767)  
End Sub  
  
'Read ADC return Vols  
Private Sub Read_Volt (Range As Float) As Float  
    Dim data() As Byte = Read_ADC    'alternate reading  
    Return (Bit.Shiftleft(data(0),8) + data(1)) * Range / 32767  
End Sub  
  
Public Sub doubleMap(analoginputvalue As Double,in_min As Double,in_max As Double,out_min As Double,out_max As Double) As Double  
    Dim a As Double = (analoginputvalue - in_min) * (out_max - out_min) / (in_max - in_min) + out_min  
    Return a  
End Sub  
  
  
#if C  
#include <Wire.h>  
void icwirebegintransmisson (B4R::Object* o) {  
   Wire.beginTransmission(b4r_esp_ads1115::_deviceaddress);  
}  
  
void icwireendtransmisson (B4R::Object* o) {  
  b4r_esp_ads1115::_wireerror = Wire.endTransmission();  
}  
  
void SetWireClock(B4R::Object* o) {  
   Wire.setClock (o->toULong());  
}  
  
#End if
```

  
[SPOILER="prev version"]  

```B4X
'module esp_ads1115  
'v.0.2  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    '**********************************************  
    'ADC I2C  
    Private bc As ByteConverter  
    Private Wire As WireMaster  
    Private deviceaddress As Byte    'ignore, for inline-C  
    Private wireerror As Byte = 55    'ignore, for inline-C  
  
    Private ADC1115 As Byte = 0x48    'default i2c address  
    Private ADC_Address As Byte = ADC1115  
    Private ADC_Channel As Byte = 4  
    Private Volt(ADC_Channel) As Double    'result voltages  
  
    '                          1100 0010 1110 0011     '+AN0 -GND 4,096 V  
    Private Config0 As Int =  0xC2E3                   '+AN0 -GND 4,096 V  
    Private Range0 As Float = 4.096  
    '                           1101 0010 1110 0011     '+AN1 -GND 4,096 V  
    Private Config1 As Int =  0xD2E3                      '+AN1 -GND 4,096 V  
    Private Range1 As Float = 4.096  
    '                           1110 0010 1110 0011     '+AN2 -GND 4,096 V  
    Private Config2 As Int =  0xE2E3                   '+AN2 -GND 4,096 V  
    Private Range2 As Float = 4.096  
    '                           1111 0010 1110 0011     '+AN3 -GND 4,096 V  
    Private Config3 As Int =  0xF2E3                   '+AN3 -GND 4,096 V  
    Private Range3 As Float = 4.096  
    '  
    '                             1111 0100 0010 0011    'legend  
    '                              |   |  | |||  |||| - 0011=comparator is disabled  
    '                              |   |  | 000  8 SPS  
    '                              |   |  | 001 16 SPS  
    '                              |   |  | 010 32 SPS  
    '                              |   |  | ….  
    '                              |   |  | 100 128 SPS (default)  
    '                              |   |  | ….  
    '                              |   |  | 111 860 SPS  
    '                              |   |  |  
    '                              |   |  Mode 0=cont. conversion 1=Single-shot  
    '                              |   |  
    '                              |   000 6.144V  
    '                              |   001 4.096V - used this  
    '                              |   010 2.048V (DEFAULT)  
    '                              |   011 1.024V  
    '                              |   100 0.512V  
    '                              |   11x 0.256V  
    '                              000 = AINp=AIN0 And AINn=AIN1 (default)  
    '                              001 = AINp=AIN0 And AINn=AIN3  
    '                              010 = AINp=AIN1 And AINn=AIN3  
    '                              011 = AINp=AIN2 And AINn=AIN3  
    '                              100 = AINp=AIN0 And AINn=GND - used these 4 single polarity  
    '                              101 = AINp=AIN1 And AINn=GND  
    '                              110 = AINp=AIN2 And AINn=GND  
    '                              111 = AINp=AIN3 And AINn=GND  
  
    Private ADCChannel As Byte  
    '**********************************************  
    Private Timer1 As Timer  
    Dim Ready_flag As Boolean  
   
    Private ResistorDivider0 As Double = 1    '390 / 270    'kOhm, Rout / Rin  
    Private ResistorDivider1 As Double = 1  
    Private ResistorDivider2 As Double = 1  
    Private ResistorDivider3 As Double = 1  
   
    Private MinValue0 As Double = 0    'needed output converted (measured) value range, low limit, channel 0  
    Private MaxValue0 As Double = 100    'needed output converted (measured) value range, high limit, channel 0  
    Private MinValue1 As Double = 0  
    Private MaxValue1 As Double = 100  
    Private MinValue2 As Double = 0  
    Private MaxValue2 As Double = 100  
    Private MinValue3 As Double = 0  
    Private MaxValue3 As Double = 100  
    Public Values(ADC_Channel) As Double    'result measurements  
End Sub  
  
Sub Start_ads1115  
    '********************************************************  
    'ADC I2C  
    'Data on Lolin32 - ESP32  
    '96,15kHz , 10,4uS clock  
    'config = 9+9+9+9 = 36x10 = 375uS about  
    'sel conf reg. = 9+9 = 18x10= 187uS about  
    'read conv. = 9+9+9 = 27x10= 280uS about  
    'read-set-next = 280+375+187 = 842 uS about  
    Wire.Initialize  
   
    Log("Start reading ads1115…")  
    Ready_flag = False  
   
    '——-test if device presents—–  
        deviceaddress = ADC1115  
        RunNative("SetWireClock", 800000)  
        RunNative("icwirebegintransmisson", Null)  
        RunNative("icwireendtransmisson", Null)  
        Dim b(1) As Byte  
        b(0) = ADC1115  
        If wireerror = 0 Then  
            Log("ADC1115 I2C device found at address: 0x", bc.HexFromBytes(b), " (", ADC1115, ")")  
        Else  
            Log("ADC1115 device was not found at 0x", bc.HexFromBytes(b), " (", ADC1115, ")")  
            Return  
        End If  
    '—————————-  
    Set_ADC (Config0)  
    ADCChannel = 0  
    ADC_Address = ADC1115  
   
    Timer1.Initialize("Timer1_Tick", 20)    '20 = OK  
    Timer1.Enabled = True  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("esp_ads1115 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    Select ADCChannel  
        Case 0  
            Dim ADCV As Int = ADC_SS_read(Config0)  
            Volt(0) = Convert_2_Volt (ADCV, Range0) / ResistorDivider0  
            Values(0) = CalcValue  
            Log("Volt(0) = ", Volt(0), "; ", Values(0))  
            ADCChannel = 1  
        Case 1  
            Dim ADCV As Int = ADC_SS_read(Config1)  
            Volt(1) = Convert_2_Volt (ADCV, Range1) / ResistorDivider1  
            Values(1) = CalcValue  
            Log("Volt(1) = ", Volt(1), "; ", Values(1))  
            ADCChannel = 2  
        Case 2  
            Dim ADCV As Int = ADC_SS_read(Config2)  
            Volt(2) = Convert_2_Volt (ADCV, Range2) / ResistorDivider2  
            Values(2) = CalcValue  
            Log("Volt(2) = ", Volt(2), "; ", Values(2))  
            ADCChannel = 3  
        Case 3  
            Dim ADCV As Int = ADC_SS_read(Config3)  
            Volt(3) = Convert_2_Volt (ADCV, Range3) / ResistorDivider3  
            Values(3) = CalcValue  
            Log("Volt(3) = ", Volt(3), "; ", Values(3))  
            ADCChannel = 0  
        
            Ready_flag = True  
    End Select  
   
End Sub  
  
Private Sub CalcValue As Double  
    Dim a As Double  
    Select ADCChannel  
        Case 0  
            a = doubleMap(Volt(0), 0, Range0, MinValue0, MaxValue0)  
        Case 1  
            a = doubleMap(Volt(1), 0, Range1, MinValue1, MaxValue1)  
        Case 2  
            a = doubleMap(Volt(2), 0, Range2, MinValue2, MaxValue2)  
        Case 3  
            a = doubleMap(Volt(3), 0, Range3, MinValue3, MaxValue3)  
    End Select  
    Return a  
End Sub  
  
'Config ADC  
Private Sub Set_ADC (Config As Int)  
    'Set config register 0x1  
    Wire.WriteTo(ADC_Address, Array As Byte(0x1, Bit.HighByte(Config), Bit.LowByte(Config)))  
    'Select ADC conversion register 0x0  
    '                                0x0 = conversion register  
    '                                        |  
    '                                        v  
    Wire.WriteTo(ADC_Address, Array As Byte(0x0))  
End Sub  
  
'Read ADC single shot, return ADC value Int  
Private Sub ADC_SS_read (Config As Int) As Int  
    Dim Mdelay As UInt  
  
    'Set config register 0x1  
    Config = Bit.Or (Config,0x0100)  
  
    'ADC config and start conversion  
    Wire.WriteTo(ADC_Address, Array As Byte(0x1, Bit.HighByte(Config), Bit.LowByte(Config)))  '36clk -> 370uS  
    'select conversion register for read  
    Wire.WriteTo(ADC_Address, Array As Byte(0x0))                                             '18clk = 187 uS  
  
    'get Samples per Seconds setting  
    Dim SPS As UInt = Bit.ShiftRight(Bit.And(Bit.LowByte(Config), 0xE0),5)  
   
    'conversion time from 125 to 1,16 mS (8 to 860 SPS)  
    Select SPS  
        Case 0   '8  
            Mdelay = 1000000 / 8  
        Case 1   '16  
            Mdelay = 1000000 / 16  
        Case 2   '32  
            Mdelay = 1000000 / 32  
        Case 3   '64  
            Mdelay = 1000000 / 64  
        Case 4   '128  
            Mdelay = 1000000 / 128  
        Case 5   '250  
            Mdelay = 1000000 / 250  
        Case 6   '475  
            Mdelay = 1000000 / 475  
        Case 7   '860  
            Mdelay = 1000000 / 860  
    End Select  
  
    DelayMicroseconds(Mdelay)   'wait for conversion  
    'read ADC  
    Dim data() As Byte = Wire.RequestFrom(ADC_Address, 2)  
    Return Bit.Shiftleft(data(0),8) + data(1)    'Covert array to Int and return it  
End Sub  
  
  
'Read ADC return array High - Low  
Private Sub Read_ADC () As Byte()  
    Return Wire.RequestFrom(ADC_Address, 2)    'High - Low  
End Sub  
  
  
'Read ADC return Int number  
Private Sub Read_ADC2 () As Int  
    Dim data() As Byte = Wire.RequestFrom(ADC_Address, 2)  
    Return Bit.Shiftleft(data(0),8) + data(1)  
End Sub  
  
'Convert ADC number to Volt  
Private Sub Convert_2_Volt (ADC_Value As Int, Range As Float) As Float  
    Return (ADC_Value * Range / 32767)  
End Sub  
  
'Read ADC return Vols  
Private Sub Read_Volt (Range As Float) As Float  
    Dim data() As Byte = Read_ADC    'alternate reading  
    Return (Bit.Shiftleft(data(0),8) + data(1)) * Range / 32767  
End Sub  
  
Public Sub doubleMap(analoginputvalue As Double,in_min As Double,in_max As Double,out_min As Double,out_max As Double) As Double  
    Dim a As Double = (analoginputvalue - in_min) * (out_max - out_min) / (in_max - in_min) + out_min  
    Return a  
End Sub  
  
  
#if C  
#include <Wire.h>  
void icwirebegintransmisson (B4R::Object* o) {  
   Wire.beginTransmission(b4r_esp_ads1115::_deviceaddress);  
}  
  
void icwireendtransmisson (B4R::Object* o) {  
  b4r_esp_ads1115::_wireerror = Wire.endTransmission();  
}  
  
void SetWireClock(B4R::Object* o) {  
   Wire.setClock (o->toULong());  
}  
  
#End if
```

[/SPOILER]