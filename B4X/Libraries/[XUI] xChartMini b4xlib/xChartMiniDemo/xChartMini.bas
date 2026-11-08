B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'xChartMini Custom View class
'This class is a mini version of the xChartLite class which is a lite version of the xChart class.
'
'Version 1.0 2023.03.06
'
'Written by Klaus CHRISTL (klaus)

#Event: CursorTouch (Action As Int, CursorPointIndex As Int)
#RaisesSynchronousEvents: CursorTouch (Action As Int, CursorPointIndex As Int)

#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Bar chart, Description: Chart title.
#DesignerProperty: Key: TitleTextColor, DisplayName: TitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Title text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: Subtitle, DisplayName: Subtitle, FieldType: String, DefaultValue: 
#DesignerProperty: Key: SubtitleTextColor, DisplayName: SubtitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Subtitle text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: XAxisName, DisplayName: XaxisName, FieldType: String, DefaultValue: X axis, Description: X axis name.
#DesignerProperty: Key: YAxisName, DisplayName: YaxisName, FieldType: String, DefaultValue: Y axis, Description: Y axis name.
#DesignerProperty: Key: YMaxValue, DisplayName: YMaxValue, FieldType: Int, DefaultValue: 100, Description: Max Y value manual scale.
#DesignerProperty: Key: YMinValue, DisplayName: YMinValue, FieldType: Int, DefaultValue: 0, Description: Min Y value manual scale.
#DesignerProperty: Key: YZeroAxis, DisplayName: YZeroAxis, FieldType: Boolean, DefaultValue: True, Description: Stes the min value to 0 if all values are > 0 and max valule to 0 if all values are <0.
#DesignerProperty: Key: NbYIntervals, DisplayName: NbYIntervals, FieldType: Int, DefaultValue: 10, Description: Number of Y intervals.
#DesignerProperty: Key: ChartType, DisplayName: ChartType, FieldType: String, DefaultValue: BAR, List: LINE|BAR|STACKED_BAR, Description: Selects the chart type.
#DesignerProperty: Key: ChartBackgroundColor, DisplayName: ChartBackgroundColor, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: Chart background color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridFrameColor, DisplayName: GridFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Grid frame color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridColor, DisplayName: GridColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Grid lines color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GradientColors, DisplayName: GradientColors, FieldType: Boolean, DefaultValue: True, Description: Use gradient or plain colors for bars.
#DesignerProperty: Key: GradientColorsAlpha, DisplayName: GradientColorsAlpha, FieldType: Int, DefaultValue: 96, MinRange: 0, MaxRange: 255, Description:  Gradient colors alpha value for bars.
#DesignerProperty: Key: AxisTextColor, DisplayName: AxisTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleTextColor, DisplayName: ScaleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Scale text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: DrawXScale, DisplayName: DrawXScale, FieldType: Boolean, DefaultValue: True, Description: Draws the X scale. Not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: DrawYScale, DisplayName: DrawYScale, FieldType: Boolean, DefaultValue: True, Description: Draws the Y scale. Not drawing the scale can be usefull for small charts. Not for logarithmic scales.
#DesignerProperty: Key: IncludeLegend, DisplayName: IncludeLegend, FieldType: String, DefaultValue: NONE, List: NONE|TOP_RIGHT|BOTTOM, Description: Include Legend. Select the position of the legend.
#DesignerProperty: Key: LegendBackgroundColor, DisplayName: LegendBackgroundColor, FieldType: Color, DefaultValue: 0x66FFFFFF, Description: Color of the legend background.
#DesignerProperty: Key: LegendTextColor, DisplayName: LegendTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the legend texts.
#DesignerProperty: Key: AutomaticScale, DisplayName: AutomaticScale, FieldType: Boolean, DefaultValue: True, Description: The scales for the Y axis are calulated automatically.
#DesignerProperty: Key: XScaleTextOrientation, DisplayName: XScaleTextOrientation, FieldType: String, DefaultValue: HORIZONTAL, List: HORIZONTAL|VERTICAL|45 DEGREES, Description: X scale text orientation.

Sub Class_Globals
	Type GraphDataM (Title As String, SubTitle As String, XAxisName As String, YAxisName As String, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, Radius As Float, CenterX As Int, CenterY As Int, Rect As B4XRect, YInterval As Int, XInterval As Int, XOffset As Int, BarWidth As Int, ChartType As String, BarSubWidth As Int, IncludeBarMeanLine As Boolean, IncludeValues As Boolean, ChartBackgroundColor As Int, GridFrameColor As Int, GridColor As Int, XScaleTextOrientation As String, GradientColors As Boolean, GradientColorsAlpha As Int, BarValueOrientation As String)
	Type PointDataM (X As String, XArray() As Double, YArray() As Double, ShowTick As Boolean)
	Type ItemDataM (Name As String, Color As Int, Value As Float, StrokeWidth As Int, DrawLine As Boolean, PointType As String, PointFilled As Boolean, PointColor As Int, YXArray As List)
	Type ScaleDataM (Scale As Double, MinVal As Double, MaxVal As Double, MinManu As Double, MaxManu As Double,	IntervalManu As Double, MinAuto As Double, MaxAuto As Double, IntervalAuto As Double, Interval As Double, NbIntervals As Int, Automatic As Boolean, Different As Boolean, Exp As Double, YZeroAxis As Boolean, ScaleValues As String, DrawXScale As Boolean, DrawYScale As Boolean)
	Type ScaleDataLogM(Scale As Double, MantMin As Int, MantMax As Int, LogMin As Double, LogMinIndex As Int, LogMax As Double, Logs() As Double, Vals() As Double, NbDecades As Int, ScaleValues As String, RadarScaleType As String)
	Type TextDataM (TitleFont As B4XFont, SubtitleFont As B4XFont, AxisFont As B4XFont, ScaleFont As B4XFont, AutomaticTextSizes As Boolean, TitleTextSize As Float, TitleTextColor As Int, SubTitleTextSize As Float, SubTitleTextColor As Int, TitleTextWidth As Int, SubtitleTextWidth As Int, AxisTextColor As Int, AxisTextSize As Float, ScaleTextSize As Float, ScaleTextColor As Int, TitleTextHeight As Int, SubTitleTextHeight As Int, AxisTextHeight As Int, ScaleTextHeight As Int)
	Type LegendDataM (IncludeLegend As String, TextFont As B4XFont, TextSize As Float, TextHeight As Int, TextColor As Int, Height As Int, LineNumber As Int, LineNumbers As List, LineChange As List, BackgroundColor As Int)

	Private xui As XUI
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Public Tag As Object
	
	Private xpnlGraph As B4XView
	Private xcvsGraph As B4XCanvas
	Private pthGrid As B4XPath
	
	Private NbMaxDifferentScales = 1 As Int
	Private Scale(NbMaxDifferentScales + 1) As ScaleDataM
	Private ScaleLog(NbMaxDifferentScales + 1) As ScaleDataLogM
	Private sX, sY(NbMaxDifferentScales) As Int
	Private BarWidth0 = False As Boolean
	Public Items As List
	Public Points As List
	Private Graph As GraphDataM
	Private Texts As TextDataM
	Private Legend As LegendDataM
	Private MinMaxMeanValues(3) As Double
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	sX = 0
	sY(0) = 1
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
		
	Scale(sY(0)).Initialize
	Scale(sX).Initialize
	Items.Initialize
	Points.Initialize
	Graph.Initialize
	Texts.Initialize
	Legend.Initialize
	
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
		Scale(sY(i)).Different = False	'no different scales
		Scale(sY(i)).DrawYScale = Props.GetDefault("DrawYScale", True)
		Scale(sY(i)).ScaleValues = Props.GetDefault("ScaleValues", "1!2!2.5!5!10")
	Next
	Scale(sX).DrawXScale = Props.GetDefault("DrawXScale", True)

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
	Texts.AxisTextColor = xui.PaintOrColorToColor(Props.GetDefault("AxisTextColor", xui.Color_Black))
	Legend.TextColor = xui.PaintOrColorToColor(Props.Get("LegendTextColor"))
	Legend.BackgroundColor = xui.PaintOrColorToColor(Props.Get("LegendBackgroundColor"))
	Graph.XScaleTextOrientation = Props.Get("XScaleTextOrientation")
	Legend.IncludeLegend = Props.GetDefault("IncludeLegend", "NONE")
	Legend.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", xui.Color_ARGB(102, 255, 255, 255)))
	Legend.TextColor = xui.PaintOrColorToColor(Props.GetDefault("LegendTextColor", xui.Color_Black))

	xpnlGraph = xui.CreatePanel("xpnlGraph")
	mBase.AddView(xpnlGraph, 0, 0, mBase.Width, mBase.Height)
	xcvsGraph.Initialize(xpnlGraph)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xpnlGraph.Width = Width
	xpnlGraph.Height = Height
	xcvsGraph.Resize(Width, Height)
	If Points.Size > 0 Then
		DrawChart
	End If
End Sub

Private Sub xpnlGraph_Touch (Action As Int, X As Float, Y As Float)
	If Action = xpnlGraph.TOUCH_ACTION_MOVE_NOTOUCH Then
		Return
	End If
	
	Private PointIndex As Int
	PointIndex = GetCursorIndex(X)

	If xui.SubExists(mCallBack, mEventName & "_CursorTouch", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_CursorTouch", Action, PointIndex)
	End If
End Sub

'adds a bar
'only for Bar and StackedBar charts !
Public Sub AddBar(Name As String, BarColor As Int)
	If Items.IsInitialized = False Then
		Items.Initialize
	End If
	
	Private ID As ItemDataM
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
	Dim PD As PointDataM
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
	Dim PD As PointDataM
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
	
	Dim ID As ItemDataM
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
	
	Dim ID As ItemDataM
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
	Private PD As PointDataM
	PD.Initialize
	PD.X = X
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
End Sub

'adds single line point data
'ShowTick = True displays the x value in the X axis
'only for Line charts !
Public Sub AddLinePointData (X As String, Y As Double, ShowTick As Boolean)
	If Points.IsInitialized = False Then Points.Initialize
	Dim PD As PointDataM
	PD.Initialize
	PD.X = X
	Private YArray(1) As Double
	YArray(0) = Y
	PD.YArray = YArray
	PD.ShowTick = ShowTick
	Points.Add(PD)
End Sub

Private Sub InitChart
	InitTextSizes
	
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	
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
		Graph.Right = xpnlGraph.Width - 1.5 * Texts.ScaleTextHeight - WidthXScale_2
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

	If Graph.ChartType = "BAR" Or Graph.ChartType = "STACKED_BAR" Then
		BarWidth0 = False
		Private PD As PointDataM = Points.Get(0)
		Private Margin = 0.02 * Graph.Width As Int
		Graph.XInterval = Floor((Graph.Width - Margin) / Points.Size) '???
		
		Private Space As Int
		If Graph.ChartType = "BAR" Or Graph.ChartType = "STACKED_BAR" Then
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
End Sub

'Initializes text sizes.
Private Sub InitTextSizes
	Private GraphSize As Int
	GraphSize = Min(xpnlGraph.Width, xpnlGraph.Height) / xui.Scale
	Texts.TitleTextSize = (1 + (GraphSize - 250)/1000) * 18
	Texts.SubtitleTextSize = (1 + (GraphSize - 250)/1000) * 16
	Texts.AxisTextSize = (1 + (GraphSize - 250)/1000) * 14
	Legend.TextSize = (1 + (GraphSize - 250)/1000) * 14
	Texts.ScaleTextSize = (1 + (GraphSize - 250)/1000) * 12

	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.AxisFont = xui.CreateDefaultFont(Texts.AxisTextSize)
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	Legend.TextFont = xui.CreateDefaultFont(Legend.TextSize)
	
	Texts.TitleTextHeight = MeasureTextHeight("Mg", Texts.TitleFont)
	Texts.SubtitleTextHeight = MeasureTextHeight("Mg", Texts.SubtitleFont)
	Texts.AxisTextHeight =  MeasureTextHeight("Mg", Texts.AxisFont)
	Texts.ScaleTextHeight =  MeasureTextHeight("Mg", Texts.ScaleFont)
	Legend.TextHeight =  MeasureTextHeight("Mg", Legend.TextFont)
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
				Private PD As PointDataM
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
				Private PD As PointDataM
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
					Private PD As PointDataM
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
					Private PD As PointDataM
					PD = Points.Get(i)
					YVals = PD.YArray
					For j = 0 To PD.YArray.Length - 1
						MMMValues(1) = Max(MMMValues(1), YVals(Axis - 1))
						MMMValues(0) = Min(MMMValues(0), YVals(Axis - 1))
						MMMValues(2) = MMMValues(2) + YVals(Axis - 1)
						NbPoints = NbPoints + 1
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
		Private PD As PointDataM
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
			DrawLines
		Case "BAR", "STACKED_BAR"
			DrawGrid
			DrawBars
	End Select
End Sub

'Draws the grid of a chart with the scales, titles and axis names.
Private Sub DrawGrid
	Private x1, y As Int
	
	xcvsGraph.ClearRect(xcvsGraph.TargetRect)
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.ChartBackgroundColor, True, 1dip)

		Scale(sY(0)).Scale = Graph.Height / (Scale(sY(0)).MaxVal - Scale(sY(0)).MinVal)
		DrawScaleY
	
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
	rctOuter.Initialize(0, 0, xpnlGraph.Width, xpnlGraph.Height)
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
		Private PD As PointDataM
			
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
		Private ID As ItemDataM
		Private lstCoords As List

		ID = Items.Get(l)
		lstCoords.Initialize
		For i = 0 To Points.Size - 1
			Private PD As PointDataM
			
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
		Private ID As ItemDataM
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
				Private PD As PointDataM
				Private ip As Int
			
				ip = i
				PD = Points.Get(i)
				Private py(PD.YArray.Length) As Double
				x0 = Graph.Left + Graph.XOffset + (ip + 0.5) * Graph.XInterval - Graph.BarWidth / 2
				py = PD.YArray

				For j = 0 To PD.YArray.Length - 1
					Private r, rb As B4XRect
					x = x0 + j * Graph.BarSubWidth
				
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
		Case "STACKED_BAR"
			Private mYAxis0 = Graph.Bottom As Int
	
			xcvsGraph.ClipPath(pthGrid)	'avoids drawing outsides the grid
			For i = 0 To Points.Size - 1
				Private PD As PointDataM
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

'gets the x intervals and x scale for LINE charts
Private Sub GetXIntervals
	Private I As Int
	
	Scale(sX).Scale = Graph.Width / (Points.Size - 1)
	
	For i = 0 To Points.Size - 1
		Private PD As PointDataM
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
	rct = xcvsGraph.MeasureText(Text, Font1)
	Return rct.Width
End Sub

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsGraph.MeasureText(Text, Font1)
	Return rct.Height
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
			For Each Item As ItemDataM In Items
				Private txt As String = Item.Name
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
			For Each Item As ItemDataM In Items
				Private top As Int = y + h * i
				r.Initialize(x, top + 0.5 * h - 0.65 * box, x + box, top + 0.5 * h + 0.35 * box)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
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
				Private Item As ItemDataM
				Item = Items.Get(i)
				y = y0 + Legend.TextHeight * Legend.LineNumbers.Get(i)
				Private txt As String = Item.Name
				If Legend.LineChange.Get(i) = True Then
					x = box
				End If

				r.Initialize(x, y - box, x + box, y)
				xcvsGraph.DrawRect(r, Item.Color, True, 0)
				Private txt As String = Item.Name
				
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

Private Sub GetCursorIndex(X As Float) As Int
	Private Index As Int

	Select Graph.ChartType
		Case "BAR", "STACKED_BAR"
			Index =(x - Graph.Left - Graph.XOffset) / Graph.XInterval
		Case "LINE"
			Index = (x - Graph.Left) / Scale(sX).Scale + 0.5
	End Select
	Index = Max(Index, 0)
	Index = Min(Index, Points.Size - 1)
	
	Return Index
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
		Private Item As ItemDataM
		Item = Items.Get(i)
		Private txt As String = Item.Name
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
			Private Item As ItemDataM
			Item = Items.Get(i)
			Private txt As String = Item.Name
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

'Sets the SubtitleTextColor property.
'The color must be an xui.Color.
'Example code: <code>xChart1.SubitleTextColor = xui.Color_Black</code>
Public Sub setSubtitleTextColor(Color As Int)
	Texts.SubtitleTextColor = Color
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
	Scale(sX).Automatic = AutomaticScale
End Sub

''Gets or sets the DifferentScales property, only for LINE charts.
''When True, displays the lines with different automatic scales for two up to four lines max.
''If the number of lines is 1 or bigger than 4, then all lines have the same scale.
'Public Sub getDifferentScales As Boolean
'	Return Scale(sY(0)).Different
'End Sub
'
'Public Sub setDifferentScales(DifferentScales As Boolean)
'	Scale(sY(0)).Different = DifferentScales
'End Sub

'Gets or sets the XScaleTextOrientation property
'Possible values: VERTICAL, HORIZONTAL, 45 DEGREES
Public Sub getXScaleTextOrientation As String
	Return Graph.XScaleTextOrientation
End Sub

Public Sub setXScaleTextOrientation(XScaleTextOrientation As String)
	Graph.XScaleTextOrientation = XScaleTextOrientation
End Sub

'Gets or sets the chart type
'Possible values: BAR, STACKED_BAR, LINE
Public Sub getChartType As String
	Return Graph.ChartType
End Sub

Public Sub setChartType(ChartType As String)
	If ChartType = "BAR" Or ChartType = "STACKED_BAR" Or ChartType = "LINE" Then
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
End Sub

'Gets or sets the GradientColors property
'Use gradient or plain colors for bars.
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

'Gets or sets the NbYIntervals property, number of Y axis intervals
'Should be an even number, otherwise the 0 scale value might not be displayed
Public Sub getNbYIntervals As Int
	Return Scale(sY(0)).NbIntervals
End Sub

Public Sub setNbYIntervals (NbYIntervals As Int)
	Scale(sY(0)).NbIntervals = NbYIntervals
End Sub

'Gets or sets the YZeroAxis property for LINE charts
'If all values are positives, sets the lower Y scale to zero
'If all values are negatives, sets the upper Y scale to zero
Public Sub getYZeroAxis As Boolean
	Return Scale(sY(0)).YZeroAxis
End Sub

Public Sub setYZeroAxis (YZeroAxis As Boolean)
	Scale(sY(0)).YZeroAxis = YZeroAxis
End Sub

Public Sub RemovePointData(Index As Int)
	Points.RemoveAt(Index)
End Sub

Public Sub getNbPoints As Int
	Return Points.Size
End Sub

'Returns a B4XBitmap object of the chart (read only)
Public Sub getSnapshot As B4XBitmap
	Return mBase.Snapshot
End Sub

'Gets the max number of displayable bars or group of bars.
'This method can be called before DrawChart to determine the number max of displayable bars, but the bar values must be known.
'This can allow to adapt the filling routine according to the capacity of the chart.
Public Sub GetMaxNumberBars As Int
	Private MaxBars As Int
	Private MinWidth = 5dip As Int
	Private Margin = 0.02 * xpnlGraph.Width As Int
	
	InitChart
	MaxBars = (Graph.Width - Margin) / MinWidth - 1
	Return MaxBars
End Sub

'Gets the max number of displayable bars or group of bars.
'This method can be called before DrawChart to determine the number max of displayable bars.
'This can allow to adapt the filling routine according to the capacity of the chart.
'Not as precise as GetMaxNumberBars.
Public Sub GetMaxNumberBars2 As Int
	Private MaxBars, MinItemWidth As Int
	
	InitTextSizes
	Graph.Left = MeasureTextWidth("-99999", Texts.ScaleFont) + 1.05 * Texts.ScaleTextHeight + 15dip'+ WidthXScale_2
'	If Graph.D
	Graph.Left = Graph.Left + Texts.AxisTextHeight * 1.8
	Graph.Right = xpnlGraph.Width - 1.5 * Texts.ScaleTextHeight '- WidthXScale_2 '???
	Graph.Width = Graph.Right - Graph.Left
	
	Private Margin = 0.02 * Graph.Width As Int
		
	Private Space As Int

	Space = 1dip
	If Graph.ChartType = "BAR" Then
		MinItemWidth = 4dip * Items.Size + Space
	Else
		MinItemWidth = 4dip + Space
	End If
	
	MaxBars = (Graph.Width - Margin) / MinItemWidth
	Return MaxBars
End Sub
