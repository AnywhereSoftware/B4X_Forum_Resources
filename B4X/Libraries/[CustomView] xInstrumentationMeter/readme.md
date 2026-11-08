[B]xInstrumentationMeter[/B] is an open source B4X library.
The xInstrumentationMeter (Custom View) purpose is to display meter value or to set a meter value via touch or mouse click.

[ATTACH type="full" alt="1637052507708.png"]121757[/ATTACH]

[B]Features[/B]
[LIST]
[*]Display a meter, horizontal or vertical, showing a value with a scale, bar and indicator.
[*]Set the meter value (by code or touchable).
[*]Many instrument properties can be set either in the visual designer or via methods (code).
[*]Use as display only (readonly) by setting the custom view common property enabled to false.
[*]Hint: Other usage possibilities, like meter as a progressbar.
[/LIST]
[B]Attached[/B]
The [B]xInstrumentationMeter-NNN.zip [/B](NNN is version number) archive contains 
[LIST]
[*]B4X library xInstrumentationMeter.b4xlib.
[*]B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).
[*]NOTE: The B4i code is not developed further - The class v1.01 has been tested with B4i by @Johan Hormaza.
[/LIST]

[B]Install[/B]
Copy the b4xlib file to the respective B4X additional libraries folder.

[B]B4XPages Sample B4XMainPage.bas[/B]
[CODE=b4x]
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
[/CODE]

[B]Licence[/B]
GNU General Public License v3.0 - Developed for personal use only.

[B]ToDo[/B]
See file TODO.md.

[B]Changelog[/B]
v1.20 (20211204)
See file CHANGELOG.md.