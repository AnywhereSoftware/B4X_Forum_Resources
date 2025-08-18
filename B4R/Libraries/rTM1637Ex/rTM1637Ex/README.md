# rTM1637Ex
rTM1637Ex is an open source B4R library for writing to TM1637 7-segment-displays connected to microcontroller, like Arduino.

This B4R library is
* a wrapper with extended methods for [this](https://github.com/avishorp/TM1637) open source project.
* based on the library [rTM1637](https://www.b4x.com/android/forum/threads/tm1637-4-digits-display.67733/#post-477687) by Anywhere Software.
* Enhanced with several methods and support for the fonts AscII and [Siekoo](http://fakoo.de/siekoo.html).
* written in C++ (using the Arduino IDE 1.8.13 and the B4Rh2xml tool).
* tested with B4R v3.71.

[B4R](https://www.b4x.com/b4r.html) development tool for native Arduino and ESP programs by [Anywhere Software](https://www.b4x.com).

Library published B4R Forum Additional Libraries: [here](https://www.b4x.com/android/forum/threads/rtm1637ex.127739/).

## Files
* rTM1637Ex.zip archive contains the library and B4R sample projects.

## Install
The library files are installed in the B4R additional libraries folder.
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.
```
<path to b4r additional libraries folder>\rTM1637Ex.xml
<path to b4r additional libraries folder>\rTM1637Ex\rTM1637Ex.h , rTM1637Ex.cpp, TM1637Display.h , TM1637Display.cpp 
```

For B4R program examples, lookup folder examples.

## Wiring
```
TM1637 = Arduino
CLK = D2 
DIO = D3 
GND = GND
VCC = 3.3v or 5v
```
Tested a DFRobot 4-Digit Display v1.0 (supports the semicolon, but not the dot) with the Arduino UNO and Arduino MEGA.

```
TM1637 = ESP8266 NodeMCU 1.0
CLK = Pin D2 GPIO4 (Blue)
DIO = Pin D5 GPIO14 (Pink)
GND = Pin GND (Black)
VCC = Pin 3.3v Or VIN (Red)
```
Tested a DFRobot 4-Digit Display v1.0 (supports the semicolon, but not the dot) with the an ESP8266 NodeMCU 1.0.

## Segments
-A-
F-B
-G-
E-C
-D-

The character tables define each character using the segments defined as fields.

Examples B4R how to define own characters with the segment fields.
° = Dim circle As Byte = Bit.Or(tmDisplay.SEG_A, Bit.Or(tmDisplay.SEG_B, Bit.Or(tmDisplay.SEG_F, tmDisplay.SEG_G)))
C = Dim celcius As Byte = Bit.Or(tmDisplay.SEG_A, Bit.Or(tmDisplay.SEG_D, Bit.Or(tmDisplay.SEG_E, tmDisplay.SEG_F)))
P = Dim circle As Byte = Bit.Or(tmDisplay.SEG_A, Bit.Or(tmDisplay.SEG_B, Bit.Or(tmDisplay.SEG_F, tmDisplay.SEG_G)))

## Functions Overview
Initializes the object. 
PinClk - Pin connected to the clock pin. PinDIO - Pin connected to the DIO pin.
```
Initialize (PinClk As Byte, PinDIO As Byte)
```

Sets the brightness of the display.
The setting takes effect when a command is given to change the data being displayed.
brightness - a number from 0 (lowes brightness) to 7 (highest brightness) 
on - turn display on or off
```
SetBrightness (brightness As Byte, on As bool)
```

Displays arbitrary data. 
Each byte represents a single digit. 
Each bit represents a segment. 
Position - Position from which to start the modification (0 - leftmost, 3 - rightmost). 
The 7 LED segments A F B G E C D. DP is the dot (8th LED) if supported by the display.
```
SetSegments (Segments As Byte[], Position As Byte)
```

Displays the decimal number.
```
ShowNumberDec (Number As Int)
```

Displays the decimal number.
Number - Number to be shown. 
LeadingZero - Whether to add leading zeroes. 
Length - Number of digits to set. 
Position - Position of the least significant digit (0 - leftmost, 3 - rightmost).
```
ShowNumberDec2 (Number As Int, LeadingZero As bool, Length As Byte, Position As Byte)
```

Similar to ShowNumberDec2. 
Controls the decimal dots or colon based on the DotsMask. 
Pass 0xFF to enable all dots / colons. 
The argument is a bitmask, with each bit corresponding to a dot between the digits (or colon mark, as implemented by each module). 
The MSB is the leftmost dot of the digit being update.
For example, if Position is 1, the MSB of DotsMask will correspond the dot near digit no. 2 from the left. 
Dots are updated only on those digits actually being update (that is, no more than Length digits)
```
ShowNumberDec3 (Number As Int, LeadingZero As bool, Length As Byte, Position As Byte, DotsMask As Byte)
```

Clear the display (uses SetSegments with 0 data)
```
Clear()
```

Get Char from the font char table.
Index - AscII character index 0 - 127)
Font - 1=AscII, 2=Siekoo
```
Byte GetChar(Int Index, Byte Font)
```

Display a text with max 4 characters in ascii range 0-127. Not all characters are supported.
Position - Starting position of the text: 0=leftmost .. 3=rightmost
Font - 1=AscII, 2=Siekoo
Examples:
Display text HaLo startig at pos 0 (leftmost): tmDisplay.ShowText("HaLo",0)
Display text 9C starting at position 1: tmDisplay.ShowText("9C",1)
```
ShowText(B4RString* Text, Byte Position, Byte Font)
```

## Fields
**Segments**
Define the 7 segments:
```
SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G
```
The segment definitions are used to define the character tables and for the method SetSegments.

**Fonts**
FONT_ASCII - AscII characters 0 - 127.
FONT_SIEKOO - AscII characters 0 - 127 displayed as Siekoo font.

**Special Characacter**
Example library header file, how to define a special character using the 7 segment fields:
```
#define /*Byte SPECIAL_DEGREE;*/ B4RTM1637Display_SPECIAL_DEGREE SEG_A | SEG_B | SEG_F | SEG_G
```

## B4R Example Blinking Number
Several examples showing a blinking number.
```
#Region Project Attributes
	#AutoFlushLogs: True
	#CheckArrayBounds: True
	#StackBufferSize: 300
#End Region

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

## B4R Example SetSegments
The display to show rightmost 9°C.
The degree character and the letter C are created using the method SetSegments
```
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

## B4R Siekoo Example (snippet)
Display special degree character, AscII 94 with Siekoo font at position
```
Private charFont As Byte = 2 ' Siekoo
Private charPos As Byte = 3 ' most right
tmDisplay.SetSegments(Array As Byte(tmDisplay.GetChar(94, charFont)), charPos)
```

## Hints
If not using the Siekoo font, remove from the library - saves memory.

## Credits
* Anywhere Software for providing B4R (and of course the whole B4X suite) [Info](https://www.b4x.com/).
* Author of this TM1637 [open source project](https://github.com/avishorp/TM1637).
* Author of the [Siekoo fonts](http://fakoo.de/siekoo.html).

## Licence
GNU General Public License v3.0.
