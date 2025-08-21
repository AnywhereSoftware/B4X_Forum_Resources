### Setting and Reading date and time of a DS1302 (RTC) without a library by Johan Schoeman
### 12/26/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/112488/)

I have one of the "MH-REAL-TIME CLOCK MODULES - 2" with a DS1302 chip. I thought it would be interesting to see if I could read the seconds, minutes, hours, year, month, day of month, and day of week from the module without making use of a library i.e hard coding the data extraction as a learning exercise.  
  
Found the attached PDF document that explains the command / address details of how to read and write to the module. Have used a Nano and assigned pins 10, 11, and 12 to serve as the CLK, DAT, and RST lines respectively that are connected to the RTC module.  
  
Attached is my B4R sample project - by no means whatsoever optimised at all. Just wanted to see if I could extract the data from the module. So, in the B4R project I control the RST (or CE) line and the CLK line via simple B4R code and clock in the commands / addresses via the DAT (I/O) line (pin 11 in output mode) and then switch pin 11 to input mode to read the response from the module while controlling the CLK line.  
  
I guess writing / setting the module with new date / time info will be much a similar exercise - for whoever might be interested to do so.  
  
Extract from the code:  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
      
    Dim pclk, pdat, prst As Pin          'clock, I/O, CE  
    Dim seconds10, seconds1, seconds As Byte = 0  
    Dim minutes10, minutes1, minutes As Byte = 0  
    Dim hours10, hours1, hours As Byte = 0  
    Dim years10, years1, years As Byte = 0  
    Dim months10, months1, months As Byte = 0  
    Dim days10, days1, days As Byte = 0  
    Dim weekdays10, weekdays1, weekdays As Byte = 0  
      
    Dim data As Byte  
      
    Dim t As Timer  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
      
    t.Initialize("t_tick", 1000)  
    data = 0  
      
    pclk.Initialize(10, pclk.MODE_OUTPUT)  
    pdat.Initialize(11, pdat.MODE_OUTPUT)  
    prst.Initialize(12, prst.MODE_OUTPUT)  
      
    t.Enabled = True  
      
    pclk.DigitalWrite(False)  
    pdat.DigitalWrite(False)  
    prst.digitalwrite(False)  
      
'    AddLooper("myLooper")  
      
      
      
End Sub  
  
Sub t_tick  
      
    getSeconds  
    getMinutes  
    getHours  
    getYear  
    getMonth  
    getDayOfMonth  
    getDayOfWeek  
    Log(" ")  
      
      
End Sub  
  
Sub getSeconds  
      
    '81h = read Seconds (1000 0001) -> need to clock in 81h via the I/O line with the I/O line set to mode output (in this example I/O line = pin 11)  
      
    prst.Digitalwrite(True)                      'pull CE high                  '  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(True)            '1               LSB  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(False)           '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(False)            '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(False)            '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
      
      
      
    pdat.DigitalWrite(False)           '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
      
    pdat.DigitalWrite(False)           '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(False)           '0  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    pdat.DigitalWrite(True)            '1         MSB  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
      
    data = 0  
      
    pdat.Initialize(11, pdat.MODE_INPUT)                  'set the I/O line to mode input to read the response from the RTC (DS1302) module  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 1)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 2)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 4)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 8)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 16)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 32)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 64)  
    DelayMicroseconds(4)  
      
    pclk.DigitalWrite(True)  
    DelayMicroseconds(4)  
    pclk.DigitalWrite(False)  
    DelayMicroseconds(4)  
    If pdat.DigitalRead = True Then data = Bit.Or(data, 128)  
    DelayMicroseconds(4)  
      
    prst.DigitalWrite(False)                 'pull CE low  
      
    seconds10 = 0  
    seconds1 = 0  
    seconds1 = Bit.And(data, 0x0f)  
    seconds10 = Bit.And(data, 0xf0)  
    seconds10 = Bit.ShiftRight(seconds10,4)  
    seconds = (seconds10 * 10) + seconds1  
    Log("SECONDS = ", seconds)  
  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/86725)  
  
  
![](https://www.b4x.com/android/forum/attachments/86726)