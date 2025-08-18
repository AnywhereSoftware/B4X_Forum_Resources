### rLiquidCrystalI2CEx by rwblinn
### 02/17/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/127742/)

**rLiquidCrystalI2CEx** is an open source B4R library for writing to LCD Displays connected to microcontroller, like Arduino.  
  
The library provides extended methods based on the B4R library [rLiquiCrystal\_I2C](https://www.b4x.com/android/forum/threads/liquidcrystal_i2c.66425/).  
  
**Attached**  
rLiquidCrystalI2CEx.zip archive contains the library and sample project.  
  
**Install**  
The library files are installed in the B4R additional libraries folder.  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  

```B4X
<path to b4r additional libraries folder>\rLiquidCrystalI2CEx.xml  
<path to b4r additional libraries folder>\rLiquidCrystalI2CEx\rLiquidCrystalI2CEx.h, rLiquidCrystalI2CEx.cpp, LiquidCrystal_I2C.h , LiquidCrystal_I2C.cpp
```

  
  
**Wiring**  

```B4X
Arduino = LCD I2C  
GND = GND (Black)  
5v = VCC (Red)  
SDA = SDA (Blue)  
SCL = SCL (Green)
```

  
Tested with an Arduino UNO and Arduino MEGA.  
  
**Methods  
Initialize the LCD**  
LCD16x2: 0x3F, 16, 2  
LCD20x4: 0x27, 20, 4  

```B4X
Initialize (Address As Byte, Columns As Byte, Rows As Byte)
```

  
  
**Set Cursor Position at Column, Row**  

```B4X
SetCursor (Column As Byte, Row As Byte)
```

  
  
**Write Text**  
At the position prior set via SetCursor(Col,Row).  

```B4X
Write (Message As Object)
```

  
  
**Write Text Position Column, Row**  

```B4X
WriteAt (Column As Byte, Row As Byte, Message As Object)
```

  
  
**Clear Screen and Set Cursor Position 0,0**  

```B4X
Clear
```

  
  
**Clear Row and Set Cursor Position 0, Row**  

```B4X
ClearRow (Row As Byte)
```

  
  
**Create Special Character Location 0-7**  

```B4X
CreateChar (Location As Byte, Charmap() As Byte)
```

  
  
**Write Special Character Location 0-7**  

```B4X
WriteChar (Location As Byte)
```

  
  
**Write Special Character Location 0-7 at Position Column, Row**  

```B4X
WriteCharAt (Column As Byte, Row As Byte, Location As Byte)
```

  
  
**Properties  
Set Cursor Blink ON (true) or OFF (false)**  

```B4X
Blink As bool [write only]
```

  
  
**Set Cursor State ON (true) or OFF ( false)**  

```B4X
CursorOn As bool [write only]
```

  
  
**Turn LCD backlight ON (true) or OFF (false)**  

```B4X
Backlight As bool [write only]
```

  
  
**Fields  
Create lcd Object**  

```B4X
lcd As LiquidCrystalI2CEX
```

  
  
**Get Number of Columns**  

```B4X
ColumnSize As Byte
```

  
  
**Get Number of Rows**  

```B4X
RowSize As Byte
```

  
  
**B4R Example**  

```B4X
Sub Process_Globals  
    Public serialLine As Serial  
    Private lcd As LiquidCrystalI2CEX  
    ' Special characters with location index 0,1…  
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

  
  
**Hints**  
Handy tools (written in B4J) working with LCD displays: [LCD Char Maker](https://www.b4x.com/android/forum/threads/tool-lcd-char-maker.67908/), [LCD Display Designer](https://www.b4x.com/android/forum/threads/tool-lcd-display-designer.127676/)  
  
**Licence**  
GNU General Public License v3.0.  
  
**Changelog**  
v1.00 (20210217) - Published B4R Forum