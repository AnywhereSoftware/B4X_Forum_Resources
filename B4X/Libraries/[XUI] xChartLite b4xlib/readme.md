###  [XUI] xChartLite b4xlib by klaus
### 01/01/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140197/)

**Current version : 1.8**  
  
xChartLite is a b4xlib library, it is a lite version of the [xChart library](https://www.b4x.com/android/forum/threads/b4x-xui-xchart-class-and-b4xlib.91830/#content).  
A mini version is also available:[xChartMini](https://www.b4x.com/android/forum/threads/b4x-xui-xchartmini-b4xlib.146592/).  
  
It has automatic scales, automatic text size according to the chart size.  
These can also be set manually.  
  
I am convinced that many user do not need all kind of different possible charts and settings.  
The size of the code is almost one third of the full version.  
  
Supported charts:  
- Pie  
- Bar  
- Stacked bar  
- Lines  
  
The demo project is a B4XPages project using the xChartLite library.  
Tested on PC, Android Samsung S10, Samsung Tab S2, iPhone 8 and iPad.  
**xChartDemoV1\_4.zip** B4XPages cross platform project using the xChartLite library, you need to copy the xChartLite.b4xlib file into your AdditionalLibraries\B4X folder.  
**xChartLite.b4xlib** The xChartLite B4X library file. You must copy it into your your AdditionalLibraries\B4X folder.  
**xChartLite.xml** Help file, it is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
 **Don’t copy the xChartLite.xml file to the AdditionalLibraries folder!**  
  
  
![](https://www.b4x.com/android/forum/attachments/128620)  
  
EDIT: 2025.01.01 Version 1.8  
Improved check of chart incompatibilities  
Changed the 0 axis highligt property, it is now behind the data lines  
Added the DrawGridFrame, DrawHorizontalGridLines, DrawVerticalGridLines, SetBarMeanValueFormat, BarMarginMode properties  
Added the MaxDigits, NumberFormatGroupingUsed and NumberFormatGroupingCharacter properties  
  
EDIT: 2023.11.14 Version 1.6  
Added check of chart incompatibilities  
Amended problem with DisplayValues and DisplayValuesOnHover  
Added GetMaxNumberBars2, does not need to know the data values.  
Set Items and Points lists as Public  
Only the xChartLite.b4xlib the xChartLite.xml files have been updated.  
  
EDIT: 2022.06.01 Version 1.3  
Added the DisplayValuesOnHover property: Show values when hovering with the cursor over a chart; valid only for B4J.  
Added AxisTextColor property  
  
V1.2 Amended problem with min bar width for STACKED\_BAR charts.  
V1.1 Added PieStartAngle, PiePercentageNbFractions, PieAddPercentage and ValuesBackground properties  
Only the xChartLite.b4xlib the xChartLite.xml files have been updated.  
  
**xChartLite**  
  
 **Author:** Klaus CHRISTL (klaus)  
**Version: 1.8**  
  

- **xChartLite**

- **Events:**

- **CursorTouch** (Action As Int, CursorPointIndex As Int)
*Action, same as the Panel Touch event.  
 CursorPointIndex, is the index of the point at the current cursor position.*
- **Fields:**

- **mBase** As B4XView
- **Items** As List
*Items are Bars, Lines etc.*- **Points** As List
*Points contain the point coordinates.*
- **Methods:**

- **AddBar** (Name As String, BarColor As Int) As String
*adds a bar  
 only for Bar and StackedBar charts !*- **AddBarMultiplePoint** (X As String, YArray As Double())
*adds multibar points data  
 only for Bar and StackedBar charts !*- **AddBarPointData** (X As String, Y As Double) As String)
*adds single bar point data  
 only for Bar charts !*- **AddLine** (Name As String, LineColor As Int)
*adds a line  
 only for Line charts !*- **AddLine2** (Name As String, LineColor As Int, StrokeWidth As Int, PointType As String, PointFilled As Boolean, PointColor As Int) As String
*adds a line  
 StrokeWidth = line thickness  
 PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"  
 only for Line charts !*- **AddLineMultiplePoints** (X As String, YArray As Double(), ShowTick As Boolean) As String
*adds multiline points data  
 ShowTick = True displays the x value in the X axis  
 only for Line charts !*- **AddLinePointData** (X As String, Y As Double, ShowTick As Boolean)
*adds single line point data  
 ShowTick = True displays the x value in the X axis  
 only for Line charts !*- **AddPie** (Name As String, Value As Float, Color As Int) As String
*Adds a pie slice item  
 Color: 0 = random color  
 only for Pie charts !*- **Base\_Resize** (Width As Double, Height As Double)
*resizes the Chart with new Width and Height*- **ClearData**
*clears all data, not the title nor axis names*- **ClearPoints**
*clears all points, not the title nor axis names*- **DrawChart**
*draws a chart*- **GetMaxNumberBars** As Int
*Returns an Int  
 gets the max number of displayable bars or group of bars  
 this method can be called before DrawChart to determine the number max of displayable bars  
 this can allow to adapt the filling routine according to the capacity of the chart***.**- **GetMaxNumberBars2** As Int
*Gets the max number of displayable bars or group of bars.  
 This method can be called before DrawChart to determine the number max of displayable bars.  
 This can allow to adapt the filling routine according to the capacity of the chart.  
 Not as precise as GetMaxNumberBars*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **JumpTo** (Index As Int)
*Jumps to the given index when a chart is zoomed.  
 does nothing when the chart is unzoomed.*- **NumberFormat3** (Number As Double, MaxDigits As Int) As String
*formats a number with scientific notation  
 MaxDigits = number max of digits  
 Examples: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.23E10*- **RemovePointData** (Index As Int) As String
*removes the data of the point with the given index*- **SetBarMeanValueFormat** (MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)
*Sets a custom number format for the bar mean line value, values like NumberFormat2  
 If set, it overides the default format  
 To go back to the default format, comment the line defining the custom number format*
- **Properties:**

- **AutomaticScale** As Boolean
*gets or sets the AutomaticScale property  
 if True, the scales are automatically calculated to fill the chart, with 1, 2, 2.5, 5 standardized scales*- **AutomaticTextSizes** As Boolean
*gets or sets the AutomaticTextSizes property  
 if True, the text sizes are automatically calculated according to the chart size*- **AxisTextColor** As Int
*gets or sets the AxisTextColor property*- **AxisTextSize** As Float
gets or sets the AxisTextSize property
setting this text size sets automatically AutomaticTextSizes = False- **BarMarginMode** As Int
*Gets or sets the BarMarginMode property  
 Possible values: 0, 1, 2  
 0 > The bar width is an Int, this produces constant bar widths and variable margins at the left and right side and a constant chart width  
 1 > The bar width is a Double, this produces variable bar widths and fixed margins at the left and right side and a constant chart width  
 2 > The bar width is an Int, this produces constant bar widths, and fixed margins and a variable chart width*- **BarValueOrientation** As Boolean
gets or sets the BarValueOrientation property
Possible values: VERTICAL, HORIZONTAL- **ChartBackgroundColor** As Int
*sets the ChartBackgroundColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ChartBackgroundColor = xui.Color\_RGB(207, 220, 220)</code>*- **ChartType** As String
*gets or sets the chart type  
 Possible values: LINE, BAR, H\_BAR, STACKED\_BAR, H\_STACKED\_BAR, PIE, YX\_CHART, RADAR*- **Differe**ntScales As Boolean
*gets or sets the DifferentScales property, only for LINE and YX\_CHART charts.  
 when True, displays the lines with different automatic scales for two up to four lines.  
 if the number of lines is smaller than 2 and bigger than 4, then all lines have the same scale.*- DisplayValu**es** As Boolean
*gets or sets the DisplayValues property  
 if True, displays the item values when moving the finger or the cursor on the chart.*- **DisplayValuesOnHover** As Boolean
*gets or sets the DisplayValuesOnHover property  
 if True, displays the item values when hovering with the cursor over a chart; valid only for B4J.*- **DrawGridFrame** As Boolean
*sets or gets the DrawGridFrame property, True by default   
 if False, no frame, only the X and Y axes are drawn*- **DrawHorizontalGridLines** As Boolean
*sets or gets the DrawHorizontalGridLines property, True by default  
 if False, no horizontal grid lines are drawn*- **DrawVerticalGridLines** As Boolean
*gets or sets the DrawOuterFrame property of the Chart  
 draws an outer frame around the chart*- **DrawXScale** As Boolean
*gets or sets the DrawXScale property  
 True by default, if False doesn't draw the X scale values  
 not drawing the scale can be useful for small charts  
 not for logarithmic scales*- **DrawYScale** As Boolean
*gets or sets the DrawYScale property  
 True by default, if False doesn't draw the Y scale values  
 not drawing the scale can be useful for small charts  
 not for logarithmic scales*- **GradientColors** As Boolean
*gets or sets the GradientColors property*- **GradientColorsAlpha** As Int
*gets or sets the GradientColorsAlpha property  
 values between 0 and 255  
 setting this value, set automatically the GradientColors property to True*- **GridColor** As Int
*sets the GridColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.GridColor = xui.Color\_RGB(169, 169, 169)</code>*- **GridFrameColor** As Int
*sets the GridFrameColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.GridFrameColor = xui.Color\_Blue</code>*- **Height** As Int
*gets or sets the Height property*- **IncludeBarMeanLine** As Boolean
*gets or sets the IncludeBarMeanLine property  
 possible only for single bar charts*- **IncludeLegend** As String
*gets or sets the IncludeLegend property  
 possible values: NONE, TOP\_RIGHT, BOTTOM*- **IncludeValues** As String
*gets or sets the IncludeValues property  
 possible only for single bar charts or pie charts with TOP\_RIGHT legend*- **Left** As Int
*gets or sets the Left property*- **LegendBackgroundColor** As Int
*sets the LegendBackgroundColor property  
 the color must be an xui.Color  
 Example code: xChart1.LegendBackgroundColor = xui.Color\_ARGB(102, 255, 255, 255)*- **LegendTextColor** As Int
*sets the LegendTextColor property  
 the color must be an xui.Color  
 Example code: xChart1.LegendTextColor = xui.Color\_Black*- **LegendTextSize** As Float
*gets or sets the LegendTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **MaxDigits** As Int
*Gets or sets the MaxDigits property  
 Number of digits of the displayed values  
 Values between 6 and 10  
 Default value = 6  
 Examples for 6 digits: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.2E10  
 Examples for 8 digits: 1.2345678 / 12.345678 / 1234.5678 / 12345678 / 1.2345E10*- **NbPoints** As Int [read only]
*gets the number of points (read only)*- **NbYIntervals** As Int
*gets or sets the NbYIntervals property, number of Y axis intervals  
 should be an even number, otherwise the 0 scale value might not be displayed*- **NumberFormatGroupingCharacter** *As* String
*Gets or sets the NumberFormatGroupingCharacter property  
 Possible values Space or Comma.  
 Displays big numbers like  
 1 234 567.89 or 1,234,567.89 instead of 1234567.89  
 The NumberFormatGroupingUsed property must be set to True*- **NumberFormatGroupingUsed** As Boolean
*Gets or sets the NumberFormatGroupingUsed property  
 The same as in NumberFormat2(GroupingUsed) True displays big numbers like  
 1 234 567.89 or 1,234,567.89 instead of 1234567.89*- **PiePercentageNbFractions** As Int
gets or sets the number of fractions for pie percentage values
min = 0 max = 2- **PieStartAngle** As Int
*gets or sets the PieStartAngle property  
 default value = 0 (three o'clock), positive clockwise  
 twelve o'clock = -90*- **ScaleTextColor** As Int
*sets the ScaleTextColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ScaleTextColor = xui.Color\_Blue</code>*- **ScaleTextSize** As Float
*gets or sets the ScaleTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **ScaleValues** As String
*gets or sets the ScaleValues property  
 it is a string with the different scale values separated by the exclamation mark.  
 it must begin with 1! and end with !10  
 Example: the default property 1!2!2.5!5!10*- **Snapshot** As B4XBitmap [read only]
*returns a B4XBitmap object of the chart (read only)*- **Subtitle** As String
*gets or sets the Subtitle property*- **SubtitleTextColor** As Int
gets or sets the SubtitleTextColor property
the color must be an xui.Color
Example code: <code>xChart1.SubitleTextColor = xui.Color\_Black</code>- **SubtitleTextSize** As Float
gets or sets the SubtitleTextSize property
setting this text size sets automatically AutomaticTextSizes = False- **Title** As String
*gets or sets the Chart title*- **TitleTextColor** As Int
*sets the TitleTextColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.TitleTextColor = xui.Color\_Black</code>*- **TitleTextSize** As Float
*gets or sets the TitleTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **Top** As Int
*gets or sets the Top property*- **ValuesBackgroundColor** As Int
*sets the ValuesBackgroundColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ValuesBackgroundColor = xui.Color\_Black</code>*- **ValuesTextColor** As Int
*sets the ValuesTextColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ValuesTextColor = xui.Color\_Black</code>*- **ValuesTextSize** As Float
*gets or sets the ValuesTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **Visible** As Boolean
*gets or sets the Visible property*- **Width** As Int
*gets or sets the Width property*- **XAxisName** As String
*gets or sets the X axis name*- **XScaleTextOrientation** As String
*gets or sets the X scale text orientation  
 Possible values: VERTICAL, HORIZONTAL, 45 DEGREES*- **YAxisName** As String
*gets or sets the Y axis name*- **YScaleMaxValue** As Double
*gets or sets the Y scale max value  
 works only with AutomaticScale = False  
 setting XScaleMaxValue sets automatically AutomaticScale = False*- **YScaleMinValue** As Double
*gets or sets the Y scale min value  
 works only with AutomaticScale = False  
 setting XScaleMaxValue sets automatically AutomaticScale = False*- **YZeroAxis** As Boolean
*gets or sets the YZeroAxis property for LINE charts  
 if all values are positives, sets the lower Y scale to zero  
 if all values are negatives, sets the upper Y scale to zero*