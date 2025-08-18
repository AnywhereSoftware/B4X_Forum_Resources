# rLiquidCrystal_I2C
rLiquidCrystal_I2C is an open source library for writing to LCD Displays connected to microcontroller, like Arduino.

This B4R library
* is a wrapper for the [open source project](https://github.com/marcoschwartz/LiquidCrystal_I2C).
* is based on the first version [published](https://www.b4x.com/android/forum/threads/liquidcrystal_i2c.66425/) by Anywhere Software].
* is written in C++ (using the Arduino IDE 1.8.13 and the B4Rh2xml tool).

[B4R](https://www.b4x.com/b4r.html) development tool for native Arduino and ESP programs by [Anywhere Software](https://www.b4x.com).

## Files
* rLiquidCrystal_I2C.zip archive contains the library and sample projects.

## Install
The library files are installed in the B4R additional libraries folder.
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.
```
<path to b4r additional libraries folder>/rLiquidCrystal_I2C.xml
<path to b4r additional libraries folder>/rLiquidCrystal_I2C/rLiquidCrystal_I2C.h , rLiquidCrystal_I2C.cpp, LiquidCrystal_I2C.h , LiquidCrystal_I2C.cpp 
```

## Wiring
```
Arduino = LCD I2C
GND = GND (Black)
5v = VCC (Red)
SDA = SDA (Blue)
SCL = SCL (Green)
```
Tested with an Arduino UNO and Arduino MEGA.

## B4R Example
```
Sub Process_Globals
	Public serialLine As Serial
    Private lcd As LiquidCrystal_I2C
	' Special characters with location index 0,1...
	Private CharArrowUp As Byte = 0
	Private CharArrowDown As Byte = 1
	Private CharBell As Byte = 2
End Sub

Private Sub AppStart
	serialLine.Initialize(115200)
   	Log("AppStart")
	
	'Init the LCD: Address (1602 = 0x3F,2004 = 0x27), Columns, Rows
	lcd.Initialize(0x27, 20, 4)
	'lcd.Initialize(0x3F, 16, 2)

	'Turn the backlight on (default is turned off), set cursor 0,0, write some text
   	lcd.Backlight = True
	lcd.SetCursor(0,0)
	lcd.Write("Hello World")
	lcd.WriteAt(0,3,"B4X is great")
	
	'Define Special Chars
	lcd.CreateChar(CharArrowUp, Array As Byte (0x00,0x04,0x0E,0x1F,0x04,0x04,0x04,0x00))
	lcd.CreateChar(CharArrowDown, Array As Byte (0x00,0x04,0x04,0x04,0x1F,0x0E,0x04,0x00))
	lcd.CreateChar(CharBell, Array As Byte (0x04,0x0E,0x0E,0x0E,0x1F,0x00,0x04,0x00))
	'Write Special Chars at row 1
	lcd.WriteCharAt(0,1,CharArrowUp)
	lcd.WriteCharAt(5,1,CharArrowDown)
	lcd.WriteCharAt(10,1,CharBell)
End Sub
```

## Credits
* Anywhere Software for providing B4R (and of course the whole B4X suite) [Info](https://www.b4x.com/)
* Author of this [open source project](https://github.com/marcoschwartz/LiquidCrystal_I2C).

## Licence
GNU General Public License v3.0.
