B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'xChartLite Custom View class
'This class is a lite version of the xChart class
'
'Version 1.4
'Ameded problem with display values in BAR and STACKED_BAR charts
'
'Version 1.3
'Added the DisplayValuesOnHover property: Show values when hovering with the cursor over a chart; valid only for B4J.
'Added AxisTextColor property
'
'Version 1.2
'Amended problem with min bar width for STACKED_BAR charts.
'
'Version 1.1
'Added PieStartAngle, PiePercentageNbFractions, PieAddPercentage and ValuesBackground properties
'
'Version 1.0 2022.04.28
'
'Written by Klaus CHRISTL (klaus)

#Event: CursorTouch (Action As Int, CursorPointIndex As Int)
#RaisesSynchronousEvents: CursorTouch (Action As Int, CursorPointIndex As Int)

#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Bar chart, Description: Chart title.
#DesignerProperty: Key: Subtitle, DisplayName: Subtitle, FieldType: String, DefaultValue: 
#DesignerProperty: Key: XAxisName, DisplayName: XaxisName, FieldType: String, DefaultValue: X axis, Description: X axis name.
#DesignerProperty: Key: YAxisName, DisplayName: YaxisName, FieldType: String, DefaultValue: Y axis, Description: Y axis name.
#DesignerProperty: Key: YMaxValue, DisplayName: YMaxValue, FieldType: Int, DefaultValue: 100, Description: Max Y value manual scale.
#DesignerProperty: Key: YMinValue, DisplayName: YMinValue, FieldType: Int, DefaultValue: 0, Description: Min Y value manual scale.
#DesignerProperty: Key: YZeroAxis, DisplayName: YZeroAxis, FieldType: Boolean, DefaultValue: True, Description: Stes the min value to 0 if all values are > 0 and max valule to 0 if all values are <0.
#DesignerProperty: Key: NbYIntervals, DisplayName: NbYIntervals, FieldType: Int, DefaultValue: 10, Description: Number of Y intervals.
#DesignerProperty: Key: ChartType, DisplayName: ChartType, FieldType: String, DefaultValue: BAR, List: LINE|BAR|STACKED_BAR|PIE, Description: Selects the chart type.
#DesignerProperty: Key: ChartBackgroundColor, DisplayName: ChartBackgroundColor, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: Chart background color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridFrameColor, DisplayName: GridFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Grid frame color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridColor, DisplayName: GridColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Grid lines color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: TitleTextColor, DisplayName: TitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Title text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SubtitleTextColor, DisplayName: SubtitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Subtitle text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GradientColors, DisplayName: GradientColors, FieldType: Boolean, DefaultValue: True, Description: Use gradient or plain colors for pies and bars.
#DesignerProperty: Key: GradientColorsAlpha, DisplayName: GradientColorsAlpha, FieldType: Int, DefaultValue: 96, MinRange: 0, MaxRange: 255, Description:  Gradient colors alpha value for pies and bars.
#DesignerProperty: Key: AxisTextColor, DisplayName: AxisTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleTextColor, DisplayName: ScaleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Scale text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleValues, DisplayName: ScaleValues, FieldType: String, DefaultValue: 1!2!2.5!5!10, List: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10, Description: Scale values is a string with the different possible scale values separated by the exclamation mark and must begin with 1! and end with !10.
#DesignerProperty: Key: DrawXScale, DisplayName: DrawXScale, FieldType: Boolean, DefaultValue: True, Description: Draws the X scale. Not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: DrawYScale, DisplayName: DrawYScale, FieldType: Boolean, DefaultValue: True, Description: Draws the Y scale. Not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: AutomaticTextSizes, DisplayName: AutomaticTextSizes, FieldType: Boolean, DefaultValue: True, Description: Automatic text sizes. The text sizes are calculated depending on the chart size. The text size properties below are only valid when AutomaticTextSizes = False.
#DesignerProperty: Key: TitleTextSize, DisplayName: TitleTextSize, FieldType: Int, DefaultValue: 18, Description: Title text size. Valid only when AutomaticTextSizes = False.
#DesignerProperty: Key: SubtitleTextSize, DisplayName: SubtitleTextSize, FieldType: Int, DefaultValue: 16, Description: Subtitle text size. Valid only if AutomaticTextSizes = False.
#DesignerProperty: Key: AxisTextSize, DisplayName: AxisTextSize, FieldType: Int, DefaultValue: 14, Description: Axis name text size. Valid only when AutomaticTextSizes = False.
#DesignerProperty: Key: ScaleTextSize, DisplayName: ScaleTextSize, FieldType: Int, DefaultValue: 12, Description: Scale text size. Valid only when AutomaticTextSizes = False.
#DesignerProperty: Key: LegendTextSize, DisplayName: LegendTextSize, FieldType: Int, DefaultValue: 14, Description: Legend text size. Valid only when AutomaticTextSizes = False.
#DesignerProperty: Key: IncludeLegend, DisplayName: IncludeLegend, FieldType: String, DefaultValue: NONE, List: NONE|TOP_RIGHT|BOTTOM, Description: Include Legend. Select the position of the legend.
#DesignerProperty: Key: IncludeValues, DisplayName: IncludeValues, FieldType: Boolean, DefaultValue: False, Description: Include values in single bar charts or pie charts with TOP_RIGHT legend.
#DesignerProperty: Key: LegendBackgroundColor, DisplayName: LegendBackgroundColor, FieldType: Color, DefaultValue: 0x66FFFFFF, Description: Color of the legend background.
#DesignerProperty: Key: LegendTextColor, DisplayName: LegendTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the legend texts.
#DesignerProperty: Key: BarValueOrientation, DisplayName: BarValueOrientation, FieldType: String, DefaultValue: HORIZONTAL, List: HORIZONTAL|VERTICAL, Description: Orientation of the value text in the bars of single bar charts.
#DesignerProperty: Key: IncludeBarMeanLine, DisplayName: IncludeBarMeanLine, FieldType: Boolean, DefaultValue: False, Description: Adds a line at the mean value and its value. Only for single bar charts
#DesignerProperty: Key: AutomaticScale, DisplayName: AutomaticScale, FieldType: Boolean, DefaultValue: True, Description: The scales for the Y axis are calulated automatically.
#DesignerProperty: Key: DifferentScales, DisplayName: DifferentScales, FieldType: Boolean, DefaultValue: False, Description: Sets different scales only for LINE charts. If True uses a different automatic scale for each line from two up to four lines max!
#DesignerProperty: Key: XScaleTextOrientation, DisplayName: XScaleTextOrientation, FieldType: String, DefaultValue: HORIZONTAL, List: HORIZONTAL|VERTICAL|45 DEGREES, Description: X scale text orientation.
#DesignerProperty: Key: PieStartAngle, DisplayName: PieStartAngle, FieldType: Int, DefaultValue: 0, Description: Start angel of the pies. Default value = 0 (three o'clock); positive clockwise. Twelve o'clock = -90.
#DesignerProperty: Key: PieGapDegrees, DisplayName: PieAddPerentage, FieldType: Int, DefaultValue: 0, Description: Gap in degrees between pies. Pie charts only.
#DesignerProperty: Key: PieAddPercentage, DisplayName: PieAddPercentage, FieldType: Boolean, DefaultValue: True, Description: Add percentage values in pie slices.
#DesignerProperty: Key: PiePercentageNbFractions, DisplayName: PiePercentageNbFractions, FieldType: Int, DefaultValue: 0, Description: Number of fractions for pie percentage values: min = 0  max = 2.
#DesignerProperty: Key: DisplayValues, DisplayName: DisplayValues, FieldType: Boolean, DefaultValue: True, Description: Show the item values when clicking on a chart and moving the cursor.
#DesignerProperty: Key: DisplayValuesOnHover, DisplayName: DisplayValuesOnHover, FieldType: Boolean, DefaultValue: False, Description: Show the item values when hovering with the cursor over a chart; valid only for B4J.
#DesignerProperty: Key: ValuesTextSize, DisplayName: ValuesTextSize, FieldType: Int, DefaultValue: 14, Description: Values text size
#DesignerProperty: Key: ValuesTextColor, DisplayName: ValuesTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Values text color.
#DesignerProperty: Key: ValuesBackgroundColor, DisplayName: ValuesBackgroundColor, FieldType: Color, DefaultValue: 0xAAFFFFFF, Description: Color of the values background.

Sub Class_Globals
	Type GraphDataL (Title As String, SubTitle As String, XAxisName As String, YAxisName As String, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, Radius As Float, CenterX As Int, CenterY As Int, Rect As B4XRect, YInterval As Int, XInterval As Int, XOffset As Int, BarWidth As Int, ChartType As String, BarSubWidth As Int, IncludeBarMeanLine As Boolean, IncludeValues As Boolean, ChartBackgroundColor As Int, GridFrameColor As Int, GridColor As Int, XScaleTextOrientation As String, PieStartAngle As Int, PieGapDegrees As Int, PieAddPercentage As Boolean, GradientColors As Boolean, GradientColorsAlpha As Int, BarValueOrientation As String)
	Type PointDataL (X As String, XArray() As Double, YArray() As Double, ShowTick As Boolean)
	Type ItemDataL (Name As String, Color As Int, Value As Float, StrokeWidth As Int, DrawLine As Boolean, PointType As String, PointFilled As Boolean, PointColor As Int, YXArray As List)
	Type ScaleDataL (Scale As Double, MinVal As Double, MaxVal As Double, MinManu As Double, MaxManu As Double,	IntervalManu As Double, MinAuto As Double, MaxAuto As Double, IntervalAuto As Double, Interval As Double, NbIntervals As Int, Automatic As Boolean, Different As Boolean, Exp As Double, YZeroAxis As Boolean, ScaleValues As String, DrawXScale As Boolean, DrawYScale As Boolean)
	Type ScaleDataLogL(Scale As Double, MantMin As Int, MantMax As Int, LogMin As Double, LogMinIndex As Int, LogMax As Double, Logs() As Double, Vals() As Double, NbDecades As Int, ScaleValues As String, RadarScaleType As String)
	Type TextDataL (TitleFont As B4XFont, SubtitleFont As B4XFont, AxisFont As B4XFont, ScaleFont As B4XFont, AutomaticTextSizes As Boolean, TitleTextSize As Float, TitleTextColor As Int, SubTitleTextSize As Float, SubTitleTextColor As Int, TitleTextWidth As Int, SubtitleTextWidth As Int, AxisTextColor As Int, AxisTextSize As Float, ScaleTextSize As Float, ScaleTextColor As Int, TitleTextHeight As Int, SubTitleTextHeight As Int, AxisTextHeight As Int, ScaleTextHeight As Int)
	Type LegendDataL (IncludeLegend As String, TextFont As B4XFont, TextSize As Float, TextHeight As Int, TextColor As Int, Height As Int, LineNumber As Int, LineNumbers As List, LineChange As List, BackgroundColor As Int)
	Type ValuesDataL (Show As Boolean, ShowOnHover As Boolean, TextFont As B4XFont, TextSize As Float, TextColor As Int, TextHeight As Int, Left As Int, Top As Int, Width As Int, Height As Int, MidPoint As Int, rectValues As B4XRect, rectCursor As B4XRect, MaxDigits As Int, BackgroundColor As Int)
	Type NumberFormats(MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)

	Private xui As XUI
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Public Tag As Object
	
	Private xpnlGraph As B4XView
	Private xcvsGraph As B4XCanvas
	Private xpnlValues As B4XView
	Private xcvsValues As B4XCanvas
	Private xpnlCursor As B4XView
	Private xcvsCursor As B4XCanvas
	Private pthGrid As B4XPath
	
	Private NbMaxDifferentScales = 4 As Int
	Private Scale(NbMaxDifferentScales + 1) As ScaleDataL
	Private ScaleLog(NbMaxDifferentScales + 1) As ScaleDataLogL
	Private sX, sY(NbMaxDifferentScales) As Int
	Private BMVNF As NumberFormats		' Bar Mean Value Number Format
	Private BMVNFUsed As Boolean			' True if a custom number format is used
	Private BarWidth0 = False As Boolean
	Private mPiePercentageNbFractions As Int
	Private Items As List
	Private Points As List
	Private Graph As GraphDataL
	Private Texts As TextDataL
	Private Legend As LegendDataL
	Private Values As ValuesDataL
	Private MinMaxMeanValues(3) As Double
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	sX = 0
	sY(0) = 1
	sY(1) = 2
	sY(2) = 3
	sY(3) = 4
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
		
	Scale(sY(0)).Initialize
	Scale(sY(1)).Initialize
	Scale(sY(2)).Initialize
	Scale(sY(3)).Initialize
	Scale(sX).Initialize
	Items.Initialize
	Points.Initialize
	Graph.Initialize
	Texts.Initialize
	Legend.Initialize
	Values.Initialize
	
	Legend.LineNumbers.Initialize
	Legend.LineChange.Initialize
	
	Graph.Title = Props.GetDefault("Title", "")
	Graph.Subtitle = Props.GetDefault("Subtitle", "")
	Graph.XAxisName = Props.GetDefault("XAxisName", "X axis")
	Graph.YAxisName = Props.GetDefault("YAxisName", "Y axis")

	For i = 0 To sY.Length - 1
		Scale(sY(i)).MaxManu = Props.GetDefault("YMaxValue", 100)
		Scale(sY(i)).MinManu = Props.GetDefault("YMinValue", 0)
		Scale(sY(i)).NbIntervals = Props.GetDefault("NbYIntervals", 10)
		Scale(sY(i)).YZeroAxis = Props.GetDefault("YZeroAxis", False)
		Scale(sY(i)).Automatic = Props.GetDefault("AutomaticScale", True)
		Scale(sY(i)).Different = Props.GetDefault("DifferentScales", False)
		Scale(sY(i)).DrawYScale = Props.GetDefault("DrawYScale", True)
		Scale(sY(i)).ScaleValues = Props.GetDefault("ScaleValues", "1!2!2.5!5!10")
	Next
	Scale(sX).MaxManu = Props.GetDefault("XMaxValue", 100)
	Scale(sX).MinManu = Props.GetDefault("XMinValue", 0)
	Scale(sX).DrawXScale = Props.GetDefault("DrawXScale", True)
	Scale(sX).ScaleValues = Props.GetDefault("ScaleValues", "1!2!2.5!5!10")

	Graph.ChartType = Props.Get("ChartType")
	Scale(sX).Automatic = False
	Graph.ChartBackgroundColor = xui.PaintOrColorToColor(Props.Get("ChartBackgroundColor"))
	Graph.GridFrameColor = xui.PaintOrColorToColor(Props.Get("GridFrameColor"))
	Graph.GridColor = xui.PaintOrColorToColor(Props.Get("GridColor"))
	Graph.GradientColors = Props.Get("GradientColors")
	Graph.GradientColorsAlpha = Props.Get("GradientColorsAlpha")
	Texts.TitleTextColor = xui.PaintOrColorToColor(Props.Get("TitleTextColor"))
	Texts.SubtitleTextColor = xui.PaintOrColorToColor(Props.GetDefault("SubtitleTextColor", xui.Color_Black ))
	Texts.ScaleTextColor = xui.PaintOrColorToColor(Props.Get("ScaleTextColor"))
	Texts.TitleTextSize = Props.GetDefault("TitleTextSize", 18)
	Texts.SubtitleTextSize = Props.GetDefault("SubtitleTextSize", 16)
	Texts.AxisTextColor = xui.PaintOrColorToColor(Props.GetDefault("AxisTextColor", xui.Color_Black))
	Texts.AxisTextSize = Props.GetDefault("AxisTextSize", 14)
	Texts.ScaleTextSize = Props.GetDefault("ScaleTextSize", 12)
	Legend.TextSize = Props.GetDefault("LegendTextSize", 14)
	Legend.TextColor = xui.PaintOrColorToColor(Props.Get("LegendTextColor"))
	Legend.BackgroundColor = xui.PaintOrColorToColor(Props.Get("LegendBackgroundColor"))
	Texts.AutomaticTextSizes = Props.Get("AutomaticTextSizes")
	Graph.XScaleTextOrientation = Props.Get("XScaleTextOrientation")
	Legend.IncludeLegend = Props.GetDefault("IncludeLegend", "NONE")
	Legend.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", xui.Color_ARGB(102, 255, 255, 255)))
	Legend.TextColor = xui.PaintOrColorToColor(Props.GetDefault("LegendTextColor", xui.Color_Black))
	Graph.IncludeValues = Props.GetDefault("IncludeValues", False)
	Graph.BarValueOrientation = Props.GetDefault("BarValueOrientation", "HORIZONTAL")
	Graph.PieStartAngle = Props.GetDefault("PieStartAngle", 0)
	Graph.PieAddPercentage = Props.GetDefault("PieAddPercentage", True)
	Graph.PieGapDegrees = Props.GetDefault("PieGapDegrees", 0)
	mPiePercentageNbFractions = Props.GetDefault("PiePerentageNbFractions", 0)
	mPiePercentageNbFractions = Max(mPiePercentageNbFractions, 0)
	mPiePercentageNbFractions = Min(mPiePercentageNbFractions, 2)
	Values.Show = Props.GetDefault("DisplayValues", True)
	Values.ShowOnHover = Props.GetDefault("DisplayValuesOnHover", False)
	Values.TextSize = Props.GetDefault("ValuesTextSize", 14)
	Values.TextColor = xui.PaintOrColorToColor(Props.Get("ValuesTextColor"))
	Values.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ValuesBackgroundColor", 0xAAFFFFFF))
	Graph.IncludeBarMeanLine = Props.GetDefault("IncludeBarMeanLine", False)

	xpnlGraph = xui.CreatePanel("xpnlGraph")
	mBase.AddView(xpnlGraph, 0, 0, mBase.Width, mBase.Height)
	xcvsGraph.Initialize(xpnlGraph)
	
	xpnlCursor = xui.CreatePanel("xpnlCursor")
	mBase.AddView(xpnlCursor, 0, 0, mBase.Width, mBase.Height)
	xcvsCursor.Initialize(xpnlCursor)
	
	xpnlValues = xui.CreatePanel("xpnlValues")
	mBase.AddView(xpnlValues, 0, 0, 100dip, 100dip)
	xpnlValues.Visible = False
	xcvsValues.Initialize(xpnlValues)
	
	BMVNFUsed = False
	BMVNF.MinimumIntegers = 1
	BMVNF.MaximumFractions = 2
	BMVNF.MinimumFractions = 2
	BMVNF.GroupingUsed = False
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xpnlGraph.Width = Width
	xpnlGraph.Height = Height
	xcvsGraph.Resize(Width, Height)
	xpnlCursor.Width = Width
	xpnlCursor.Height = Height
	xcvsCursor.Resize(Width, Height)
	If Points.Size > 0 Or Graph.ChartType = "PIE" Then
		DrawChart
	End If
End Sub

Private Sub xpnlCursor_Touch (Action As Int, X As Float, Y As Float)
	If Action = xpnlCursor.TOUCH_ACTION_MOVE_NOTOUCH Then
		If Values.Show = True And Values.ShowOnHover = True Then
			If X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				DrawItemValues(X, Y)
				xpnlValues.Visible = True
			Else
				xpnlValues.Visible = False
				xcvsCursor.ClearRect(Values.rectCursor)
			End If
		End If
	End If
	
	If Graph.ChartType = "PIE" Or Graph.ChartType = "YX_CHART" Or Graph.ChartType = "BUBBLE" Then
		'no values shown in a PIE, YX_CHART and BUBBLE chart
		Return
	End If
	
	Private PointIndex As Int
	PointIndex = GetCursorIndex(X)

	If xui.SubExists(mCallBack, mEventName & "_CursorTouch", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_CursorTouch", Action, PointIndex)
	End If
	
	Select Action
		Case xpnlCursor.TOUCH_ACTION_DOWN
			If X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				DrawItemValues(X, Y)
				xpnlValues.Visible = True
			End If
		Case xpnlCursor.TOUCH_ACTION_UP
			xpnlValues.Visible = False
			xcvsCursor.ClearRect(Values.rectCursor)
'			xcvsCursor.Invalidate
		Case xpnlCursor.TOUCH_ACTION_MOVE
			If xpnlValues.Visible = False Then
				xpnlValues.Visible = True
			End If
			
			If X > Graph.Left And X < Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				DrawItemValues(X, Y)
			End If
	End Select
End Sub

Private Sub InitValues
	Private r As B4XRect
	Private i, LineNumber As Int
	
	Values.Left = Graph.Left + 2dip
	Values.Top = Graph.Top + 2dip
	Values.MaxDigits = 6
	
	LineNumber = Items.Size + 1
	Values.Height = Values.TextHeight * 1.3 * (LineNumber + 0.3)
	
	Private ItemWidth As Int
	Private txtX As String
	If Graph.XAxisName = "" Then
		txtX = "x = "
	Else
		txtX = Graph.XAxisName & " = "
	End If
	ItemWidth = MeasureTextWidth(txtX, Values.TextFont)
	For Each Item As ItemDataL In Items
		Private txt As String = Item.Name & " = "
		ItemWidth = Max(ItemWidth, MeasureTextWidth(txt, Values.TextFont))
	Next
	If Graph.ChartType.Contains("STACKED") Then
		ItemWidth = Max(ItemWidth, MeasureTextWidth("Total = ", Values.TextFont))
		Values.Height = Values.TextHeight * 1.3 * (Items.Size + 2.3)
	End If
	ItemWidth = ItemWidth + 1.8 * Values.TextHeight
	Values.MidPoint = ItemWidth - 0.9 * Values.TextHeight
	Private ValueWidth As Int
	For Each pnt As PointDataL In Points
		txt = pnt.X
		ValueWidth = Max(ValueWidth, MeasureTextWidth(txt, Values.TextFont))
		For i = 0 To pnt.YArray.Length - 1
			txt = NumberFormat3(pnt.YArray(i), Values.MaxDigits)
			ValueWidth = Max(ValueWidth, MeasureTextWidth(txt, Values.TextFont))
		Next
	Next
	Values.Width = ItemWidth + ValueWidth + 0.05 * Values.TextHeight
	Values.rectCursor.Initialize(0, 0, 5dip, xpnlCursor.Height)
	Values.rectValues.Initialize(Values.MidPoint, 0, Values.Width, Values.Height) 'KC
	xpnlValues.Left = Values.Left
	xpnlValues.Top = Values.Top
	xpnlValues.Width = Values.Width
	xpnlValues.Height = Values.Height
	xcvsValues.Resize(Values.Width, Values.Height)
	
	r.Initialize(0, 0, Values.Width, Values.Height)
	xcvsValues.ClearRect(r)
	xcvsValues.DrawRect(r, Values.BackgroundColor, True, 0) 'KC
	
	Private h, i, x, y As Int
	h = Values.TextHeight * 1.3
	x = Values.MidPoint
	y = 1.2 * Values.TextHeight
	If Graph.XAxisName = "" Then
		xcvsValues.DrawText(txtX, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
	Else
		xcvsValues.DrawText(txtX, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
		xcvsValues.DrawText(txtX, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
	End If
	i = 1
	Private top As Int
	For Each Item As ItemDataL In Items
		top = y + h * i
		Private txt As String = Item.Name & " = "
		xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Item.Color, "RIGHT")
		i = i + 1
	Next
	
	If Graph.ChartType.Contains("STACKED") Then
		Private top As Int = y + h * i
		Private txt As String = "Total = "
		xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Values.TextColor, "RIGHT")
	End If
	
	xpnlValues.BringToFront
	xcvsValues.Invalidate
End Sub

'draws item values in a specific area, not for pie charts
Private Sub DrawItemValues(x As Int, y As Int)
	If Graph.ChartType <> "PIE" Then
		Private Index As Int
		xcvsValues.ClearRect(Values.rectValues)
		xcvsCursor.ClearRect(Values.rectCursor)
		Private rectValues1 As B4XRect
		rectValues1.Initialize(Values.rectValues.Left - 1, Values.rectValues.Top, Values.rectValues.Right, Values.rectValues.Bottom)
		xcvsValues.DrawRect(rectValues1, Values.BackgroundColor, True, 0) 'KC
		Select Graph.ChartType
			Case "BAR", "STACKED_BAR"
				Index =(x - Graph.Left - Graph.XOffset) / Graph.XInterval
			Case "LINE"
				Index = (x - Graph.Left) / Scale(sX).Scale + 0.5
		End Select
		Index = Max(Index, 0)
		Index = Min(Index, Points.Size - 1)
		Private PD As PointDataL
		PD = Points.Get(Index)
		Private h, i, x, y As Int
		h = Values.TextHeight * 1.3
		x = Values.MidPoint
		y = 1.2 * Values.TextHeight
		
		If Values.Show = False Then
			xpnlValues.Visible = False
		Else
			Private Total = 0 As Double
			Private top As Int
			Private txt As String
#If B4i	'it seems that B4i skips the empty character at the end
			xcvsValues.DrawText("  " & PD.X, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
			For i = 0 To PD.YArray.Length - 1
				top = y + h * (i + 1)
				txt = "  " & NumberFormat3(PD.YArray(i), Values.MaxDigits)
				xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
				Total = Total + PD.YArray(i)
			Next
			If Graph.ChartType.Contains("STACKED") Then
				top = y + h * (i + 1)
				xcvsValues.DrawText("  " & NumberFormat3(Total, Values.MaxDigits), x, top + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
			End If
#Else
			xcvsValues.DrawText(PD.X, x, y + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
			Private nb As Int
			nb = PD.YArray.Length - 1

				For i = 0 To nb
					top = y + h * (i + 1)
						txt = NumberFormat3(PD.YArray(i), Values.MaxDigits)
					xcvsValues.DrawText(txt, x, top + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
					Total = Total + PD.YArray(i)
				Next
			If Graph.ChartType.Contains("STACKED") Then
				top = y + h * (i + 1)
				xcvsValues.DrawText(NumberFormat3(Total, Values.MaxDigits), x, top + 0.2 * h, Values.TextFont, Values.TextColor, "LEFT")
			End If
#End If
		End If

		Private xCursor As Int
		Select Graph.ChartType
			Case "BAR", "STACKED_BAR"
				xCursor = (Index + 0.5) * Graph.XInterval + Graph.Left + Graph.XOffset
			Case "LINE"
				xCursor = Index * Scale(sX).Scale + Graph.Left
		End Select
		xcvsCursor.DrawLine(xCursor, Graph.Top, xCursor, Graph.Bottom, xui.Color_Red, 2dip)
		Values.rectCursor.Initialize(xCursor - 2dip, 0, xCursor + 2dip, xpnlCursor.Height)
		xcvsValues.Invalidate
		xcvsCursor.Invalidate
	End If
End Sub

Private Sub GetCursorIndex(X As Float) As Int
	Private Index As Int

	If Graph.ChartType <> "PIE" Then
		Select Graph.ChartType
			Case "BAR", "STACKED_BAR"
				Index =(x - Graph.Left - Graph.XOffset) / Graph.XInterval
			Case "LINE"
				Index = (x - Graph.Left) / Scale(sX).Scale + 0.5
		End Select
		Index = Max(Index, 0)
		Index = Min(Index, Points.Size - 1)
	End If
	
	Return Index
End Sub

'adds a bar
'only for Bar and StackedBar charts !
Public Sub AddBar(Name As String, BarColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	
	Private ID As ItemDataL
	ID.Initialize
	ID.Name = Name
	ID.Color = BarColor
	Items.Add(ID)
End Sub

'adds multibar points data
'only for Bar and StackedBar charts !
Public Sub AddBarMultiplePoint (X As String, YArray() As Double)
	If Points.IsInitialized = False Then
		Points.Initialize
	End If
	Dim PD As PointDataL
	PD.Initialize
	PD.X = X
	PD.YArray = YArray
	PD.ShowTick = True
	Points.Add(PD)
End Sub

'adds single bar point data
'only for Bar charts !
Public Sub AddBarPointData (X As String, Y As Double)
	If Points.IsInitialized = False Then
		Points.Initialize
	End If
	Dim PD As PointDataL
	PD.Initialize
	PD.X = X
	Private YArray(1) As Double
	YArray(0) = Y
	PD.YArray = YArray
	PD.ShowTick = True
	Points.Add(PD)
End Sub

'adds a line
'only for Line charts !
Public Sub AddLine(Name As String, LineColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemDataL
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = 2dip
	ID.PointType = "NONE"
	ID.PointFilled = False
	Items.Add(ID)
End Sub

'adds a line
'StrokeWidth = line thickness
'PointType, possible values: "NONE", "CIRCLE", "SQUARE", "TRIANGLE", "RHOMBUS", "CROSS+", "CROSSX"
'only for Line charts !
Public Sub AddLine2(Name As String, LineColor As Int, StrokeWidth As Int, PointType As String, PointFilled As Boolean, PointColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	
	Dim ID As ItemDataL
	ID.Initialize
	ID.Name = Name
	ID.Color = LineColor
	ID.StrokeWidth = StrokeWidth
	ID.PointType = PointType
	ID.PointFilled = PointFilled
	ID.PointColor = PointColor
	Items.Add(ID)
End Sub

'adds multiline points data
'ShowTick = True displays the x value in the X axis
'only for Line charts !
Public Sub AddLineMultiplePoints(X As String, YArray() As Double, ShowTick As Boolean)
	If Points.IsInitialized = False Then Points.Initialize
	Private PD As PointDataL
	PD.Initialize
	PD.X = X
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
	If xpnlValues.Visible = True Then
		xpnlValues.Visible = False
		xcvsCursor.ClearRect(Values.rectCursor)
		xcvsCursor.Invalidate
	End If
End Sub

'adds single line point data
'ShowTick = True displays the x value in the X axis
'only for Line charts !
Public Sub AddLinePointData (X As String, Y As Double, ShowTick As Boolean)
	If Points.IsInitialized = False Then Points.Initialize
	Dim PD As PointDataL
	PD.Initialize
	PD.X = X
	Private YArray(1) As Double
	YArray(0) = Y
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
	xpnlValues.Visible = False
	xcvsCursor.ClearRect(Values.rectCursor)
	xcvsCursor.Invalidate
End Sub

'Adds a pie slice item
'Color: 0 = random color
'only for Pie charts !
Public Sub AddPie(Name As String, Value As Float, Color As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	If Color = 0 Then Color = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))
	Dim ID As ItemDataL
	ID.Initialize
	ID.Name = Name
	ID.Value = Value
	ID.Color = Color
	Items.Add(ID)
End Sub

Private Sub InitChart
	InitTextSizes
	
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsCursor.ClearRect(xcvsCursor.TargetRect)
	
	Select Graph.ChartType
		Case "PIE"
			Graph.Height = xpnlGraph.Height
			Graph.Top = Legend.TextHeight
			Graph.Right = xpnlGraph.Width - Legend.TextHeight
			If Legend.IncludeLegend = "BOTTOM" And Items.Size > 0 Then
				GetLegendLineNumbers(xpnlGraph.Width - 1.2 * Legend.TextHeight)
				Legend.Height = (Legend.LineNumber + 0.8) * 1 * Legend.TextHeight
				Graph.Height = Graph.Height - Legend.Height - 0.75 * Legend.TextHeight
			End If
			Return
	End Select
	
	If Graph.ChartType = "LINE" And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
		If Scale(sY(0)).Automatic = True Then
			For i = 0 To Items.Size - 1
				CalcScaleAuto(sY(i))
			Next
		Else
			For i = 0 To Items.Size -1
				CalcScaleManu(sY(i))
			Next
		End If
	Else
		If Scale(sY(0)).Automatic = True Then
			CalcScaleAuto(sY(0))
		Else
			CalcScaleManu(sY(0))
		End If
	End If
	
	Private WidthXScale_2 As Int
	If Scale(sX).DrawXScale = True Then
		WidthXScale_2 = GetXScaleWidth / 2
	End If

	If Scale(sY(0)).DrawYScale = False Then
		Graph.Left = 0.75 * Texts.AxisTextHeight '+ WidthXScale_2
	Else
		If Graph.ChartType = "LINE" And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			Private Width As Int
			For i = 0 To NbMaxDifferentScales - 1 Step 2
				Width = Max(Width, GetYScaleWidth(i))
			Next
			Graph.Left = Width + 1.05 * Texts.ScaleTextHeight
		Else
			Graph.Left = GetYScaleWidth(0) + 1.05 * Texts.ScaleTextHeight '+ WidthXScale_2
		End If
	End If

	If Graph.YAxisName <> "" Then
		Graph.Left = Graph.Left + Texts.AxisTextHeight * 1.8
	End If
	
	If Scale(sY(0)).DrawYScale = False Then
		Graph.Right = xpnlGraph.Width - 0.75 * Texts.ScaleTextHeight - WidthXScale_2
	Else
		If Graph.ChartType = "LINE" And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
			Graph.Right = xpnlGraph.Width - 1.5 * Texts.ScaleTextHeight - GetYScaleWidth(1)
			For i = 1 To NbMaxDifferentScales - 1 Step 2
'				RightScaleWidth = Max(Width, GetYScaleWidth(i)) '???
			Next
'			Graph.Right = xpnlGraph.Width - RightScaleWidth - 1.5 * Texts.ScaleTextHeight - WidthXScale_2
		Else
			Graph.Right = xpnlGraph.Width - 1.5 * Texts.ScaleTextHeight - WidthXScale_2
		End If
	End If

	Graph.Width = Graph.Right - Graph.Left

	If Graph.ChartType = "LINE" And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
		For i = 0 To Items.Size - 1
			Scale(sY(i)).Scale = Graph.Height / (Scale(sY(i)).MaxVal - Scale(sY(i)).MinVal)
		Next
	Else
		Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
	End If
	Scale(sX).Scale = Graph.Width / (Scale(sX).MaxVal - Scale(sX).MinVal)

	If Graph.ChartType = "BAR" Or Graph.ChartType = "STACKED_BAR" Or Graph.ChartType = "CANDLE" Or Graph.ChartType = "WATERFALL" Then
		BarWidth0 = False
		Private PD As PointDataL = Points.Get(0)
		Private Margin = 0.02 * Graph.Width As Int
		Graph.XInterval = Floor((Graph.Width - Margin) / Points.Size) '???
		
		Private Space As Int
		If Graph.ChartType = "BAR" Or Graph.ChartType = "STACKED_BAR" Or Graph.ChartType = "CANDLE" Or Graph.ChartType = "WATERFALL" Then
			Select Items.Size
				Case 0, 1
					If Points.Size <= 40 Then
						Private SpaceRatio As Double
						If Points.Size = 1 Then
							SpaceRatio = 1
						Else If Points.Size = 2 Then
							SpaceRatio = 0.85
						Else If Points.Size = 3 Then
							SpaceRatio = 0.75
						Else If Points.Size = 4 Then
							SpaceRatio = 0.6
						Else If Points.Size = 5 Then
							SpaceRatio = 0.5
						Else If Points.Size > 5 And Points.Size <= 20 Then
							SpaceRatio = 0.4
						Else If Points.Size > 20 And Points.Size <= 30 Then
							SpaceRatio = 0.3
						Else
							SpaceRatio = 0.2
						End If
						Space = Max(1dip, Graph.XInterval - Graph.Width / ((1 + SpaceRatio) * Points.Size + 2 * SpaceRatio))
					Else
						If Points.Size < 50 And Graph.XInterval >= 6dip Then
							Space = 2dip
						Else
							Space = 1dip
						End If
					End If
				Case 2, 3
					If Points.Size <= 40 Then
						Private SpaceRatio As Double
						If Points.Size = 1 Then
							SpaceRatio = 0.5
						Else If Points.Size = 2 Then
							SpaceRatio = 0.42
						Else If Points.Size = 3 Then
							SpaceRatio = 0.375
						Else If Points.Size = 4 Then
							SpaceRatio = 0.3
						Else If Points.Size = 5 Then
							SpaceRatio = 0.25
						Else If Points.Size > 5 And Points.Size <= 20 Then
							SpaceRatio = 0.2
						Else If Points.Size > 20 And Points.Size <= 30 Then
							SpaceRatio = 0.15
						Else
							SpaceRatio = 0.1
						End If
						Space = Max(1dip, Graph.XInterval - Graph.Width / ((1 + SpaceRatio) * Points.Size + 2 * SpaceRatio))
					Else
						If Points.Size < 50 And Graph.XInterval >= 6dip Then
							Space = 2dip
						Else
							Space = 1dip
						End If
					End If
				Case Else
					If Points.Size <= 40 Then
						Private SpaceRatio As Double
						If Points.Size = 1 Then
							SpaceRatio = 0.3
						Else If Points.Size = 2 Then
							SpaceRatio = 0.25
						Else If Points.Size = 3 Then
							SpaceRatio = 0.22
						Else If Points.Size = 4 Then
							SpaceRatio = 0.18
						Else If Points.Size = 5 Then
							SpaceRatio = 0.25
						Else If Points.Size > 5 And Points.Size <= 20 Then
							SpaceRatio = 0.15
						Else If Points.Size > 20 And Points.Size <= 30 Then
							SpaceRatio = 0.1
						Else
							SpaceRatio = 0.1
						End If
						Space = Max(1dip, Graph.XInterval - Graph.Width / ((1 + SpaceRatio) * Points.Size + 2 * SpaceRatio))
					Else
						If Points.Size < 50 And Graph.XInterval >= 6dip Then
							Space = 2dip
						Else
							Space = 1dip
						End If
					End If
			End Select
		Else
			Space = Margin
		End If
	
		Private Limit As Int
		If Graph.ChartType = "BAR" Then
			Limit = 4dip * PD.YArray.Length
		Else
			Limit = 4dip
		End If
	
		If Graph.XInterval - Space < Limit Then
			Log("Bar width = too small !!! Drawing of Bar chart skipped")
			BarWidth0 = True
		End If
		
		Graph.XOffset = (Graph.Width - Graph.XInterval * Points.Size) / 2
		Graph.BarWidth = Graph.XInterval - Space
		Graph.BarSubWidth = Graph.BarWidth / PD.YArray.Length
		
		If Graph.ChartType = "BAR" Then
			'checks if Graph.BarSubWidth too small < 4dip
			If Graph.BarSubWidth < 4dip And BarWidth0 = False Then
				Log("Bar width = too small !!! Drawing of Bar chart skipped")
				BarWidth0 = True
			End If
		End If
	End If
	
	If Graph.Title <> "" Then
		Graph.Top = 1.8 * Texts.TitleTextHeight
	Else
		Graph.Top = 0.9 * Texts.TitleTextHeight
	End If
	
	If Graph.Subtitle <> "" Then
		Graph.Top = Graph.Top + 1.5 * Texts.SubtitleTextHeight
	End If
	
	If Scale(sX).DrawXScale = False Then
		Graph.Height = xpnlGraph.Height - Graph.Top - 0.5 * Texts.ScaleTextHeight
	Else
		Select Graph.XScaleTextOrientation
			Case "HORIZONTAL"
				Graph.Height = xpnlGraph.Height - Graph.Top - 2.1 * Texts.ScaleTextHeight
			Case "VERTICAL"
				Graph.Height = xpnlGraph.Height - Graph.Top - 0.9 * Texts.ScaleTextHeight - GetXScaleWidth
			Case "45 DEGREES"
				Graph.Height = xpnlGraph.Height - Graph.Top - 0.9 * Texts.ScaleTextHeight - GetXScaleWidth * 0.8
		End Select
	End If
	If Graph.XAxisName <> "" Then
		Graph.Height = Graph.Height - 1.3 * Texts.AxisTextHeight
	End If
	
	If Legend.IncludeLegend = "BOTTOM" And Items.Size > 0 And Graph.ChartType <> "CANDLE" Then
		GetLegendLineNumbers(xpnlGraph.Width - 1.2 * Legend.TextHeight)
		Legend.Height = (Legend.LineNumber + 0.8) * Legend.TextHeight
		Graph.Height = Graph.Height - Legend.Height - 0.75 * Legend.TextHeight
	End If

	Graph.YInterval = Graph.Height / Scale(sY(0)).NbIntervals
	Graph.Height =  Graph.YInterval * Scale(sY(0)).NbIntervals
	Graph.Bottom = Graph.Top + Graph.Height
	Graph.Rect.Initialize(Graph.Left, Graph.Top, Graph.Right, Graph.Bottom)
	
	If Graph.ChartType = "AREA" Or Graph.ChartType = "STACKED_AREA" Then
		Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
	End If
	
	'used to avoid drawing lines outsides the grid
	pthGrid.Initialize(Graph.Left - 1dip, Graph.Top - 1dip)
	pthGrid.LineTo(Graph.Right + 1dip, Graph.Top - 1dip)
	pthGrid.LineTo(Graph.Right + 1dip, Graph.Bottom + 1dip)
	pthGrid.LineTo(Graph.Left - 1dip, Graph.Bottom + 1dip)
	pthGrid.LineTo(Graph.Left - 1dip, Graph.Top - 1dip)
	
	InitValues
End Sub

'Initializes text sizes.
Private Sub InitTextSizes
	If Texts.AutomaticTextSizes = True Then
		Private GraphSize As Int
		GraphSize = Min(xpnlGraph.Width, xpnlGraph.Height) / xui.Scale
		Texts.TitleTextSize = (1 + (GraphSize - 250)/1000) * 18
		Texts.SubtitleTextSize = (1 + (GraphSize - 250)/1000) * 16
		Texts.AxisTextSize = (1 + (GraphSize - 250)/1000) * 14
		Legend.TextSize = (1 + (GraphSize - 250)/1000) * 14
		Texts.ScaleTextSize = (1 + (GraphSize - 250)/1000) * 12
		Values.TextSize = (1 + (GraphSize - 250)/1000) * 14
	End If
	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.AxisFont = xui.CreateDefaultFont(Texts.AxisTextSize)
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	Legend.TextFont = xui.CreateDefaultFont(Legend.TextSize)
	Values.TextFont = xui.CreateDefaultFont(Values.TextSize)
	
	Texts.TitleTextHeight = MeasureTextHeight("Mg", Texts.TitleFont)
	Texts.SubtitleTextHeight = MeasureTextHeight("Mg", Texts.SubtitleFont)
	Texts.AxisTextHeight =  MeasureTextHeight("Mg", Texts.AxisFont)
	Texts.ScaleTextHeight =  MeasureTextHeight("Mg", Texts.ScaleFont)
	Legend.TextHeight =  MeasureTextHeight("Mg", Legend.TextFont)
	Values.TextHeight = MeasureTextHeight("Mg", Values.TextFont)
End Sub

'Calculates manual scales.
Private Sub CalcScaleManu(Index As Int)
	Private ValMinMax(3) As Double

	Select Graph.ChartType
		Case "LINE"
			ValMinMax = GetLinePointsMinMaxMeanValues(sY(0))
			If Scale(sY(0)).YZeroAxis = True And ValMinMax(0) >= 0 And ValMinMax(1) > 0 Then
				ValMinMax(0) = 0
			End If
			If Scale(sY(0)).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) <= 0 Then
				ValMinMax(1) = 0
			End If
		Case Else
			ValMinMax = GetBarPointsMinMaxValues
	End Select
		
	Scale(Index).MaxVal = Scale(Index).MaxManu
	Scale(Index).MinVal = Scale(Index).MinManu
	Scale(Index).IntervalManu = (Scale(Index).MaxVal - Scale(Index).MinVal) / Scale(Index).NbIntervals
	Scale(Index).Interval = Scale(Index).IntervalManu
	Scale(Index).Exp = Floor(Logarithm((Scale(Index).MaxVal - Scale(Index).MinVal) / Scale(Index).NbIntervals, 10))
	If Index = sY(0) Then
		Scale(Index).Scale = Graph.Height / (Scale(Index).MaxVal - Scale(Index).MinVal)
	Else
		Scale(Index).Scale = Graph.Width / (Scale(Index).MaxVal - Scale(Index).MinVal)
	End If
End Sub

'Calculates automatic scales, with 1, 2, 2.5, 5 as default scales.
'The number of standardized values can be defined with ScaleValues.
Private Sub CalcScaleAuto(Axis As Int)
	Private ScaleLogarithm, ScaleMant, ScaleDelta, ValDiff, ScaleMin, ScaleMax, ValMax As Double
	Private nbMin, NbUsedIntervals, NbUsedIntervalsTop, NbUsedIntervalsBottom, NbIntervalsToMove As Int
	Private ValMinMax(3) As Double
	
	Select Graph.ChartType
		Case "LINE"
			ValMinMax = GetLinePointsMinMaxMeanValues(Axis)
			If Scale(Axis).YZeroAxis = True And ValMinMax(0) >= 0 And ValMinMax(1) > 0 Then
				ValMinMax(0) = 0
			End If
			If Scale(Axis).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) <= 0 Then
				ValMinMax(1) = 0
			End If
		Case Else
			ValMinMax = GetBarPointsMinMaxValues
	End Select
	
	'check if min = max then unit scale
	If ValMinMax(0) = ValMinMax(1) Then
		If ValMinMax(0) >= 0 And ValMinMax(0) <= 1 Then
			Scale(Axis).MinAuto = 0
			Scale(Axis).MaxAuto = 1
			Scale(Axis).IntervalAuto = 1 / Scale(Axis).NbIntervals
			Scale(Axis).MinVal = Scale(Axis).MinAuto
			Scale(Axis).MaxVal = Scale(Axis).MaxAuto
			Scale(Axis).Interval = Scale(Axis).IntervalAuto
			Return
		Else If ValMinMax(0) < 0 And ValMinMax(0) >= -1 Then
			Scale(Axis).MinAuto = -1
			Scale(Axis).MaxAuto = 0
			Scale(Axis).IntervalAuto = 1 / Scale(Axis).NbIntervals
			Scale(Axis).MinVal = Scale(Axis).MinAuto
			Scale(Axis).MaxVal = Scale(Axis).MaxAuto
			Scale(Axis).Interval = Scale(Axis).IntervalAuto
			Return
		Else
			If Scale(Axis).YZeroAxis = False Then
				If Abs(ValMinMax(0)) < 100 Then
					Scale(Axis).IntervalAuto = 0.1
				Else
					Scale(Axis).IntervalAuto = 1
				End If
				Scale(Axis).MinAuto = Floor(ValMinMax(0)) - Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals / 2
				Scale(Axis).MaxAuto = Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
				Scale(Axis).MinVal = Scale(Axis).MinAuto
				Scale(Axis).MaxVal = Scale(Axis).MaxAuto
				Scale(Axis).Interval = Scale(Axis).IntervalAuto
				If Axis = sX Then
					Scale(Axis).Scale = Graph.Width / (Scale(Axis).MaxVal - Scale(Axis).MinVal)
				Else
					Scale(Axis).Scale = Graph.Height / (Scale(Axis).MaxVal - Scale(Axis).MinVal)
				End If
				Return
			Else
				If ValMinMax(0) > 0 Then
					ValMinMax(0) = 0
				Else
					ValMinMax(1) = 0
				End If
			End If
		End If
		Scale(Axis).MinVal = Scale(Axis).MinAuto
		Scale(Axis).MaxVal = Scale(Axis).MaxAuto
		Scale(Axis).Interval = Scale(Axis).IntervalAuto
		Return
	End If
	
	Private ScaleOK As Boolean = False
	ValMax = ValMinMax(1)
	Do Until ScaleOK = True
		ValDiff = ValMax - ValMinMax(0)
		ScaleDelta = ValDiff / Scale(Axis).NbIntervals
	
		ScaleLogarithm = Logarithm(ScaleDelta, 10)
		Scale(Axis).Exp = Floor(ScaleLogarithm)
		If ValDiff >= 1 Then
			ScaleMant = ScaleLogarithm - Scale(Axis).Exp
		Else
			ScaleMant = Abs(Scale(Axis).Exp) + ScaleLogarithm
		End If
		
		ScaleMant = GetScaleMant(ScaleMant, Axis)
		Scale(Axis).IntervalAuto = Power(10, Scale(Axis).Exp + ScaleMant)
		
		If Scale(Axis).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) = 0 Then
			ScaleMax = 0
			ScaleMin = -Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		Else
			ScaleMin = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
			ScaleMax = ScaleMin + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		End If
		
		' check if the top scale is below the max value
		If Round2(ScaleMax, 14) < Round2(ValMinMax(1), 14) Then
			ValMax = ValMax + Scale(Axis).IntervalAuto
		Else
			ScaleOK = True
		End If
	Loop
	
	' check if the scale interval is OK
	If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
		NbUsedIntervalsTop = Ceil(ValMinMax(1) / Scale(Axis).IntervalAuto - 0.00000000000001)
		NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / Scale(Axis).IntervalAuto - 0.00000000000001)
		' check if there are more necessary intervals than available
		If NbUsedIntervalsTop + NbUsedIntervalsBottom > Scale(Axis).NbIntervals Then
			' if yes increase the scale interval
			ScaleMant = GetScaleMant(ScaleMant, Axis)
		
			Scale(Axis).IntervalAuto = Power(10, Scale(Axis).Exp + ScaleMant)
		End If
	End If
	
	' calculate the scale min value
	If Scale(Axis).YZeroAxis = True And ValMinMax(1) = 0 Then
		Scale(Axis).MinAuto = ScaleMin
		Scale(Axis).MaxAuto = 0
	Else
		nbMin = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto)
		If Abs(ValMinMax(0)) <= 0.000000000001 Then
			Scale(Axis).MinAuto = 0
		Else If ValMinMax(0) >= 0 Then
			Scale(Axis).MinAuto = nbMin * Scale(Axis).IntervalAuto
		Else If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
			Scale(Axis).MinAuto = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
		Else
			Scale(Axis).MinAuto = Floor(ValMinMax(0) / Scale(Axis).IntervalAuto + 0.00000000000001) * Scale(Axis).IntervalAuto
		End If
	End If
	Scale(Axis).MaxAuto = Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
	
	' distribution of empty intervals
	If (Scale(Axis).MinAuto >= 0 And Scale(Axis).YZeroAxis = False) Or (Scale(Axis).MaxAuto <= 0 And Scale(Axis).YZeroAxis = False) Or (Scale(Axis).MinAuto < 0 And Scale(Axis).MaxAuto > 0) Then
		If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
			NbUsedIntervalsTop = Ceil(ValMinMax(1) / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbUsedIntervals = NbUsedIntervalsTop + NbUsedIntervalsBottom
			If NbUsedIntervalsTop - NbUsedIntervalsBottom = 1 Then
				NbIntervalsToMove = Scale(Axis).NbIntervals / 2 - NbUsedIntervalsBottom
			Else
				NbIntervalsToMove = (Scale(Axis).NbIntervals - NbUsedIntervals) / 2
			End If
		Else
			NbUsedIntervals = Ceil(ValDiff / Scale(Axis).IntervalAuto - 0.00000000000001)
			NbIntervalsToMove = (Scale(Axis).NbIntervals - NbUsedIntervals) / 2
		End If
		Scale(Axis).MinAuto = Scale(Axis).MinAuto - Scale(Axis).IntervalAuto * NbIntervalsToMove
	End If
	
	If Graph.ChartType = "BAR" Or Graph.ChartType = "H_BAR" Then
		'if all values are > 0 and the min scale is < 0 then min scale is set to 0
		If 	ValMinMax(0) = 0 And ValMinMax(1) > 0 And Scale(Axis).MinAuto < 0 Then
			Scale(Axis).MinAuto = 0
		End If
		
		'if all values are < 0 and the max scale is > 0 then max scale is set to 0
		If 	ValMinMax(0) < 0 And ValMinMax(1) = 0 And Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals > 0 Then
			Scale(Axis).MaxAuto = 0
			Scale(Axis).MinAuto = - Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
		End If
	End If
	
	' calculate the scale max value
	Scale(Axis).MaxAuto = Scale(Axis).MinAuto + Scale(Axis).IntervalAuto * Scale(Axis).NbIntervals
	
	Scale(Axis).MinVal = Scale(Axis).MinAuto
	Scale(Axis).MaxVal = Scale(Axis).MaxAuto
	Scale(Axis).Interval = Scale(Axis).IntervalAuto
End Sub

'Calculates the Logs and Value for linear scales according to the ScaleLog(Axis).ScaleValues string.
Private Sub ScaleLogVals(Axis As Int)
	Private Scales() As String
	Scales = Regex.Split("!", Scale(Axis).ScaleValues)
	Private Vals(Scales.Length), Logs(Scales.Length) As Double
	For i = 0 To Scales.Length - 1
		Vals(i) = Scales(i)
		Logs(i) = Logarithm(Vals(i), 10)
	Next
	ScaleLog(Axis).Logs = Logs	'???
	ScaleLog(Axis).Vals = Vals	'???
End Sub

Private Sub GetScaleMant(ScaleMant0 As Double, Axis As Int) As Double
	Private ScaleMant1 As Double
	
	ScaleLogVals(Axis)
	
	If Round2(ScaleMant0, 14) <= Round2(ScaleLog(Axis).Logs(0), 14) Then
		ScaleMant1 = 0
	Else
		For i = 0 To ScaleLog(Axis).Logs.Length - 2
			If Round2(ScaleMant0, 14) > Round2(ScaleLog(Axis).Logs(i), 14) And Round2(ScaleMant0, 14) <= Round2(ScaleLog(Axis).Logs(i + 1), 14) Then
				ScaleMant1 = Logarithm(ScaleLog(Axis).Vals(i + 1), 10)
				Exit
			End If
		Next
	End If
	
	Return ScaleMant1
End Sub

'gets min and max values of the given points for bars
Private Sub GetBarPointsMinMaxValues As Double()
	Private j, j As Int
	Private MinMax(2) As Double
	
	If Points.Size > 0 Then
	
		If Graph.ChartType = "BAR" Or Graph.ChartType = "H_BAR" Or Graph.ChartType = "RADAR" Or Graph.ChartType = "CANDLE" Then
			' BAR chart
			MinMax(1) = -1E10
			MinMax(0) = 1E10
	
			For i = 0 To Points.Size - 1
				Private YVals() As Double
				Private PD As PointDataL
				PD = Points.Get(i)
				YVals = PD.YArray
				For j = 0 To PD.YArray.Length - 1
					MinMax(1) = Max(MinMax(1), YVals(j))
					MinMax(0) = Min(MinMax(0), YVals(j))
				Next
			Next
			MinMaxMeanValues(0) = MinMax(0)
			MinMaxMeanValues(1) = MinMax(1)
			If Graph.ChartType <> "CANDLE" Then
				If MinMax(0) > 0 And MinMax(1) > 0 Then
					MinMax(0) = 0
				End If
				If MinMax(0) < 0 And MinMax(1) < 0 Then
					MinMax(1) = 0
				End If
			End If
		Else
			' STACKED BAR chart
			MinMax(1) = 0
			MinMax(0) = 0
	
			For i = 0 To Points.Size - 1
				Private YVals(), Total As Double
				Private PD As PointDataL
				PD = Points.Get(i)
				YVals = PD.YArray
				For j = 0 To PD.YArray.Length - 1
					Total = Total + YVals(j)
				Next
				MinMax(1) = Max(MinMax(1), Total)
			Next
			MinMaxMeanValues(0) = MinMax(0)
			MinMaxMeanValues(1) = MinMax(1)
		End If
	End If
	
	Return MinMax
End Sub

'Gets min, max and mean values of the given points for lines.
Private Sub GetLinePointsMinMaxMeanValues(Axis As Int) As Double()
	Private i, j, NbPoints, iP0, iP1 As Int
	Private MMMValues(3) As Double
	MMMValues(1) = -1E10
	MMMValues(0) = 1E10
	MMMValues(2) = 0
	
	Select Graph.ChartType
		Case "LINE"
			iP0 = 0
			iP1 = Points.Size - 1
			If Scale(Axis).Different = False Then 'mono scale
				NbPoints = 0
				For i = iP0 To iP1
					Private YVals() As Double
					Private PD As PointDataL
					PD = Points.Get(i)
					If Axis = sX Then
						YVals = PD.XArray
					Else
						YVals = PD.YArray
					End If
					For j = 0 To PD.YArray.Length - 1
						MMMValues(1) = Max(MMMValues(1), YVals(j))
						MMMValues(0) = Min(MMMValues(0), YVals(j))
						MMMValues(2) = MMMValues(2) + YVals(j)
						NbPoints = NbPoints + 1
					Next
				Next
			Else	'multi scale
				NbPoints = 0
				For i = iP0 To iP1
					Private YVals() As Double
					Private PD As PointDataL
					PD = Points.Get(i)
					YVals = PD.YArray
					For j = 0 To PD.YArray.Length - 1
'						If YVals(Axis - 1) <> mMissingDataValue Then
						MMMValues(1) = Max(MMMValues(1), YVals(Axis - 1))
						MMMValues(0) = Min(MMMValues(0), YVals(Axis - 1))
						MMMValues(2) = MMMValues(2) + YVals(Axis - 1)
						NbPoints = NbPoints + 1
'						End If
					Next
				Next
			End If
			MMMValues(2) = MMMValues(2) / NbPoints
	End Select

	MinMaxMeanValues(0) = MMMValues(0)
	MinMaxMeanValues(1) = MMMValues(1)
	MinMaxMeanValues(2) = MMMValues(2)

	Return MMMValues
End Sub

'gets the max width of the x scale values in pixels
Private Sub GetXScaleWidth As Int
	Private Width As Int

	For i = 0 To Points.Size - 1
		Private PD As PointDataL
		PD = Points.Get(i)
		If Graph.ChartType = "LINE" And PD.ShowTick = True Then
			Width = Max(Width, MeasureTextWidth(PD.X, Texts.ScaleFont))
		Else
			Width = Max(Width, MeasureTextWidth(PD.X, Texts.ScaleFont))
		End If
	Next
	Return Width
End Sub

'gets the max width of the y scale values in pixels
Private Sub GetYScaleWidth(Index As Int) As Int
	Private Width As Int
	
	If Scale(sY(0)).Automatic = True Then
		Width = MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal, 6), Texts.ScaleFont)
		For i = 1 To Scale(sY(Index)).NbIntervals
			Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal + i * Scale(sY(Index)).IntervalAuto, 6), Texts.ScaleFont))
		Next
	Else
		Width = MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal, 6), Texts.ScaleFont)
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).Interval, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MaxVal - Scale(sY(Index)).Interval, 6), Texts.ScaleFont))
		Width = Max(Width, MeasureTextWidth(NumberFormat3(Scale(sY(Index)).MinVal + Scale(sY(Index)).Interval, 6), Texts.ScaleFont))
	End If
	Return Width
End Sub

'draws a chart
Public Sub DrawChart
	InitChart
	Select Graph.ChartType
		Case "LINE"
			GetXIntervals
			DrawGrid
			If Items.Size > 1 And Items.Size <= NbMaxDifferentScales  And Scale(sY(0)).Different = True Then
				DrawLinesNScales
			Else
				DrawLines
			End If
		Case "BAR", "STACKED_BAR"
			DrawGrid
			DrawBars
		Case "PIE"
			DrawPies
	End Select
End Sub

'Draws the grid of a chart with the scales, titles and axis names, not for PIE charts for vertical charts.
Private Sub DrawGrid
	Private x1, y As Int
	
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)

	If Graph.ChartType = "LINE"  And Items.Size <= NbMaxDifferentScales And Scale(sY(0)).Different = True Then
		For i = 0 To Items.Size - 1
			Scale(sY(i)).Scale = Graph.Height / (Scale(sY(i)).MaxVal - Scale(sY(i)).MinVal)
		Next
		DrawScalesY
	Else
		Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
		DrawScaleY
	End If
	
	If Scale(sX).DrawXScale = True Then
		DrawScaleX
	End If

	y = 0.45 * Texts.TitleTextHeight
	If Graph.Title <> "" Then
		y = y + 0.9 * Texts.TitleTextHeight
		xcvsGraph.DrawText(Graph.Title, Graph.Left + Graph.Width / 2, y, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	End If
	
	If Graph.Subtitle <> "" Then
		y = y + 1.5 * Texts.SubtitleTextHeight
		xcvsGraph.DrawText(Graph.Subtitle, Graph.Left + Graph.Width / 2, y, Texts.SubtitleFont, Texts.SubtitleTextColor, "CENTER")
	End If
	
	y = xpnlGraph.Height - 0.38 * Texts.AxisTextHeight
	If Legend.IncludeLegend = "BOTTOM" And Graph.ChartType <> "CANDLE" And Graph.ChartType <> "WATERFALL" Then
		y = y - Legend.Height - 0.75 * Legend.TextHeight
	End If
	
	If Graph.XAxisName <> "" Then
		xcvsGraph.DrawText(Graph.XAxisName, Graph.Left + Graph.Width / 2, y, Texts.AxisFont, Texts.AxisTextColor, "CENTER")
	End If
	
	x1 = 1.5 * Texts.AxisTextHeight
	If Graph.YAxisName <> "" Then
		xcvsGraph.DrawTextRotated(Graph.YAxisName, x1, Graph.Top + Graph.Height / 2, Texts.AxisFont, Texts.AxisTextColor, "CENTER", -90)
	End If
	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	xcvsGraph.DrawLine(Graph.Left, Graph.Bottom, Graph.Right, Graph.Bottom, Graph.GridFrameColor, 2dip)
	xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
	
	Private rctOuter As B4XRect
	rctOuter.Initialize(0, 0, xpnlCursor.Width, xpnlCursor.Height)
	xcvsGraph.DrawRect(rctOuter, Graph.GridFrameColor, False, 4dip)
End Sub

'draws the Y scale
Private Sub DrawScaleY
	Private i, y, y1 As Int
	Private txt As String
	
	y1 = Graph.Bottom
	For i = 0 To Scale(sY(0)).NbIntervals
		y = Graph.Bottom - i * Graph.YInterval
		
		xcvsGraph.DrawLine(Graph.Left, y, Graph.Right, y, Graph.GridColor, 1dip)
		
		If Scale(sY(0)).DrawYScale = True Then
			xcvsGraph.DrawLine(Graph.Left - 4dip, y, Graph.Left, y, Graph.GridFrameColor, 2dip)
			If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 And Scale(sY(0)).Automatic = True Then
				txt = ""
			Else
				txt = NumberFormat3(Scale(sY(0)).MinVal + i * Scale(sY(0)).Interval, 6)
			End If
		
			If i = 0 Or MeasureTextHeight(txt, Texts.ScaleFont) * 1.8 < y1 - y Then
#If B4A
				xcvsGraph.DrawText(txt, Graph.Left - 0.75 * Texts.ScaleTextHeight, y + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else If B4J
				xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, y + 0.38 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#Else
				xcvsGraph.DrawText(txt, Graph.Left - 0.6 * Texts.ScaleTextHeight, y + 0.52 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
#End If				
				y1 = y
			End If
		End If
	Next
	If Scale(sY(0)).DrawYScale = True Then
		xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
	End If
End Sub

'Draws the Y scales.
Private Sub DrawScalesY
	Private i, l, x(NbMaxDifferentScales), dy(NbMaxDifferentScales), y, y1 As Int
	Private txt As String
	Private ID As ItemDataL
	Private Alignment(4) As String
	Alignment(0) = "RIGHT"
	Alignment(1) = "LEFT"
	Alignment(2) = "RIGHT"
	Alignment(3) = "LEFT"
#If B4A
	x(0) = Graph.Left - 0.75 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.75 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.75 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.75 * Texts.ScaleTextHeight
	dy(0) = 0.52 * Texts.ScaleTextHeight
	dy(1) = 0.52 * Texts.ScaleTextHeight
	dy(2) = -0.48 * Texts.ScaleTextHeight
	dy(3) = -0.48 * Texts.ScaleTextHeight
#Else If B4J
	x(0) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	dy(0) = 0.38 * Texts.ScaleTextHeight
	dy(1) = 0.38 * Texts.ScaleTextHeight
	dy(2) = -0.62 * Texts.ScaleTextHeight
	dy(3) = -0.62 * Texts.ScaleTextHeight
#Else
	x(0) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(1) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	x(2) = Graph.Left - 0.6 * Texts.ScaleTextHeight
	x(3) = Graph.Right + 0.6 * Texts.ScaleTextHeight
	dy(0) = 0.52 * Texts.ScaleTextHeight
	dy(1) = 0.52 * Texts.ScaleTextHeight
	dy(2) = -0.48 * Texts.ScaleTextHeight
	dy(3) = -0.48 * Texts.ScaleTextHeight
#End If	
	y1 = Graph.Bottom
	For l = 0 To Items.Size - 1
		ID = Items.Get(l)
		For i = 0 To Scale(sY(0)).NbIntervals
			y = Graph.Bottom - i * Graph.YInterval
			xcvsGraph.DrawLine(Graph.Left, y, Graph.Right, y, Graph.GridColor, 1dip)

			If Scale(sY(0)).DrawYScale = True Then
				xcvsGraph.DrawLine(Graph.Left - 4dip, y, Graph.Left, y, Graph.GridFrameColor, 2dip)
				If Scale(sY(0)).Different = True Then
					xcvsGraph.DrawLine(Graph.Right, y, Graph.Right + 4dip, y, Graph.GridFrameColor, 2dip)
				End If
				If Scale(sY(l)).MinVal = 0 And Scale(sY(l)).MaxVal = 0 And Scale(sY(l)).Automatic = True Then
					txt = ""
				Else
					txt = NumberFormat3(Scale(sY(l)).MinVal + i * Scale(sY(l)).Interval, 6)
				End If
				
				If i = 0 Or MeasureTextHeight(txt, Texts.ScaleFont) * 1.8 < y1 - y Then
					'skip scale values
					xcvsGraph.DrawText(txt, x(l), y + dy(l), Texts.ScaleFont, ID.Color, Alignment(l))
					y1 = y
				End If
			End If
		Next
	Next
	xcvsGraph.DrawLine(Graph.Left, Graph.Top, Graph.Left, Graph.Bottom, Graph.GridFrameColor, 2dip)
End Sub

'Draws the X scale.
Private Sub DrawScaleX
	Private i, ip, x, x1, l1 As Int
	Private h1, h2, h3, h4, h5 As Double
	
#If B4i	
	h1 = 1.52
	h2 = 0.5
	h3 = 0.6
	h4 = 0.75
	h5 = 1.35
#Else
	h1 = 1.65
	h2 = 0.38
	h3 = 0.45
	h4 = 0.6
	h5 = 1.2
#End If
	l1 = 4dip

	For i = 0 To Points.Size - 1
		Private PD As PointDataL
			
		ip = i
		PD = Points.Get(i)
		If Graph.ChartType = "LINE" Or Graph.ChartType = "AREA" Or Graph.ChartType = "STACKED_AREA" Then
			x = Graph.Left + ip * Scale(sX).Scale
		Else
			x = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval
		End If
		If PD.ShowTick = True Then
			xcvsGraph.DrawLine(x, Graph.Top, x, Graph.Bottom, Graph.GridColor, 1dip)
			Select Graph.XScaleTextOrientation
				Case "HORIZONTAL"
					If (x - x1) > 1.3 * MeasureTextWidth(PD.X, Texts.ScaleFont) Or ip = 0 Then
						xcvsGraph.DrawText(PD.X, x, Graph.Bottom + h1 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "CENTER")
						x1 = x
					End If
				Case "VERTICAL"
					If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
						xcvsGraph.DrawTextRotated(PD.X, x + h2 * Texts.ScaleTextHeight, Graph.Bottom + h4 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -90)
						x1 = x
					End If
				Case "45 DEGREES"
					If (x - x1) > 1.8 * Texts.ScaleTextHeight Then
						xcvsGraph.DrawTextRotated(PD.X, x + h3 * Texts.ScaleTextHeight, Graph.Bottom + h5 * Texts.ScaleTextHeight, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT", -45)
						x1 = x
					End If
			End Select
			xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + l1, Graph.GridFrameColor, 2dip)
		End If
	Next
	xcvsGraph.DrawLine(Graph.Left, Graph.Bottom, Graph.Right, Graph.Bottom, Graph.GridFrameColor, 2dip)
End Sub

'draws the lines in a LINE chart
Private Sub DrawLines
	Private i, ip, l As Int
	
	For l = 0 To Items.Size - 1
		Private ID As ItemDataL
		Private lstCoords As List

		ID = Items.Get(l)
		lstCoords.Initialize
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			
			ip = i
			PD = Points.Get(i)
			Private Coords(2) As Int
			Coords(0) = Graph.Left + ip * Scale(sX).Scale
			Coords(1) = Graph.Bottom - (PD.YArray(l) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
			lstCoords.Add(Coords)
		Next
		
		xcvsGraph.ClipPath(pthGrid)	'avoids drawing outsides the grid
		
		For i = 1 To lstCoords.Size - 1
			Private Coords0(2), Coords1(2) As Int
			Coords0 = lstCoords.Get(i - 1)
			Coords1 = lstCoords.Get(i)
			xcvsGraph.DrawLine(Coords0(0), Coords0(1), Coords1(0), Coords1(1), ID.Color, ID.StrokeWidth)
		Next
		xcvsGraph.RemoveClip
		
		If ID.PointType <> "NONE" Then
			For i = 0 To lstCoords.Size - 1
				Private Coords(2) As Int
				Coords = lstCoords.Get(i)
				DrawPoint(Coords(0), Coords(1), ID.PointColor, ID.PointType, ID.PointFilled, ID.StrokeWidth)
			Next
		End If
	Next
	
	If Scale(sY(0)).MinVal< 0 And Scale(sY(0)).MaxVal > 0 Then
		Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
		xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
	End If
	
	If Legend.IncludeLegend <> "NONE" Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'Draws N lines with N different scales in LINE charts.
Private Sub DrawLinesNScales
	Private i, ip, l As Int
	
	For l = 0 To Items.Size - 1
		Private ID As ItemDataL
		Private lstCoords As List

		ID = Items.Get(l)
		lstCoords.Initialize
		For i = 0 To Points.Size -1
			Private PD As PointDataL
				
			ip = i '- Zoom.BeginIndex
			PD = Points.Get(i)
			Private Coords(2) As Int
			Coords(0) = Graph.Left + ip * Scale(sX).Scale
			Coords(1) = Graph.Bottom - (PD.YArray(l) - Scale(sY(l)).MinVal) * Scale(sY(l)).Scale
			lstCoords.Add(Coords)
		Next
		
		xcvsGraph.ClipPath(pthGrid)	'avoids drawing outsides the grid
		
		For i = 1 To lstCoords.Size - 1
			Private Coords0(2), Coords1(2) As Int
			Coords0 = lstCoords.Get(i - 1)
			Coords1 = lstCoords.Get(i)
			xcvsGraph.DrawLine(Coords0(0), Coords0(1), Coords1(0), Coords1(1), ID.Color, ID.StrokeWidth)
		Next
		xcvsGraph.RemoveClip
		
		If ID.PointType <> "NONE" Then
			For i = 0 To lstCoords.Size - 1
				Private Coords(2) As Int
				Coords = lstCoords.Get(i)
				DrawPoint(Coords(0), Coords(1), ID.PointColor, ID.PointType, ID.PointFilled, ID.StrokeWidth)
			Next
		End If
		
		If Scale(sY(l)).MinVal< 0 And Scale(sY(l)).MaxVal > 0 Then
			Private mYAxis0 = Graph.Bottom + Scale(sY(l)).MinVal * Scale(sY(l)).Scale As Int
			xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, ID.Color, 2dip)
		End If
	Next

	If Legend.IncludeLegend <> "NONE" And Points.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws a point at each StrokeTick
Private Sub DrawPoint(X As Int, Y As Int, Color As Int, PointType As String, Filled As Boolean, StrokeWidth As Int)
	Private dx As Int 
	
	dx = Max(4dip, 1.4 * StrokeWidth)
	Select PointType
		Case "CIRCLE"
			If Filled = False Then
				xcvsGraph.DrawCircle(X, Y, dx, Graph.ChartBackgroundColor, True, 2dip)
				xcvsGraph.DrawCircle(X, Y, dx, Color, Filled, 2dip)
			Else
				xcvsGraph.DrawCircle(X, Y, dx, Color, True, 2dip)
				xcvsGraph.DrawCircle(X, Y, dx, Color, False, 2dip)
			End If
		Case "SQUARE"
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 2dip)
				xcvsGraph.DrawRect(r, Color, Filled, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 2dip)
				xcvsGraph.DrawRect(r, Color, False, 2dip)
			End If
		Case "TRIANGLE"
			Private triPath As B4XPath
			triPath.Initialize(X - dx, Y + 0.8 * dx)
			triPath.LineTo(X, Y - 1.2 * dx)
			triPath.LineTo(X + dx, Y + 0.8 * dx)
			triPath.LineTo(X - dx, Y + 0.8 * dx)
			xcvsGraph.ClipPath(triPath)
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)	
					
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y + dx, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y + dx, Color, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y + dx, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y + dx, Color, 2dip)
			End If
		Case "RHOMBUS"
			Private triPath As B4XPath
			triPath.Initialize(X - dx, Y)
			triPath.LineTo(X, Y -  dx)
			triPath.LineTo(X + dx, Y)
			triPath.LineTo(X, Y + dx)
			triPath.LineTo(X - dx, Y)
			xcvsGraph.ClipPath(triPath)
			Private r As B4XRect
			r.Initialize(X - dx, Y - dx, X + dx, Y + dx)
					
			If Filled = False Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y, Color, 2dip)
				xcvsGraph.DrawLine(X + dx, Y, X, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y + dx, X - dx, Y, Color, 2dip)
			Else
				xcvsGraph.DrawRect(r, Color, True, 1dip)
				xcvsGraph.RemoveClip
				xcvsGraph.DrawLine(X - dx, Y, X, Y - dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y - dx, X + dx, Y, Color, 2dip)
				xcvsGraph.DrawLine(X + dx, Y, X, Y + dx, Color, 2dip)
				xcvsGraph.DrawLine(X, Y + dx, X - dx, Y, Color, 2dip)
			End If
		Case "CROSS+"
			dx = dx + 1dip
			xcvsGraph.DrawLine(X, Y - dx, X, Y + dx, Color, 2dip)
			xcvsGraph.DrawLine(X - dx, Y, X + dx, Y, Color, 2dip)
		Case "CROSSX", "CROSSx"
			xcvsGraph.DrawLine(X - dx, Y + dx, X + dx, Y - dx, Color, 2dip)
			xcvsGraph.DrawLine(X - dx, Y - dx, X + dx, Y + dx, Color, 2dip)
	End Select
End Sub

'draws the bars in a BAR chart
Private Sub DrawBars
	Private i, j, x0, x, h, y As Int
	Private Cols(Items.Size), ACols(Items.Size) As Int
	Private Names(Items.Size), GradientOrientation As String

	For i = 0 To Items.Size - 1
		Private ID As ItemDataL
		ID = Items.Get(i)
		Cols(i) = ID.Color
		Private ARGB As ARGBColor
		Private BmpCreate As BitmapCreator
		BmpCreate.Initialize(10, 10)
		BmpCreate.ColorToARGB(Cols(i), ARGB)
		ACols(i) = xui.Color_ARGB(Graph.GradientColorsAlpha, ARGB.r, ARGB.g, ARGB.b)
		Names(i) = ID.Name
	Next
	
	Select Graph.ChartType
		Case "BAR"
			Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
	
			xcvsGraph.ClipPath(pthGrid)	'avoids drawing outsides the grid
			For i = 0 To Points.Size - 1
				Private PD As PointDataL
				Private ip As Int
			
				ip = i
				PD = Points.Get(i)
				Private py(PD.YArray.Length) As Double
				x0 = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval - Graph.BarWidth / 2
				py = PD.YArray

				For j = 0 To PD.YArray.Length - 1
					Private r, rb As B4XRect
					x = x0 + j * Graph.BarSubWidth
				
					If Scale(sY(0)).Automatic = False Then ' manual scales
						If Scale(sY(0)).MinVal >= 0 Then
							h = (py(j) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
							r.Initialize(x, Graph.Bottom - h, x + Graph.BarSubWidth, Graph.Bottom)
							GradientOrientation = "TOP_BOTTOM"
						Else If  Scale(sY(0)).MaxVal <= 0 Then
							h = (py(j) - Scale(sY(0)).MaxVal) * Scale(sY(0)).Scale
							r.Initialize(x, Graph.Top, x + Graph.BarSubWidth, Graph.Top - h)
							GradientOrientation = "BOTTOM_TOP"
						Else
							h = py(j) * Scale(sY(0)).Scale
							If h > 0 Then
								r.Initialize(x, mYAxis0 - h, x + Graph.BarSubWidth, mYAxis0)
								GradientOrientation = "TOP_BOTTOM"
							Else
								r.Initialize(x, mYAxis0, x + Graph.BarSubWidth, mYAxis0 - h)
								GradientOrientation = "BOTTOM_TOP"
							End If
						End If
					Else	'automatic scales
						h = py(j) * Scale(sY(0)).Scale
						If h > 0 Then
							r.Initialize(x, mYAxis0 - h, x + Graph.BarSubWidth, mYAxis0)
						Else
							r.Initialize(x, mYAxis0, x + Graph.BarSubWidth, mYAxis0 - h)
						End If
					End If

					If Graph.GradientColors = False Then
						xcvsGraph.DrawRect(r, Cols(j), True, 1dip)
					Else
						Private bmc1 As BitmapCreator
						rb.Initialize(0, 0, Graph.BarSubWidth, Max(1, Abs(h)))
						bmc1.Initialize(Graph.BarSubWidth, Max(1, Abs(h)))
						If h > 0 Then
							GradientOrientation = "TOP_BOTTOM"
						Else
							GradientOrientation = "BOTTOM_TOP"
						End If
						bmc1.FillGradient(Array As Int(Cols(j), ACols(j)), rb, GradientOrientation)
						xcvsGraph.DrawBitmap(bmc1.Bitmap, r)
					End If
				Next
			Next
			xcvsGraph.RemoveClip

			If Scale(sY(0)).DrawYScale = True Then
				If mYAxis0 = Graph.Top Or mYAxis0 = Graph.Bottom Then
					xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
				Else
					xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
				End If
			End If
		
			If Graph.IncludeValues = True Then
				If PD.YArray.Length = 1 Then
					DrawBarValuesSingle
				Else
					DrawBarValuesMulti
				End If
			End If
		
			If Graph.IncludeBarMeanLine = True Then
				DrawBarMeanLine
			End If
		Case "STACKED_BAR"
			Private mYAxis0 = Graph.Bottom As Int
	
			xcvsGraph.ClipPath(pthGrid)	'avoids drawing outsides the grid
			For i = 0 To Points.Size - 1
				Private PD As PointDataL
				Private ip As Int
			
				ip = i
				PD = Points.Get(i)
				Private py(PD.YArray.Length) As Double
				x0 = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval - Graph.BarWidth / 2
				py = PD.YArray
		
				y = mYAxis0
				For j = 0 To PD.YArray.Length - 1
					Private r, rb As B4XRect
					h = py(j) * Scale(sY(0)).Scale
					r.Initialize(x0, y - h, x0 + Graph.BarWidth, y)
					If Graph.GradientColors = False Then
						xcvsGraph.DrawRect(r, Cols(j), True, 1dip)
					Else
						rb.Initialize(0, 0, Graph.BarWidth, Max(1, Abs(h)))
						Private bmc1 As BitmapCreator
						bmc1.Initialize(Graph.BarWidth, Max(1, Abs(h)))
						bmc1.FillGradient(Array As Int(Cols(j), ACols(j)), rb, "TOP_BOTTOM")
						xcvsGraph.DrawBitmap(bmc1.Bitmap, r)
					End If
					y = y - h
				Next
			Next
			xcvsGraph.RemoveClip

			If Scale(sY(0)).DrawYScale = True Then
				If Scale(sY(0)).DrawYScale = True Then
					If mYAxis0 = Graph.Top Or mYAxis0 = Graph.Bottom Then
						xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 2dip)
					Else
						xcvsGraph.DrawLine(Graph.Left, mYAxis0, Graph.Right, mYAxis0, Graph.GridFrameColor, 1dip)
					End If
				End If
			End If
	End Select
	
	If Legend.IncludeLegend <> "NONE" And Items.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'draws the bars mean value line and its value, only for single bar charts
Private Sub DrawBarMeanLine
	Private PD As PointDataL
	PD = Points.Get(0)
	
	Private ID As ItemDataL
	ID = Items.Get(0)

	If PD.YArray.Length > 1 Then Return
	
	Private i, sMean, sMean0, h, x0, y0, yt As Int
	Private Total, Mean As Double
	For i = 0 To Points.Size - 1
		PD = Points.Get(i)
		Total = Total + PD.YArray(0)
	Next
	Mean = Total / Points.Size
	sMean0 = Mean * Scale(sY(0)).Scale
	sMean = Graph.Bottom - (Mean - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
	
	xcvsGraph.DrawLine(Graph.Left, sMean, Graph.Right, sMean, ID.Color, 2dip)
	
	If Scale(sY(0)).MinVal = 0 And Scale(sY(0)).MaxVal > 0 Then
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			PD = Points.Get(i)
			h = PD.YArray(0) * Scale(sY(0)).Scale
			If sMean0 > h + 0.75 * Texts.ScaleTextHeight Then
				x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
				y0 = sMean - 1.35 * Texts.ScaleTextHeight
				yt = sMean - 0.3 * Texts.ScaleTextHeight
				Exit
			End If
		Next
	Else if Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			PD = Points.Get(i)
			h = -PD.YArray(0) * Scale(sY(0)).Scale
			If -sMean0 > h + 0.3 * Texts.ScaleTextHeight Then
				x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
				y0 = sMean + 0.3 * Texts.ScaleTextHeight
				yt = sMean + 1.2 * Texts.ScaleTextHeight
				Exit
			End If
		Next
	Else
		If Mean >= 0 Then
			For i = 0 To Points.Size - 1
				Private PD As PointDataL
				PD = Points.Get(i)
				h = PD.YArray(0) * Scale(sY(0)).Scale
				If Mean >= 0 And sMean0 > h + 0.75 * Texts.ScaleTextHeight Then
					x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
					y0 = sMean - 1.45 * Texts.ScaleTextHeight
					yt = sMean - 0.3 * Texts.ScaleTextHeight
					Exit
				End If
			Next
		Else
			For i = 0 To Points.Size - 1
				Private PD As PointDataL
				PD = Points.Get(i)
				h = -PD.YArray(0) * Scale(sY(0)).Scale
				If Mean < 0 And -sMean0 > h + 0.3 * Texts.ScaleTextHeight Then
					x0 = Graph.Left + Graph.XOffset + (i  + 0.5) * Graph.XInterval
					y0 = sMean + 0.3 * Texts.ScaleTextHeight
					yt = sMean + 1.2 * Texts.ScaleTextHeight
					Exit
				End If
			Next
		End If
	End If
	
	Private txt As String
	Private rctText, rctMean As B4XRect
	Private txtW, txtH As Double
	If BMVNFUsed = False Then
		txt = NumberFormat3(Mean, 6)
	Else
		txt = NumberFormat2(Mean, BMVNF.MinimumIntegers, BMVNF.MaximumFractions, BMVNF.MinimumFractions, BMVNF.GroupingUsed)
	End If
	rctText = xcvsGraph.MeasureText(txt, Texts.ScaleFont)
	txtW = 4dip + rctText.Width
	txtH = 1.2 * rctText.Height
	rctMean.Initialize(x0 - txtW / 2, y0, x0 + txtW / 2, y0 + txtH)
	xcvsGraph.DrawRect(rctMean, Graph.ChartBackgroundColor, True, 1dip)
	xcvsGraph.DrawText(txt, x0, yt, Texts.ScaleFont, ID.Color, "CENTER")
End Sub

'Draws the bar values, only for multi BAR charts.
Private Sub DrawBarValuesMulti
	If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 Then Return
	
	Private i, ip, j, h, x, x0, xt, dy, y, yt As Int
	Private Col As Int
	Private mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale As Int
	Private rectText, rectTextBackground As B4XRect
	Private TextWidth As Int
	Private LocalBarValueOrientation As String
	Private valText As String
	Private LocalTextSize As Float
	Private LocalTextHeight As Int
	Private LocalFont As B4XFont
	Private ID As ItemDataL
	Private ForExit = False As Boolean
	ID = Items.Get(0)
	
	LocalBarValueOrientation = Graph.BarValueOrientation
	LocalFont = Texts.ScaleFont
	LocalTextHeight = Texts.ScaleTextHeight
	LocalTextSize = Texts.ScaleTextSize
	'checks if the bar value text is too wide, if yes sets it to VERTICAL
	If Graph.BarValueOrientation = "HORIZONTAL" Then
'		For i = Zoom.BeginIndex To Zoom.EndIndex
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			For j = 0 To PD.YArray.Length - 1
				rectText = xcvsGraph.MeasureText(NumberFormat3(py(j), Values.MaxDigits), Texts.ScaleFont)
				TextWidth = rectText.Width + 1.5 * Texts.ScaleTextHeight
				If TextWidth + 0.1 * Texts.ScaleTextHeight > Graph.BarSubWidth Then
					LocalBarValueOrientation = "VERTICAL"
					Log("xChart BarValueOrientation set to VERTICAL")
					ForExit = True
					Exit
				End If
			Next
			If ForExit = True Then
				Exit
			End If
		Next
	End If

	If LocalBarValueOrientation = "VERTICAL" Then
		Private TextAlignment As String
		
		'checks if the bar width is too small for the value text
		If Texts.ScaleTextHeight * 1.5 + 4dip > Graph.BarSubWidth Then
			rectText = xcvsGraph.MeasureText("10", Texts.ScaleFont)
			LocalTextSize = Min(Texts.ScaleTextSize, Texts.ScaleTextSize * Graph.BarSubWidth / Texts.ScaleTextHeight / 1.2)
			LocalFont = xui.CreateFont2(Texts.ScaleFont, LocalTextSize)
			LocalTextHeight = Texts.ScaleTextHeight * LocalTextSize / Texts.ScaleTextSize
			If LocalTextSize < 6 Then
				Log("Bar value text size too small")
				Return
			End If
		End If
	
		For i = 0 To Points.Size - 1
			Private PD As PointDataL

			ip = i 
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			
			x0 = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval - Graph.BarWidth / 2 + Graph.BarSubWidth / 2 + 0.43 * LocalTextHeight
			For j = 0 To py.Length - 1
				If py(0) >= Scale(sY(0)).MinVal And py(0) <= Scale(sY(0)).MaxVal Then
					ID = Items.Get(j)
					xt = x0 + j * Graph.BarSubWidth
					x = xt - 0.9 * LocalTextHeight
					If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
						h = py(j) * Scale(sY(0)).Scale
					Else
						If Scale(sY(0)).MinVal >= 0 Then
							h = (py(j) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
						Else
							h = (py(j) - Scale(sY(0)).MaxVal) * Scale(sY(0)).Scale
						End If
					End If
					valText = NumberFormat3(py(j), Values.MaxDigits)
					rectText = xcvsGraph.MeasureText(valText, LocalFont)
					TextWidth = rectText.Width + 0.5 * LocalTextHeight
					If Abs(h) > TextWidth Then
						If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
							yt = mYAxis0 - h / 2
						Else
							If Scale(sY(0)).MinVal >= 0 Then
								yt = Graph.Bottom - h / 2
							Else If Scale(sY(0)).MaxVal <= 0 Then
								yt = Graph.Top - h / 2
							End If
						End If
						TextAlignment = "CENTER"
						Col = GetContrastColor(ID.Color)
					Else
						If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
							y = mYAxis0 - h
						Else
							If Scale(sY(0)).MinVal >= 0 Then
								y = Graph.Bottom - h
							Else If Scale(sY(0)).MaxVal <= 0 Then
								y = Graph.Top - h
							End If
						End If
						dy = 0.25 * LocalTextHeight
						rectTextBackground.Initialize(x, y, x + LocalTextHeight, y + TextWidth)
						rectTextBackground.Height = TextWidth
						If h = 0 Then
							If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
								yt = y + dy + 2dip
								TextAlignment = "RIGHT"
								rectTextBackground.Top = y + 2dip
							Else
								yt = y - dy - 2dip
								TextAlignment = "LEFT"
								rectTextBackground.Top = y - TextWidth - 2dip
							End If
						Else If h > 0  Then
							If Abs(h) + TextWidth > mYAxis0 - Graph.Top Then
								yt = mYAxis0 + dy + 2dip
								TextAlignment = "RIGHT"
								rectTextBackground.Top = mYAxis0 + 2dip
							Else
								yt = y - dy
								TextAlignment = "LEFT"
								rectTextBackground.Top = y - TextWidth
							End If
						Else
							If Abs(h) + TextWidth > Graph.Bottom - mYAxis0 Then
								yt = mYAxis0 - dy- 2dip
								TextAlignment = "LEFT"
								rectTextBackground.Top = mYAxis0 - TextWidth - 2dip
							Else
								yt = y + dy
								TextAlignment = "RIGHT"
								rectTextBackground.Top = y
							End If
						End If
						rectTextBackground.Bottom = rectTextBackground.Top + TextWidth
						rectTextBackground.Height = TextWidth
					
						Col = GetContrastColor(Graph.ChartBackgroundColor)
						xcvsGraph.DrawRect(rectTextBackground, Graph.ChartBackgroundColor, True, 1dip)
					End If
					xcvsGraph.DrawTextRotated(valText, xt, yt, LocalFont, Col, TextAlignment, -90)
				End If
			Next
		Next
	Else	' Graph.BarValueOrientation = "HORIZONTAL"
		For i = 0 To Points.Size - 1
			Private PD As PointDataL

			ip = i
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			x0 = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval - Graph.BarWidth / 2 + Graph.BarSubWidth / 2 '+ 0.5 * LocalTextHeight
			For j = 0 To py.Length - 1
				ID = Items.Get(j)
				xt = x0 + j * Graph.BarSubWidth
				If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
					h = py(j) * Scale(sY(0)).Scale
				Else
					If Scale(sY(0)).MinVal >= 0 Then
						h = (py(j) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
					Else
						h = (py(j) - Scale(sY(0)).MaxVal) * Scale(sY(0)).Scale
					End If
				End If
				valText = NumberFormat3(py(j), Values.MaxDigits)
				rectText = xcvsGraph.MeasureText(valText, LocalFont)
				TextWidth = rectText.Width + 0.5 * LocalTextHeight
				If Abs(h) > 2.25 * Texts.ScaleTextHeight Then
					If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
						y = mYAxis0 - h / 2
					Else
						If Scale(sY(0)).MinVal >= 0 Then
							y = Graph.Bottom - h / 2
						Else If Scale(sY(0)).MaxVal <= 0 Then
							y = Graph.Top - h / 2
						End If
					End If
					If h >= 0 Then
						y = y + 0.45 * Texts.ScaleTextHeight
					Else
						y = y + 0.38 * Texts.ScaleTextHeight
					End If
					Col = GetContrastColor(ID.Color)
				Else
					If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
						y = mYAxis0 - h
					Else
						If Scale(sY(0)).MinVal >= 0 Then
							y = Graph.Bottom - h
						Else If Scale(sY(0)).MaxVal <= 0 Then
							y = Graph.Top - h
						End If
					End If
					If h = 0 Then
						If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
							y = y + 1.45 * Texts.ScaleTextHeight
						Else
							y = y - 1.5 * Texts.ScaleTextHeight / 3
						End If
					Else If h > 0  Then
						y = y - 1.5 * Texts.ScaleTextHeight / 3
					Else
						y = y + 1.45 * Texts.ScaleTextHeight
					End If
					rectTextBackground.Initialize(xt - TextWidth / 2, y + 1.1 * rectText.Top, xt + TextWidth / 2, y - 0.1 * rectText.Top)
					Col = GetContrastColor(Graph.ChartBackgroundColor)
					xcvsGraph.DrawRect(rectTextBackground, Graph.ChartBackgroundColor, True, 1dip)
				End If
				xcvsGraph.DrawText(valText, xt, y, Texts.ScaleFont, Col, "CENTER")
			Next
		Next
	End If
End Sub

'Draws the bar values, only for single BAR charts.
Private Sub DrawBarValuesSingle
	If MinMaxMeanValues(0) = 0 And MinMaxMeanValues(1) = 0 Then Return
	
	Private i, ip, h, x, xt, dy, y, yt As Int
	Private Col As Int
	Private mYAxis0 As Int
	Private rectText, rectTextBackground As B4XRect
	Private TextWidth As Int
	Private LocalBarValueOrientation As String
	Private valText As String
	Private LocalTextSize As Float
	Private LocalTextHeight As Int
	Private LocalFont As B4XFont
	Private ID As ItemDataL
	
	mYAxis0 = Graph.Bottom + Scale(sY(0)).MinVal * Scale(sY(0)).Scale
	
	ID = Items.Get(0)
	
	LocalBarValueOrientation = Graph.BarValueOrientation
	LocalFont = Texts.ScaleFont
	LocalTextHeight = Texts.ScaleTextHeight
	LocalTextSize = Texts.ScaleTextSize
	'checks if the bar value text is too wide, if yes sets it to VERTICAL
	If Graph.BarValueOrientation = "HORIZONTAL" Then
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			rectText = xcvsGraph.MeasureText(NumberFormat3(py(0), Values.MaxDigits), Texts.ScaleFont)
			TextWidth = rectText.Width + 1.5 * Texts.ScaleTextHeight
			If TextWidth + 0.1 * Texts.ScaleTextHeight > Graph.XInterval Then
				LocalBarValueOrientation = "VERTICAL"
				Log("xChart BarValueOrientation set to VERTICAL")
				Exit
			End If
		Next
	End If

	If LocalBarValueOrientation = "VERTICAL" Then
		Private TextAlignment As String
		
		'checks if the bar width is too small for the value text
		If Texts.ScaleTextHeight * 1.5 + 4dip > Graph.BarWidth Then
			rectText = xcvsGraph.MeasureText("10", Texts.ScaleFont)
			LocalTextSize = Min(Texts.ScaleTextSize, Texts.ScaleTextSize * Graph.BarWidth / Texts.ScaleTextHeight / 1.2)
			LocalFont = xui.CreateFont2(Texts.ScaleFont, LocalTextSize)
			LocalTextHeight = Texts.ScaleTextHeight * LocalTextSize / Texts.ScaleTextSize
			If LocalTextSize < 6 Then
				Log("Bar value text size too small")
				Return
			End If
		End If
		
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
	
			ip = i
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			valText = NumberFormat3(py(0), Values.MaxDigits)
'			If py(0) >= Scale(sY(0)).MinVal And py(0) <= Scale(sY(0)).MaxVal Then
			If py(0) >= Round2(Scale(sY(0)).MinVal, 14) And py(0) <= Round2(Scale(sY(0)).MaxVal, 14) Then
				xt = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval + 0.4 * LocalTextHeight
				x = xt - 0.9 * LocalTextHeight
				If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
					h = py(0) * Scale(sY(0)).Scale
				Else
					If Scale(sY(0)).MinVal >= 0 Then
						h = (py(0) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
					Else
						h = (py(0) - Scale(sY(0)).MaxVal) * Scale(sY(0)).Scale
					End If
				End If
				rectText = xcvsGraph.MeasureText(valText, LocalFont)
				TextWidth = rectText.Width + LocalTextHeight
				If Abs(h) > TextWidth Then
					If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
						yt = mYAxis0 - h / 2
					Else
						If Scale(sY(0)).MinVal >= 0 Then
							yt = Graph.Bottom - h / 2
						Else If Scale(sY(0)).MaxVal <= 0 Then
							yt = Graph.Top - h / 2
						End If
					End If
					TextAlignment = "CENTER"
					Col = GetContrastColor(ID.Color)
				Else
					If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
						y = mYAxis0 - h
					Else
						If Scale(sY(0)).MinVal >= 0 Then
							y = Graph.Bottom - h
						Else If Scale(sY(0)).MaxVal <= 0 Then
							y = Graph.Top - h
						End If
					End If
					dy = 0.25 * LocalTextHeight
					rectTextBackground.Initialize(x, y, x + LocalTextHeight, y + TextWidth)
					rectTextBackground.Height = TextWidth
					If h = 0 Then
						If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
							yt = y + dy + 2dip
							TextAlignment = "RIGHT"
							rectTextBackground.Top = y + 2dip
							rectTextBackground.Height = TextWidth
						Else
							yt = y - dy - 2dip
							TextAlignment = "LEFT"
							rectTextBackground.Top = y - TextWidth - 2dip
							rectTextBackground.Height = TextWidth
						End If
					Else If h > 0  Then
						If Abs(h) + TextWidth > mYAxis0 - Graph.Top Then
							yt = mYAxis0 + dy + 2dip
							TextAlignment = "RIGHT"
							rectTextBackground.Top = mYAxis0 + 2dip
							rectTextBackground.Height = TextWidth
						Else
							yt = y - dy
							TextAlignment = "LEFT"
							rectTextBackground.Top = y - TextWidth
							rectTextBackground.Height = TextWidth
						End If
					Else
						If Abs(h) + TextWidth > Graph.Bottom - mYAxis0 Then
							yt = mYAxis0 - dy- 2dip
							TextAlignment = "LEFT"
							rectTextBackground.Top = mYAxis0 - TextWidth - 2dip
							rectTextBackground.Height = TextWidth
						Else
							yt = y + dy
							TextAlignment = "RIGHT"
							rectTextBackground.Top = y
							rectTextBackground.Height = TextWidth
						End If
					End If
			
					Col = GetContrastColor(Graph.ChartBackgroundColor)
					xcvsGraph.DrawRect(rectTextBackground, Graph.ChartBackgroundColor, True, 1dip)
				End If
				xcvsGraph.DrawTextRotated(valText, xt, yt, LocalFont, Col, TextAlignment, -90)
			End If
		Next
	Else	' Graph.BarValueOrientation = "HORIZONTAL"
		For i = 0 To Points.Size - 1
			Private PD As PointDataL
			
			ip = i 
			PD = Points.Get(i)
			Private py(PD.YArray.Length) As Double
			py = PD.YArray
			valText = NumberFormat3(py(0), Values.MaxDigits)
			
			x = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval
			If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
				h = py(0) * Scale(sY(0)).Scale
			Else
				If Scale(sY(0)).MinVal >= 0 Then
					h = (py(0) - Scale(sY(0)).MinVal) * Scale(sY(0)).Scale
				Else
					h = (py(0) - Scale(sY(0)).MaxVal) * Scale(sY(0)).Scale
				End If
			End If
			If Abs(h) > 2.25 * Texts.ScaleTextHeight Then
				If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
					y = mYAxis0 - h / 2
				Else
					If Scale(sY(0)).MinVal >= 0 Then
						y = Graph.Bottom - h / 2
					Else If Scale(sY(0)).MaxVal <= 0 Then
						y = Graph.Top - h / 2
					End If
				End If
				If h >= 0 Then
					y = y + 0.45 * Texts.ScaleTextHeight
				Else
					y = y + 0.38 * Texts.ScaleTextHeight
				End If
				Col = GetContrastColor(ID.Color)
			Else
				If Scale(sY(0)).Automatic = True Or (Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal > 0) Then
					y = mYAxis0 - h
				Else
					If Scale(sY(0)).MinVal >= 0 Then
						y = Graph.Bottom - h
					Else If Scale(sY(0)).MaxVal <= 0 Then
						y = Graph.Top - h
					End If
				End If
				If h = 0 Then
					If Scale(sY(0)).MinVal < 0 And Scale(sY(0)).MaxVal <= 0 Then
						y = y + 1.45 * Texts.ScaleTextHeight
					Else
						y = y - 1.5 * Texts.ScaleTextHeight / 3
					End If
				Else If h > 0  Then
					y = y - 1.5 * Texts.ScaleTextHeight / 3
				Else
					y = y + 1.45 * Texts.ScaleTextHeight
				End If
			
				Col = GetContrastColor(Graph.ChartBackgroundColor)
				rectTextBackground.Initialize(x - TextWidth / 2, y + 1.1 * rectText.Top, x + TextWidth / 2, y - 0.1 * rectText.Top)
				xcvsGraph.DrawRect(rectTextBackground, Graph.ChartBackgroundColor, True, 1dip)
			End If
			xcvsGraph.DrawText(valText, x, y, Texts.ScaleFont, Col, "CENTER")
		Next
	End If
End Sub

'Draws the PIE chart.
Private Sub DrawPies
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)
	
	Dim Total As Float
	For Each Item As ItemDataL In Items
		Total = Total + Item.Value
	Next
	
	Private xy As Float
	Private TitleHeight = 0 As Int
	Private DeltaHeight = 0 As Int
	
	If Graph.Title <> "" And Graph.Subtitle <> "" Then
		TitleHeight = 1.7 * Texts.TitleTextHeight
		If (Texts.TitleTextWidth + Texts.SubtitleTextWidth + 40dip) < xpnlGraph.Width Then
		Else
			DeltaHeight = 1.5 * Texts.SubtitleTextHeight
		End If
	Else If Graph.Title <> "" And Graph.Subtitle = "" Then
		TitleHeight = 1.7 * Texts.TitleTextHeight
	Else If Graph.Title = "" And Graph.Subtitle <> "" Then
		TitleHeight = 1.7 * Texts.SubTitleTextHeight
	End If
	Graph.Radius = Min(xpnlGraph.Width, (Graph.Height - TitleHeight - DeltaHeight)) / 2 - 10dip
	
	If Legend.IncludeLegend <> "NONE" Then
		If xpnlGraph.Width > xpnlGraph.Height Then
			Graph.CenterX = Graph.Radius + 10dip
		Else
			Graph.CenterX = xpnlGraph.Width / 2
		End If
	Else
		Graph.CenterX = xpnlGraph.Width / 2
	End If
	Graph.CenterY = Graph.Height - Graph.Radius - 10dip
	
	If Graph.Title <> "" And Graph.Subtitle <> "" Then
		If DeltaHeight = 0 Then
			xy = (xpnlGraph.Width - Texts.TitleTextWidth - Texts.SubtitleTextWidth - 10dip) / 2
			xcvsGraph.DrawText(Graph.Title, xy, 1.3 * Texts.TitleTextHeight, Texts.TitleFont, Texts.TitleTextColor, "LEFT")
			xy = xy + Texts.TitleTextWidth + 20dip
			xcvsGraph.DrawText(Graph.SubTitle, xy, 1.3 * Texts.TitleTextHeight, Texts.SubTitleFont, Texts.SubTitleTextColor, "LEFT")
		Else
			xy = 1.3 * Texts.TitleTextHeight
			xcvsGraph.DrawText(Graph.Title, xpnlGraph.Width / 2, xy, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
			xy = xy + 1.3 * Texts.SubTitleTextHeight
			xcvsGraph.DrawText(Graph.SubTitle, xpnlGraph.Width / 2, xy, Texts.SubTitleFont, Texts.SubTitleTextColor, "CENTER")
		End If
	Else If Graph.Title <> "" And Graph.Subtitle = "" Then
		xcvsGraph.DrawText(Graph.Title, xpnlGraph.Width / 2, 1.3 * Texts.TitleTextHeight, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	Else If Graph.Title = "" And Graph.Subtitle <> "" Then
		xcvsGraph.DrawText(Graph.SubTitle, xpnlGraph.Width / 2, 1.3 * Texts.SubTitleTextHeight, Texts.SubTitleFont, Texts.SubTitleTextColor, "CENTER")
	End If
	
	Private RadiusText As Float = Graph.Radius * 0.7
	Private StartAngle, TotalAngle, MidAngle As Float
	TotalAngle = 360 - Graph.PieGapDegrees * Items.Size
	Private rectCircle As B4XRect
	rectCircle.Initialize(Graph.CenterX - Graph.Radius, Graph.CenterY - Graph.Radius, Graph.CenterX + Graph.Radius, Graph.CenterY + Graph.Radius)
	
	StartAngle = Graph.PieStartAngle
	For Each Item As ItemDataL In Items
		Private mPath As B4XPath
		Private Angle As Float = Item.Value / Total * TotalAngle
		If Angle = TotalAngle Then
			If Graph.GradientColors = False Then
				xcvsGraph.DrawCircle(Graph.CenterX, Graph.CenterY, Graph.Radius, Item.Color, True, 0)
			Else
			End If
		Else
			Private ARGB As ARGBColor
			Private BmpCreate As BitmapCreator
			Private Acol As Int
			BmpCreate.Initialize(10, 10)
			BmpCreate.ColorToARGB(Item.Color, ARGB)
			Acol = xui.Color_ARGB(Graph.GradientColorsAlpha, ARGB.r, ARGB.g, ARGB.b)
			
			mPath.InitializeArc(Graph.CenterX, Graph.CenterY, Graph.Radius, StartAngle, Angle)
			StartAngle = StartAngle + Angle + Graph.PieGapDegrees
			xcvsGraph.ClipPath(mPath)
			If Graph.GradientColors = False Then
				xcvsGraph.DrawCircle(Graph.CenterX, Graph.CenterY, Graph.Radius, Item.Color, True, 0)
			Else
				Private rb As B4XRect
				rb.Initialize(0, 0, 2 * Graph.Radius, 2 * Graph.Radius)
				Private bc1 As BitmapCreator
				bc1.Initialize(2 * Graph.Radius, 2 * Graph.Radius)
				bc1.FillRadialGradient(Array As Int(Acol, Item.Color), rb)
				xcvsGraph.DrawBitmap(bc1.Bitmap, rectCircle)
			End If
			xcvsGraph.RemoveClip
		End If
	Next
	
	If Graph.PieAddPercentage Then
		Private Percentage As Float
		
		For Each Item As ItemDataL In Items
			Private mPath As B4XPath
			Private Angle As Float = Item.Value / Total * TotalAngle
			If Angle = TotalAngle Then
				xcvsGraph.DrawCircle(Graph.CenterX, Graph.CenterY, Graph.Radius, Item.Color, True, 0)
			Else
				StartAngle = StartAngle + Angle + Graph.PieGapDegrees
				Private x, y As Int
				Private txt As String
				MidAngle = StartAngle - Angle /2 - Graph.PieGapDegrees
				x = Graph.CenterX + RadiusText * CosD(MidAngle)
				y = Graph.CenterY + RadiusText * SinD(MidAngle) + 5dip
				Percentage = Item.Value / Total * 100
				txt = NumberFormat2(Percentage, 1, mPiePercentageNbFractions, mPiePercentageNbFractions, False) & " %"
				xcvsGraph.DrawText(txt, x, y, Texts.AxisFont, GetContrastColor(Item.Color), "CENTER")
			End If
		Next
	End If
	
	If Legend.IncludeLegend <> "NONE" And Items.Size > 0 Then
		DrawLegend
	End If
	
	xcvsGraph.Invalidate
End Sub

'gets the x intervals and x scale for LINE charts
Private Sub GetXIntervals
	Private I As Int
	
	Scale(sX).Scale = Graph.Width / (Points.Size - 1)
	
	For i = 0 To Points.Size - 1
		Private PD As PointDataL
		PD = Points.Get(I)
		If PD.ShowTick = True Then
			Scale(sX).NbIntervals = Scale(sX).NbIntervals + 1
		End If
	Next
	Scale(sX).Scale = Graph.Width / (Points.Size - 1)
End Sub

'clears all data, not the title nor axis names
Public Sub ClearData
	ClearPoints
	Items.Clear
End Sub

'Clears all points, not the title nor axis names.
Public Sub ClearPoints
	Points.Clear
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Width
End Sub

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Height
End Sub

'gets returns white for a dark color or returns black for a light color
Private Sub GetContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	yiq = r * 0.299 + g * 0.587 + b * 0.114
	
	If yiq > 128 Then
		Return xui.Color_Black
	Else
		Return xui.Color_White
	End If
End Sub

'draws the legend
Private Sub DrawLegend
	Private y, y1, w, x As Int
	Private h As Int = 1.8 * Legend.TextHeight
	Private box As Int = 0.8 * Legend.TextHeight
	Private textVerticalOffset As Int = 0.3 * Legend.TextHeight
	If xui.IsB4i Then textVerticalOffset = 0.45 * Legend.TextHeight
	Private i As Int
	Private r As B4XRect
	
	y = 1.2 * Legend.TextHeight
	y = Graph.Top + 0.5 * box + 2dip
	Select Legend.IncludeLegend
		Case "TOP_RIGHT"
			h = Texts.AxisTextHeight * 1.2
			For Each Item As ItemDataL In Items
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & NumberFormat3(Item.Value, 6)
				End If
				w = Max(w, MeasureTextWidth(txt, Legend.TextFont))
			Next
			w = w + 2 * box + Texts.AxisTextHeight
			x = Graph.Right - w - 2dip
			r.Initialize(x - box, y - 0.5 * box, x + w, y + h * Items.Size + 0.5 * box)
			If Graph.ChartBackgroundColor = xui.Color_Transparent Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 0)
			Else
				xcvsGraph.DrawRect(r, Legend.BackgroundColor, True, 0)
			End If
			For Each Item As ItemDataL In Items
				Private top As Int = y + h * i
				r.Initialize(x, top + 0.5 * h - 0.65 * box, x + box, top + 0.5 * h + 0.35 * box)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & NumberFormat3(Item.Value, 6)
				End If
				xcvsGraph.DrawText(txt, x + box + box, top + 0.5 * h + textVerticalOffset, Legend.TextFont, Legend.TextColor, "LEFT")
				i = i + 1
			Next
		Case "BOTTOM"
			Private x, y0, y As Int
			Private i As Int
			Private r As B4XRect
			
			y0  = xpnlGraph.Height - Legend.Height + 0.9 * Legend.TextHeight
			x = box

			r.Initialize(0.5 * box, xpnlGraph.Height - Legend.Height - 0.5 * box, xpnlGraph.Width - 0.5 * box, xpnlGraph.Height - 0.5 * box)
			If Graph.ChartBackgroundColor = xui.Color_Transparent Then
				xcvsGraph.DrawRect(r, Graph.ChartBackgroundColor, True, 0)
			Else
				xcvsGraph.DrawRect(r, Legend.BackgroundColor, True, 0)
			End If
			
			For i = 0 To Items.Size - 1
				Private Item As ItemDataL
				Item = Items.Get(i)
				y = y0 + Legend.TextHeight * Legend.LineNumbers.Get(i)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & NumberFormat3(Item.Value, 6)
				End If
				If Legend.LineChange.Get(i) = True Then
					x = box
				End If

				r.Initialize(x, y - box, x + box, y)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
				If Graph.ChartType = "PIE" And Graph.IncludeValues Then
					txt = txt & " : " & NumberFormat3(Item.Value, 6)
				End If
				
				#If B4A
					y1 = y '+ 0.1 * box
				#Else If B4i
					y1 = y + 0.3 * box
				#Else
				y1 = y '- 0.1 * box
				#End If
				xcvsGraph.DrawText(txt, x + 1.5 * box, y1, Legend.TextFont, Legend.TextColor, "LEFT")
				x = x + 2.5 * box + MeasureTextWidth(txt, Legend.TextFont)
			Next
	End Select
End Sub

'gets the number of lines for the BOTTOM legend and the line changes
Private Sub GetLegendLineNumbers(Limit As Int)
	Private x As Int
	Private box As Int = 1.05 * Legend.TextHeight
	
	Legend.LineNumber = 1
	Legend.LineNumbers.Clear
	Legend.LineChange.Clear
	
	Private AllTooBig = False As Boolean
	
	For i = 0 To Items.Size - 1
		Private Item As ItemDataL
		Item = Items.Get(i)
		Private txt As String = Item.Name
		If Graph.ChartType = "PIE" And Legend.IncludeLegend = "BOTTOM" And Graph.IncludeValues = True Then
			txt = txt & " : " & NumberFormat3(Item.Value, 6)
		End If
		If 1.85 * box + MeasureTextWidth(txt, Legend.TextFont) > Limit Then
			AllTooBig = True
		End If
	Next
	
	If AllTooBig = True Then
		Legend.LineNumber = Items.Size
		For i = 0 To Items.Size - 1
			Legend.LineChange.Add(True)
			Legend.LineNumbers.Add(i)
		Next
	Else
		x = 0
		For i = 0 To Items.Size - 1
			Private Item As ItemDataL
			Item = Items.Get(i)
			Private txt As String = Item.Name
			If Graph.ChartType = "PIE" And Legend.IncludeLegend = "BOTTOM" And Graph.IncludeValues = True Then
				txt = txt & " : " & NumberFormat3(Item.Value, 6)
			End If
			x = x + 1.85 * box + MeasureTextWidth(txt, Legend.TextFont)
			If x > Limit Then
				x = 1.85 * box + MeasureTextWidth(txt, Legend.TextFont)
				Legend.LineNumber = Legend.LineNumber + 1
				Legend.LineChange.Add(True)
			Else
				Legend.LineChange.Add(False)
			End If
			Legend.LineNumbers.Add(Legend.LineNumber - 1)
		Next
	End If
End Sub

'Formats a number with scientific notation.
'MaxDigits = number max of digits.
'Examples for 6 digits: 1.23456 / 12.3456 / 1234.56 / 123456 / 1.23E10.
Public Sub NumberFormat3(Number As Double, MaxDigits As Int) As String
	Private mant, exp, lng, lng2 As Double
	Private str, strMinus As String
	
	If Abs(Number) < 1e-11 Then Return "0"
	
	If Number < 0 Then
		strMinus = "-"
	Else
		strMinus = ""
	End If
	lng = Logarithm(Abs(Number), 10)
	exp = Floor(lng)
	If exp < 0 Then
		lng2 = Floor(lng)
		lng = -lng2 + lng
	Else
		lng = lng - exp
	End If
	
	If exp < MaxDigits And exp > -5 Then
		str = NumberFormat2(Number, 1, MaxDigits - 1 - exp, 0, False)
	Else If exp <= -5 And exp > -7 Then
		str = NumberFormat2(Number, 1, 9, 0, False)
	Else
		mant = Power(10, lng)
		str = strMinus & NumberFormat2(mant, 1, MaxDigits - 1, 0, False)
		str = str & "E" & exp
	End If
	
	Return str
End Sub

#If B4i
Private Sub Round2(Number As Double, DecimalPlaces As Int) As Double
	Private shift As Double = Power(10, DecimalPlaces)
	Return Round(Number * shift) / shift
End Sub
#End If

'Gets or sets the Chart title
Public Sub getTitle As String
	Return Graph.Title
End Sub

Public Sub setTitle(Title As String)
	Graph.Title = Title
End Sub

'Gets or sets the Subtitle property.
Public Sub getSubtitle As String
	Return Graph.Subtitle
End Sub

Public Sub setSubtitle(Subtitle As String)
	Graph.Subtitle = Subtitle
End Sub

'Gets or sets the SubtitleTextSize property.
'Setting this text size sets automatically AutomaticTextSizes = False.
Public Sub getSubtitleTextSize As Float
	Return Texts.AxisTextSize
End Sub

Public Sub setSubtitleTextSize(SubtitleTextSize As Float)
	Texts.SubtitleTextSize = SubtitleTextSize
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Sets the SubtitleTextColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.SubitleTextColor = xui.Color_Black</code>
Public Sub setSubtitleTextColor(Color As Int)
	Texts.SubtitleTextColor = Color
End Sub

'Gets or sets the BarValueOrientation property.
'Possible values: VERTICAL, HORIZONTAL.
Public Sub getBarValueOrientation As String
	Return Graph.BarValueOrientation
End Sub

'Gets or sets the X axis name
Public Sub getXAxisName As String
	Return Graph.XAxisName
End Sub

Public Sub setXAxisName(XAxisName As String)
	Graph.XAxisName = XAxisName
End Sub

'Gets or sets the Y axis name
Public Sub getYAxisName As String
	Return Graph.YAxisName
End Sub

Public Sub setYAxisName(YAxisName As String)
	Graph.YAxisName = YAxisName
End Sub

'Gets or sets the Y scale max value
'Setting YSclaeMaxValue works only with AutomaticScale = False
Public Sub getYScaleMaxValue As Double
	Return Scale(sY(0)).MaxVal
End Sub

Public Sub setYScaleMaxValue(YScaleMaxValue As Double)
	Scale(sY(0)).MaxManu = YScaleMaxValue
	Scale(sY(0)).MaxVal = YScaleMaxValue
	Scale(sY(0)).Automatic = False
End Sub

'Gets or sets the Y scale min value
'Setting YSclaeMinValue works only with AutomaticScale = False
Public Sub getYScaleMinValue As Double
	Return Scale(sY(0)).MinVal
End Sub

Public Sub setYScaleMinValue(YScaleMinValue As Double)
	Scale(sY(0)).MinManu = YScaleMinValue
	Scale(sY(0)).MinVal = YScaleMinValue
	Scale(sY(0)).Automatic = False
End Sub

'Gets or sets the IncludeLegend property
'Possible values: NONE, TOP_RIGHT, BOTTOM
Public Sub getIncludeLegend As String
	Return Legend.IncludeLegend
End Sub

Public Sub setIncludeLegend(IncludeLegend As String)
	Legend.IncludeLegend = IncludeLegend
End Sub

'Gets or sets the IncludeValues property
'Possible only for single bar charts or pie charts with TOP_RIGHT legend
Public Sub getIncludeValues As String
	Return Graph.IncludeValues
End Sub

Public Sub setIncludeValues(IncludeValues As String)
	Graph.IncludeValues = IncludeValues
End Sub

'Gets or sets the IncludeBarMeanLine property
'Adds a line at the mean value and its value.
'Possible only for single bar chart
Public Sub getIncludeBarMeanLine As Boolean
	Return Graph.IncludeBarMeanLine
End Sub

Public Sub setIncludeBarMeanLine(IncludeBarMeanLine As Boolean)
	Graph.IncludeBarMeanLine = IncludeBarMeanLine
End Sub

'Sets the LegendBackgroundColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.LegendBackgroundColor = xui.Color_ARGB(102, 255, 255, 255)</code>
Public Sub setLegendBackgroundColor(Color As Int)
	Legend.BackgroundColor = Color
End Sub

'Sets the LegendTextColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.LegendTextColor = xui.Color_Black</code>
Public Sub setLegendTextColor(Color As Int)
	Legend.TextColor = Color
End Sub

'Gets or sets the AutomaticScale property
'The scales for the Y axis are calulated automatically.
Public Sub getAutomaticScale As Boolean
	Return Scale(sY(0)).Automatic
End Sub

Public Sub setAutomaticScale(AutomaticScale As Boolean)
	Scale(sY(0)).Automatic = AutomaticScale
	Scale(sY(1)).Automatic = AutomaticScale
	Scale(sY(2)).Automatic = AutomaticScale
	Scale(sY(3)).Automatic = AutomaticScale
	Scale(sX).Automatic = AutomaticScale
End Sub

'Gets or sets the DifferentScales property, only for LINE charts.
'When True, displays the lines with different automatic scales for two up to four lines max.
'If the number of lines is 1 or bigger than 4, then all lines have the same scale.
Public Sub getDifferentScales As Boolean
	Return Scale(sY(0)).Different
End Sub

Public Sub setDifferentScales(DifferentScales As Boolean)
	Scale(sY(0)).Different = DifferentScales
	Scale(sY(1)).Different = DifferentScales
	Scale(sY(2)).Different = DifferentScales
	Scale(sY(3)).Different = DifferentScales
End Sub

'Gets or sets the XScaleTextOrientation property
'Possible values: VERTICAL, HORIZONTAL, 45 DEGREES
Public Sub getXScaleTextOrientation As String
	Return Graph.XScaleTextOrientation
End Sub

Public Sub setXScaleTextOrientation(XScaleTextOrientation As String)
	Graph.XScaleTextOrientation = XScaleTextOrientation
End Sub

'Gets or sets the chart type
'Possible values: BAR, STACKED_BAR, LINE, PIE
Public Sub getChartType As String
	Return Graph.ChartType
End Sub

Public Sub setChartType(ChartType As String)
	If ChartType = "BAR" Or ChartType = "STACKED_BAR" Or ChartType = "LINE" Or ChartType = "PIE" Then
		Graph.ChartType = ChartType
	Else
		Log("Wrong chart type")
	End If
End Sub

'Gets or sets the Left property
Public Sub getLeft As Int
	Return mBase.Left
End Sub

Public Sub setLeft(Left As Int)
	mBase.Left = Left
End Sub

'Gets or sets the Top property
Public Sub getTop As Int
	Return mBase.Left
End Sub

Public Sub setTop(Top As Int)
	mBase.Top = Top
End Sub

'Gets or sets the Width property
Public Sub getWidth As Int
	Return mBase.Width
End Sub

Public Sub setWidth(Width As Int)
	mBase.Width = Width
	DrawChart
End Sub

'Gets or sets the Height property
Public Sub getHeight As Int
	Return mBase.Height
End Sub

Public Sub setHeight(Height As Int)
	mBase.Height = Height
	DrawChart
End Sub

'Gets or sets the Visible property
Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub setVisible(Visible As Boolean)
	mBase.Visible = Visible
End Sub

'Gets or sets the AutomaticTextSizes property
'The text sizes are calculated depending on the chart size.
Public Sub getAutomaticTextSizes As Boolean
	Return Texts.AutomaticTextSizes
End Sub

Public Sub setAutomaticTextSizes(AutomaticTextSizes As Boolean)
	Texts.AutomaticTextSizes = AutomaticTextSizes
End Sub

'Gets or sets the TitleTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False
Public Sub getTitleTextSize As Float
	Return Texts.TitleTextSize
End Sub

Public Sub setTitleTextSize(TitleTextSize As Float)
	Texts.TitleTextSize = TitleTextSize
	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Gets or sets the AxisTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False
Public Sub getAxisTextSize As Float
	Return Texts.AxisTextSize
End Sub

Public Sub setAxisTextSize(AxisTextSize As Float)
	Texts.AxisTextSize = AxisTextSize
	Texts.AxisFont = xui.CreateDefaultFont(Texts.AxisTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Gets or sets the ScaleTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False
Public Sub getScaleTextSize As Float
	Return Texts.ScaleTextSize
End Sub

Public Sub setScaleTextSize(ScaleTextSize As Float)
	Texts.ScaleTextSize = ScaleTextSize
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Gets or sets the LegendTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False
Public Sub getLegendTextSize As Float
	Return Legend.TextSize
End Sub

Public Sub setLegendTextSize(LegendTextSize As Float)
	Legend.TextSize = LegendTextSize
	Legend.TextFont = xui.CreateDefaultFont(Legend.TextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Gets or sets the ValuesTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False
Public Sub getValuesTextSize As Float
	Return Values.TextSize
End Sub

Public Sub setValuesTextSize(LegendTextSize As Float)
	Values.TextSize = LegendTextSize
	Values.TextFont = xui.CreateDefaultFont(Values.TextSize)
	Texts.AutomaticTextSizes = False
End Sub

'Sets the ValuesBackgroundColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.ValuesBackgroundColor = xui.Color_ARGB(10, 0, 0, 0)</code>
Public Sub setValuesBackgroundColor(Color As Int)
	Values.BackgroundColor = Color
End Sub

'Gets or sets the DisplayValues property
'If True, displays the item values when moving the finger or the cursor on the chart.
Public Sub getDisplayValues As Boolean
	Return Values.Show
End Sub

Public Sub setDisplayValues(DisplayValues As Boolean)
	Values.Show = DisplayValues
End Sub

'Gets or sets the ValuesShowOnHover property
'If True, displays the item values when hovering with the cursor over a chart; valid only for B4J.
Public Sub getDisplayValuesOnHover As Boolean
	Return Values.ShowOnHover
End Sub

Public Sub setDisplayValuesOnHover(DisplayValuesOnHover As Boolean)
	Values.ShowOnHover = DisplayValuesOnHover
End Sub

'Gets or sets the ScaleValues property.
'It is a string with the different scale values separated by the exclamation mark.
'It must begin with 1! and end with !10.
'Example: the default property 1!2!2.5!5!10.
Public Sub getScaleValues As String
	Return Scale(sY(0)).ScaleValues
End Sub

Public Sub setScaleValues(ScaleValues As String)
	If ScaleValues.StartsWith("1!") = False Or ScaleValues.EndsWith("!10") = False Then
		Log("Wrong ScaleValues property")
		Return
	End If
	Scale(sY(0)).ScaleValues = ScaleValues
	Scale(sY(1)).ScaleValues = ScaleValues
	Scale(sY(2)).ScaleValues = ScaleValues
	Scale(sY(3)).ScaleValues = ScaleValues
End Sub

'Gets or sets the DrawXScale property.
'True by default, if False doesn't draw the X scale values.
'Not drawing the scale can be useful for small charts.
'Not for logarithmic scales.
Public Sub getDrawXScale As Boolean
	Return Scale(sX).DrawXScale
End Sub

Public Sub setDrawXScale(DrawXScale As Boolean)
	Scale(sX).DrawXScale = DrawXScale
End Sub

'Gets or sets the DrawYScale property.
'True by default, if False doesn't draw the Y scale values.
'Not drawing the scale can be useful for small charts.
'Not for logarithmic scales.
Public Sub getDrawYScale As Boolean
	Return Scale(sY(0)).DrawYScale
End Sub

Public Sub setDrawYScale(DrawYScale As Boolean)
	Scale(sY(0)).DrawYScale = DrawYScale
	Scale(sY(1)).DrawYScale = DrawYScale
	Scale(sY(2)).DrawYScale = DrawYScale
	Scale(sY(3)).DrawYScale = DrawYScale
End Sub

'Gets or sets the GradientColors property
'Use gradient or plain colors for pies and bars.
Public Sub getGradientColors As Boolean
	Return Graph.GradientColors
End Sub

Public Sub setGradientColors(GradientColors As Boolean)
	Graph.GradientColors = GradientColors
End Sub

'Gets or sets the GradientColorsAlpha property.
'Values between 0 and 255.
'Setting this value, sets automatically the GradientColors property to True.
Public Sub getGradientColorsAlpha As Int
	Return Graph.GradientColorsAlpha
End Sub

Public Sub setGradientColorsAlpha(GradientColorsAlpha As Int)
	Graph.GradientColorsAlpha = GradientColorsAlpha
	Graph.GradientColorsAlpha = Max(0, Graph.GradientColorsAlpha)
	Graph.GradientColorsAlpha = Min(255, Graph.GradientColorsAlpha)
End Sub

'Sets the ChartBackgroundColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.ChartBackgroundColor = xui.Color_Red</code>
Public Sub setChartBackgroundColor(Color As Int)
	Graph.ChartBackgroundColor = Color
End Sub
	
'Sets the GridFrameColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.GridFrameColor = xui.Color_Red</code>
Public Sub setGridFrameColor(Color As Int)
	Graph.GridFrameColor = Color
End Sub
	
'Sets the GridColor property
'The color must be an xui.Color
'Example code: <code>xChart1.GridColor = xui.Color_Red</code>
Public Sub setGridColor(Color As Int)
	Graph.GridColor = Color
End Sub

'Sets the TitleTextColor property
'The color must be an xui.Color
'Example code: <code>xChart1.TitleTextColor = xui.Color_Red</code>
Public Sub setTitleTextColor(Color As Int)
	Texts.TitleTextColor = Color
End Sub

'Sets the AxisTextColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.AxisTextColor = xui.Color_Black</code>
Public Sub setAxisTextColor(Color As Int)
	Texts.AxisTextColor = Color
End Sub

'Sets the ScaleTextColor property
'The color must be an xui.Color
'Example code: <code>xChart1.ScaleTextColor = xui.Color_Red</code>
Public Sub setScaleTextColor(Color As Int)
	Texts.ScaleTextColor = Color
End Sub

'Sets the ValuesTextColor property	
'The color must be an xui.Color
'Example code: <code>xChart1.ValuesTextColor = xui.Color_Red</code>
Public Sub setValuesTextColor(Color As Int)
	Values.TextColor = Color
End Sub

'Gets or sets the NbYIntervals property, number of Y axis intervals
'Should be an even number, otherwise the 0 scale value might not be displayed
Public Sub getNbYIntervals As Int
	Return Scale(sY(0)).NbIntervals
End Sub

Public Sub setNbYIntervals (NbYIntervals As Int)
	Scale(sY(0)).NbIntervals = NbYIntervals
	Scale(sY(1)).NbIntervals = NbYIntervals
	Scale(sY(2)).NbIntervals = NbYIntervals
	Scale(sY(3)).NbIntervals = NbYIntervals
End Sub

'Gets or sets the YZeroAxis property for LINE charts
'If all values are positives, sets the lower Y scale to zero
'If all values are negatives, sets the upper Y scale to zero
Public Sub getYZeroAxis As Boolean
	Return Scale(sY(0)).YZeroAxis
End Sub

'Gets or sets the PieStartAngle property.
'Default value = 0 (three o'clock), positive clockwise.
'Twelve o'clock = -90.
Public Sub getPieStartAngle As Int
	Return Graph.PieStartAngle
End Sub

Public Sub setPieStartAngle(PieStartAngle As Int)
	Graph.PieStartAngle = PieStartAngle
End Sub

'Gets or sets the PieStartAngle property.
'Gap in degrees between pies. Pie charts only.
'Default value = 0 
Public Sub getPieGapDegrees As Int
	Return Graph.PieGapDegrees
End Sub

Public Sub setPieGapDegrees(PieGapDegrees As Int)
	Graph.PieGapDegrees = PieGapDegrees
End Sub

'Gets or sets the number of fractions for pie percentage values.
'min = 0  max = 2.
Public Sub getPieAddPercentage As Boolean
	Return Graph.PieAddPercentage
End Sub

Public Sub setPieAddPercentage(PieAddPercentage As Boolean)
	Graph.PieAddPercentage = PieAddPercentage
End Sub

'Gets or sets the number of fractions for pie percentage values.
'min = 0  max = 2.
Public Sub getPiePercentageNbFractions As Int
	Return mPiePercentageNbFractions
End Sub

Public Sub setPiePercentageNbFractions(PiePercentageNbFractions As Int)
	mPiePercentageNbFractions = Max(PiePercentageNbFractions, 0)
	mPiePercentageNbFractions = Min(mPiePercentageNbFractions, 2)
End Sub

Public Sub setYZeroAxis (YZeroAxis As Boolean)
	Scale(sY(0)).YZeroAxis = YZeroAxis
	Scale(sY(1)).YZeroAxis = YZeroAxis
	Scale(sY(2)).YZeroAxis = YZeroAxis
	Scale(sY(3)).YZeroAxis = YZeroAxis
End Sub

Public Sub RemovePointData(Index As Int)
	Points.RemoveAt(Index)
End Sub

'Sets a custom numberformat for the bar mean line value, values like NumberFormat2.
'If set, it overides the default format.
'To go back to the default format, comment the line defining the custom number format.
Public Sub SetBarMeanValueFormat(MinimumIntegers As Int, MaximumFractions As Int, MinimumFractions As Int, GroupingUsed As Boolean)
	BMVNFUsed = True
	BMVNF.MinimumIntegers = MinimumIntegers
	BMVNF.MaximumFractions = MaximumFractions
	BMVNF.MinimumFractions = MinimumFractions
	BMVNF.GroupingUsed = GroupingUsed
End Sub

Public Sub getNbPoints As Int
	Return Points.Size
End Sub

'Returns a B4XBitmap object of the chart (read only)
Public Sub getSnapshot As B4XBitmap
	Return mBase.Snapshot
End Sub

'Gets the max number of displayable bars or group of bars.
'This method can be called before DrawChart to determine the number max of displayable bars.
'This can allow to adapt the filling routine according to the capacity of the chart.
Public Sub GetMaxNumberBars As Int
	Private MaxBars As Int
	Private MinWidth = 5dip As Int
	Private Margin = 0.02 * xpnlGraph.Width As Int
	
	InitChart
	MaxBars = (Graph.Width - Margin) / MinWidth - 1
	Return MaxBars
End Sub

