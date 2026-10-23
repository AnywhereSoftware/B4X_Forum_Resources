B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As StackedAreaClickResult)
#Event: ItemTouch (Result As StackedAreaTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Bandwidth Breakdown, Description: Main chart title text
#DesignerProperty: Key: TitleColor, DisplayName: Title Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the main title text
#DesignerProperty: Key: TitleSize, DisplayName: Title Size, FieldType: Int, DefaultValue: 16, MinRange: 8, MaxRange: 36, Description: Font size of main title
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: Usage by Protocol (Gbps), Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the sub-title text
#DesignerProperty: Key: SubTitleSize, DisplayName: SubTitle Size, FieldType: Int, DefaultValue: 12, MinRange: 8, MaxRange: 28, Description: Font size of sub-title
#DesignerProperty: Key: XAxisTitle, DisplayName: X-Axis Title, FieldType: String, DefaultValue: , Description: Title for the horizontal axis
#DesignerProperty: Key: YAxisTitle, DisplayName: Y-Axis Title, FieldType: String, DefaultValue: , Description: Title for the vertical axis
#DesignerProperty: Key: LabelTextColor, DisplayName: Label Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of axis text labels
#DesignerProperty: Key: LabelFontSize, DisplayName: Label Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 28, Description: Font size for labels
#DesignerProperty: Key: AxisColor, DisplayName: Axis Color, FieldType: Color, DefaultValue: 0xFF888888, Description: Color of axis lines
#DesignerProperty: Key: GridSteps, DisplayName: Grid Steps, FieldType: Int, DefaultValue: 4, MinRange: 2, MaxRange: 20, Description: Number of grid lines / value steps
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFE0E0E0, Description: Color of horizontal gridlines
#DesignerProperty: Key: Depth, DisplayName: 3D Depth, FieldType: Int, DefaultValue: 20, MinRange: 5, MaxRange: 100, Description: 3D thickness depth in dip
#DesignerProperty: Key: ShowLegend, DisplayName: Show Legend, FieldType: Boolean, DefaultValue: True, Description: Show the series legend at the bottom
#DesignerProperty: Key: ShowLegendOnChart, DisplayName: Show Legend On Chart, FieldType: Boolean, DefaultValue: False, Description: Show series legend on the top right-hand side of the chart area
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Show numeric value text over points
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of values text drawn on chart points
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched point
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when a point is touched
#DesignerProperty: Key: ShowPopupLegendTotal, DisplayName: Show Popup Legend Total, FieldType: Boolean, DefaultValue: False, Description: Show total value in the popup legend when a point is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type StackedAreaSeries (Name As String, Color As Int, Values As List)
	Type StackedXY (X As Float, Y As Float)
	Type StackedAreaClickResult (PointIndex As Int, CategoryLabel As String, StackValues As Map, StackSum As Float)
	Type StackedAreaTouchResult (PointIndex As Int, CategoryLabel As String, StackValues As Map, StackSum As Float)
	
	Private mDepth As Int
	
	' Titles & Text
	Private mTitle As String
	Private mSubTitle As String
	Private mXAxisTitle As String
	Private mYAxisTitle As String
	Private mTitleColor As Int
	Private mTitleSize As Int
	Private mSubTitleColor As Int
	Private mSubTitleSize As Int
	Private mAxisColor As Int
	Private mGridColor As Int
	Private mLabelTextColor As Int
	Private mLabelFontSize As Int
	Private mValueTextColor As Int
	Private mShowValues As Boolean
	Private mShowLegend As Boolean
	Private mShowLegendOnChart As Boolean
	Private mGridSteps As Int = 4
	Private mShowTouchLine As Boolean
	Private mTouchLineColor As Int
	Private mShowPopupLegend As Boolean
	Private mShowPopupLegendTotal As Boolean
	
	' Fonts
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontLabel As B4XFont
	Private fontAxisTitle As B4XFont
	
	Private SeriesList As List
	Private CategoriesList As List
	Private MaxValue As Float = 100
	Private mRawMaxValue As Float = 100
	Private MinValue As Float = 0
	
	Private TouchPanel As B4XView
	Private LastTouchedIndex As Int = -1
	
	' Performance optimizations: Caching and Array Re-use
	Type CachedSeriesColors (Base As Object, Side As Object, SideOutline As Object, FrontOutline As Object, TopRoof As Object, TopOutline As Object)
	Private SeriesColorsList As List
	Private CategoryTotals As List
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoly(0) As Double
	Private yPoly(0) As Double
	#End If
End Sub

' Initializes the chart manager object.
Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
	SeriesList.Initialize
	CategoriesList.Initialize
	SeriesColorsList.Initialize
	CategoryTotals.Initialize
	UpdateFonts
End Sub

' Restores configuration defaults pulled from the designer interface upon load.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	If SeriesList.IsInitialized = False Then SeriesList.Initialize
	If CategoriesList.IsInitialized = False Then CategoriesList.Initialize
	If SeriesColorsList.IsInitialized = False Then SeriesColorsList.Initialize
	If CategoryTotals.IsInitialized = False Then CategoryTotals.Initialize
	
	mDepth = DipToCurrent(Props.GetDefault("Depth", 20))
	
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mXAxisTitle = Props.GetDefault("XAxisTitle", "")
	mYAxisTitle = Props.GetDefault("YAxisTitle", "")
	mTitleColor = xui.PaintOrColorToColor(Props.GetDefault("TitleColor", xui.Color_Black))
	mTitleSize = Props.GetDefault("TitleSize", 16)
	
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	mSubTitleSize = Props.GetDefault("SubTitleSize", 12)
	
	mAxisColor = xui.PaintOrColorToColor(Props.GetDefault("AxisColor", 0xFF888888))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFE0E0E0))
	mLabelTextColor = xui.PaintOrColorToColor(Props.GetDefault("LabelTextColor", xui.Color_DarkGray))
	mLabelFontSize = Props.GetDefault("LabelFontSize", 11)
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_White))
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowLegend = Props.GetDefault("ShowLegend", True)
	mShowLegendOnChart = Props.GetDefault("ShowLegendOnChart", False)
	mGridSteps = Props.GetDefault("GridSteps", 4)
	mShowTouchLine = Props.GetDefault("ShowTouchLine", False)
	mTouchLineColor = xui.PaintOrColorToColor(Props.GetDefault("TouchLineColor", xui.Color_Red))
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	mShowPopupLegendTotal = Props.GetDefault("ShowPopupLegendTotal", False)
	
	UpdateFonts
	cvs.Initialize(mBase)
	
	TouchPanel = xui.CreatePanel("p")
	TouchPanel.Color = xui.Color_Transparent
	#If B4J
	Dim jo As JavaObject = TouchPanel
	jo.RunMethod("setPickOnBounds", Array(True))
	#End If
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	
	Base_Resize(mBase.Width, mBase.Height)
End Sub

#If B4J Or B4A
Private Sub p_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_DOWN Or Action = mBase.TOUCH_ACTION_MOVE Then
		HandleTouchMove(X, Y)
	Else If Action = mBase.TOUCH_ACTION_UP Then
		HandleClick(X, Y)
		If LastTouchedIndex <> -1 Then
			LastTouchedIndex = -1
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
			RequestRedraw
		End If
	End If
End Sub

Private Sub HandleTouchMove(touchX As Float, touchY As Float)
	Dim ptIdx As Int = GetCategoryIndexAt(touchX, touchY)
	If ptIdx <> LastTouchedIndex Then
		LastTouchedIndex = ptIdx
		If ptIdx >= 0 Then
			Dim res As StackedAreaTouchResult
			res.Initialize
			res.PointIndex = ptIdx
			If ptIdx < CategoriesList.Size Then
				res.CategoryLabel = CategoriesList.Get(ptIdx)
			Else
				res.CategoryLabel = ""
			End If
			res.StackValues.Initialize
			
			Dim stackSum As Float = 0
			For sIdx = 0 To SeriesList.Size - 1
				Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
				If ptIdx < s.Values.Size Then
					Dim val As Float = s.Values.Get(ptIdx)
					res.StackValues.Put(s.Name, val)
					stackSum = stackSum + val
				End If
			Next
			res.StackSum = stackSum
			
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", res)
			End If
		Else
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
		End If
		RequestRedraw
	End If
End Sub

Private Sub GetCategoryIndexAt(touchX As Float, touchY As Float) As Int
	If SeriesList.Size = 0 Or CategoriesList.Size = 0 Then Return -1
	
	Dim headerHeight As Float = DrawHeader
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim chartLeft As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim chartRight As Float = mBase.Width - 25dip - mDepth
	Dim chartTop As Float = headerHeight + 20dip + mDepth
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And CategoriesList.Size > 0 Then legendHeight = 30dip
	Dim chartBottom As Float = mBase.Height - (40dip + legendHeight)
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim count As Int = CategoriesList.Size
	If count < 2 Then Return -1
	Dim stepX As Float = chartWidth / (count - 1)
	
	If touchX < chartLeft - 10dip Or touchX > chartRight + mDepth + 10dip Then Return -1
	If touchY < chartTop - 10dip Or touchY > chartBottom + 30dip Then Return -1
	
	Dim closestPtIdx As Int = -1
	Dim minDistX As Float = 1000000
	
	For ptIdx = 0 To count - 1
		Dim px As Float = chartLeft + (ptIdx * stepX)
		Dim dx As Float = Abs(touchX - px)
		If dx < minDistX Then
			minDistX = dx
			closestPtIdx = ptIdx
		End If
	Next
	
	If closestPtIdx >= 0 And minDistX <= (stepX / 2) Then
		Return closestPtIdx
	End If
	
	Return -1
End Sub

Private Sub HandleClick(clickX As Float, clickY As Float)
	Dim ptIdx As Int = GetCategoryIndexAt(clickX, clickY)
	If ptIdx >= 0 Then
		Dim res As StackedAreaClickResult
		res.Initialize
		res.PointIndex = ptIdx
		If ptIdx < CategoriesList.Size Then
			res.CategoryLabel = CategoriesList.Get(ptIdx)
		Else
			res.CategoryLabel = ""
		End If
		res.StackValues.Initialize
		
		Dim stackSum As Float = 0
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			If ptIdx < s.Values.Size Then
				Dim val As Float = s.Values.Get(ptIdx)
				res.StackValues.Put(s.Name, val)
				stackSum = stackSum + val
			End If
		Next
		res.StackSum = stackSum
		
		If SubExists(mCallBack, mEventName & "_ItemClick") Then
			CallSub2(mCallBack, mEventName & "_ItemClick", res)
		End If
	End If
End Sub
#End If

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	#If B4J Or B4A
	If TouchPanel.IsInitialized Then
		TouchPanel.SetLayoutAnimated(0, 0, 0, Width, Height)
	End If
	#End If
	Redraw
End Sub

' Set the base view instance managing canvas elements.
Public Sub GetBase As B4XView
	Return mBase
End Sub

' Set the underlying reference object tag.
Public Sub getTag As Object
	Return mTag
End Sub

' Connects a reference tag to the control.
Public Sub setTag (vTag As Object)
	mTag = vTag
End Sub

Private Sub UpdateFonts
	fontTitle = xui.CreateDefaultBoldFont(mTitleSize)
	fontSubTitle = xui.CreateDefaultFont(mSubTitleSize)
	fontLabel = xui.CreateDefaultFont(mLabelFontSize)
	fontAxisTitle = xui.CreateDefaultBoldFont(mLabelFontSize)
End Sub

#If B4J
Private Sub GetFXColor(clr As Int) As Object
	Dim a As Double = Bit.UnsignedShiftRight(Bit.And(clr, 0xFF000000), 24) / 255.0
	Dim r As Double = Bit.UnsignedShiftRight(Bit.And(clr, 0x00FF0000), 16) / 255.0
	Dim g As Double = Bit.UnsignedShiftRight(Bit.And(clr, 0x0000FF00), 8) / 255.0
	Dim b As Double = Bit.And(clr, 0x000000FF) / 255.0
	Dim c As JavaObject
	Return c.InitializeStatic("javafx.scene.paint.Color").RunMethod("color", Array(r, g, b, a))
End Sub

Private Sub GetGraphicsContext As JavaObject
	Dim fxCanvas As JavaObject = mBase.GetView(0)
	Return fxCanvas.RunMethod("getGraphicsContext2D", Null)
End Sub

Private Sub EnsurePolyCapacity(Size As Int)
	If xPoly.Length < Size Then
		Dim newX(Size) As Double
		Dim newY(Size) As Double
		xPoly = newX
		yPoly = newY
	End If
End Sub
#End If

Private Sub MeasureMaxYLabelWidth As Float
	Dim maxWidth As Float = 0
	For i = 0 To mGridSteps
		Dim labelVal As Float = MinValue + i * ((MaxValue - MinValue) / mGridSteps)
		Dim labelTxt As String = NumberFormat(labelVal, 1, 0)
		Dim rect As B4XRect = cvs.MeasureText(labelTxt, fontLabel)
		If rect.Width > maxWidth Then maxWidth = rect.Width
	Next
	Return maxWidth
End Sub

' Sets the number of grid steps / value lines.
Public Sub setGridSteps(Steps As Int)
	mGridSteps = Max(2, Steps)
	RequestRedraw
End Sub

'' Set the number of grid steps / value lines.
'Public Sub getGridSteps As Int
'	Return mGridSteps
'End Sub

' Set the axis color.
Public Sub setAxisColor(Clr As Int)
	mAxisColor = Clr
	RequestRedraw
End Sub

'' Set the axis color.
'Public Sub getAxisColor As Int
'	Return mAxisColor
'End Sub

' Set the grid color.
Public Sub setGridColor(Clr As Int)
	mGridColor = Clr
	RequestRedraw
End Sub

'' Set the grid color.
'Public Sub getGridColor As Int
'	Return mGridColor
'End Sub

' Calculates the next logical nice maximum value above raw max for chart headroom.
Private Sub CalculateNiceMax(rawMax As Float, steps As Int) As Float
	If rawMax <= 0 Then Return 10.0
	If steps <= 0 Then steps = 4
	
	Dim roughStep As Float = rawMax / steps
	If roughStep <= 0 Then roughStep = 1.0
	
	Dim magnitude As Float = Power(10, Floor(Logarithm(roughStep, 10)))
	If magnitude = 0 Then magnitude = 1.0
	Dim normalized As Float = roughStep / magnitude
	Dim niceNormalized As Float
	
	If normalized <= 1.0 Then
		niceNormalized = 1.0
	Else if normalized <= 2.0 Then
		niceNormalized = 2.0
	Else if normalized <= 2.5 Then
		niceNormalized = 2.5
	Else if normalized <= 5.0 Then
		niceNormalized = 5.0
	Else
		niceNormalized = 10.0
	End If
	
	Dim stepSize As Float = niceNormalized * magnitude
	If stepSize <= 0 Then stepSize = 1.0
	
	Dim candidate As Float = Ceil(rawMax / stepSize) * stepSize
	If candidate <= rawMax Then
		candidate = candidate + stepSize
	End If
	Return candidate
End Sub

Private Sub RequestRedraw
	If Not(mRedrawPending) Then
		mRedrawPending = True
		CallSubDelayed(Me, "ProcessPendingRedraw")
	End If
End Sub

Private Sub ProcessPendingRedraw
	mRedrawPending = False
	Redraw
End Sub

' Sets chart specific 3D layering depth values.
Public Sub setDepth(DipVal As Int)
	mDepth = DipToCurrent(DipVal)
	RequestRedraw
End Sub

'' Set current chart specific 3D layer depth.
'Public Sub getDepth As Int
'	Return mDepth / xui.Scale
'End Sub

' Sets option indicating visual numerics should render inside the mapped zones.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

'' Set True when enabled.
'Public Sub getShowValues As Boolean
'	Return mShowValues
'End Sub

' Enables or disables displaying the series legend at the bottom of the chart.
Public Sub setShowLegend(Enabled As Boolean)
	mShowLegend = Enabled
	RequestRedraw
End Sub

'' Set if the legend block is rendered.
'Public Sub getShowLegend As Boolean
'	Return mShowLegend
'End Sub

' Sets whether displaying the series legend on the top right-hand side of the chart area is enabled.
Public Sub setShowLegendOnChart(Enabled As Boolean)
	mShowLegendOnChart = Enabled
	RequestRedraw
End Sub

'' Gets whether the series legend is displayed on the chart area.
'Public Sub getShowLegendOnChart As Boolean
'	Return mShowLegendOnChart
'End Sub

' Set whether a popup legend is displayed when a point is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	RequestRedraw
End Sub

'' Set whether the popup legend is enabled.
'Public Sub getShowPopupLegend As Boolean
'	Return mShowPopupLegend
'End Sub

' Set whether the total is displayed in the popup legend.
Public Sub setShowPopupLegendTotal(Enabled As Boolean)
	mShowPopupLegendTotal = Enabled
	RequestRedraw
End Sub

'' Set whether the popup legend total is enabled.
'Public Sub getShowPopupLegendTotal As Boolean
'	Return mShowPopupLegendTotal
'End Sub

' Enables or disables rendering a line through the touched point.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

'' Set if the touch line is displayed.
'Public Sub getShowTouchLine As Boolean
'	Return mShowTouchLine
'End Sub

' Sets the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

'' Set the touch line color.
'Public Sub getTouchLineColor As Int
'	Return mTouchLineColor
'End Sub

' Modifies drawing color corresponding to the text generated.
Public Sub setValueTextColor(Clr As Int)
	mValueTextColor = Clr
	RequestRedraw
End Sub

'' Sets current label rendering color target.
'Public Sub getValueTextColor As Int
'	Return mValueTextColor
'End Sub

' Sets the primary descriptive string layout text header.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

'' Set current top-level string layout header text.
'Public Sub getTitle As String
'	Return mTitle
'End Sub

' Sets secondary underlying description.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

'' Set the subordinate text format descriptor.
'Public Sub getSubTitle As String
'	Return mSubTitle
'End Sub

' Sets the string title located across X-axis bottom label.
Public Sub setXAxisTitle(Text As String)
	mXAxisTitle = Text
	RequestRedraw
End Sub

'' Sets the X-axis mapping text sequence title.
'Public Sub getXAxisTitle As String
'	Return mXAxisTitle
'End Sub

' Sets string header mapping directly adjacent the vertical values edge representation.
Public Sub setYAxisTitle(Text As String)
	mYAxisTitle = Text
	RequestRedraw
End Sub

'' Set mapping title currently assigned.
'Public Sub getYAxisTitle As String
'	Return mYAxisTitle
'End Sub

' Loads the underlying text mapping descriptors mapping sequentially against standard X inputs.
Public Sub SetCategories(Categories As List)
	CategoriesList.Clear
	CategoriesList.AddAll(Categories)
	RecalculateBounds
	RequestRedraw
End Sub

' Drops stored point sequences.
Public Sub Clear
	SeriesList.Clear
	CategoriesList.Clear
	SeriesColorsList.Clear
	CategoryTotals.Clear
	mRawMaxValue = 100
	MaxValue = 100
	MinValue = 0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

' Aggregates sequential mapping inputs combined over categories limits previously populated into internal mapping targets.
Public Sub AddSeries(SeriesName As String, Color As Int, Values As List)
	Dim s As StackedAreaSeries
	s.Initialize
	s.Name = SeriesName
	s.Color = Color
	s.Values.Initialize
	s.Values.AddAll(Values)
	SeriesList.Add(s)
	
	Dim csc As CachedSeriesColors
	csc.Initialize
	#If B4J
	csc.Base = GetFXColor(Color)
	csc.Side = GetFXColor(DarkenColor(Color, 0.75))
	csc.SideOutline = GetFXColor(DarkenColor(Color, 0.5))
	csc.FrontOutline = GetFXColor(DarkenColor(Color, 0.6))
	csc.TopRoof = GetFXColor(DarkenColor(Color, 0.8))
	csc.TopOutline = GetFXColor(DarkenColor(Color, 0.5))
	#Else
	csc.Base = Color
	csc.Side = DarkenColor(Color, 0.75)
	csc.SideOutline = DarkenColor(Color, 0.5)
	csc.FrontOutline = DarkenColor(Color, 0.6)
	csc.TopRoof = DarkenColor(Color, 0.8)
	csc.TopOutline = DarkenColor(Color, 0.5)
	#End If
	SeriesColorsList.Add(csc)
	
	Dim maxStackedV As Float = 0
	Dim maxLen As Int = Max(CategoriesList.Size, Values.Size)
	For i = 0 To maxLen - 1
		Dim current As Float = 0
		If i < CategoryTotals.Size Then current = CategoryTotals.Get(i)
		Dim added As Float = 0
		If i < Values.Size Then added = Values.Get(i)
		
		current = current + added
		
		If i < CategoryTotals.Size Then
			CategoryTotals.Set(i, current)
		Else
			CategoryTotals.Add(current)
		End If
		
		If current > maxStackedV Then maxStackedV = current
	Next
	
	mRawMaxValue = Max(10, maxStackedV)
	MaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	MinValue = 0
	
	RequestRedraw
End Sub

Private Sub RecalculateBounds 'ignore
	If SeriesList.Size = 0 Or CategoriesList.Size = 0 Then Return
	
	CategoryTotals.Clear
	Dim maxStackedV As Float = 0
	
	For ptIdx = 0 To CategoriesList.Size - 1
		Dim currentSum As Float = 0
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			If ptIdx < s.Values.Size Then
				currentSum = currentSum + s.Values.Get(ptIdx)
			End If
		Next
		CategoryTotals.Add(currentSum)
		If currentSum > maxStackedV Then maxStackedV = currentSum
	Next
	
	mRawMaxValue = Max(10, maxStackedV)
	MaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	MinValue = 0
End Sub

' Discards canvas target content and invokes redraw cycle mapped strictly against defined point coordinates values.
Public Sub Redraw
	cvs.ClearRect(cvs.TargetRect)
	
	Dim headerHeight As Float = DrawHeader
	If SeriesList.Size = 0 Or CategoriesList.Size = 0 Then
		cvs.Invalidate
		Return
	End If
	
	MaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim chartLeft As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim chartRight As Float = mBase.Width - 25dip - mDepth
	Dim chartTop As Float = headerHeight + 20dip + mDepth
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And CategoriesList.Size > 0 Then legendHeight = 30dip
	Dim chartBottom As Float = mBase.Height - (40dip + legendHeight)
	
	DrawGridAndAxes(chartLeft, chartRight, chartTop, chartBottom)
	Draw3DStackedArea(chartLeft, chartRight, chartTop, chartBottom)
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	
	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, chartLeft + (chartWidth / 2), chartBottom + 35dip, fontAxisTitle, mLabelTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, chartTop + (chartHeight / 2), fontAxisTitle, mLabelTextColor, "CENTER", -90)
	End If
	
	' Draw Bottom Legend
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then
		Dim legendY As Float = mBase.Height - 15dip
		Dim totalLegendWidth As Float = 0
		
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			Dim itemWidth As Float = 0
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			itemWidth = itemWidth + 12dip + 6dip + txtRect.Width
			
			totalLegendWidth = totalLegendWidth + itemWidth
			If sIdx < SeriesList.Size - 1 Then totalLegendWidth = totalLegendWidth + 20dip
		Next
		
		Dim currentX As Float = (mBase.Width / 2) - (totalLegendWidth / 2)
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			
			Dim r As B4XRect
			r.Initialize(currentX, legendY - 10dip, currentX + 12dip, legendY + 2dip)
			cvs.DrawRect(r, s.Color, True, 0)
			cvs.DrawRect(r, mLabelTextColor, False, 1dip)
			
			currentX = currentX + 12dip + 6dip
			cvs.DrawText(s.Name, currentX, legendY, fontLabel, mLabelTextColor, "LEFT")
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			currentX = currentX + txtRect.Width + 20dip
		Next
	End If
	
	' Draw On-Chart Legend (Top Right)
	If mShowLegend And mShowLegendOnChart And SeriesList.Size > 0 Then
		Dim seriesCount As Int = SeriesList.Size
		Dim maxTextW As Float = 0
		
		For sIdx = 0 To seriesCount - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			If txtRect.Width > maxTextW Then maxTextW = txtRect.Width
		Next
		
		Dim itemH As Float = fontLabel.Size + 8dip
		Dim boxWidth As Float = 12dip + 6dip + maxTextW + 16dip
		Dim boxHeight As Float = (seriesCount * itemH) + 12dip
		
		Dim boxLeft As Float = chartRight - boxWidth
		Dim boxTop As Float = chartTop + 4dip
		
		Dim rBox As B4XRect
		rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
		
		cvs.DrawRect(rBox, XUI.Color_ARGB(192, 255, 255, 255), True, 0)
		cvs.DrawRect(rBox, mGridColor, False, 1dip)
		
		Dim currentItemY As Float = boxTop + 6dip
		#If B4A
		Dim textBaselineOffset As Float = fontLabel.Size / 2.5
		#Else
		Dim textBaselineOffset As Float = fontLabel.Size / 3
		#End If
		
		For sIdx = 0 To seriesCount - 1
			Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
			
			Dim rColorBox As B4XRect
			rColorBox.Initialize(boxLeft + 8dip, currentItemY + 2dip, boxLeft + 8dip + 12dip, currentItemY + 12dip)
			cvs.DrawRect(rColorBox, s.Color, True, 0)
			cvs.DrawRect(rColorBox, mLabelTextColor, False, 1dip)
			
			Dim textX As Float = boxLeft + 8dip + 12dip + 6dip
			Dim textY As Float = currentItemY + (itemH / 2)
			
			cvs.DrawText(s.Name, textX, textY + textBaselineOffset, fontLabel, mLabelTextColor, "LEFT")
			
			currentItemY = currentItemY + itemH
		Next
	End If
	
	cvs.Invalidate
End Sub

Private Sub DrawHeader As Float
	Dim currentY As Float = 10dip
	Dim cx As Float = mBase.Width / 2
	
	If mTitle <> "" Then
		cvs.DrawText(mTitle, cx, currentY + 14dip, fontTitle, mTitleColor, "CENTER")
		currentY = currentY + 22dip
	End If
	
	If mSubTitle <> "" Then
		cvs.DrawText(mSubTitle, cx, currentY + 10dip, fontSubTitle, mSubTitleColor, "CENTER")
		currentY = currentY + 18dip
	End If
	
	Return currentY
End Sub

Private Sub DrawGridAndAxes(chartLeft As Float, chartRight As Float, chartTop As Float, chartBottom As Float)
	Dim chartHeight As Float = chartBottom - chartTop
	
	For i = 0 To mGridSteps
		Dim yVal As Float = chartBottom - (i * (chartHeight / mGridSteps))
		cvs.DrawLine(chartLeft, yVal, chartRight + mDepth, yVal, mGridColor, 1dip)
		
		Dim labelVal As Float = MinValue + i * ((MaxValue - MinValue) / mGridSteps)
		Dim labelTxt As String = NumberFormat(labelVal, 1, 0)
		cvs.DrawText(labelTxt, chartLeft - 6dip, yVal + (mLabelFontSize / 3), fontLabel, mLabelTextColor, "RIGHT")
	Next
	
	cvs.DrawLine(chartLeft, chartTop, chartLeft, chartBottom, mAxisColor, 1.5dip)
	cvs.DrawLine(chartLeft, chartBottom, chartRight + mDepth, chartBottom, mAxisColor, 1.5dip)
End Sub

#If B4J
Private Sub Draw3DStackedArea(chartLeft As Float, chartRight As Float, chartTop As Float, chartBottom As Float)
	Dim count As Int = CategoriesList.Size
	If count < 2 Or SeriesList.Size = 0 Then Return
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	Dim stepX As Float = chartWidth / (count - 1)
	
	Dim topX(SeriesList.Size, count) As Double
	Dim topY(SeriesList.Size, count) As Double
	Dim botX(SeriesList.Size, count) As Double
	Dim botY(SeriesList.Size, count) As Double
	
	Dim accumulated(count) As Float
	For i = 0 To count - 1
		accumulated(i) = 0
	Next
	
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
		For i = 0 To count - 1
			Dim val As Float = 0
			If i < s.Values.Size Then val = s.Values.Get(i)
			
			Dim prevAcc As Float = accumulated(i)
			Dim newAcc As Float = prevAcc + val
			accumulated(i) = newAcc
			
			Dim prevRatio As Float = prevAcc / Max(1, MaxValue)
			Dim newRatio As Float = newAcc / Max(1, MaxValue)
			
			topX(sIdx, i) = chartLeft + (i * stepX)
			topY(sIdx, i) = chartBottom - (newRatio * chartHeight)
			
			botX(sIdx, i) = topX(sIdx, i)
			botY(sIdx, i) = chartBottom - (prevRatio * chartHeight)
		Next
	Next
	
	Dim gc As JavaObject = GetGraphicsContext
	EnsurePolyCapacity(count * 2)
	
	' 1. Top Surface Roof Quad (Rendered once across the peak series profile)
	Dim topSIdx As Int = SeriesList.Size - 1
	Dim cscTop As CachedSeriesColors = SeriesColorsList.Get(topSIdx)
	
	gc.RunMethod("setLineWidth", Array(0.5 * xui.Scale))
	gc.RunMethod("setFill", Array(cscTop.TopRoof))
	gc.RunMethod("setStroke", Array(cscTop.TopOutline))
	
	For i = 0 To count - 2
		xPoly(0) = topX(topSIdx, i)
		yPoly(0) = topY(topSIdx, i)
		xPoly(1) = topX(topSIdx, i + 1)
		yPoly(1) = topY(topSIdx, i + 1)
		xPoly(2) = topX(topSIdx, i + 1) + mDepth
		yPoly(2) = topY(topSIdx, i + 1) - (mDepth * 0.5)
		xPoly(3) = topX(topSIdx, i) + mDepth
		yPoly(3) = topY(topSIdx, i) - (mDepth * 0.5)
		
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, 4))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, 4))
	Next
	
	' 2. Right Side Cap Profile (Side wall extrusions per series layer)
	Dim lastIdx As Int = count - 1
	For sIdx = 0 To SeriesList.Size - 1
		Dim cscSide As CachedSeriesColors = SeriesColorsList.Get(sIdx)
		
		gc.RunMethod("setFill", Array(cscSide.Side))
		gc.RunMethod("setStroke", Array(cscSide.SideOutline))
		
		xPoly(0) = topX(sIdx, lastIdx)
		yPoly(0) = topY(sIdx, lastIdx)
		xPoly(1) = topX(sIdx, lastIdx) + mDepth
		yPoly(1) = topY(sIdx, lastIdx) - (mDepth * 0.5)
		xPoly(2) = botX(sIdx, lastIdx) + mDepth
		yPoly(2) = botY(sIdx, lastIdx) - (mDepth * 0.5)
		xPoly(3) = botX(sIdx, lastIdx)
		yPoly(3) = botY(sIdx, lastIdx)
		
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, 4))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, 4))
	Next
	
	' 3. Front Solid Area Faces (Rendered bottom to top)
	gc.RunMethod("setLineWidth", Array(1.0 * xui.Scale))
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
		Dim cscFront As CachedSeriesColors = SeriesColorsList.Get(sIdx)
		
		gc.RunMethod("setFill", Array(cscFront.Base))
		gc.RunMethod("setStroke", Array(cscFront.FrontOutline))
		
		Dim pCount As Int = 0
		For i = 0 To count - 1
			xPoly(pCount) = topX(sIdx, i)
			yPoly(pCount) = topY(sIdx, i)
			pCount = pCount + 1
		Next
		For i = count - 1 To 0 Step -1
			xPoly(pCount) = botX(sIdx, i)
			yPoly(pCount) = botY(sIdx, i)
			pCount = pCount + 1
		Next
		
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, pCount))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, pCount))
		
		' Value Text Overlay
		If mShowValues Then
			For i = 0 To count - 1
				Dim val As Float = 0
				If i < s.Values.Size Then val = s.Values.Get(i)
				Dim midY As Float = topY(sIdx, i) + ((botY(sIdx, i) - topY(sIdx, i)) / 2)
				If i = 0 Then
					cvs.DrawText(NumberFormat(val, 1, 0), topX(sIdx, i) + 4dip, midY + (mLabelFontSize / 3), fontLabel, mValueTextColor, "LEFT")
				Else
					cvs.DrawText(NumberFormat(val, 1, 0), topX(sIdx, i), midY + (mLabelFontSize / 3), fontLabel, mValueTextColor, "CENTER")
				End If
			Next
		End If
	Next
	
	' X Axis Categories Labels
	For i = 0 To count - 1
		Dim catTxt As String = CategoriesList.Get(i)
		Dim px As Float = chartLeft + (i * stepX)
		cvs.DrawText(catTxt, px, chartBottom + 18dip, fontLabel, mLabelTextColor, "CENTER")
	Next
	
	' Render Touch Line over the active touched point
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim touchX As Float = chartLeft + (LastTouchedIndex * stepX)
		cvs.DrawLine(touchX, chartTop, touchX, chartBottom, mTouchLineColor, 2dip)
		
		If mShowPopupLegend And SeriesList.Size > 0 Then
			Dim lines As List
			lines.Initialize
			Dim catLabel As String = CategoriesList.Get(LastTouchedIndex)
			Dim stackSum As Float = 0
			For sIdx = 0 To SeriesList.Size - 1
				Dim sTouch As StackedAreaSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < sTouch.Values.Size Then
					stackSum = stackSum + sTouch.Values.Get(LastTouchedIndex)
				End If
			Next
			
			lines.Add(catLabel)
			For sIdx = 0 To SeriesList.Size - 1
				Dim sTouch As StackedAreaSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < sTouch.Values.Size Then
					lines.Add(sTouch.Name & ": " & NumberFormat(sTouch.Values.Get(LastTouchedIndex), 1, 0))
				End If
			Next
			If mShowPopupLegendTotal Then
				lines.Add("Total: " & NumberFormat(stackSum, 1, 0))
			End If
			
			Dim maxW As Float = 0
			Dim lineH As Float = 0
			For Each lineText As String In lines
				Dim rText As B4XRect = cvs.MeasureText(lineText, fontLabel)
				If rText.Width > maxW Then maxW = rText.Width
				If rText.Height > lineH Then lineH = rText.Height
			Next
			lineH = lineH + 6dip
			
			Dim boxLeft As Float = chartLeft + 4dip
			Dim boxTop As Float = chartTop + 4dip
			Dim boxWidth As Float = maxW + 16dip
			Dim boxHeight As Float = (lines.Size * lineH) + 8dip
			
			Dim rBox As B4XRect
			rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
			
			cvs.DrawRect(rBox, xui.Color_ARGB(192, 255, 255, 255), True, 0)
			cvs.DrawRect(rBox, mGridColor, False, 1dip)
			
			Dim currentTextY As Float = boxTop + 6dip + (lineH / 2)
			For Each lineText As String In lines
				cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + (fontLabel.Size / 3), fontLabel, mLabelTextColor, "LEFT")
				currentTextY = currentTextY + lineH
			Next
		End If
	End If
End Sub
#Else
Private Sub Draw3DStackedArea(chartLeft As Float, chartRight As Float, chartTop As Float, chartBottom As Float)
	Dim count As Int = CategoriesList.Size
	If count < 2 Or SeriesList.Size = 0 Then Return
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	Dim stepX As Float = chartWidth / (count - 1)
	
	Dim accumulated(count) As Float
	For i = 0 To count - 1
		accumulated(i) = 0
	Next
	
	Dim allTopPoints(SeriesList.Size, count) As StackedXY
	Dim allBotPoints(SeriesList.Size, count) As StackedXY
	
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
		For i = 0 To count - 1
			Dim val As Float = s.Values.Get(i)
			Dim prevAcc As Float = accumulated(i)
			Dim newAcc As Float = prevAcc + val
			accumulated(i) = newAcc
			
			Dim prevRatio As Float = prevAcc / Max(1, MaxValue)
			Dim newRatio As Float = newAcc / Max(1, MaxValue)
			
			allTopPoints(sIdx, i).Initialize
			allTopPoints(sIdx, i).X = chartLeft + (i * stepX)
			allTopPoints(sIdx, i).Y = chartBottom - (newRatio * chartHeight)
			
			allBotPoints(sIdx, i).Initialize
			allBotPoints(sIdx, i).X = allTopPoints(sIdx, i).X
			allBotPoints(sIdx, i).Y = chartBottom - (prevRatio * chartHeight)
		Next
	Next
	
	' 1. Top Surface Roof Quad (Rendered once across the peak series profile)
	Dim topSIdx As Int = SeriesList.Size - 1
	Dim topSeries As StackedAreaSeries = SeriesList.Get(topSIdx)
	Dim topRoofColor As Int = DarkenColor(topSeries.Color, 0.8)
	Dim outlineColor As Int = DarkenColor(topSeries.Color, 0.5)
	
	For i = 0 To count - 2
		Dim pTop As B4XPath
		pTop.Initialize(allTopPoints(topSIdx, i).X, allTopPoints(topSIdx, i).Y)
		pTop.LineTo(allTopPoints(topSIdx, i + 1).X, allTopPoints(topSIdx, i + 1).Y)
		pTop.LineTo(allTopPoints(topSIdx, i + 1).X + mDepth, allTopPoints(topSIdx, i + 1).Y - (mDepth * 0.5))
		pTop.LineTo(allTopPoints(topSIdx, i).X + mDepth, allTopPoints(topSIdx, i).Y - (mDepth * 0.5))
		cvs.DrawPath(pTop, topRoofColor, True, 0)
		cvs.DrawPath(pTop, outlineColor, False, 0.5dip)
	Next
	
	' 2. Right Side Cap Profile (Side wall extrusions per series layer)
	Dim lastIdx As Int = count - 1
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
		Dim sideColor As Int = DarkenColor(s.Color, 0.75)
		Dim sideOutline As Int = DarkenColor(s.Color, 0.5)
		
		Dim pRight As B4XPath
		pRight.Initialize(allTopPoints(sIdx, lastIdx).X, allTopPoints(sIdx, lastIdx).Y)
		pRight.LineTo(allTopPoints(sIdx, lastIdx).X + mDepth, allTopPoints(sIdx, lastIdx).Y - (mDepth * 0.5))
		pRight.LineTo(allBotPoints(sIdx, lastIdx).X + mDepth, allBotPoints(sIdx, lastIdx).Y - (mDepth * 0.5))
		pRight.LineTo(allBotPoints(sIdx, lastIdx).X, allBotPoints(sIdx, lastIdx).Y)
		cvs.DrawPath(pRight, sideColor, True, 0)
		cvs.DrawPath(pRight, sideOutline, False, 0.5dip)
	Next
	
	' 3. Front Solid Area Faces (Rendered bottom to top)
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As StackedAreaSeries = SeriesList.Get(sIdx)
		Dim frontOutline As Int = DarkenColor(s.Color, 0.6)
		
		Dim pFront As B4XPath
		pFront.Initialize(allTopPoints(sIdx, 0).X, allTopPoints(sIdx, 0).Y)
		For i = 1 To count - 1
			pFront.LineTo(allTopPoints(sIdx, i).X, allTopPoints(sIdx, i).Y)
		Next
		For i = count - 1 To 0 Step -1
			pFront.LineTo(allBotPoints(sIdx, i).X, allBotPoints(sIdx, i).Y)
		Next
		cvs.DrawPath(pFront, s.Color, True, 0)
		cvs.DrawPath(pFront, frontOutline, False, 1dip)
		
		' Value Text Overlay
		If mShowValues Then
			For i = 0 To count - 1
				Dim val As Float = s.Values.Get(i)
				Dim midY As Float = allTopPoints(sIdx, i).Y + ((allBotPoints(sIdx, i).Y - allTopPoints(sIdx, i).Y) / 2)
				If i = 0 Then
					cvs.DrawText(NumberFormat(val, 1, 0), allTopPoints(sIdx, i).X + 4dip, midY + (mLabelFontSize / 3), fontLabel, mValueTextColor, "LEFT")
				Else
					cvs.DrawText(NumberFormat(val, 1, 0), allTopPoints(sIdx, i).X, midY + (mLabelFontSize / 3), fontLabel, mValueTextColor, "CENTER")
				End If
			Next
		End If
	Next
	
	' X Axis Categories Labels
	For i = 0 To count - 1
		Dim catTxt As String = CategoriesList.Get(i)
		Dim px As Float = chartLeft + (i * stepX)
		cvs.DrawText(catTxt, px, chartBottom + 18dip, fontLabel, mLabelTextColor, "CENTER")
	Next
	
	' Render Touch Line over the active touched point
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim touchX As Float = chartLeft + (LastTouchedIndex * stepX)
		cvs.DrawLine(touchX, chartTop, touchX, chartBottom, mTouchLineColor, 2dip)
		
		If mShowPopupLegend And SeriesList.Size > 0 Then
			Dim lines As List
			lines.Initialize
			Dim catLabel As String = CategoriesList.Get(LastTouchedIndex)
			Dim stackSum As Float = 0
			For sIdx = 0 To SeriesList.Size - 1
				Dim sTouch As StackedAreaSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < sTouch.Values.Size Then
					stackSum = stackSum + sTouch.Values.Get(LastTouchedIndex)
				End If
			Next
			
			lines.Add(catLabel)
			For sIdx = 0 To SeriesList.Size - 1
				Dim sTouch As StackedAreaSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < sTouch.Values.Size Then
					lines.Add(sTouch.Name & ": " & NumberFormat(sTouch.Values.Get(LastTouchedIndex), 1, 0))
				End If
			Next
			If mShowPopupLegendTotal Then
				lines.Add("Total: " & NumberFormat(stackSum, 1, 0))
			End If
			
			Dim maxW As Float = 0
			Dim lineH As Float = 0
			For Each lineText As String In lines
				Dim rText As B4XRect = cvs.MeasureText(lineText, fontLabel)
				If rText.Width > maxW Then maxW = rText.Width
				If rText.Height > lineH Then lineH = rText.Height
			Next
			lineH = lineH + 6dip
			
			Dim boxLeft As Float = chartLeft + 4dip
			Dim boxTop As Float = chartTop + 4dip
			Dim boxWidth As Float = maxW + 16dip
			Dim boxHeight As Float = (lines.Size * lineH) + 8dip
			
			Dim rBox As B4XRect
			rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
			
			cvs.DrawRect(rBox, XUI.Color_ARGB(192, 255, 255, 255), True, 0)
			cvs.DrawRect(rBox, mGridColor, False, 1dip)
			
			Dim currentTextY As Float = boxTop + 6dip + (lineH / 2)
			For Each lineText As String In lines
				cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + (fontLabel.Size / 3), fontLabel, mLabelTextColor, "LEFT")
				currentTextY = currentTextY + lineH
			Next
		End If
	End If
End Sub
#End If

Private Sub DarkenColor(clr As Int, factor As Float) As Int
	Dim argb() As Int = GetARGB(clr)
	Return xui.Color_ARGB(argb(0), argb(1) * factor, argb(2) * factor, argb(3) * factor)
End Sub

Private Sub GetARGB(clr As Int) As Int()
	Dim a As Int = Bit.UnsignedShiftRight(Bit.And(clr, 0xFF000000), 24)
	Dim r As Int = Bit.UnsignedShiftRight(Bit.And(clr, 0x00FF0000), 16)
	Dim g As Int = Bit.And(clr, 0x0000FF00) / 256
	Dim b As Int = Bit.And(clr, 0x000000FF)
	Return Array As Int(a, r, g, b)
End Sub

' Takes a full snapshot of the custom view chart and returns a B4XBitmap.
Public Sub Snapshot As B4XBitmap
	#If B4J
	Dim joBase As JavaObject = mBase
	Dim snapParams As JavaObject
	snapParams.InitializeNewInstance("javafx.scene.SnapshotParameters", Null)
	
	Dim transform As JavaObject
	transform.InitializeStatic("javafx.scene.transform.Transform")
	' Scale the snapshot by 8x to ensure the printout is sharp
	Dim scale As JavaObject = transform.RunMethod("scale", Array(8.0, 8.0))
	snapParams.RunMethod("setTransform", Array(scale))
	
	Return joBase.RunMethod("snapshot", Array(snapParams, Null))
	#Else
	Return mBase.Snapshot
	#End If
End Sub
