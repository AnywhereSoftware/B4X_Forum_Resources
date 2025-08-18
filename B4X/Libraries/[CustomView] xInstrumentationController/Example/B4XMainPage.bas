B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Notes
'Project: B4XLib xInstrumentationController
'The xInstrumentationController purpose is to display a device present value & display and set a setpoint via touch or method.
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xController1 As xInstrumentationController
	Private xController2 As xInstrumentationController
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
	B4XPages.SetTitle(Me, "B4X CV xInstrumentationController")
	CallSubDelayed(Me, "SetProperties")
End Sub

Private Sub SetProperties
	btnSimulator.Text = IIf(TimerLevel.Enabled, "Stop Simulator", "Start Simulator")
	'Just a few
	xController1.BarBackgroundColor = xui.Color_RGB(220, 220, 220)
	xController1.ScaleMin = 10
	xController1.ScaleMax = 30
	xController1.ScaleAutoRange = 0
	xController1.CustomActionSize = 10dip
	xController1.Value = Rnd(xController1.ScaleMin, xController1.ScaleMax)
		
	Log(xController1.Tag)
End Sub

'Generate random controller / indicator values
Sub TimerLevel_Tick
	xController1.Value = Rnd(xController1.ScaleMin, xController1.ScaleMax)
	xController1.Setpoint = Rnd(xController1.ScaleMin, xController1.ScaleMax)
	xController2.Value = Rnd(xController2.ScaleMin, xController2.ScaleMax)
End Sub

Private Sub xController1_ValueChanged(value As Float)
	Log($"xController1_ValueChanged: ${LogChange}"$)
End Sub

Private Sub xController1_SetpointChanged(value As Float)
	Log($"xController1_SetpointChanged: ${LogChange}"$)
End Sub

Private Sub LogChange As String
	Return _ 
	$"Value=${NumberFormat(xController1.value, 0, xController1.ScaleDigits)}"$ & _
	$", Setpoint=${NumberFormat(xController1.setpoint, 0, xController1.ScaleDigits)}"$ & _
	$", SetpointPrevious=${NumberFormat(xController1.SetpointPrevious, 0, xController1.ScaleDigits)}"$ & _ 
	$", Delta SP-PV=${NumberFormat(xController1.Delta, 0, xController1.ScaleDigits)}"$ & _
	$", Min=${xController1.ScaleMin}, Max=${xController1.ScaleMax}"$
End Sub

Private Sub xController1_CustomAction1
	xui.MsgboxAsync($"Define custom actions or dialogs."$, "Controller1 - Custom Action 1")
	xController1.Setpoint = 5
End Sub

Private Sub xController1_CustomAction2
	xui.MsgboxAsync($"Define custom actions or dialogs."$, "Controller1 - Custom Action 2")
	xController1.Setpoint = 23
End Sub

Private Sub xController2_CustomAction2
	xui.MsgboxAsync($"Define custom action or dialogs."$, "Controller2 - Custom Action 2")
End Sub

Private Sub btnSimulator_Click
	TimerLevel.Enabled = Not(TimerLevel.Enabled)
	btnSimulator.Text = IIf(TimerLevel.Enabled, "Stop Simulator", "Start Simulator")
End Sub
