B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As StackedBarClickResult)
#Event: ItemTouch (Result As StackedBarTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: 3D Stacked Bar Chart, Description: Main chart title text
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: Stacked Data Overview, Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the sub-title text
#DesignerProperty: Key: XAxisTitle, DisplayName: X-Axis Title, FieldType: String, DefaultValue: , Description: Title for the horizontal axis
#DesignerProperty: Key: YAxisTitle, DisplayName: Y-Axis Title, FieldType: String, DefaultValue: , Description: Title for the vertical axis
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis label text color
#DesignerProperty: Key: GridSteps, DisplayName: Grid Steps, FieldType: Int, DefaultValue: 4, MinRange: 2, MaxRange: 20, Description: Number of grid lines / value steps
#DesignerProperty: Key: AxisColor, DisplayName: Axis Color, FieldType: Color, DefaultValue: 0xFF888888, Description: Color of axis lines
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFE0E0E0, Description: Color of horizontal gridlines
#DesignerProperty: Key: Depth, DisplayName: 3D Depth, FieldType: Int, DefaultValue: 15, MinRange: 5, MaxRange: 50, Description: 3D bar depth in dip
#DesignerProperty: Key: ShowLegend, DisplayName: Show Legend, FieldType: Boolean, DefaultValue: True, Description: Show the series legend
#DesignerProperty: Key: ShowLegendOnChart, DisplayName: Show Legend On Chart, FieldType: Boolean, DefaultValue: False, Description: Show series legend on the top right-hand side of the chart area
#DesignerProperty: Key: ShowLegendValues, DisplayName: Show Legend Values, FieldType: Boolean, DefaultValue: True, Description: Show series total values on the left of the legend items
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Render numeric values inside blocks
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color for values printed inside blocks
#DesignerProperty: Key: ValueFontSize, DisplayName: Value Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 36, Description: Font size for segment values
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched stack
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when the stack is touched
#DesignerProperty: Key: ShowPopupLegendTotal, DisplayName: Show Popup Legend Total, FieldType: Boolean, DefaultValue: False, Description: Show total value in the popup legend when the stack is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type CustomStackedBarPoint (X As Float, Y As Float)
	Type StackedSeries (Name As String, Color As Int, Values As List)
	Type StackedBarClickResult (CategoryIndex As Int, CategoryLabel As String, StackValues As Map, StackSum As Float)
	Type StackedBarTouchResult (CategoryIndex As Int, CategoryLabel As String, StackValues As Map, StackSum As Float)
	
	Private mTitle As String
	Private mSubTitle As String
	Private mSubTitleColor As Int
	Private mXAxisTitle As String
	Private mYAxisTitle As String
	Private mAxisColor As Int
	Private mGridColor As Int
	Private mTextColor As Int
	Private mDepth As Float
	Private mValueTextColor As Int
	Private mValueFontSize As Int
	Private mShowValues As Boolean
	Private mShowLegend As Boolean
	Private mShowLegendOnChart As Boolean
	Private mShowLegendValues As Boolean
	Private mGridSteps As Int = 4
	Private mShowTouchLine As Boolean
	Private mTouchLineColor As Int
	Private mShowPopupLegend As Boolean
	Private mShowPopupLegendTotal As Boolean
	
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontAxis As B4XFont
	Private fontValue As B4XFont
	Private fontAxisTitle As B4XFont
	
	Private SeriesList As List
	Private CategoryLabels As List
	Private mMaxTotalValue As Float = 1.0
	Private mRawMaxTotalValue As Float = 1.0
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	Private LastTouchedIndex As Int = -1
	#End If
	
	' Performance optimizations: Caching, Arrays and Coalesced Rendering
	Type CachedStackedBarColors (Base As Object, Top As Object, Side As Object, Outline As Object)
	Private SeriesColorsList As List
	Private CategoryTotals As List
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoints(4) As Double
	Private yPoints(4) As Double
	#End If
End Sub

' Initialises the chart view framework and internal data structures.
Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
	SeriesList.Initialize
	CategoryLabels.Initialize
	SeriesColorsList.Initialize
	CategoryTotals.Initialize
	UpdateFonts
End Sub

' Configures the view after being inflated from the designer.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	If SeriesList.IsInitialized = False Then SeriesList.Initialize
	If CategoryLabels.IsInitialized = False Then CategoryLabels.Initialize
	If SeriesColorsList.IsInitialized = False Then SeriesColorsList.Initialize
	If CategoryTotals.IsInitialized = False Then CategoryTotals.Initialize
	
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	mXAxisTitle = Props.GetDefault("XAxisTitle", "")
	mYAxisTitle = Props.GetDefault("YAxisTitle", "")
	mAxisColor = xui.PaintOrColorToColor(Props.GetDefault("AxisColor", 0xFF888888))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFE0E0E0))
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_DarkGray))
	mDepth = DipToCurrent(Props.GetDefault("Depth", 15))
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_White))
	mValueFontSize = Props.GetDefault("ValueFontSize", 11)
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowLegend = Props.GetDefault("ShowLegend", True)
	mShowLegendOnChart = Props.GetDefault("ShowLegendOnChart", False)
	mShowLegendValues = Props.GetDefault("ShowLegendValues", True)
	mGridSteps = Props.GetDefault("GridSteps", 4)
	mShowTouchLine = Props.GetDefault("ShowTouchLine", False)
	mTouchLineColor = xui.PaintOrColorToColor(Props.GetDefault("TouchLineColor", xui.Color_Red))
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	mShowPopupLegendTotal = Props.GetDefault("ShowPopupLegendTotal", False)
	
	UpdateFonts
	
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
	Dim catIdx As Int = GetCategoryIndexAt(touchX, touchY)
	If catIdx <> LastTouchedIndex Then
		LastTouchedIndex = catIdx
		If catIdx >= 0 Then
			Dim res As StackedBarTouchResult
			res.Initialize
			res.CategoryIndex = catIdx
			res.CategoryLabel = CategoryLabels.Get(catIdx)
			res.StackSum = CategoryTotals.Get(catIdx)
			res.StackValues.Initialize
			
			For sIdx = 0 To SeriesList.Size - 1
				Dim ss As StackedSeries = SeriesList.Get(sIdx)
				If catIdx < ss.Values.Size Then
					res.StackValues.Put(ss.Name, ss.Values.Get(catIdx))
				End If
			Next
			
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
	If CategoryLabels.Size = 0 Or SeriesList.Size = 0 Then Return -1
	
	Dim count As Int = CategoryLabels.Size
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	Dim headerHeight As Float = DrawHeader
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + mDepth
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If plotHeight <= 0 Or plotWidth <= 0 Then Return -1
	
	If touchX < plotX - 10dip Or touchX > plotX + plotWidth + mDepth + 30dip Then Return -1
	If touchY < plotY - 10dip Or touchY > plotY + plotHeight + 30dip Then Return -1
	
	Dim zoneW As Float = plotWidth / count
	
	For catIdx = 0 To count - 1
		Dim zoneStartX As Float = plotX + (catIdx * zoneW)
		Dim zoneEndX As Float = zoneStartX + zoneW
		
		If touchX >= zoneStartX And touchX <= zoneEndX Then
			Return catIdx
		End If
	Next
	
	Return -1
End Sub

Private Sub HandleClick(clickX As Float, clickY As Float)
	Dim catIdx As Int = GetCategoryIndexAt(clickX, clickY)
	If catIdx >= 0 Then
		If SubExists(mCallBack, mEventName & "_ItemClick") Then
			Dim res As StackedBarClickResult
			res.Initialize
			res.CategoryIndex = catIdx
			res.CategoryLabel = CategoryLabels.Get(catIdx)
			res.StackSum = CategoryTotals.Get(catIdx)
			res.StackValues.Initialize
			
			For sIdx = 0 To SeriesList.Size - 1
				Dim ss As StackedSeries = SeriesList.Get(sIdx)
				If catIdx < ss.Values.Size Then
					res.StackValues.Put(ss.Name, ss.Values.Get(catIdx))
				End If
			Next
			
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

' Set the base view context assigned to the drawing component.
Public Sub GetBase As B4XView
	Return mBase
End Sub

' Set the tag property on custom target.
Public Sub getTag As Object
	Return mTag
End Sub

' Set the identifier or linked node reference.
Public Sub setTag (vTag As Object)
	mTag = vTag
End Sub

Private Sub UpdateFonts
	fontTitle = xui.CreateDefaultBoldFont(16)
	fontSubTitle = xui.CreateDefaultFont(12)
	fontAxis = xui.CreateDefaultFont(11)
	fontValue = xui.CreateDefaultFont(mValueFontSize)
	fontAxisTitle = xui.CreateDefaultBoldFont(11)
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

Private Sub MeasureMaxYLabelWidth As Float
	Dim maxWidth As Float = 0
	Dim range As Float = mMaxTotalValue - 0
	If range = 0 Then range = 1.0
	For i = 0 To mGridSteps
		Dim gridVal As Float = (range / mGridSteps) * i
		Dim valText As String = NumberFormat(gridVal, 1, 0)
		Dim rect As B4XRect = cvs.MeasureText(valText, fontAxis)
		If rect.Width > maxWidth Then maxWidth = rect.Width
	Next
	Return maxWidth
End Sub

' Set the number of grid steps / value lines.
Public Sub setGridSteps(Steps As Int)
	mGridSteps = Max(2, Steps)
	RequestRedraw
End Sub

' Set the axis color.
Public Sub setAxisColor(Clr As Int)
	mAxisColor = Clr
	RequestRedraw
End Sub

' Set the grid color.
Public Sub setGridColor(Clr As Int)
	mGridColor = Clr
	RequestRedraw
End Sub

' Calculates the next logical nice maximum value above raw max for chart headroom.
Private Sub CalculateNiceMax(rawMax As Float, steps As Int) As Float
	If rawMax <= 0 Then Return 1.0
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

' Set whether label overlay rendering occurs within the segments bounds on target redraw.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

' Set whether displaying the series legend at the bottom of the chart is enabled.
Public Sub setShowLegend(Enabled As Boolean)
	mShowLegend = Enabled
	RequestRedraw
End Sub

' Set whether displaying the series legend on the top right-hand side of the chart area is enabled.
Public Sub setShowLegendOnChart(Enabled As Boolean)
	mShowLegendOnChart = Enabled
	RequestRedraw
End Sub

'' Set whether the series legend is displayed on the chart area.
'Public Sub getShowLegendOnChart As Boolean
'	Return mShowLegendOnChart
'End Sub

' Set whether displaying the series values on the left of the legend items is enabled.
Public Sub setShowLegendValues(Enabled As Boolean)
	mShowLegendValues = Enabled
	RequestRedraw
End Sub

' Set whether a popup legend is displayed when a stack is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	RequestRedraw
End Sub

' Set whether the total is displayed in the popup legend.
Public Sub setShowPopupLegendTotal(Enabled As Boolean)
	mShowPopupLegendTotal = Enabled
	RequestRedraw
End Sub

' Set whether rendering a line through the touched stack is enabled.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

' Set the color for numerics drawn above mapped layout dimensions.
Public Sub setValueTextColor(Clr As Int)
	mValueTextColor = Clr
	RequestRedraw
End Sub

' Set value metrics font display size limit.
Public Sub setValueFontSize(Size As Int)
	mValueFontSize = Size
	UpdateFonts
	RequestRedraw
End Sub

' Set the header caption.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

' Set sub-header label configuration text.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

' Set the color for the secondary chart subtitle.
Public Sub setSubTitleColor(Clr As Int)
	mSubTitleColor = Clr
	RequestRedraw
End Sub

' Set description text placed beneath lower bounding category markers.
Public Sub setXAxisTitle(Text As String)
	mXAxisTitle = Text
	RequestRedraw
End Sub

' Set value magnitude descriptor title layout constraint.
Public Sub setYAxisTitle(Text As String)
	mYAxisTitle = Text
	RequestRedraw
End Sub

' Stores sequential identifiers aligned laterally underneath bounding visual groups.
Public Sub SetCategories(Labels() As String)
	CategoryLabels.Clear
	For i = 0 To Labels.Length - 1
		CategoryLabels.Add(Labels(i))
	Next
	RecalculateMaxTotal
	RequestRedraw
End Sub

' Scraps all aggregated arrays.
Public Sub Clear
	SeriesList.Clear
	SeriesColorsList.Clear
	CategoryTotals.Clear
	mRawMaxTotalValue = 1.0
	mMaxTotalValue = 1.0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

' Reconstructs completely empty configuration bounds over arrays previously occupied.
Public Sub ClearAll
	SeriesList.Clear
	CategoryLabels.Clear
	SeriesColorsList.Clear
	CategoryTotals.Clear
	mRawMaxTotalValue = 1.0
	mMaxTotalValue = 1.0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

' Registers group sequences combining sequential values across all mapped horizontal nodes.
Public Sub AddSeries(SeriesName As String, Values() As Float, Color As Int)
	Dim ss As StackedSeries
	ss.Initialize
	ss.Name = SeriesName
	ss.Color = Color
	ss.Values.Initialize
	
	For i = 0 To Values.Length - 1
		ss.Values.Add(Values(i))
	Next
	
	SeriesList.Add(ss)
	
	Dim csbc As CachedStackedBarColors
	csbc.Initialize
	#If B4J
	csbc.Base = GetFXColor(Color)
	csbc.Top = GetFXColor(LightenColor(Color, 1.25))
	csbc.Side = GetFXColor(DarkenColor(Color, 0.75))
	csbc.Outline = GetFXColor(DarkenColor(Color, 0.5))
	#Else
	csbc.Base = Color
	csbc.Top = LightenColor(Color, 1.25)
	csbc.Side = DarkenColor(Color, 0.75)
	csbc.Outline = DarkenColor(Color, 0.5)
	#End If
	SeriesColorsList.Add(csbc)
	
	Dim maxLen As Int = Max(CategoryLabels.Size, Values.Length)
	For i = 0 To maxLen - 1
		Dim currentSum As Float = 0
		If i < CategoryTotals.Size Then currentSum = CategoryTotals.Get(i)
		Dim addVal As Float = 0
		If i < Values.Length Then addVal = Values(i)
		
		currentSum = currentSum + addVal
		If i < CategoryTotals.Size Then
			CategoryTotals.Set(i, currentSum)
		Else
			CategoryTotals.Add(currentSum)
		End If
		
		If currentSum > mRawMaxTotalValue Then mRawMaxTotalValue = currentSum
	Next
	mRawMaxTotalValue = Max(0.001, mRawMaxTotalValue)
	
	RequestRedraw
End Sub

Private Sub RecalculateMaxTotal 'ignore
	mRawMaxTotalValue = 0.001
	CategoryTotals.Clear
	If CategoryLabels.Size = 0 Or SeriesList.Size = 0 Then
		mRawMaxTotalValue = 1.0
		Return
	End If
	
	For catIdx = 0 To CategoryLabels.Size - 1
		Dim catTotal As Float = 0
		For sIdx = 0 To SeriesList.Size - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			If catIdx < ss.Values.Size Then
				catTotal = catTotal + ss.Values.Get(catIdx)
			End If
		Next
		CategoryTotals.Add(catTotal)
		If catTotal > mRawMaxTotalValue Then mRawMaxTotalValue = catTotal
	Next
End Sub

' Initiates painting sequence across the current graphical canvas base.
Public Sub Redraw
	cvs.ClearRect(cvs.TargetRect)
	
	Dim headerHeight As Float = DrawHeader
	
	Dim count As Int = CategoryLabels.Size
	If count = 0 Or SeriesList.Size = 0 Then
		cvs.Invalidate
		Return
	End If
	
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	
	' Compute nice max headroom before measuring labels
	mMaxTotalValue = CalculateNiceMax(mRawMaxTotalValue, mGridSteps)
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + mDepth
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If plotHeight <= 0 Or plotWidth <= 0 Then Return
	
	' 1. Y-Axis Scale Values & Horizontal Grid Lines
	For i = 0 To mGridSteps
		Dim gridVal As Float = (mMaxTotalValue / mGridSteps) * i
		Dim yPos As Float = (plotY + plotHeight) - (i * (plotHeight / mGridSteps))
		
		cvs.DrawLine(plotX, yPos, plotX + plotWidth + mDepth, yPos, mGridColor, 1dip)
		
		Dim valText As String = NumberFormat(gridVal, 1, 0)
		cvs.DrawText(valText, plotX - 5dip, yPos + 4dip, fontAxis, mTextColor, "RIGHT")
	Next
	
	' Y-Axis Baseline Line
	cvs.DrawLine(plotX, plotY, plotX, plotY + plotHeight, mAxisColor, 1.5dip)
	
	' 2. Render Stacked 3D Bars & X-Axis Category Labels
	If count > 0 And SeriesList.Size > 0 Then
		Dim barW As Float = (plotWidth / count) * 0.6
		Dim spacing As Float = (plotWidth / count) * 0.4
		
		For catIdx = 0 To count - 1
			Dim startX As Float = plotX + (spacing / 2) + catIdx * (barW + spacing)
			Dim currentY As Float = plotY + plotHeight
			
			For sIdx = 0 To SeriesList.Size - 1
				Dim ss As StackedSeries = SeriesList.Get(sIdx)
				If catIdx < ss.Values.Size Then
					Dim val As Float = ss.Values.Get(catIdx)
					Dim segH As Float = (val / mMaxTotalValue) * plotHeight
					
					If segH > 0 Then
						DrawStacked3DSegment(startX, currentY, barW, segH, mDepth, sIdx, val)
						currentY = currentY - segH
					End If
				End If
			Next
			
			Dim centerX As Float = startX + (barW / 2)
			cvs.DrawText(CategoryLabels.Get(catIdx), centerX, (plotY + plotHeight) + 18dip, fontAxis, mTextColor, "CENTER")
		Next
		
		' Render Touch Line over the active touched stack (full height of the chart)
		#If B4J Or B4A
		If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
			Dim touchStartX As Float = plotX + (spacing / 2) + LastTouchedIndex * (barW + spacing)
			Dim touchCenterX As Float = touchStartX + (barW / 2)
			cvs.DrawLine(touchCenterX, plotY, touchCenterX, plotY + plotHeight, mTouchLineColor, 2dip)
			
			If mShowPopupLegend Then
				Dim lines As List
				lines.Initialize
				lines.Add(CategoryLabels.Get(LastTouchedIndex))
				For sIdx = 0 To SeriesList.Size - 1
					Dim ssTouch As StackedSeries = SeriesList.Get(sIdx)
					If LastTouchedIndex < ssTouch.Values.Size Then
						lines.Add(ssTouch.Name & ": " & NumberFormat(ssTouch.Values.Get(LastTouchedIndex), 1, 0))
					End If
				Next
				If mShowPopupLegendTotal Then
					lines.Add("Total: " & NumberFormat(CategoryTotals.Get(LastTouchedIndex), 1, 0))
				End If
				
				Dim maxW As Float = 0
				Dim lineH As Float = 0
				For Each lineText As String In lines
					Dim rText As B4XRect = cvs.MeasureText(lineText, fontAxis)
					If rText.Width > maxW Then maxW = rText.Width
					If rText.Height > lineH Then lineH = rText.Height
				Next
				lineH = lineH + 6dip
				
				Dim boxLeft As Float = plotX + 4dip
				Dim boxTop As Float = plotY + 4dip
				Dim boxWidth As Float = maxW + 16dip
				Dim boxHeight As Float = (lines.Size * lineH) + 8dip
				
				Dim rBox As B4XRect
				rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
				
				cvs.DrawRect(rBox, xui.Color_ARGB(192, 255, 255, 255), True, 0)
				cvs.DrawRect(rBox, mGridColor, False, 1dip)
				
				Dim currentTextY As Float = boxTop + 6dip + (lineH / 2)
				
				#If B4A
				Dim textBaselineOffset As Float = fontAxis.Size / 2.5
				#Else
				Dim textBaselineOffset As Float = fontAxis.Size / 3
				#End If
				
				For Each lineText As String In lines
					cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + textBaselineOffset, fontAxis, mTextColor, "LEFT")
					currentTextY = currentTextY + lineH
				Next
			End If
		End If
		#End If
	End If
	
	' 3. X-Axis Baseline
	cvs.DrawLine(plotX, plotY + plotHeight, plotX + plotWidth + mDepth, plotY + plotHeight, mAxisColor, 1.5dip)
	
	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, plotX + (plotWidth / 2), plotY + plotHeight + 35dip, fontAxisTitle, mTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, plotY + (plotHeight / 2), fontAxisTitle, mTextColor, "CENTER", -90)
	End If
	
	' Draw Bottom Legend (if enabled and not rendered on chart)
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then
		Dim legendY As Float = mBase.Height - 15dip
		Dim totalLegendWidth As Float = 0
		Dim seriesCount As Int = SeriesList.Size
		
		Dim seriesTotals(seriesCount) As Float
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			Dim sTotal As Float = 0
			For Each val As Float In ss.Values
				sTotal = sTotal + val
			Next
			seriesTotals(sIdx) = sTotal
		Next
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			Dim itemWidth As Float = 0
			
			If mShowLegendValues Then
				Dim totalTxt As String = NumberFormat(seriesTotals(sIdx), 1, 0)
				Dim valRect As B4XRect = cvs.MeasureText(totalTxt, fontAxis)
				itemWidth = itemWidth + valRect.Width + 6dip
			End If
			
			Dim txtRect As B4XRect = cvs.MeasureText(ss.Name, fontAxis)
			itemWidth = itemWidth + 12dip + 6dip + txtRect.Width
			
			totalLegendWidth = totalLegendWidth + itemWidth
			If sIdx < seriesCount - 1 Then totalLegendWidth = totalLegendWidth + 20dip
		Next
		
		Dim currentX As Float = (mBase.Width / 2) - (totalLegendWidth / 2)
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			
			If mShowLegendValues Then
				Dim totalTxt As String = NumberFormat(seriesTotals(sIdx), 1, 0)
				cvs.DrawText(totalTxt, currentX, legendY, fontAxis, mTextColor, "LEFT")
				Dim valRect As B4XRect = cvs.MeasureText(totalTxt, fontAxis)
				currentX = currentX + valRect.Width + 6dip
			End If
			
			Dim r As B4XRect
			r.Initialize(currentX, legendY - 10dip, currentX + 12dip, legendY + 2dip)
			cvs.DrawRect(r, ss.Color, True, 0)
			cvs.DrawRect(r, mTextColor, False, 1dip)
			
			currentX = currentX + 12dip + 6dip
			cvs.DrawText(ss.Name, currentX, legendY, fontAxis, mTextColor, "LEFT")
			
			Dim txtRect As B4XRect = cvs.MeasureText(ss.Name, fontAxis)
			currentX = currentX + txtRect.Width + 20dip
		Next
	End If
	
	' Draw On-Chart Legend (Top Right)
	If mShowLegend And mShowLegendOnChart And SeriesList.Size > 0 Then
		Dim seriesCount As Int = SeriesList.Size
		Dim maxTextW As Float = 0
		
		Dim seriesTotals(seriesCount) As Float
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			Dim sTotal As Float = 0
			For Each val As Float In ss.Values
				sTotal = sTotal + val
			Next
			seriesTotals(sIdx) = sTotal
		Next
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			Dim itemW As Float = 0
			If mShowLegendValues Then
				Dim totalTxt As String = NumberFormat(seriesTotals(sIdx), 1, 0)
				Dim valRect As B4XRect = cvs.MeasureText(totalTxt, fontAxis)
				itemW = itemW + valRect.Width + 6dip
			End If
			Dim txtRect As B4XRect = cvs.MeasureText(ss.Name, fontAxis)
			itemW = itemW + 12dip + 6dip + txtRect.Width
			If itemW > maxTextW Then maxTextW = itemW
		Next
		
		Dim itemH As Float = fontAxis.Size + 8dip
		Dim boxWidth As Float = maxTextW + 16dip
		Dim boxHeight As Float = (seriesCount * itemH) + 12dip
		
		Dim boxLeft As Float = plotX + plotWidth - boxWidth - 10dip
		Dim boxTop As Float = plotY + 10dip
		
		Dim rBox As B4XRect
		rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
		
		cvs.DrawRect(rBox, xui.Color_ARGB(192, 255, 255, 255), True, 0)
		cvs.DrawRect(rBox, mGridColor, False, 1dip)
		
		Dim currentItemY As Float = boxTop + 6dip
		#If B4A
		Dim textBaselineOffset As Float = fontAxis.Size / 2.5
		#Else
		Dim textBaselineOffset As Float = fontAxis.Size / 3
		#End If
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As StackedSeries = SeriesList.Get(sIdx)
			Dim currentX As Float = boxLeft + 8dip
			
			If mShowLegendValues Then
				Dim totalTxt As String = NumberFormat(seriesTotals(sIdx), 1, 0)
				cvs.DrawText(totalTxt, currentX, currentItemY + (itemH / 2) + textBaselineOffset, fontAxis, mTextColor, "LEFT")
				Dim valRect As B4XRect = cvs.MeasureText(totalTxt, fontAxis)
				currentX = currentX + valRect.Width + 6dip
			End If
			
			Dim rColorBox As B4XRect
			rColorBox.Initialize(currentX, currentItemY + 2dip, currentX + 12dip, currentItemY + 12dip)
			cvs.DrawRect(rColorBox, ss.Color, True, 0)
			cvs.DrawRect(rColorBox, mTextColor, False, 1dip)
			
			currentX = currentX + 12dip + 6dip
			cvs.DrawText(ss.Name, currentX, currentItemY + (itemH / 2) + textBaselineOffset, fontAxis, mTextColor, "LEFT")
			
			currentItemY = currentItemY + itemH
		Next
	End If
	
	cvs.Invalidate
End Sub

Private Sub DrawHeader As Float
	Dim currentY As Float = 10dip
	Dim cx As Float = mBase.Width / 2
	
	If mTitle <> "" Then
		cvs.DrawText(mTitle, cx, currentY + 14dip, fontTitle, mTextColor, "CENTER")
		currentY = currentY + 22dip
	End If
	
	If mSubTitle <> "" Then
		cvs.DrawText(mSubTitle, cx, currentY + 10dip, fontSubTitle, mSubTitleColor, "CENTER")
		currentY = currentY + 18dip
	End If
	
	Return currentY
End Sub

#If B4J
Private Sub DrawStacked3DSegment(x As Float, y As Float, w As Float, h As Float, depth As Float, sIdx As Int, val As Float)
	Dim csbc As CachedStackedBarColors = SeriesColorsList.Get(sIdx)
	Dim gc As JavaObject = GetGraphicsContext
	
	Dim pFrontBLX As Double = x
	Dim pFrontBLY As Double = y
	Dim pFrontBRX As Double = x + w
	Dim pFrontBRY As Double = y
	Dim pFrontTLX As Double = x
	Dim pFrontTLY As Double = y - h
	Dim pFrontTRX As Double = x + w
	Dim pFrontTRY As Double = y - h
	
	Dim pBackTLX As Double = pFrontTLX + depth
	Dim pBackTLY As Double = pFrontTLY - (depth * 0.5)
	Dim pBackTRX As Double = pFrontTRX + depth
	Dim pBackTRY As Double = pFrontTRY - (depth * 0.5)
	Dim pBackBRX As Double = pFrontBRX + depth
	Dim pBackBRY As Double = pFrontBRY - (depth * 0.5)
	
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
	gc.RunMethod("setFill", Array(csbc.Base))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(csbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Right Side Face
	xPoints(0) = pFrontTRX : yPoints(0) = pFrontTRY
	xPoints(1) = pBackTRX : yPoints(1) = pBackTRY
	xPoints(2) = pBackBRX : yPoints(2) = pBackBRY
	xPoints(3) = pFrontBRX : yPoints(3) = pFrontBRY
	gc.RunMethod("setFill", Array(csbc.Side))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(csbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Top Face
	xPoints(0) = pFrontTLX : yPoints(0) = pFrontTLY
	xPoints(1) = pBackTLX : yPoints(1) = pBackTLY
	xPoints(2) = pBackTRX : yPoints(2) = pBackTRY
	xPoints(3) = pFrontTRX : yPoints(3) = pFrontTRY
	gc.RunMethod("setFill", Array(csbc.Top))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(csbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Render Value Text inside block center if enabled and dimensions allow
	If mShowValues Then
		Dim valTxt As String = NumberFormat(val, 1, 0)
		Dim centerX As Float = x + (w / 2)
		If h >= mValueFontSize + 2dip And w >= cvs.MeasureText(valTxt, fontValue).Width + 2dip Then
			Dim centerY As Float = y - (h / 2) + (mValueFontSize / 3)
			cvs.DrawText(valTxt, centerX, centerY, fontValue, mValueTextColor, "CENTER")
		End If
	End If
End Sub
#Else
Private Sub DrawStacked3DSegment(x As Float, y As Float, w As Float, h As Float, depth As Float, sIdx As Int, val As Float)
	Dim csbc As CachedStackedBarColors = SeriesColorsList.Get(sIdx)
	
	Dim pFrontBLX As Float = x
	Dim pFrontBLY As Float = y
	Dim pFrontBRX As Float = x + w
	Dim pFrontBRY As Float = y
	Dim pFrontTLX As Float = x
	Dim pFrontTLY As Float = y - h
	Dim pFrontTRX As Float = x + w
	Dim pFrontTRY As Float = y - h
	
	Dim pBackTLX As Float = pFrontTLX + depth
	Dim pBackTLY As Float = pFrontTLY - (depth * 0.5)
	Dim pBackTRX As Float = pFrontTRX + depth
	Dim pBackTRY As Float = pFrontTRY - (depth * 0.5)
	Dim pBackBRX As Float = pFrontBRX + depth
	Dim pBackBRY As Float = pFrontBRY - (depth * 0.5)
	
	' Front Face
	Dim pathFront As B4XPath
	pathFront.Initialize(pFrontTLX, pFrontTLY)
	pathFront.LineTo(pFrontTRX, pFrontTRY)
	pathFront.LineTo(pFrontBRX, pFrontBRY)
	pathFront.LineTo(pFrontBLX, pFrontBLY)
	pathFront.LineTo(pFrontTLX, pFrontTLY)
	cvs.DrawPath(pathFront, csbc.Base, True, 0)
	
	' Right Side Face
	Dim pathRight As B4XPath
	pathRight.Initialize(pFrontTRX, pFrontTRY)
	pathRight.LineTo(pBackTRX, pBackTRY)
	pathRight.LineTo(pBackBRX, pBackBRY)
	pathRight.LineTo(pFrontBRX, pFrontBRY)
	pathRight.LineTo(pFrontTRX, pFrontTRY)
	cvs.DrawPath(pathRight, csbc.Side, True, 0)
	
	' Top Face
	Dim pathTop As B4XPath
	pathTop.Initialize(pFrontTLX, pFrontTLY)
	pathTop.LineTo(pBackTLX, pBackTLY)
	pathTop.LineTo(pBackTRX, pBackTRY)
	pathTop.LineTo(pFrontTRX, pFrontTRY)
	pathTop.LineTo(pFrontTLX, pFrontTLY)
	cvs.DrawPath(pathTop, csbc.Top, True, 0)
	
	' Outlines
	cvs.DrawPath(pathFront, csbc.Outline, False, 1dip)
	cvs.DrawPath(pathRight, csbc.Outline, False, 1dip)
	cvs.DrawPath(pathTop, csbc.Outline, False, 1dip)
	
	' Render Value Text inside block center if enabled and dimensions allow
	If mShowValues Then
		Dim valTxt As String = NumberFormat(val, 1, 0)
		Dim centerX As Float = x + (w / 2)
		If h >= mValueFontSize + 2dip And w >= cvs.MeasureText(valTxt, fontValue).Width + 2dip Then
			Dim centerY As Float = y - (h / 2) + (mValueFontSize / 3)
			cvs.DrawText(valTxt, centerX, centerY, fontValue, mValueTextColor, "CENTER")
		End If
	End If
End Sub
#End If

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
