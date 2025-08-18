### [CustomView Class] xLevelIndicator by rwblinn
### 11/09/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/135894/)

**xLevelIndicator** is an open source B4X CustomView Class.  
  
The xLevelIndicator purpose is to monitor the level of a device, like Battery (%), Voltage (V), Tank Level (m3) and more.  
  
![](https://www.b4x.com/android/forum/attachments/121459)  
See sample code below.  
The indicator layout is loaded from bal/bjl file. There are slight differences (simpy overlooked) between B4A & B4J as had to develop two layout files BAL and BJL.  
*Note*: Would be great to have a single visual designer (i.e. BXL) layout file which can be used by B4A, B4i, B4J.  
The layout contains at the top a lavel showing the level with prefix and suffix, in the middle a panel/pane acting as a bar, at the bottom an indicator which can be a fontawesome icon or text.  
The views of the layout can be customized via its properties.  
  
*Background*  
The background for developing this B4X CustomView Class, is to control a [LEGO Boost RC Car](https://www.b4x.com/android/forum/threads/rlegoinoboost.135237/#post-856874) via B4A or B4J. The Level Indicator is used to show the battery level of the LEGO MoveHUB.  
*Note*: This is the first B4X CustomView developed by the author = there might be better ways to accomplish a functionality.  
  
**Attached**  
The **xLevelIndicator-NNN.zip** (NNiN version number) archive contains the custom view xLevelIndicator.bas and B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).  
*Note*: The B4i code has not been developed and kept as placeholder in the project structure.  
  
**Install**  
Include the custom view file xLevelIndicator.bas in a project either in the project folder or if B4XPages project in the same folder as B4XMainPage.bas (with relative path).  
  
**Methods**  
See B4XPages sample next or lookup xLevelIndicator.bas.  
  
**B4XPages Sample B4XMainPage.bas**  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    'Three custom view indicators as examples  
    Private BatteryIndicator As xLevelIndicator  
    Private VoltageIndicator As xLevelIndicator  
    Private WaterTankIndicator As xLevelIndicator  
    Private lblWaterTank As B4XView  
    'Timer generating random level values for the indicators  
    Private TimerLevel As Timer  
End Sub  
  
'Init the class  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = False  
    Log($"B4X CustomView - xLevelIndicator ${BatteryIndicator.Version}"$)  
    TimerLevel.Initialize("TimerLevel", 2000)  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    B4XPages.SetTitle(Me, "B4X CV xLevelIndicator")  
    CallSubDelayed(Me, "SetProperties")  
End Sub  
  
'Set properties or the indicators instead using the visual designer.  
Sub SetProperties  
    BatteryIndicator.BarColor = xui.Color_Blue  
    BatteryIndicator.LevelTextPrefix = "Battery "  
    BatteryIndicator.LevelTextSuffix = "%"  
    BatteryIndicator.LevelTextColor = xui.Color_Blue  
    BatteryIndicator.LevelColor = xui.Color_White  
  
    'Set the indicator fontawesome after completing this sub (required for B4A)  
    CallSubDelayed(Me, "SetFontAwesome")  
    CallSubDelayed(Me, "SetColorAndBorder")  
    'Start the timer generating random levels  
    TimerLevel.Enabled = True  
End Sub  
  
'Set the level indicator properties (=bottom label of the custom view)  
'Note: If fontawesome, then text is set using hex value as int … but also possible using string via Chr(Bit.ParseInt("F0EB", 16)) [without 0x]  
Sub SetFontAwesome  
    'Example setting fontawesome properties for the battery indicator instead via the visual designer  
    BatteryIndicator.IndicatorFontAwesome = True  
    BatteryIndicator.IndicatorText = Chr(0xF240)  
    BatteryIndicator.IndicatorVisible = True  
End Sub  
  
'Set the background color and the border of the indicator.  
'This example draws the indicator as kind of tank image.  
'Hint: Set the background color of the labels for level and indicator to transparent.  
Sub SetColorAndBorder  
    WaterTankIndicator.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Gray, 25dip)  
End Sub  
  
'Generate random indicator values  
Sub TimerLevel_Tick  
    BatteryIndicator.Level = Rnd(0, 100)  
    VoltageIndicator.Level = Rnd(0, 12)  
    WaterTankIndicator.Level = Rnd(0, 500)  
End Sub  
  
'Handle battery level value changed.  
'Depending battery level the battery fontawesome icon is set (empty , quarter, half, full) and the background color (green, yellow, red)  
'The battery icon color can also be set, i.e. BatteryIndicator.IndicatorTextColor = xui.Color_Red  
Private Sub BatteryIndicator_ValueChanged(value As Int)  
    Log($"BatteryIndicator_ValueChanged: ${value}"$)  
    Dim iconHex As Int  
    If BatteryIndicator.Level <= 10 Then  
        iconHex = 0xF244  
        BatteryIndicator.IndicatorColor = xui.Color_Red  
    Else If BatteryIndicator.Level > 10 And BatteryIndicator.Level <= 25 Then  
        iconHex = 0xF243  
        BatteryIndicator.IndicatorColor = xui.Color_Yellow  
    Else If BatteryIndicator.Level > 25 And BatteryIndicator.Level <= 50 Then  
        iconHex = 0xF242  
        BatteryIndicator.IndicatorColor = xui.Color_Green  
    Else If BatteryIndicator.Level > 50 And BatteryIndicator.Level <= 75 Then  
        iconHex = 0xF241  
        BatteryIndicator.IndicatorColor = xui.Color_Green  
    Else  
        iconHex = 0xF240  
        BatteryIndicator.IndicatorColor = xui.Color_Green  
    End If  
    BatteryIndicator.IndicatorText = Chr(iconHex)  
End Sub  
  
Private Sub VoltageIndicator_ValueChanged(value As Int)  
    Log($"VoltageIndicator_ValueChanged: ${value}"$)  
End Sub  
  
'Example using the watertank indicator value changed event to set a label with tank state and level pct.  
Private Sub WaterTankIndicator_ValueChanged(Value As Int)  
    Dim levelPct As Int = 0  
    If Value > 0 Then levelPct = (Value / (WaterTankIndicator.LevelMax - WaterTankIndicator.LevelMin)) * 100  
    Dim levelStr As String  
    If levelPct < 10 Then levelStr = "Empty"  
    If levelPct >= 10 And levelPct < 25 Then levelStr = "Low"  
    If levelPct >= 25 And levelPct < 90 Then levelStr = "OK"  
    If levelPct > 90 Then levelStr = "Full"  
    lblWaterTank.Text = $"${levelStr}${CRLF}${levelPct}%"$  
    Log($"WaterTankIndicator_ValueChanged: ${value}"$)  
End Sub
```

  
  
**Licence**  
GNU General Public License v3.0.  
  
**ToDo**  
See file TODO.md.  
  
**Changelog**  
v1.00 (20211109) - First version.  
See file CHANGELOG.md.