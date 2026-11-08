B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'Icons
'Work in progress to define nicer and coloroured icons.
'Examples using the library DrawIcon function:
'x, y, rows, columns, size (in px), icon byte array, color, background color.
'lcd.DrawIcon(20,50, 6, 8, 8, Icons.BatteryFull, lcd.COLOR_BLACK, lcd.color_GREEN)
'lcd.DrawIcon(100,50, 6, 8, 8, Icons.BatteryHalf, lcd.COLOR_BLACK, lcd.color_YELLOW)
'lcd.DrawIcon(180,50, 4, 8, 8, Icons.BatteryEmpty, lcd.COLOR_BLACK, lcd.color_RED)
'lcd.DrawIcon(20,100, 5, 8, 8, Icons.ArrowRight, lcd.COLOR_BLACK, lcd.BackgroundColor)

Sub Process_Globals

	'Battery full 6 rows x 8 columns - shape sharp.
	'Each row is represented by a byte = binary number with 8 digits.
	Public BatteryFull(6) As Byte = Array As Byte( _
	  	0xFF, _ ' 11111111
		0x81, _ ' 10000001
		0x81, _ ' 10000001
		0x81, _ ' 10000001
		0x81, _ ' 10000001
		0xFF  _ ' 11111111
	)

	'Battery half 6 rows x 8 columns - shape sharp.
	'Each row is represented by a byte = binary number with 8 digits.
	Public BatteryHalf(6) As Byte = Array As Byte( _
	  	0xFF, _ ' 11111111
		0x8F, _ ' 10001111
		0x8F, _ ' 10001111
		0x8F, _ ' 10001111
		0x8F, _ ' 10001111
		0xFF  _ ' 11111111
	)

	'Battery empty 4 rows x 8 columns - shape sharp.
	'Each row is represented by a byte = binary number with 8 digits.
	Public BatteryEmpty(4) As Byte = Array As Byte( _
	  	0xFF, _ ' 11111111
		0x81, _ ' 10000001
		0x81, _ ' 10000001
		0xFF  _ ' 11111111
	)
	
	'Arrow right 5 rows x 8 columns - shape sharp.
	'Each row is represented by a byte = binary number with 8 digits.
	Public ArrowRight(5) As Byte = Array As Byte( _
	  	0x0C, _ ' 00001100
		0x06, _ ' 00000110
		0xFF, _ ' 11111111
		0x06, _ ' 00000110
		0x0C  _ ' 00001100
	)
	
End Sub
