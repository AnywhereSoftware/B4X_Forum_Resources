### Starchild_B4J_SmartGraphView by Starchild
### 08/02/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115272/)

This library contains a custom view called **Starchild\_B4J\_SmartGraphView** which can be added into a form layout using B4J Designer. It provides a simple and stylish way of presenting dynamic data as a graphed display. Spot, Line and Bars can be used to represent the plotted data values on the graph.  
  
SmartGraphView can automatically re-scale itself to best present the plotted data, or you can choose the method it should use to automatically alter the X and Y scales when required.  
  
The main difference to other graphing solutions is that the X-Axis can also be used as a Time Line to present Y values against an X-Axis (Tick values) as Time-of-Day.  
  
Once the graph is displayed the user can drag a selection marker across the graph to read the displayed plotted data using the mouse, generating appropriate mouse events.  
  
Refer to the example provided.  
  
  
**Generated Events:  
  
MouseMoving(X As Double, Y As Double)**   
Mouse hovering over graph.  
Returns the values of the X and Y for the closest plotted data item displayed on the graph.  
  
**MouseClicked(X As Double, Y As Double)**  
Clicked on the graph  
Returns the values of the X and Y for the closest plotted data item displayed on the graph.  
  
**MouseEntering()**  
Has just moved onto the graph area.  
  
**MouseLeaving()**  
Has just moved away from the graph.  
  
  
**Methods:**  
  
**Initialize (Owner As Object, EventPrefix As String)**  
Initialise the SmartGraphView. NB: B4J Designer does this for you.  
eg. MyGraph.Initialize(Me,”MyGraph”)  
  
**Clear**  
Clear the Graph and erase ALL plotted data  
  
**Plot(X As Double,Y As Double)**  
Add this data element to the graph.  
NB: Will NOT appear on graph until RenderAllNow() is called.  
  
**SortAllDataX**  
Sort All Plotted Data into Ascending order on the X axis.  
  
**RenderAllNow**  
Redraw the Graph entirely.  
ie. Redraws the grid, both X/Y axis, the plotted data and the title.  
  
**TestGraph**  
Display a graph of test data to demonstrate some of the features.  
  
**SetAxisY( AxisName As String, Minimum As Double, Maximum As Double, NumberOfSteps As Int, StepValue As Double, MinIntegerDigits As Int, DecimalPlaces As Int )**  
Define the Y axis for the graph.  
AxisName .. text name displayed just above the top of the Y-Axis.  
Minimum .. Preferred minimum value at the bottom of the Y-Axis.  
Maximum .. Preferred maximum value at the top of the Y-Axis.  
NumberOfSteps .. number of tick interval marks on the Y-Axis. (NB: 0 = automatic)  
StepValue .. value between each step interval on the Y-Axis. (NB: 0=automatic)  
  
**SetAxisX( AxisName As String, Minimum As Double, Maximum As Double, NumberOfSteps As Int, StepValue As Double, MinIntegerDigits As Int, TimeFormat As String )**  
Define the X axis for the graph.  
AxisName .. text name displayed underneath X-Axis.  
Minimum .. Preferred minimum value at the left end of the X-Axis.  
Maximum .. Preferred maximum value at the right end of the X-Axis.  
NumberOfSteps .. number of tick interval marks on the X-Axis. (NB: 0 = automatic)  
StepValue .. value between each step interval on the X-Axis. (NB: 0=automatic)  
TimeFormat .. to show the TOD on the X axis.  
  
The X axis can show time-of-day using TICK values.  
[INDENT]"h:mma" eg. 4:32pm[/INDENT]  
[INDENT]"hh:mma" eg. 04:32pm[/INDENT]  
[INDENT]"HH:mm" eg. 16:32[/INDENT]  
[INDENT]"HH" eg. 16[/INDENT]  
[INDENT]"HH:mm:ss" eg. 16:32:41[/INDENT]  
[INDENT]NB: same format as used by B4J DateTime object[/INDENT]  
[INDENT]"" leave blank for numerical X data axis)[/INDENT]  
[INDENT][/INDENT]  
**AutoRescale(ModeX As Boolean,ModeY As Boolean)**  
Adjust Graph Minimums and Maximums to fit all Plotted data.  
NB: Should call SortAllDataX() first.  
If existing Scales do not extend far enough, then for  
[INDENT]Mode=TRUE … Increase NumberOfSteps, (StepValue remains the same)[/INDENT]  
[INDENT]Mode=FALSE .. Increase StepValue, (NumberOfSteps remains the same)[/INDENT]  
  
**RenderTitleOnly**  
Update the Title only.  
NB: Much faster to only re-draw the Title text.  
  
**AdjustRightEdge(Edge As Double)**  
Adjust the indent at the right edge of the graph.  
NB: This value is multiplied by the AXIS\_INDENT value to determine the actual right indent.  
 Edge = 1.0 … which would give a right indent of AXIS\_INDENT. The default value is (0.7)  
  
**GetTimeFormatX As String**  
Returns: Time Format used for X axis (""=numerical X data)  
(same format as used by DateTime object)  
  
**GetNameX As String**  
Returns: Name of X axis  
  
**GetNameY As String**  
Returns: Name of Y axis  
  
**Snapshot as Image**  
Returns: Image of the entire Graph (including Marker)  
  
**Snapshot2 As Image**  
'Returns: Image of the entire Graph (without Marker)  
  
  
**Properties**  
  
Visible, BackColor, DropShadow, Tag  
  
  
**Custom Properties**  
  
The following custom properties can be set in the Layout Designer or using code at run-time. They are all given a suitable default value.  
  
AXIS\_INDENT, AXIS\_COLOUR, AXIS\_LINE\_WIDTH, AXIS\_MARKER\_LENGTH, AXIS\_TEXT\_SIZE, AXIS\_X\_TEXT\_COLOUR, AXIS\_Y\_TEXT\_COLOUR, GRID\_COLOUR, SHOW\_GRID, TITLE\_TEXT, TITLE\_SIZE, TITLE\_COLOUR, OVERLAY\_TEXT, OVERLAY\_SIZE, OVERLAY\_COLOUR, SHOW\_MARKER, MARKER\_WIDTH, MARKER\_COLOUR, MARKER\_TEXT, MARKER\_TEXT\_SIZE, SHOW\_DATA\_LINE, DATA\_LINE\_COLOUR, DATA\_LINE\_WIDTH, SHOW\_DATA\_POINT, DATA\_POINT\_COLOUR, DATA\_POINT\_SIZE, SHOW\_DATA\_BAR, DATA\_BAR\_COLOUR, DATA\_BAR\_WIDTH  
  
NB: AXIS\_TEXT\_SIZE, DATA\_POINT\_SIZE and DATA\_BAR\_WIDTH can be set to (0) if you want the graph to automatically calculate a suitable value.  
  
**ReleaseKey**  
  
This is a writable only property of the SmartGraphView. You can use the graph in DEBUG mode without a valid ReleaseKey to evaluate and determine if this Object is suitable for your application. A release key is available on request from my web site [www.starchild.com.au](http://www.starchild.com.au)  
  
**Example Screen Shots**  
![](https://www.b4x.com/android/forum/attachments/90455)![](https://www.b4x.com/android/forum/attachments/90456)