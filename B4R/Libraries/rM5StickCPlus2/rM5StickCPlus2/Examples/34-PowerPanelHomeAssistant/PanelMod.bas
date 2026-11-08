B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:		PanelMod.bas
' Brief:	Methods for controlling the M5 LCD display.
' Notes:	
#End Region

Private Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.

	' =========================================================
	' COLOR CONSTANTS – Semantic naming for UI elements
	' =========================================================
	Private COLOR_BG_DEFAULT	As Int
	Private COLOR_TEXT_DEFAULT  As Int
	Private COLOR_TEXT_WARNING  As Int
	Private COLOR_TEXT_ALERT    As Int
	Private COLOR_TEXT_OK       As Int
	Private COLOR_TEXT_DISABLED As Int	'ignore
	Private COLOR_TILE_BORDER   As Int

	' =========================================================
	' POWER FLOW SPECIFIC COLORS
	' =========================================================
	Private COLOR_POWERHOUSE	As Int
	Private COLOR_POWERSOLAR    As Int
	Private COLOR_POWERGRID     As Int
	Private COLOR_POWERBATTERY  As Int	'ignore

	' =========================================================
	' TEXT SIZES
	' =========================================================
	Private TEXTSIZE_PAGE_HEADING	As Int = 2
	Private TEXTSIZE_PAGE_FOOTER	As Int = 1

	' =========================================================
	' Tiles
	' =========================================================
	Private UNIT_WATT As String = "W"
	Private UNIT_PERCENT As String = "%"

	' =========================================================
	' Thresholds
	' =========================================================
	Private THRESHOLD_BATTERY_MIN As Byte = 20
	Private THRESHOLD_POWERFROMSOLAR_MIN As Byte = 0
	
	'Pages - pages main, battery and settingsare used.
	Private PAGE_MAX As Byte = 4
	Private PAGE_DASHBOARD=1, PAGE_BATTERY=2,PAGE_SOLAR=3,PAGE_INFO=4 As Byte
	
	'Keep track of the page selected:
	Private PageSelected As Int = PAGE_DASHBOARD

	' M5 Device
	Public M5 As M5StickCPlus2

	' Helper
	Private bc As ByteConverter
End Sub

Public Sub Initialize As Boolean
	' Init the M5 device with button event
	M5.InitializeWithButtonEvent("button_pressed")
	Log("[Main.AppStart][I] M5 initialized.")
		
	' Set M5 Display mode landscape (power supply right)
	M5.Rotation = M5.M5_ROTATION_LANDSCAPE
	Log("[Main.AppStart][I] Rotation portrait=", M5.IsPortrait)

	InitColors

	Return True
End Sub

' --- Initialize color constants ---
' =========================================================
' Initialize all color constants – call once after m5.Initialize
' =========================================================
Public Sub InitColors
	' =========================================================
	' COLOR CONSTANTS – Semantic naming for UI elements
	' =========================================================
	COLOR_BG_DEFAULT    = M5.COLOR_BLACK        ' Default background
	COLOR_TEXT_DEFAULT  = M5.COLOR_WHITE        ' Normal text
	COLOR_TEXT_WARNING  = M5.COLOR_YELLOW       ' Warnings
	COLOR_TEXT_ALERT    = M5.COLOR_RED          ' Errors or critical states
	COLOR_TEXT_OK       = M5.COLOR_GREEN        ' Normal operation or "OK"
	COLOR_TEXT_DISABLED	= M5.COLOR_LIGHTGREY    ' Disabled or inactive
	COLOR_TILE_BORDER   = M5.COLOR_DARKGREY     ' Optional subtle tile border

	' =========================================================
	' POWER FLOW SPECIFIC COLORS
	' =========================================================
	COLOR_POWERHOUSE	= COLOR_TEXT_DEFAULT    ' Normal: white
	COLOR_POWERSOLAR    = COLOR_TEXT_OK         ' Solar power: green
	COLOR_POWERGRID     = COLOR_TEXT_ALERT      ' Grid (import/export): red
	COLOR_POWERBATTERY  = COLOR_TEXT_WARNING    ' Battery: yellow
End Sub

#Region Pages
' Helper to set the LCD page header
Public Sub SetPageHeader(text As String)
	Dim linethickness As Int = 1
	M5.SetHeader(text, TEXTSIZE_PAGE_HEADING, M5.UI_ALIGN_CENTER, M5.COLOR_GREEN, COLOR_BG_DEFAULT , True)
	M5.SetHorLine((M5.GetFontHeight * TEXTSIZE_PAGE_HEADING) + (linethickness * 2), M5.COLOR_WHITE, linethickness)
End Sub

' Helper to set the LCD page footer
Public Sub SetPageFooter(text As String)
	Dim linethickness As Int = 1
	M5.SetFooter(text, TEXTSIZE_PAGE_FOOTER, M5.UI_ALIGN_CENTER, M5.COLOR_GREEN, COLOR_BG_DEFAULT , True)
	M5.SetHorLine(M5.GetHeight - (M5.GetFontHeight * TEXTSIZE_PAGE_FOOTER) - (linethickness * 2), M5.COLOR_BLUE, linethickness)
End Sub

' Set a message at the center of the display.
Public Sub SetMessage(header As String, footer As String, msg As String, textcolor As Int)
	M5.Clear
	If header.Length > 0 Then SetPageHeader(header)
	M5.PrintCentered(M5.GetCenterX, M5.GetCenterY, msg, 2, textcolor, COLOR_BG_DEFAULT )
	If footer.Length > 0 Then SetPageFooter(footer)
End Sub

Private Sub DrawTile(X As Int, Y As Int, W As Int, H As Int, Label As String, Value As Int, Unit As String, bgColor As Int, textColor As Int)
	' Draw tile background
	M5.FillRect(X, Y, W, H, bgColor)
    
	' Draw tile border (optional)
	M5.DrawRect(X, Y, W, H, COLOR_TILE_BORDER)

	' Draw header label centered (textsize 2)
	M5.PrintCentered(X + W / 2, Y + 6, Label, 2, COLOR_TEXT_DEFAULT, bgColor)
 
	' Draw value centered (textsize 3)
	M5.PrintCentered(X + W / 2, Y + (H / 2) - 8, NumberFormat(Value, 0, 0), 3, textColor, bgColor)
    
	' Draw unit centered below value (textsize 1)
	M5.PrintCentered(X + W / 2, Y + (H / 2) + 18, Unit, 1, COLOR_TEXT_DEFAULT, bgColor)
End Sub

' Draw value x,y centered with (nice) text font UI_TEXTFONT_8
Private Sub DrawValueCentered(value As Int, textcolor As Int)
	Dim x, y As Int
	Dim s As String = value

	M5.SetTextColor(textcolor)
	' Digit Fonts - use size 1 for XL or 1.5 for LCD
	M5.SetDigitFont(M5.UI_DIGITFONT_XL, 1)
	' LCD font also looks nice
	'M5.SetDigitFont(M5.UI_DIGITFONT_LCD, 1.5)

	Dim tl As Int = M5.GetTextLengthInPixel(s)
	Dim fh As Int = M5.GetFontHeight
	x = M5.GetCenterX
	y = M5.GetCenterY
	M5.SetCursor(x - (tl/2), y - (fh/2))
	M5.Print(s)
	M5.SetFontDefault
End Sub

' Draw an info row: Label Value
' Used for the info page
Private Sub DrawInfoRow(y As Int, label As String, value As String, textcolor As Int)
	' Text settings
	Dim textsize As Int = 2

	' Text position
	Dim xlabel As Int = 10
	Dim xvalue As Int = (M5.GetWidth / 2) - 40

	' Label
	M5.SetTextAt(xlabel, y, label, textsize, textcolor)
	M5.SetTextAt(xvalue, y, value, textsize, textcolor)
End Sub
#End Region

#Region DrawPages
' Update the display with the measured values.
Public Sub DrawPageDashboard(data As TPowerData)
	Dim TILES_PER_ROW As Int = 2
	Dim TILES_PER_COL As Int = 2
	' Tile width & height
	Dim w As Int = M5.GetWidth / TILES_PER_ROW
	Dim h As Int = M5.GetHeight / TILES_PER_COL
	' Tile adjusted width & height
	Dim wt As Int = w - 2
	Dim ht As Int = h -2

	' Clear the display first
	M5.Clear

	' Tile Top-left: Solar
	' If power from solar 0, set text color red
	If data.PowerFromSolar > THRESHOLD_POWERFROMSOLAR_MIN Then
		DrawTile(0, 0, wt, ht, "Solar", data.PowerFromSolar, UNIT_WATT, COLOR_BG_DEFAULT, COLOR_POWERSOLAR)
	Else
		DrawTile(0, 0, wt, ht, "Solar", data.PowerFromSolar, UNIT_WATT, COLOR_BG_DEFAULT, COLOR_TEXT_ALERT)
	End If

	' Tile Top-right: House
	DrawTile(w, 0, wt, ht, "House", data.PowerToHouse, UNIT_WATT, COLOR_BG_DEFAULT, COLOR_POWERHOUSE)

	' Tile Bottom-left: Grid
	' If power is taken from the grid, set text color red
	If data.PowerToGrid >= 0 Then
		DrawTile(0, h, wt, ht, "Grid", data.PowerToGrid, UNIT_WATT, COLOR_BG_DEFAULT, COLOR_POWERGRID)
	Else
		DrawTile(0, h, wt, ht, "Grid", data.PowerFromGrid, UNIT_WATT, COLOR_BG_DEFAULT, COLOR_TEXT_ALERT)
	End If

	' Tile Bottom-right: Battery
	' If battery < 20%, set text color red
	If data.PowerBatteryChargeState > THRESHOLD_BATTERY_MIN Then
		DrawTile(w, h, wt, ht, "Battery", data.PowerBatteryChargeState, UNIT_PERCENT, COLOR_BG_DEFAULT, COLOR_TEXT_OK)
	Else
		DrawTile(w, h, wt, ht, "Battery", data.PowerBatteryChargeState, UNIT_PERCENT, COLOR_BG_DEFAULT, COLOR_TEXT_WARNING)
	End If
End Sub

' Draw the battery charge state in %
Private Sub DrawPageBattery(data As TPowerData)
	Dim powerbattery As Int
	Dim textcolor As Int
		
	' Clear the display first
	M5.ClearColor(COLOR_BG_DEFAULT)

	' Set the page header
	M5.SetHeader("Battery %", TEXTSIZE_PAGE_HEADING, M5.UI_ALIGN_CENTER, COLOR_TEXT_DEFAULT, COLOR_BG_DEFAULT, False)

	' Draw the value center of the display
	If data.PowerBatteryChargeState > THRESHOLD_BATTERY_MIN Then
		DrawValueCentered(data.PowerBatteryChargeState, COLOR_TEXT_OK)
	Else
		DrawValueCentered(data.PowerBatteryChargeState, COLOR_TEXT_WARNING)
	End If

	' Set the page Footer
	'Adjust the powertobattery value
	If data.PowerToBattery > 0 Then
		powerbattery = data.PowerToBattery
		textcolor = COLOR_TEXT_OK
	Else
		powerbattery = data.PowerFromBattery * -1
		textcolor = COLOR_TEXT_ALERT
	End If
	M5.SetFooter(powerbattery, 2, M5.UI_ALIGN_CENTER, textcolor, COLOR_BG_DEFAULT, False)
End Sub

' Draw the solar page with power from solar in W
Private Sub DrawPageSolar(data As TPowerData)
	' Clear the display first
	M5.ClearColor(COLOR_BG_DEFAULT)

	' Set the page header
	M5.SetHeader("Solar W", TEXTSIZE_PAGE_HEADING, M5.UI_ALIGN_CENTER, COLOR_TEXT_DEFAULT, COLOR_BG_DEFAULT, False)

	' Draw the value center of the display
	If data.PowerFromSolar > THRESHOLD_POWERFROMSOLAR_MIN Then
		DrawValueCentered(data.PowerFromSolar, COLOR_POWERSOLAR)
	Else
		DrawValueCentered(data.PowerFromSolar, COLOR_TEXT_ALERT)		
	End If

	' Set the page Footer
	M5.SetFooter(data.PowerTimeStamp, 2, M5.UI_ALIGN_CENTER, COLOR_TEXT_DEFAULT, COLOR_BG_DEFAULT, False)
End Sub

' Draw the info page with Battery charging state, IP address, Uptime (from millis), app version.
Private Sub DrawPageInfo()
	Dim ROWS As Byte = 5
	Dim rowy As Int = M5.GetHeight / ROWS

	' Clear display first
	M5.ClearColor(COLOR_BG_DEFAULT)

	' Set the page header
	M5.SetHeader("Information", TEXTSIZE_PAGE_HEADING, M5.UI_ALIGN_CENTER, COLOR_TEXT_DEFAULT, COLOR_BG_DEFAULT, False)

	' Draw the info rows
	DrawInfoRow(rowy * 1, "Bat", M5.BatteryLevel, COLOR_TEXT_DEFAULT)
	DrawInfoRow(rowy * 2, "IP", WiFiMod.WiFi.LocalIp, COLOR_TEXT_DEFAULT)
	DrawInfoRow(rowy * 3, "Up", Convert.MillisToBytes(Millis), COLOR_TEXT_DEFAULT)
	DrawInfoRow(rowy * 4, "V", Main.VERSION, COLOR_TEXT_DEFAULT)
End Sub
#End Region

#Region Buttons
' Handle button pressed event.
' buttonid 0=A (Big one in the middle),1=B,2=PWR
Private Sub Button_Pressed(buttonid As Byte)
	' Increase pageselected counter
	PageSelected = PageSelected + 1
	' Check in range else set page dashboard
	If PageSelected > PAGE_MAX Then
		PageSelected = PAGE_DASHBOARD
	End If

	Log("[Main.Button_Pressed][I] buttonid=", buttonid, ",pageselected=", PageSelected)
	' [Main.Button_Pressed] buttonid=1, pageselected=1
		
	Select buttonid
		Case M5.BTN_A
			' Big button device top - show selected page
			ShowPage
		Case M5.BTN_B
			' Small button top left - show page dashboard
			PageSelected = PAGE_DASHBOARD
			ShowPage
		Case M5.BTN_PWR
			' Small button bottom right - show page information
			' Note: press > 6 seconds shuts M5 down
			PageSelected = PAGE_INFO
			ShowPage
	End Select
End Sub

Public Sub ShowPage
	Select PageSelected
		Case PAGE_DASHBOARD
			DrawPageDashboard(Main.PowerData)
		Case PAGE_SOLAR
			DrawPageSolar(Main.PowerData)
		Case PAGE_BATTERY
			DrawPageBattery(Main.PowerData)
		Case PAGE_INFO
			DrawPageInfo
	End Select
End Sub
#End Region

#Region Helpers
' To be addeed to the library rConvert

'----------------------------------------------
' GetCSVItemsCount
' Get the number of items from a CSV string.
'----------------------------------------------
Public Sub GetCSVItemsCount(buffer() As Byte) As Int	'ignore
	Dim counter As Int = 0
	For Each item() As Byte In bc.Split(buffer, ",")
		counter = counter + 1
	Next
	Return counter
End Sub

''----------------------------------------------
'' GetCSVItems
'' Get the items from a CSV string.
'' Return byte() Items string array.
''----------------------------------------------
'Public Sub GetCSVItems(buffer() As Byte) As Byte()
'	Dim dataitems(9) As String
'	Dim i As Int = 0
'
'	For Each item() As Byte In bc.Split(buffer, ",")
'		Dim s As String = Convert.BytesToString(item)
'		DATA_ITEMS = s
'		i = i + 1
'	Next
'	Return dataitems
'End Sub
#End Region


'Sub DrawTileWhite(X As Int, Y As Int, W As Int, H As Int, Label As String, Value As Int, IsPercent As Boolean)	'ignore
'	' Draw tile background
'	m5.DrawRect(X, Y, W, H, m5.COLOR_DARKGREY)
'    
'	' Draw header label centered
'	Dim labelText As String = Label
'	m5.PrintCentered(X + W / 2, Y + 6, labelText, 2, m5.COLOR_WHITE, m5.COLOR_BLACK)
'    
'	' Prepare value + unit
'	Dim valueStr As String = NumberFormat(Value, 0, 0)
'	Dim unitStr As String
'	If IsPercent Then
'		unitStr = "%"
'	Else
'		unitStr = "W"
'	End If
'    
'	' Draw value centered (text size 3)
'	m5.PrintCentered(X + W / 2, Y + (H / 2) - 8, valueStr, 3, m5.COLOR_WHITE, m5.COLOR_BLACK)
'    
'	' Draw unit below value (text size 2)
'	m5.PrintCentered(X + W / 2, Y + (H / 2) + 18, unitStr, 1, m5.COLOR_WHITE, m5.COLOR_BLACK)
'End Sub

'' Set sensor reading as row with:
'' Label Value Unit
'Private Sub SetSensorRow(y As Int, label As String, value As String, unit As String, textcolor As Int)
'	' Text settings
'	Dim textsize As Int = 3
'
'	' Text position
'	Dim xlabel As Int = 10
'	Dim xvalue As Int = (m5.GetWidth / 2) - 30
'	Dim xunit As Int = m5.GetWidth - 50
'
'	' Label
'	m5.SetTextAt(xlabel, y, label, textsize, textcolor)
'	m5.SetTextAt(xvalue, y, value, textsize, textcolor)
'	m5.SetTextAt(xunit, y, unit, textsize * 0.9, textcolor)
'End Sub
'
