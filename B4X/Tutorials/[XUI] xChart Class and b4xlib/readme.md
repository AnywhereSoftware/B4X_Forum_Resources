###  [XUI] xChart Class and b4xlib by klaus
### 02/04/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/91830/)

**Current version 10.0**  
  
A lite version is available: [xChartLite](https://www.b4x.com/android/forum/threads/b4x-xui-xchartlite-b4xlib.140197/).  
A mini version is also available:[xChartMini](https://www.b4x.com/android/forum/threads/b4x-xui-xchartmini-b4xlib.146592/).  
  
Learning B4XViews and XUI, I wrote this CustomView xChart Class.  
It is an evolution of Erels' [Android Charts Framework](https://www.b4x.com/android/forum/threads/android-charts-framework.8260/).  
  
The xChart custom view is a B4X libary.  
It works on all three platforms: B4A, B4i and B4J.  
The xChart.b4xlib and the xChart.xml files are attached.  
You need to copy the xChart.b4xlib file to the AdditionlLibraries\B4X folder!  
The recommended AdditionlLibraries folder structure is explained [HERE](https://www.b4x.com/guides/B4XGettingStarted.html#pfa).  
  
Do not copy the xChart.xml file to the AdditionalLibraries folder, copy it in another folder for all b4xlib xml files.  
Example: AdditionlLibraries\B4XlibXMLFiles  
The xChart.xml file is for help purposes only and is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
The xChart.xml file was generated with this tool: [b4xlib - XML generation](https://www.b4x.com/android/forum/threads/tool-b4xlib-xml-generation.101450/)  
  
It has automatic scales, linear and logarithmic, automatic text size according to the chart size.  
These can also be set manually.  
  
Demo projects for all three platforms as a B4XPages project.  
Tested on PC, Android Samsung S10, Samsung Tab S2, iPhone 8 and iPad.  
**B4XPagesxChartDemoV8\_8.zip** A B4XPages cross platform project using the xChart library, you need to copy the xChart.b4xlib file into your AdditionalLibraries\B4X folder.  
**B4JLogScaleV8\_8.zip** B4J project showing the logarithmic scales, it uses also the xChart library.  
**xChart.b4xlib** The xChart B4X library file. You must copy it into your your AdditionalLibraries\B4X folder.  
**xChart.xml** Help file, it is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
 Don’t copy the xChart.xml file to the AdditionalLibraries folder! Look above.  
  
  
![](https://www.b4x.com/android/forum/attachments/74001)  
  
![](https://www.b4x.com/android/forum/attachments/88515)  
This image is from the B4JLogScale demo project, there is only a B4J project to show logarithmic scale examples.  
The principles are the same for the two other platforms.  
  
![](https://www.b4x.com/android/forum/attachments/90609) ![](https://www.b4x.com/android/forum/attachments/90610)  
  
4 lines with 4 different scales the same lines with the same scale.  
  
![](https://www.b4x.com/android/forum/attachments/103192) ![](https://www.b4x.com/android/forum/attachments/109696)  
  
Radar type chart  
  
![](https://www.b4x.com/android/forum/attachments/106535) ![](https://www.b4x.com/android/forum/attachments/106538)  
H\_BAR chart type H\_STACKED\_BAR chart type  
  
The horizontal scale can be either on bottom, default, or on top.  
The vertical scale values can go from bottom to top, default, or from top to bottom.  
  
![](https://www.b4x.com/android/forum/attachments/108497)  
  
YX\_CHART with display of the cursor position.  
When the cursor is on a point, the cross-hair color changes to the curve color and a circle is drawn at the point if no points are drawn.  
  
![](https://www.b4x.com/android/forum/attachments/118189) ![](https://www.b4x.com/android/forum/attachments/118190)  
  
AREA and STACKED\_AREA chart  
  
  
![](https://www.b4x.com/android/forum/attachments/128374)  
  
[CANDLE chart](https://en.wikipedia.org/wiki/Candlestick_chart)  
  
![](https://www.b4x.com/android/forum/attachments/127668)  
  
[WATERFALL chart](https://en.wikipedia.org/wiki/Waterfall_chart)  
  
![](https://www.b4x.com/android/forum/attachments/127967)  
  
[BUBBLE chart](https://en.wikipedia.org/wiki/Bubble_chart)  
  
EDIT: 2025.01.19 Version 10.0  
Amended error when DrawXScale or DrawYScale = False for horizontal charts.  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2024.12.29 Version 9.9  
Changed the 0 axis highligt property, it is now behind the data lines  
Added the MaxDigits, BarMarginMode, NumberFormatGroupingUsed and NumberFormatGroupingCharacter properties  
  
EDIT: 2023.08.06 Version 9.8  
Changed SetZoomIndexes Zoom.EndIndex not limited to previous Zoom.EndIndex  
Set zoom min cursor width from 10dip to 15dip  
The first change allows zooming with dynamic data input and move the zoom cursor at the end.  
Demo program for [dynamic data and zoom](https://www.b4x.com/android/forum/threads/b4x-xui-xchart-class-and-b4xlib.91830/post-946982).  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2023.06.08 Version 9.7  
Added a warning for the RemovePointData method  
Changed getNbPonts to Return Points.size  
Added ZoombarEnabled property, code only not in the Designer  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2023.03.13 Version 9.6  
Amended a problem with zoom.  
  
EDIT: 2023.03.11 Version 9.5  
Amended AutomaticScales with only one point  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2023.02.12 Version 9.4  
Added SetZoomSteps(SmallStep As Int, BigStep As Int) method  
Added ZoomLeftButtonClick, ZoomRightButtonClick, ZoomLeftAreanClick and ZoomRightAreaClick events  
Added ZoomSmallStep, ZoomBigStep, ZoomBeginIndex, ZoomEndIndex and ZoomNbVisiblePoints properties read only  
Amended multiple zoom problem  
Amended GetCursorIndex when zoomed  
Added XZeroAxis and XZeroAxisHighlight properties  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2022.10.12 Version 9.2  
Added SetCustomFont(CustomFontName, CustomFontScale) method,example [HERE](https://www.b4x.com/android/forum/threads/b4x-xui-xchart-class-and-b4xlib.91830/post-909235).  
Amended legend top position overlapping with the title.  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2022.10.08 Version 9.1  
Replaced all Props.Get by Props.GetDefault  
Amended problem with DisplayValues, DisplayCursor and DisplayValuesOnHover  
Added GetMaxNumberBars2, does not need to know the data values.  
Added PieGapDegrees and PieAddPercentage properties in the code  
Only the xChart.b4xlib and xChart.xml files have been updated.  
  
EDIT: 2022.06.26 Version 9.0  
Added the DisplayValuesOnHover property: Show values when hovering with the cursor over a chart; valid only for B4J.  
Only the xChart.b4xlib and the xChart.xml file have been updated, the xChart.bas file has been removed.  
  
EDIT: 2022.06.01 Version 8.9  
Amended problem with min bar width for STACKED\_BAR charts.  
Only the xChart.b4xlib, xChart.bas and xChart.xml files have been updated.  
  
EDIT: 2022.04.24 Version 8.8  
Added a new property: CandleDisplayVolume, False by default  
Added a new method: AddCandlePoint2 including the Volume parameter  
Renamed CursorIndex to CursorPointIndex in the CursorTouch event routine  
Added DisplayCursor property to allow to display the cursor without displaying the values, False by default  
  
EDIT: 2022.04.20 Version 8.7  
Amended bottom margin when no X scale is displayed.  
  
EDIT: 2022.04.15 Version 8.6  
Added BUBBLE chart and BubbleDiameterMax, BubbleDiameterMin and BubbleSmallSnap properties.  
  
EDIT: 2022.03.31 Version 8.5  
Added WATERFALL chart and the WaterfallTotalBarColor property.  
The CandleDecreaseColor and CandleIncreaseColor properties were changed to DecreaseColor and IncreaseColor.  
These properties are also used with WATERFALL charts.  
  
EDIT: 2022.03.27 Version 8.4  
Added the CandleWickWidth property  
Changed the word Shadow to Wick for the Candle properties  
  
EDIT: 2022.03.27 Version 8.3  
Version 8.3  
Added CANDLE chart  
Version 8.2  
Added the YAxisName2 property, a second Y axis name for different scales  
  
EDIT: 2021.11.29 Version 8.1  
Added a HideLine method allowing to not display a line.  
Added SetYScaleNMinValue, GetYScaleNMinValue, SetYScaleNMaxValue and GetYScaleNMaxValue methods.  
Amended problem with DrawLinesNScales and zoom  
Amended some minor problems.  
  
EDIT: 2021.11.29 Version 8.0  
Amended graph height when no x scale nor x axis name.  
Added display of a YXChart line with only one point value with logarithmic scales.  
  
I removed the old update history.  
  
**xCharts  
  
Author:** Klaus CHRISTL (klaus)  
**Version: 10.0**  

- **xChart**

- **Events:**

- **CursorTouch** (Action As Int, CursorPointIndex As Int)
- **Touch** (X As Double, Y As Double)
- **ZoomLeftAreaClick**
- **ZoomLeftButtonClick**
- **ZoomRightAreaClick**
- **ZoomRightButtonClick**

- **Fields:**

- **xBase** As B4XView
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
 only for Bar charts !*- **AddBubble** (SerieIndex As Int, X As Double, Y As Double, Value v Double)
*Adds a point in the given Bubble series.  
 A series Bubble has no name but an x / y position and a value.  
 The value determines the area of the circle and not the radius nor diameter.  
 Only for BUBBLE charts.*- **AddBubbleSeries** (Name As String, BubbleColor As Int)
*Adds a Bubble series.  
 A Bubble series has a name and can contain bubbles with a value at different positions.  
 Only for BUBBLE charts.*- **AddBubbleSingle** (Name As String, X As Double, Y As Double, Value As Double, BubbleColor As Int)
*Adds a single Bubble.  
 A single Bubble has a name, a value and a position.  
 It is the same as a Bubble series with only one bubble.  
 The value determines the area of the circle and not the radius nor diameter.  
 Only for BUBBLE charts.*- **AddCandlePoint** (X As String, Open As Double, Height As Double, Low As Double, Close As Double, ShowTick As Boolean)
*Adds a Candel point.  
 ShowTick = True displays the x value on the X axis.*- **AddCandlePoint2** (X As String, Open As Double, Height As Double, Low As Double, Close As Double, Volume As Double, ShowTick As Boolean)
*Adds a Candel point.  
 Volume = Transaction volume during the time period.  
 ShowTick = True displays the x value on the X axis.*- **AddHorizontalLine** (Value As Double, Color As Int, StrokeWidth As Int, DisplayValue As Boolean)
*Adds a horizontal line at the given Y scale value with the given color and width.  
 If a line with this value already exist, updates the Color and StrokeWidth.  
 Valid for BAR and HBAR charts and LINE charts only with same Y scales.  
 Valid also for H\_BAR charts charts only with same Y scales, but the line is vertical.*- **AddLine** (Name As String, LineColor As Int)
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
 only for Pie charts !*- **AddRadar** (Name As String, Color As Int, SrokeWidth As Int, Filled As Boolean)
*adds a radar  
 only for Radar charts !*- **AddRadar2** (Name As String, Color As Int, SrokeWidth As Int, Filled As Boolean, PointType As String, PointFilled As Boolean, PointColor As Int)
*adds a radar  
 PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"  
 only for Radar charts !*- **AddRadarMultiplePoint** (X As String, YArray As Double)
*adds multiradar points data  
 only for Radar charts !*- **AddRadarPointData** (X As String, Y As Double)
*adds single radar data  
 only for Radar charts !*- **AddWaterfallPoint**(BarType As Stringg, X As String, Y As Double)
- **AddYXLine** (Name As String, LineColor As Int, StrokeWidth As Int) As String
*adds a YXLine  
 only for YXCharts !*- **AddYXLine2** (Name As String, LineColor As Int, StrokeWidth As Int, DrawLine As Boolean, PointType As String, PointFilled As Boolean, PointColor As Int) As String
*adds a YX line  
 StrokeWidth = line thickness  
 DrawLine = False allows to draw only the points  
 PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"  
 only for YXCharts !*- **AddYXPoint** (LineIndex As Int, X As Double, Y As Double) As String
*adds a point in the given lines*- **Base\_Resize** (Width As Double, Height As Double)
*resizes the Chart with new Width and Height*- **ClearData**
*clears all data, not the title nor axis names*- **ClearDisplayedValues**
*Clears the cursor and displayed values  
 useful if KeepDisplayValues was set to True*- **ClearPoints**
*clears all points, not the title nor axis names*- **DrawChart**
*draws a chart*- **DrawEmptyChart**
*Draws an empty chart with the current background color.*- **GetYScaleNMaxValue** (Index As Int)
*Gets the Y scale max value for the given curve.  
 Index of the curve between 0 and 3.  
 Works only with AutomaticScale = False.  
 Setting YScaleMaxValue sets automatically AutomaticScale = False.*- **GetYScaleNMinValue** (Index As Int)
*Gets the Y scale min value for the given curve.  
 Index of the curve between 0 and 3.  
 Works only with AutomaticScale = False.  
 Setting YScaleMaxValue sets automatically AutomaticScale = False.*- **GetMaxNumberBars** As Int
Returns an Int
*gets the max number of displayable bars or group of bars  
 this method can be called before DrawChart to determine the number max of displayable bars  
 this can allow to adapt the filling routine according to the capacity of the chart***.**- ****GetMaxNumberBars2**** As Int
*Gets the max number of displayable bars or group of bars.  
 This method can be called before DrawChart to determine the number max of displayable bars.  
 This can allow to adapt the filling routine according to the capacity of the chart.*
*Not as precise as GetMaxNumberBars.*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **JumpTo** (Index As Int)
*Jumps to the given index when a chart is zoomed.  
 does nothing when the chart is unzoomed.*- **MaxDigits**  As Int
*Number of digits of the displayed values.  
 Values between 6 and 10  
 Examples for 6 digits: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.2E10  
 Examples for 8 digits: 1.2345678 / 12.345678 / 1234.5678 / 12345678 / 1.2345E10*- **NumberFormat3** (Number As Double, MaxDigits As Int) As String
*formats a number with scientific notation  
 MaxDigits = number max of digits  
 Examples: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.23E10*- **NumberFormat4** (Number As Double, MaxDigits As Int, Scientific As Boolean) As String
*Formats a number with either scientific notation or n, , m, K, M, G notation.  
 MaxDigits = number max of digits.  
 Examples for 6 digits: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.23E10.  
 Examples for 6 digits: 1.23456 / 12.3456 / 1.23456K / 12.3456K / 1.23G.*- **RemoveHorizontalLine**  (Value As Double)
*Removes the horizontal line from the list with the given value**.**  
 Value = Y scale value.*- **RemovePointData** (Index As Int) As String
*removes the data of the point with the given index*- **SetBarMeanValueFormat** (MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)
sets a custom numberformat for the bar mean line value, values like NumberFormat2
if set, it overides the default format
to go back to the default format, comment the line defining the custom number format- **SetCustomFont** (CustomFontName As String, CustomFontName As Double)
*Sets a custom font.  
 CustomFontName can be either:  
 a custom font ttf file, B4J and B4A  
 or a font name only B4J  
 CustomFontScale is a scale factor to increas or decrease the text sizes  
 epending if the font is bigger or smaller than the defautl font  
 Defautlt value = 1  
 B4i, when you use a ttf file you must add the line below in the Main module in the Project Attributes Region:  
 #AppFont: MyCustomFont.ttf, replace MyCustomFont by the name of the custom font.  
Explanations here: <https://www.b4x.com/android/forum/threads/custom-fonts.46461/#content>  
 Example with a custom font file:*
xChart1.SetCustomFont("MyCustomFont.ttf", 1.2)
*Example with a custom font name:*
xChart1.SetCustomFont("Times New Roman", 1)
*Example back to default font (in this case the CustomFontScale value is automatically set to 1):*
xChart1.SetCustomFont("", 1)- **SetYScaleNMaxValue** (Index As Int)
*Sets the Y scale max value for the given curve.  
 Index of the curve between 0 and 3.  
 Works only with AutomaticScale = False.  
 Setting YScaleMaxValue sets automatically AutomaticScale = False.*- **SetYScaleNMinValue** (Index As Int)
*Sets the Y scale min value for the given curve.  
 Index of the curve between 0 and 3.  
 Works only with AutomaticScale = False.  
 Setting YScaleMinValue sets automatically AutomaticScale = False.*- **SetZoomIndexes** (BeginIndex As Int, EndIndex As Int)
*sets the zoom indexes, the values must be between 0 and Points.Size -1  
 valid only for LINE, BAR, STACKED\_BAR, H\_LINE, H\_BAR and H\_STACKEDBAR charts  
 this method should be called after having added the points data.*- **SetZoomSteps** (SmallStep As Int, BigStep As Int)
*Sets the zoom steps  
 SmallStep = step when the left or right button is pressed  
 BigStep = step when the area between the lider and a button is pressed*- **UnZoom**
*Unzooms the chart.*
- **Properties:**

- **AreaFillAlphaValue** As Int
*gets or sets the AreaFillAlphaValue property  
 this value represents the alpha value of the area fill color for AREA and STACHED\_AREA charts only  
 the area fill color is the line color with this alpha value*- **AutomaticScale** As Boolean
*gets or sets the AutomaticScale property  
 if True, the scales are automatically calculated to fill the chart, with 1, 2, 2.5, 5 standardized scales*- **AutomaticTextSizes** As Boolean
*gets or sets the AutomaticTextSizes property  
 if True, the text sizes are automatically calculated according to the chart size*- **AxisTextColor** As Int
*gets or sets the AxisTextColor property*- **AxisTextSize** As Float
gets or sets the AxisTextSize property
setting this text size sets automatically AutomaticTextSizes = False- **BarMarginMode** As Int
*Possible values: 0, 1, 2  
 0 > The bar width is an Int, this produces constant bar widths and variable margins at the left and right side and a constant chart width  
 1 > The bar width is a Double, this produces variable bar widths and fixed margins at the left and right side and a constant chart width  
 2 > The bar width is an Int, this produces constant bar widths, and fixed margins and a variable chart width*- **BarValueOrientation** As Boolean
gets or sets the BarValueOrientation property
Possible values: VERTICAL, HORIZONTAL- **BubbleDiameterMax** As Double
*Gets or sets the BubbleDiameterMax, only for BUBBLE charts.  
 Max diameter of a bubble in percent of the smallest chart side (width or height).  
 This value is used for the highest bubble value.  
 For lower values, the bubble area is proportional. The diameter is proportional to the square root of the ratio.  
 Default value 10%.*- **BubbleDiameterMin** As Double
*Gets or sets the BubbleDiameterMin, only for BUBBLE charts.  
 Min diameter of a bubble in percent of the smallest chart side (width or height).  
 Default value 1%.*- **BubbleSmallSnap** As Boolean
*Gets or sets the BubbleSmallSnap, only for BUBBLE charts.  
 False = the cursor snaps when it is insides the bubble.  
 True = the cursor snaps when it is near the bubble center (3dip).  
 Default value False.*- **CandleDrawBodyBorder** As Boolean
*Gets or sets the getCandleDrawBodyBorder, only for CANDLE charts.  
 Draws a border on the candle body with the shadow color.*- **CandleDisplayVolume** As Boolean
*Gets or sets the CandleDisplayVolume, only for CANDLE charts.  
 'True = displays the trade Volume on the bottom of the CANDLE chart and displays its value in the popup panel.  
 'Example code: <code>CandleChart1.CandleDisplayVolume = True</code>*- **CandleWickColor** As Int
*Gets or sets the CandleWickColor, only for CANDLE charts.  
 Wick is the line above and below the candle body when the Open and Close values are above or below the Low and High values.  
 It must be a xui.Color value, FF0000FF (Blue) = default value.  
 Example code:  
 CandleChart1.CandleWickColor = xui.Color\_Black*- **CandleWickWidth** As Int
*Gets or sets the CandleWickWidth, only for CANDLE charts.* *Wick is the line above and below the candle body when the Open and Close values are above or below the Low and High values.  
 It must be a dip value, not a pixel value.  
 Example code:  
 CandleChart1.CandleWickWidth = 1*- **ChartBackgroundColor** As Int
*sets the ChartBackgroundColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ChartBackgroundColor = xui.Color\_RGB(207, 220, 220)</code>*- **ChartType** As String
*gets or sets the chart type  
 Possible values: LINE, BAR, H\_BAR, STACKED\_BAR, H\_STACKED\_BAR, PIE, YX\_CHART, RADAR*- **DecreaseColor** As Boolean
*Gets or sets the DecreaseColor, only for CANDLE and WATERFALL charts.  
 The DecreaseColor is used in CANDLE charts when the Close value is lower than the Open value.  
 Or in WATERFALL charts when the bar value is negative.  
 It must be a xui.Color value, FFAA0000 (Green) = default value.  
 Example code:  
 CandleChart1.DecreaseColor = xui.Color\_RGB(128, 0, 0)*- **DifferentScales** As Boolean
*gets or sets the DifferentScales property, only for LINE and YX\_CHART charts.  
 when True, displays the lines with different automatic scales for two up to four lines.  
 if the number of lines is smaller than 2 and bigger than 4, then all lines have the same scale.*- **DisplayCursor** As Boolean
*Gets or sets the DisplayCursor property.  
 Allows to displays the cursor when clicking or moving on the chart when DislpayValues = False.*- **DisplayValues** As Boolean
*gets or sets the DisplayValues property  
 if True, displays the point values when moving the finger or the cursor on the chart.*- **DisplayValuesOnHover** As Boolean
*gets or sets the DisplayValuesOnHover property  
 if True, displays the item values when hovering with the cursor over a chart; valid only for B4J.*- **DrawGridFrame** As Boolean
*sets or gets the DrawGridFrame property, True by default  
 if False, no frame, only the X and Y axes are drawn*- **DrawHorizontalGridLines** As Boolean
*sets or gets the DrawHorizontalGridLines property, True by default  
 if False, no horizontal grid lines are drawn*- **DrawOuterFrame** As Boolean
*gets or sets the DrawOuterFrame property of the Chart  
 draws an outer frame around the chart*- **DrawVerticalGridLines** As Boolean
*sets or gets the DrawVerticalGridLines property, True by default  
 if False, no vertical grid lines are drawn*- **DrawXScale** As Boolean
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
 Example code: <code>xChart1.GridFrameColor = xui.Color\_Blue</code>*- **HBarTicksTopDown** As Boolean
gets or sets the HBarsTicksTopDown property for H\_BAR and H\_STACKED\_BAR charts
*False = draws the tick values from bottom to top, default value  
 True = draws the tick from top to bottom*- **HBarXScaleOnTop** As Boolean
*gets or sets the HBarsXScaleOnTop property for H\_BAR and H\_STACKED\_BAR charts  
 False = draws the horizontal scale on bottom, default value  
 True = draws the horizontal scale on top*- **Height** As Int
*gets or sets the Height property*- **IncludeBarMeanLine** As Boolean
*gets or sets the IncludeBarMeanLine property  
 possible only for single bar charts*- **IncludeLegend** As String
*gets or sets the IncludeLegend property  
 possible values: NONE, TOP\_RIGHT, BOTTOM*- **IncludeMaxLine** As Boolean
*gets or sets the IncludenMaxLine property, only for single line Chart  
 inserts a line at the level of the max value*- **IncludeMeanLine** As Boolean
*gets or sets the IncludeMeanLine property, only for single line Chart  
 inserts a line at the level of the mean value*- **IncludeMinLine** As Boolean
*gets or sets the IncludeMinLine property, only for single line Chart  
 inserts a line at the level of the min value*- **IncludeValues** As String
*gets or sets the IncludeValues property  
 possible only for single bar charts or pie charts with TOP\_RIGHT legend*- **IncreaseColor** As Int
*Gets or sets the IncreaseColor, only for CANDLE and WATERFALL charts.  
 The IncreaseColor is used in CANDLE charts when the Close value is higher than the Open value.  
 Or in WATERFALL charts when the bar value is negative.  
 It must be a xui.Color value, FF00AA00 (Green) = default value.  
 Example code:  
 CandleChart1.IncreaseColor = xui.Color\_RGB(0, 128, 0)*- **KeepDisplayValues** As String
*gets or sets the KeepValuesDisplay property  
 possible values:  
 NONE >; deletes the cursor and the displayed values after Touch\_Up  
 CURSOR >; keeps the cursor visible but deletes the values after Touch\_Up  
 BOTH >; keeps both, the cursor and the values visible after Touch\_Up*- **Left** As Int
*gets or sets the Left property*- **LegendBackgroundColor** As Int
*sets the LegendBackgroundColor property  
 the color must be an xui.Color  
 Example code: xChart1.LegendBackgroundColor = xui.Color\_ARGB(102, 255, 255, 255)*- **LegendTextColor** As Int
*sets the LegendTextColor property  
 the color must be an xui.Color  
 Example code: xChart1.LegendTextColor = xui.Color\_Black*- **LegendTextSize** As Float
*gets or sets the LegendTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **MaxLineColor**  As Int
*sets the single line chart MaxLineColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.MaxLineColor = xui.Color\_Red</code>*- **MeanLineColor**  As Int
*sets the single line chart MeanLineColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.MeanLineColor = xui.Color\_RGB(182, 74, 26)</code>*- **MinLineColor**  As Int
*sets the single line chart MinLineColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.MinLineColor = xui.Color\_RGB(0, 128, 0)</code>*- **MissingDataValue** As Double
*gets or sets the MissingDataValue property, only for LINE charts  
 default value 1000000000  
 when you set any value in a Line chart, it is considerd as a missing value*- ****MaxDigits**** As Int
*Gets or sets the MaxDigits property*
*Number of digits of the displayed values  
 Values between 6 and 10  
 Default value = 6  
 Examples for 6 digits: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.2E10  
 Examples for 8 digits: 1.2345678 / 12.345678 / 1234.5678 / 12345678 / 1.2345E1*- **NbPoints** As Int [read only]
*gets the number of points (read only)*- **NbXIntervals** As Int
*gets or sets the NbYIntervals property, number of X axis intervals  
 should be an even number, otherwise the 0 scale value might not be displayed  
 valid only for YXCharts*- **NbYIntervals** As Int
*gets or sets the NbYIntervals property, number of Y axis intervals  
 should be an even number, otherwise the 0 scale value might not be displayed*- ****NumberFormatGroupingCharacter**** As String
*Gets or sets the NumberFormatGroupingCharacter property  
 Possible values Space or Comma.  
 Displays big numbers like  
 1 234 567.89 or 1,234,567.89 instead of 1234567.89  
 The NumberFormatGroupingUsed property must be set to True*- ****NumberFormatGroupingUsed**** As Boolean
*Gets or sets the NumberFormatGroupingUsed property  
 The same as in NumberFormat2(GroupingUsed) True displays big numbers like  
 1 234 567.89 or 1,234,567.89 instead of 1234567.89*- **PieAddPercentage** As Boolean
gets or sets the PieAddPercentage property.- **PieGapDegrees** As Int
*gets or sets the PieGapDegrees property.  
 default value = 0* - **PiePercentageNbFractions** As Int
gets or sets the number of fractions for pie percentage values
min = 0 max = 2- **PieStartAngle** As Int
*gets or sets the PieStartAngle property  
 default value = 0 (three o'clock), positive clockwise  
 twelve o'clock = -90*- **RadarDrawScale** As Boolean
*gets or sets the RadarDrawScale property for RADAR charts  
 True = draws the spider web type scale lines or circles  
 depends on the RadarScaleType property SPIDER or CIRCLE*- **RadarDrawScaleValues** As Boolean
*gets or sets the RadarDrawScaleValues property for RADAR charts  
 True = draws the scale values*- **RadarScaleType** As String
*gets or sets the RadarScaleType property for RADAR charts  
 Either SPIDER or CIRCLE*- **RadarStartAngle** As Int
*gets or sets the RadarStartAngle property for RADAR charts  
 default value = 0 (three o'clock), positive clockwis*e
*twelve o'clock = -90*- **RemoveHorizontalLine** (Value As Double)
*removes the horizontal line from the list with the given value****.***
*Value = Y scale value****.***- **RemovePointData** (Index As Int)
*removes the data of the point with the given index***.**- **ReverseYScale** As Boolean
*gets or sets the ReverseYScale property, only for LINE and YX\_CHART charts  
 False means min value on top and max value.  
 True means min value at bottom and max value at bottom on top. Default value.*- **Rotation** As Double
*gets or sets the Rotation property of the Chart  
 rotates the entire chart*- **ScalesOnZoomedPart** As Boolean
*gets or sets the ScalesOnZooedPart property.  
 False means scales on the whoel chart.  
 True means scales on the zooem part only.*- **ScaleTextColor** As Int
*sets the ScaleTextColor property  
 the color must be an xui.Color  
 Example code: <code>xChart1.ScaleTextColor = xui.Color\_Blue</code>*- **ScaleTextSize** As Float
*gets or sets the ScaleTextSize property  
 setting this text size sets automatically AutomaticTextSizes = False*- **ScaleValues** As String
*gets or sets the ScaleValues property  
 it is a string with the different scale values separated by the exclamation mark.  
 it must begin with 1! and end with !10  
 Example: the default property 1!2!2.5!5!10*- **ScaleXValuesLog** As String
*gets or sets the ScaleXValuesLog property  
 it is a string with the different scale values, for one decade, separated by the exclamation mark  
 it must begin with 1! and end with !10  
 only for YX\_CHART X scale  
 Example: the default property 1!2!5!7!10*- **ScaleYValuesLog** As String
*gets or sets the ScaleYValuesLog property  
 it is a string with the different scale values, for one decade, separated by the exclamation mark  
 it must begin with 1! and end with !10  
 only for LINE Y scale and YX\_CHART Y scale  
 Example: the default property 1!2!5!7!10*- **Snapshot** As B4XBitmap [read only]
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
*gets or sets the Visible property*- **WaterfallTotalBarColor**
*Gets or sets the WaterfallTotalBarColor, only for WATERFALL charts.  
 Valid only for TotalBars.  
 It must be a xui.Color value, FF0000FF (Blue) = default value.  
 Example code:  
 CandleChart1.WaterfallTotalBarColor = xui.Color\_Black*- **Width** As Int
*gets or sets the Width property*- **XAxisName** As String
*gets or sets the X axis name*- **XMaxValue** As Double
*gets or sets the X Max scale value*- **XMinValue** As Double
*gets or sets the X Min scale value*- **XScaleLogaritmic** As Boolean
*gets or sets the X scale to logarithmic  
 valid only for positive numbers and for YX\_CHART*- **XScaleMaxValue** As Double
*gets or sets the X scale max value  
 works only with AutomaticScale = False  
 setting XScaleMaxValue sets automatically AutomaticScale = False  
 valid only for YXChats*- **XScaleMinValue** As Double
*gets or sets the X scale min value  
 works only with AutomaticScale = False  
 setting XScaleMinValue sets automatically AutomaticScale = False  
 valid only for YXChats*- **XScaleTextOrientation** As String
*gets or sets the X scale text orientation  
 Possible values: VERTICAL, HORIZONTAL, 45 DEGREES*- **XZeroAxis** As Boolean
*gets or sets the <xZeroAxis property for LINE charts  
 if all values are positives, sets the lower X scale to zero  
 if all values are negatives, sets the upper X scale to zero*- **XZeroAxisHighlight** As Boolean
*gets or sets the XZeroAxisHighlight property  
 if True draws the X Zero axis 2dip thick otherwise with 1dip*- **YAxisName** As String
*gets or sets the Y axis name*- **YMaxValue** As Double
*gets or sets the Y Max scale value*- **YMinValue** As Double
*gets or sets the Y Min scale value*- **YScaleLogarithmic** As Boolean
*gets or sets the Y scale to logarithmic  
 valid only for positive numbers and for LINE and YX\_CHART*- **YScaleMaxValue** As Double
*gets or sets the Y scale max value  
 works only with AutomaticScale = False  
 setting XScaleMaxValue sets automatically AutomaticScale = False*- **YScaleMinValue** As Double
*gets or sets the Y scale min value  
 works only with AutomaticScale = False  
 setting XScaleMaxValue sets automatically AutomaticScale = False*- **YXChartCrossHairColor** As Int
*gets or sets the YXChartCrossHairColor property, only for YX\_CHARTs.  
 it must be a xui.Color value, black = default value.  
 Example code: YXChart1.YXChartCrossHairColor = xui.Color\_Black.*- **YXChartCrossHairDeltaY** As Int
*gets or sets the YXChartCrossHairDeltaY property, only for YX\_CHARTs.  
 the horizontal line of the cross hair cursor is shifted topwards by the given value.  
 this useful to not cover the horizontal cursor line with the finger.*- **YXChartDisplayCrossHair** As Boolean
*gets or sets the YXChartDisplayCrossHair property, only for YX\_CHARTs.  
 True = displays cross hair lines at the cursor position.*- **YXChartDisplayPosition** As String
*gets or sets the YXChartDisplayPosition, only for YX\_CHARTs.  
 possible values:  
 CURSOR > displays the coordinates of the cursor position at the cursor position, default value.  
 CORNERS &gt; displays the coordinates of the cursor position in one of the four corners.  
 Example code: YXChart1.YXChartDisplayPosition = "CURSOR".*- **YXChartDisplayValues** As Boolean
*gets or sets the YXChartDisplayValues property, only for YX\_CHARTs.  
 True = displays the x and y coordinates of the cursor position.*- **YZeroAxis** As Boolean
*gets or sets the YZeroAxis property for LINE charts  
 if all values are positives, sets the lower Y scale to zero  
 if all values are negatives, sets the upper Y scale to zero*- **YZeroAxisHighlight** As Boolean
*gets or sets the YZeroAxisHighlight property  
 if True draws the Y Zero axis 2dip thick otherwise with 1dip*- **ZoomBarEnabled** As Booleannt
*Gets or sets the ZoomBeginIndex property  
 If False the zoom bar is disabled  
 Default value = True*- **ZoomBeginIndex** As Int
*Returns the ZoomBeginIndex property  
 ZoomBeginIndex = index of the first displayed point*- **ZoomBigStep** As Int
*Returns the zoom big step  
 ZoomBigStep = step when the area between the lider and a button is pressed*- **ZoomEndIndex** As Int
*Returns the ZoomEndIndex property  
 ZoomEndIndex = index of the last displayed point*- **ZoomNbVisiblePoints** As Int
*Returns the ZoomNbVisiblePoints property  
 ZoomNbVisiblePoints = number of visible points*- **ZoomSmallStep** As Int
*Returns the zoom small step  
 ZoomSmallStep = step when the left or right button is pressed*