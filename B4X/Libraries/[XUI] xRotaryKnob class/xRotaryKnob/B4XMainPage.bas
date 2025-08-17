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
	
	Private xRotaryKnob1, xRotaryKnob2, xRotaryKnob3 As xRotaryKnob
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Sleep(0)
	
	xRotaryKnob2.Initialize(Me, "xRotaryKnob2")
	xRotaryKnob2.BackgroundColor = xui.Color_LightGray
	xRotaryKnob2.KnobBorderColor = xui.Color_Black
	xRotaryKnob2.HighlightTextColor = xui.Color_Blue
	xRotaryKnob2.KnobColor = xui.Color_Green
	xRotaryKnob2.LineColor = xui.Color_Yellow
	xRotaryKnob2.OffsetAngle = 30
	xRotaryKnob2.ScaleMaxValue = 100
	xRotaryKnob2.ScaleMinValue = 0
	xRotaryKnob2.ScaleNbValues = 11
	xRotaryKnob2.TextColor = xui.Color_Red
	xRotaryKnob2.SnapMode = "ALLWAYS"
#If B4J
	xRotaryKnob2.AddToParent(Root, 40, 280, 200, 200)
#Else If B4A
	xRotaryKnob2.AddToParent(Root, 10dip, 200dip, 150dip, 150dip)
#Else If B4i
	xRotaryKnob2.AddToParent(Root, 10dip, 220dip, 150dip, 150dip)
#End If
	xRotaryKnob2.Value = 56
	
	xRotaryKnob3.Value = 56
End Sub

Private Sub xRotaryKnob1_ValueChanged(Value As Double)
	Log("1: " & NumberFormat(Value, 1, 2))
End Sub

Private Sub xRotaryKnob2_ValueChanged(Value As Double)
	Log("2: " & Value)
End Sub

Private Sub xRotaryKnob3_ValueChanged(Value As Double)
	Log("3: " & Value)
End Sub
