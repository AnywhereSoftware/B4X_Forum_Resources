B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Notes
'Project: B4XLib xInstrumentationMeter
'The xInstrumentationMeter (Custom View) purpose is to display meter value or to set a meter value via touch or mouse click.
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xInstrumentationMeter1 As xInstrumentationMeter
	Private xInstrumentationMeter2 As xInstrumentationMeter
	Private xInstrumentationMeter3 As xInstrumentationMeter
	Private xInstrumentationMeter4 As xInstrumentationMeter
	Private btnSimulator As B4XView
	'Timer generating random level values for the indicators
	Private TimerLevel As Timer
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	TimerLevel.Initialize("TimerLevel", 2000)
	TimerLevel.Enabled = False
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4X CV xInstrumentationMeter")
	CallSubDelayed(Me, "SetProperties")
End Sub

Private Sub SetProperties
	btnSimulator.Text = IIf(TimerLevel.Enabled, "Stop Simulator", "Start Simulator")
	'Just a few
	xInstrumentationMeter1.Value = 0
	xInstrumentationMeter2.Value = 100
	xInstrumentationMeter2.BarBackgroundColor = xui.Color_Green
End Sub

'Generate random indicator values
Sub TimerLevel_Tick
	xInstrumentationMeter1.Value = Rnd(xInstrumentationMeter1.ScaleMin, xInstrumentationMeter1.ScaleMax)
	xInstrumentationMeter2.Value = Rnd(xInstrumentationMeter2.ScaleMin, xInstrumentationMeter2.ScaleMax)
End Sub

Private Sub xInstrumentationMeter1_ValueChanged(value As Float)
	Log($"xInstrumentationMeter1_valueChanged: Value=${value}, Min=${xInstrumentationMeter1.ScaleMin}, Max=${xInstrumentationMeter1.ScaleMax}"$)
	xInstrumentationMeter1.Legend = $"${NumberFormat(value,0,xInstrumentationMeter2.ScaleDigits)}${xInstrumentationMeter2.Unit}"$
	xInstrumentationMeter3.Value =  xInstrumentationMeter2.Value
End Sub

Private Sub xInstrumentationMeter2_ValueChanged(Value As Float)
	Log($"xInstrumentationMeter2_valueChanged: Value=${Value}, Min=${xInstrumentationMeter2.ScaleMin}, Max=${xInstrumentationMeter2.ScaleMax}"$)
	xInstrumentationMeter2.Legend = $"Tank Level: ${NumberFormat(Value,0,xInstrumentationMeter2.ScaleDigits)}${xInstrumentationMeter2.Unit}"$
	xInstrumentationMeter4.Value =  xInstrumentationMeter1.Value
End Sub

Private Sub btnSimulator_Click
	TimerLevel.Enabled = Not(TimerLevel.Enabled)
	btnSimulator.Text = IIf(TimerLevel.Enabled, "Stop Simulator", "Start Simulator")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
