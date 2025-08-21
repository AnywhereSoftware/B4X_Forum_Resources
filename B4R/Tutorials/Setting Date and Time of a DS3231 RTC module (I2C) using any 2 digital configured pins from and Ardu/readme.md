### Setting Date and Time of a DS3231 RTC module (I2C) using any 2 digital configured pins from and Arduino by Johan Schoeman
### 01/18/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/113151/)

The attached project implements the I2C communication protocol to set the Date and Time of a DS3231 RTC module. The protocol is hard coded (i.e no library) and you can therefore use any 2 digital pins of an Arduino Uno/Nano/etc to connect to the SDA and SCL pins of the DS3231.  
  
On the Arduino Nano, the I2C but is tied to pins A4 and A5. In this project (setting date and time only - not yet reading) any two digital pins that are correctly assigned will allow you to set the Date/Time on the DS3231. It therefore does not solely rely on pins A4 and A5. Have tested the settings making use of pins 10 and 11 and also 11 and 12 and it is working fine. Only setback at the moment is that I need to connect it back to pins A4 and A5 to read from it via the inline C code (i.e to see if writing date/time values to the DS3231 were correctly received by the DS3231.  
  
The code below and attached is my interpretation of the DS3231 data sheet to write date and time values to the RTC - data sheet attached. All control of the SDA and SCL lines are hard coded making use of B4R core library only.  
  

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
    Dim pclk, pdat As Pin  
    'comment out the below two lines and un-comment the following two line to use for eg pins 10 (data) and 11 (clock)  
    Dim pdatNo As Byte = pdat.A4                  'pin A4 on the Nano is the default pin for the I2C data line  
    Dim pclkNo As Byte = pclk.A5                  'pin A5 on the Nano is the default pin for the I2C clock line  
    
'    Dim pdatNo As Byte = 10                       'with the code below any digital pin can be used as the data pin - the I2C comms is hard coded and not tied to a specific pin  
'    Dim pclkNo As Byte = 11                       'with the code below any digital pin can be used as the clock pin - the I2C comms is hard coded and not tied to a specific pin  
  
    
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    
    pclk.Initialize(pclkNo, pclk.MODE_OUTPUT)  
    pdat.Initialize(pdatNo, pdat.MODE_OUTPUT)  
    
    pclk.DigitalWrite(True)                          'put both lines in idle mode (i.e both lines high)  
    pdat.DigitalWrite(True)  
    Delay(100)                                       'give the lines some time to settle to the new states  
    
    setSeconds(15)                                    'NOTE - if you set the SECONDS then the other time and date registers MUST be written to within 1 second  
    'if SECONDS are not set then you can change and of the other (below) date/time registers individually (i.e no need to change everything simultaneously)  
    setMinutes(40)                                   'set the minutes - 0…..59  
    setHours(14)                                     'set the hours (24HR format) - 0…..24  
    setDayOfWeek(7)                                  'set the day of the week - 1…..7  
    setDayOfMonth(18)                                'set the day of the month - 1…..31  
    setMonth(1)                                      'set the month - 1….12  
    setYear(20)                                      'set the year - 0…..99  
  
    Delay(100)  
    RunNative("setup1", Null)                        'NOTE - the inline java code uses the Wire library and it uses pins A4 and A5 for data and clock respectively  
    AddLooper("myLooper")  
    
End Sub  
  
Sub myLooper  
    
    RunNative("loop1", Null)  
    
End Sub  
  
Sub setHours(hour As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x02                         'address of the register that holds the HOURS data in the DS3231  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the HOURS (0….23)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(hour)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setMinutes(minutes As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x01                         'address of the register that holds the MINUTES data in the DS3231  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the MINUTES (0….59)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(minutes)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setDayOfMonth(dom As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x04                         'address of the register that holds the DAY OF MONTH data in the DS3231  (1….31)  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the DAY OF MONTH  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(dom)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setDayOfWeek(dow As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x03                         'address of the register that holds the DAY OF WEEK data in the DS3231 (1….7)  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the DAY OF WEEK  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(dow)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setYear(year As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x06                         'address of the register that holds the YEAR data in the DS3231 (0….99)  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the YEAR  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(year)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setMonth(month As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x05                         'address of the register that holds the MONTH data in the DS3231 (1…12)  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the MONTH  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(month)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setSeconds(seconds As Byte)  
    
    setStartCondition                                   'create a START condition for the DS3231 - the data line needs to go from high to low while the clock is high  
    clockInDS3231Address                                'send the DS3231 I2C address out on the I2C bus  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after address has been sent on the bus  
    Dim register As Byte = 0x00                         'address of the register that holds the SECONDS data in the DS3231 (0…59)  
    selectRegister(register)                            'tell the DS3231 we want to work with the register that holds the SECONDS  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setValue(seconds)  
    checkAckFromDS3231                                  'check if the DS3231 is sending back and ACK after 8 bits have been sent to it  
    setStopCondition                                    'generate STOP condition for the DS3231  
    
End Sub  
  
Sub setValue(value As Byte)  
    
    Dim value10, value1 As Byte = 0  
    value10 = value/10                                 'this will become the high nibble  
    value1 = value Mod 10                              'this will become the low nibble  
    value10 = Bit.ShiftLeft(value10, 4)                'move the value10 low nibble to the high nibble  
    value = Bit.Or(value10, value1)                    'OR the two bytes to get the final byte that needs to be sent to the DS3231  
    For i = 0 To 7  
        If Bit.And(value, 128) = 128 Then  
            pdat.DigitalWrite(True)  
        Else  
            pdat.DigitalWrite(False)  
        End If  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(True)  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(False)  
        DelayMicroseconds(2)  
        value = Bit.ShiftLeft(value, 1)                 'shift byte "value" 1 bit to the left for the next Bit.And operation  
    Next  
    
End Sub  
  
Sub selectRegister(register As Byte)  
    
    For i = 0 To 7  
        If Bit.And(register, 128) = 128 Then  
            pdat.DigitalWrite(True)  
        Else  
            pdat.DigitalWrite(False)  
        End If  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(True)  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(False)  
        DelayMicroseconds(2)  
        register = Bit.ShiftLeft(register, 1)  
    Next  
    
End Sub  
  
Sub setStopCondition  
    
    pdat.DigitalWrite(False)            'generate a stop condition - the data line must go from low to high while the clock is high  
    DelayMicroseconds(2)  
    pclk.DigitalWrite(True)  
    DelayMicroseconds(2)  
    pdat.DigitalWrite(True)  
    
End Sub  
  
Sub setStartCondition  
  
    pdat.DigitalWrite(False)           'set a start condition i.e the data line goes low while the clock is high  
    DelayMicroseconds(2)  
    pclk.DigitalWrite(False)           'take the clock low  
    
End Sub  
  
Sub clockInDS3231Address  
    
    Dim address As Byte = 0xD0               'address  (7 bits) plus 8th bit added as LSB to indicate to the DS3231 that we want to write to it (address is 0x68 left shift 1 = 0xD0 to incliude the WRITE bit)  
    For i = 0 To 7  
        If Bit.And(address, 128) = 128 Then  'is the bit a 1?  
            pdat.DigitalWrite(True)  
        Else  
            pdat.DigitalWrite(False)  
        End If  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(True)  
        DelayMicroseconds(2)  
        pclk.DigitalWrite(False)  
        DelayMicroseconds(2)  
        address = Bit.ShiftLeft(address, 1)   'shift the address byte 1 bit to the left for the next Bit.And operation  
    Next  
    
End Sub  
  
Sub checkAckFromDS3231  
    
    pdat.Initialize(pdatNo, pdat.MODE_INPUT)           'check for the ACK coming from the DS3231 - the line should be pulled low by the DS3231  
    DelayMicroseconds(2)  
    pclk.DigitalWrite(True)                            'we need to generate a 9th clock for every byte to read the ACK from the DS3231 - take the clock high  
    DelayMicroseconds(2)  
    Log("pdat mode 1 = ", pdat.DigitalRead)            'check id the DS3231 has pulled the data line low  
    pclk.DigitalWrite(False)                           'take the clock low  
    
    pdat.Initialize(pdatNo, pdat.MODE_OUTPUT)          'put the data pin back into output mode  
    pdat.DigitalWrite(True)                            'take the data line back to high i.e normal idle mode  
    
End Sub  
  
  
  
#if C  
  
#define DS3231_I2C_ADDRESS 0x68  
  
void displayTime();  
byte decToBcd(byte val);  
byte bcdToDec(byte val);  
void readDS3231time(byte *second, byte *minute, byte *hour, byte *dayOfWeek, byte *dayOfMonth, byte *month, byte *year);  
  
// Convert normal decimal numbers to binary coded decimal  
byte decToBcd(byte val){  
  return( (val/10*16) + (val%10) );  
}  
// Convert binary coded decimal to normal decimal numbers  
byte bcdToDec(byte val){  
  return( (val/16*10) + (val%16) );  
}  
void setup1(B4R::Object* o){  
  Wire.begin();  
  Serial.begin(115200);  
}  
  
void readDS3231time(byte *second, byte *minute, byte *hour, byte *dayOfWeek, byte *dayOfMonth, byte *month, byte *year){  
  Wire.beginTransmission(DS3231_I2C_ADDRESS);  
  Wire.write(0); // set DS3231 register pointer to 00h  
  Wire.endTransmission();  
  Wire.requestFrom(DS3231_I2C_ADDRESS, 7);  
  // request seven bytes of data from DS3231 starting from register 00h  
  *second = bcdToDec(Wire.read() & 0x7f);  
  *minute = bcdToDec(Wire.read());  
  *hour = bcdToDec(Wire.read() & 0x3f);  
  *dayOfWeek = bcdToDec(Wire.read());  
  *dayOfMonth = bcdToDec(Wire.read());  
  *month = bcdToDec(Wire.read());  
  *year = bcdToDec(Wire.read());  
}  
void displayTime(){  
  byte second, minute, hour, dayOfWeek, dayOfMonth, month, year;  
  // retrieve data from DS3231  
  readDS3231time(&second, &minute, &hour, &dayOfWeek, &dayOfMonth, &month, &year);  
  // send it to the serial monitor  
  Serial.print(hour, DEC);  
  // convert the byte variable to a decimal number when displayed  
  Serial.print(":");  
  if (minute<10){  
    Serial.print("0");  
  }  
  Serial.print(minute, DEC);  
  Serial.print(":");  
  if (second<10){  
    Serial.print("0");  
  }  
  Serial.print(second, DEC);  
  Serial.print(" ");  
  Serial.print(dayOfMonth, DEC);  
  Serial.print("/");  
  Serial.print(month, DEC);  
  Serial.print("/");  
  Serial.print(year, DEC);  
  Serial.print(" Day of week: ");  
  switch(dayOfWeek){  
  case 1:  
    Serial.println("Sunday");  
    break;  
  case 2:  
    Serial.println("Monday");  
    break;  
  case 3:  
    Serial.println("Tuesday");  
    break;  
  case 4:  
    Serial.println("Wednesday");  
    break;  
  case 5:  
    Serial.println("Thursday");  
    break;  
  case 6:  
    Serial.println("Friday");  
    break;  
  case 7:  
    Serial.println("Saturday");  
    break;  
  }  
}  
void loop1(B4R::Object* o){  
  displayTime(); // display the real-time clock data on the Serial Monitor,  
  delay(1000); // every second  
}  
  
  
  
  
#End If
```