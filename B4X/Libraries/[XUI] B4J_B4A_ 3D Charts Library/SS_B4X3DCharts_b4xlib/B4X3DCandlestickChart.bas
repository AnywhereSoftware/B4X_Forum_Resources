B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As CandleClickResult)
#Event: ItemTouch (Result As CandleTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Stock Price Chart, Description: Main chart title text
#DesignerProperty: Key: TitleColor, DisplayName: Title Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the main title text
#DesignerProperty: Key: TitleSize, DisplayName: Title Size, FieldType: Int, DefaultValue: 16, MinRange: 8, MaxRange: 36, Description: Font size for main title
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: 3D OHLC Daily Candlesticks, Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the sub-title text
#DesignerProperty: Key: SubTitleSize, DisplayName: SubTitle Size, FieldType: Int, DefaultValue: 12, MinRange: 8, MaxRange: 28, Description: Font size for sub-title
#DesignerProperty: Key: XAxisTitle, DisplayName: X-Axis Title, FieldType: String, DefaultValue: , Description: Title for the horizontal axis
#DesignerProperty: Key: YAxisTitle, DisplayName: Y-Axis Title, FieldType: String, DefaultValue: , Description: Title for the vertical axis
#DesignerProperty: Key: LabelTextColor, DisplayName: Label Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of price and date labels
#DesignerProperty: Key: LabelFontSize, DisplayName: Label Size, FieldType: Int, DefaultValue: 10, MinRange: 8, MaxRange: 24, Description: Font size for axis labels
#DesignerProperty: Key: AxisColor, DisplayName: Axis Color, FieldType: Color, DefaultValue: 0xFF888888, Description: Color of axis lines
#DesignerProperty: Key: GridSteps, DisplayName: Grid Steps, FieldType: Int, DefaultValue: 4, MinRange: 2, MaxRange: 20, Description: Number of horizontal grid steps
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFE0E0E0, Description: Color of horizontal grid lines
#DesignerProperty: Key: Depth, DisplayName: 3D Depth, FieldType: Int, DefaultValue: 12, MinRange: 4, MaxRange: 40, Description: 3D depth scale in dip
#DesignerProperty: Key: BullishColor, DisplayName: Bullish Color, FieldType: Color, DefaultValue: 0xFF26A69A, Description: Color for upward price candles (Close >= Open)
#DesignerProperty: Key: BearishColor, DisplayName: Bearish Color, FieldType: Color, DefaultValue: 0xFFEF5350, Description: Color for downward price candles (Close < Open)
#DesignerProperty: Key: WickColorMode, DisplayName: Wick Color Mode, FieldType: String, DefaultValue: SameAsCandle, List: SameAsCandle|Gray, Description: Choose whether wicks match the candle color or use gray
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched candle
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when a candle is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object

	Type CandleData (OpenVal As Float, HighVal As Float, LowVal As Float, CloseVal As Float, DateLabel As String)
	Type CandlePoint3D (X As Float, Y As Float)
	Type CandleClickResult (Index As Int, DateLabel As String, OpenVal As Float, CloseVal As Float, HighVal As Float, LowVal As Float)
	Type CandleTouchResult (Index As Int, DateLabel As String, OpenVal As Float, CloseVal As Float, HighVal As Float, LowVal As Float)
	
	' Properties
	Private mDepth As Int
	Private mWickColorMode As String = "SameAsCandle"
	Private mTitle As String
	Private mSubTitle As String
	Private mXAxisTitle As String
	Private mYAxisTitle As String
	Private mBullishColor As Int
	Private mBearishColor As Int
	Private mGridColor As Int
	Private mAxisColor As Int
	Private mLabelTextColor As Int
	Private mTitleColor As Int
	Private mSubTitleColor As Int
	Private mTitleSize As Int
	Private mSubTitleSize As Int
	Private mLabelFontSize As Int
	Private mShowTouchLine As Boolean
	Private mTouchLineColor As Int
	Private mGridSteps As Int = 4
	Private mShowPopupLegend As Boolean
	
	' Fonts
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontLabel As B4XFont
	Private fontAxisTitle As B4XFont
	
	' Data
	Private CandleList As List
	Private MaxPrice As Float = 100
	Private MinPrice As Float = 0
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	#End If
	Private LastTouchedIndex As Int = -1
	
	
	' Performance optimizations: Caching and Array Re-use
	Private RawMaxPrice As Float = 100
	Private RawMinPrice As Float = 0
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoints(4) As Double
	Private yPoints(4) As Double
	Private cachedBullishTop As Object
	Private cachedBullishSide As Object
	Private cachedBullishBase As Object
	Private cachedBullishOutline As Object
	Private cachedBullishUpperWick As Object
	Private cachedBullishLowerWick As Object
	Private cachedBearishTop As Object
	Private cachedBearishSide As Object
	Private cachedBearishBase As Object
	Private cachedBearishOutline As Object
	Private cachedBearishUpperWick As Object
	Private cachedBearishLowerWick As Object
	#End If
End Sub

' Initialises the chart object and sets up underlying data structures.
Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
	CandleList.Initialize
	UpdateFonts
	UpdateCachedColors
End Sub

' Called by the designer to draw the view using custom properties.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	If CandleList.IsInitialized = False Then CandleList.Initialize
	
	mDepth = DipToCurrent(Props.GetDefault("Depth", 12))
	mWickColorMode = Props.GetDefault("WickColorMode", "SameAsCandle")
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mXAxisTitle = Props.GetDefault("XAxisTitle", "")
	mYAxisTitle = Props.GetDefault("YAxisTitle", "")
	
	mBullishColor = xui.PaintOrColorToColor(Props.GetDefault("BullishColor", 0xFF26A69A))
	mBearishColor = xui.PaintOrColorToColor(Props.GetDefault("BearishColor", 0xFFEF5350))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFE0E0E0))
	mAxisColor = xui.PaintOrColorToColor(Props.GetDefault("AxisColor", 0xFF888888))
	mLabelTextColor = xui.PaintOrColorToColor(Props.GetDefault("LabelTextColor", xui.Color_DarkGray))
	mTitleColor = xui.PaintOrColorToColor(Props.GetDefault("TitleColor", xui.Color_Black))
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	
	mTitleSize = Props.GetDefault("TitleSize", 16)
	mSubTitleSize = Props.GetDefault("SubTitleSize", 12)
	mLabelFontSize = Props.GetDefault("LabelFontSize", 10)
	mShowTouchLine = Props.GetDefault("ShowTouchLine", False)
	mTouchLineColor = xui.PaintOrColorToColor(Props.GetDefault("TouchLineColor", xui.Color_Red))
	mGridSteps = Props.GetDefault("GridSteps", 4)
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	
	UpdateFonts
	UpdateCachedColors
	cvs.Initialize(mBase)
	
	#If B4J Or B4A
	TouchPanel = xui.CreatePanel("p")
	TouchPanel.Color = xui.Color_Transparent
	#If B4J
	Dim jo As JavaObject = TouchPanel
	jo.RunMethod("setPickOnBounds", Array(True))
	#End If
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	#End If
	
	Base_Resize(mBase.Width, mBase.Height)
End Sub

#If B4J Or B4A
Private Sub p_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_DOWN Or Action = mBase.TOUCH_ACTION_MOVE Then
		HandleTouchMove(X)
	Else If Action = mBase.TOUCH_ACTION_UP Then
		HandleClick(X)
		If LastTouchedIndex <> -1 Then
			LastTouchedIndex = -1
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
			Redraw
		End If
	End If
End Sub

Private Sub HandleTouchMove(touchX As Float)
	Dim foundPoint As Int = -1
	If CandleList.Size > 0 Then
		foundPoint = GetCandleIndexAtTouch(touchX)
	End If
	
	If foundPoint <> LastTouchedIndex Then
		LastTouchedIndex = foundPoint
		If foundPoint >= 0 Then
			Dim cd As CandleData = CandleList.Get(foundPoint)
			Dim res As CandleTouchResult
			res.Initialize
			res.Index = foundPoint
			res.DateLabel = cd.DateLabel
			res.OpenVal = cd.OpenVal
			res.CloseVal = cd.CloseVal
			res.HighVal = cd.HighVal
			res.LowVal = cd.LowVal
			
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", res)
			End If
		Else
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
		End If
		Redraw
	End If
End Sub

Private Sub GetCandleIndexAtTouch(touchX As Float) As Int
	If CandleList.Size = 0 Then Return -1
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim chartLeft As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim projX As Float = mDepth * 0.5
	Dim chartRight As Float = mBase.Width - 20dip - projX
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim count As Int = CandleList.Size
	If count = 0 Then Return -1
	
	Dim stepX As Float = chartWidth / count
	If touchX < chartLeft Or touchX > chartRight + projX Then Return -1
	
	Dim rawIdx As Int = Floor((touchX - chartLeft) / stepX)
	Return Max(0, Min(count - 1, rawIdx))
End Sub

Private Sub HandleClick(clickX As Float)
	If CandleList.Size = 0 Then Return
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim chartLeft As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim projX As Float = mDepth * 0.5
	Dim chartRight As Float = mBase.Width - 20dip - projX
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim count As Int = CandleList.Size
	If count = 0 Then Return
	
	Dim stepX As Float = chartWidth / count
	If clickX < chartLeft Or clickX > chartRight + projX Then Return
	
	Dim foundPoint As Int = Floor((clickX - chartLeft) / stepX)
	foundPoint = Max(0, Min(count - 1, foundPoint))
	
	If SubExists(mCallBack, mEventName & "_ItemClick") Then
		Dim cd As CandleData = CandleList.Get(foundPoint)
		Dim res As CandleClickResult
		res.Initialize
		res.Index = foundPoint
		res.DateLabel = cd.DateLabel
		res.OpenVal = cd.OpenVal
		res.CloseVal = cd.CloseVal
		res.HighVal = cd.HighVal
		res.LowVal = cd.LowVal
		
		CallSub2(mCallBack, mEventName & "_ItemClick", res)
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

' Set the base B4XView object.
Public Sub GetBase As B4XView
	Return mBase
End Sub

' Set the tag assigned to the view.
Public Sub getTag As Object
	Return mTag
End Sub

' Set a custom tag object to the view.
Public Sub setTag (vTag As Object)
	mTag = vTag
End Sub

Private Sub UpdateFonts
	fontTitle = xui.CreateDefaultBoldFont(mTitleSize)
	fontSubTitle = xui.CreateDefaultFont(mSubTitleSize)
	fontLabel = xui.CreateDefaultFont(mLabelFontSize)
	fontAxisTitle = xui.CreateDefaultBoldFont(mLabelFontSize)
End Sub

Private Sub UpdateCachedColors
	#If B4J
	cachedBullishBase = GetFXColor(mBullishColor)
	cachedBullishTop = GetFXColor(LightenColor(mBullishColor, 1.25))
	cachedBullishSide = GetFXColor(DarkenColor(mBullishColor, 0.75))
	cachedBullishOutline = GetFXColor(DarkenColor(mBullishColor, 0.5))
	
	Dim bUpperClr As Int = DarkenColor(mBullishColor, 0.85)
	Dim bLowerClr As Int = DarkenColor(mBullishColor, 0.75)
	If mWickColorMode.ToUpperCase = "GRAY" Then
		bUpperClr = xui.Color_Gray
		bLowerClr = xui.Color_Gray
	End If
	cachedBullishUpperWick = GetFXColor(bUpperClr)
	cachedBullishLowerWick = GetFXColor(bLowerClr)
	
	cachedBearishBase = GetFXColor(mBearishColor)
	cachedBearishTop = GetFXColor(LightenColor(mBearishColor, 1.25))
	cachedBearishSide = GetFXColor(DarkenColor(mBearishColor, 0.75))
	cachedBearishOutline = GetFXColor(DarkenColor(mBearishColor, 0.5))
	
	Dim rUpperClr As Int = DarkenColor(mBearishColor, 0.85)
	Dim rLowerClr As Int = DarkenColor(mBearishColor, 0.75)
	If mWickColorMode.ToUpperCase = "GRAY" Then
		rUpperClr = xui.Color_Gray
		rLowerClr = xui.Color_Gray
	End If
	cachedBearishUpperWick = GetFXColor(rUpperClr)
	cachedBearishLowerWick = GetFXColor(rLowerClr)
	#End If
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
#End If

Private Sub MeasureMaxYLabelWidth As Float
	Dim maxWidth As Float = 0
	Dim gridSteps As Int = mGridSteps
	For i = 0 To gridSteps
		Dim priceVal As Float = MinPrice + i * ((MaxPrice - MinPrice) / gridSteps)
		Dim labelTxt As String = NumberFormat(priceVal, 1, 2)
		Dim rect As B4XRect = cvs.MeasureText(labelTxt, fontLabel)
		If rect.Width > maxWidth Then maxWidth = rect.Width
	Next
	Return maxWidth
End Sub

' Set the axis color.
Public Sub setAxisColor(Clr As Int)
	mAxisColor = Clr
	Redraw
End Sub

'' Set the axis color.
'Public Sub getAxisColor As Int
'	Return mAxisColor
'End Sub

' Set the grid color.
Public Sub setGridColor(Clr As Int)
	mGridColor = Clr
	Redraw
End Sub

'' Set the grid color.
'Public Sub getGridColor As Int
'	Return mGridColor
'End Sub

' Set the color mode for wicks. Options are "SameAsCandle" or "Gray".
Public Sub setWickColorMode(ModeStr As String)
	If ModeStr.ToUpperCase = "GRAY" Then
		mWickColorMode = "Gray"
	Else
		mWickColorMode = "SameAsCandle"
	End If
	UpdateCachedColors
	Redraw
End Sub

'' Set the current wick color mode.
'Public Sub getWickColorMode As String
'	Return mWickColorMode
'End Sub

' Set the 3D depth dimension (in dip).
Public Sub setDepth(DipVal As Int)
	mDepth = DipToCurrent(DipVal)
	Redraw
End Sub

'' Set the 3D depth dimension.
'Public Sub getDepth As Int
'	Return mDepth / xui.Scale
'End Sub

' Set whether rendering a line through the touched candle is enabled.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	Redraw
End Sub

'' Set whether the touch line is displayed.
'Public Sub getShowTouchLine As Boolean
'	Return mShowTouchLine
'End Sub

' Set whether a popup legend is displayed when a candle is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	Redraw
End Sub

'' Set whether the popup legend is enabled.
'Public Sub getShowPopupLegend As Boolean
'	Return mShowPopupLegend
'End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	Redraw
End Sub

'' Set the touch line color.
'Public Sub getTouchLineColor As Int
'	Return mTouchLineColor
'End Sub

' Set the color of a bullish (upward) candle.
Public Sub setBullishColor(Clr As Int)
	mBullishColor = Clr
	UpdateCachedColors
	Redraw
End Sub

'' Set the current bullish color.
'Public Sub getBullishColor As Int
'	Return mBullishColor
'End Sub

' Set the color of a bearish (downward) candle.
Public Sub setBearishColor(Clr As Int)
	mBearishColor = Clr
	UpdateCachedColors
	Redraw
End Sub

'' Set the current bearish color.
'Public Sub getBearishColor As Int
'	Return mBearishColor
'End Sub

' Set the main title of the chart.
Public Sub setTitle(Text As String)
	mTitle = Text
	Redraw
End Sub

'' Set the main title of the chart.
'Public Sub getTitle As String
'	Return mTitle
'End Sub

' Set the secondary subtitle of the chart.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	Redraw
End Sub

'' Set the secondary subtitle of the chart.
'Public Sub getSubTitle As String
'	Return mSubTitle
'End Sub

' Set the title displayed along the X-Axis.
Public Sub setXAxisTitle(Text As String)
	mXAxisTitle = Text
	Redraw
End Sub

'' Set the X-Axis title.
'Public Sub getXAxisTitle As String
'	Return mXAxisTitle
'End Sub

' Set the title displayed along the Y-Axis.
Public Sub setYAxisTitle(Text As String)
	mYAxisTitle = Text
	Redraw
End Sub

'' Set the Y-Axis title.
'Public Sub getYAxisTitle As String
'	Return mYAxisTitle
'End Sub

' Set the number of horizontal grid steps.
Public Sub setGridSteps(Steps As Int)
	mGridSteps = Max(2, Steps)
	Redraw
End Sub

'' Set the number of horizontal grid steps.
'Public Sub getGridSteps As Int
'	Return mGridSteps
'End Sub

' Clears all candle data and resets scales.
Public Sub Clear
	CandleList.Clear
	MaxPrice = 100
	MinPrice = 0
	RawMaxPrice = 100
	RawMinPrice = 0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	Redraw
End Sub

' Adds a single candlestick data point using standard Open, High, Low, Close properties.
Public Sub AddCandle(OpenVal As Float, HighVal As Float, LowVal As Float, CloseVal As Float, DateLabel As String)
	Dim cd As CandleData
	cd.Initialize
	cd.OpenVal = OpenVal
	cd.HighVal = HighVal
	cd.LowVal = LowVal
	cd.CloseVal = CloseVal
	cd.DateLabel = DateLabel
	CandleList.Add(cd)
	
	If CandleList.Size = 1 Then
		RawMaxPrice = HighVal
		RawMinPrice = LowVal
	Else
		If HighVal > RawMaxPrice Then RawMaxPrice = HighVal
		If LowVal < RawMinPrice Then RawMinPrice = LowVal
	End If
	
	Dim padding As Float = (RawMaxPrice - RawMinPrice) * 0.05
	If padding = 0 Then padding = 1.0
	MaxPrice = RawMaxPrice + padding
	MinPrice = Max(0, RawMinPrice - padding)
	
	If Not(mRedrawPending) Then
		mRedrawPending = True
		CallSubDelayed(Me, "ProcessPendingRedraw")
	End If
End Sub

Private Sub ProcessPendingRedraw
	mRedrawPending = False
	Redraw
End Sub

Private Sub RecalculateBounds 'ignore
	If CandleList.Size = 0 Then Return
	
	Dim cdFirst As CandleData = CandleList.Get(0)
	RawMaxPrice = cdFirst.HighVal
	RawMinPrice = cdFirst.LowVal
	
	For i = 1 To CandleList.Size - 1
		Dim cd As CandleData = CandleList.Get(i)
		If cd.HighVal > RawMaxPrice Then RawMaxPrice = cd.HighVal
		If cd.LowVal < RawMinPrice Then RawMinPrice = cd.LowVal
	Next
	
	Dim padding As Float = (RawMaxPrice - RawMinPrice) * 0.05
	If padding = 0 Then padding = 1.0
	MaxPrice = RawMaxPrice + padding
	MinPrice = Max(0, RawMinPrice - padding)
End Sub

' Manually forces a refresh and redraw of the chart canvas.
Public Sub Redraw
	cvs.ClearRect(cvs.TargetRect)
	
	Dim headerHeight As Float = DrawHeader
	If CandleList.Size = 0 Then
		cvs.Invalidate
		Return
	End If
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim chartLeft As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim projX As Float = mDepth * 0.5
	
	Dim chartRight As Float = mBase.Width - 20dip - projX
	Dim chartTop As Float = headerHeight + 20dip + mDepth
	Dim chartBottom As Float = mBase.Height - 40dip
	
	If (chartRight - chartLeft) <= 0 Or (chartBottom - chartTop) <= 0 Then Return
	
	DrawGridAndAxes(chartLeft, chartRight, chartTop, chartBottom)
	Draw3DCandles(chartLeft, chartRight, chartTop, chartBottom)
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	
	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, chartLeft + (chartWidth / 2), mBase.Height - 5dip, fontAxisTitle, mLabelTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, chartTop + (chartHeight / 2), fontAxisTitle, mLabelTextColor, "CENTER", -90)
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
	Dim gridSteps As Int = mGridSteps
	Dim projX As Float = mDepth * 0.5
	
	For i = 0 To gridSteps
		Dim yVal As Float = chartBottom - (i * (chartHeight / gridSteps))
		cvs.DrawLine(chartLeft, yVal, chartRight + projX, yVal, mGridColor, 1dip)
		
		Dim priceVal As Float = MinPrice + i * ((MaxPrice - MinPrice) / gridSteps)
		Dim labelTxt As String = NumberFormat(priceVal, 1, 2)
		cvs.DrawText(labelTxt, chartLeft - 6dip, yVal + (mLabelFontSize / 3), fontLabel, mLabelTextColor, "RIGHT")
	Next
	
	cvs.DrawLine(chartLeft, chartTop, chartLeft, chartBottom, mAxisColor, 1.5dip)
	cvs.DrawLine(chartLeft, chartBottom, chartRight + projX, chartBottom, mAxisColor, 1.5dip)
End Sub

#If B4J
Private Sub Draw3DCandles(chartLeft As Float, chartRight As Float, chartTop As Float, chartBottom As Float)
	Dim count As Int = CandleList.Size
	If count = 0 Then Return
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	Dim priceRange As Float = Max(0.001, MaxPrice - MinPrice)
	
	Dim stepX As Float = chartWidth / count
	Dim candleW As Float = Max(4dip, stepX * 0.45)
	
	Dim projX As Float = candleW * 0.5
	Dim projY As Float = candleW * 0.5
	
	Dim gc As JavaObject = GetGraphicsContext
	Dim wLineWidth As Double = 2.5 * xui.Scale
	
	For i = 0 To count - 1
		Dim cd As CandleData = CandleList.Get(i)
		Dim centerX As Float = chartLeft + (i * stepX) + (stepX / 2)
		
		Dim yHigh As Float = chartBottom - (((cd.HighVal - MinPrice) / priceRange) * chartHeight)
		Dim yLow As Float = chartBottom - (((cd.LowVal - MinPrice) / priceRange) * chartHeight)
		Dim yOpen As Float = chartBottom - (((cd.OpenVal - MinPrice) / priceRange) * chartHeight)
		Dim yClose As Float = chartBottom - (((cd.CloseVal - MinPrice) / priceRange) * chartHeight)
		
		Dim isBullish As Boolean = (cd.CloseVal >= cd.OpenVal)
		
		Dim bodyTop As Float = Min(yOpen, yClose)
		Dim bodyBottom As Float = Max(yOpen, yClose)
		Dim bodyHeight As Float = Max(2dip, bodyBottom - bodyTop)
		
		' Centered Volumetric Wick Coordinates as native Doubles
		Dim wick3DX As Double = centerX + (projX * 0.5)
		Dim wickHighY As Double = yHigh - (projY * 0.5)
		Dim wickLowY As Double = yLow - (projY * 0.5)
		Dim bodyTop3DY As Double = bodyTop - (projY * 0.5)
		Dim bodyBottom3DY As Double = bodyBottom - (projY * 0.5)
		
		' Lower Wick
		If yLow > bodyBottom Then
			gc.RunMethod("setStroke", Array(IIf(isBullish, cachedBullishLowerWick, cachedBearishLowerWick)))
			gc.RunMethod("setLineWidth", Array(wLineWidth))
			gc.RunMethod("strokeLine", Array(wick3DX, bodyBottom3DY, wick3DX, wickLowY))
		End If
		
		' Square 3D Body Block
		DrawSingle3DBlock(centerX - (candleW / 2), bodyTop, candleW, bodyHeight, projX, projY, IIf(isBullish, mBullishColor, mBearishColor))
		
		' Upper Wick
		If yHigh < bodyTop Then
			gc.RunMethod("setStroke", Array(IIf(isBullish, cachedBullishUpperWick, cachedBearishUpperWick)))
			gc.RunMethod("setLineWidth", Array(wLineWidth))
			gc.RunMethod("strokeLine", Array(wick3DX, bodyTop3DY, wick3DX, wickHighY))
		End If
		
		' Date Label
		If cd.DateLabel <> "" Then
			Dim labelInterval As Int = Max(1, Floor(count / 6))
			If i Mod labelInterval = 0 Or i = count - 1 Then
				cvs.DrawText(cd.DateLabel, centerX, chartBottom + 18dip, fontLabel, mLabelTextColor, "CENTER")
			End If
		End If
	Next
	
	' Render Touch Line over the active touched candle
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim touchX As Float = chartLeft + (LastTouchedIndex * stepX) + (stepX / 2)
		cvs.DrawLine(touchX, chartTop, touchX, chartBottom, mTouchLineColor, 2dip)
		
		If mShowPopupLegend Then
			Dim cdTouched As CandleData = CandleList.Get(LastTouchedIndex)
			Dim lines As List
			lines.Initialize
			lines.Add(cdTouched.DateLabel)
			lines.Add("Open: " & NumberFormat(cdTouched.OpenVal, 1, 2))
			lines.Add("High: " & NumberFormat(cdTouched.HighVal, 1, 2))
			lines.Add("Low: " & NumberFormat(cdTouched.LowVal, 1, 2))
			lines.Add("Close: " & NumberFormat(cdTouched.CloseVal, 1, 2))
			
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
			
			#If B4A
			Dim textBaselineOffset As Float = fontLabel.Size / 2.5
			#Else
			Dim textBaselineOffset As Float = fontLabel.Size / 3
			#End If
			
			For Each lineText As String In lines
				cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + textBaselineOffset, fontLabel, mLabelTextColor, "LEFT")
				currentTextY = currentTextY + lineH
			Next
		End If
	End If
End Sub

Private Sub DrawSingle3DBlock(x As Float, y As Float, w As Float, h As Float, projX As Float, projY As Float, baseClr As Int)
	Dim isBullish As Boolean = (baseClr = mBullishColor)
	Dim gc As JavaObject = GetGraphicsContext
	
	Dim pFrontBLX As Double = x
	Dim pFrontBLY As Double = y + h
	Dim pFrontBRX As Double = x + w
	Dim pFrontBRY As Double = y + h
	Dim pFrontTLX As Double = x
	Dim pFrontTLY As Double = y
	Dim pFrontTRX As Double = x + w
	Dim pFrontTRY As Double = y
	
	Dim pBackTLX As Double = pFrontTLX + projX
	Dim pBackTLY As Double = pFrontTLY - projY
	Dim pBackTRX As Double = pFrontTRX + projX
	Dim pBackTRY As Double = pFrontTRY - projY
	Dim pBackBRX As Double = pFrontBRX + projX
	Dim pBackBRY As Double = pFrontBRY - projY
	
	Dim topCol As Object = IIf(isBullish, cachedBullishTop, cachedBearishTop)
	Dim sideCol As Object = IIf(isBullish, cachedBullishSide, cachedBearishSide)
	Dim baseCol As Object = IIf(isBullish, cachedBullishBase, cachedBearishBase)
	Dim outlineCol As Object = IIf(isBullish, cachedBullishOutline, cachedBearishOutline)
	
	Dim outlineWidth As Double = 1.0 * xui.Scale
	gc.RunMethod("setLineWidth", Array(outlineWidth))
	
	' Apply ROUND line joins and caps to prevent miter spikes on acute 3D projection angles
	Dim joJoin As JavaObject
	joJoin.InitializeStatic("javafx.scene.shape.StrokeLineJoin")
	gc.RunMethod("setLineJoin", Array(joJoin.GetField("ROUND")))
	
	Dim joCap As JavaObject
	joCap.InitializeStatic("javafx.scene.shape.StrokeLineCap")
	gc.RunMethod("setLineCap", Array(joCap.GetField("ROUND")))
	
	' Front Face
	xPoints(0) = pFrontTLX : yPoints(0) = pFrontTLY
	xPoints(1) = pFrontTRX : yPoints(1) = pFrontTRY
	xPoints(2) = pFrontBRX : yPoints(2) = pFrontBRY
	xPoints(3) = pFrontBLX : yPoints(3) = pFrontBLY
	gc.RunMethod("setFill", Array(baseCol))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(outlineCol))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Right Side Face
	xPoints(0) = pFrontTRX : yPoints(0) = pFrontTRY
	xPoints(1) = pBackTRX : yPoints(1) = pBackTRY
	xPoints(2) = pBackBRX : yPoints(2) = pBackBRY
	xPoints(3) = pFrontBRX : yPoints(3) = pFrontBRY
	gc.RunMethod("setFill", Array(sideCol))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(outlineCol))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Top Face
	xPoints(0) = pFrontTLX : yPoints(0) = pFrontTLY
	xPoints(1) = pBackTLX : yPoints(1) = pBackTLY
	xPoints(2) = pBackTRX : yPoints(2) = pBackTRY
	xPoints(3) = pFrontTRX : yPoints(3) = pFrontTRY
	gc.RunMethod("setFill", Array(topCol))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(outlineCol))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
End Sub
#Else
Private Sub Draw3DCandles(chartLeft As Float, chartRight As Float, chartTop As Float, chartBottom As Float)
	Dim count As Int = CandleList.Size
	If count = 0 Then Return
	
	Dim chartWidth As Float = chartRight - chartLeft
	Dim chartHeight As Float = chartBottom - chartTop
	Dim priceRange As Float = Max(0.001, MaxPrice - MinPrice)
	
	Dim stepX As Float = chartWidth / count
	Dim candleW As Float = Max(4dip, stepX * 0.45)
	
	Dim projX As Float = candleW * 0.5
	Dim projY As Float = candleW * 0.5
	
	For i = 0 To count - 1
		Dim cd As CandleData = CandleList.Get(i)
		Dim centerX As Float = chartLeft + (i * stepX) + (stepX / 2)
		
		Dim yHigh As Float = chartBottom - (((cd.HighVal - MinPrice) / priceRange) * chartHeight)
		Dim yLow As Float = chartBottom - (((cd.LowVal - MinPrice) / priceRange) * chartHeight)
		Dim yOpen As Float = chartBottom - (((cd.OpenVal - MinPrice) / priceRange) * chartHeight)
		Dim yClose As Float = chartBottom - (((cd.CloseVal - MinPrice) / priceRange) * chartHeight)
		
		Dim baseColor As Int = mBullishColor
		If cd.CloseVal < cd.OpenVal Then
			baseColor = mBearishColor
		End If
		
		' Evaluate wick color preference
		Dim upperWickColor As Int = DarkenColor(baseColor, 0.85)
		Dim lowerWickColor As Int = DarkenColor(baseColor, 0.75)
		If mWickColorMode.ToUpperCase = "GRAY" Then
			upperWickColor = xui.Color_Gray
			lowerWickColor = xui.Color_Gray
		End If
		
		Dim bodyTop As Float = Min(yOpen, yClose)
		Dim bodyBottom As Float = Max(yOpen, yClose)
		Dim bodyHeight As Float = Max(2dip, bodyBottom - bodyTop)
		
		' Centered Volumetric Wick Coordinates
		Dim wick3DX As Float = centerX + (projX * 0.5)
		Dim wickHighY As Float = yHigh - (projY * 0.5)
		Dim wickLowY As Float = yLow - (projY * 0.5)
		Dim bodyTop3DY As Float = bodyTop - (projY * 0.5)
		Dim bodyBottom3DY As Float = bodyBottom - (projY * 0.5)
		
		' Lower Wick
		If yLow > bodyBottom Then
			cvs.DrawLine(wick3DX, bodyBottom3DY, wick3DX, wickLowY, lowerWickColor, 2.5dip)
		End If
		
		' Square 3D Body Block
		DrawSingle3DBlock(centerX - (candleW / 2), bodyTop, candleW, bodyHeight, projX, projY, baseColor)
		
		' Upper Wick
		If yHigh < bodyTop Then
			cvs.DrawLine(wick3DX, bodyTop3DY, wick3DX, wickHighY, upperWickColor, 2.5dip)
		End If
		
		' Date Label
		If cd.DateLabel <> "" Then
			Dim labelInterval As Int = Max(1, Floor(count / 6))
			If i Mod labelInterval = 0 Or i = count - 1 Then
				cvs.DrawText(cd.DateLabel, centerX, chartBottom + 18dip, fontLabel, mLabelTextColor, "CENTER")
			End If
		End If
	Next
	
	' Render Touch Line over the active touched candle
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim touchX As Float = chartLeft + (LastTouchedIndex * stepX) + (stepX / 2)
		cvs.DrawLine(touchX, chartTop, touchX, chartBottom, mTouchLineColor, 2dip)
		
		If mShowPopupLegend Then
			Dim cdTouched As CandleData = CandleList.Get(LastTouchedIndex)
			Dim lines As List
			lines.Initialize
			lines.Add(cdTouched.DateLabel)
			lines.Add("Open: " & NumberFormat(cdTouched.OpenVal, 1, 2))
			lines.Add("High: " & NumberFormat(cdTouched.HighVal, 1, 2))
			lines.Add("Low: " & NumberFormat(cdTouched.LowVal, 1, 2))
			lines.Add("Close: " & NumberFormat(cdTouched.CloseVal, 1, 2))
			
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
			
			#If B4A
			Dim textBaselineOffset As Float = fontLabel.Size / 2.5
			#Else
			Dim textBaselineOffset As Float = fontLabel.Size / 3
			#End If
			
			For Each lineText As String In lines
				cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + textBaselineOffset, fontLabel, mLabelTextColor, "LEFT")
				currentTextY = currentTextY + lineH
			Next
		End If
	End If
End Sub

Private Sub DrawSingle3DBlock(x As Float, y As Float, w As Float, h As Float, projX As Float, projY As Float, baseClr As Int)
	Dim pFrontBL As CandlePoint3D = CreatePoint(x, y + h)
	Dim pFrontBR As CandlePoint3D = CreatePoint(x + w, y + h)
	Dim pFrontTL As CandlePoint3D = CreatePoint(x, y)
	Dim pFrontTR As CandlePoint3D = CreatePoint(x + w, y)
	
	Dim pBackTL As CandlePoint3D = CreatePoint(pFrontTL.X + projX, pFrontTL.Y - projY)
	Dim pBackTR As CandlePoint3D = CreatePoint(pFrontTR.X + projX, pFrontTR.Y - projY)
	Dim pBackBR As CandlePoint3D = CreatePoint(pFrontBR.X + projX, pFrontBR.Y - projY)
	
	Dim topColor As Int = LightenColor(baseClr, 1.25)
	Dim sideColor As Int = DarkenColor(baseClr, 0.75)
	
	' Front Face (Closed Path)
	Dim pathFront As B4XPath
	pathFront.Initialize(pFrontTL.X, pFrontTL.Y)
	pathFront.LineTo(pFrontTR.X, pFrontTR.Y)
	pathFront.LineTo(pFrontBR.X, pFrontBR.Y)
	pathFront.LineTo(pFrontBL.X, pFrontBL.Y)
	pathFront.LineTo(pFrontTL.X, pFrontTL.Y)
	cvs.DrawPath(pathFront, baseClr, True, 0)
	
	' Right Side Face (Closed Path)
	Dim pathRight As B4XPath
	pathRight.Initialize(pFrontTR.X, pFrontTR.Y)
	pathRight.LineTo(pBackTR.X, pBackTR.Y)
	pathRight.LineTo(pBackBR.X, pBackBR.Y)
	pathRight.LineTo(pFrontBR.X, pFrontBR.Y)
	pathRight.LineTo(pFrontTR.X, pFrontTR.Y)
	cvs.DrawPath(pathRight, sideColor, True, 0)
	
	' Top Face (Closed Path)
	Dim pathTop As B4XPath
	pathTop.Initialize(pFrontTL.X, pFrontTL.Y)
	pathTop.LineTo(pBackTL.X, pBackTL.Y)
	pathTop.LineTo(pBackTR.X, pBackTR.Y)
	pathTop.LineTo(pFrontTR.X, pFrontTR.Y)
	pathTop.LineTo(pFrontTL.X, pFrontTL.Y)
	cvs.DrawPath(pathTop, topColor, True, 0)
	
	' Outline Borders drawn using individual lines to prevent overlapping path strokes/plus-sign artifacts at corners
	Dim outlineClr As Int = DarkenColor(baseClr, 0.5)
	Dim outlineWidth As Float = 1dip
	
	' Front Face Outline
	cvs.DrawLine(pFrontTL.X, pFrontTL.Y, pFrontTR.X, pFrontTR.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pFrontTR.X, pFrontTR.Y, pFrontBR.X, pFrontBR.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pFrontBR.X, pFrontBR.Y, pFrontBL.X, pFrontBL.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pFrontBL.X, pFrontBL.Y, pFrontTL.X, pFrontTL.Y, outlineClr, outlineWidth)
	
	' Top Face Edges
	cvs.DrawLine(pFrontTL.X, pFrontTL.Y, pBackTL.X, pBackTL.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pBackTL.X, pBackTL.Y, pBackTR.X, pBackTR.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pBackTR.X, pBackTR.Y, pFrontTR.X, pFrontTR.Y, outlineClr, outlineWidth)
	
	' Right Face Edges
	cvs.DrawLine(pBackTR.X, pBackTR.Y, pBackBR.X, pBackBR.Y, outlineClr, outlineWidth)
	cvs.DrawLine(pBackBR.X, pBackBR.Y, pFrontBR.X, pFrontBR.Y, outlineClr, outlineWidth)
End Sub
#End If

Private Sub CreatePoint(x As Float, y As Float) As CandlePoint3D 'ignore
	Dim pt As CandlePoint3D
	pt.Initialize
	pt.X = x
	pt.Y = y
	Return pt
End Sub

Private Sub LightenColor(clr As Int, factor As Float) As Int
	Dim argb() As Int = GetARGB(clr)
	Return xui.Color_ARGB(argb(0), Min(255, argb(1) * factor), Min(255, argb(2) * factor), Min(255, argb(3) * factor))
End Sub

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
