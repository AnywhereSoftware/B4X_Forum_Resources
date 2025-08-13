### Reading & Writing Time of DS1307 With ESP32 Using rWire by embedded
### 06/01/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/148252/)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private Wire As WireMaster  
    Dim Sec,Minute,Hour As Byte  
    Private Timer1 As Timer  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  'GPIO 22–SDA GPIO 21-SCL  
    Log("AppStart")              'Tested ok on 01/06/23  
    Wire.Initialize               'Tiny RTC Module  
    Delay(10)                     'DS1307 address-0x68  
    Timer1.Initialize("Timer1_Tick",1000)  
    Timer1.Enabled=True            'only time is show here  
End Sub  
  
Sub Timer1_Tick  
    Log("tmr running")  
    Read_RTC  
End Sub  
  
Sub Read_RTC  
    'Log("read rtc sub")  
    Dim B(7) As Byte  
    Wire.WriteTo2(0x68,True,Array As Byte(0))'ds1307 set register pointer to zero  
    B=Wire.RequestFrom(0x68,7) 'read first seven register contain sec,min,day,hour,date,month,year  
    Log("secinBCD=",B(0))  
    Log("mininBCD=",B(1))  
    Log("hourinBCD=",B(2))  
    Sec=BCD_2_decimal(B(0))  
    Minute=BCD_2_decimal(B(1))  
    Hour=BCD_2_decimal(B(2))  
    Log("Time ",Hour,":",Minute,":",Sec)  
    Log("stackBufferUse=",StackBufferUsage)  
    'Read_RTC  
End Sub  
  
Sub BCD_2_decimal(value As Byte) As Byte  
    Dim MSB,LSB,DecValue As Byte  
    MSB=value/16  
    LSB=value Mod 16  
    DecValue=(MSB*10)+LSB  
    Return DecValue  
End Sub  
  
'—————————————————————– Set time to DS1307 ——————————————————————  
  
Sub Set_Time_DS1307  
    Dim mySEC,myMin,myHour,myDay,myDATE,myMONTH,myYear As Byte  
    Dim data(8) As Byte  
    mySEC=00  
    myMin=03  
    myHour=23  
    myDay=4  
    myDATE=1  
    myMONTH=6  
    myYear=23  
    data(0)=0  
      
    data(1)=Decimal_2_BCD(mySEC)  
    data(2)=Decimal_2_BCD(myMin)  
    data(3)=Decimal_2_BCD(myHour)  
    data(4)=Decimal_2_BCD(myDay)  
    data(5)=Decimal_2_BCD(myDATE)  
    data(6)=Decimal_2_BCD(myMONTH)  
    data(7)=Decimal_2_BCD(myYear)  
    wire.WriteTo2(0x68,True,data)  
    Log(" DS1307 bcd write complete")  
End Sub  
  
Sub Decimal_2_BCD(value As Byte)As Byte  
    Dim MSB,LSB,bcdValue As Byte  
    MSB=value/10  
    LSB=value Mod 10  
    bcdValue=(MSB*16)+LSB  
    Return bcdValue  
End Sub
```