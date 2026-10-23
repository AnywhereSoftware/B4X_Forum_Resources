B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As RadarClickResult)
#Event: ItemTouch (Result As RadarTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Radar Chart, Description: Main chart title text
#DesignerProperty: Key: TitleColor, DisplayName: Title Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Main title text color
#DesignerProperty: Key: TitleSize, DisplayName: Title Size, FieldType: Int, DefaultValue: 16, MinRange: 8, MaxRange: 36, Description: Font size for main title
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: 3D Performance Metrics, Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Subtitle text color
#DesignerProperty: Key: SubTitleSize, DisplayName: SubTitle Size, FieldType: Int, DefaultValue: 12, MinRange: 8, MaxRange: 28, Description: Font size for sub-title
#DesignerProperty: Key: ShowLegend, DisplayName: Show Legend, FieldType: Boolean, DefaultValue: True, Description: Show the series legend
#DesignerProperty: Key: ShowLegendOnChart, DisplayName: Show Legend On Chart, FieldType: Boolean, DefaultValue: False, Description: Show series legend on the top right-hand side of the chart area
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Axis and category label text color
#DesignerProperty: Key: LabelFontSize, DisplayName: Label Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 28, Description: Font size for axis labels
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFCCCCCC, Description: Radar web grid color
#DesignerProperty: Key: Depth, DisplayName: 3D Depth, FieldType: Int, DefaultValue: 20, MinRange: 3, MaxRange: 80, Description: 3D depth thickness in dip
#DesignerProperty: Key: TiltAngle, DisplayName: Tilt Angle (Deg), FieldType: Int, DefaultValue: 55, MinRange: 20, MaxRange: 80, Description: Perspective tilt angle
#DesignerProperty: Key: Alpha, DisplayName: Series Opacity, FieldType: Int, DefaultValue: 160, MinRange: 40, MaxRange: 255, Description: Transparency alpha for data polygons (0-255)
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Render numeric values on radar vertices
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when a data point is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type RadarSeries (Name As String, Color As Int, Values As List)
	Type RadarPoint3D (X As Float, Y As Float)
	Type RadarClickResult (SeriesIndex As Int, PointIndex As Int, Value As Float, SeriesName As String, CategoryLabel As String)
	Type RadarTouchResult (SeriesIndex As Int, PointIndex As Int, Value As Float, SeriesName As String, CategoryLabel As String)
	Type ChartMetricsData (CX As Float, CY As Float, MaxR As Float)
	
	Private mTitle As String
	Private mSubTitle As String
	Private mDepth As Float
	Private mTiltRad As Float
	Private mShowLegend As Boolean = True
	Private mShowLegendOnChart As Boolean = False
	Private mGridColor As Int
	Private mTextColor As Int
	Private mTitleColor As Int
	Private mSubTitleColor As Int
	Private mTitleSize As Int
	Private mSubTitleSize As Int
	Private mLabelFontSize As Int
	Private mAlpha As Int = 160
	Private mShowValues As Boolean = True
	Private mShowPopupLegend As Boolean
	
	' Fonts
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontLabel As B4XFont
	Private fontValue As B4XFont
	
	' Data
	Private SeriesList As List
	Private CategoryLabels As List
	Private mMaxValue As Float = 100.0
	Private mMinValue As Float = 0.0
	Private IsDesignerPreview As Boolean = False
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	Private LastTouchedSeriesIndex As Int = -1
	Private LastTouchedPointIndex As Int = -1
	#End If
	
	' Performance optimisations: Caching, Arrays and Coalesced Rendering
	Type CachedRadarColors (TopFill As Object, SideFill As Object, SideOutline As Object, StrokeOutline As Object)
	Private SeriesColorsList As List
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoly(10) As Double
	Private yPoly(10) As Double
	#End If
End Sub

' Initializes the radar chart view framework and internal data structures.
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
	mDepth = DipToCurrent(Props.GetDefault("Depth", 20))
	mShowLegend = Props.GetDefault("ShowLegend", True)
	mShowLegendOnChart = Props.GetDefault("ShowLegendOnChart", False)
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", xui.Color_LightGray))
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_DarkGray))
	mTitleColor = xui.PaintOrColorToColor(Props.GetDefault("TitleColor", xui.Color_Black))
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	
	mTitleSize = Props.GetDefault("TitleSize", 16)
	mSubTitleSize = Props.GetDefault("SubTitleSize", 12)
	mLabelFontSize = Props.GetDefault("LabelFontSize", 11)
	mAlpha = Props.GetDefault("Alpha", 160)
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	
	Dim tiltDeg As Int = Props.GetDefault("TiltAngle", 55)
	mTiltRad = tiltDeg * 0.017453292519943295
	
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
	
	If CategoryLabels.Size = 0 And SeriesList.Size = 0 Then
		IsDesignerPreview = True
		
		Dim sampleCats As List
		sampleCats.Initialize2(Array As String("France", "Canada", "Germany", "USA", "Italy", "Spain", "Russia", "Sweden", "Japan"))
		SetCategories(sampleCats)
		
		Dim vals1 As List
		vals1.Initialize2(Array As Float(80, 65, 75, 80, 85, 70, 60, 50, 70))
		AddSeries("Series1", 0xFF1E88E5, vals1)
		
		Dim vals2 As List
		vals2.Initialize2(Array As Float(75, 40, 70, 30, 45, 80, 70, 55, 60))
		AddSeries("Series2", 0xFFFB8C00, vals2)
	End If
	
	Base_Resize(mBase.Width, mBase.Height)
End Sub

#If B4J Or B4A
Private Sub p_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_DOWN Or Action = mBase.TOUCH_ACTION_MOVE Then
		HandleTouchMove(X, Y)
	Else If Action = mBase.TOUCH_ACTION_UP Then
		HandleClick(X, Y)
		If LastTouchedSeriesIndex <> -1 Or LastTouchedPointIndex <> -1 Then
			LastTouchedSeriesIndex = -1
			LastTouchedPointIndex = -1
			If SubExists(mCallBack, mEventName & "_ItemTouch") Then
				CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
			End If
			RequestRedraw
		End If
	End If
End Sub

Private Sub GetHitResult(touchX As Float, touchY As Float) As Int()
	Dim res(2) As Int
	res(0) = -1 ' SeriesIndex
	res(1) = -1 ' PointIndex
	
	If CategoryLabels.Size = 0 Or SeriesList.Size = 0 Then Return res
	
	Dim metrics As ChartMetricsData = GetChartMetrics
	Dim cx As Float = metrics.CX
	Dim cy As Float = metrics.CY
	Dim maxR As Float = metrics.MaxR
	
	Dim count As Int = CategoryLabels.Size
	Dim angleStep As Float = 360 / count
	Dim range As Float = Max(0.001, mMaxValue - mMinValue)
	
	Dim dx As Float = touchX - cx
	Dim dy As Float = touchY - cy
	Dim touchR As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	
	If touchR > maxR + 50dip Then Return res
	
	Dim touchAngleRad As Float
	If dx = 0 And dy = 0 Then
		touchAngleRad = 0
	Else
		touchAngleRad = ATan2(dy, dx)
	End If
	Dim touchAngleDeg As Float = touchAngleRad * 180 / cPI
	
	Do While touchAngleDeg < 0
		touchAngleDeg = touchAngleDeg + 360
	Loop
	Do While touchAngleDeg >= 360
		touchAngleDeg = touchAngleDeg - 360
	Loop
	
	Dim closestPoint As Int = -1
	Dim minAngleDiff As Float = 10000
	
	For pIdx = 0 To count - 1
		Dim spokeAngle As Float = -90 + (pIdx * angleStep)
		Do While spokeAngle < 0
			spokeAngle = spokeAngle + 360
		Loop
		Do While spokeAngle >= 360
			spokeAngle = spokeAngle - 360
		Loop
		
		Dim diff As Float = Abs(touchAngleDeg - spokeAngle)
		If diff > 180 Then diff = 360 - diff
		
		If diff < minAngleDiff Then
			minAngleDiff = diff
			closestPoint = pIdx
		End If
	Next
	
	If closestPoint <> -1 Then
		Dim bestSeries As Int = -1
		Dim minDiffR As Float = 1000000
		Dim maxSeriesR As Float = -1
		Dim outermostSeries As Int = -1
		
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As RadarSeries = SeriesList.Get(sIdx)
			If closestPoint < s.Values.Size Then
				Dim val As Float = s.Values.Get(closestPoint)
				Dim r As Float = ((val - mMinValue) / range) * maxR
				
				If r > maxSeriesR Then
					maxSeriesR = r
					outermostSeries = sIdx
				End If
				
				If r >= touchR Then
					Dim rDiff As Float = r - touchR
					If rDiff < minDiffR Then
						minDiffR = rDiff
						bestSeries = sIdx
					End If
				End If
			End If
		Next
		
		If bestSeries = -1 Then
			bestSeries = outermostSeries
		End If
		
		res(0) = bestSeries
		res(1) = closestPoint
	End If
	
	Return res
End Sub

Private Sub HandleTouchMove(touchX As Float, touchY As Float)
	Dim hits() As Int = GetHitResult(touchX, touchY)
	Dim foundSeries As Int = hits(0)
	Dim foundPoint As Int = hits(1)
	
	If foundSeries <> LastTouchedSeriesIndex Or foundPoint <> LastTouchedPointIndex Then
		LastTouchedSeriesIndex = foundSeries
		LastTouchedPointIndex = foundPoint
		
		If foundSeries >= 0 And foundPoint >= 0 Then
			Dim s As RadarSeries = SeriesList.Get(foundSeries)
			Dim val As Float = s.Values.Get(foundPoint)
			
			Dim res As RadarTouchResult
			res.Initialize
			res.SeriesIndex = foundSeries
			res.PointIndex = foundPoint
			res.Value = val
			res.SeriesName = s.Name
			res.CategoryLabel = CategoryLabels.Get(foundPoint)
			
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

Private Sub HandleClick(clickX As Float, clickY As Float)
	Dim hits() As Int = GetHitResult(clickX, clickY)
	Dim closestSeries As Int = hits(0)
	Dim closestPoint As Int = hits(1)
	
	If closestSeries >= 0 And closestPoint >= 0 Then
		If SubExists(mCallBack, mEventName & "_ItemClick") Then
			Dim s As RadarSeries = SeriesList.Get(closestSeries)
			Dim val As Float = s.Values.Get(closestPoint)
			Dim res As RadarClickResult
			res.Initialize
			res.SeriesIndex = closestSeries
			res.PointIndex = closestPoint
			res.Value = val
			res.SeriesName = s.Name
			res.CategoryLabel = CategoryLabels.Get(closestPoint)
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

' Set the base B4XView assigned to the chart.
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
	fontTitle = xui.CreateDefaultBoldFont(mTitleSize)
	fontSubTitle = xui.CreateDefaultFont(mSubTitleSize)
	fontLabel = xui.CreateDefaultFont(mLabelFontSize)
	fontValue = xui.CreateDefaultBoldFont(mLabelFontSize - 1)
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
		Private newX(Size) As Double
		Private newY(Size) As Double
		xPoly = newX
		yPoly = newY
	End If
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

' Set the 3D depth thickness (in dip).
Public Sub setDepth(DipVal As Int)
	mDepth = DipToCurrent(DipVal)
	RequestRedraw
End Sub

'' Set the 3D depth thickness.
'Public Sub getDepth As Int
'	Return mDepth / xui.Scale
'End Sub

' Set the tilt angle viewing perspective (20 to 80 degrees).
Public Sub setTiltAngle(Angle As Int)
	Dim clampedDeg As Int = Min(80, Max(20, Angle))
	mTiltRad = clampedDeg * 0.017453292519943295
	RequestRedraw
End Sub

' Set the tilt angle viewing perspective.
Public Sub getTiltAngle As Int
	Return Round(mTiltRad / 0.017453292519943295)
End Sub

' Set whether displaying the series legend at the bottom of the chart is enabled.
Public Sub setShowLegend(Enabled As Boolean)
	mShowLegend = Enabled
	RequestRedraw
End Sub

'' Set whether the legend block is rendered.
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

' Set the opacity alpha for series polygons (40 to 255).
Public Sub setAlpha(AlphaVal As Int)
	mAlpha = Min(255, Max(40, AlphaVal))
	RequestRedraw
End Sub

'' Set the opacity alpha.
'Public Sub getAlpha As Int
'	Return mAlpha
'End Sub

' Set whether rendering numbers on radar vertices is enabled.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

'' Set whether numeric values are displayed.
'Public Sub getShowValues As Boolean
'	Return mShowValues
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

' Set the chart main title text.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

'' Set the chart main title text.
'Public Sub getTitle As String
'	Return mTitle
'End Sub

' Set the chart subtitle text.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

'' Set the chart subtitle text.
'Public Sub getSubTitle As String
'	Return mSubTitle
'End Sub

' Sets category labels along the radar axes.
Public Sub SetCategories(Categories As List)
	If IsDesignerPreview Then
		SeriesList.Clear
		SeriesColorsList.Clear
		CategoryLabels.Clear
		IsDesignerPreview = False
	End If
	CategoryLabels.Clear
	CategoryLabels.AddAll(Categories)
	RequestRedraw
End Sub

' Clears all series data.
Public Sub Clear
	SeriesList.Clear
	SeriesColorsList.Clear
	IsDesignerPreview = False
	#If B4J Or B4A
	LastTouchedSeriesIndex = -1
	LastTouchedPointIndex = -1
	#End If
	RequestRedraw
End Sub

' Clears categories and series data.
Public Sub ClearAll
	SeriesList.Clear
	CategoryLabels.Clear
	SeriesColorsList.Clear
	IsDesignerPreview = False
	#If B4J Or B4A
	LastTouchedSeriesIndex = -1
	LastTouchedPointIndex = -1
	#End If
	RequestRedraw
End Sub

' Adds a data series to the radar chart.
Public Sub AddSeries(SeriesName As String, Color As Int, Values As List)
	If IsDesignerPreview Then
		SeriesList.Clear
		CategoryLabels.Clear
		SeriesColorsList.Clear
		IsDesignerPreview = False
	End If
	
	Dim s As RadarSeries
	s.Initialize
	s.Name = SeriesName
	s.Color = Color
	s.Values.Initialize
	s.Values.AddAll(Values)
	SeriesList.Add(s)
	
	Dim crc As CachedRadarColors
	crc.Initialize
	#If B4J
	crc.TopFill = GetFXColor(ApplyAlpha(Color, mAlpha))
	crc.SideFill = GetFXColor(DarkenColor(Color, 0.7))
	crc.SideOutline = GetFXColor(DarkenColor(Color, 0.5))
	crc.StrokeOutline = GetFXColor(DarkenColor(Color, 0.8))
	#Else
	crc.TopFill = ApplyAlpha(Color, mAlpha)
	crc.SideFill = DarkenColor(Color, 0.7)
	crc.SideOutline = DarkenColor(Color, 0.5)
	crc.StrokeOutline = DarkenColor(Color, 0.8)
	#End If
	SeriesColorsList.Add(crc)
	
	For i = 0 To Values.Size - 1
		Dim v As Float = Values.Get(i)
		If v > mMaxValue Then mMaxValue = v
		If v < mMinValue Then mMinValue = v
	Next
	mMaxValue = Max(10.0, Ceil(mMaxValue / 10) * 10)
	
	RequestRedraw
End Sub

Private Sub RecalculateBounds 'ignore
	mMaxValue = 10.0
	mMinValue = 0.0
	
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As RadarSeries = SeriesList.Get(sIdx)
		For i = 0 To s.Values.Size - 1
			Dim v As Float = s.Values.Get(i)
			If v > mMaxValue Then mMaxValue = v
			If v < mMinValue Then mMinValue = v
		Next
	Next
	
	mMaxValue = Max(10.0, Ceil(mMaxValue / 10) * 10)
End Sub

Private Sub GetHeaderHeight As Float
	Dim currentY As Float = 10dip
	If mTitle <> "" Then currentY = currentY + 22dip
	If mSubTitle <> "" Then currentY = currentY + 18dip
	Return currentY
End Sub

Private Sub GetChartMetrics As ChartMetricsData
	Dim headerHeight As Float = GetHeaderHeight
	Dim metrics As ChartMetricsData
	metrics.Initialize
	metrics.CX = mBase.Width / 2
	
	Dim legendHeight As Float = 0
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then legendHeight = 30dip
	
	Dim availableHeight As Float = mBase.Height - headerHeight - mDepth - legendHeight - 20dip
	If availableHeight <= 20dip Then availableHeight = 20dip
	metrics.CY = headerHeight + (availableHeight / 2) + 10dip
	
	metrics.MaxR = Max(10dip, Min((mBase.Width / 2) - 30dip, (availableHeight / 2))) * 0.75
	Return metrics
End Sub

' Commits drawing changes and outputs to canvas view.
Public Sub Redraw
	If mBase.IsInitialized = False Then Return
	If mBase.Width <= 0 Or mBase.Height <= 0 Then Return
	
	cvs.ClearRect(cvs.TargetRect)
	
	Dim headerHeight As Float = DrawHeader
	If CategoryLabels.Size = 0 Then Return
	
	Dim metrics As ChartMetricsData = GetChartMetrics
	Dim cx As Float = metrics.CX
	Dim cy As Float = metrics.CY
	Dim maxR As Float = metrics.MaxR
	
	' 1. Web Grid & Category Axes
	DrawRadarWebAndAxes(cx, cy, maxR)
	
	' 2. Data Series (Layered with 3D Depth)
	DrawRadarSeriesData(cx, cy, maxR)
	
	' 3. Bottom Legend
	If mShowLegend And Not(mShowLegendOnChart) And SeriesList.Size > 0 Then
		Dim legendY As Float = mBase.Height - 15dip
		Dim totalLegendWidth As Float = 0
		
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As RadarSeries = SeriesList.Get(sIdx)
			Dim itemWidth As Float = 0
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			itemWidth = itemWidth + 12dip + 6dip + txtRect.Width
			
			totalLegendWidth = totalLegendWidth + itemWidth
			If sIdx < SeriesList.Size - 1 Then totalLegendWidth = totalLegendWidth + 20dip
		Next
		
		Dim currentX As Float = (mBase.Width / 2) - (totalLegendWidth / 2)
		For sIdx = 0 To SeriesList.Size - 1
			Dim s As RadarSeries = SeriesList.Get(sIdx)
			
			Dim r As B4XRect
			r.Initialize(currentX, legendY - 10dip, currentX + 12dip, legendY + 2dip)
			cvs.DrawRect(r, s.Color, True, 0)
			cvs.DrawRect(r, mTextColor, False, 1dip)
			
			currentX = currentX + 12dip + 6dip
			cvs.DrawText(s.Name, currentX, legendY, fontLabel, mTextColor, "LEFT")
			
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			currentX = currentX + txtRect.Width + 20dip
		Next
	End If
	
	' Draw On-Chart Legend (Top Right)
	If mShowLegend And mShowLegendOnChart And SeriesList.Size > 0 Then
		Dim seriesCount As Int = SeriesList.Size
		Dim maxTextW As Float = 0
		
		For sIdx = 0 To seriesCount - 1
			Dim s As RadarSeries = SeriesList.Get(sIdx)
			Dim txtRect As B4XRect = cvs.MeasureText(s.Name, fontLabel)
			If txtRect.Width > maxTextW Then maxTextW = txtRect.Width
		Next
		
		Dim itemH As Float = fontLabel.Size + 8dip
		Dim boxWidth As Float = 12dip + 6dip + maxTextW + 16dip
		Dim boxHeight As Float = (seriesCount * itemH) + 12dip
		
		'Dim boxLeft As Float = (cx + maxR) - boxWidth 'Original
		Dim boxLeft As Float = mBase.Width - boxWidth - 70dip
		Dim boxTop As Float = cy - maxR
		
		Dim rBox As B4XRect
		rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
		
		cvs.DrawRect(rBox, xui.Color_White, True, 0)
		cvs.DrawRect(rBox, mGridColor, False, 1dip)
		
		Dim currentItemY As Float = boxTop + 6dip
		#If B4A
		Dim textBaselineOffset As Float = fontLabel.Size / 2.5
		#Else
		Dim textBaselineOffset As Float = fontLabel.Size / 3
		#End If
		
		For sIdx = 0 To seriesCount - 1
			Dim s As RadarSeries = SeriesList.Get(sIdx)
			
			Dim rColorBox As B4XRect
			rColorBox.Initialize(boxLeft + 8dip, currentItemY + 2dip, boxLeft + 8dip + 12dip, currentItemY + 12dip)
			cvs.DrawRect(rColorBox, s.Color, True, 0)
			cvs.DrawRect(rColorBox, mTextColor, False, 1dip)
			
			Dim textX As Float = boxLeft + 8dip + 12dip + 6dip
			Dim textY As Float = currentItemY + (itemH / 2)
			
			cvs.DrawText(s.Name, textX, textY + textBaselineOffset, fontLabel, mTextColor, "LEFT")
			
			currentItemY = currentItemY + itemH
		Next
	End If
	
	' 4. Popup Legend
	#If B4J Or B4A
	If mShowPopupLegend And LastTouchedSeriesIndex >= 0 And LastTouchedPointIndex >= 0 Then
		Dim sTouched As RadarSeries = SeriesList.Get(LastTouchedSeriesIndex)
		If LastTouchedPointIndex < sTouched.Values.Size Then
			Dim valTouched As Float = sTouched.Values.Get(LastTouchedPointIndex)
			Dim catLabel As String = CategoryLabels.Get(LastTouchedPointIndex)
			
			Dim lines As List
			lines.Initialize
			lines.Add(sTouched.Name)
			lines.Add(catLabel & ": " & NumberFormat(valTouched, 1, 0))
			
			Dim maxW As Float = 0
			Dim lineH As Float = 0
			For Each lineText As String In lines
				Dim rText As B4XRect = cvs.MeasureText(lineText, fontLabel)
				If rText.Width > maxW Then maxW = rText.Width
				If rText.Height > lineH Then lineH = rText.Height
			Next
			lineH = lineH + 6dip
			
			Dim boxLeft As Float = 10dip
			Dim boxTop As Float = headerHeight + 4dip
			Dim boxWidth As Float = maxW + 16dip
			Dim boxHeight As Float = (lines.Size * lineH) + 8dip
			
			Dim rBox As B4XRect
			rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
			
			cvs.DrawRect(rBox, xui.Color_ARGB(192, 255, 255, 255), True, 0)
			cvs.DrawRect(rBox, mGridColor, False, 1dip)
			
			Dim currentTextY As Float = boxTop + 6dip + (lineH / 2)
			For Each lineText As String In lines
				cvs.DrawText(lineText, boxLeft + 8dip, currentTextY + (fontLabel.Size / 3), fontLabel, mTextColor, "LEFT")
				currentTextY = currentTextY + lineH
			Next
		End If
	End If
	#End If
	
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

#If B4J
Private Sub DrawRadarWebAndAxes(cx As Float, cy As Float, maxR As Float)
	Dim count As Int = CategoryLabels.Size
	If count < 3 Then Return
	
	Dim angleStep As Float = 360 / count
	Dim gridRings As Int = 5
	Dim gc As JavaObject = GetGraphicsContext
	
	gc.RunMethod("setLineWidth", Array(1.0 * xui.Scale))
	
	' Concentric Web Rings
	For ring = 1 To gridRings
		Dim r As Float = maxR * (ring / gridRings)
		EnsurePolyCapacity(count + 1)
		
		For i = 0 To count - 1
			Dim angleDeg As Float = -90 + (i * angleStep)
			Dim angleRad As Float = angleDeg * 0.017453292519943295
			xPoly(i) = cx + r * Cos(angleRad)
			yPoly(i) = cy + r * Sin(angleRad)
		Next
		
		xPoly(count) = xPoly(0)
		yPoly(count) = yPoly(0)
		
		gc.RunMethod("setStroke", Array(GetFXColor(mGridColor)))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, count + 1))
	Next
	
	' Spoke Axes & Category Labels
	For i = 0 To count - 1
		Dim angleDeg As Float = -90 + (i * angleStep)
		Dim angleRad As Float = angleDeg * 0.017453292519943295
		
		Dim cosA As Float = Cos(angleRad)
		Dim sinA As Float = Sin(angleRad)
		
		Dim endX As Float = cx + maxR * cosA
		Dim endY As Float = cy + maxR * sinA
		
		cvs.DrawLine(cx, cy, endX, endY, mGridColor, 1dip)
		
		' Top Axis Value Scale Labels
		If i = 0 Then
			For ring = 0 To gridRings
				Dim ringR As Float = maxR * (ring / gridRings)
				Dim valY As Float = cy - ringR
				Dim valNum As Float = mMinValue + (ring * ((mMaxValue - mMinValue) / gridRings))
				cvs.DrawText(NumberFormat(valNum, 1, 0), cx - 6dip, valY + (mLabelFontSize / 3), fontLabel, mTextColor, "RIGHT")
				
				' Small tick mark
				cvs.DrawLine(cx - 3dip, valY, cx, valY, mTextColor, 1dip)
			Next
		End If
		
		' Category Label Offset
		Dim labelDist As Float = maxR + 18dip
		Dim lx As Float = cx + labelDist * cosA
		Dim ly As Float = cy + labelDist * sinA + (mLabelFontSize / 3)
		
		Dim align As String = "CENTER"
		If cosA > 0.2 Then
			align = "LEFT"
		Else If cosA < -0.2 Then
			align = "RIGHT"
		End If
		
		cvs.DrawText(CategoryLabels.Get(i), lx, ly, fontLabel, mTextColor, align)
	Next
End Sub
#Else
Private Sub DrawRadarWebAndAxes(cx As Float, cy As Float, maxR As Float)
	Dim count As Int = CategoryLabels.Size
	If count < 3 Then Return
	
	Dim angleStep As Float = 360 / count
	Dim gridRings As Int = 5
	
	' Concentric Web Rings
	For ring = 1 To gridRings
		Dim r As Float = maxR * (ring / gridRings)
		Dim pathWeb As B4XPath
		
		For i = 0 To count - 1
			Dim angleDeg As Float = -90 + (i * angleStep)
			Dim angleRad As Float = angleDeg * 0.017453292519943295
			Dim px As Float = cx + r * Cos(angleRad)
			Dim py As Float = cy + r * Sin(angleRad)
			
			If i = 0 Then
				pathWeb.Initialize(px, py)
			Else
				pathWeb.LineTo(px, py)
			End If
		Next
		
		Dim firstDeg As Float = -90
		Dim firstRad As Float = firstDeg * 0.017453292519943295
		pathWeb.LineTo(cx + r * Cos(firstRad), cy + r * Sin(firstRad))
		
		cvs.DrawPath(pathWeb, mGridColor, False, 1dip)
	Next
	
	' Spoke Axes & Category Labels
	For i = 0 To count - 1
		Dim angleDeg As Float = -90 + (i * angleStep)
		Dim angleRad As Float = angleDeg * 0.017453292519943295
		
		Dim cosA As Float = Cos(angleRad)
		Dim sinA As Float = Sin(angleRad)
		
		Dim endX As Float = cx + maxR * cosA
		Dim endY As Float = cy + maxR * sinA
		
		cvs.DrawLine(cx, cy, endX, endY, mGridColor, 1dip)
		
		' Top Axis Value Scale Labels
		If i = 0 Then
			For ring = 0 To gridRings
				Dim ringR As Float = maxR * (ring / gridRings)
				Dim valY As Float = cy - ringR
				Dim valNum As Float = mMinValue + (ring * ((mMaxValue - mMinValue) / gridRings))
				cvs.DrawText(NumberFormat(valNum, 1, 0), cx - 6dip, valY + (mLabelFontSize / 3), fontLabel, mTextColor, "RIGHT")
				
				' Small tick mark
				cvs.DrawLine(cx - 3dip, valY, cx, valY, mTextColor, 1dip)
			Next
		End If
		
		' Category Label Offset
		Dim labelDist As Float = maxR + 18dip
		Dim lx As Float = cx + labelDist * cosA
		Dim ly As Float = cy + labelDist * sinA + (mLabelFontSize / 3)
		
		Dim align As String = "CENTER"
		If cosA > 0.2 Then
			align = "LEFT"
		Else If cosA < -0.2 Then
			align = "RIGHT"
		End If
		
		cvs.DrawText(CategoryLabels.Get(i), lx, ly, fontLabel, mTextColor, align)
	Next
End Sub
#End If

#If B4J
Private Sub DrawRadarSeriesData(cx As Float, cy As Float, maxR As Float)
	Dim count As Int = CategoryLabels.Size
	If count < 3 Or SeriesList.Size = 0 Then Return
	
	Dim angleStep As Float = 360 / count
	Dim range As Float = Max(0.001, mMaxValue - mMinValue)
	Dim gc As JavaObject = GetGraphicsContext
	
	' Draw back to front
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As RadarSeries = SeriesList.Get(sIdx)
		Dim crc As CachedRadarColors = SeriesColorsList.Get(sIdx)
		
		' Top Face Coordinates
		Dim topPts(count) As RadarPoint3D
		For i = 0 To count - 1
			Dim val As Float = 0
			If i < s.Values.Size Then val = s.Values.Get(i)
			Dim r As Float = ((val - mMinValue) / range) * maxR
			
			Dim angleDeg As Float = -90 + (i * angleStep)
			Dim angleRad As Float = angleDeg * 0.017453292519943295
			
			topPts(i).Initialize
			topPts(i).X = cx + r * Cos(angleRad)
			topPts(i).Y = cy + r * Sin(angleRad)
		Next
		
		' 1. 3D Side Depth Walls
		EnsurePolyCapacity(4)
		gc.RunMethod("setLineWidth", Array(1.0 * xui.Scale))
		
		For i = 0 To count - 1
			Dim nextIdx As Int = (i + 1) Mod count
			
			Dim p1 As RadarPoint3D = topPts(i)
			Dim p2 As RadarPoint3D = topPts(nextIdx)
			
			xPoly(0) = p1.X : yPoly(0) = p1.Y
			xPoly(1) = p2.X : yPoly(1) = p2.Y
			xPoly(2) = p2.X : yPoly(2) = p2.Y + mDepth
			xPoly(3) = p1.X : yPoly(3) = p1.Y + mDepth
			
			gc.RunMethod("setFill", Array(crc.SideFill))
			gc.RunMethod("fillPolygon", Array(xPoly, yPoly, 4))
			gc.RunMethod("setStroke", Array(crc.SideOutline))
			gc.RunMethod("strokePolygon", Array(xPoly, yPoly, 4))
		Next
		
		' 2. Top Solid Polygon Face
		EnsurePolyCapacity(count + 1)
		For i = 0 To count - 1
			xPoly(i) = topPts(i).X
			yPoly(i) = topPts(i).Y
		Next
		xPoly(count) = topPts(0).X
		yPoly(count) = topPts(0).Y
		
		gc.RunMethod("setLineWidth", Array(1.5 * xui.Scale))
		gc.RunMethod("setFill", Array(crc.TopFill))
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, count + 1))
		gc.RunMethod("setStroke", Array(crc.StrokeOutline))
		gc.RunMethod("strokePolygon", Array(xPoly, yPoly, count + 1))
		
		' 3. Vertices & Value Labels
		For i = 0 To count - 1
			Dim pt As RadarPoint3D = topPts(i)
			cvs.DrawCircle(pt.X, pt.Y, 3.5dip, s.Color, True, 0)
			
			If mShowValues And i < s.Values.Size Then
				Dim val As Float = s.Values.Get(i)
				Dim valTxt As String = NumberFormat(val, 1, 0)
				cvs.DrawText(valTxt, pt.X, pt.Y - 6dip, fontValue, mTextColor, "CENTER")
			End If
		Next
	Next
End Sub
#Else
Private Sub DrawRadarSeriesData(cx As Float, cy As Float, maxR As Float)
	Dim count As Int = CategoryLabels.Size
	If count < 3 Or SeriesList.Size = 0 Then Return
	
	Dim angleStep As Float = 360 / count
	Dim range As Float = Max(0.001, mMaxValue - mMinValue)
	
	' Draw back to front
	For sIdx = 0 To SeriesList.Size - 1
		Dim s As RadarSeries = SeriesList.Get(sIdx)
		
		' Top Face Coordinates
		Dim topPts(count) As RadarPoint3D
		For i = 0 To count - 1
			Dim val As Float = 0
			If i < s.Values.Size Then val = s.Values.Get(i)
			Dim r As Float = ((val - mMinValue) / range) * maxR
			
			Dim angleDeg As Float = -90 + (i * angleStep)
			Dim angleRad As Float = angleDeg * 0.017453292519943295
			
			topPts(i).Initialize
			topPts(i).X = cx + r * Cos(angleRad)
			topPts(i).Y = cy + r * Sin(angleRad)
		Next
		
		' 1. 3D Side Depth Walls
		Dim sideColor As Int = DarkenColor(s.Color, 0.7)
		For i = 0 To count - 1
			Dim nextIdx As Int = (i + 1) Mod count
			
			Dim p1 As RadarPoint3D = topPts(i)
			Dim p2 As RadarPoint3D = topPts(nextIdx)
			
			Dim pathSide As B4XPath
			pathSide.Initialize(p1.X, p1.Y)
			pathSide.LineTo(p2.X, p2.Y)
			pathSide.LineTo(p2.X, p2.Y + mDepth)
			pathSide.LineTo(p1.X, p1.Y + mDepth)
			
			cvs.DrawPath(pathSide, sideColor, True, 0)
			cvs.DrawPath(pathSide, DarkenColor(s.Color, 0.5), False, 1dip)
		Next
		
		' 2. Top Solid Polygon Face
		Dim fillColor As Int = ApplyAlpha(s.Color, mAlpha)
		Dim strokeColor As Int = DarkenColor(s.Color, 0.8)
		
		Dim pathTop As B4XPath
		pathTop.Initialize(topPts(0).X, topPts(0).Y)
		For i = 1 To count - 1
			pathTop.LineTo(topPts(i).X, topPts(i).Y)
		Next
		pathTop.LineTo(topPts(0).X, topPts(0).Y)
		
		cvs.DrawPath(pathTop, fillColor, True, 0)
		cvs.DrawPath(pathTop, strokeColor, False, 1.5dip)
		
		' 3. Vertices & Value Labels
		For i = 0 To count - 1
			Dim pt As RadarPoint3D = topPts(i)
			cvs.DrawCircle(pt.X, pt.Y, 3.5dip, strokeColor, True, 0)
			
			If mShowValues And i < s.Values.Size Then
				Dim val As Float = s.Values.Get(i)
				Dim valTxt As String = NumberFormat(val, 1, 0)
				cvs.DrawText(valTxt, pt.X, pt.Y - 6dip, fontValue, mTextColor, "CENTER")
			End If
		Next
	Next
End Sub
#End If

Private Sub ApplyAlpha(clr As Int, alpha As Int) As Int
	Dim argb() As Int = GetARGB(clr)
	Return xui.Color_ARGB(alpha, argb(1), argb(2), argb(3))
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
