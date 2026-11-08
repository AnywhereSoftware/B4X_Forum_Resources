B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#Event: ItemClick (Result As PieClickResult)
#Event: ItemTouch (Result As PieTouchResult)
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Chart Title, Description: Main chart title text
#DesignerProperty: Key: TitleColor, DisplayName: Title Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the main title text
#DesignerProperty: Key: TitleSize, DisplayName: Title Size, FieldType: Int, DefaultValue: 16, MinRange: 8, MaxRange: 36, Description: Font size of main title
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: Chart Subtitle, Description: Secondary title text
#DesignerProperty: Key: SubTitleColor, DisplayName: SubTitle Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the sub-title text
#DesignerProperty: Key: SubTitleSize, DisplayName: SubTitle Size, FieldType: Int, DefaultValue: 12, MinRange: 8, MaxRange: 28, Description: Font size of sub-title
#DesignerProperty: Key: PieChartType, DisplayName: Chart Type, FieldType: String, DefaultValue: Pie, List: Pie, Description: Choose Pie chart display
#DesignerProperty: Key: LegendTitle, DisplayName: Legend Title, FieldType: String, DefaultValue: Legend, Description: Title header for the side legend block
#DesignerProperty: Key: LegendPosition, DisplayName: Legend Position, FieldType: String, DefaultValue: None, List: None|Right|Left, Description: Display item description legend block on side
#DesignerProperty: Key: LabelTextColor, DisplayName: Label Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color for external labels
#DesignerProperty: Key: LabelFontSize, DisplayName: Label Font Size, FieldType: Int, DefaultValue: 11, MinRange: 8, MaxRange: 36, Description: Font size for labels
#DesignerProperty: Key: LabelLineLength, DisplayName: Label Line Length, FieldType: Int, DefaultValue: 20, MinRange: 0, MaxRange: 100, Description: Length of pointer line (Set to 0 to disable lines)
#DesignerProperty: Key: Depth, DisplayName: 3D Depth, FieldType: Int, DefaultValue: 25, MinRange: 5, MaxRange: 100, Description: 3D thickness in dip
#DesignerProperty: Key: ExplodeDistance, DisplayName: Explode Distance, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 50, Description: Distance in dip to offset the largest slice (0 = connected)
#DesignerProperty: Key: TiltAngle, DisplayName: Tilt Angle (Deg), FieldType: Int, DefaultValue: 55, MinRange: 20, MaxRange: 80, Description: Perspective tilt angle
#DesignerProperty: Key: ShowValues, DisplayName: Show Values, FieldType: Boolean, DefaultValue: True, Description: Render numeric values inside slices
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color for values inside slices
#DesignerProperty: Key: ValueFontSize, DisplayName: Value Font Size, FieldType: Int, DefaultValue: 12, MinRange: 8, MaxRange: 36, Description: Font size for values
#DesignerProperty: Key: ShowTouchLine, DisplayName: Show Touch Line, FieldType: Boolean, DefaultValue: False, Description: Render a line through the center of the touched point
#DesignerProperty: Key: TouchLineColor, DisplayName: Touch Line Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the touch selection line
#DesignerProperty: Key: ShowPopupLegend, DisplayName: Show Popup Legend, FieldType: Boolean, DefaultValue: True, Description: Show a popup legend when a slice is touched

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mTag As Object
	
	Type PieSlice (Value As Float, Color As Int, Label As String)
	Type PieClickResult (Index As Int, Value As Float, Label As String)
	Type PieTouchResult (Index As Int, Value As Float, Label As String)
	Type PieGeometry (CX As Float, CY As Float, OuterR As Float, YFactor As Float)
	Type SliceCenter (X As Float, Y As Float)

	Private Const DEG2RAD As Double = 0.017453292519943295
	Private Const RAD2DEG As Double = 57.29577951308232
	
	Private mDepth As Int
	Private mTiltRad As Float
	Private mChartType As String = "Pie"
	Private mExplodeDistance As Float = 0
	Private mLabelLineLength As Int = 20
	Private mLegendPosition As String = "None"
	Private mLegendTitle As String = "Legend"
	Private mShowTouchLine As Boolean
	Private mTouchLineColor As Int
	Private mShowPopupLegend As Boolean
	
	' Title & SubTitle
	Private mTitle As String
	Private mSubTitle As String
	Private mTitleColor As Int
	Private mTitleSize As Int
	Private mSubTitleColor As Int
	Private mSubTitleSize As Int
	
	' Slice Text Properties
	Private mValueTextColor As Int
	Private mValueFontSize As Int
	Private mLabelTextColor As Int
	Private mLabelFontSize As Int
	Private mShowValues As Boolean
	
	' Fonts
	Private fontTitle As B4XFont
	Private fontSubTitle As B4XFont
	Private fontValue As B4XFont
	Private fontLabel As B4XFont
	
	Private SliceList As List
	Private TotalValue As Float = 0
	Private MaxSliceValue As Float = -1
	Private LargestSliceIndex As Int = -1
	Private IsDesignerPreview As Boolean = False
	
	#If B4J Or B4A
	Private TouchPanel As B4XView
	Private LastTouchedIndex As Int = -1
	#End If
	
	' Performance optimizations: Caching, Arrays and Coalesced Rendering
	Type CachedPieSliceColors (Top As Object, InnerWall As Object, CutFace As Object, OuterWall As Object, Outline As Object)
	Private SliceColorsList As List
	Private mRedrawPending As Boolean = False
	
	#If B4J
	Private xPoly(4) As Double
	Private yPoly(4) As Double
	#End If
End Sub

' Initialises the chart view and internal properties.
Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
	SliceList.Initialize
	SliceColorsList.Initialize
	UpdateFonts
End Sub

' Called by the B4X framework to generate the view dynamically.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	If SliceList.IsInitialized = False Then SliceList.Initialize
	If SliceColorsList.IsInitialized = False Then SliceColorsList.Initialize
	
	mChartType = Props.GetDefault("PieChartType", "Pie")
	mExplodeDistance = DipToCurrent(Props.GetDefault("ExplodeDistance", 0))
	mDepth = DipToCurrent(Props.GetDefault("Depth", 25))
	mLabelLineLength = DipToCurrent(Props.GetDefault("LabelLineLength", 20))
	mLegendPosition = Props.GetDefault("LegendPosition", "None")
	mLegendTitle = Props.GetDefault("LegendTitle", "Legend")
	mShowTouchLine = Props.GetDefault("ShowTouchLine", False)
	mTouchLineColor = xui.PaintOrColorToColor(Props.GetDefault("TouchLineColor", xui.Color_Red))
	mShowPopupLegend = Props.GetDefault("ShowPopupLegend", True)
	
	mTitle = Props.GetDefault("Title", "")
	mSubTitle = Props.GetDefault("SubTitle", "")
	mTitleColor = xui.PaintOrColorToColor(Props.GetDefault("TitleColor", xui.Color_Black))
	mTitleSize = Props.GetDefault("TitleSize", 16)
	
	mSubTitleColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleColor", xui.Color_DarkGray))
	mSubTitleSize = Props.GetDefault("SubTitleSize", 12)
	
	mValueTextColor = xui.PaintOrColorToColor(Props.GetDefault("ValueTextColor", xui.Color_White))
	mValueFontSize = Props.GetDefault("ValueFontSize", 12)
	mLabelTextColor = xui.PaintOrColorToColor(Props.GetDefault("LabelTextColor", xui.Color_DarkGray))
	mLabelFontSize = Props.GetDefault("LabelFontSize", 11)
	mShowValues = Props.GetDefault("ShowValues", True)
	
	Dim tiltDeg As Int = Props.GetDefault("TiltAngle", 55)
	mTiltRad = tiltDeg * DEG2RAD
	
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
	
	If SliceList.Size = 0 Then
		IsDesignerPreview = True
		AddSlice(46, 0xFF2196F3, "Development")
		AddSlice(25, 0xFF4CAF50, "Marketing")
		AddSlice(15, 0xFFFF9800, "Sales")
		AddSlice(14, 0xFFF44336, "Support")
	End If
	
	Base_Resize(mBase.Width, mBase.Height)
End Sub

#If B4J Or B4A
#If B4A
Private Sub p_Touch (Action As Int, X As Float, Y As Float) As Boolean
#Else
Private Sub p_Touch (Action As Int, X As Float, Y As Float)
#End If
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
#If B4A
	Return True
#End If
End Sub

Private Sub HandleTouchMove(touchX As Float, touchY As Float)
	Dim i As Int = GetSliceIndexAt(touchX, touchY)
	If i <> LastTouchedIndex Then
		LastTouchedIndex = i
		RaiseItemTouch(i)
		RequestRedraw
	End If
End Sub

Private Sub HandleClick(clickX As Float, clickY As Float)
	RaiseItemClick(GetSliceIndexAt(clickX, clickY))
End Sub

Private Sub GetSliceIndexAt(touchX As Float, touchY As Float) As Int
	If SliceList.Size = 0 Or TotalValue = 0 Then Return -1

	Dim g As PieGeometry = GetChartGeometry(DrawHeader)
	Dim startAngle As Float = -90

	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim p As SliceCenter = GetSliceCenter(i, startAngle, sweepAngle, g.CX, g.CY, g.YFactor)

		Dim dx As Float = touchX - p.X
		Dim dy As Float = (touchY - p.Y) / g.YFactor
		Dim dist As Float = Sqrt(dx * dx + dy * dy)

		If dist <= g.OuterR Then
			Dim angleDeg As Float = ATan2(dy, dx) * RAD2DEG
			If angleDeg < -90 Then angleDeg = angleDeg + 360

			If angleDeg >= startAngle And angleDeg <= startAngle + sweepAngle Then Return i
		End If

		startAngle = startAngle + sweepAngle
	Next

	Return -1
End Sub

Private Sub RaiseItemTouch(Index As Int)
	If Not(SubExists(mCallBack, mEventName & "_ItemTouch")) Then Return

	If Index < 0 Then
		CallSub2(mCallBack, mEventName & "_ItemTouch", Null)
		Return
	End If

	Dim s As PieSlice = SliceList.Get(Index)
	Dim res As PieTouchResult
	res.Initialize
	res.Index = Index
	res.Value = s.Value
	res.Label = s.Label

	CallSub2(mCallBack, mEventName & "_ItemTouch", res)
End Sub

Private Sub RaiseItemClick(Index As Int)
	If Index < 0 Or Not(SubExists(mCallBack, mEventName & "_ItemClick")) Then Return

	Dim s As PieSlice = SliceList.Get(Index)
	Dim res As PieClickResult
	res.Initialize
	res.Index = Index
	res.Value = s.Value
	res.Label = s.Label

	CallSub2(mCallBack, mEventName & "_ItemClick", res)
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
	fontValue = xui.CreateDefaultFont(mValueFontSize)
	fontLabel = xui.CreateDefaultFont(mLabelFontSize)
End Sub

Private Sub HasSideLegend As Boolean
	Dim p As String = mLegendPosition.ToUpperCase
	Return p = "RIGHT" Or p = "LEFT"
End Sub

Private Sub IsLeftLegend As Boolean
	Return mLegendPosition.ToUpperCase = "LEFT"
End Sub

Private Sub GetChartGeometry(HeaderHeight As Float) As PieGeometry
	Dim g As PieGeometry
	g.Initialize

	Dim chartAreaWidth As Float = mBase.Width
	g.CX = mBase.Width / 2

	If HasSideLegend Then
		chartAreaWidth = mBase.Width * 0.65

		If IsLeftLegend Then
			g.CX = (mBase.Width * 0.35) + (chartAreaWidth / 2)
		Else
			g.CX = chartAreaWidth / 2
		End If
	End If

	Dim availableHeight As Float = mBase.Height - HeaderHeight - mDepth
	If availableHeight <= 20dip Then availableHeight = 20dip
	g.CY = HeaderHeight + (availableHeight / 2)

	g.YFactor = Sin(mTiltRad)
	If g.YFactor <= 0.05 Then g.YFactor = 0.05

	Dim effectiveLineLen As Int = 0
	If Not(HasSideLegend) Then effectiveLineLen = mLabelLineLength

	g.OuterR = Max(10dip, Min( _
		(chartAreaWidth / 2) - (effectiveLineLen + 20dip), _
		(availableHeight / 2) / g.YFactor)) * 0.75

	Return g
End Sub

Private Sub GetSliceCenter(Index As Int, StartAngle As Float, SweepAngle As Float, _
	cx As Float, cy As Float, yFactor As Float) As SliceCenter

	Dim p As SliceCenter
	p.Initialize
	p.X = cx
	p.Y = cy

	If Index = LargestSliceIndex And mExplodeDistance > 0 Then
		Dim midRad As Float = (StartAngle + (SweepAngle / 2)) * DEG2RAD
		p.X = cx + mExplodeDistance * Cos(midRad)
		p.Y = cy + (mExplodeDistance * Sin(midRad)) * yFactor
	End If

	Return p
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

' Set the 3D depth of the chart.
Public Sub setDepth(DipVal As Int)
	mDepth = DipToCurrent(DipVal)
	RequestRedraw
End Sub

'' Set the 3D depth.
'Public Sub getDepth As Int
'	Return mDepth / xui.Scale
'End Sub

' Set the visual tilt angle (in degrees).
Public Sub setTiltAngle(DegVal As Int)
	Dim clampedDeg As Int = Min(85, Max(15, DegVal))
	mTiltRad = clampedDeg * DEG2RAD
	RequestRedraw
End Sub

'' Set the visual tilt angle.
'Public Sub getTiltAngle As Int
'	Return Round(mTiltRad * RAD2DEG)
'End Sub

' Set the label pointer line length.
Public Sub setLabelLineLength(DipVal As Int)
	mLabelLineLength = DipToCurrent(DipVal)
	RequestRedraw
End Sub

'' Set the label pointer line length.
'Public Sub getLabelLineLength As Int
'	Return mLabelLineLength / xui.Scale
'End Sub

' Set the legend block position. Supported values: "None", "Right", "Left".
Public Sub setLegendPosition(PositionStr As String)
	mLegendPosition = PositionStr
	RequestRedraw
End Sub

'' Set the current legend block position.
'Public Sub getLegendPosition As String
'	Return mLegendPosition
'End Sub

' Set the legend header text.
Public Sub setLegendTitle(Text As String)
	mLegendTitle = Text
	RequestRedraw
End Sub

'' Set the legend header text.
'Public Sub getLegendTitle As String
'	Return mLegendTitle
'End Sub

' Set whether rendering a line through the touched point is enabled.
Public Sub setShowTouchLine(Enabled As Boolean)
	mShowTouchLine = Enabled
	RequestRedraw
End Sub

'' Set whether the touch line is displayed.
'Public Sub getShowTouchLine As Boolean
'	Return mShowTouchLine
'End Sub

' Set whether a popup legend is displayed when a slice is touched.
Public Sub setShowPopupLegend(Enabled As Boolean)
	mShowPopupLegend = Enabled
	RequestRedraw
End Sub

'' Set whether the popup legend is enabled.
'Public Sub getShowPopupLegend As Boolean
'	Return mShowPopupLegend
'End Sub

' Set the color for the touch selection line.
Public Sub setTouchLineColor(Clr As Int)
	mTouchLineColor = Clr
	RequestRedraw
End Sub

'' Set the touch line color.
'Public Sub getTouchLineColor As Int
'	Return mTouchLineColor
'End Sub

' Set the chart display type. Accepts "Pie".
Public Sub setPieChartType(TypeStr As String)
	mChartType = "Pie"
	RequestRedraw
End Sub

' Set the active chart display type.
Public Sub getPieChartType As String
	Return mChartType
End Sub

' Set whether numeric values are rendered inside the slices.
Public Sub setShowValues(Enabled As Boolean)
	mShowValues = Enabled
	RequestRedraw
End Sub

'' Set whether values are being rendered on the slices.
'Public Sub getShowValues As Boolean
'	Return mShowValues
'End Sub

' Set the primary chart title.
Public Sub setTitle(Text As String)
	mTitle = Text
	RequestRedraw
End Sub

'' Set the primary chart title.
'Public Sub getTitle As String
'	Return mTitle
'End Sub

' Set the color for the primary chart title text.
Public Sub setTitleColor(Clr As Int)
	mTitleColor = Clr
	RequestRedraw
End Sub

'' Set the title text color.
'Public Sub getTitleColor As Int
'	Return mTitleColor
'End Sub

' Set the secondary chart subtitle.
Public Sub setSubTitle(Text As String)
	mSubTitle = Text
	RequestRedraw
End Sub

'' Set the secondary chart subtitle.
'Public Sub getSubTitle As String
'	Return mSubTitle
'End Sub

' Set the color for the secondary chart sub-title text.
Public Sub setSubTitleColor(Clr As Int)
	mSubTitleColor = Clr
	RequestRedraw
End Sub

'' Set the sub-title text color.
'Public Sub getSubTitleColor As Int
'	Return mSubTitleColor
'End Sub

' Set the color for values rendered inside the slices.
Public Sub setValueTextColor(Clr As Int)
	mValueTextColor = Clr
	RequestRedraw
End Sub

'' Set the value text color.
'Public Sub getValueTextColor As Int
'	Return mValueTextColor
'End Sub

' Set the font size for slice values.
Public Sub setValueFontSize(Size As Int)
	mValueFontSize = Size
	UpdateFonts
	RequestRedraw
End Sub

'' Set the font size for slice values.
'Public Sub getValueFontSize As Int
'	Return mValueFontSize
'End Sub

' Set the color for labels rendered outside the slices.
Public Sub setLabelTextColor(Clr As Int)
	mLabelTextColor = Clr
	RequestRedraw
End Sub

'' Set the color for labels rendered outside the slices.
'Public Sub getLabelTextColor As Int
'	Return mLabelTextColor
'End Sub

' Set the font size for slice labels.
Public Sub setLabelFontSize(Size As Int)
	mLabelFontSize = Size
	UpdateFonts
	RequestRedraw
End Sub

'' Set the font size for slice labels.
'Public Sub getLabelFontSize As Int
'	Return mLabelFontSize
'End Sub

Private Sub ResetSlices
	SliceList.Clear
	SliceColorsList.Clear
	TotalValue = 0
	MaxSliceValue = -1
	LargestSliceIndex = -1
End Sub

' Clears the chart of all slices.
Public Sub Clear
	ResetSlices
	IsDesignerPreview = False
	#If B4J Or B4A
	LastTouchedIndex = -1
	#End If
	RequestRedraw
End Sub

Private Sub CreateCachedColors(Color As Int) As CachedPieSliceColors
	Dim csc As CachedPieSliceColors
	csc.Initialize

	#If B4J
	csc.Top = GetFXColor(Color)
	csc.InnerWall = GetFXColor(DarkenColor(Color, 0.5))
	csc.CutFace = GetFXColor(DarkenColor(Color, 0.55))
	csc.OuterWall = GetFXColor(DarkenColor(Color, 0.65))
	csc.Outline = GetFXColor(DarkenColor(Color, 0.7))
	#Else
	csc.Top = Color
	csc.InnerWall = DarkenColor(Color, 0.5)
	csc.CutFace = DarkenColor(Color, 0.55)
	csc.OuterWall = DarkenColor(Color, 0.65)
	csc.Outline = DarkenColor(Color, 0.7)
	#End If

	Return csc
End Sub

' Adds a new data slice to the chart sequence.
Public Sub AddSlice(Value As Float, Color As Int, Label As String)
	If IsDesignerPreview Then
		ResetSlices
		IsDesignerPreview = False
	End If

	Dim s As PieSlice
	s.Initialize
	s.Value = Value
	s.Color = Color
	s.Label = Label
	SliceList.Add(s)
	
	SliceColorsList.Add(CreateCachedColors(Color))
	
	TotalValue = TotalValue + Value
	If Value > MaxSliceValue Then
		MaxSliceValue = Value
		LargestSliceIndex = SliceList.Size - 1
	End If
	
	RequestRedraw
End Sub

' Repaints the entire chart onto the canvas based on current configurations and data.
Public Sub Redraw
	If mBase.Width <= 0 Or mBase.Height <= 0 Then Return

	Dim rect As B4XRect
	rect.Initialize(0, 0, mBase.Width, mBase.Height)
	cvs.ClearRect(rect)

	Dim g As PieGeometry
	g = GetChartGeometry(DrawHeader)

	If SliceList.Size = 0 Or TotalValue = 0 Then
		cvs.Invalidate
		Return
	End If

	' 1. Draw 3D Side Walls
	Draw3DSideWalls(g.CX, g.CY, g.OuterR, g.YFactor)

	' 2. Draw Top Flat Cap Slices
	DrawTopSlices(g.CX, g.CY, g.OuterR, g.YFactor)

	' 3. Draw Labels / Values / Side Legend
	DrawLabelsAndValues(g.CX, g.CY, g.OuterR, g.YFactor)
	If HasSideLegend Then
		DrawLegendBlock
	End If

	' Render Touch Line if active
	#If B4J Or B4A
	If mShowTouchLine And LastTouchedIndex >= 0 And LastTouchedIndex < SliceList.Size Then
		Dim startAngle As Float = -90
		For i = 0 To LastTouchedIndex - 1
			Dim sPrev As PieSlice = SliceList.Get(i)
			startAngle = startAngle + ((sPrev.Value / TotalValue) * 360)
		Next

		Dim sActive As PieSlice = SliceList.Get(LastTouchedIndex)
		Dim sweepActive As Float = (sActive.Value / TotalValue) * 360
		Dim midTouchRad As Float = (startAngle + (sweepActive / 2)) * DEG2RAD

		Dim p As SliceCenter = GetSliceCenter(LastTouchedIndex, startAngle, sweepActive, g.CX, g.CY, g.YFactor)

		Dim touchLineX As Float = p.X + (g.OuterR * 0.75) * Cos(midTouchRad)
		Dim touchLineY As Float = p.Y + ((g.OuterR * 0.75) * Sin(midTouchRad)) * g.YFactor

		cvs.DrawLine(p.X, p.Y, touchLineX, touchLineY, mTouchLineColor, 2dip)
	End If
	
	If mShowPopupLegend And LastTouchedIndex >= 0 And LastTouchedIndex < SliceList.Size Then
		Dim sTouched As PieSlice = SliceList.Get(LastTouchedIndex)
		Dim lines As List
		lines.Initialize
		lines.Add(sTouched.Label)
		If TotalValue > 0 Then
			Dim pct As Float = (sTouched.Value / TotalValue) * 100
			lines.Add("Share: " & NumberFormat(pct, 1, 1) & "%")
		End If
		
		Dim maxW As Float = 0
		Dim lineH As Float = 0
		For Each lineText As String In lines
			Dim rText As B4XRect = cvs.MeasureText(lineText, fontLabel)
			If rText.Width > maxW Then maxW = rText.Width
			If rText.Height > lineH Then lineH = rText.Height
		Next
		lineH = lineH + 6dip
		
		Dim boxLeft As Float = 10dip
		Dim boxTop As Float = DrawHeader + 4dip
		Dim boxWidth As Float = maxW + 16dip
		Dim boxHeight As Float = (lines.Size * lineH) + 8dip
		
		Dim rBox As B4XRect
		rBox.Initialize(boxLeft, boxTop, boxLeft + boxWidth, boxTop + boxHeight)
		
		cvs.DrawRect(rBox, XUI.Color_ARGB(192, 255, 255, 255), True, 0)
		cvs.DrawRect(rBox, xui.Color_LightGray, False, 1dip)
		
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
Private Sub Draw3DSideWalls(cx As Float, cy As Float, outerR As Float, yFactor As Float)
	Dim gc As JavaObject = GetGraphicsContext

	' --- PASS 1: Radial Cut Faces ---
	Dim startAngleCut As Float = -90
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngleCut + sweepAngle
		
		Dim p As SliceCenter = GetSliceCenter(i, startAngleCut, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = p.X
		Dim sliceCY As Float = p.Y
		
		Dim rStart As Float = startAngleCut * DEG2RAD
		Dim sx1 As Float = sliceCX
		Dim sy1 As Float = sliceCY
		Dim sx2 As Float = sliceCX + outerR * Cos(rStart)
		Dim sy2 As Float = sliceCY + (outerR * Sin(rStart)) * yFactor
		
		If mExplodeDistance > 0 Or Sin(rStart) > 0 Then
			DrawQuad(sx1, sy1, sx2, sy2, sx2, sy2 + mDepth, sx1, sy1 + mDepth, csc.CutFace)
		End If
		
		Dim rEnd As Float = endAngle * DEG2RAD
		Dim ex1 As Float = sliceCX
		Dim ey1 As Float = sliceCY
		Dim ex2 As Float = sliceCX + outerR * Cos(rEnd)
		Dim ey2 As Float = sliceCY + (outerR * Sin(rEnd)) * yFactor
		
		If mExplodeDistance > 0 Or Sin(rEnd) > 0 Then
			DrawQuad(ex1, ey1, ex2, ey2, ex2, ey2 + mDepth, ex1, ey1 + mDepth, csc.CutFace)
		End If
		
		startAngleCut = endAngle
	Next

	' --- PASS 2: Outer Rim Front Wall Surface (0 to 180 Deg) ---
	Dim startAngleOuter As Float = -90
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngleOuter + sweepAngle
		
		Dim pC As SliceCenter = GetSliceCenter(i, startAngleOuter, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = pC.X
		Dim sliceCY As Float = pC.Y
		
		Dim a1 As Float = Max(startAngleOuter, 0)
		Dim a2 As Float = Min(endAngle, 180)
		
		If a2 > a1 Then
			Dim arcSteps As Int = Ceil(Abs(a2 - a1)) + 1
			EnsurePolyCapacity(arcSteps * 2)
			
			Dim ptIdx As Int = 0
			Dim stepA As Float = a1
			Do While True
				Dim currentA As Float = Min(stepA, a2)
				Dim rad As Float = currentA * DEG2RAD
				xPoly(ptIdx) = sliceCX + outerR * Cos(rad)
				yPoly(ptIdx) = sliceCY + (outerR * Sin(rad)) * yFactor
				ptIdx = ptIdx + 1
				If currentA >= a2 Then Exit
				stepA = stepA + 1
				If stepA > a2 Then stepA = a2
			Loop
			
			stepA = a2
			Do While True
				Dim currentA As Float = Max(stepA, a1)
				Dim rad As Float = currentA * DEG2RAD
				xPoly(ptIdx) = sliceCX + outerR * Cos(rad)
				yPoly(ptIdx) = sliceCY + (outerR * Sin(rad)) * yFactor + mDepth
				ptIdx = ptIdx + 1
				If currentA <= a1 Then Exit
				stepA = stepA - 1
				If stepA < a1 Then stepA = a1
			Loop
			
			gc.RunMethod("setFill", Array(csc.OuterWall))
			gc.RunMethod("fillPolygon", Array(xPoly, yPoly, ptIdx))
		End If
		
		startAngleOuter = endAngle
	Next
End Sub

Private Sub DrawTopSlices(cx As Float, cy As Float, outerR As Float, yFactor As Float)
	Dim startAngle As Float = -90
	Dim gc As JavaObject = GetGraphicsContext
	
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngle + sweepAngle
		
		Dim pC As SliceCenter = GetSliceCenter(i, startAngle, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = pC.X
		Dim sliceCY As Float = pC.Y
		
		Dim outerSteps As Int = Ceil(Abs(endAngle - startAngle)) + 1
		EnsurePolyCapacity(outerSteps + 1)
		
		Dim ptIdx As Int = 0
		Dim stepA As Float = startAngle
		Do While True
			Dim currentA As Float = Min(stepA, endAngle)
			Dim rad As Float = currentA * DEG2RAD
			xPoly(ptIdx) = sliceCX + outerR * Cos(rad)
			yPoly(ptIdx) = sliceCY + (outerR * Sin(rad)) * yFactor
			ptIdx = ptIdx + 1
			If currentA >= endAngle Then Exit
			stepA = stepA + 1
			If stepA > endAngle Then stepA = endAngle
		Loop
		
		xPoly(ptIdx) = sliceCX
		yPoly(ptIdx) = sliceCY
		ptIdx = ptIdx + 1
		
		gc.RunMethod("setFill", Array(csc.Top))
		gc.RunMethod("fillPolygon", Array(xPoly, yPoly, ptIdx))
		
		startAngle = endAngle
	Next
End Sub

Private Sub DrawQuad(x1 As Float, y1 As Float, x2 As Float, y2 As Float, x3 As Float, y3 As Float, x4 As Float, y4 As Float, clrObj As Object)
	EnsurePolyCapacity(4)
	xPoly(0) = x1 : yPoly(0) = y1
	xPoly(1) = x2 : yPoly(1) = y2
	xPoly(2) = x3 : yPoly(2) = y3
	xPoly(3) = x4 : yPoly(3) = y4
	Dim gc As JavaObject = GetGraphicsContext
	gc.RunMethod("setFill", Array(clrObj))
	gc.RunMethod("fillPolygon", Array(xPoly, yPoly, 4))
End Sub
#Else
Private Sub Draw3DSideWalls(cx As Float, cy As Float, outerR As Float, yFactor As Float)
	' --- PASS 1: Radial Cut Faces ---
	Dim startAngleCut As Float = -90
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngleCut + sweepAngle
		
		Dim pC As SliceCenter = GetSliceCenter(i, startAngleCut, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = pC.X
		Dim sliceCY As Float = pC.Y
		
		Dim rStart As Float = startAngleCut * DEG2RAD
		Dim sx1 As Float = sliceCX
		Dim sy1 As Float = sliceCY
		Dim sx2 As Float = sliceCX + outerR * Cos(rStart)
		Dim sy2 As Float = sliceCY + (outerR * Sin(rStart)) * yFactor
		
		If mExplodeDistance > 0 Or Sin(rStart) > 0 Then
			DrawQuad(sx1, sy1, sx2, sy2, sx2, sy2 + mDepth, sx1, sy1 + mDepth, csc.CutFace)
		End If
		
		Dim rEnd As Float = endAngle * DEG2RAD
		Dim ex1 As Float = sliceCX
		Dim ey1 As Float = sliceCY
		Dim ex2 As Float = sliceCX + outerR * Cos(rEnd)
		Dim ey2 As Float = sliceCY + (outerR * Sin(rEnd)) * yFactor
		
		If mExplodeDistance > 0 Or Sin(rEnd) > 0 Then
			DrawQuad(ex1, ey1, ex2, ey2, ex2, ey2 + mDepth, ex1, ey1 + mDepth, csc.CutFace)
		End If
		
		startAngleCut = endAngle
	Next

	' --- PASS 2: Outer Rim Front Wall Surface (0 to 180 Deg) ---
	Dim startAngleOuter As Float = -90
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngleOuter + sweepAngle
		
		Dim pC As SliceCenter = GetSliceCenter(i, startAngleOuter, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = pC.X
		Dim sliceCY As Float = pC.Y
		
		Dim a1 As Float = Max(startAngleOuter, 0)
		Dim a2 As Float = Min(endAngle, 180)
		
		If a2 > a1 Then
			Dim pOuter As B4XPath
			Dim firstPoint As Boolean = True
			
			Dim stepA As Float = a1
			Do While True
				Dim currentA As Float = Min(stepA, a2)
				Dim rad As Float = currentA * DEG2RAD
				Dim px As Float = sliceCX + outerR * Cos(rad)
				Dim py As Float = sliceCY + (outerR * Sin(rad)) * yFactor
				If firstPoint Then
					pOuter.Initialize(px, py)
					firstPoint = False
				Else
					pOuter.LineTo(px, py)
				End If
				If currentA >= a2 Then Exit
				stepA = stepA + 1
				If stepA > a2 Then stepA = a2
			Loop
			
			stepA = a2
			Do While True
				Dim currentA As Float = Max(stepA, a1)
				Dim rad As Float = currentA * DEG2RAD
				Dim px As Float = sliceCX + outerR * Cos(rad)
				Dim py As Float = sliceCY + (outerR * Sin(rad)) * yFactor + mDepth
				pOuter.LineTo(px, py)
				If currentA <= a1 Then Exit
				stepA = stepA - 1
				If stepA < a1 Then stepA = a1
			Loop
			
			cvs.DrawPath(pOuter, csc.OuterWall, True, 0)
		End If
		
		startAngleOuter = endAngle
	Next
End Sub

Private Sub DrawTopSlices(cx As Float, cy As Float, outerR As Float, yFactor As Float)
	Dim startAngle As Float = -90
	
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim csc As CachedPieSliceColors = SliceColorsList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		Dim endAngle As Float = startAngle + sweepAngle
		
		Dim pC As SliceCenter = GetSliceCenter(i, startAngle, sweepAngle, cx, cy, yFactor)
		Dim sliceCX As Float = pC.X
		Dim sliceCY As Float = pC.Y
		
		Dim p As B4XPath
		Dim firstPoint As Boolean = True
		
		Dim stepA As Float = startAngle
		Do While True
			Dim currentA As Float = Min(stepA, endAngle)
			Dim rad As Float = currentA * DEG2RAD
			Dim px As Float = sliceCX + outerR * Cos(rad)
			Dim py As Float = sliceCY + (outerR * Sin(rad)) * yFactor
			If firstPoint Then
				p.Initialize(px, py)
				firstPoint = False
			Else
				p.LineTo(px, py)
			End If
			If currentA >= endAngle Then Exit
			stepA = stepA + 1
			If stepA > endAngle Then stepA = endAngle
		Loop
		
		p.LineTo(sliceCX, sliceCY)
		
		cvs.DrawPath(p, csc.Top, True, 0)
		startAngle = endAngle
	Next
End Sub

Private Sub DrawQuad(x1 As Float, y1 As Float, x2 As Float, y2 As Float, x3 As Float, y3 As Float, x4 As Float, y4 As Float, clr As Int)
	Dim p As B4XPath
	p.Initialize(x1, y1)
	p.LineTo(x2, y2)
	p.LineTo(x3, y3)
	p.LineTo(x4, y4)
	cvs.DrawPath(p, clr, True, 0)
End Sub
#End If

Private Sub DrawLabelsAndValues(cx As Float, cy As Float, outerR As Float, yFactor As Float)
	Dim startAngle As Float = -90
	Dim midRadius As Float = outerR * 0.65

	Dim pointerStartR As Float = outerR + 2dip
	Dim pointerEndR As Float = outerR + mLabelLineLength
	
	Dim lastRightY As Float = -10000
	Dim lastLeftY As Float = 10000
	Dim minSpacing As Float = mLabelFontSize + 12dip
	
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		Dim sweepAngle As Float = (s.Value / TotalValue) * 360
		
		Dim p As SliceCenter = GetSliceCenter(i, startAngle, sweepAngle, cx, cy, yFactor)
		
		Dim midAngle As Float = startAngle + (sweepAngle / 2)
		Dim rad As Float = midAngle * DEG2RAD
		
		Dim cosA As Float = Cos(rad)
		Dim sinA As Float = Sin(rad)
		
		If mShowValues Then
			Dim vx As Float = p.X + midRadius * cosA
			Dim vy As Float = p.Y + (midRadius * sinA) * yFactor
			Dim valTxt As String = NumberFormat(s.Value, 1, 0)
			cvs.DrawText(valTxt, vx, vy + (mValueFontSize / 3), fontValue, mValueTextColor, "CENTER")
		End If
		
		' Draw pointer lines ONLY if side legend is turned OFF and line length > 0
		If Not(HasSideLegend) And mLabelLineLength > 0 And s.Label <> "" Then
			Dim depthOffset As Float = 0
			If sinA > 0 Then
				depthOffset = mDepth * sinA
			End If
			
			Dim px1 As Float = p.X + pointerStartR * cosA
			Dim py1 As Float = p.Y + (pointerStartR * sinA) * yFactor + depthOffset
			
			Dim px2 As Float = p.X + pointerEndR * cosA
			Dim py2 As Float = p.Y + (pointerEndR * sinA) * yFactor + depthOffset
			
			Dim alignment As String = "LEFT"
			Dim labelXOffset As Float = 4dip
			
			If cosA >= 0 Then
				alignment = "LEFT"
				labelXOffset = 4dip
				If py2 < lastRightY + minSpacing Then
					py2 = lastRightY + minSpacing
				End If
				lastRightY = py2
				
				Dim dy As Float = py2 - p.Y
				Dim sinA_new As Float
				If dy > 0 Then
					sinA_new = dy / (pointerEndR * yFactor + mDepth)
				Else
					sinA_new = dy / (pointerEndR * yFactor)
				End If
				
				If sinA_new > 1 Then sinA_new = 1
				If sinA_new < -1 Then sinA_new = -1
				
				Dim cosA_new As Float = Sqrt(1 - (sinA_new * sinA_new))
				px2 = p.X + pointerEndR * cosA_new
				
				If px2 < px1 + 10dip Then px2 = px1 + 10dip
			Else
				alignment = "RIGHT"
				labelXOffset = -4dip
				If py2 > lastLeftY - minSpacing Then
					py2 = lastLeftY - minSpacing
				End If
				lastLeftY = py2
				
				Dim dy As Float = py2 - p.Y
				Dim sinA_new As Float
				If dy > 0 Then
					sinA_new = dy / (pointerEndR * yFactor + mDepth)
				Else
					sinA_new = dy / (pointerEndR * yFactor)
				End If
				
				If sinA_new > 1 Then sinA_new = 1
				If sinA_new < -1 Then sinA_new = -1
				
				Dim cosA_new As Float = Sqrt(1 - (sinA_new * sinA_new))
				px2 = p.X - pointerEndR * cosA_new
				
				If px2 > px1 - 10dip Then px2 = px1 - 10dip
			End If
			
			cvs.DrawLine(px1, py1, px2, py2, DarkenColor(s.Color, 0.8), 1.5dip)
			cvs.DrawText(s.Label, px2 + labelXOffset, py2 + (mLabelFontSize / 3), fontLabel, mLabelTextColor, alignment)
		End If
		
		startAngle = startAngle + sweepAngle
	Next
End Sub

Private Sub DrawLegendBlock
	If SliceList.Size = 0 Then Return

	' Indent the left legend further in to match the visual margin of the right legend
	Dim legendX As Float = mBase.Width * 0.18
	If mLegendPosition.ToUpperCase = "RIGHT" Then
		legendX = mBase.Width * 0.67
	End If
	
	Dim swatchSize As Float = 14dip
	Dim rowSpacing As Float = 22dip
	
	' Dynamic vertical centering calculation based on total content height
	Dim totalContentHeight As Float = SliceList.Size * rowSpacing
	If mLegendTitle <> "" Then
		totalContentHeight = totalContentHeight + mTitleSize + 10dip
	End If
	
	Dim currentY As Float = (mBase.Height - totalContentHeight) / 2
	
	' Render Legend Header Title if supplied
	If mLegendTitle <> "" Then
		cvs.DrawText(mLegendTitle, legendX, currentY + (mTitleSize / 2), fontTitle, mTitleColor, "LEFT")
		currentY = currentY + mTitleSize + 10dip
	End If
	
	For i = 0 To SliceList.Size - 1
		Dim s As PieSlice = SliceList.Get(i)
		
		' Draw Swatch Box
		Dim r As B4XRect
		r.Initialize(legendX, currentY, legendX + swatchSize, currentY + swatchSize)
		cvs.DrawRect(r, s.Color, True, 0)
		cvs.DrawRect(r, DarkenColor(s.Color, 0.7), False, 1dip)
		
		' Draw Label Text beside swatch
		Dim txtX As Float = legendX + swatchSize + 8dip
		Dim txtY As Float = currentY + (swatchSize / 2) + (mLabelFontSize / 3)
		cvs.DrawText(s.Label, txtX, txtY, fontLabel, mLabelTextColor, "LEFT")
		
		currentY = currentY + rowSpacing
	Next
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
