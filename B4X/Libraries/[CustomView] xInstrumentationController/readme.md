[B]xInstrumentationController[/B] is an open source B4X Library.
The xInstrumentationController (Custom View) purpose is to display a device present value & display and set a setpoint via touch or method.

[ATTACH type="full" alt="1637314728473.png"]121934[/ATTACH]

[B]Features[/B]
[LIST]
[*]Set the device present value (PV) and display on a vertical bar (horizontal is not supported).
[*]Set the device setpoint (SP) (by code or touch) and display as an indicator line, with value (optional), on the vertical bar.
[*]Define two custom events, displayed as small circles (acting as buttons) at the bottom left & right of the instrument.
[*]Many instrument properties can be set either in the visual designer or via methods (code).
[*]Use as indicator (readonly) without ability to set the setpoint and custom events.
[*]Written in B4X, source code included in the b4xlib file (zip format).
[/LIST]
[B]Attached[/B]
The [B]xInstrumentationController-NNN.zip[/B](NNN version number) archive contains
[LIST]
[*]B4X library xInstrumentationController.b4xlib.
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
	Private xController1 As xInstrumentationController
	Private xController2 As xInstrumentationController
	Private btnSimulator As B4XView
	Private TimerLevel As Timer
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	TimerLevel.Initialize("TimerLevel", 2000)
	TimerLevel.Enabled = False
End Sub

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
[/CODE]

[B]Hints[/B]
The unit textfield can be used to display other information. Example showing a thermostat valve position 0-100%:
[CODE]
thermostat.Unit = $"${NumberFormat(data.Get("LEVEL") * 100, 0, 0)}%"$
[/CODE]

[B]Licence[/B]
GNU General Public License v3.0 - Developed for personal use only.

[B]ToDo[/B]
See file TODO.md.

[B]Changelog[/B]
v1.20 (20211204)
See file CHANGELOG.md.

[B]Other Example from Authors Smart Home[/B]
The instruments control Smart Home [URL='https://en.homematic-ip.com/en/start.html']HomematicIP[/URL] Thermostats. For each thermostat the present value & setpoint are set.
The data is live data obtained via HTTP XMLAPI (requires the Homematic Addon XMLAPI) request to the HomematicIP CCU3.
The response is a (complex) XML tree which is parsed using [URL='https://www.b4x.com/android/forum/threads/b4x-xml2map-simple-way-to-parse-xml-documents.74848/']XML2Map[/URL].
The thermostat datapoints ACTUAL_TEMPERATURE and SET_POINT_TEMPERATURE are used for each of the instruments.
The red button sets the thermostat setpoint to 5°C, the green button to 23°C.
Changing the setpoint is again done via HTTP XMLAPI request. If HTTP response is successful the instrument is updated.

[ATTACH type="full" alt="1637314897347.png"]121935[/ATTACH]