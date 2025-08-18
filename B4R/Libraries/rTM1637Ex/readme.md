### rTM1637Ex by rwblinn
### 04/09/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/127739/)

**rTM1637Ex** is an open source B4R library for writing to TM1637 7-segment-displays connected to microcontroller, like Arduino.  
  
The library provides extended methods based on the library [rTM1637](https://www.b4x.com/android/forum/threads/tm1637-4-digits-display.67733/#post-477687) and has been tested with B4R v3.5.  
  
**Attached**  
rTM1637Ex.zip archive contains the library and B4R sample projects.  
  
**Install**  
The library files are installed in the B4R additional libraries folder.  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  

```B4X
<path to b4r additional libraries folder>\rTM1637Ex.xml  
<path to b4r additional libraries folder>\rTM1637Ex\rTM1637Ex.h , rTM1637Ex.cpp, TM1637Display.h , TM1637Display.cpp
```

  
  
**Wiring  
TM1637 = Arduino UNO & MEGA**  
CLK = D2  
DIO = D3  
GND = GND  
VCC = 3.3v or 5v  
  
**TM1637 = ESP8266 NodeMCU 1.0**  
CLK = Pin D2 GPIO4   
DIO = Pin D5 GPIO14   
GND = Pin GND   
VCC = Pin 3.3v Or VIN   
  
Tested a DFRobot 4-Digit Display v1.0 (supports semicolon, but no dot) with the Arduino UNO, Arduino MEGA and ESP8266 NodeMCU 1.0  
  
**Functions Overview  
Initializes Display Object**   
PinClk - Pin connected to the clock pin.  
PinDIO - Pin connected to the DIO pin.  

```B4X
Initialize (PinClk As Byte, PinDIO As Byte)
```

  
  
**Set Display Brightness**  
The setting takes effect when a command is given to change the data being displayed.  
brightness - a number from 0 (lowes brightness) to 7 (highest brightness)  
on - turn display on or off  

```B4X
SetBrightness (brightness As Byte, on As bool)
```

  
  
**Display Arbitrary Data**  
Each byte represents a single digit. Each bit represents a segment.  
Position - Position from which to start the modification (0 - leftmost, 3 - rightmost).  
The 7 LED segments A F B G E C D. DP is the dot (8th LED) if supported by the display.  

```B4X
SetSegments (Segments As Byte[], Position As Byte)
```

  
  
**Display Decimal Number**  

```B4X
ShowNumberDec (Number As Int)
```

  
  
**Display Decimal Number with Options**  
Number - Number to be shown.  
LeadingZero - Whether to add leading zeroes.  
Length - Number of digits to set.  
Position - Position of the least significant digit (0 - leftmost, 3 - rightmost).  

```B4X
ShowNumberDec2 (Number As Int, LeadingZero As bool, Length As Byte, Position As Byte)
```

  
  
**Display Decimal Number with DotMask**  
Controls the decimal dots or colon based on the DotsMask.  
Pass 0xFF to enable all dots / colons.  
The argument is a bitmask, with each bit corresponding to a dot between the digits (or colon mark, as implemented by each module).  
The MSB is the leftmost dot of the digit being update.  
For example, if Position is 1, the MSB of DotsMask will correspond the dot near digit no. 2 from the left.  
Dots are updated only on those digits actually being update (that is, no more than Length digits)  

```B4X
ShowNumberDec3 (Number As Int, LeadingZero As bool, Length As Byte, Position As Byte, DotsMask As Byte)
```

  
  
**Clear Display**  
(uses the method SetSegments with 0 data)  

```B4X
Clear()
```

  
  
**Get Char**  
Get Char from the font char table.  
Index - AscII character index 0 - 127  
Font - 1=AscII, 2=Siekoo  

```B4X
Byte GetChar(Int Index, Byte Font)
```

  
  
**Display Text**  
Display a text with max 4 characters in ascii range 0-127. Not all characters are supported.  
Position - Starting position of the text: 0=leftmost .. 3=rightmost  
Font - 1=AscII, 2=Siekoo  
Examples:  
Display text HaLo startig at pos 0 (leftmost): tmDisplay.ShowText("HaLo",0)  
Display text 9C starting at position 1: tmDisplay.ShowText("9C",1)  

```B4X
ShowText(B4RString* Text, Byte Position, Byte Font);
```

  
  
**Fields**  
*Segments*  
Define the 7 segments  
The segment definitions are used to define the character tables and for the method SetSegments.  

```B4X
SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G
```

  
  
*Fonts*  
Two fonts are supported:  

```B4X
FONT_ASCII - AscII characters 0 - 127.  
FONT_SIEKOO - AscII characters 0 - 127 displayed as Siekoo font.
```

  
  
*Special Characacter*  
Example library header file, how to define a special character using the 7 segment fields:  

```B4X
#define /*Byte SPECIAL_DEGREE;*/ B4RTM1637Display_SPECIAL_DEGREE SEG_A | SEG_B | SEG_F | SEG_G
```

  
  
**B4R Example Blinking Number**  
Several examples showing a blinking number.  

```B4X
Sub Process_Globals  
    Public VERSION As String = "B4R Library rTM1637Ex - Blinking Number v20210216"  
    Public serialLine As Serial  
    Private tmDisplay As TM1637Display  
    Private PINCLK As Byte = 2  
    Private PINDIO As Byte = 3  
    Private BRIGHTNESS As Byte = 7  
    Private timerBlinking As Timer  
    Private TIMERBLINKING_INTERVAL As ULong = 2000  
    Private displayOn As Boolean = False  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(115200)  
    Log(VERSION)  
    ' Init display with pin clk and dio  
    tmDisplay.Initialize(PINCLK, PINDIO)  
    ' Set the blnking timer  
    timerBlinking.Initialize("TimerBlinking_Tick", TIMERBLINKING_INTERVAL)  
    timerBlinking.Enabled = True  
    tmDisplay.Clear  
End Sub  
  
Sub TimerBlinking_Tick  
    Dim numberValue As Int  
    displayOn = Not(displayOn)  
  
    ' Set the display brightness and turn the display ON or OFF  
    tmDisplay.SetBrightness(BRIGHTNESS, displayOn)  
    tmDisplay.Clear  
   
    ' Show two digit random number NN with length 2 at the right  
    numberValue = Rnd(0,99)  
    tmDisplay.ShowNumberDec2(numberValue, False, 2, 2)  
  
    ' Show two digit random number NNNN with leading zeros from left to right  
    ' numberValue = Rnd(0,1001)  
    ' tmDisplay.ShowNumberDec2(numberValue, True, 4, 0)  
  
    ' Show four digit random number NNNN with leading zeros from left to right with semicolon between NN:NN  
    ' numberValue = Rnd(1,1001)  
    ' tmDisplay.ShowNumberDec3(numberValue, True, 4, 0, 0xFF)  
  
    Log(numberValue, " = " , displayOn)  
End Sub
```

  
  
**B4R Example SetSegments**  
The display to show rightmost 9°C.  
The degree character and the letter C are created using the method SetSegments.  

```B4X
Sub Process_Globals  
    Public VERSION As String = "B4R Library rTM1637Ex - SetSegments v20210216"  
    Public serialLine As Serial  
    Private tmDisplay As TM1637Display  
    Private PINCLK As Byte = 2  
    Private PINDIO As Byte = 3  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(115200)  
    Log(VERSION)  
    tmDisplay.Initialize(PINCLK, PINDIO)  
   
    'Clear the display first  
    tmDisplay.Clear  
  
    'Set a single digit number (9) at position 1  
    tmDisplay.ShowNumberDec2(9,False,1,1)  
   
    'Show °C (circle C) at position 2 (from left) using setsegments  
    Dim circle As Byte = Bit.Or(tmDisplay.SEG_A, Bit.Or(tmDisplay.SEG_B, Bit.Or(tmDisplay.SEG_F, tmDisplay.SEG_G)))  
    Dim celcius As Byte = Bit.Or(tmDisplay.SEG_A, Bit.Or(tmDisplay.SEG_D, Bit.Or(tmDisplay.SEG_E, tmDisplay.SEG_F)))  
    tmDisplay.SetSegments(Array As Byte(circle, celcius), 2)  
End Sub
```

  
  
**B4R Siekoo Example (snippet)**  
Display special degree character, AscII 94 with Siekoo font at position  

```B4X
Private charFont As Byte = 2 ' Siekoo  
Private charPos As Byte = 3 ' most right  
tmDisplay.SetSegments(Array As Byte(tmDisplay.GetChar(94, charFont)), charPos)
```

  
  
**Hints**  
If not using the AscII or Siekoo fonts, remove from the library - saves memory.  
  
**Licence**  
GNU General Public License v3.0.  
  
**Changelog**  
v1.51 (20220409) - Removed PROGMEM from the header declaration for the character font tables for use on ESP8266 (avoid section attribute error).  
v1.50 (20210525) - GetChar, ShowText, Fonts AscII & Siekoo, Improvements.  
v1.00 (20210217) - Initial version.