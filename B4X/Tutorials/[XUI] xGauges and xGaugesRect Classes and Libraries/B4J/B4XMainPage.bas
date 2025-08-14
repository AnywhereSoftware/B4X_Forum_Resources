B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private TimerNeedle As Timer
	
	Private xGauge1, xGauge2 As xGauges
#If B4J
	Private xGauge3, xGauge4, xGauge5, xGauge6 As xGauges
#End If
	Private xGaugeRectH, xGaugeRectV As xGaugesRect
	Private DeltaValue = 5 As Double
	Private Value = 0 As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	xGauge2.ScaleMidLimitColors = Array As Int(xui.Color_Green, xui.Color_Yellow)
	xGauge2.ScaleMidLimit2Colors = Array As Int(xui.Color_Yellow, xui.Color_Red)

	xGaugeRectH.ScaleMidLimitColors = Array As Int(xui.Color_Green, xui.Color_Yellow)
	xGaugeRectH.ScaleMidLimit2Colors = Array As Int(xui.Color_Yellow, xui.Color_Red)
	
	xGaugeRectV.ScaleMidLimitColors = Array As Int(xui.Color_Green, xui.Color_Yellow)
	xGaugeRectV.ScaleMidLimit2Colors = Array As Int(xui.Color_Yellow, xui.Color_Red)

	TimerNeedle.Initialize("TimerNeedle", 300)
	TimerNeedle.Enabled = True
	
#If B4J
	xGauge3.GaugeTitle = "Consumption"
	xGauge3.GaugeUnit = "KWh"
'	xGauge3.NeedleON = False
	
	xGauge4.ScaleLowLimitPerCent = 100
	xGauge4.ScaleLowLimitColors = Array As Int(xui.Color_Green, xui.Color_Yellow, xui.Color_Red)
'	xGauge4.ScaleLowLimitColors = Array As Int(xui.Color_Green, xui.Color_Yellow, xui.Color_White, xui.Color_Yellow, xui.Color_Red)
	
	xGauge6.Initialize(Me, "xGauge6")
	xGauge6.GaugeType = "90° Top"
	xGauge6.NeedleBitmapFileName = "needlebike2.png"
	xGauge6.BackgroundColor = xui.Color_Blue
	xGauge6.ScaleColor = xui.Color_RGB(255, 215, 0)
	xGauge6.GaugeTitle = "Tilt"
	xGauge6.TickText = "60°|30°|0°|30°|60°"
	xGauge6.MainTickNumber = 5
	xGauge6.HalfTicks = True
	xGauge6.SmallTicksNumber = 6
	xGauge6.ScaleHighLimitColors(0) = xui.Color_Red
	xGauge6.ScaleHighLimitPerCent = 12
	xGauge6.ScaleLowLimitColors(0) = xui.Color_Red
	xGauge6.ScaleLowLimitPerCent = 12
'	xGauge6.BorderWidth = 7
'	xGauge6.BorderColor = xui.Color_Black
'	xGauge6.CornerRadius = 20
	xGauge6.AddToParent(Root, 10, 410, 180)
#End If

	For i = 0 To Root.NumberOfViews - 1
		Private obj As Object
		
		obj = Root.GetView(i).Tag
		Log(i)
		Log(GetType(obj))
		If GetType(obj).Contains("xgauges") Then
			If GetType(obj).Contains("rect") Then
				Log(obj.As(xGaugesRect).GaugeTitle)
			Else
				Log(obj.As(xGauges).GaugeTitle)
				Log(obj.As(xGauges).TickText)
			End If
		End If
	Next
End Sub

Private Sub TimerNeedle_Tick
	Value = Value + DeltaValue
	If Value > xGaugeRectH.ValueMax Then
		DeltaValue = -DeltaValue
		Value = Value + 2 * DeltaValue
	Else if Value < xGaugeRectH.ValueMin Then
		DeltaValue = -DeltaValue
		Value = Value + 2 * DeltaValue
	End If

	xGauge1.Value = Value
	xGauge2.Value = Value
	xGaugeRectH.Value = Value
	xGaugeRectV.Value = Value

#If B4J
	xGauge3.Value = Value
	xGauge4.Value = Value /100 * 16
	xGauge5.Value = Value /100 * 12
	xGauge6.Value = Value
#End If
End Sub

Private Sub xGauge1_Click
	Log("xGauge1_Click")
End Sub

Private Sub xGauge1_LongClick
	Log("xGauge1_LongClick")
End Sub

Private Sub xGaugeRectH_Click
	Log("Shape")
	xGaugeRectH.NeedleShape = "Triagle"
End Sub

#If B4J
Private Sub xGauge6_Click
	If xGauge6.TickText.CharAt(0) = "6" Then
		xGauge6.TickText = "120°|60°|0°|60°|120°"
	Else
		xGauge6.TickText = "60°|30°|0°|30°|60°"
	End If
End Sub
#End If

Private Sub xGaugeRecth_CursorValueChanged(CursorIndex As Int, CursorValue As Double)
	Log("Cursor : " & CursorIndex & " value = " & CursorValue)
End Sub

Private Sub xGaugeRectV_CursorValueChanged(CursorIndex As Int, CursorValue As Double)
	Log("Cursor : " & CursorIndex & " value = " & CursorValue)
End Sub
