# rLiquidCrystalI2CEX
rLiquidCrystalI2CEx is an open source B4R library for writing to LCD Displays connected to microcontroller, like Arduino.

The library provides extended methods based on the B4R library [rLiquiCrystal_I2C](https://www.b4x.com/android/forum/threads/liquidcrystal_i2c.66425/).

[B4R](https://www.b4x.com/b4r.html) development tool for native Arduino and ESP programs by [Anywhere Software](https://www.b4x.com).

## Files
* rLiquidCrystalI2CEx.zip archive contains the library and sample projects.

## Install
The library files are installed in the B4R additional libraries folder.
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.
```
<path to b4r additional libraries folder>/rLiquidCrystalI2CEx.xml
<path to b4r additional libraries folder>/rLiquidCrystalI2CEx/rLiquidCrystalI2CEx.h, rLiquidCrystalI2CEx.cpp, LiquidCrystal_I2C.h , LiquidCrystal_I2C.cpp 
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

## Methods
Init the LCD with address (default 0x27) and columns (20), rows (4)
```
Initialize (Address As Byte, Columns As Byte, Rows As Byte)
```

Set the cursor position at column, row
```
SetCursor (Column As Byte, Row As Byte)
```

Write text at the position prior set via SetCursor(Col,Row).
```
Write (Message As Object)
```

Write text at the position col,row.
```
WriteAt (Column As Byte, Row As Byte, Message As Object)
```

Clear the screen and set the cursor at position 0,0.
```
Clear
```

Clear a row and set the cursor at position 0, row.
```
ClearRow (Row As Byte)
```

Create special character location 0-7.
```
CreateChar (Location As Byte, Charmap() As Byte)
```

Write special character 0-7
```
WriteChar (Location As Byte)
```

Write special character wih location 0-7 at the position column, row.
```
WriteCharAt (Column As Byte, Row As Byte, Location As Byte)
```

## Properties
Set cursor blink ON (true) or OFF (false).
```
Blink As bool [write only]
```

Sets the cursor state ON (true) or OFF ( false)
```
CursorOn As bool [write only]
```

Turn the LCD backlight ON (true) or OFF (false)
```
Backlight As bool [write only]
```

## Fields
Create lcd object
```
lcd As LiquidCrystalI2CEx
```

Get the number of columns
```
ColumnSize As Byte
```

Get the number of rows
```
RowSize As Byte
```

## B4R Example
```
Sub Process_Globals
	Public serialLine As Serial
   	Private lcd As LiquidCrystalI2CEX
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
