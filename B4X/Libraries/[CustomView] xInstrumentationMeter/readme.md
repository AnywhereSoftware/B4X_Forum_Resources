### [CustomView] xInstrumentationMeter by rwblinn
### 12/04/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/135936/)

**xInstrumentationMeter** is an open source B4X library.  
The xInstrumentationMeter (Custom View) purpose is to display meter value or to set a meter value via touch or mouse click.  
  
![](https://www.b4x.com/android/forum/attachments/122670)  
  
**Features**  

- Display a meter, horizontal or vertical, showing a value with a scale, bar and indicator.
- Set the meter value (by code or touchable).
- Many instrument properties can be set either in the visual designer or via methods (code).
- Use as display only (readonly) by setting the custom view common property enabled to false.
- Hint: Other usage possibilities, like meter as a progressbar.

**Attached**  
The **xInstrumentationMeter-NNN.zip** (NNN is version number) archive contains  

- B4X library xInstrumentationMeter.b4xlib.
- B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).
- NOTE: The B4i code is not developed further - The class v1.01 has been tested with B4i by [USER=103337]@Johan Hormaza[/USER].

**Install**  
Copy the b4xlib file to the respective B4X additional libraries folder.  
  
**B4XPages Sample B4XMainPage.bas**  

```B4X
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
```

  
  
**Licence**  
GNU General Public License v3.0 - Developed for personal use only.  
  
**ToDo**  
See file TODO.md.  
  
**Last Change**  
v1.20 (20211204) - Packed as B4XLib.  
See file CHANGELOG.md.