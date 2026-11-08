B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As VerticalBarClickResult)
#Event: ItemTouch (Result As VerticalBarTouchResult)
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
#DesignerProperty: Key: DefaultBarColor, DisplayName: Bar Color, FieldType: Color, DefaultValue: 0xFF1E88E5, Description: Primary bar color
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Render numeric values inside bars
#DesignerProperty: Key: ValueOrientation, DisplayName: Value Orientation, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical, Description: Orientation of values inside bars
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color for values printed inside bars
#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 36, Description: Font size for bar values
#DesignerProperty: Key: ShowMeanLine, DisplayName: Show Mean Line, FieldType: Boolean, DefaultValue: False, Description: Render horizontal line at calculated mean value
#DesignerProperty: Key: MeanLineColor, DisplayName: Mean Line Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the optional mean value line
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched bar
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when the bar is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type CustomVerticalBarPoint (X As Float, Y As Float)
	Type VerticalBarData (Value As Float, Label As String)
	Type VerticalBarClickResult (Index As Int, Value As Float, Label As String)
	Type VerticalBarTouchResult (Index As Int, Value As Float, Label As String)
	
	Private mTitle As String
	Private mSubTitle As String
	Private mXAxisTitle As String
	Private mYAxisTitle As String
	Private mAxisColor As Int
	Private mGridColor As Int
	Private mTextColor As Int
	Private mSubTitleColor As Int
	Private mValueTextColor As Int
	Private mBarColor As Int
	Private mDepth As Float
	Private mFontSize As Int
	Private mValueOrientation As String = "Horizontal"
	Private mShowValues As Boolean
	Private mShowMeanLine As Boolean
	Private mMeanLineColor As Int
	Private mGridSteps As Int = 4
	Private mShowTouchLine As Boolean
	Private mTouchLineColor As Int
	Private mShowPopupLegend As Boolean
	
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontAxis As B4XFont
	Private fontValue As B4XFont
	Private fontAxisTitle As B4XFont
	
	Private DataList As List
	Private mMaxValue As Float = 1.0
	Private mRawMaxValue As Float = 1.0
	Private mMinValue As Float = 0.0
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	Private LastTouchedIndex As Int = -1
	#End If
	
	' Performance optimizations: Caching, Arrays and Coalesced Rendering
	Type VerticalBarCachedColors (Base As Object, Top As Object, Side As Object, Outline As Object)
	Private BarColors As VerticalBarCachedColors
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
	DataList.Initialize
	BarColors.Initialize
	UpdateFonts
End Sub

' Configures the view after being inflated from the designer.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	If DataList.IsInitialized = False Then DataList.Initialize
	
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mXAxisTitle = Props.GetDefault("XAxisTitle", "")
	mYAxisTitle = Props.GetDefault("YAxisTitle", "")
	mAxisColor = xui.PaintOrColorToColor(Props.GetDefault("AxisColor", 0xFF888888))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFE0E0E0))
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_DarkGray))
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_White))
	
	Dim barProp As Object = Props.GetDefault("DefaultBarColor", xui.Color_Blue)
	If barProp = Null Or barProp = "" Then
		mBarColor = xui.Color_Blue
	Else
		Try
			mBarColor = xui.PaintOrColorToColor(barProp)
		Catch
			mBarColor = xui.Color_Blue
		End Try
	End If
	
	mDepth = DipToCurrent(Props.GetDefault("Depth", 15))
	mFontSize = Props.GetDefault("FontSize", 11)
	mValueOrientation = Props.GetDefault("ValueOrientation", "Horizontal")
	mShowValues = Props.GetDefault("ShowValues", True)
	mShowMeanLine = Props.GetDefault("ShowMeanLine", False)
	mMeanLineColor = xui.PaintOrColorToColor(Props.GetDefault("MeanLineColor", xui.Color_Black))
	mGridSteps = Props.GetDefault("GridSteps", 4)
	mShowTouchLine = Props.GetDefault("ShowTouchLine", False)
	mTouchLineColor = xui.PaintOrColorToColor(Props.GetDefault("TouchLineColor", xui.Color_Red))
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	
	UpdateBarColors
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
	Dim i As Int = GetBarIndexAt(touchX, touchY)
	If i <> LastTouchedIndex Then
		LastTouchedIndex = i
		If i >= 0 Then
			Dim bd As VerticalBarData = DataList.Get(i)
			Dim res As VerticalBarTouchResult
			res.Initialize
			res.Index = i
			res.Value = bd.Value
			res.Label = bd.Label
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
	Dim i As Int = GetBarIndexAt(clickX, clickY)
	If i >= 0 Then
		Dim bd As VerticalBarData = DataList.Get(i)
		Dim res As VerticalBarClickResult
		res.Initialize
		res.Index = i
		res.Value = bd.Value
		res.Label = bd.Label
		If SubExists(mCallBack, mEventName & "_ItemClick") Then
			CallSub2(mCallBack, mEventName & "_ItemClick", res)
		End If
	End If
End Sub

Private Sub GetBarIndexAt(touchX As Float, touchY As Float) As Int
	If DataList.Size = 0 Then Return -1
	
	Dim count As Int = DataList.Size
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	
	Dim headerHeight As Float = DrawHeader
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim rightPadding As Float = 20dip + mDepth
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim bottomPadding As Float = 40dip
	
	Dim plotX As Float = leftPadding
	Dim plotY As Float = topPadding
	Dim plotWidth As Float = w - leftPadding - rightPadding
	Dim plotHeight As Float = h - topPadding - bottomPadding
	
	If plotHeight <= 0 Or plotWidth <= 0 Then Return -1
	
	If touchX < plotX - 10dip Or touchX > plotX + plotWidth + mDepth + 30dip Then Return -1
	If touchY < plotY - 10dip Or touchY > plotY + plotHeight + 30dip Then Return -1
	
	Dim zoneW As Float = plotWidth / count
	
	For i = 0 To count - 1
		Dim zoneStartX As Float = plotX + (i * zoneW)
		Dim zoneEndX As Float = zoneStartX + zoneW
		
		If touchX >= zoneStartX And touchX <= zoneEndX Then
			Return i
		End If
	Next
	
	Return -1
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

' Set or Get the tag property on custom target.
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

Private Sub UpdateBarColors
	#If B4J
	BarColors.Base = GetFXColor(mBarColor)
	BarColors.Top = GetFXColor(LightenColor(mBarColor, 1.25))
	BarColors.Side = GetFXColor(DarkenColor(mBarColor, 0.75))
	BarColors.Outline = GetFXColor(DarkenColor(mBarColor, 0.5))
	#Else
	BarColors.Base = mBarColor
	BarColors.Top = LightenColor(mBarColor, 1.25)
	BarColors.Side = DarkenColor(mBarColor, 0.75)
	BarColors.Outline = DarkenColor(mBarColor, 0.5)
	#End If
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

'' Set or Get the axis color.
'Public Sub getAxisColor As Int
'	Return mAxisColor
'End Sub

' Set the grid color.
Public Sub setGridColor(Clr As Int)
	mGridColor = Clr
	RequestRedraw
End Sub

'' Set or Get the grid color.
'Public Sub getGridColor As Int
'	Return mGridColor
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

' Set whether the horizontal mean aggregate line is drawn.
Public Sub setShowMeanLine(Enabled As Boolean)
	mShowMeanLine = Enabled
	RequestRedraw
End Sub

' Set the color for the average calculated mean line.
Public Sub setMeanLineColor(Clr As Int)
	mMeanLineColor = Clr
	RequestRedraw
End Sub

' Set whether a line is rendered through the touched bar.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

' Set whether a popup legend is displayed when a bar is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
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

' Clears out existing value data and redraws an empty chart frame.
Public Sub Clear
	DataList.Clear
	mRawMaxValue = 1.0
	mMaxValue = 1.0
	mMinValue = 0.0
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

' Adds a new data value and category label to the chart list.
Public Sub AddValue(Value As Float, Label As String)
	Dim bd As VerticalBarData
	bd.Initialize
	bd.Value = Value
	bd.Label = Label
	DataList.Add(bd)
	
	If Value > mRawMaxValue Then mRawMaxValue = Value
	If Value < mMinValue Then mMinValue = Value
	RequestRedraw
End Sub

' Commits drawing changes and outputs to the canvas view.
Public Sub Redraw
	If mBase.IsInitialized = False Then Return
	If mBase.Width <= 0 Or mBase.Height <= 0 Then Return
	
	Dim rect As B4XRect
	rect.Initialize(0, 0, mBase.Width, mBase.Height)
	cvs.ClearRect(rect)
	
	Dim headerHeight As Float = DrawHeader
	If DataList.Size = 0 Then Return
	
	' Calculate nice max headroom before measuring labels
	mMaxValue = CalculateNiceMax(mRawMaxValue, mGridSteps)
	
	Dim count As Int = DataList.Size
	Dim w As Float = mBase.Width
	Dim h As Float = mBase.Height
	
	Dim maxLabelWidth As Float = MeasureMaxYLabelWidth
	Dim titleOffset As Float = 0
	If mYAxisTitle <> "" Then titleOffset = fontAxisTitle.Size + 6dip
	
	Dim leftPadding As Float = 10dip + titleOffset + maxLabelWidth + 8dip
	Dim rightPadding As Float = 20dip + mDepth
	Dim topPadding As Float = headerHeight + 20dip + mDepth
	Dim bottomPadding As Float = 40dip
	
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
	
	Dim barW As Float = (plotWidth / count) * 0.6
	Dim spacing As Float = (plotWidth / count) * 0.4
	
	' Track lowest value bar index and calculate total sum
	Dim lowestIndex As Int = 0
	Dim lowestVal As Float = 3.4028235E38
	Dim totalSum As Float = 0
	
	For i = 0 To count - 1
		Dim bdCheck As VerticalBarData = DataList.Get(i)
		totalSum = totalSum + bdCheck.Value
		If bdCheck.Value < lowestVal Then
			lowestVal = bdCheck.Value
			lowestIndex = i
		End If
	Next
	
	' Render 3D Bars & X-Axis Labels
	For i = 0 To count - 1
		Dim bd As VerticalBarData = DataList.Get(i)
		Dim barH As Float = (Abs(bd.Value) / range) * plotHeight
		Dim startX As Float = plotX + (spacing / 2) + i * (barW + spacing)
		
		' Calculate baseline Y depending on positive or negative value
		Dim baselineY As Float = zeroY
		If bd.Value < 0 Then
			baselineY = zeroY + barH
		End If
		
		DrawSingle3DBar(startX, baselineY, barW, barH, mDepth, bd.Value)
		
		Dim centerX As Float = startX + (barW / 2)
		Dim labelY As Float = plotY + plotHeight + 18dip
		cvs.DrawText(bd.Label, centerX, labelY, fontAxis, mTextColor, "CENTER")
	Next
	
	' Render Touch Line over the active touched bar (vertical line spanning the full height of the chart plot area)
	#If B4J Or B4A
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < count Then
		Dim touchStartX As Float = plotX + (spacing / 2) + LastTouchedIndex * (barW + spacing)
		Dim touchCenterX As Float = touchStartX + (barW / 2)
		cvs.DrawLine(touchCenterX, plotY, touchCenterX, plotY + plotHeight, mTouchLineColor, 2dip)
		
		If mShowPopupLegend Then
			' Render legend on the top left corner of the inner chart showing the same values as what the click/touch receives
			Dim bdTouched As VerticalBarData = DataList.Get(LastTouchedIndex)
			Dim legendText As String = bdTouched.Label & ": " & NumberFormat(bdTouched.Value, 1, 0)
			Dim legendRect As B4XRect = cvs.MeasureText(legendText, fontAxis)
			Dim boxLeft As Float = plotX + 4dip
			Dim boxTop As Float = plotY + 4dip
			Dim boxWidth As Float = legendRect.Width + 16dip
			Dim boxHeight As Float = legendRect.Height + 8dip
			
			Dim rBox As B4XRect
			rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
			
			cvs.DrawRect(rBox, XUI.Color_ARGB(192, 255, 255, 255), True, 0)
			cvs.DrawRect(rBox, mGridColor, False, 1dip)
			
			#If B4A
			Dim textBaselineOffset As Float = legendRect.Height / 2
			#Else
			Dim textBaselineOffset As Float = fontAxis.Size / 3
			#End If
			
			cvs.DrawText(legendText, boxLeft + 8dip, boxTop + (boxHeight / 2) + textBaselineOffset, fontAxis, mTextColor, "LEFT")
		End If
	End If
	#End If
	
	' Render Zero Axis Baseline
	cvs.DrawLine(plotX, zeroY, plotX + plotWidth + mDepth, zeroY, mAxisColor, 1.5dip)
	
	' Render Optional Mean Line over the lowest value bar
	If mShowMeanLine And count > 0 Then
		Dim meanVal As Float = totalSum / count
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
		
		' Position text over the lowest bar X center
		Dim lowestBarX As Float = plotX + (spacing / 2) + lowestIndex * (barW + spacing) + (barW / 2)
		Dim meanTxt As String = NumberFormat(meanVal, 1, 1)
		
		' Center the box on the dashed line (meanY) and vertically center the text
		Dim r As B4XRect = cvs.MeasureText(meanTxt, fontAxis)
		Dim boxWidth As Float = r.Width + 10dip
		Dim boxHeight As Float = r.Height + 6dip
		Dim bgRect As B4XRect
		bgRect.Initialize(lowestBarX - (boxWidth / 2), meanY - (boxHeight / 2), lowestBarX + (boxWidth / 2), meanY + (boxHeight / 2))
		
		cvs.DrawRect(bgRect, xui.Color_White, True, 0)
		cvs.DrawRect(bgRect, xui.Color_LightGray, False, 1dip)
		
		Dim textY As Float = meanY - r.Top - (r.Height / 2)
		cvs.DrawText(meanTxt, lowestBarX, textY, fontAxis, mMeanLineColor, "CENTER")
	End If
	
	If mXAxisTitle <> "" Then
		cvs.DrawText(mXAxisTitle, plotX + (plotWidth / 2), mBase.Height - 5dip, fontAxisTitle, mTextColor, "CENTER")
	End If
	
	If mYAxisTitle <> "" Then
		Dim yTitleX As Float = 10dip + (fontAxisTitle.Size / 2)
		cvs.DrawTextRotated(mYAxisTitle, yTitleX, plotY + (plotHeight / 2), fontAxisTitle, mTextColor, "CENTER", -90)
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
Private Sub DrawSingle3DBar(x As Float, y As Float, w As Float, h As Float, depth As Float, val As Float)
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
	gc.RunMethod("setFill", Array(BarColors.Base))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(BarColors.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Right Side Face
	xPoints(0) = pFrontTRX : yPoints(0) = pFrontTRY
	xPoints(1) = pBackTRX : yPoints(1) = pBackTRY
	xPoints(2) = pBackBRX : yPoints(2) = pBackBRY
	xPoints(3) = pFrontBRX : yPoints(3) = pFrontBRY
	gc.RunMethod("setFill", Array(BarColors.Side))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(BarColors.Outline))
	gc.RunMethod("strokePolygon", Array(xPoints, yPoints, 4))
	
	' Top Face
	xPoints(0) = pFrontTLX : yPoints(0) = pFrontTLY
	xPoints(1) = pBackTLX : yPoints(1) = pBackTLY
	xPoints(2) = pBackTRX : yPoints(2) = pBackTRY
	xPoints(3) = pFrontTRX : yPoints(3) = pFrontTRY
	gc.RunMethod("setFill", Array(BarColors.Top))
	gc.RunMethod("fillPolygon", Array(xPoints, yPoints, 4))
	gc.RunMethod("setStroke", Array(BarColors.Outline))
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
Private Sub DrawSingle3DBar(x As Float, y As Float, w As Float, h As Float, depth As Float, val As Float)
	Dim pFrontBL As CustomVerticalBarPoint = CreatePoint(x, y)
	Dim pFrontBR As CustomVerticalBarPoint = CreatePoint(x + w, y)
	Dim pFrontTL As CustomVerticalBarPoint = CreatePoint(x, y - h)
	Dim pFrontTR As CustomVerticalBarPoint = CreatePoint(x + w, y - h)
	
	Dim pBackTL As CustomVerticalBarPoint = CreatePoint(pFrontTL.X + depth, pFrontTL.Y - (depth * 0.5))
	Dim pBackTR As CustomVerticalBarPoint = CreatePoint(pFrontTR.X + depth, pFrontTR.Y - (depth * 0.5))
	Dim pBackBR As CustomVerticalBarPoint = CreatePoint(pFrontBR.X + depth, pFrontBR.Y - (depth * 0.5))
	
	Dim topColor As Int = BarColors.Top
	Dim sideColor As Int = BarColors.Side
	Dim baseClr As Int = BarColors.Base
	Dim outlineClr As Int = BarColors.Outline
	
	' Front Face
	Dim pathFront As B4XPath
	pathFront.Initialize(pFrontTL.X, pFrontTL.Y)
	pathFront.LineTo(pFrontTR.X, pFrontTR.Y)
	pathFront.LineTo(pFrontBR.X, pFrontBR.Y)
	pathFront.LineTo(pFrontBL.X, pFrontBL.Y)
	pathFront.LineTo(pFrontTL.X, pFrontTL.Y)
	cvs.DrawPath(pathFront, baseClr, True, 0)
	
	' Right Side Face
	Dim pathRight As B4XPath
	pathRight.Initialize(pFrontTR.X, pFrontTR.Y)
	pathRight.LineTo(pBackTR.X, pBackTR.Y)
	pathRight.LineTo(pBackBR.X, pBackBR.Y)
	pathRight.LineTo(pFrontBR.X, pFrontBR.Y)
	pathRight.LineTo(pFrontTR.X, pFrontTR.Y)
	cvs.DrawPath(pathRight, sideColor, True, 0)
	
	' Top Face
	Dim pathTop As B4XPath
	pathTop.Initialize(pFrontTL.X, pFrontTL.Y)
	pathTop.LineTo(pBackTL.X, pBackTL.Y)
	pathTop.LineTo(pBackTR.X, pBackTR.Y)
	pathTop.LineTo(pFrontTR.X, pFrontTR.Y)
	pathTop.LineTo(pFrontTL.X, pFrontTL.Y)
	cvs.DrawPath(pathTop, topColor, True, 0)
	
	' Outlines
	cvs.DrawPath(pathFront, outlineClr, False, 1dip)
	cvs.DrawPath(pathRight, outlineClr, False, 1dip)
	cvs.DrawPath(pathTop, outlineClr, False, 1dip)
	
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

Private Sub CreatePoint(x As Float, y As Float) As CustomVerticalBarPoint 'ignore
	Dim pt As CustomVerticalBarPoint
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
