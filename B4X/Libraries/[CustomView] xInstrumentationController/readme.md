### [CustomView] xInstrumentationController by rwblinn
### 12/04/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136157/)

**xInstrumentationController** is an open source B4X Library.  
The xInstrumentationController (Custom View) purpose is to display a device present value & display and set a setpoint via touch or method.  
  
![](https://www.b4x.com/android/forum/attachments/121934)  
  
**Features**  

- Set the device present value (PV) and display on a vertical bar (horizontal is not supported).
- Set the device setpoint (SP) (by code or touch) and display as an indicator line, with value (optional), on the vertical bar.
- Define two custom events, displayed as small circles (acting as buttons) at the bottom left & right of the instrument.
- Many instrument properties can be set either in the visual designer or via methods (code).
- Use as indicator (readonly) without ability to set the setpoint and custom events.
- Written in B4X, source code included in the b4xlib file (zip format).

**Attached**  
The **xInstrumentationController-NNN.zip**(NNN version number) archive contains  

- B4X library xInstrumentationController.b4xlib.
- B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).
- NOTE: The B4i code is not developed.

  
**Install**  
Copy the b4xlib file to the respective B4X additional libraries folder.  
  
**Methods**  
See the B4XPages sample below or lookup the source source.  
  
**B4XPages Sample B4XMainPage.bas**  

```B4X
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
```

  
  
**Hints**  
The unit textfield can be used to display other information. Example showing a thermostat valve position 0-100%:  

```B4X
thermostat.Unit = $"${NumberFormat(data.Get("LEVEL") * 100, 0, 0)}%"$
```

  
  
**Licence**  
GNU General Public License v3.0 - Developed for personal use only.  
  
**ToDo**  
See file TODO.md.  
  
**Last Change**  
v1.20 (20211204) - Packed as B4XLib.  
See file CHANGELOG.md.  
  
**Other Example from Authors Smart Home**  
The instruments control Smart Home [HomematicIP](https://en.homematic-ip.com/en/start.html) Thermostats. For each thermostat the present value & setpoint are set.  
The data is live data obtained via HTTP XMLAPI (requires the Homematic Addon XMLAPI) request to the HomematicIP CCU3.  
The response is a (complex) XML tree which is parsed using [XML2Map](https://www.b4x.com/android/forum/threads/b4x-xml2map-simple-way-to-parse-xml-documents.74848/).  
The thermostat datapoints ACTUAL\_TEMPERATURE and SET\_POINT\_TEMPERATURE are used for each of the instruments.  
The red button sets the thermostat setpoint to 5°C, the green button to 23°C.  
Changing the setpoint is again done via HTTP XMLAPI request. If HTTP response is successful the instrument is updated.  
  
![](https://www.b4x.com/android/forum/attachments/121935)