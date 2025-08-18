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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	'
	Private xVIGauge As xInstrumentationValueIndicator
	Private xVIHorizontalBar As xInstrumentationValueIndicator
	Private xVIVerticalBar As xInstrumentationValueIndicator
	Private xVITriangle As xInstrumentationValueIndicator
	Private xVICircles As xInstrumentationValueIndicator
	Private xVIGaugeHalf As xInstrumentationValueIndicator
	'Define the instruments array - used to set common properties
	Private Instruments() As xInstrumentationValueIndicator
	Private btnSimulator As B4XView
	'Timer generating random level values for the indicators
	Private TimerValue As Timer
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	TimerValue.Initialize("TimerValue", 2000)
	TimerValue.Enabled = False
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4X CV xInstrumentationValueIndicator")
	SetProperties
	CallSubDelayed(Me, "SetProperties")
End Sub

Private Sub SetProperties
	btnSimulator.Text = IIf(TimerValue.Enabled, "Stop Simulator", "Start Simulator")
	Instruments = Array As xInstrumentationValueIndicator(xVIGauge,xVIGaugeHalf,xVIHorizontalBar,xVIVerticalBar,xVITriangle,xVICircles)
	For Each Instrument As xInstrumentationValueIndicator In Instruments
		Instrument.ValueMin		= 0
		Instrument.ValueMax		= 100
		Instrument.Unit			= "%"
		Instrument.ValueSize 	= 22
		Instrument.UnitSize 	= 10
		Instrument.ShowValue	= True
		Instrument.BorderColor	= xui.Color_LightGray
		Instrument.BackgroundColor = xui.Color_ARGB(0xFF,0xFF,0xE4,0xC4)	'Bisque 
		Instrument.UnitColor = xui.Color_DarkGray
	Next
	TimerValue_Tick
End Sub

'Generate random indicator values
Sub TimerValue_Tick
	Dim Value As Float = Rnd(xVIGauge.ValueMin, xVIGauge.ValueMax)
	' Log($"TimerValue: ${Value}"$)
	For Each Instrument As xInstrumentationValueIndicator In Instruments
		Instrument.Value = Value
	Next
End Sub

Private Sub xVI_ValueChanged(value As Float)
	Dim Instrument As xInstrumentationValueIndicator = Sender
	Log($"xVI_ValueChanged: ${LogChange(Instrument)}"$)
End Sub

Private Sub LogChange(Instrument As xInstrumentationValueIndicator) As String
	Return $"Value=${NumberFormat(Instrument.value, 0, Instrument.Digits)}"$ & _
	$", Min=${Instrument.ValueMin}, Max=${Instrument.ValueMax}"$
End Sub

Private Sub btnSimulator_Click
	TimerValue.Enabled = Not(TimerValue.Enabled)
	btnSimulator.Text = IIf(TimerValue.Enabled, "Stop Simulator", "Start Simulator")
End Sub
