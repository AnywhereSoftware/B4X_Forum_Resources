B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'MyShapes
'Code module with own defined shapes examples.
'Each method has an LovyanGFXEx instance as first argument and must be declared as public.

Sub Process_Globals

	'Icon Arrow right 5 rows x 8 columns - shape sharp.
	'Each row has a width of 8 columns represented by a byte = binary number with 8 digits.
	Public ArrowRight(5) As Byte = Array As Byte( _
	  	0x0C, _ ' 00001100
		0x06, _ ' 00000110
		0xFF, _ ' 11111111
		0x06, _ ' 00000110
		0x0C  _ ' 00001100
	)

End Sub

'Draw a default heading aligned middle center at the top of the screen.
Public Sub DrawHeading(lcd As LovyanGFXEx, text As String)
	lcd.DrawText(lcd.Width / 2, 10, text, lcd.TEXT_ALIGN_MIDDLE_CENTER, 1.5, lcd.COLOR_BLUE, lcd.COLOR_WHITE)
End Sub

'Draw a default footer aligned left at the bottom of the screen.
Public Sub DrawFooter(lcd As LovyanGFXEx, text As String)
	lcd.DrawText(10, lcd.Height - lcd.FontHeight(1) - 2, text, lcd.TEXT_ALIGN_MIDDLE_LEFT, 1, lcd.COLOR_BLACK, lcd.COLOR_DEFAULT)
End Sub

'Draw a pixel size 8x8
Public Sub DrawPixel8(lcd As LovyanGFXEx, x As Int, y As Int, color As ULong)
	Dim size As Byte = 8
	
	For i=x To x + size
		For j=y To y + size
			lcd.DrawPixel(i, j, color)
		Next
	Next
End Sub

'Draw an icon defined by byte array with n rows and 8 columns.
'Example icon using pixel 8x8
'<code>
'DrawIcon(100, 100, 8, ArrowRight, lcd.COLOR_BLACK, lcd.color_RED)
'</code>
Public Sub DrawIcon(lcd As LovyanGFXEx, x As UInt, y As UInt, size As Byte, icon() As Byte, color As ULong, bgcolor As ULong)
	Dim rows As UInt = icon.Length
	Dim cols As UInt = 8
	Dim row As Int
	Dim col As Int
	Dim clr As ULong
	
	For row = 0 To rows - 1
		For col = 0 To cols - 1
			'Set the color of the pixel
			clr = IIf(Bit.And(icon(row), Bit.ShiftRight(0x80, col)) <> 0, color, bgcolor)
			'Draw the pixel with given size
			lcd.DrawPixelSize(x + col * size, y + row * size, size, clr)
		Next
	Next
End Sub

'Draw a rounded button
Public Sub DrawButtonRound(lcd As LovyanGFXEx, x As Long, y As Long, w As Long, h As Long, text As String, textcolor As ULong, color As ULong)
	Dim textsize As Double = 1
	Dim radius As Long = 10
	
	lcd.FillRoundRect(x, y, w, h, radius, color)
	lcd.Font = lcd.FONT_FREESANS_12
	lcd.DrawText(x + (w/2), y + (h/2), text, lcd.TEXT_ALIGN_MIDDLE_CENTER, textsize, textcolor, color) 
	lcd.Font = lcd.FONT_DEFAULT
End Sub

