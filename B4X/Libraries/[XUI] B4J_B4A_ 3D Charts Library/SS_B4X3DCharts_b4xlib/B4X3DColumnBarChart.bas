B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As ColumnBarClickResult)
#Event: ItemTouch (Result As ColumnBarTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Chart Title, Description: Main chart title text
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: Chart Subtitle, Description: Secondary title text
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
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Render numeric values inside bars
#DesignerProperty: Key: ValueOrientation, DisplayName: Value Orientation, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical, Description: Orientation of values inside bars
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color for values printed inside bars
#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 36, Description: Font size for bar values
#DesignerProperty: Key: ShowMeanLine, DisplayName: Show Mean Line, FieldType: Boolean, DefaultValue: False, Description: Render horizontal line at calculated mean value
#DesignerProperty: Key: MeanLineColor, DisplayName: Mean Line Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the optional mean value line
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched category
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when the category is touched
#DesignerProperty: Key: ShowPopupLegendTotal, DisplayName: Show Popup Legend Total, FieldType: Boolean, DefaultValue: False, Description: Show total value in the popup legend when a category is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type ColumnSeries (Name As String, Color As Int, Values As List)
	Type ColumnBarClickResult (CategoryIndex As Int, CategoryLabel As String, ColumnValues As Map, ColumnSum As Float)
	Type ColumnBarTouchResult (CategoryIndex As Int, CategoryLabel As String, ColumnValues As Map, ColumnSum As Float)
	
	Private mTitle As String
	Private mSubTitle As String
	Private mSubTitleColor As Int
	Private mXAxisTitle As String
	Private mYAxisTitle As String
	Private mAxisColor As Int
	Private mGridColor As Int
	Private mTextColor As Int
	Private mValueTextColor As Int
	Private mDepth As Float
	Private mFontSize As Int
	Private mValueOrientation As String = "Horizontal"
	Private mShowValues As Boolean
	Private mShowLegend As Boolean
	Private mShowLegendOnChart As Boolean
	Private mShowLegendValues As Boolean
	Private mShowMeanLine As Boolean
	Private mMeanLineColor As Int
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
	Private mMaxValue As Float = 1.0
	Private mRawMaxValue As Float = 1.0
	Private mMinValue As Float = 0.0
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	Private LastTouchedIndex As Int = -1
	#End If
	
	' Performance optimizations: Caching, Arrays and Coalesced Rendering
	Type CachedColumnBarColors (Base As Object, Top As Object, Side As Object, Outline As Object)
	Private SeriesColorsList As List
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
	
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	mXAxisTitle = Props.GetDefault("XAxisTitle", "")
	mYAxisTitle = Props.GetDefault("YAxisTitle", "")
	mAxisColor = xui.PaintOrColorToColor(Props.GetDefault("AxisColor", 0xFF888888))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFE0E0E0))
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_DarkGray))
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_White))
	mDepth = DipToCurrent(Props.GetDefault("Depth", 15))
	mFontSize = Props.GetDefault("FontSize", 11)
	mValueOrientation = Props.GetDefault("ValueOrientation", "Horizontal")
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowLegend = Props.GetDefault("ShowLegend", True)
	mShowLegendOnChart = Props.GetDefault("ShowLegendOnChart", False)
	mShowLegendValues = Props.GetDefault("ShowLegendValues", True)
	mShowMeanLine = Props.GetDefault("ShowMeanLine", False)
	mMeanLineColor = xui.PaintOrColorToColor(Props.GetDefault("MeanLineColor", xui.Color_Black))
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
			Dim res As ColumnBarTouchResult
			res.Initialize
			res.CategoryIndex = catIdx
			res.CategoryLabel = CategoryLabels.Get(catIdx)
			res.ColumnValues.Initialize
			
			Dim colSum As Float = 0
			For sIdx = 0 To SeriesList.Size - 1
				Dim ss As ColumnSeries = SeriesList.Get(sIdx)
				If catIdx < ss.Values.Size Then
					Dim val As Float = ss.Values.Get(catIdx)
					res.ColumnValues.Put(ss.Name, val)
					colSum = colSum + val
				End If
			Next
			res.ColumnSum = colSum
			
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
	Dim seriesCount As Int = SeriesList.Size
	
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	Dim headerHeight As Float = DrawHeader
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And seriesCount > 0 Then legendHeight = 30dip
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
	
	Dim catW As Float = plotWidth / count
	Dim catSpacing As Float = catW * 0.2
	
	For catIdx = 0 To count - 1
		Dim catStartX As Float = plotX + (catSpacing / 2) + (catIdx * catW)
		Dim catEndX As Float = catStartX + catW
		
		If touchX >= catStartX And touchX <= catEndX Then
			Return catIdx
		End If
	Next
	
	Return -1
End Sub

Private Sub HandleClick(clickX As Float, clickY As Float)
	Dim catIdx As Int = GetCategoryIndexAt(clickX, clickY)
	If catIdx >= 0 Then
		If SubExists(mCallBack, mEventName & "_ItemClick") Then
			Dim res As ColumnBarClickResult
			res.Initialize
			res.CategoryIndex = catIdx
			res.CategoryLabel = CategoryLabels.Get(catIdx)
			res.ColumnValues.Initialize
			
			Dim colSum As Float = 0
			For sIdx = 0 To SeriesList.Size - 1
				Dim ss As ColumnSeries = SeriesList.Get(sIdx)
				If catIdx < ss.Values.Size Then
					Dim val As Float = ss.Values.Get(catIdx)
					res.ColumnValues.Put(ss.Name, val)
					colSum = colSum + val
				End If
			Next
			res.ColumnSum = colSum
			
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
	fontValue = xui.CreateDefaultFont(mFontSize)
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
	Dim range As Float = mMaxValue - mMinValue
	If range = 0 Then range = 1.0
	For i = 0 To mGridSteps
		Dim gridVal As Float = mMinValue + (range / mGridSteps) * i
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

' Set the orientation for the value text (Horizontal or Vertical).
Public Sub setValueOrientation(OrientationStr As String)
	If OrientationStr.ToUpperCase = "VERTICAL" Then
		mValueOrientation = "Vertical"
	Else
		mValueOrientation = "Horizontal"
	End If
	RequestRedraw
End Sub

' Set whether numbers are rendered inside chart bars.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

' Set whether displaying the series legend at the bottom of the chart is enabled.
Public Sub setShowLegend(Enabled As Boolean)
	mShowLegend = Enabled
	RequestRedraw
End Sub

' Sets whether displaying the series legend on the top right-hand side of the chart area is enabled.
Public Sub setShowLegendOnChart(Enabled As Boolean)
	mShowLegendOnChart = Enabled
	RequestRedraw
End Sub

'' Gets whether the series legend is displayed on the chart area.
'Public Sub getShowLegendOnChart As Boolean
'	Return mShowLegendOnChart
'End Sub

' Set whether displaying the series values on the left of the legend items is enabled.
Public Sub setShowLegendValues(Enabled As Boolean)
	mShowLegendValues = Enabled
	RequestRedraw
End Sub

' Set whether a popup legend is displayed when a category is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	RequestRedraw
End Sub

' Set whether the total is displayed in the popup legend.
Public Sub setShowPopupLegendTotal(Enabled As Boolean)
	mShowPopupLegendTotal = Enabled
	RequestRedraw
End Sub

' Set whether drawing the horizontal mean aggregate line is enabled.
Public Sub setShowMeanLine(Enabled As Boolean)
	mShowMeanLine = Enabled
	RequestRedraw
End Sub

' Set the color for the average calculated mean line.
Public Sub setMeanLineColor(Clr As Int)
	mMeanLineColor = Clr
	RequestRedraw
End Sub

' Set whether rendering a line through the touched category is enabled.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

' Set the text color for the axis labels.
Public Sub setTextColor(Clr As Int)
	mTextColor = Clr
	RequestRedraw
End Sub

' Set the text color for the values printed inside bars.
Public Sub setValueTextColor(Clr As Int)
	mValueTextColor = Clr
	RequestRedraw
End Sub

' Set the font size for bar values.
Public Sub setFontSize(Size As Int)
	mFontSize = Size
	UpdateFonts
	RequestRedraw
End Sub

' Set the chart's main title text.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

' Set the chart's sub-title text.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

' Set the color for the chart's sub-title text.
Public Sub setSubTitleColor(Clr As Int)
	mSubTitleColor = Clr
	RequestRedraw
End Sub

' Set the text displayed under the X-Axis.
Public Sub setXAxisTitle(Text As String)
	mXAxisTitle = Text
	RequestRedraw
End Sub

' Set the title displayed next to the Y-Axis.
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
	RecalculateMaxMin
	RequestRedraw
End Sub

' Clears out existing value data.
Public Sub Clear
	SeriesList.Clear
	SeriesColorsList.Clear
	mRawMaxValue = 1.0
	mMaxValue = 1.0
	mMinValue = 0.0
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
	mRawMaxValue = 1.0
	mMaxValue = 1.0
	mMinValue = 0.0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

' Registers group sequences combining sequential values across all mapped horizontal nodes.
Public Sub AddSeries(SeriesName As String, Values() As Float, Color As Int)
	Dim ss As ColumnSeries
	ss.Initialize
	ss.Name = SeriesName
	ss.Color = Color
	ss.Values.Initialize
	
	For i = 0 To Values.Length - 1
		ss.Values.Add(Values(i))
		If Values(i) > mRawMaxValue Then mRawMaxValue = Values(i)
		If Values(i) < mMinValue Then mMinValue = Values(i)
	Next
	
	SeriesList.Add(ss)
	
	Dim ccbc As CachedColumnBarColors
	ccbc.Initialize
	#If B4J
	ccbc.Base = GetFXColor(Color)
	ccbc.Top = GetFXColor(LightenColor(Color, 1.25))
	ccbc.Side = GetFXColor(DarkenColor(Color, 0.75))
	ccbc.Outline = GetFXColor(DarkenColor(Color, 0.5))
	#Else
	ccbc.Base = Color
	ccbc.Top = LightenColor(Color, 1.25)
	ccbc.Side = DarkenColor(Color, 0.75)
	ccbc.Outline = DarkenColor(Color, 0.5)
	#End If
	SeriesColorsList.Add(ccbc)
	
	If mRawMaxValue = 0 And mMinValue = 0 Then mRawMaxValue = 1.0
	RequestRedraw
End Sub

Private Sub RecalculateMaxMin 'ignore
	mRawMaxValue = 0.0
	mMinValue = 0.0
	If CategoryLabels.Size = 0 Or SeriesList.Size = 0 Then
		mRawMaxValue = 1.0
		Return
	End If
	
	For Each ss As ColumnSeries In SeriesList
		For Each val As Float In ss.Values
			If val > mRawMaxValue Then mRawMaxValue = val
			If val < mMinValue Then mMinValue = val
		Next
	Next
	If mRawMaxValue = 0 And mMinValue = 0 Then mRawMaxValue = 1.0
End Sub

' Commits drawing changes and outputs to the canvas view.
Public Sub Redraw
	If mBase.IsInitialized = False Then Return
	If mBase.Width <= 0 Or mBase.Height <= 0 Then Return
	
	Dim rect As B4XRect
	rect.Initialize(0, 0, mBase.Width, mBase.Height)
	cvs.ClearRect(rect)
	
	Dim headerHeight As Float = DrawHeader
	If CategoryLabels.Size = 0 Or SeriesList.Size = 0 Then
		cvs.Invalidate
		Return
	End If
	
	' Dynamic Scale Calculations with Headroom
	mMaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	
	Dim count As Int = CategoryLabels.Size
	Dim seriesCount As Int = SeriesList.Size
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And seriesCount > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + mDepth
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If plotHeight <= 0 Or plotWidth <= 0 Then Return
	
	' Dynamic Scale Calculations
	Dim range As Float = mMaxValue - mMinValue
	If range = 0 Then range = 1.0
	
	' Y-coordinate for value 0.0
	Dim zeroY As Float = plotY + plotHeight - (((0.0 - mMinValue) / range) * plotHeight)
	
	' Y-Axis Scale Values & Horizontal Grid Lines
	For i = 0 To mGridSteps
		Dim gridVal As Float = mMinValue + (range / mGridSteps) * i
		Dim yPos As Float = (plotY + plotHeight) - (i * (plotHeight / mGridSteps))
		
		cvs.DrawLine(plotX, yPos, plotX + plotWidth + mDepth, yPos, mGridColor, 1dip)
		
		Dim valText As String = NumberFormat(gridVal, 1, 0)
		cvs.DrawText(valText, plotX - 5dip, yPos + 4dip, fontAxis, mTextColor, "RIGHT")
	Next
	
	' Y-Axis Line
	cvs.DrawLine(plotX, plotY, plotX, plotY + plotHeight, mAxisColor, 1.5dip)
	
	Dim catW As Float = plotWidth / count
	Dim availableCatW As Float = catW * 0.8
	Dim barW As Float = availableCatW / seriesCount
	Dim catSpacing As Float = catW * 0.2
	
	Dim totalSum As Float = 0
	Dim totalItems As Int = 0
	Dim lowestVal As Float = 3.4028235E38
	Dim lowestBarCenterX As Float = plotX
	
	' Render 3D Bars & X-Axis Labels
	For catIdx = 0 To count - 1
		Dim catStartX As Float = plotX + (catSpacing / 2) + (catIdx * catW)
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
			If catIdx < ss.Values.Size Then
				Dim val As Float = ss.Values.Get(catIdx)
				totalSum = totalSum + val
				totalItems = totalItems + 1
				
				Dim startX As Float = catStartX + (sIdx * barW)
				
				If val < lowestVal Then
					lowestVal = val
					lowestBarCenterX = startX + (barW / 2) + mDepth
				End If
				
				Dim barH As Float = (Abs(val) / range) * plotHeight
				
				Dim baselineY As Float = zeroY
				If val < 0 Then baselineY = zeroY + barH
				
				DrawSingle3DBar(startX, baselineY, barW, barH, mDepth, sIdx, val)
			End If
		Next
		
		Dim centerX As Float = catStartX + (availableCatW / 2)
		Dim labelY As Float = plotY + plotHeight + 18dip
		cvs.DrawText(CategoryLabels.Get(catIdx), centerX, labelY, fontAxis, mTextColor, "CENTER")
	Next
	
	' Render Touch Line over the active touched category
	#If B4J Or B4A
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim catStartX As Float = plotX + (catSpacing / 2) + (LastTouchedIndex * catW)
		Dim centerX As Float = catStartX + (availableCatW / 2)
		cvs.DrawLine(centerX, plotY, centerX, plotY + plotHeight, mTouchLineColor, 2dip)
		
		If mShowPopupLegend Then
			Dim lines As List
			lines.Initialize
			Dim colSum As Float = 0
			For sIdx = 0 To seriesCount - 1
				Dim ssTouch As ColumnSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < ssTouch.Values.Size Then
					colSum = colSum + ssTouch.Values.Get(LastTouchedIndex)
				End If
			Next
			
			lines.Add(CategoryLabels.Get(LastTouchedIndex))
			For sIdx = 0 To seriesCount - 1
				Dim ssTouch As ColumnSeries = SeriesList.Get(sIdx)
				If LastTouchedIndex < ssTouch.Values.Size Then
					lines.Add(ssTouch.Name & ": " & NumberFormat(ssTouch.Values.Get(LastTouchedIndex), 1, 0))
				End If
			Next
			If mShowPopupLegendTotal Then
				lines.Add("Total: " & NumberFormat(colSum, 1, 0))
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
	
	' Render Zero Axis Baseline
	cvs.DrawLine(plotX, zeroY, plotX + plotWidth + mDepth, zeroY, mAxisColor, 1.5dip)
	
	' Render Optional Mean Line over the lowest value bar area
	If mShowMeanLine And totalItems > 0 Then
		Dim meanVal As Float = totalSum / totalItems
		Dim meanY As Float = (plotY + plotHeight) - (((meanVal - mMinValue) / range) * plotHeight)
		
		' Draw Dashed Horizontal Mean Line
		Dim dashLen As Float = 6dip
		Dim gapLen As Float = 4dip
		Dim currentX As Float = plotX
		Dim endX As Float = plotX + plotWidth + mDepth
		
		Do While currentX < endX
			Dim nextX As Float = Min(currentX + dashLen, endX)
			cvs.DrawLine(currentX, meanY, nextX, meanY, mMeanLineColor, 1.5dip)
			currentX = currentX + dashLen + gapLen
		Loop
		
		Dim meanTxt As String = NumberFormat(meanVal, 1, 1)
		
		Dim r As B4XRect = cvs.MeasureText(meanTxt, fontAxis)
		Dim boxWidth As Float = r.Width + 10dip
		Dim boxHeight As Float = r.Height + 6dip
		Dim bgRect As B4XRect
		bgRect.Initialize(lowestBarCenterX - (boxWidth / 2), meanY - (boxHeight / 2), lowestBarCenterX + (boxWidth / 2), meanY + (boxHeight / 2))
		
		cvs.DrawRect(bgRect, xui.Color_White, True, 0)
		cvs.DrawRect(bgRect, xui.Color_LightGray, False, 1dip)
		
		Dim textY As Float = meanY - r.Top - (r.Height / 2)
		cvs.DrawText(meanTxt, lowestBarCenterX, textY, fontAxis, mMeanLineColor, "CENTER")
	End If

	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, plotX + (plotWidth / 2), plotY + plotHeight + 35dip, fontAxisTitle, mTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, plotY + (plotHeight / 2), fontAxisTitle, mTextColor, "CENTER", -90)
	End If
	
	' Draw Bottom Legend
	If mShowLegend And Not(mShowLegendOnChart) And seriesCount > 0 Then
		Dim legendY As Float = mBase.Height - 15dip
		Dim totalLegendWidth As Float = 0
		
		Dim seriesTotals(seriesCount) As Float
		For sIdx = 0 To seriesCount - 1
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
			Dim sTotal As Float = 0
			For Each val As Float In ss.Values
				sTotal = sTotal + val
			Next
			seriesTotals(sIdx) = sTotal
		Next
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
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
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
			
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
	If mShowLegend And mShowLegendOnChart And seriesCount > 0 Then
		Dim maxTextW As Float = 0
		Dim seriesTotals(seriesCount) As Float
		
		For sIdx = 0 To seriesCount - 1
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
			Dim sTotal As Float = 0
			For Each val As Float In ss.Values
				sTotal = sTotal + val
			Next
			seriesTotals(sIdx) = sTotal
			
			Dim itemName As String = ss.Name
			If mShowLegendValues Then
				itemName = NumberFormat(sTotal, 1, 0) & "  " & ss.Name
			End If
			Dim txtRect As B4XRect = cvs.MeasureText(itemName, fontAxis)
			If txtRect.Width > maxTextW Then maxTextW = txtRect.Width
		Next
		
		Dim itemH As Float = fontAxis.Size + 8dip
		Dim boxWidth As Float = 12dip + 6dip + maxTextW + 16dip
		Dim boxHeight As Float = (seriesCount * itemH) + 12dip
		
		Dim boxLeft As Float = plotX + plotWidth - boxWidth
		Dim boxTop As Float = plotY + 4dip
		
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
			Dim ss As ColumnSeries = SeriesList.Get(sIdx)
			Dim curX As Float = boxLeft + 8dip
			
			If mShowLegendValues Then
				Dim totalTxt As String = NumberFormat(seriesTotals(sIdx), 1, 0)
				cvs.DrawText(totalTxt, curX, currentItemY + (itemH / 2) + textBaselineOffset, fontAxis, mTextColor, "LEFT")
				Dim valRect As B4XRect = cvs.MeasureText(totalTxt, fontAxis)
				curX = curX + valRect.Width + 6dip
			End If
			
			Dim rColorBox As B4XRect
			rColorBox.Initialize(curX, currentItemY + 2dip, curX + 12dip, currentItemY + 12dip)
			cvs.DrawRect(rColorBox, ss.Color, True, 0)
			cvs.DrawRect(rColorBox, mTextColor, False, 1dip)
			
			curX = curX + 12dip + 6dip
			cvs.DrawText(ss.Name, curX, currentItemY + (itemH / 2) + textBaselineOffset, fontAxis, mTextColor, "LEFT")
			
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
Private Sub DrawSingle3DBar(x As Float, y As Float, w As Float, h As Float, depth As Float, sIdx As Int, val As Float)
	Dim ccbc As CachedColumnBarColors = SeriesColorsList.Get(sIdx)
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
	gc.RunMethod("setFill", Array(ccbc.Base))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(ccbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Right Side Face
	xPoints(0) = pFrontTRX : yPoints(0) = pFrontTRY
	xPoints(1) = pBackTRX : yPoints(1) = pBackTRY
	xPoints(2) = pBackBRX : yPoints(2) = pBackBRY
	xPoints(3) = pFrontBRX : yPoints(3) = pFrontBRY
	gc.RunMethod("setFill", Array(ccbc.Side))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(ccbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Top Face
	xPoints(0) = pFrontTLX : yPoints(0) = pFrontTLY
	xPoints(1) = pBackTLX : yPoints(1) = pBackTLY
	xPoints(2) = pBackTRX : yPoints(2) = pBackTRY
	xPoints(3) = pFrontTRX : yPoints(3) = pFrontTRY
	gc.RunMethod("setFill", Array(ccbc.Top))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(ccbc.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Render Value Text inside bar center if enabled
	If mShowValues Then
		Dim valTxt As String = NumberFormat(val, 1, 0)
		Dim centerX As Float = x + (w / 2)
		
		If mValueOrientation.ToUpperCase = "VERTICAL" Then
			Dim charHeight As Float = mFontSize * 1.15
			Dim totalTxtH As Float = valTxt.Length * charHeight
			
			If h >= totalTxtH Then
				Dim startY As Float = y - (h / 2) - (totalTxtH / 2) + charHeight
				For i = 0 To valTxt.Length - 1
					Dim ch As String = valTxt.CharAt(i)
					Dim charY As Float = startY + (i * charHeight)
					cvs.DrawText(ch, centerX, charY, fontValue, mValueTextColor, "CENTER")
				Next
			End If
		Else
			If h >= mFontSize + 2dip And w >= cvs.MeasureText(valTxt, fontValue).Width + 2dip Then
				Dim centerY As Float = y - (h / 2) + (mFontSize / 3)
				cvs.DrawText(valTxt, centerX, centerY, fontValue, mValueTextColor, "CENTER")
			End If
		End If
	End If
End Sub
#Else
Private Sub DrawSingle3DBar(x As Float, y As Float, w As Float, h As Float, depth As Float, sIdx As Int, val As Float)
	Dim ccbc As CachedColumnBarColors = SeriesColorsList.Get(sIdx)
	
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
	cvs.DrawPath(pathFront, ccbc.Base, True, 0)
	
	' Right Side Face
	Dim pathRight As B4XPath
	pathRight.Initialize(pFrontTRX, pFrontTRY)
	pathRight.LineTo(pBackTRX, pBackTRY)
	pathRight.LineTo(pBackBRX, pBackBRY)
	pathRight.LineTo(pFrontBRX, pFrontBRY)
	pathRight.LineTo(pFrontTRX, pFrontTRY)
	cvs.DrawPath(pathRight, ccbc.Side, True, 0)
	
	' Top Face
	Dim pathTop As B4XPath
	pathTop.Initialize(pFrontTLX, pFrontTLY)
	pathTop.LineTo(pBackTLX, pBackTLY)
	pathTop.LineTo(pBackTRX, pBackTRY)
	pathTop.LineTo(pFrontTRX, pFrontTRY)
	pathTop.LineTo(pFrontTLX, pFrontTLY)
	cvs.DrawPath(pathTop, ccbc.Top, True, 0)
	
	' Outlines
	cvs.DrawPath(pathFront, ccbc.Outline, False, 1dip)
	cvs.DrawPath(pathRight, ccbc.Outline, False, 1dip)
	cvs.DrawPath(pathTop, ccbc.Outline, False, 1dip)
	
	' Render Value Text inside bar center if enabled
	If mShowValues Then
		Dim valTxt As String = NumberFormat(val, 1, 0)
		Dim centerX As Float = x + (w / 2)
		
		If mValueOrientation.ToUpperCase = "VERTICAL" Then
			Dim charHeight As Float = mFontSize * 1.15
			Dim totalTxtH As Float = valTxt.Length * charHeight
			
			If h >= totalTxtH Then
				Dim startY As Float = y - (h / 2) - (totalTxtH / 2) + charHeight
				For i = 0 To valTxt.Length - 1
					Dim ch As String = valTxt.CharAt(i)
					Dim charY As Float = startY + (i * charHeight)
					cvs.DrawText(ch, centerX, charY, fontValue, mValueTextColor, "CENTER")
				Next
			End If
		Else
			If h >= mFontSize + 2dip And w >= cvs.MeasureText(valTxt, fontValue).Width + 2dip Then
				Dim centerY As Float = y - (h / 2) + (mFontSize / 3)
				cvs.DrawText(valTxt, centerX, centerY, fontValue, mValueTextColor, "CENTER")
			End If
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
