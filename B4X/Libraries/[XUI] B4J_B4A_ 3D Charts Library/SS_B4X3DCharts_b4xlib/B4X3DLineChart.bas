B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As LinePointClickResult)
#Event: ItemTouch (Result As LinePointTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: 3D Line Chart, Description: Main chart title text
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: Performance Metrics, Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the sub-title text
#DesignerProperty: Key: XAxisTitle, DisplayName: X-Axis Title, FieldType: String, DefaultValue: , Description: Title for the horizontal axis
#DesignerProperty: Key: YAxisTitle, DisplayName: Y-Axis Title, FieldType: String, DefaultValue: , Description: Title for the vertical axis
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis label text color
#DesignerProperty: Key: GridSteps, DisplayName: Grid Steps, FieldType: Int, DefaultValue: 4, MinRange: 2, MaxRange: 20, Description: Number of grid lines / value steps
#DesignerProperty: Key: AxisColor, DisplayName: Axis Color, FieldType: Color, DefaultValue: 0xFF888888, Description: Color of axis lines
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFE0E0E0, Description: Color of horizontal gridlines
#DesignerProperty: Key: Depth, DisplayName: Ribbon Depth, FieldType: Int, DefaultValue: 12, MinRange: 1, MaxRange: 40, Description: 3D ribbon depth thickness in dip
#DesignerProperty: Key: ShowLegend, DisplayName: Show Legend, FieldType: Boolean, DefaultValue: True, Description: Show series legend
#DesignerProperty: Key: ShowLegendOnChart, DisplayName: Show Legend On Chart, FieldType: Boolean, DefaultValue: False, Description: Show series legend on the top right-hand side of the chart area
#DesignerProperty: Key: ShowPoints, DisplayName: Show Points, FieldType: Boolean, DefaultValue: True, Description: Render filled circles on the data points (only visible if Ribbon Depth <= 3)
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Show numeric value text over points
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color for numeric values printed over points
#DesignerProperty: Key: ValueFontSize, DisplayName: Value Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 36, Description: Font size for point values
#DesignerProperty: Key: ShowMeanLine, DisplayName: Show Mean Line, FieldType: Boolean, DefaultValue: False, Description: Render horizontal line at calculated mean value
#DesignerProperty: Key: MeanLineColor, DisplayName: Mean Line Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the optional mean value line
#DesignerProperty: Key: ShowMeanLines, DisplayName: Show Mean Lines, FieldType: Boolean, DefaultValue: False, Description: Render horizontal mean lines for each individual series
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
	
	Type CustomLinePoint (X As Float, Y As Float)
	Type LineSeries (Name As String, Values As List, Color As Int)
	Type LinePointClickResult (SeriesIndex As Int, PointIndex As Int, Value As Float, SeriesName As String, CategoryLabel As String, CategoryTotal As Float, StackValues As Map)
	Type LinePointTouchResult (SeriesIndex As Int, PointIndex As Int, Value As Float, SeriesName As String, CategoryLabel As String, CategoryTotal As Float, StackValues As Map)
	
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
	Private mShowPoints As Boolean
	Private mShowValues As Boolean
	Private mShowMeanLine As Boolean
	Private mShowMeanLines As Boolean
	Private mMeanLineColor As Int
	Private mShowLegend As Boolean
	Private mShowLegendOnChart As Boolean
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
	Private LastTouchedPointIndex As Int = -1
	#End If
	
	' Performance optimizations: Caching, Arrays and Coalesced Rendering
	Type CachedLineColors (Top As Object, Front As Object, Outline As Object)
	Private SeriesColorsList As List
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoly(4) As Double
	Private yPoly(4) As Double
	#End If
End Sub

' Initialises the chart view framework and internal data items.
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
	mDepth = DipToCurrent(Props.GetDefault("Depth", 12))
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_DarkGray))
	mValueFontSize = Props.GetDefault("ValueFontSize", 11)
	mShowPoints = Props.GetDefault("ShowPoints", True)
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowMeanLine = Props.GetDefault("ShowMeanLine", False)
	mShowMeanLines = Props.GetDefault("ShowMeanLines", False)
	mMeanLineColor = xui.PaintOrColorToColor(Props.GetDefault("MeanLineColor", xui.Color_Black))
	mShowLegend = Props.GetDefault("ShowLegend", True)
	mShowLegendOnChart = Props.GetDefault("ShowLegendOnChart", False)
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
		If LastTouchedPointIndex <> -1 Then
			LastTouchedPointIndex = -1
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
			RequestRedraw
		End If
	End If
End Sub

Private Sub HandleTouchMove(touchX As Float, touchY As Float)
	Dim foundPoint As Int = -1
	
	If SeriesList.Size > 0 Then
		foundPoint = GetCategoryIndexAtTouch(touchX, touchY)
	End If
	
	If foundPoint <> LastTouchedPointIndex Then
		LastTouchedPointIndex = foundPoint
		
		If foundPoint >= 0 Then
			Dim s As LineSeries = SeriesList.Get(0)
			Dim val As Float = 0
			If foundPoint < s.Values.Size Then
				val = s.Values.Get(foundPoint)
			End If
			
			Dim res As LinePointTouchResult
			res.Initialize
			res.SeriesIndex = 0
			res.PointIndex = foundPoint
			res.Value = val
			res.SeriesName = s.Name
			If foundPoint < CategoryLabels.Size Then
				res.CategoryLabel = CategoryLabels.Get(foundPoint)
			Else
				res.CategoryLabel = ""
			End If
			
			res.StackValues.Initialize
			Dim catTotal As Float = 0
			For checkSIdx = 0 To SeriesList.Size - 1
				Dim checkS As LineSeries = SeriesList.Get(checkSIdx)
				If foundPoint < checkS.Values.Size Then
					Dim seriesVal As Float = checkS.Values.Get(foundPoint)
					res.StackValues.Put(checkS.Name, seriesVal)
					catTotal = catTotal + seriesVal
				End If
			Next
			res.CategoryTotal = catTotal
			
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

Private Sub GetCategoryIndexAtTouch(touchX As Float, touchY As Float) As Int
	Dim headerHeight As Float = DrawHeader
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	Dim totalDepthOffset As Float = Max(1, SeriesList.Size) * (mDepth * 0.8)
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 16dip
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + totalDepthOffset
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If touchX >= plotX And touchX <= plotX + plotWidth + totalDepthOffset And touchY >= plotY And touchY <= plotY + plotHeight Then
		Dim numPoints As Int = CategoryLabels.Size
		For Each s As LineSeries In SeriesList
			If s.Values.Size > numPoints Then numPoints = s.Values.Size
		Next
		
		If numPoints > 0 Then
			Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
			If stepX > 0 Then
				Dim rawIdx As Int = Round((touchX - plotX) / stepX)
				Return Max(0, Min(numPoints - 1, rawIdx))
			End If
		End If
	End If
	Return -1
End Sub

Private Sub HandleClick(clickX As Float, clickY As Float)
	If SeriesList.Size = 0 Then Return
	
	Dim headerHeight As Float = DrawHeader
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	Dim totalDepthOffset As Float = Max(1, SeriesList.Size) * (mDepth * 0.8)
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 16dip
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + totalDepthOffset
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If clickX >= plotX And clickX <= plotX + plotWidth + totalDepthOffset And clickY >= plotY And clickY <= plotY + plotHeight Then
		Dim numPoints As Int = CategoryLabels.Size
		For Each s As LineSeries In SeriesList
			If s.Values.Size > numPoints Then numPoints = s.Values.Size
		Next
		
		If numPoints > 0 Then
			Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
			Dim foundPoint As Int = 0
			If stepX > 0 Then
				Dim rawIdx As Int = Round((clickX - plotX) / stepX)
				foundPoint = Max(0, Min(numPoints - 1, rawIdx))
			End If
			
			Dim s As LineSeries = SeriesList.Get(0)
			Dim val As Float = 0
			If foundPoint < s.Values.Size Then
				val = s.Values.Get(foundPoint)
			End If
			
			If SubExists(mCallBack, mEventName & "_ItemClick") Then
				Dim res As LinePointClickResult
				res.Initialize
				res.SeriesIndex = 0
				res.PointIndex = foundPoint
				res.Value = val
				res.SeriesName = s.Name
				If foundPoint < CategoryLabels.Size Then
					res.CategoryLabel = CategoryLabels.Get(foundPoint)
				Else
					res.CategoryLabel = ""
				End If
				
				res.StackValues.Initialize
				Dim catTotal As Float = 0
				For checkSIdx = 0 To SeriesList.Size - 1
					Dim checkS As LineSeries = SeriesList.Get(checkSIdx)
					If foundPoint < checkS.Values.Size Then
						Dim seriesVal As Float = checkS.Values.Get(foundPoint)
						res.StackValues.Put(checkS.Name, seriesVal)
						catTotal = catTotal + seriesVal
					End If
				Next
				res.CategoryTotal = catTotal
				
				CallSub2(mCallBack, mEventName & "_ItemClick", res)
			End If
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

' Set the base view assigned to the chart.
Public Sub GetBase As B4XView
	Return mBase
End Sub

' Set the object tag.
Public Sub getTag As Object
	Return mTag
End Sub

' Set a custom object tag.
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

' Set the line Drop Depth.
Public Sub setDropDepth(Depth As Int)
	mDepth = Depth
	RequestRedraw
End Sub

'' Set or Get the line Drop Depth.
'Public Sub getDropDepth As Int
'	Return mDepth
'End Sub

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

' Set whether drawing circles at data points is enabled (only appears if Ribbon Depth <= 3).
Public Sub setShowPoints(Enabled As Boolean)
	mShowPoints = Enabled
	RequestRedraw
End Sub

'' Set or Get whether data point circles are displayed.
'' Points are only shown if the Ribbon Depth is 1, 2, or 3
'Public Sub getShowPoints As Boolean
'	Return mShowPoints
'End Sub

' Set whether rendering numbers associated with individual ribbon points is enabled.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

'' Set or Get whether numeric points are overlayed on chart values.
'Public Sub getShowValues As Boolean
'	Return mShowValues
'End Sub

' Set whether drawing the horizontal mean aggregate line is enabled.
Public Sub setShowMeanLine(Enabled As Boolean)
	mShowMeanLine = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the mean line is displayed.
'Public Sub getShowMeanLine As Boolean
'	Return mShowMeanLine
'End Sub

' Set whether drawing the horizontal mean lines for each series is enabled.
Public Sub setShowMeanLines(Enabled As Boolean)
	mShowMeanLines = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the individual series mean lines are displayed.
'Public Sub getShowMeanLines As Boolean
'	Return mShowMeanLines
'End Sub

' Set the color for the average calculated mean line.
Public Sub setMeanLineColor(Clr As Int)
	mMeanLineColor = Clr
	RequestRedraw
End Sub

'' Set or Get the mean line color.
'Public Sub getMeanLineColor As Int
'	Return mMeanLineColor
'End Sub

' Set whether rendering a line through the touched point is enabled.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the touch line is displayed.
'Public Sub getShowTouchLine As Boolean
'	Return mShowTouchLine
'End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

'' Set or Get the touch line color.
'Public Sub getTouchLineColor As Int
'	Return mTouchLineColor
'End Sub

' Set whether a popup legend is displayed when a point is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the popup legend is enabled.
'Public Sub getShowPopupLegend As Boolean
'	Return mShowPopupLegend
'End Sub

' Set whether the total is displayed in the popup legend.
Public Sub setShowPopupLegendTotal(Enabled As Boolean)
	mShowPopupLegendTotal = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the popup legend total is enabled.
'Public Sub getShowPopupLegendTotal As Boolean
'	Return mShowPopupLegendTotal
'End Sub

' Set the text color for the line point labels.
Public Sub setValueTextColor(Clr As Int)
	mValueTextColor = Clr
	RequestRedraw
End Sub

'' Set or Get the text color for the labels.
'Public Sub getValueTextColor As Int
'	Return mValueTextColor
'End Sub

' Set the font size for line point value labels.
Public Sub setValueFontSize(Size As Int)
	mValueFontSize = Size
	UpdateFonts
	RequestRedraw
End Sub

'' Set or Get the font size for value labels.
'Public Sub getValueFontSize As Int
'	Return mValueFontSize
'End Sub

' Set whether rendering the series legend at the bottom of the chart is enabled.
Public Sub setShowLegend(Enabled As Boolean)
	mShowLegend = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the series legend is displayed.
'Public Sub getShowLegend As Boolean
'	Return mShowLegend
'End Sub

' Set whether rendering the series legend on the top right-hand side of the chart area is enabled.
Public Sub setShowLegendOnChart(Enabled As Boolean)
	mShowLegendOnChart = Enabled
	RequestRedraw
End Sub

'' Set or Get whether the series legend is displayed on the chart area.
'Public Sub getShowLegendOnChart As Boolean
'	Return mShowLegendOnChart
'End Sub

' Set the primary title text.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

'' Set or Get the primary title.
'Public Sub getTitle As String
'	Return mTitle
'End Sub

' Set the subtitle text.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

'' Set or Get the subtitle text.
'Public Sub getSubTitle As String
'	Return mSubTitle
'End Sub

' Set the color for the secondary chart subtitle.
Public Sub setSubTitleColor(Clr As Int)
	mSubTitleColor = Clr
	RequestRedraw
End Sub

'' Set or Get the sub-title text color.
'Public Sub getSubTitleColor As Int
'	Return mSubTitleColor
'End Sub

' Set the X-Axis text.
Public Sub setXAxisTitle(Text As String)
	mXAxisTitle = Text
	RequestRedraw
End Sub

'' Set or Get the X-Axis text.
'Public Sub getXAxisTitle As String
'	Return mXAxisTitle
'End Sub

' Set the Y-Axis text.
Public Sub setYAxisTitle(Text As String)
	mYAxisTitle = Text
	RequestRedraw
End Sub

'' Set or Get the Y-Axis text.
'Public Sub getYAxisTitle As String
'	Return mYAxisTitle
'End Sub

' Maps a series of text string labels to the horizontal bottom axis.
Public Sub SetCategories(Labels() As String)
	CategoryLabels.Clear
	For i = 0 To Labels.Length - 1
		CategoryLabels.Add(Labels(i))
	Next
	RequestRedraw
End Sub

' Truncates existing numeric data streams in the chart instances without deleting category definitions.
Public Sub Clear
	SeriesList.Clear
	SeriesColorsList.Clear
	mRawMaxValue = 1.0
	mMaxValue = 1.0
	mMinValue = 0.0
	#If B4J Or B4A
	LastTouchedPointIndex = -1
	#End If
	RequestRedraw
End Sub

' Wipes chart categories and all stored value lists to empty out the structure.
Public Sub ClearAll
	SeriesList.Clear
	CategoryLabels.Clear
	SeriesColorsList.Clear
	mRawMaxValue = 1.0
	mMaxValue = 1.0
	mMinValue = 0.0
	#If B4J Or B4A
	LastTouchedPointIndex = -1
	#End If
	RequestRedraw
End Sub

' Creates and inserts a completely new line series containing specific values.
Public Sub AddSeries(SeriesName As String, Values() As Float, Color As Int)
	Dim s As LineSeries
	s.Initialize
	s.Name = SeriesName
	s.Color = Color
	s.Values.Initialize
	
	For i = 0 To Values.Length - 1
		s.Values.Add(Values(i))
		If Values(i) > mRawMaxValue Then mRawMaxValue = Values(i)
		If Values(i) < mMinValue Then mMinValue = Values(i)
	Next
	SeriesList.Add(s)
	
	Dim clc As CachedLineColors
	clc.Initialize
	#If B4J
	clc.Top = GetFXColor(LightenColor(Color, 1.2))
	clc.Front = GetFXColor(Color)
	clc.Outline = GetFXColor(DarkenColor(Color, 0.6))
	#Else
	clc.Top = LightenColor(Color, 1.2)
	clc.Front = Color
	clc.Outline = DarkenColor(Color, 0.6)
	#End If
	SeriesColorsList.Add(clc)
	
	RequestRedraw
End Sub

' Initiates painting sequence across the current graphical canvas base.
Public Sub Redraw
	cvs.ClearRect(cvs.TargetRect)
	
	Dim headerHeight As Float = DrawHeader
	
	If SeriesList.Size = 0 Then
		cvs.Invalidate
		Return
	End If
	
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	
	' Compute nice max headroom before measuring labels
	mMaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	
	Dim totalDepthOffset As Float = Max(1, SeriesList.Size) * (mDepth * 0.8)
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 16dip
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	Dim bottomPadding As Float = 40dip + legendHeight
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim rightPadding As Float = 20dip + totalDepthOffset
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If plotHeight <= 0 Or plotWidth <= 0 Then Return
	
	Dim valRange As Float = Max(0.001, mMaxValue - mMinValue)
	
	Dim totalSum As Float = 0
	Dim totalItems As Int = 0
	
	If SeriesList.Size > 0 Then
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			Dim numPoints As Int = CategoryLabels.Size
			If numPoints < 2 Then numPoints = s.Values.Size
			Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
			
			For pIdx = 0 To s.Values.Size - 1
				Dim val As Float = s.Values.Get(pIdx)
				totalSum = totalSum + val
				totalItems = totalItems + 1
			Next
		Next
	End If
	
	' 1. Y-Axis Scale Lines and Labels
	For i = 0 To mGridSteps
		Dim gridVal As Float = mMinValue + (valRange / mGridSteps) * i
		Dim yPos As Float = (plotY + plotHeight) - (i * (plotHeight / mGridSteps))
		
		cvs.DrawLine(plotX, yPos, plotX + plotWidth + totalDepthOffset, yPos, mGridColor, 1dip)
		
		Dim valText As String = NumberFormat(gridVal, 1, 0)
		cvs.DrawText(valText, plotX - 5dip, yPos + 4dip, fontAxis, mTextColor, "RIGHT")
	Next
	
	' Y-Axis Baseline Line
	cvs.DrawLine(plotX, plotY, plotX, plotY + plotHeight, mAxisColor, 1.5dip)
	
	' 2. Render 3D Ribbon Lines (Back to Front)
	If SeriesList.Size > 0 Then
		For sIdx = SeriesList.Size - 1 To 0 Step -1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			
			Draw3DRibbonLine(s, sIdx, plotX, plotY, plotWidth, plotHeight)
		Next
	End If
	
	' Render Optional Mean Line over the lowest value point area
	If mShowMeanLine And totalItems > 0 Then
		Dim meanVal As Float = totalSum / totalItems
		Dim meanY As Float = (plotY + plotHeight) - (((meanVal - mMinValue) / valRange) * plotHeight)
		
		' Draw Dashed Horizontal Mean Line
		Dim dashLen As Float = 6dip
		Dim gapLen As Float = 4dip
		Dim currentX As Float = plotX
		Dim endX As Float = plotX + plotWidth + totalDepthOffset
		
		Do While currentX < endX
			Dim nextX As Float = Min(currentX + dashLen, endX)
			cvs.DrawLine(currentX, meanY, nextX, meanY, mMeanLineColor, 1.5dip)
			currentX = currentX + dashLen + gapLen
		Loop
		
		Dim meanCenterX As Float = plotX + ((plotWidth + totalDepthOffset) / 2)
		Dim meanTxt As String = NumberFormat(meanVal, 1, 1)
		Dim r As B4XRect = cvs.MeasureText(meanTxt, fontAxis)
		Dim boxWidth As Float = r.Width + 10dip
		Dim boxHeight As Float = r.Height + 6dip
		Dim bgRect As B4XRect
		bgRect.Initialize(meanCenterX - (boxWidth / 2), meanY - (boxHeight / 2), meanCenterX + (boxWidth / 2), meanY + (boxHeight / 2))
		
		cvs.DrawRect(bgRect, xui.Color_White, True, 0)
		cvs.DrawRect(bgRect, xui.Color_LightGray, False, 1dip)
		
		Dim textY As Float = meanY - r.Top - (r.Height / 2)
		cvs.DrawText(meanTxt, meanCenterX, textY, fontAxis, mMeanLineColor, "CENTER")
	End If

	' Render Individual Mean Lines for each series
	If mShowMeanLines And SeriesList.Size > 0 Then
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			Dim sSum As Float = 0
			Dim sItems As Int = s.Values.Size
			Dim sLowestVal As Float = 3.4028235E38
			Dim sLowestPointCenterX As Float = plotX
			
			If sItems > 0 Then
				Dim numPoints As Int = CategoryLabels.Size
				If numPoints < 2 Then numPoints = sItems
				Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
				
				For pIdx = 0 To sItems - 1
					Dim val As Float = s.Values.Get(pIdx)
					sSum = sSum + val
					If val < sLowestVal Then
						sLowestVal = val
						sLowestPointCenterX = plotX + (pIdx * stepX)
					End If
				Next
				
				Dim sMeanVal As Float = sSum / sItems
				Dim sMeanY As Float = (plotY + plotHeight) - (((sMeanVal - mMinValue) / valRange) * plotHeight)
				
				' Draw Dashed Horizontal Mean Line
				Dim dashLen As Float = 6dip
				Dim gapLen As Float = 4dip
				Dim currentX As Float = plotX
				Dim endX As Float = plotX + plotWidth + totalDepthOffset
				
				Do While currentX < endX
					Dim nextX As Float = Min(currentX + dashLen, endX)
					cvs.DrawLine(currentX, sMeanY, nextX, sMeanY, s.Color, 1.5dip)
					currentX = currentX + dashLen + gapLen
				Loop
				
				Dim sMeanTxt As String = NumberFormat(sMeanVal, 1, 1)
				Dim r As B4XRect = cvs.MeasureText(sMeanTxt, fontAxis)
				Dim boxWidth As Float = r.Width + 10dip
				Dim boxHeight As Float = r.Height + 6dip
				Dim bgRect As B4XRect
				bgRect.Initialize(sLowestPointCenterX - (boxWidth / 2), sMeanY - (boxHeight / 2), sLowestPointCenterX + (boxWidth / 2), sMeanY + (boxHeight / 2))
				
				cvs.DrawRect(bgRect, xui.Color_White, True, 0)
				cvs.DrawRect(bgRect, xui.Color_LightGray, False, 1dip)
				
				Dim textY As Float = sMeanY - r.Top - (r.Height / 2)
				cvs.DrawText(sMeanTxt, sLowestPointCenterX, textY, fontAxis, s.Color, "CENTER")
			End If
		Next
	End If
	
	' Render Touch Line and Popup Legend over everything (including mean lines)
	#If B4J Or B4A
	If mShowTouchLine And LastTouchedPointIndex >= 0 Then
		Dim numPoints As Int = CategoryLabels.Size
		If numPoints < 2 And SeriesList.Size > 0 Then
			Dim s As LineSeries = SeriesList.Get(0)
			numPoints = s.Values.Size
		End If
		If numPoints > 1 Then
			Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
			Dim touchX As Float = plotX + (LastTouchedPointIndex * stepX)
			cvs.DrawLine(touchX, plotY, touchX, plotY + plotHeight, mTouchLineColor, 2dip)
			
			If mShowPopupLegend And SeriesList.Size > 0 Then
				Dim lines As List
				lines.Initialize
				Dim catLabel As String = ""
				If LastTouchedPointIndex < CategoryLabels.Size Then
					catLabel = CategoryLabels.Get(LastTouchedPointIndex)
				Else
					catLabel = "Point " & LastTouchedPointIndex
				End If
				
				Dim catTotal As Float = 0
				For sIdx = 0 To SeriesList.Size - 1
					Dim sTouch As LineSeries = SeriesList.Get(sIdx)
					If LastTouchedPointIndex < sTouch.Values.Size Then
						catTotal = catTotal + sTouch.Values.Get(LastTouchedPointIndex)
					End If
				Next
				
				lines.Add(catLabel)
				For sIdx = 0 To SeriesList.Size - 1
					Dim sTouch As LineSeries = SeriesList.Get(sIdx)
					If LastTouchedPointIndex < sTouch.Values.Size Then
						lines.Add(sTouch.Name & ": " & NumberFormat(sTouch.Values.Get(LastTouchedPointIndex), 1, 0))
					End If
				Next
				If mShowPopupLegendTotal Then
					lines.Add("Total: " & NumberFormat(catTotal, 1, 0))
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
				For Each lineText As String In lines
					cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + (fontAxis.Size / 3), fontAxis, mTextColor, "LEFT")
					currentTextY = currentTextY + lineH
				Next
			End If
		End If
	End If
	#End If
	
	' 3. X-Axis Baseline and Category Labels
	Dim baselineY As Float = plotY + plotHeight
	cvs.DrawLine(plotX, baselineY, plotX + plotWidth + totalDepthOffset, baselineY, mAxisColor, 1.5dip)
	
	If CategoryLabels.Size > 0 Then
		Dim numPoints As Int = CategoryLabels.Size
		Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
		
		For i = 0 To CategoryLabels.Size - 1
			Dim lx As Float = plotX + (i * stepX)
			cvs.DrawText(CategoryLabels.Get(i), lx, baselineY + 16dip, fontAxis, mTextColor, "CENTER")
		Next
	End If
	
	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, plotX + (plotWidth / 2), baselineY + 34dip, fontAxisTitle, mTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, plotY + (plotHeight / 2), fontAxisTitle, mTextColor, "CENTER", -90)
	End If
	
	' Draw Bottom Legend (if enabled and not rendered on chart)
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then
		Dim legendY As Float = mBase.Height - 15dip
		Dim totalLegendWidth As Float = 0
		
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			Dim itemWidth As Float = 0
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontAxis)
			itemWidth = itemWidth + 12dip + 6dip + txtRect.Width
			
			totalLegendWidth = totalLegendWidth + itemWidth
			If sIdx < SeriesList.Size - 1 Then totalLegendWidth = totalLegendWidth + 20dip
		Next
		
		Dim currentX As Float = (mBase.Width / 2) - (totalLegendWidth / 2)
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			
			Dim r As B4XRect
			r.Initialize(currentX, legendY - 10dip, currentX + 12dip, legendY + 2dip)
			cvs.DrawRect(r, s.Color, True, 0)
			cvs.DrawRect(r, mTextColor, False, 1dip)
			
			currentX = currentX + 12dip + 6dip
			cvs.DrawText(s.Name, currentX, legendY, fontAxis, mTextColor, "LEFT")
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontAxis)
			currentX = currentX + txtRect.Width + 20dip
		Next
	End If
	
	' Draw On-Chart Legend (Top Right)
	If mShowLegend And mShowLegendOnChart And SeriesList.Size > 0 Then
		Dim maxTextW As Float = 0
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontAxis)
			If txtRect.Width > maxTextW Then maxTextW = txtRect.Width
		Next
		
		Dim itemH As Float = fontAxis.Size + 8dip
		Dim boxWidth As Float = 12dip + 6dip + maxTextW + 16dip
		Dim boxHeight As Float = (SeriesList.Size * itemH) + 12dip
		
		Dim boxLeft As Float = plotX + plotWidth - boxWidth - 10dip
		Dim boxTop As Float = plotY + 10dip
		
		Dim rBox As B4XRect
		rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
		
		cvs.DrawRect(rBox, XUI.Color_ARGB(192, 255, 255, 255), True, 0)
		cvs.DrawRect(rBox, mGridColor, False, 1dip)
		
		Dim currentItemY As Float = boxTop + 6dip
		#If B4A
		Dim textBaselineOffset As Float = fontAxis.Size / 2.5
		#Else
		Dim textBaselineOffset As Float = fontAxis.Size / 3
		#End If
		
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As LineSeries = SeriesList.Get(sIdx)
			
			Dim rColorBox As B4XRect
			rColorBox.Initialize(boxLeft + 8dip, currentItemY + 2dip, boxLeft + 8dip + 12dip, currentItemY + 12dip)
			cvs.DrawRect(rColorBox, s.Color, True, 0)
			cvs.DrawRect(rColorBox, mTextColor, False, 1dip)
			
			Dim textX As Float = boxLeft + 8dip + 12dip + 6dip
			Dim textY As Float = currentItemY + (itemH / 2)
			
			cvs.DrawText(s.Name, textX, textY + textBaselineOffset, fontAxis, mTextColor, "LEFT")
			
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
Private Sub Draw3DRibbonLine(s As LineSeries, sIdx As Int, plotX As Float, plotY As Float, plotWidth As Float, plotHeight As Float)
	Dim count As Int = s.Values.Size
	If count < 2 Then Return
	
	Dim numPoints As Int = CategoryLabels.Size
	If numPoints < 2 Then numPoints = count
	Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
	Dim clc As CachedLineColors = SeriesColorsList.Get(sIdx)
	Dim gc As JavaObject = GetGraphicsContext
	
	Dim valRange As Float = Max(0.001, mMaxValue - mMinValue)
	
	For i = 0 To count - 2
		Dim v1 As Float = s.Values.Get(i)
		Dim v2 As Float = s.Values.Get(i + 1)
		
		Dim x1 As Float = plotX + (i * stepX)
		Dim y1 As Float = (plotY + plotHeight) - (((v1 - mMinValue) / valRange) * plotHeight)
		
		Dim x2 As Float = plotX + ((i + 1) * stepX)
		Dim y2 As Float = (plotY + plotHeight) - (((v2 - mMinValue) / valRange) * plotHeight)
		
		Dim pF1X As Double = x1
		Dim pF1Y As Double = y1
		Dim pF2X As Double = x2
		Dim pF2Y As Double = y2
		
		Dim pB1X As Double = pF1X + mDepth
		Dim pB1Y As Double = pF1Y - (mDepth * 0.5)
		Dim pB2X As Double = pF2X + mDepth
		Dim pB2Y As Double = pF2Y - (mDepth * 0.5)
		
		xPoly(0) = pF1X : yPoly(0) = pF1Y
		xPoly(1) = pF2X : yPoly(1) = pF2Y
		xPoly(2) = pB2X : yPoly(2) = pB2Y
		xPoly(3) = pB1X : yPoly(3) = pB1Y
		
		gc.RunMethod("setLineWidth", Array(1.0 * xui.Scale))
		gc.RunMethod("setFill", Array(clc.Top))
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, 4))
		gc.RunMethod("setStroke", Array(clc.Outline))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, 4))
		
		gc.RunMethod("setStroke", Array(clc.Front))
		gc.RunMethod("setLineWidth", Array(3.0 * xui.Scale))
		gc.RunMethod("strokeLine", Array(pF1X, pF1Y, pF2X, pF2Y))
	Next
	
	If mShowPoints And mDepth <= 3dip Then
		For i = 0 To count - 1
			Dim val As Float = s.Values.Get(i)
			Dim x As Float = plotX + (i * stepX)
			Dim y As Float = (plotY + plotHeight) - (((val - mMinValue) / valRange) * plotHeight)
			cvs.DrawCircle(x, y, 5dip, s.Color, True, 0)
		Next
	End If
	
	If mShowValues Then
		For i = 0 To count - 1
			Dim val As Float = s.Values.Get(i)
			Dim x As Float = plotX + (i * stepX)
			Dim y As Float = (plotY + plotHeight) - (((val - mMinValue) / valRange) * plotHeight)
			
			Dim px As Float = x
			Dim py As Float = y
			
			Dim valTxt As String = NumberFormat(val, 1, 0)
			Dim align As String = "CENTER"
			If i = 0 Then
				px = x + 5dip
				align = "LEFT"
			Else If i = count - 1 Then
				px = x - 5dip
				align = "RIGHT"
			End If
			cvs.DrawText(valTxt, px, py - 6dip, fontValue, mValueTextColor, align)
		Next
	End If
End Sub
#Else
Private Sub Draw3DRibbonLine(s As LineSeries, sIdx As Int, plotX As Float, plotY As Float, plotWidth As Float, plotHeight As Float)
	Dim count As Int = s.Values.Size
	If count < 2 Then Return
	
	Dim numPoints As Int = CategoryLabels.Size
	If numPoints < 2 Then numPoints = count
	Dim stepX As Float = plotWidth / Max(1, numPoints - 1)
	Dim clc As CachedLineColors = SeriesColorsList.Get(sIdx)
	
	Dim valRange As Float = Max(0.001, mMaxValue - mMinValue)
	
	For i = 0 To count - 2
		Dim v1 As Float = s.Values.Get(i)
		Dim v2 As Float = s.Values.Get(i + 1)
		
		Dim x1 As Float = plotX + (i * stepX)
		Dim y1 As Float = (plotY + plotHeight) - (((v1 - mMinValue) / valRange) * plotHeight)
		
		Dim x2 As Float = plotX + ((i + 1) * stepX)
		Dim y2 As Float = (plotY + plotHeight) - (((v2 - mMinValue) / valRange) * plotHeight)
		
		Dim pF1 As CustomLinePoint = CreatePoint(x1, y1)
		Dim pF2 As CustomLinePoint = CreatePoint(x2, y2)
		
		Dim pB1 As CustomLinePoint = CreatePoint(pF1.X + mDepth, pF1.Y - (mDepth * 0.5))
		Dim pB2 As CustomLinePoint = CreatePoint(pF2.X + mDepth, pF2.Y - (mDepth * 0.5))
		
		Dim pathTop As B4XPath
		pathTop.Initialize(pF1.X, pF1.Y)
		pathTop.LineTo(pF2.X, pF2.Y)
		pathTop.LineTo(pB2.X, pB2.Y)
		pathTop.LineTo(pB1.X, pB1.Y)
		cvs.DrawPath(pathTop, clc.Top, True, 0)
		cvs.DrawPath(pathTop, clc.Outline, False, 1dip)
		
		cvs.DrawLine(pF1.X, pF1.Y, pF2.X, pF2.Y, clc.Front, 3dip)
	Next
	
	If mShowPoints And mDepth <= 3dip Then
		For i = 0 To count - 1
			Dim val As Float = s.Values.Get(i)
			Dim x As Float = plotX + (i * stepX)
			Dim y As Float = (plotY + plotHeight) - (((val - mMinValue) / valRange) * plotHeight)
			cvs.DrawCircle(x, y, 5dip, s.Color, True, 0)
		Next
	End If
	
	If mShowValues Then
		For i = 0 To count - 1
			Dim val As Float = s.Values.Get(i)
			Dim x As Float = plotX + (i * stepX)
			Dim y As Float = (plotY + plotHeight) - (((val - mMinValue) / valRange) * plotHeight)
			
			Dim px As Float = x
			Dim py As Float = y
			
			Dim valTxt As String = NumberFormat(val, 1, 0)
			Dim align As String = "CENTER"
			If i = 0 Then
				px = x + 5dip
				align = "LEFT"
			Else If i = count - 1 Then
				px = x - 5dip
				align = "RIGHT"
			End If
			cvs.DrawText(valTxt, px, py - 6dip, fontValue, mValueTextColor, align)
		Next
	End If
End Sub
#End If

Private Sub CreatePoint(x As Float, y As Float) As CustomLinePoint 'ignore
	Dim pt As CustomLinePoint
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
