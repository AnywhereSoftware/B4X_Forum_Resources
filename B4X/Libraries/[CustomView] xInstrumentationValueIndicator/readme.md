### [CustomView] xInstrumentationValueIndicator by rwblinn
### 12/04/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136240/)

**xInstrumentationValueIndicator** is an open source B4X Library.  
The xInstrumentationValueIndicator (Custom View) purpose is to display an indicator with value and (optional) unit.  
  
![](https://www.b4x.com/android/forum/attachments/122138)  
  
**Features**  

- Display a value and optional unit in an indicator.
- Supported indicators: Gauge|GaugeHalf|HorizontalBar|VerticalBar|Triangle|Circles.
- Many instrument properties can be set either in the visual designer or via methods (code).
- Written in B4X, source code included in the b4xlib file (zip format).

**Attached**  
The **xInstrumentationValueIndicator-NNN.zip** (NNN is version number) archive contains  

- B4X library xInstrumentationValueIndicator.b4xlib.
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
```

  
  
**Licence**  
GNU General Public License v3.0.  
Developed for personal use only.  
  
**ToDo**  
See file TODO.md.  
  
**Changelog**  
v1.10 (20211204) - Packed as B4XLib.  
See file CHANGELOG.md.