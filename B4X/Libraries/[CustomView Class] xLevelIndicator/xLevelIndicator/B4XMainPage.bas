B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Notes
'B4XMainpage - Main page displaying several level indicators.
'20211109 rwbl
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	'Three level indicators as examples
	Private BatteryIndicator As xLevelIndicator
	Private VoltageIndicator As xLevelIndicator
	Private WaterTankIndicator As xLevelIndicator
	Private lblWaterTank As B4XView
	'Timer generating random level values for the indicators
	Private TimerLevel As Timer
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = False
	Log($"B4X CustomView - xLevelIndicator ${BatteryIndicator.Version}"$)
	TimerLevel.Initialize("TimerLevel", 2000)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4X CV xLevelIndicator")
	CallSubDelayed(Me, "SetProperties")
End Sub

'Set properties or the indicators instead using the visual designer.
Sub SetProperties
	BatteryIndicator.BarColor = xui.Color_Blue
	BatteryIndicator.LevelTextPrefix = "Battery "
	BatteryIndicator.LevelTextSuffix = "%"
	BatteryIndicator.LevelTextColor = xui.Color_Blue
	BatteryIndicator.LevelColor = xui.Color_White

'	Commented out
'	VoltageIndicator.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Red, 0dip)
'	VoltageIndicator.LevelMax = 12
'	VoltageIndicator.BarColor = xui.Color_Red
'	VoltageIndicator.LevelTextPrefix = "Battery "
'	VoltageIndicator.LevelTextSuffix = "V"

'	WaterTankIndicator.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Gray, 25dip)

	'Set the indicator fontawesome after completing this sub (required for B4A)
	CallSubDelayed(Me, "SetFontAwesome")
	CallSubDelayed(Me, "SetColorAndBorder")
	'Start the timer generating random levels
	TimerLevel.Enabled = True
End Sub

'Set the level indicator properties (=bottom label of the custom view)
'Note: If fontawesome, then text is set using hex value as int ... but also possible using string via Chr(Bit.ParseInt("F0EB", 16)) [without 0x]
Sub SetFontAwesome
	'Example setting fontawesome propertirs for the battery indicator instead via the visual designer
	BatteryIndicator.IndicatorFontAwesome = True
	BatteryIndicator.IndicatorText = Chr(0xF240)
	BatteryIndicator.IndicatorVisible = True
End Sub

'Set the background color and the border of the indicator.
'This example draws the indicator as kind of tank image.
'Set the background color of the labels for level and indicator to transparent.
Sub SetColorAndBorder
	WaterTankIndicator.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Gray, 25dip)
End Sub

'Generate random indicator values
Sub TimerLevel_Tick
	BatteryIndicator.Level = Rnd(0, 100)
	VoltageIndicator.Level = Rnd(0, 12)
	WaterTankIndicator.Level = Rnd(0, 500)
End Sub

'Handle battery level value changed.
'Depending battery level the battery fontawesome icon is set (empty , quarter, half, full) and the background color (green, yellow, red)
'The battery icon color can also be set (commened out)
Private Sub BatteryIndicator_ValueChanged(value As Int)
	Log($"BatteryIndicator_ValueChanged: ${value}"$)
	Dim iconHex As Int
	If BatteryIndicator.Level <= 10 Then
		iconHex = 0xF244
'		BatteryIndicator.IndicatorTextColor = xui.Color_Red
		BatteryIndicator.IndicatorColor = xui.Color_Red
	Else If BatteryIndicator.Level > 10 And BatteryIndicator.Level <= 25 Then
		iconHex = 0xF243
'		BatteryIndicator.IndicatorTextColor = xui.Color_Yellow
		BatteryIndicator.IndicatorColor = xui.Color_Yellow
	Else If BatteryIndicator.Level > 25 And BatteryIndicator.Level <= 50 Then
		iconHex = 0xF242
'		BatteryIndicator.IndicatorTextColor = defaultColor
		BatteryIndicator.IndicatorColor = xui.Color_Green
	Else If BatteryIndicator.Level > 50 And BatteryIndicator.Level <= 75 Then
		iconHex = 0xF241
'		BatteryIndicator.IndicatorTextColor = defaultColor
		BatteryIndicator.IndicatorColor = xui.Color_Green
	Else
		iconHex = 0xF240
'		BatteryIndicator.IndicatorTextColor = defaultColor
		BatteryIndicator.IndicatorColor = xui.Color_Green
	End If
	BatteryIndicator.IndicatorText = Chr(iconHex)
End Sub

Private Sub VoltageIndicator_ValueChanged(value As Int)
'	Log($"VoltageIndicator_ValueChanged: ${value}"$)
End Sub

'Example using the watertank indicator value changed event to set a label with tank state and level pct.
Private Sub WaterTankIndicator_ValueChanged(Value As Int)
	Dim levelPct As Int = 0
	If Value > 0 Then levelPct = (Value / (WaterTankIndicator.LevelMax - WaterTankIndicator.LevelMin)) * 100
	Dim levelStr As String
	If levelPct < 10 Then levelStr = "Empty"
	If levelPct >= 10 And levelPct < 25 Then levelStr = "Low"
	If levelPct >= 25 And levelPct < 90 Then levelStr = "OK"
	If levelPct > 90 Then levelStr = "Full"
	lblWaterTank.Text = $"${levelStr}${CRLF}${levelPct}%"$
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
