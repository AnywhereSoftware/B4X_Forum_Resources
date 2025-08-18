### library for PCF8574 by candide
### 08/02/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/127531/)

it is a wrapper for PCF8574 based of arduino library from <https://github.com/RobTillaart/PCF8574/>  
  
functions are similar to original library, except initialization adapted to B4R.  
It can work on Wire, Wire1 or Wire2, on hard I2C and on software I2C and we can have several 8574 on same I2C  
with  
**## initialization**  
- Initialize(deviceAddress) // for all board with default I2C  
- Initializeesp32(deviceAddress, I2Cbus) //only for esp32  
 device address: for PCF8574 : 0x20 to 0x27 for PCF8574A : 0x38 to 0x3F  
 I2Cbus can be define with a parameter provided by library :Wire or Wire1 or Wire2 (Wire by default)  
- begin(initB) // set the initial value for the pins and masks.  
- beginesp(sda, scl, initB) // only for esp8266 and esp32 to change pins  
- isConnected() // checks if the address is visible on the I2C bus  
  
**### Read and Write**  
- \*\*read8()\*\* reads all 8 pins at once. This one does the actual reading.  
- \*\*read(pin)\*\* reads a single pin; pin = 0..7  
- \*\*value()\*\* returns the last read inputs again, as this information is buffered in the class this is faster than reread the pins.  
- \*\*write8(value)\*\* writes all 8 pins at once. This one does the actual reading.  
- \*\*write(pin, value)\*\* writes a single pin; pin = 0..7; value is HIGH(1) or LOW (0)  
- \*\*valueOut()\*\* returns the last written data.  
  
**### Button**  
- \*\*setButtonMask(mask)\*\*  
- \*\*readButton8()\*\*  
- \*\*readButton8Mask(mask)\*\*  
- \*\*readButton(pin)\*\*  
  
**### More**  
- \*\*toggle(pin)\*\* toggles a single pin  
- \*\*toggleMask(mask)\*\* toggles a selection of pins, if you want to invert all pins use 0xFF (default value).  
- \*\*shiftRight(n = 1)\*\* shifts output channels n pins (default 1) pins right (e.g. leds ).Fills the higher lines with zero's.  
- \*\*shiftLeft(n = 1)\*\* shifts output channels n pins (default 1) pins left (e.g. leds ).Fills the lower lines with zero's.  
- \*\*rotateRight(n = 1)\*\* rotates output channels to right, moving lowest line to highest line.  
- \*\*rotateLeft(n = 1)\*\* rotates output channels to left, moving highest line to lowest line.  
- \*\*reverse()\*\* revers the "bit pattern" of the lines, high to low and vice versa.  
  
**### Misc**  
- \*\*lastError()\*\* returns the last error from the lib. (see .h file)  
  
## Error codes  
| name | value | description |  
| PCF8574\_OK | 0x00 | no error  
| PCF8574\_PIN\_ERROR | 0x81 | pin number out of range |  
| PCF8574\_I2C\_ERROR | 0x82 | I2C communication error |  
  
22/08/02 new version for esp32 compatibility  
a few changes in initialize and begin to be compatible multiple boards  
=======================================  
'I2C config is depending depending of hard:  
'=======================================  
'esp32   
' with defaumt Wire, pins by default For only one I2C  
' SCL : GPIO 22 (I2C -> Data)  
' SDA : GPIO 21 (I2C -> Clock)  
' pcf.Initialize(0x20)  
' pcf.begin(0xFF)   
  
' with TwoWire pins can be changed  
' SDA : GPIO 33  
' SCL : GPIO 32  
' pcf.Initializeesp32(0x20,pcf.I2C\_TwoWire0)  
' pcf.beginesp(33,32,0xFF)  
  
' with TwoWire both I2C can be used  
' pins by default can be used For I2C one, but can be changes also  
' I2C Bus 1: uses GPIO 27 (SDA) And GPIO 26 (SCL);  
' I2C Bus 2: uses GPIO 33 (SDA) And GPIO 32 (SCL);  
' pins must be defined For second I2C  
' Private pcf1 As PCF8574  
' Private pcf2 As PCF8574  
' pcf1.Initializeesp32(0x20,pcf.I2C\_TwoWire0)  
' pcf1.beginesp(27,26,0xFF)  
' pcf2.Initializeesp32(0x20,pcf.I2C\_TwoWire1)  
' pcf2.beginesp(33,32,0xFF)  
  
'esp8266  
' with Wire pins by default:  
' SCL : GPIO 5 D1  
' SDA : GPIO 4 D2  
' pcf.Initialize(0x20)  
' pcf.begin(0xFF) pins by default  
' pins can be changed   
' pcf.Initialize(0x20)  
' pcf.beginesp(33,32,0xFF) if pins must be changed  
   
'Arduino Nano  
' SDA: A4  
' SCL: A5  
' pcf.Initialize(0x20)  
' pcf.begin(0xFF)   
  
'Arduino Uno  
' SDA: PIN18  
' SCL: PIN19  
' pcf.Initialize(0x20)  
' pcf.begin(0xFF)   
  
'Arduino Mega  
' SDA: PIN20  
' SCL: PIN21  
' pcf.Initialize(0x20)  
' pcf.begin(0xFF)