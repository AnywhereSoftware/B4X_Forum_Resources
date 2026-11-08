# To-Do B4XLib xInstrumentationStateIndicator

### UPD: Enhance Documentation
Write up the custom view class documentation, hints and samples.
Provide a Smart Home Devices Control example (Thermostats, Lights, Pumps).
#### Status
Not started.

### NEW: Indicator TrafficLight Status
Display one of the three trafficlight states RED, YELLOW, GREEN using the xui colors (xui.Color_RED ...).
Something like Indicator.SetTrafficLight(RED), Indicator.SetTrafficLight(YELLOW), Indicator.SetTrafficLight(GREEN).
#### Status
Not started.

### NEW: Indicator Name Multiline
Enable displaying the indicator name with multiline(basically 2) using space as CRLF.
#### Status
Not started.

### NEW: Init Indicator from JSON string defined as property
An indicator property can be set via its according method called in f.e. B4XMainPage.
```
xStateIndicator1.Touchable = False
xStateIndicator1.SetIndicatorColorTrue(1, xui.color_blue)
xStateIndicator1.SetIndicatorStrokeColor(1, xui.Color_Transparent)
xStateIndicator2.SetIndicatorState(1, True)
xStateIndicator2.SetIndicatorBlinking(2, True)
```
The indicator properties are defined as a Type:
```
Type TIndicator (ID As Int, Name As String, Tag As String, X As Float, Y As Float, Radius As Float, _
				 Color As Int, ColorTrue As Int, ColorFalse As Int, Filled As Boolean, StrokeWidth As Float, StrokeColor As Int, _ 
				 State As Boolean, Blinking As Boolean, Touchable As Boolean, Visible As Boolean)
```

To set Indicator properties straight away at initialization, use & parse JSON string.
Example:
```
[
	{"id":1,"name":"pump 1"}, "state": false},
	{"id":2,"name":"pump 2"}, "state": true, "touchable":false}
]
```
#### Status
Not started.
