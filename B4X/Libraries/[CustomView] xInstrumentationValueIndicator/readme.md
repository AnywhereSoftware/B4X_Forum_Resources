[B]xInstrumentationValueIndicator[/B] is an open source B4X Library.
The xInstrumentationValueIndicator (Custom View) purpose is to display an indicator with value and (optional) unit.

[B]Features[/B]
[LIST]
[*]Display a value and optional unit in an indicator.
[*]Supported indicators: Gauge|GaugeHalf|HorizontalBar|VerticalBar|Triangle|Circles.
[*]Many instrument properties can be set either in the visual designer or via methods (code).
[*]Written in B4X, source code included in the b4xlib file (zip format).
[/LIST]
[B]Attached[/B]
The [B]xInstrumentationValueIndicator-NNN.zip [/B](NNN is version number) archive contains
[LIST]
[*]B4X library xInstrumentationValueIndicator.b4xlib.
[*]B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).
[*]NOTE: The B4i code is not developed.
[/LIST]

[B]Install[/B]
Copy the b4xlib file to the respective B4X additional libraries folder.

[B]Methods[/B]
See the B4XPages sample below or lookup the source source.

[B]B4XPages Sample B4XMainPage.bas[/B]
[CODE=b4x]
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xVIGauge As xInstrumentationValueIndicator
	Private xVIHorizontalBar As xInstrumentationValueIndicator
	Private xVIVerticalBar As xInstrumentationValueIndicator
	Private xVITriangle As xInstrumentationValueIndicator
	Private xVICircles As xInstrumentationValueIndicator
	Private xVIGaugeHalf As xInstrumentationValueIndicator
	'Define the instruments array - used to set common properties
	Private Instruments() As xInstrumentationValueIndicator
	Private btnSimulator As B4XView
	Private TimerValue As Timer
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = False
	TimerValue.Initialize("TimerValue", 2000)
	TimerValue.Enabled = False
End Sub

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
[/CODE]

[B]Hints[/B]
The custom view can also be included in a B4X library, like xInstrumentationValueIndicator.b4xlib.
Create a manifest file manifest.txt:
[CODE]Version=1.00
Supported Platforms=B4A,B4J
[/CODE]
Create an ZIP archive: Add manifest.txt, xInstrumentationValueIndicator.bas.
Save the ZIP archive as xInstrumentationValueIndicator.b4xlib and copy to the B4J/B4A additional libraries folder.
Note: if using also for B4i, add B4i to the supported platforms - not tested.

[B]Licence[/B]
GNU General Public License v3.0.
Developed for personal use only.

[B]ToDo[/B]
See file TODO.md.

[B]Changelog[/B]
v1.10 (20211204) - Packed as B4XLib.
See file CHANGELOG.md.
