B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
'xGraph Custom View class
'Version 1.7 2022.06.20
'Added ScaleOnZoomdPart property
'Added ZoomChanged event
'
'Version 1.6 2021.09.11
'Ammended some bugs
'
'Version 1.5 2021.03.19
'Amended problem with tooltip label remaining visible
'
'Version 1.4 2021.02.22
'Set CurveStrokeWidth to Public
'Added CalcRMSValue, RMS calculation of a curve
'Added CalcSmooth, smoothing of a curve
'Added CalcSmoothExponentialLag and CalcSmoothExponentialLead smouthing methods
'Added DrawCurve(Index), draws one curve with the given index
'Added DrawCurves(Index()), superimposes up to 4 curves with the given indexes
'Added SetGraphToSynchronize method, allows to synchronize two xGraph objects.
'Added DeSynchronize method
'Added UnZoom method

'Version 1.3 2020.06.23
'Added GraphWithMissingData and MissingDataValue properties
'Updated the Tag property according to Erels recommandation:
'https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358
'Added two cursors with display of the curvevalues.
'Added a Touch event which return 
'Added a CursorPositionChanged event returning the CursoorIndex and XIndex.
'Added these properties XIndexBegin, XIndexEnd. GraphLeft, GraphTop, GraphWidth and GraphHeight
'
'Version 1.2 2020.02.23
'Set CurveColor to Public
'
'Version 1.1 2019.12.14
'Version 1.0 2019.04.26
'
'Written by Klaus CHRISTL (klaus)

#Event: Touch (Parameters() As TouchParameters)
#RaisesSynchronousEvents: Touch(Parameters())
#Event: CursorPositionChanged (CursorIndex As Int, XIndex As Int)
#RaisesSynchronousEvents: CursorPositionChanged (CursorIndex As Int, XIndex As Int)
#Event: ZoomChanged (ZoomBeginIndex As Int, ZoomEndIndex As Int)
#RaisesSynchronousEvents: ZoomChanged (ZoomBeginIndex As Int, ZoomEndIndex As Int)

#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Graph, Description: Graph title.
#DesignerProperty: Key: XAxisName, DisplayName: XAxisName, FieldType: String, DefaultValue: Time, Description: X axis name.
#DesignerProperty: Key: XAxisUnit, DisplayName: XAxisUnit, FieldType: String, DefaultValue: s, Description: X axis unit.
#DesignerProperty: Key: NbMaxSamples, DisplayName: NbMaxSamples, FieldType: Int, DefaultValue: 1000, Description: Number max of samples.
#DesignerProperty: Key: NbMaxCurves, DisplayName: NbMaxCurves, FieldType: Int, DefaultValue: 10, Description: Number max of curves.
#DesignerProperty: Key: NbXIntervals, DisplayName: NbXIntervals, FieldType: Int, DefaultValue: 15, Description: Number of X intervals.
#DesignerProperty: Key: NbYIntervals, DisplayName: NbYIntervals, FieldType: Int, DefaultValue: 10, Description: Number of Y intervals.
#DesignerProperty: Key: GraphColor, DisplayName: Graph background color, FieldType: Color, DefaultValue: 0xFFF4EFE4, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridFrameColor, DisplayName: GridFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridColor, DisplayName: GridColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: TitleTextColor, DisplayName: TitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Title text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: ScaleTextColor, DisplayName: ScaleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Scale text color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: TitleTextSize, DisplayName: TitleTextSize, FieldType: Int, DefaultValue: 14, Description: Sets the curves text size. Has no effect with automatic text sizes.
#DesignerProperty: Key: CurveTextSize, DisplayName: CurveTextSize, FieldType: Int, DefaultValue: 12, Description: Sets the title text size. Has no effect with automatic text sizes.
#DesignerProperty: Key: ScaleTextSize, DisplayName: ScaleTextSize, FieldType: Int, DefaultValue: 12, Description: Sets the scales text size. Has no effect with automatic text sizes.
#DesignerProperty: Key: AutomaticTextSizes, DisplayName: AutomaticTextSizes, FieldType: Boolean, DefaultValue: True, Description: All text sizes are calculated according to tje Graph size.
#DesignerProperty: Key: AutomaticScale, DisplayName: AutomaticScale, FieldType: Boolean, DefaultValue: True, Description: The scales are calculated automatically.
#DesignerProperty: Key: ScaleXValues, DisplayName: ScaleXValues, FieldType: String, DefaultValue: 1!2!2.5!5!10, List: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10, Description: X-axis scale values; a string with the different possible scale values separated by the exclamation mark and must begin with 1! and end with !10.
#DesignerProperty: Key: ScaleYValues, DisplayName: ScaleYValues, FieldType: String, DefaultValue: 1!2!2.5!5!10, Description: The scale is calculated for the zoomed part.
#DesignerProperty: Key: ScaleOnZoomedPartOnly, DisplayName: ScaleOnZoomedPartOnly, FieldType: Boolean, DefaultValue: True, List: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10, Description: Y-axis scale values; a string with the different possible scale values separated by the exclamation mark and must begin with 1! and end with !10.
#DesignerProperty: Key: OuterFrame, DisplayName: OuterFrame, FieldType: Boolean, DefaultValue: False, Description: Adds an outer frame.
#DesignerProperty: Key: OuterFrameColor, DisplayName: OuterFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Outer frame color.
#DesignerProperty: Key: DisplayCurveUnit, DisplayName: DisplayCurveUnit, FieldType: Boolean, DefaultValue: True, Description: Display the curve units after the curve name.
#DesignerProperty: Key: DisplayCurveIndex, DisplayName: DisplayCurveIndex, FieldType: Boolean, DefaultValue: True, Description: Display the curve index before the curve name.
#DesignerProperty: Key: GraphWithMissingData, DisplayName: GraphWithMissingData, FieldType: Boolean, DefaultValue: False, Description: Manages curves with missing data. It is necessary to enter the MissingDataValue in place.
#DesignerProperty: Key: MissingDataValue, DisplayName: MissingDataValue, FieldType: Int, DefaultValue: 100000000, Description: Used when GraphWithMissingData = True; the missing data must be replaced by this value.
#DesignerProperty: Key: UseCustomColors, DisplayName: UseCustomColors, FieldType: Boolean, DefaultValue: False, Description: False = four standard colors and True = one color for each curve.

Sub Class_Globals
	Type GraphData (Title As String, XAxisName As String, XAxisUnit As String, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, Rect As B4XRect, NbYIntervals As Int, YInterval As Int, NbXIntervals As Int, NbCurrentXIntervals As Int, XInterval As Int, XOffset As Int, GraphColor As Int, GridFrameColor As Int, GridColor As Int, XScaleTextOrientation As String, SameScaleCurveIndex As Int, OuterFrame As Boolean, OuterFrameColor As Int, ScaleYValues As String, ScaleXValues As String, ScaleOnZoomedPartOnly As Boolean)
	Type ScaleXData (Scale As Double, MinVal As Double, MaxVal As Double, MinManu As Double, MaxManu As Double,	IntervalManu As Double, MinAuto As Double, MaxAuto As Double, IntervalAuto As Double, Interval As Double, Automatic As Boolean, Exp As Int, Offset As Double, Extend As Double, NbSamples As Int, IBegin As Int, IEnd As Int)
	Type ScaleYData (Scale As Double, MinVal As Double, MaxVal As Double, MinManu As Double, MaxManu As Double,	IntervalManu As Double, MinAuto As Double, MaxAuto As Double, IntervalAuto As Double, Interval As Double, Automatic As Boolean, Exp As Int)
	Type TextsData (TitleFont As B4XFont, LineFont As B4XFont, ScaleFont As B4XFont, AutomaticTextSizes As Boolean, TitleTextSize As Float, TitleTextColor As Int, CurveTextSize As Float, ScaleTextSize As Float, ScaleTextColor As Int, TitleTextHeight As Int, CurveTextHeight As Int, ScaleTextHeight As Int)
	Type ScaleValues (MinValue As Double, MaxValue As Double)
	Type CursorsData (XIndex As Int, XValue As Double, Rect As B4XRect, Color As Int)
	Type TouchParameters (Action As Int, X As Int, Y As Int, XIndex As Int)
	
	#If B4J
	Private fx As JFX	
	#End If
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Public Tag As Object
	
	Private xui As XUI
	
	Private xcvsGraph As B4XCanvas
	
	Private xpnlCursor As B4XView
	Private xcvsCursor As B4XCanvas

	Private xpnlTwoCursors As B4XView
	Private xcvsTwoCursors As B4XCanvas

	Private xpnlZoomedArea As B4XView
	Private xcvsZoomedArea As B4XCanvas
	
	Private RectTimeText, RectValuesText, RectCursor, RectCursor1, RectZoomCursor, RectZoomCursorArea, RectZoomedArea, RectTwoCursorsTexts, RectSelected, RectSelectedFull As B4XRect
	
	Private Graph As GraphData
	Private ScaleX As ScaleXData
	Private ScalesY() As ScaleYData
	Private Texts As TextsData

	Private lstCurves As List
	Private lstCurvesToDisplay As List
	
	Private mNbMaxSamples, mNbMaxCurves As Int
	Public CurveX(20000) As Double
	Public CurveY(2, 20000) As Double
	Public CurveYName(10) As String
	Public CurveYUnit(10) As String
	Public CurveCustomColor(10) As Int
	Public CurveCustomWidth(10) As Int
	Public CurveDrawYScale(10) As Boolean
	Public CurveColor(4) As Int
	Public CurveWidth(4) As Int
	Private SingleCurveNames = True As Boolean
	Private mDisplayCurveUnit = True As Boolean
	Private mDisplayCurveIndex = True As Boolean
	Private Zoomed = False As Boolean
	Private ZoomX, ZoomDelta, IBegin, IEnd, ZoomIBegin As Int
	Private ZoomScale As Double
	Private FirstInit = True As Boolean
	Private mZoomMode = -1 As Int
	Private mAutomaticYScales = True As Boolean
	Private mCursorMode = -1 As Int
	Private mCurrentCursor = -1 As Int
	Private lstTwoCursors As List
	Private mDrawCursorValues = False As Boolean
	Private lblComments As Label
	Private xlblComments As B4XView
	Private mGraphWithMissingData As Boolean
	Private mMissingDataValue As Int
	Private mUseCustomColors As Boolean
	
	Private SameYScales = -1 As Int

	Private StandardCursorColor = xui.Color_Red As Int
	Private ZoomCursorColor = xui.Color_Blue As Int
	Private CursorActive = False As Boolean
	Private ZoomCursorActive = False As Boolean
	Private mSynchronizeGraphs = False As Boolean
	Private mSynchGraphSelected = False As Boolean
	Private mSelectedGraphShow, mSynchronizeZoom, mDisplaySynchronizedZoomArea As Boolean
	Private mSelectedGraphColor As Int
	Private mGraphToSynchronize As xGraph
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	ScaleX.Initialize
	Graph.Initialize
	lstCurves.Initialize
	lstCurvesToDisplay.Initialize2(Array As Int(0))
	lstTwoCursors.Initialize
	
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	xcvsGraph.Initialize(mBase)

	xpnlTwoCursors = xui.CreatePanel("xpnlTwoCursors")
	mBase.AddView(xpnlTwoCursors, 0, 0, mBase.Width, mBase.Height)
	xcvsTwoCursors.Initialize(xpnlTwoCursors)

	xpnlZoomedArea = xui.CreatePanel("xpnlTwoCursors")
	mBase.AddView(xpnlZoomedArea, 0, 0, mBase.Width, mBase.Height)
	xcvsZoomedArea.Initialize(xpnlZoomedArea)

	xpnlCursor = xui.CreatePanel("xpnlCursor")
	mBase.AddView(xpnlCursor, 0, 0, mBase.Width, mBase.Height)
	xcvsCursor.Initialize(xpnlCursor)
	
	lblComments.Initialize("")
	mBase.AddView(lblComments, 0, 0, mBase.Width, 35dip)
	xlblComments = lblComments
	xlblComments.Visible = False
	xlblComments.Color = xui.Color_Blue
	xlblComments.TextColor = xui.Color_Yellow
	xlblComments.SetTextAlignment("CENTER", "CENTER")
	
	Graph.SameScaleCurveIndex = -1
	Graph.Title = Props.Get("Title")
	Graph.XAxisName = Props.Get("XAxisName")
	Graph.XAxisUnit = Props.Get("XAxisUnit")
	mNbMaxSamples = Props.Get("NbMaxSamples")
	mNbMaxCurves = Props.Get("NbMaxCurves")
	setNbMaxCurves(mNbMaxCurves)
	setNbMaxSamples(mNbMaxSamples)
	
	Graph.NbXIntervals = Props.Get("NbXIntervals")
	Graph.NbYIntervals = Props.Get("NbYIntervals")
	Graph.GraphColor = xui.PaintOrColorToColor(Props.Get("GraphColor"))
	Graph.GridFrameColor = xui.PaintOrColorToColor(Props.Get("GridFrameColor"))
	Graph.GridColor = xui.PaintOrColorToColor(Props.Get("GridColor"))
	Texts.TitleTextColor = xui.PaintOrColorToColor(Props.Get("TitleTextColor"))
	Texts.ScaleTextColor = xui.PaintOrColorToColor(Props.Get("ScaleTextColor"))
	Texts.TitleTextSize = Props.Get("TitleTextSize")
	Texts.CurveTextSize = Props.Get("CurveTextSize")
	Texts.ScaleTextSize = Props.Get("ScaleTextSize")
	Texts.AutomaticTextSizes = Props.Get("AutomaticTextSizes")
	mAutomaticYScales = Props.Get("AutomaticScale")
	Graph.ScaleXValues = Props.Get("ScaleXValues")
	Graph.ScaleYValues = Props.Get("ScaleYValues")
	Graph.ScaleOnZoomedPartOnly = Props.GetDefault("ScaleOnZoomedPartOnly", True)
	Graph.OuterFrame = Props.Get("OuterFrame")
	Graph.OuterFrameColor = xui.PaintOrColorToColor(Props.Get("OuterFrameColor"))
	mDisplayCurveUnit = Props.Get("DisplayCurveUnit")
	mDisplayCurveIndex = Props.Get("DisplayCurveIndex")
	mGraphWithMissingData = Props.GetDefault("GraphWithMissingData", False)
	mMissingDataValue = Props.GetDefault("MissingDataValue", 100000000)
	mUseCustomColors = Props.GetDefault("UseCustomColors", False)
	Private ScalesY(mNbMaxCurves) As ScaleYData
	CurveColor(0) = xui.Color_Red
	CurveWidth(0) = 1dip
	CurveColor(1) = xui.Color_Blue
	CurveWidth(1) = 1dip
	CurveColor(2) = xui.Color_Magenta
	CurveWidth(2) = 1dip
	CurveColor(3) = xui.Color_RGB(0, 153, 0)
	CurveWidth(3) = 1dip

	RectZoomCursor.Initialize(0, 0, 1dip, 1dip)
	RectCursor.Initialize(0, 0, 10dip, 10dip)
	RectSelected.Initialize(0, 0, 10dip, 10dip)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xcvsGraph.Resize(Width, Height)
	xpnlCursor.Width = Width
	xpnlCursor.Height = Height
	xcvsCursor.Resize(Width, Height)
	xpnlTwoCursors.Width = Width
	xpnlTwoCursors.Height = Height
	xcvsTwoCursors.Resize(Width, Height)
	xpnlZoomedArea.Height = Height
	xcvsZoomedArea.Resize(Width, Height)
	
	If FirstInit = False Then
		DrawGraph
	End If
End Sub

Private Sub xpnlCursor_Touch (Action As Int, X As Float, Y As Float)
	Private Index, CursColor As Int
	Private IndexDelta As Int
	
	If Action = 100 Then
		Return
	End If

	If mZoomMode = -1 And mCursorMode = -1 Then
		CursColor = StandardCursorColor
	Else
		CursColor = ZoomCursorColor
	End If
	IndexDelta = ScaleX.IEnd - ScaleX.IBegin
	
	If xui.SubExists(mCallBack, mEventName & "_Touch", 1) Then
		Private P As TouchParameters
		P.Action = Action
		P.X = X' - Graph.Left
		P.Y = Y' - Graph.Top
		P.XIndex = Max(0, (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + ScaleX.IBegin + 0.5)
		P.XIndex = Min(P.XIndex, ScaleX.NbSamples - 1)
		If xui.SubExists(mCallBack, mEventName & "_Touch", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_Touch", P)	'in screen coordonates
		End If
	End If
	
	Select Action
		Case xpnlCursor.TOUCH_ACTION_DOWN
			If mSynchronizeGraphs = True And mSelectedGraphShow = True Then
				SelectGraph(True)
				mGraphToSynchronize.SelectGraph(False)
			End If
			
			If X >= Graph.Left And X <= Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				If mCursorMode = 2 Then	'add cursor mode
					CursorActive = True
					Private TC As CursorsData
					Private xd As Int
					xd = 6dip
					TC = lstTwoCursors.Get(mCurrentCursor)
					TC.XIndex = Max(0, (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + ScaleX.IBegin + 0.5)
					TC.XIndex = Min(TC.XIndex, ScaleX.NbSamples - 1)
					TC.Rect.Initialize(x - xd - 1dip, Graph.Top - 1dip, x + xd + 1dip, Graph.Bottom + 1dip)	'xd
					mCursorMode = 0
					DrawTwoCursors
					If mSynchronizeGraphs = True Then
						TC = mGraphToSynchronize.lstTwoCursors.Get(mCurrentCursor)
						TC.XIndex = Max(0, (x - mGraphToSynchronize.Graph.Left) / mGraphToSynchronize.Graph.Width * (mGraphToSynchronize.ScaleX.IEnd - mGraphToSynchronize.ScaleX.IBegin) + mGraphToSynchronize.ScaleX.IBegin + 0.5)
						TC.XIndex = Min(TC.XIndex, mGraphToSynchronize.ScaleX.NbSamples - 1)
						TC.Rect.Initialize(x - xd - 1dip, mGraphToSynchronize.Graph.Top - 1dip, x + xd + 1dip, mGraphToSynchronize.Graph.Bottom + 1dip)	'xd
						mGraphToSynchronize.SetCursor(TC.XIndex, mCurrentCursor, TC.Color)
					End If
				Else 'all other modes
					CursorActive = True
					If lstTwoCursors.Size > 0 And ChekTwoCursor(X, Y) >= 0 Then	'if a cursor was found
						mCurrentCursor = ChekTwoCursor(X, Y)
						mCursorMode = 0
					Else 'no cursor found
						DrawStandardCursor(X, CursColor)
					End If
					If (mZoomMode > -1 Or mCursorMode > -1) And xui.IsB4J Then
						ZoomCursorActive = True
						#If B4J
						Private pnl As Pane
						pnl = xpnlCursor
						pnl.MouseCursor = fx.Cursors.HAND
						#End If
					End If
				End If
			Else If Zoomed = True And Y > Graph.Bottom Then	'zoomed management
				ZoomCursorActive = True
				If X < RectZoomCursor.Left Then
					ScaleX.IBegin = Max(0, ScaleX.IBegin - IndexDelta)
					ScaleX.IEnd = ScaleX.IBegin + IndexDelta
					DrawZoomCursor
					DrawGraph
					If xui.SubExists(mCallBack, mEventName & "_ZoomChanged", 2) Then
						CallSubDelayed3(mCallBack, mEventName & "_ZoomChanged", ScaleX.IBegin, ScaleX.IEnd)
					End If
				Else If X > RectZoomCursor.Right Then
					ScaleX.IEnd = Min(ScaleX.NbSamples - 1, ScaleX.IEnd + IndexDelta)
					ScaleX.IBegin = ScaleX.IEnd - IndexDelta
					DrawZoomCursor
					DrawGraph
					If xui.SubExists(mCallBack, mEventName & "_ZoomChanged", 2) Then
						CallSubDelayed3(mCallBack, mEventName & "_ZoomChanged", ScaleX.IBegin, ScaleX.IEnd)
					End If
				Else	'If X > RectZoomCursor.Left And X < RectZoomCursor.Right
					ZoomX = X
					IBegin = ScaleX.IBegin
					IEnd = ScaleX.IEnd
				End If
			End If
		Case xpnlCursor.TOUCH_ACTION_UP
			mCursorMode = -1
			
			Index = Max(0, (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + ScaleX.IBegin + 0.5)
			Index = Min(Index, ScaleX.NbSamples - 1)
			If mZoomMode = 0 Then
				mZoomMode = 1
				ZoomIBegin = Index
				xlblComments.Text = "Select right limit"
				RectCursor1.Initialize(X - 2dip, Graph.Top, X + 2dip, Graph.Bottom)
			Else If mZoomMode = 1 Then
				mZoomMode = -1
				ScaleX.IBegin = ZoomIBegin
				ScaleX.IEnd = Index
				Private diff As Int
				diff = Graph.NbXIntervals - ScaleX.IEnd + ScaleX.IBegin
				If diff > 0 Then
					ScaleX.IBegin = Max(0, ScaleX.IBegin - diff / 2)
					ScaleX.IEnd = ScaleX.IBegin + Graph.NbXIntervals
					If ScaleX.IEnd > ScaleX.NbSamples - 1 Then
						ScaleX.IEnd = ScaleX.NbSamples
						ScaleX.IBegin = ScaleX.IEnd - Graph.NbXIntervals
					End If
				End If
				Zoomed = True
				DrawZoomCursor
				DrawGraph
				xcvsCursor.ClearRect(RectTimeText)
				xcvsCursor.ClearRect(RectCursor1)
				xcvsCursor.ClearRect(RectCursor)
			Else
				ClearStandardCursor
			End If
			
'			xcvsCursor.ClearRect(RectTimeText)
'			xcvsCursor.ClearRect(RectValuesText)
			xcvsCursor.Invalidate
			
			If mZoomMode = -1 And mCursorMode = -1 Then
				#If B4J
				Private pnl As Pane
				pnl = xpnlCursor
				pnl.MouseCursor = fx.Cursors.DEFAULT
				#End If
				xlblComments.Visible = False
			End If
			CursorActive = False
			ZoomCursorActive = False
			
		Case xpnlCursor.TOUCH_ACTION_MOVE
			If X >= Graph.Left And X <= Graph.Right And Y > Graph.Top And Y < Graph.Bottom Then
				If mCursorMode = 0 Then
					Private TC0 As CursorsData
					TC0 = lstTwoCursors.Get(mCurrentCursor)
					TC0.XIndex = Max(0, (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + ScaleX.IBegin + 0.5)
					TC0.XIndex = Min(TC0.XIndex, ScaleX.NbSamples - 1)
					DrawTwoCursors
					If mSynchronizeGraphs = True Then
						Private TC1 As CursorsData
						TC1 = mGraphToSynchronize.lstTwoCursors.Get(mCurrentCursor)
						mGraphToSynchronize.SetCursor(TC0.XIndex, mCurrentCursor, TC1.Color)
					End If
					If xui.SubExists(mCallBack, mEventName & "_CursorPositionChanged", 2) Then
						CallSubDelayed3(mCallBack, mEventName & "_CursorPositionChanged", mCurrentCursor, TC.XIndex)
					End If
				Else If CursorActive = True Then
'					DrawItemValues(X)
					DrawStandardCursor(X, CursColor)
'					xcvsCursor.ClearRect(RectCursor)
'					xcvsCursor.DrawLine(X, Graph.Top, X, Graph.Bottom - 2dip, CursColor, 2dip)
'					RectCursor.Initialize(X - 2dip, Graph.Top, X + 2dip, Graph.Bottom)
'					xcvsCursor.Invalidate
				End If
			Else If Zoomed = True And CursorActive = False And Y > Graph.Bottom And Y < xpnlCursor.Height And X > RectZoomCursor.Left And X < RectZoomCursor.Right Then
				ZoomDelta = X - ZoomX
				If ZoomDelta < 0 Then
					ScaleX.IBegin = Max (0, IBegin + ZoomDelta / ZoomScale)
					ScaleX.IEnd = ScaleX.IBegin + IndexDelta
				Else
					ScaleX.IEnd = Min(ScaleX.NbSamples - 1, IEnd + ZoomDelta / ZoomScale)
					ScaleX.IBegin = ScaleX.IEnd - IndexDelta
				End If

				If xui.SubExists(mCallBack, mEventName & "_ZoomChanged", 2) Then
					CallSubDelayed3(mCallBack, mEventName & "_ZoomChanged", ScaleX.IBegin, ScaleX.IEnd)
				End If

				DrawZoomCursor
				DrawGraph
			End If
	End Select
End Sub

'Initializes different parameters for the graph
Private Sub InitGraph
	Private c0, c, nc As Int
	
	FirstInit = False
	
	If Texts.AutomaticTextSizes = True Then
		Private GraphSize As Int
		GraphSize = Min(xcvsGraph.TargetRect.Width, xcvsGraph.TargetRect.Height)
		GraphSize = GraphSize / xui.Scale
		
		Texts.TitleTextSize = (1 + (GraphSize - 250)/1000) * 16
		Texts.CurveTextSize = (1 + (GraphSize - 250)/1000) * 12
		Texts.ScaleTextSize = (1 + (GraphSize - 250)/1000) * 12
	End If

	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.LineFont = xui.CreateDefaultFont(Texts.CurveTextSize)
	Texts.ScaleFont = xui.CreateDefaultFont(Texts.ScaleTextSize)
	
	Texts.TitleTextHeight = MeasureTextHeight("Mg[∫", Texts.TitleFont)
	Texts.CurveTextHeight = MeasureTextHeight("Mg[∫", Texts.LineFont)
	Texts.ScaleTextHeight = MeasureTextHeight("Mg[∫", Texts.ScaleFont)

	If mBase.Width >= mBase.Height Then
		SingleCurveNames = False
	Else
		SingleCurveNames = True
	End If
	
	Graph.Top = Texts.CurveTextHeight * 0.3
	If SingleCurveNames = True Then
		If lstCurvesToDisplay.Size = 0 Then
			Graph.Top = Graph.Top + Texts.CurveTextHeight * 1.2
		Else
			Graph.Top = Graph.Top + lstCurvesToDisplay.Size * (Texts.CurveTextHeight * 1.2)
		End If
	Else
		Private n As Int
		If lstCurvesToDisplay.Size = 0 Then
			Graph.Top = Graph.Top + Texts.CurveTextHeight * 1.2
		Else
			n = (lstCurvesToDisplay.Size - 1) / 2 + 1
			Graph.Top = Graph.Top + n * (Texts.CurveTextHeight * 1.2)
		End If
	End If
	
	If Graph.Title <> "" Then
		Graph.Top = Graph.Top + 1.5 * Texts.TitleTextHeight
	End If
	
	Graph.XScaleTextOrientation = "HORIZONTAL"
	Select Graph.XScaleTextOrientation
		Case "HORIZONTAL"
			Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 1.5 * Texts.ScaleTextHeight
		Case "VERTICAL"
			Graph.Height = xcvsGraph.TargetRect.Height - Graph.Top - 0.6 * Texts.ScaleTextHeight - GetXScaleWidth
	End Select
	
	Graph.Height = Graph.Height - 1.7 * Texts.CurveTextHeight
	
	Graph.YInterval = Graph.Height / Graph.NbYIntervals
	Graph.Height =  Graph.YInterval * Graph.NbYIntervals
	Graph.Bottom = Graph.Top + Graph.Height
	Graph.Rect.Initialize(Graph.Left, Graph.Top, Graph.Right, Graph.Bottom)

	For nc = 0 To lstCurvesToDisplay.Size - 1
		c = lstCurvesToDisplay.Get(nc)
		If mAutomaticYScales = True Then
			CalcScaleAutoY(c)
		Else
			CalcScaleAutoY(c)
			CalcScaleManuY(c)
		End If
	Next
	
	If Graph.SameScaleCurveIndex > -1 Then
		SameYScales = Graph.SameScaleCurveIndex
	Else If lstCurvesToDisplay.Size = 1 Then
		SameYScales = lstCurvesToDisplay.Get(0)
	Else
		c0 = lstCurvesToDisplay.Get(0)
		SameYScales = c0
		For nc = 1 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			If ScalesY(c).MaxVal <> ScalesY(c0).MaxVal Or ScalesY(c).MinVal <> ScalesY(c0).MinVal Then
				SameYScales = -1
				Exit
			End If
		Next
	End If
	
	Graph.Left = MeasureTextWidth("-2.5E-10", Texts.ScaleFont) + 0.5 * Texts.ScaleTextHeight
	
	If SameYScales >-1 Then
		Graph.Width = xcvsGraph.TargetRect.Width - Graph.Left - Texts.ScaleTextHeight
	Else
		Graph.Width = xcvsGraph.TargetRect.Width - 2 * Graph.Left
	End If
	Graph.XInterval = Graph.Width / Graph.NbXIntervals
	Graph.Width = Graph.XInterval * Graph.NbXIntervals
	Graph.Right = Graph.Left + Graph.Width
	
	CalcScaleAutoX

	If SingleCurveNames = True Or lstCurvesToDisplay.Size = 1 Then
		Private WidthL, WidthR As Int
		Private txt As String
		
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			txt = ""
			If mDisplayCurveIndex = True Then
				txt = c & " : "
			End If
			If CurveYUnit(c) <> "" And mDisplayCurveUnit = True Then
				txt = txt & CurveYName(c) & "[" & CurveYUnit(c) & "]"
			Else
				txt = txt & CurveYName(c)
			End If
			WidthL = Max(WidthL, MeasureTextWidth(txt, Texts.LineFont) + 15dip)
		Next
		RectValuesText.Initialize(Graph.Left + WidthL, Graph.Top - lstCurvesToDisplay.Size * Texts.CurveTextHeight - 2dip, Graph.Right, Graph.Top)
	Else
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			txt = ""
			If mDisplayCurveIndex = True Then
				txt = c & " : "
			End If
			If CurveYUnit(c) <> "" And mDisplayCurveUnit = True Then
				txt = txt & CurveYName(c) & "[" & CurveYUnit(c) & "]"
			Else
				txt = txt & CurveYName(c)
			End If
			If nc Mod 2 = 0 Then
				WidthL = Max(WidthL, MeasureTextWidth(txt, Texts.LineFont) + 15dip)
			Else
				WidthR = Max(WidthR, MeasureTextWidth(txt, Texts.LineFont) + 15dip)
			End If
		Next
		RectValuesText.Initialize(Graph.Left + WidthL, Graph.Top - lstCurvesToDisplay.Size * Texts.CurveTextHeight - 2dip, Graph.Right - WidthR, Graph.Top)
	End If
	
	If Graph.XAxisName <> "" Then
		Private Left, Bottom As Int
		Private txt As String
		txt = Graph.XAxisName & " [" & Graph.XAxisUnit & "]"
		Left = Graph.Left + MeasureTextWidth(txt, Texts.LineFont) + 5dip
		Bottom = Graph.Bottom + 2.6 * Texts.CurveTextHeight + 1dip
		RectTimeText.Initialize(Left, Bottom - 1.5 * Texts.CurveTextHeight + 2dip, xcvsCursor.TargetRect.Right, Bottom)
	End If

	RectZoomCursorArea.Initialize(Graph.Left, xpnlCursor.Height - 0.8 * Texts.ScaleTextHeight, Graph.Right, xpnlCursor.Height)
	RectZoomedArea.Initialize(0, 0, 10dip, 10dip)
	RectSelectedFull.Initialize(xpnlCursor.Width - 3dip, 0, xpnlCursor.Width, xpnlCursor.Height)
	RectSelected.Initialize(xpnlCursor.Width - 3dip, Graph.Top, xpnlCursor.Width, Graph.Bottom)
	If mSynchronizeGraphs = True Then
		xcvsCursor.ClearRect(RectSelectedFull)
		If mSynchGraphSelected = True Then
			SelectGraph(True)
		End If
	End If
End Sub

'Draws a graph
Public Sub DrawGraph
	If ScaleX.NbSamples = 0 Then
		Log("Number of samples = 0" & " You must set the NbSamples value")
		Return
	End If	
	
	InitGraph
	ReDrawGraph
End Sub

Private Sub ReDrawGraph
	DrawGrid
	DrawXScale
	DrawYScales
	DrawCurvesInternal
	DrawTwoCursors
End Sub

'Draws the grid of a chart with the scales, title and axis names
Private Sub DrawGrid
	Private c, i, j, nc, x, y, dy, col As Int
	Private txt As String
	
'	xcvsCursor.ClearRect(xcvsCursor.TargetRect)
	xcvsTwoCursors.ClearRect(xcvsTwoCursors.TargetRect)
	RectTwoCursorsTexts.Initialize(Graph.Left, Graph.Top, Graph.Right, Graph.Top + 60dip)

	xcvsZoomedArea.ClearRect(xcvsZoomedArea.TargetRect)
	
	xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.GraphColor, True, 1dip)
	If Graph.OuterFrame = True Then
		xcvsGraph.DrawRect(xcvsGraph.TargetRect, Graph.OuterFrameColor, False, 3dip)
	End If
	
	For c = 0 To Graph.NbYIntervals
		y = Graph.Top + c * Graph.YInterval
		xcvsGraph.DrawLine(Graph.Left - 4dip, y, Graph.Left, y, Graph.GridFrameColor, 2dip)
		xcvsGraph.DrawLine(Graph.Left, y, Graph.Right, y, Graph.GridColor, 1dip)
'		If lstCurvesToDisplay.Size > 1 And Graph.SameScaleCurveIndex < 0 Then
		If SameYScales < 0 Then
			xcvsGraph.DrawLine(Graph.Right, y, Graph.Right + 4dip, y, Graph.GridFrameColor, 2dip)
		End If
	Next
	
	For i = 0 To Graph.NbCurrentXIntervals
		x = Graph.Left + Graph.XOffset + i * Graph.XInterval
		xcvsGraph.DrawLine(x, Graph.Bottom, x, Graph.Bottom + 4dip, Graph.GridFrameColor, 2dip)
		xcvsGraph.DrawLine(x, Graph.Top, x, Graph.Bottom, Graph.GridColor, 1dip)
	Next
	
	If Graph.Title <> "" Then
		xcvsGraph.DrawText(Graph.Title, xpnlCursor.Width / 2, 1.4 * Texts.TitleTextHeight, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	End If
	
	dy = 0.35 * Texts.CurveTextHeight
	
	'display curve names
	For nc = 0 To lstCurvesToDisplay.Size - 1
		c = lstCurvesToDisplay.Get(nc)
		If mUseCustomColors = False Then
			col = CurveColor(nc)
		Else
			col = CurveCustomColor(c)
		End If
		txt = ""
		If mDisplayCurveIndex = True Then
			txt = c & " : "
		End If
		If CurveYUnit(c) <> "" And mDisplayCurveUnit Then
			txt = txt & CurveYName(c) & " [" & CurveYUnit(c) & "]"
		Else
			txt = txt & CurveYName(c)
		End If
		If SingleCurveNames = True Then
			y = Graph.Top - dy - nc * Texts.CurveTextHeight
			xcvsGraph.DrawText(txt, Graph.Left, y, Texts.LineFont, col, "LEFT")
		Else
			j = nc / 2
			y = Graph.Top - dy - j * Texts.CurveTextHeight
			If nc Mod 2 = 0 Then
				xcvsGraph.DrawText(txt, Graph.Left, y, Texts.LineFont, col, "LEFT")
			Else
				xcvsGraph.DrawText(txt, Graph.Right, y, Texts.LineFont, col, "RIGHT")
			End If
		End If
	Next
	
	xcvsGraph.DrawRect(Graph.Rect, Graph.GridFrameColor, False, 2dip)
	
	If Graph.XAxisName <> "" Then
		txt = Graph.XAxisName
		If Graph.XAxisUnit <> "" Then
			txt = txt & " [" & Graph.XAxisUnit & "]"
		End If
		xcvsGraph.DrawText(txt, Graph.Left, Graph.Bottom + 2.6 * Texts.CurveTextHeight, Texts.LineFont, Texts.ScaleTextColor, "LEFT")
	End If
End Sub

'Draws the X scale
Private Sub DrawXScale
	Private i, x, x0, y, dy, st, w As Int
	Private txt As String

	dy = 1.4 * Texts.ScaleTextHeight
	
	For i = 0 To Graph.NbCurrentXIntervals
		txt = NumberFormat3(ScaleX.MinVal + i * ScaleX.Interval, 6)
		w = Max(w, MeasureTextWidth(txt, Texts.LineFont))
	Next
		
	st = 1
	If w > 0.7 * Graph.XInterval Then
		st = 2
	End If

	y = Graph.Bottom + dy
	x0 = Graph.Left + ScaleX.Offset * ScaleX.Scale
	For i = 0 To Graph.NbCurrentXIntervals Step st
		x = x0 + i * Graph.XInterval
		Private txt As String
		txt = NumberFormat3(ScaleX.MinVal + i * ScaleX.Interval, 6)
		xcvsGraph.DrawText(txt, x, y, Texts.ScaleFont, xui.Color_Black, "CENTER")
	Next
	xcvsGraph.Invalidate
End Sub

'Draws the Y scales
Private Sub DrawYScales
	Private c, i, n, nc, y, dx, dy, st, col As Int
	Private txt As String
	
	dx = 0.5 * Texts.ScaleTextHeight
	dy = 0.4 * Texts.ScaleTextHeight

	st = 1
	If 1.7 * Texts.ScaleTextHeight > Graph.YInterval And lstCurvesToDisplay.Size > 2 Then
		st = 2
	End If
	
	If SameYScales > -1 Then
		For i = 0 To Graph.NbYIntervals Step st
			y = Graph.Top + i * Graph.YInterval + dy
			Private txt As String
			txt = NumberFormat3(ScalesY(SameYScales).MaxVal - i * ScalesY(SameYScales).Interval, 6)
			xcvsGraph.DrawText(txt, Graph.Left - dx, y, Texts.ScaleFont, Texts.ScaleTextColor, "RIGHT")
		Next
	Else
		n = 0
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			If mUseCustomColors = False Then
				col = CurveColor(nc)
			Else
				col = CurveCustomColor(c)
			End If
			If CurveDrawYScale(c) = True Then
				For i = 0 To Graph.NbYIntervals Step st
					y = Graph.Top + i * Graph.YInterval + dy
					If n > 1 Then
						y = y - Texts.ScaleTextHeight
					End If
					Private txt As String
					txt = NumberFormat3(ScalesY(c).MaxVal - i * ScalesY(c).Interval, 6)
					
					If n < 4 Then	'draws max 4 y scale values
						If n Mod 2 = 0 Then
							xcvsGraph.DrawText(txt, Graph.Left - dx, y, Texts.ScaleFont, col, "RIGHT")
						Else
							xcvsGraph.DrawText(txt, Graph.Right + dx, y, Texts.ScaleFont, col, "LEFT")
						End If
					End If
				Next
				n = n + 1
			End If
		Next
	End If
	xcvsGraph.Invalidate
End Sub

'Draws the curve with the given index
'Example code: <code>xGraph1.DrawCurve(2)</code>
Public Sub DrawCurve(Index As Int)
	lstCurvesToDisplay.Initialize2(Array As Int(Index))
	DrawGraph
End Sub

'Draws the curves with the given indexes
'Example code: <code>xGraph1.DrawCurves(Array As Int(0,1,2,3))</code>
Public Sub DrawCurves(Indexes() As Int)
	lstCurvesToDisplay.Initialize2(Indexes)
	DrawGraph
End Sub

'Draws a specific horizontal line for the given curve with the curve color
'Possible LineType:  "MAX", "MIN", "MEAN", "RMS"
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Private Sub DrawCurveLine(LineType As String, CurveIndex As Int, Width As Int, ZoomedPartOnly As Boolean, DrawText As Boolean, DrawValue As Boolean)
	Private col, nc As Int
	Private x0, y0, x1, y1 As Int
	Private Value, ValMinMax() As Double
	
	x0 = Graph.Left
	x1 = Graph.Right
	
	Select LineType
		Case "MEAN"
			Value = CalcMeanValue(CurveIndex, False)
		Case "MIN"
			ValMinMax = GetPointsMinMaxValues(CurveIndex, ZoomedPartOnly)
			Value = ValMinMax(0)
		Case "MAX"
			ValMinMax = GetPointsMinMaxValues(CurveIndex, ZoomedPartOnly)
			Value = ValMinMax(1)
		Case "RMS"
			Value = CalcRMSValue(CurveIndex, False)
		Case Else
			Log(LineType & " Wrong horizontal line type ?")
			Return
	End Select
	y0 = Graph.Bottom - (Value - ScalesY(CurveIndex).MinVal) * ScalesY(CurveIndex).Scale
	y1 = y0
	
	If mUseCustomColors = False Then
		nc = lstCurvesToDisplay.IndexOf(CurveIndex)
		If nc < 0 Then
			Return
		End If
		col = CurveColor(nc)
	Else
		col = CurveCustomColor(CurveIndex)
	End If

	xcvsGraph.DrawLine(x0, y0, x1, y1, col, Width)
End Sub

'Draws the selected Curves, internal routine
Private Sub DrawCurvesInternal
	Private c, nc, s, col, w As Int
	Private x0, y0, x1, y1 As Int
	Private pthCurves As B4XPath
	
	If lstCurvesToDisplay.Size = 0 Then
		Return
	End If
	
	pthCurves.Initialize(Graph.Left, Graph.Top)
	pthCurves.LineTo(Graph.Right, Graph.Top)
	pthCurves.LineTo(Graph.Right, Graph.Bottom)
	pthCurves.LineTo(Graph.Left, Graph.Bottom)
	pthCurves.LineTo(Graph.Left, Graph.Top)
	
	xcvsGraph.ClipPath(pthCurves)

	If mGraphWithMissingData = False Then
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			If mUseCustomColors = False Then
				col = CurveColor(nc)
				w = CurveWidth(nc)
			Else
				col = CurveCustomColor(c)
				w = CurveCustomWidth(c)
			End If
			x0 = Graph.Left
			y0 = Graph.Bottom - (CurveY(c, ScaleX.IBegin) - ScalesY(c).MinVal) * ScalesY(c).Scale
			For s = ScaleX.IBegin + 1 To ScaleX.IEnd
				x1 = Graph.Left + (CurveX(s) - CurveX(ScaleX.IBegin)) * ScaleX.Scale
				y1 = Graph.Bottom - (CurveY(c, s) - ScalesY(c).MinVal) * ScalesY(c).Scale
				xcvsGraph.DrawLine(x0, y0, x1, y1, col, w)
				x0 = x1
				y0 = y1
			Next
		Next
	Else
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			If mUseCustomColors = False Then
				col = CurveColor(nc)
				w = CurveWidth(nc)
			Else
				col = CurveCustomColor(c)
				w = CurveCustomWidth(c)
			End If
			x0 = Graph.Left
			y0 = Graph.Bottom - (CurveY(c, ScaleX.IBegin) - ScalesY(c).MinVal) * ScalesY(c).Scale
			For s = ScaleX.IBegin + 1 To ScaleX.IEnd
				x1 = Graph.Left + (CurveX(s) - CurveX(ScaleX.IBegin)) * ScaleX.Scale
				y1 = Graph.Bottom - (CurveY(c, s) - ScalesY(c).MinVal) * ScalesY(c).Scale
				If CurveY(c, s - 1) < mMissingDataValue And CurveY(c, s) < mMissingDataValue Then
					xcvsGraph.DrawLine(x0, y0, x1, y1,col, w)
				End If
				x0 = x1
				y0 = y1
			Next
		Next
	End If
	
	xcvsGraph.Invalidate
	xcvsGraph.RemoveClip
End Sub

Private Sub DrawStandardCursor(X As Int, Color As Int)
	xcvsCursor.ClearRect(RectCursor)
'	xcvsCursor.DrawLine(X, Graph.Top, X, Graph.Bottom - 2dip, Color, 2dip)
	xcvsCursor.DrawLine(X, Graph.Top, X, Graph.Bottom - 2dip, Color, 1)
	RectCursor.Initialize(X - 2dip, Graph.Top, X + 2dip, Graph.Bottom)
	DrawItemValues(x)
	
	If mSynchronizeGraphs = True And CursorActive And Color <> ZoomCursorColor Then
		Private Index, x1 As Int
		Index = ScaleX.IBegin + (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + 0.5
		x1 = mGraphToSynchronize.Graph.Left + (CurveX(Index) - CurveX(mGraphToSynchronize.ScaleX.IBegin)) * mGraphToSynchronize.ScaleX.Scale
		If x1 >= mGraphToSynchronize.Graph.Left And x1 <= mGraphToSynchronize.Graph.Right Then
			mGraphToSynchronize.DrawStandardCursor(x1, Color)
		Else
			mGraphToSynchronize.DrawStandardCursor(x1, mGraphToSynchronize.Graph.GraphColor)
		End If
	End If
End Sub

Private Sub ClearStandardCursor
	xcvsCursor.ClearRect(RectCursor)
	xcvsCursor.ClearRect(RectTimeText)
	xcvsCursor.ClearRect(RectValuesText)
	
	If mSynchronizeGraphs And CursorActive Then
		mGraphToSynchronize.ClearStandardCursor
	End If
End Sub

'Draws the values at the cursor position
Private Sub DrawItemValues(x As Int)
	Private Index, c, c2, nc, y, dy, col As Int
	Private txt As String
	
	xcvsCursor.ClearRect(RectTimeText)
	xcvsCursor.ClearRect(RectValuesText)
	
	y = RectTimeText.Bottom - 1dip
	Index = ScaleX.IBegin + (x - Graph.Left) / Graph.Width * (ScaleX.IEnd - ScaleX.IBegin) + 0.5
	xcvsCursor.DrawText(" = " & NumberFormat3(CurveX(Index), 6), RectTimeText.Left + 1dip, y, Texts.LineFont, Texts.ScaleTextColor, "LEFT")
	xcvsCursor.DrawText("Index = " & Index, Graph.Right, y, Texts.LineFont, Texts.ScaleTextColor, "RIGHT")
	
	If mZoomMode = -1 Then
		dy = 0.3 * Texts.CurveTextHeight
		If SingleCurveNames = True Or lstCurves.Size = 1 Then
			For nc = 0 To lstCurvesToDisplay.Size - 1
				c = lstCurvesToDisplay.Get(nc)
				y = Graph.Top - dy - c * Texts.CurveTextHeight
				If mGraphWithMissingData = True And CurveY(c, Index) >= mMissingDataValue Then
					txt = "NaN"
				Else
					txt = NumberFormat3(CurveY(c, Index), 6)
				End If
				xcvsCursor.DrawText(txt, RectValuesText.Left + 1dip, y, Texts.LineFont, col, "LEFT")
			Next
		Else
			For nc = 0 To lstCurvesToDisplay.Size - 1
				c = lstCurvesToDisplay.Get(nc)
				c2 = nc / 2
				If mUseCustomColors = False Then
					col = CurveColor(nc)
				Else
					col = CurveCustomColor(c)
				End If
				If mGraphWithMissingData = True And CurveY(c, Index) >= mMissingDataValue Then
					txt = "NaN"
				Else
					txt = NumberFormat3(CurveY(c, Index), 6)
				End If
				If nc Mod 2 = 0 Then
					y = Graph.Top - dy - c2 * Texts.CurveTextHeight
					xcvsCursor.DrawText(txt, RectValuesText.Left + 1dip, y, Texts.LineFont, col, "LEFT")
				Else
					y = Graph.Top - dy - c2 * Texts.CurveTextHeight
					xcvsCursor.DrawText(txt, RectValuesText.Right, y, Texts.LineFont, col, "RIGHT")
				End If
			Next
		End If
	End If
	xcvsCursor.Invalidate
End Sub

'Draws the zoom cursor
Private Sub DrawZoomCursor
	ZoomScale = xpnlCursor.Width / ScaleX.NbSamples
	xcvsCursor.ClearRect(RectZoomCursor)
	If Zoomed = True Then
		RectZoomCursor.Initialize(ScaleX.IBegin * ZoomScale, xpnlCursor.Height - 0.8 * Texts.ScaleTextHeight, ScaleX.IEnd * ZoomScale, xpnlCursor.Height)
		xcvsCursor.DrawRect(RectZoomCursor, xui.Color_ARGB(180, 180, 180, 180), True, 1)
	End If
	xcvsCursor.Invalidate
	
	If mSynchronizeGraphs = True And ZoomCursorActive Then
		If mSynchronizeZoom = True Then
			mGraphToSynchronize.SetZoomIndexes(ScaleX.IBegin, ScaleX.IEnd)
		Else
			mGraphToSynchronize.DrawSynchZoomedArea
		End If
	End If
End Sub

'Draws the zoom cursor of an unzoomed graph according to the position of the zoom of the other graph
Private Sub DrawSynchZoomedArea
	If Zoomed = False Then
		Private Color As Int
		Color = GetContrastColor(Graph.GraphColor)
		Color = GetSemiTransparentColor(96, Color)
		xcvsZoomedArea.ClearRect(xcvsZoomedArea.TargetRect)
		ZoomScale = Graph.Width / ScaleX.NbSamples
'		xcvsZoomArea.DrawRect(RectZoomCursorArea, xui.Color_RGB(220, 220, 220), True, 1)
'		RectZoomedArea.Initialize(Graph.Left + mGraphToSynchronize.ScaleX.IBegin * ZoomScale, xpnlCursor.Height - 0.8 * Texts.ScaleTextHeight, Graph.Left + mGraphToSynchronize.ScaleX.IEnd * ZoomScale, xpnlCursor.Height)
		RectZoomedArea.Initialize(Graph.Left + mGraphToSynchronize.ScaleX.IBegin * ZoomScale, Graph.Top, Graph.Left + mGraphToSynchronize.ScaleX.IEnd * ZoomScale, Graph.Bottom)
		xcvsZoomedArea.DrawRect(RectZoomedArea, xui.Color_ARGB(96, 220, 220, 220), True, 1)
		xcvsZoomedArea.Invalidate
	End If
End Sub

'Draws the two cursors
Private Sub DrawTwoCursors
	Private i, c, nc, x, x1, xt, yt, col As Int
	Private Txt As String
	Private TxtWidth, TxtWidth_2, TxtHeight As Int
	Private RectTxt As B4XRect
	Private TxtColor As Int
	
	xcvsTwoCursors.ClearRect(xcvsTwoCursors.TargetRect)
	
	'Draws the cursors
	For i = 0 To lstTwoCursors.Size - 1
		Private TC As CursorsData
		TC = lstTwoCursors.Get(i)
		If TC.XIndex >= ScaleX.IBegin And TC.XIndex <= ScaleX.IEnd Then
			xcvsTwoCursors.ClearRect(TC.Rect)
			x = Graph.Left + (TC.XIndex - ScaleX.IBegin) / (ScaleX.IEnd - ScaleX.IBegin) * Graph.Width
			xcvsTwoCursors.DrawLine(x, Graph.Top, x, Graph.Bottom, TC.Color, 2dip)
			Private xPath As B4XPath
			#If B4J
			Private xd = Texts.ScaleTextSize / 2.5 As Int
			#Else
			Private xd = Texts.ScaleTextSize / 1.5 As Int
			#End If
			xPath.Initialize(x, Graph.Top + 2 * xd)
			xPath.LineTo(x - xd, Graph.Top + xd)
			xPath.LineTo(x - xd, Graph.Top)
			xPath.LineTo(x + xd, Graph.Top)
			xPath.LineTo(x + xd, Graph.Top + xd)
			xcvsTwoCursors.DrawPath(xPath, TC.Color, True, 1dip)
			xPath.Initialize(x, Graph.Bottom - 2 * xd)
			xPath.LineTo(x - xd, Graph.Bottom - xd)
			xPath.LineTo(x - xd, Graph.Bottom)
			xPath.LineTo(x + xd, Graph.Bottom)
			xPath.LineTo(x + xd, Graph.Bottom - xd)
			xcvsTwoCursors.DrawPath(xPath, TC.Color, True, 1dip)
			TC.Rect.Initialize(x - xd - 1dip, Graph.Top - 1dip, x + xd + 1dip, Graph.Bottom + 1dip)
		End If
	Next
	
	'Draws the cursor values
	If mDrawCursorValues = True Then
		For i = 0 To lstTwoCursors.Size - 1
			TC = lstTwoCursors.Get(i)
			If TC.XIndex >= ScaleX.IBegin And TC.XIndex <= ScaleX.IEnd Then
				x = Graph.Left + (TC.XIndex - ScaleX.IBegin) / (ScaleX.IEnd - ScaleX.IBegin) * Graph.Width
'				Txt = "  Index = " & TC.XIndex & "  "
				Txt = "  " & TC.XIndex & " : " & NumberFormat3(CurveX(TC.XIndex), 6) & "  "
				TxtWidth = MeasureTextWidth(Txt, Texts.ScaleFont)
				For c = 0 To lstCurvesToDisplay.Size - 1
					Txt = " " & NumberFormat3(CurveY(lstCurvesToDisplay.Get(c), TC.XIndex), 6) & " "
					TxtWidth = Max(TxtWidth, MeasureTextWidth(Txt, Texts.ScaleFont))
				Next
				TxtWidth_2 = TxtWidth / 2
				TxtHeight = Texts.ScaleTextHeight * (lstCurvesToDisplay.Size + 1) + 0.4 * Texts.ScaleTextHeight
				TxtColor =  xui.Color_White
'				TxtColor = xui.Color_ARGB(200, 255, 255, 255)
				xt = Min(x, Graph.Right - TxtWidth_2)
				xt = Max(xt, Graph.Left + TxtWidth_2)
				If i = 1 And Abs(xt - x1) < TxtWidth Then
					yt = Graph.Top + 2 * xd  + TxtHeight + 3dip
				Else
					yt = Graph.Top + 2 * xd
					x1 = xt
				End If
				RectTxt.Initialize(xt - TxtWidth_2, yt, xt + TxtWidth_2, yt + TxtHeight)
				xcvsTwoCursors.DrawRect(RectTxt,TxtColor, True, 1dip)
'				Txt = "  Index = " & TC.XIndex & "  "
				Txt = TC.XIndex & " : " & NumberFormat3(CurveX(TC.XIndex), 6)
				xcvsTwoCursors.DrawText(Txt, xt, yt + Texts.ScaleTextHeight, Texts.ScaleFont, TC.Color, "CENTER")
				yt = yt + Texts.ScaleTextHeight
				For nc = 0 To lstCurvesToDisplay.Size - 1
					c = lstCurvesToDisplay.Get(nc)
					If mUseCustomColors = False Then
						col = CurveColor(nc)
					Else
						col = CurveCustomColor(c)
					End If
					If mGraphWithMissingData = True And CurveY(lstCurvesToDisplay.Get(nc), TC.XIndex) >= mMissingDataValue Then
						Txt = "NaN"
					Else
						Txt = NumberFormat3(CurveY(lstCurvesToDisplay.Get(nc), TC.XIndex), 6)
					End If
					yt = yt + Texts.ScaleTextHeight
					xcvsTwoCursors.DrawText(Txt, xt, yt, Texts.ScaleFont, col, "CENTER")
				Next
			End If
		Next
	End If
	xcvsTwoCursors.Invalidate
End Sub

'Calculates manual Y scales
Private Sub CalcScaleManuY(Index As Int)
	ScalesY(Index).MaxVal = ScalesY(Index).MaxManu
	ScalesY(Index).MinVal = ScalesY(Index).MinManu
	ScalesY(Index).Scale = Graph.Height / (ScalesY(Index).MaxVal - ScalesY(Index).MinVal)
	ScalesY(Index).IntervalManu = (ScalesY(Index).MaxVal - ScalesY(Index).MinVal) / Graph.NbYIntervals
	ScalesY(Index).Interval = ScalesY(Index).IntervalManu
	ScalesY(Index).Exp = Floor(Logarithm((ScalesY(Index).MaxVal - ScalesY(Index).MinVal) / Graph.NbYIntervals, 10))
End Sub

'Calculates automatic X scales with 1, 2, 2.5, 5 standardized scales
Private Sub CalcScaleAutoX
	Private ScaleLog, ScaleMant, ScaleDelta, ValDiff As Double
	Private ValMinMax(2) As Double
	Private ScaleVals() As String
	
	ValMinMax(0) = CurveX(ScaleX.IBegin)
	ValMinMax(1) = CurveX(ScaleX.IEnd)

	'check if min = max then unit scale
	If ValMinMax(0) = ValMinMax(1) Then
		ScaleX.IntervalAuto = 1
		ScaleX.MinAuto = Floor(ValMinMax(0)) - ScaleX.IntervalAuto * Graph.NbXIntervals / 2
		ScaleX.MaxAuto = ScaleX.MinAuto + ScaleX.IntervalAuto * Graph.NbXIntervals
		ScaleX.MinVal = ScaleX.MinAuto
		ScaleX.MaxVal = ScaleX.MaxAuto
		ScaleX.Interval = ScaleX.IntervalAuto
		ScaleX.Scale = Graph.Width / (ScaleX.MaxVal - ScaleX.MinVal)
	End If
	
	' logarithm variables
	ScaleVals = Regex.Split("!", Graph.ScaleXValues)
	Private Vals(ScaleVals.Length + 1), Logs(ScaleVals.Length + 1) As Double
	For i = 0 To ScaleVals.Length - 1
		Vals(i) = ScaleVals(i)
		Logs(i) = Logarithm(Vals(i), 10) + 0.00000000000001
	Next
	Vals(ScaleVals.Length) = Vals(1) * 10
	Logs(ScaleVals.Length) = Logarithm(Vals(ScaleVals.Length), 10) + 0.00000000000001
	
	ValDiff = ValMinMax(1) - ValMinMax(0)
	ScaleDelta = ValDiff / Graph.NbXIntervals
	
	ScaleLog = Logarithm(ScaleDelta, 10)
	ScaleX.Exp = Floor(ScaleLog)
	If ValDiff >= 1 Then
		ScaleMant = ScaleLog - ScaleX.Exp
	Else
		ScaleMant = Abs(ScaleX.Exp) + ScaleLog
	End If
	
	' calculate the scale interval
	If ScaleMant <= Logs(0) Then
		ScaleMant = 0
	Else
		For i = 0 To Vals.Length - 2
			If ScaleMant > Logs(i) And ScaleMant <= Logs(i + 1) Then
				ScaleMant = Logarithm(Vals(i + 1), 10)
				Exit
			End If
		Next
	End If
	ScaleX.IntervalAuto = Power(10, ScaleX.Exp + ScaleMant)
	
	' check if the scale interval is OK
	ScaleX.MinAuto = Ceil(ValMinMax(0) / ScaleX.IntervalAuto - 0.0000000000001) * ScaleX.IntervalAuto
	ScaleX.Offset = ScaleX.MinAuto - ValMinMax(0)
	ScaleX.Extend = ValMinMax(1) - Floor(ValMinMax(1) / ScaleX.IntervalAuto + 0.0000000000001) * ScaleX.IntervalAuto

	Graph.NbCurrentXIntervals = (ValMinMax(1) - ValMinMax(0) - ScaleX.Offset - ScaleX.Extend + 0.0000000000001) / ScaleX.IntervalAuto

	' calculate the scale max value
	ScaleX.MaxAuto = ScaleX.MinAuto + ScaleX.IntervalAuto * Graph.NbCurrentXIntervals
	ScaleX.Scale = Graph.XInterval / ScaleX.IntervalAuto
	
	'calculate grid width depending on the number of intervals
	
	Graph.Width = (ScaleX.Offset + ScaleX.Extend) * ScaleX.Scale + Graph.XInterval * Graph.NbCurrentXIntervals
	Graph.Right = Graph.Left + Graph.Width
	Graph.Rect.Initialize(Graph.Left, Graph.Top, Graph.Right, Graph.Bottom)
	
	ScaleX.MinVal = ScaleX.MinAuto
	ScaleX.MaxVal = ScaleX.MaxAuto
	ScaleX.Interval = ScaleX.IntervalAuto
	Graph.XOffset = ScaleX.Offset * ScaleX.Scale
	
	If ScaleX.MinManu= 0 And ScaleX.MaxManu= 0 Then
		ScaleX.MinManu = ScaleX.MinAuto
		ScaleX.MaxManu = ScaleX.MaxAuto
	End If
End Sub

'Calculates automatic Y scales with 1, 2, 2.5, 5 standardized scales
Private Sub CalcScaleAutoY(Index As Int)
	Private i As Int
	Private ScaleLog, ScaleMant, ScaleDelta, ValDiff As Double
	Private nbMin, NbUsedIntervals, NbUsedIntervalsTop, NbUsedIntervalsBottom, NbIntervalsToMove As Int
	Private ValMinMax(2) As Double
	Private ScaleVals() As String
	
	ValMinMax = GetPointsMinMaxValues(Index, Graph.ScaleOnZoomedPartOnly)
'	If ScalesY(Index).YZeroAxis = True And ValMinMax(0) >= 0 And ValMinMax(1) > 0 Then
'		ValMinMax(0) = 0
'	End If
'	If ScalesY(Index).YZeroAxis = True And ValMinMax(0) < 0 And ValMinMax(1) <= 0 Then
'		ValMinMax(1) = 0
'	End If
	
	'check if min = max then unit scale
	If ValMinMax(0) = ValMinMax(1) Then
		If ValMinMax(0) > 0 Then
			ValMinMax(0) = 0
		Else If ValMinMax(0) < 0 Then
			ValMinMax(1) = 0
		Else
			ScalesY(Index).IntervalAuto = 1
			ScalesY(Index).MinAuto = Floor(ValMinMax(0)) - ScalesY(Index).IntervalAuto * Graph.NbYIntervals / 2
			ScalesY(Index).MaxAuto = ScalesY(Index).MinAuto + ScalesY(Index).IntervalAuto * Graph.NbYIntervals
			ScalesY(Index).MinVal = ScalesY(Index).MinAuto
			ScalesY(Index).MaxVal = ScalesY(Index).MaxAuto
			ScalesY(Index).Interval = ScalesY(Index).IntervalAuto
			ScalesY(Index).Scale = Graph.Height / (ScalesY(Index).MaxVal - ScalesY(Index).MinVal)
		End If
	End If
	
	' logarithm variables
	ScaleVals = Regex.Split("!", Graph.ScaleYValues)
	Private Vals(ScaleVals.Length), Logs(ScaleVals.Length) As Double
	For i = 0 To ScaleVals.Length - 1
		Vals(i) = ScaleVals(i)
		Logs(i) = Logarithm(Vals(i), 10) + 0.00000000000001
	Next
	
	ValDiff = ValMinMax(1) - ValMinMax(0)
	ScaleDelta = ValDiff / Graph.NbYIntervals
	
	ScaleLog = Logarithm(ScaleDelta, 10)
	ScalesY(Index).Exp = Floor(ScaleLog)
	If ValDiff >= 1 Then
		ScaleMant = ScaleLog - ScalesY(Index).Exp
	Else
		ScaleMant = Abs(ScalesY(Index).Exp) + ScaleLog
	End If
	
	' calculate the scale interval
	If ScaleMant <= Logs(0) Then
		ScaleMant = 0
	Else
		For i = 0 To Vals.Length - 2
			If ScaleMant > Logs(i) And ScaleMant <= Logs(i + 1) Then
				ScaleMant = Logarithm(Vals(i + 1), 10)
				Exit
			End If
		Next
	End If
	ScalesY(Index).IntervalAuto = Power(10, ScalesY(Index).Exp + ScaleMant)
	
	' check if the scale interval is OK
	NbUsedIntervalsTop = Ceil(ValMinMax(1) / ScalesY(Index).IntervalAuto - 0.00000000000001)
'	NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / ScalesY(Index).IntervalAuto - 0.00000000000001)
	NbUsedIntervalsBottom = Floor(Abs(ValMinMax(0)) / ScalesY(Index).IntervalAuto - 0.00000000000001)
	' check if there are more necessary intervals than available
'	If NbUsedIntervalsTop + NbUsedIntervalsBottom > Graph.NbYIntervals Then
	If NbUsedIntervalsTop - NbUsedIntervalsBottom > Graph.NbYIntervals Then
		' if yes increas the scale interval
		If ScaleMant <= Logs(0) Then
			ScaleMant = 0
		Else
			For i = 0 To Vals.Length - 2
'				If ScaleMant > Logs(i) And ScaleMant <= Logs(i + 1) Then
				If (ScaleMant + 0.00000000000001) >= Logs(i) And (ScaleMant + 0.00000000000001) < Logs(i + 1) Then
					ScaleMant = Logarithm(Vals(i + 1), 10)
					Exit
				End If
			Next
		End If
		ScalesY(Index).IntervalAuto = Power(10, ScalesY(Index).Exp + ScaleMant)
	End If
	
	' calculate the scale min value
	nbMin = Floor(ValMinMax(0) / ScalesY(Index).IntervalAuto)
	If Abs(ValMinMax(0)) <= 0.0000000000001 Then
		ScalesY(Index).MinAuto = 0
	Else If ValMinMax(0) >= 0 Then
		ScalesY(Index).MinAuto = nbMin * ScalesY(Index).IntervalAuto
	Else If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
		ScalesY(Index).MinAuto = Floor(ValMinMax(0) / ScalesY(Index).IntervalAuto + 0.00000000000001) * ScalesY(Index).IntervalAuto
	Else
		ScalesY(Index).MinAuto = Floor(ValMinMax(0) / ScalesY(Index).IntervalAuto + 0.00000000000001) * ScalesY(Index).IntervalAuto
	End If
	
	' distribution of empty intervals
	If Abs(ScalesY(Index).MinAuto) > 0.0000000000001 Then
		If ValMinMax(0) < 0 And ValMinMax(1) > 0 Then
			NbUsedIntervalsTop = Ceil(ValMinMax(1) / ScalesY(Index).IntervalAuto - 0.00000000000001)
			NbUsedIntervalsBottom = Ceil(Abs(ValMinMax(0)) / ScalesY(Index).IntervalAuto - 0.00000000000001)
			NbUsedIntervals = NbUsedIntervalsTop + NbUsedIntervalsBottom
			If NbUsedIntervalsTop - NbUsedIntervalsBottom = 1 Then
				NbIntervalsToMove = Graph.NbYIntervals / 2 - NbUsedIntervalsBottom
			Else
				NbIntervalsToMove = (Graph.NbYIntervals - NbUsedIntervals) / 2
			End If
		Else
			NbUsedIntervals = Ceil(ValDiff / ScalesY(Index).IntervalAuto - 0.00000000000001)
			NbIntervalsToMove = (Graph.NbYIntervals - NbUsedIntervals) / 2
		End If
		ScalesY(Index).MinAuto = ScalesY(Index).MinAuto - ScalesY(Index).IntervalAuto * NbIntervalsToMove
	End If
	
	' calculate the scale max value
	ScalesY(Index).MaxAuto = ScalesY(Index).MinAuto + ScalesY(Index).IntervalAuto * Graph.NbYIntervals
	
	ScalesY(Index).MinVal = ScalesY(Index).MinAuto
	ScalesY(Index).MaxVal = ScalesY(Index).MaxAuto
	ScalesY(Index).Interval = ScalesY(Index).IntervalAuto
	ScalesY(Index).Scale = Graph.Height / (ScalesY(Index).MaxVal - ScalesY(Index).MinVal)
	
	If ScalesY(Index).MinManu = 0 And ScalesY(Index).MaxManu = 0 Then
		ScalesY(Index).MinManu = ScalesY(Index).MinAuto
		ScalesY(Index).MaxManu = ScalesY(Index).MaxAuto
		ScalesY(Index).IntervalManu = ScalesY(Index).IntervalAuto
	End If
End Sub

'Returns min and max values of the given Curve
Private Sub GetPointsMinMaxValues(Index As Int, ZoomedPartOnly As Boolean) As Double()
	Private i, ib, ie As Int
	Private MinMax(2) As Double
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	MinMax(1) = -1E10
	MinMax(0) = 1E10
	
	If mGraphWithMissingData = False Then
		For i = ib To ie
			MinMax(1) = Max(MinMax(1), CurveY(Index, i))
			MinMax(0) = Min(MinMax(0), CurveY(Index, i))
		Next
	Else
		For i = ib To ie
			If CurveY(Index, i) < mMissingDataValue Then
				MinMax(1) = Max(MinMax(1), CurveY(Index, i))
				MinMax(0) = Min(MinMax(0), CurveY(Index, i))
			End If
		Next
	End If

	Return MinMax
End Sub

'Gets the max width of the x scale values in pixels
Private Sub GetXScaleWidth As Int
	Private Width As Int
	
	Width = MeasureTextWidth(ScaleX.MinVal, Texts.ScaleFont)
	Width = Max(Width, MeasureTextWidth(ScaleX.MaxVal, Texts.ScaleFont))
	Width = Max(Width, MeasureTextWidth(ScaleX.Interval, Texts.ScaleFont))

	Return Width
End Sub

'Sets the scale of curve SameScaleCurveIndex for all curves
Public Sub SetSameScale(SameScaleCurveIndex As Int)
	Private nc, c As Int
	
	Graph.SameScaleCurveIndex = SameScaleCurveIndex
	mAutomaticYScales = True
	For nc = 0 To lstCurvesToDisplay.Size - 1
		c = lstCurvesToDisplay.Get(nc)
		ScalesY(c).MaxVal = ScalesY(SameScaleCurveIndex).MaxManu
		ScalesY(c).MinVal = ScalesY(SameScaleCurveIndex).MinManu
		ScalesY(c).Interval = ScalesY(SameScaleCurveIndex).IntervalManu
		ScalesY(c).Scale = ScalesY(SameScaleCurveIndex).Scale
	Next
	ReDrawGraph
End Sub

'Formats numbers with a fixed number of digits and scientific notation
Public Sub NumberFormat3(Number As Double, MaxDigits As Int) As String
	Private mant, exp, lng, lng2 As Double
	Private str, strMinus As String
	
	If Abs(Number) < 1e-13 Then Return "0"
	
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

'Measures the width of the given text for the given font
Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Width
End Sub

'Measures the height of the given text for the given font
Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Height
End Sub

'Gets or sets the max number of samples
Public Sub getNbMaxSamples As Int
	Return mNbMaxSamples
End Sub

Public Sub setNbMaxSamples(NumberMaxSamples As Int)
	mNbMaxSamples = NumberMaxSamples
	Public CurveX(mNbMaxSamples) As Double
	Public CurveY(mNbMaxCurves, mNbMaxSamples) As Double
End Sub

'Gets or sets the max number of curves
Public Sub getNbMaxCurves As Int
	Return mNbMaxCurves
End Sub

Public Sub setNbMaxCurves(NumberMaxCurves As Int)
	Private i As Int
	
	mNbMaxCurves = NumberMaxCurves
	Public CurveY(mNbMaxCurves, mNbMaxSamples) As Double
	Public CurveYName(mNbMaxCurves) As String
	Public CurveYUnit(mNbMaxCurves) As String
	Public CurveCustomColor(mNbMaxCurves) As Int
	Public CurveCustomWidth(mNbMaxCurves) As Int
	Public CurveDrawYScale(mNbMaxCurves) As Boolean
	Private DefaultColors(10) As Int
	
	DefaultColors(0) = xui.Color_Red
	DefaultColors(1) = xui.Color_Blue
	DefaultColors(2) = xui.Color_Magenta
	DefaultColors(3) = xui.Color_RGB(0, 153, 0)
	DefaultColors(4) = xui.Color_RGB(165, 42, 42)
	DefaultColors(5) = xui.Color_RGB(154, 205, 50)
	DefaultColors(6) = xui.Color_RGB(255, 127, 80)
	DefaultColors(7) = xui.Color_DarkGray
	DefaultColors(8) = xui.Color_RGB(0, 153, 153)
	DefaultColors(9) = xui.Color_RGB(153, 0, 153)
	For i = 0 To mNbMaxCurves - 1
		CurveDrawYScale(i) = True
		CurveCustomWidth(i) = 1dip
		If i < 10 Then
			CurveCustomColor(i) = DefaultColors(i)
		Else
			CurveCustomColor(i) = xui.Color_DarkGray
		End If
	Next
End Sub

'Gets or sets the current number of samples
Public Sub getNbSamples As Int
	Return ScaleX.NbSamples
End Sub

Public Sub setNbSamples(NumberSamples As Int)
	ScaleX.NbSamples = NumberSamples
	ScaleX.IBegin = 0
	ScaleX.IEnd = ScaleX.NbSamples - 1
	Private CurveX(mNbMaxSamples) As Double
End Sub

'Gets or sets the automatic scales mode
'True displays automatic Y sacales for all curves
'False displays the manual scales 
Public Sub getAutomaticYScales As Boolean
	Return mAutomaticYScales
End Sub

Public Sub setAutomaticYScales(AutomaticYScales As Boolean)
	Private nc, c As Int
	
	mAutomaticYScales = AutomaticYScales
	Graph.SameScaleCurveIndex = -1
	
	If mAutomaticYScales = True Then
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			ScalesY(c).MaxVal = ScalesY(c).MaxAuto
			ScalesY(c).MinVal = ScalesY(c).MinAuto
			ScalesY(c).Interval = ScalesY(c).IntervalAuto
			ScalesY(c).Scale = Graph.Height / (ScalesY(c).MaxVal - ScalesY(c).MinVal)
			ScalesY(c).Automatic = True
		Next	
	Else
		For nc = 0 To lstCurvesToDisplay.Size - 1
			c = lstCurvesToDisplay.Get(nc)
			ScalesY(c).MaxVal = ScalesY(c).MaxManu
			ScalesY(c).MinVal = ScalesY(c).MinManu
			ScalesY(c).Interval = ScalesY(c).IntervalManu
			ScalesY(c).Scale = Graph.Height / (ScalesY(c).MaxVal - ScalesY(c).MinVal)
			ScalesY(c).Automatic = False
		Next
	End If
	ReDrawGraph
End Sub

'Gets the automatic scale for the given curve
Public Sub GetScaleAuto(CurveIndex As Int) As ScaleValues
	Private ScaleVals As ScaleValues
	ScaleVals.MinValue = ScalesY(CurveIndex).MinAuto
	ScaleVals.MaxValue = ScalesY(CurveIndex).MaxAuto
	Return ScaleVals
End Sub

'Gets the manual scale for the given curve
Public Sub GetScaleManu(CurveIndex As Int) As ScaleValues
	Private ScaleVals As ScaleValues
	ScaleVals.MinValue = ScalesY(CurveIndex).MinManu
	ScaleVals.MaxValue = ScalesY(CurveIndex).MaxManu
	Return ScaleVals
End Sub

'Sets a manual scale for a given curve
Public Sub SetScaleManu(CurveIndex As Int, MinVal As Double, MaxVal As Double)
	ScalesY(CurveIndex).MinManu = MinVal
	ScalesY(CurveIndex).MaxManu = MaxVal
	ScalesY(CurveIndex).IntervalManu = (MaxVal - MinVal) / Graph.NbYIntervals
	ScalesY(CurveIndex).Scale = Graph.Height / (ScalesY(CurveIndex).MaxManu - ScalesY(CurveIndex).MinManu)
End Sub

'Returns a B4XBitmap object of the graph (read only)
Public Sub getSnapshot As B4XBitmap
	Return mBase.Snapshot
End Sub

'Gets or sets the curves to display
Public Sub getCurvesToDisplay As List
	Return lstCurvesToDisplay
End Sub

Public Sub setCurvesToDisplay(CurvesToDisplay As List)
	lstCurvesToDisplay = CurvesToDisplay
End Sub

'Gets or sets the ScaleValues property
'it is a string  with the different scale values separated by an exclamation mark.
'it must begin with 1! and end with !10
'the default property is 1!2!2.5!5!10
'these values can be selected in the Designer: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10
'Example code: <code>xGraph1.ScaleXValues = "1!2!2.5!5!10"</code>
Public Sub getScaleXValues As String
	Return Graph.ScaleXValues
End Sub

Public Sub setScaleXValues(ScaleXValues As String)
	If ScaleXValues.StartsWith("1!") = False Or ScaleXValues.EndsWith("!10") = False Then
		Log("Wrong ScaleXValues property")
		Return
	End If
	Graph.ScaleXValues = ScaleXValues
End Sub

'Gets or sets the ScaleValues property
'used for automatic scales
'it is a string  with the different scale values separated by the exclamation mark.
'it must begin with 1! and end with !10
'the default property 1!2!2.5!5!10
'These values can be selected in the Designer: 1!2!2.5!5!10|1!1.2!1.5!1.8!2!2.5!3!4!5!6!7!8!9!10
'Example code: <code>xGraph1.ScaleXValues = "1!2!2.5!5!10"</code>
Public Sub getScaleYValues As String
	Return Graph.ScaleYValues
End Sub

Public Sub setScaleYValues(ScaleYValues As String)
	If ScaleYValues.StartsWith("1!") = False Or ScaleYValues.EndsWith("!10") = False Then
		Log("Wrong ScaleXValues property")
		Return
	End If
	Graph.ScaleYValues = ScaleYValues
End Sub

'Gets or sets the DisplayCurveUnit property
'True displays the curve unit after the curve name
Public Sub getDisplayCurveUnit As Boolean
	Return mDisplayCurveUnit
End Sub

Public Sub setDisplayCurveUnit(DisplayCurveUnit As Boolean)
	mDisplayCurveUnit = DisplayCurveUnit
End Sub

'Gets or sets the DisplayCurveIndex property
'True displays the curve index before the curve name
Public Sub getDisplayCurveIndex As Boolean
	Return mDisplayCurveIndex
End Sub

Public Sub setDisplayCurveIndex(DisplayCurveIndex As Boolean)
	mDisplayCurveIndex = DisplayCurveIndex
End Sub

'Sets the begin and end indexes for zoom diaplay
Public Sub SetZoomIndexes(BeginIndex As Int, EndIndex As Int)
	If EndIndex < BeginIndex Then
		Private Dummy As Int
		Dummy = BeginIndex
		BeginIndex = EndIndex
		EndIndex = Dummy
	End If
	BeginIndex = Max(0, BeginIndex) 
	EndIndex = Min(ScaleX.NbSamples - 1, EndIndex)
	ScaleX.IBegin = BeginIndex
	ScaleX.IEnd = EndIndex
	If ScaleX.IBegin = 0 And ScaleX.IEnd = ScaleX.NbSamples - 1 Then
		Zoomed = False
	Else
		Zoomed = True
		ZoomCursorActive = True
	End If
	DrawZoomCursor
	DrawGraph
End Sub

'Sets the zooming mode
'The user selects with the cursor the left limit and then the right limit
Public Sub SetZoomMode
	mZoomMode = 0
	xlblComments.Visible = True
	xlblComments.Text = "Select the left limit"
	#If B4J
		Private pnl As Pane
		pnl = xpnlCursor
		pnl.MouseCursor = fx.Cursors.HAND	
	#End If
End Sub

'Gets or sets the graph title
Public Sub getTitle As String
	Return Graph.Title
End Sub

Public Sub setTitle(Title As String)
	Graph.Title = Title
End Sub

'Gets or sets the x axis name
Public Sub getXAxisName As String
	Return Graph.XAxisName
End Sub

Public Sub setXAxisName(XAxisName As String)
	Graph.XAxisName = XAxisName
End Sub

'Gets or sets the x axis unit
Public Sub getXAxisUnit As String
	Return Graph.XAxisUnit
End Sub

Public Sub setXAxisUnit(XAxisUnit As String)
	Graph.XAxisUnit = XAxisUnit
End Sub

'Sets the a new name for the curve with the given index
'UpdateGraph = True redraws the graph
Public Sub SetCurveName(CurveIndex As Int, Name As String, UpdateGraph As Boolean)
	If CurveIndex >= 0 And CurveIndex < = mNbMaxCurves - 1 Then
		CurveYName(CurveIndex) = Name
		If UpdateGraph = True Then
			ReDrawGraph			
		End If
	End If
End Sub

'Sets a new unit for the curve with the given index
'UpdateGraph = True redraws the graph
Public Sub SetCurveUnit(CurveIndex As Int, Unit As String, UpdateGraph As Boolean)
	CurveYUnit(CurveIndex) = Unit
	If UpdateGraph = True Then
		ReDrawGraph
	End If
End Sub

'Gets or sets the number of x axis intervals
Public Sub getNbXIntervals As Int
	Return Graph.NbXIntervals	
End Sub

Public Sub setNbXIntervals(NbXIntervals As Int)
	Graph.NbXIntervals = NbXIntervals
End Sub

'Gets or sets the number of y axis intervals
Public Sub getNbYIntervals As Int
	Return Graph.NbYIntervals	
End Sub

Public Sub setNbYIntervals(NbYIntervals As Int)
	Graph.NbYIntervals = NbYIntervals
End Sub

'Gets or sets the graph background color
Public Sub getGraphColor As Int
	Return Graph.GraphColor
End Sub

Public Sub setGraphColor(GraphColor As Int)
	Graph.GraphColor = GraphColor
End Sub

'Gets or sets the graph grid color
Public Sub getGridColor As Int
	Return Graph.GraphColor
End Sub

Public Sub setGridColor(GridColor As Int)
	Graph.GridColor = GridColor
End Sub

'Gets or sets the graph grid frame color
Public Sub getGridFrameColor As Int
	Return Graph.GridFrameColor
End Sub

Public Sub setGridFrameColor(GridFrameColor As Int)
	Graph.GridFrameColor = GridFrameColor
End Sub

'Gets or sets the graph outer frame property
'True = draws an outer frame around the graph
Public Sub getOuterFrame As Boolean
	Return Graph.OuterFrame
End Sub

Public Sub setOuterFrame(OuterFrame As Boolean)
	Graph.OuterFrame = OuterFrame
End Sub

'Gets or sets the graph outer frame color
Public Sub getOuterFrameColor As Int
	Return Graph.OuterFrameColor
End Sub

Public Sub setOuterFrameColor(OuterFrameColor As Int)
	Graph.OuterFrameColor = OuterFrameColor
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
	Return mBase.Top
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
End Sub

'Gets or sets the Height property
Public Sub getHeight As Int
	Return mBase.Height
End Sub

Public Sub setHeight(Height As Int)
	mBase.Height = Height
End Sub

'Gets the GraphLeft property
'The left position of the Graph in pixels 
Public Sub getGraphLeft As Int
	Return Graph.Left
End Sub

'Gets the GraphWidth property
'The width of the Graph in pixels 
Public Sub getGraphWidth As Int
	Return Graph.Width
End Sub

'Gets the GraphTop property
'The top position of the Graph in pixels 
Public Sub getGraphTop As Int
	Return Graph.Top
End Sub

'Gets the GraphHeight property
'The height of the Graph in pixels 
Public Sub getGraphHeight As Int
	Return Graph.Height
End Sub

'Gets the XIndexBegin property
'Index of the first visible item 
Public Sub getXIndexBegin As Int
	Return ScaleX.IBegin
End Sub

'Gets the XIndexEnd property
'Index of the last visible item 
Public Sub getXIndexEnd As Int
	Return ScaleX.IEnd
End Sub

'gets or sets the DrawCursorValues property
'Displays the values of the cuves at the cursor position
Public Sub getDrawCursorValues As Boolean
	Return mDrawCursorValues
End Sub

Public Sub setDrawCursorValues(DrawCursorValues As Boolean)
	mDrawCursorValues = DrawCursorValues
	DrawTwoCursors
End Sub

'Gets or sets the GraphWithMissingDat property
'Manages curves with missing data, it is necessary to enter the MissingDataValue in place.
Public Sub getGraphWithMissingData As Boolean
	Return mGraphWithMissingData
End Sub

Public Sub setGraphWithMissingData(GraphWithMissingData As Boolean)
	mGraphWithMissingData = GraphWithMissingData
End Sub

'Gets sets the MissingDataValue property
'Used when GraphWithMissingData = True, the missing data must be replaced by this value.
Public Sub getMissingDataValue As Int
	Return mMissingDataValue
End Sub

Public Sub setMissingDataValue(MissingDataValue As Int)
	mMissingDataValue = MissingDataValue
End Sub

'Gets or sets the UseCustomColors property
'UseCustomColors = False, 4 colors and widths are used for superimpositions, 
'they remain the same independant of the curves displayed
'UseCustomColors = True, one specific color and width can be defined for each curve
Public Sub getUseCustomColors As Boolean
	Return mUseCustomColors
End Sub

Public Sub setUseCustomColors(UseCustomColors As Boolean)
	mUseCustomColors = UseCustomColors
End Sub

'Copies the curve with SourceIndex to the DestinationIndex curve.
Public Sub CopyCurve(SourceIndex As Int, DestinationIndex As Int)
	Private i As Int
	
	For i = 0 To ScaleX.NbSamples - 1
		CurveY(DestinationIndex, i) = CurveY(SourceIndex, i)
	Next
End Sub

'Adds a value to the given cuve
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcAddValue(CurveIndex As Int, Value As Double, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int

	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mUseCustomColors = False Then
		For i = ib To ie
			CurveY(CurveIndex, i) = CurveY(CurveIndex, i) + Value
		Next
	Else
		For i = ib To ie
			If CurveY(CurveIndex, i) = mMissingDataValue Then
				CurveY(CurveIndex, i) = mMissingDataValue
			Else
				CurveY(CurveIndex, i) = CurveY(CurveIndex, i) + Value
			End If
		Next
	End If
	CurveYName(CurveIndex) = CurveYName(CurveIndex) & " + " & Value
End Sub

'Multiplies the curve by the given value
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcMultiplyByValue(CurveIndex As Int, Value As Double, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int

	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mUseCustomColors = False Then
		For i = ib To ie
			CurveY(CurveIndex, i) = CurveY(CurveIndex, i) * Value
		Next
	Else
		For i = ib To ie
			If CurveY(CurveIndex, i) = mMissingDataValue Then
				CurveY(CurveIndex, i) = mMissingDataValue
			Else
				CurveY(CurveIndex, i) = CurveY(CurveIndex, i) * Value
			End If
		Next
	End If
	CurveYName(CurveIndex) = CurveYName(CurveIndex) & " * " & Value
End Sub

'Adds two curves and copies the result in the destination curve
'Curve(DestinationIndex) = Curve(SourceIndex1) + Curve(SourceIndex2)
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcSum2Curves(SourceIndex1 As Int, SourceIndex2 As Int, DestinationIndex As Int, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mUseCustomColors = False Then
		For i = ib To ie
			CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) + CurveY(SourceIndex2, i)
		Next
	Else
		For i = ib To ie
			If CurveY(SourceIndex1, i) = mMissingDataValue Or CurveY(SourceIndex2, i) = mMissingDataValue Then
				CurveY(DestinationIndex, i) = mMissingDataValue
			Else
				CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) + CurveY(SourceIndex2, i)
			End If
		Next
	End If
	CurveYName(DestinationIndex) = CurveYName(SourceIndex1) & " + " & CurveYName(SourceIndex2)
	CurveYUnit(DestinationIndex) = CurveYUnit(SourceIndex1)
End Sub

'Substracts two curves and copies the result in the destination curve
'Curve(DestinationIndex) = Curve(SourceIndex1) - Curve(SourceIndex2)
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcSubtract2Curves(SourceIndex1 As Int, SourceIndex2 As Int, DestinationIndex As Int, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	If mUseCustomColors = False Then
		For i = ib To ie
			CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) - CurveY(SourceIndex2, i)
		Next
	Else
		For i = ib To ie
			If CurveY(SourceIndex1, i) = mMissingDataValue Or CurveY(SourceIndex2, i) = mMissingDataValue Then
				CurveY(DestinationIndex, i) = mMissingDataValue
			Else
				CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) - CurveY(SourceIndex2, i)
			End If
		Next
	End If
	CurveYName(DestinationIndex) = CurveYName(SourceIndex1) & " - " & CurveYName(SourceIndex2)
	CurveYUnit(DestinationIndex) = CurveYUnit(SourceIndex1)
End Sub

'Multiplies two curves and copies the result in the destination curve
'Curve(DestinationIndex) = Curve(SourceIndex1) * Curve(SourceIndex2)
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcMutiply2Curves(SourceIndex1 As Int, SourceIndex2 As Int, DestinationIndex As Int, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mUseCustomColors = False Then
		For i = ib To ie
			CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) * CurveY(SourceIndex2, i)
		Next
	Else
		For i = ib To ie
			If CurveY(SourceIndex1, i) = mMissingDataValue Or CurveY(SourceIndex2, i) = mMissingDataValue Then
				CurveY(DestinationIndex, i) = mMissingDataValue
			Else
				CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) * CurveY(SourceIndex2, i)
			End If
		Next
	End If
	CurveYName(DestinationIndex) = CurveYName(SourceIndex1) & " * " & CurveYName(SourceIndex2)
	CurveYUnit(DestinationIndex) = CurveYUnit(SourceIndex1)
End Sub

'Devides two curves and copies the result in the destination curve
'Curve(DestinationIndex) = Curve(SourceIndex1) / Curve(SourceIndex2)
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcDevide2Curves(SourceIndex1 As Int, SourceIndex2 As Int, DestinationIndex As Int, ZoomedPartOnly As Boolean)
	Private i, ib, ie As Int
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mUseCustomColors = False Then
		For i = ib To ie
			If CurveY(SourceIndex2, i) <> 0 Then
				CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) / CurveY(SourceIndex2, i)
			End If
		Next
	Else
		For i = ib To ie
			If CurveY(SourceIndex1, i) = mMissingDataValue Or CurveY(SourceIndex2, i) = mMissingDataValue Then
				CurveY(DestinationIndex, i) = mMissingDataValue
			Else
				If CurveY(SourceIndex2, i) <> 0 Then
					CurveY(DestinationIndex, i) = CurveY(SourceIndex1, i) / CurveY(SourceIndex2, i)
				End If
			End If
		Next
	End If
	CurveYName(DestinationIndex) = CurveYName(SourceIndex1) & " / " & CurveYName(SourceIndex2)
	CurveYUnit(DestinationIndex) = CurveYUnit(SourceIndex1)
End Sub

'Returns the mean value of the given curve
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcMeanValue(CurveIndex As Int, ZoomedPartOnly As Boolean) As Double
	Private i, ib, ie, n As Int
	Private Mean As Double

	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	If mGraphWithMissingData = False Then
		For i = ib To ie
			Mean = Mean + CurveY(CurveIndex, i)
		Next
		n = ScaleX.NbSamples
	Else
		n = 0
		For i = ib To ie
			If CurveY(CurveIndex, i) <> mMissingDataValue Then
				Mean = Mean + CurveY(CurveIndex, i)
				n = n + 1
			End If
		Next
	End If
	Mean = Mean / n
	Return Mean
End Sub

'Returns the RMS value of the given curve
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
Public Sub CalcRMSValue(CurveIndex As Int, ZoomedPartOnly As Boolean) As Double
	Private i, ib, ie, n As Int
	Private RMS As Double

	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If

	If mGraphWithMissingData = False Then
		For i = ib To ie
			RMS = RMS + CurveY(CurveIndex, i) * CurveY(CurveIndex, i)
		Next
		n = ScaleX.NbSamples
	Else
		n = 0
		For i = ib To ie
			If CurveY(CurveIndex, i) <> mMissingDataValue Then
				RMS = RMS + CurveY(CurveIndex, i) * CurveY(CurveIndex, i)
				n = n + 1
			End If
		Next
	End If
	RMS = Sqrt(RMS / n)
	Return RMS
End Sub

'Calculates the derivative of the source curve and saves the result in the destination curve
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
'!!! This routine does not work with missing data !!!
Public Sub CalcDerivative(SourceIndex As Int, DestinationIndex As Int, ZoomedPartOnly As Boolean)
	Private x1, x2, x3, dT As Double
	Private i, cs, cd, ib, ie As Int
	
	cs = SourceIndex
	cd = DestinationIndex
	dT = CurveX(1) - CurveX(0)
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	CurveY(cd, ib) = (CurveY(cs, ib + 1) - CurveY(cs, ib)) / dT
	For i = ib + 1 To ie - 1
		CurveY(cd, I) = (CurveY(cs, I + 1) - CurveY(cs, I - 1)) / 2 / dT
	Next
	CurveY(cd,ie) = (CurveY(cs, ie) - CurveY(cs, ie - 1)) / dT
 
	x1 = CurveY(cs, ib)
	x2 = CurveY(cs, ib + 1)
	x3 = CurveY(cs, ib + 2)
	CurveY(cd, ib) = (-x3 -x1 + 2 * x2 + (x3 - x1) / 2) / dT
  
	x1 = CurveY(cs, ie - 2)
	x2 = CurveY(cs, ie - 1)
	x3 = CurveY(cs, ie)
	CurveY(cd, ie) = (x3 + x1 - 2 * x2 + (x3 - x1) / 2 ) / dT
	CurveYName(cd) = "d/dt " & CurveYName(cs)
	CurveYUnit(cd) = CurveYUnit(cs) & "/s"
End Sub

'Calculates the integral of the source curve and saves the result in the destination curve
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
'!!! This routine does not work with missing data !!!
Public Sub CalcIntegral(SourceIndex As Int, DestinationIndex As Int, InitilalCondition As Double, ZoomedPartOnly As Boolean)
	Private dT As Double
	Private i, cs, cd, ib, ie As Int
	
	cs = SourceIndex
	cd = DestinationIndex
	dT = CurveX(1) - CurveX(0)
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	CurveY(cd, ib) = InitilalCondition
	For i = ib + 1 To ie - 1 Step 2
		CurveY(cd, i) = CurveY(cd, i - 1) + dT * (5 * CurveY(cs, i - 1) + 8 * CurveY(cs, i) - CurveY(cs, i + 1)) / 12
		If i <= ie Then
			CurveY(cd, i + 1) = CurveY(cd, i - 1) + dT * (CurveY(cs, i - 1) + 4 * CurveY(cs, i) + CurveY(cs, i + 1)) / 3
		End If
	Next
	CurveY(cd, ie) = CurveY(cd, ie - 2) + dT * (CurveY(cs, ie - 2) + 4 * CurveY(cs, ie - 1) + CurveY(cs, ie)) / 3
	CurveYName(cd) = "∫ " & CurveYName(cs)
	CurveYUnit(cd) = CurveYUnit(cs) & "*s"
End Sub

'Smooths the source curve and saves the result in the destination curve 
'The Smooth method takes the mean value of the number of samples given in Span around a sample and saves it at the same index.
'Number of samples must be an odd number, if an even number is enterd its value is incremented by 1.
'Documentation: https://en.wikipedia.org/wiki/Moving_average
'ZoomedPartOnly = True calculates only the zoomed part if the curve is zoomed
'SmoothType = "MEAN" or "RMS"
'Be aware that with RMS smothing, and nagative values, you will get wrong data
'Example:
'<code>xGraph1.CalcSmooth(2, 4, 5, False, "MEAN")</code>
Public Sub CalcSmooth(SourceIndex As Int, DestinationIndex As Int, Span As Int, ZoomedPartOnly As Boolean, SmoothType As String)
	Private Mean, RMS As Double
	Private i, cs, cd, ib, ie, js, n, NbS, NbS2 As Int
	
	If SmoothType <> "MEAN" And SmoothType <> "RMS" Then
		Log("Wrong SmothType " & SmoothType)
		Return
	End If
	
	If Span < 3 Then
		Log("Span value too small !")
		Return
	End If
	
	NbS = Span
	NbS2 = Span / 2
	NbS = 2 * NbS2 + 1
	
	cs = SourceIndex
	cd = DestinationIndex
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	If mGraphWithMissingData = False Then
		Select SmoothType
			Case "MEAN"
				For i = 0 To NbS2 - 1
					js = ib + i
					Mean = 0
					For j = ib To ib + i
						Mean = Mean + CurveY(cs, j)
					Next
					CurveY(cd, js) = Mean / (i + 1)
				Next
	
				For i = ib + NbS2 To ie - NbS2
					Mean = 0
					For j = i - NbS2 To i + NbS2
						Mean = Mean + CurveY(cs, j)
					Next
					CurveY(cd, i) = Mean / NbS
				Next

				For i = 0 To NbS2 - 1
					js = ie - i
					Mean = 0
					For j = ie To ie - i Step -1
						Mean = Mean + CurveY(cs, j)
					Next
					CurveY(cd, js) = Mean / (i + 1)
				Next
			Case "RMS"
				For i = 0 To NbS2 - 1
					js = ib + i
					RMS = 0
					For j = ib To ib + i
						RMS = RMS + CurveY(cs, j) * CurveY(cs, j)
					Next
					CurveY(cd, js) = Sqrt(RMS / (i + 1))
				Next
	
				For i = ib + NbS2 To ie - NbS2
					RMS = 0
					For j = i - NbS2 To i + NbS2
						RMS = RMS + CurveY(cs, j) + CurveY(cs, j)
					Next
					CurveY(cd, i) = Sqrt(RMS / NbS)
				Next

				For i = 0 To NbS2 - 1
					js = ie - i
					RMS = 0
					For j = ie To ie - i Step -1
						RMS = RMS + CurveY(cs, j) * CurveY(cs, j)
					Next
					CurveY(cd, js) = Sqrt(RMS / (i + 1))
				Next
		End Select
	Else
		Select SmoothType
			Case "MEAN"
				For i = 0 To NbS2 - 1
					js = ib + i
					Mean = 0
					n = 0
					For j = ib To ib + i
						If CurveY(cs, j) <> mMissingDataValue Then
							Mean = Mean + CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, js) <> mMissingDataValue Then
						CurveY(cd, js) = Mean / n
					Else
						CurveY(cd, js) = mMissingDataValue
					End If
				Next
	
				For i = ib + NbS2 To ie - NbS2
					Mean = 0
					n = 0
					For j = i - NbS2 To i + NbS2
						If CurveY(cs, j) <> mMissingDataValue Then
							Mean = Mean + CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, i) <> mMissingDataValue Then
						CurveY(cd, i) = Mean / n
					Else
						CurveY(cd, i) = mMissingDataValue
					End If
				Next

				For i = 0 To NbS2 - 1
					js = ie - i
					Mean = 0
					n = 0
					For j = ie To ie - i Step -1
						If CurveY(cs, j) <> mMissingDataValue Then
							Mean = Mean + CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, js) <> mMissingDataValue Then
						CurveY(cd, js) = Mean / n
					Else
						CurveY(cd, js) = mMissingDataValue
					End If
				Next
			Case "RMS"
				For i = 0 To NbS2 - 1
					js = ib + i
					RMS = 0
					n = 0
					For j = ib To ib + i
						If CurveY(cs, j) <> mMissingDataValue Then
							RMS = RMS + CurveY(cs, j) * CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, js) <> mMissingDataValue Then
						CurveY(cd, js) = Sqrt(RMS / n)
					Else
						CurveY(cd, js) = mMissingDataValue
					End If
				Next
	
				For i = ib + NbS2 To ie - NbS2
					RMS = 0
					n = 0
					For j = i - NbS2 To i + NbS2
						If CurveY(cs, j) <> mMissingDataValue Then
							RMS = RMS + CurveY(cs, j) * CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, i) <> mMissingDataValue Then
						CurveY(cd, i) = Sqrt(RMS / n)
					Else
						CurveY(cd, i) = mMissingDataValue
					End If
				Next

				For i = 0 To NbS2 - 1
					js = ie - i
					RMS = 0
					n = 0
					For j = ie To ie - i Step -1
						If CurveY(cs, j) <> mMissingDataValue Then
							RMS = RMS + CurveY(cs, j) * CurveY(cs, j)
							n = n + 1
						End If
					Next
					If CurveY(cs, js) <> mMissingDataValue Then
						CurveY(cd, js) = Sqrt(RMS / n)
					Else
						CurveY(cd, js) = mMissingDataValue
					End If
				Next
		End Select
	End If
	
	CurveYName(cd) = CurveYName(cs) & " smoothed/" & Span & " " & SmoothType
	CurveYUnit(cd) = CurveYUnit(cs)
End Sub

'Smooths the source curve and saves the result in the destination curve, sort of low pass filter
'The smoothing algorithm is a first order lag which implements an exponential response
'to a step input Kt must be smaller than 1.0
'yd[t] = yd[t-1] + Kt (ys[t] - yd[t-1])
'yd = destination  ys = source
'Documentation: https://en.wikipedia.org/wiki/Exponential_smoothing
'Routine kindly provided by rgarnett1955
'Example:
'<code>xGraph1.CalcSmoothExponentialLag(2, 4, 0.5, False)</code>
Public Sub CalcSmoothExponentialLag(SourceIndex As Int, DestinationIndex As Int, Kt As Double, ZoomedPartOnly As Boolean)
	Private i, cs, cd, ib, ie As Int
	
	cs = SourceIndex
	cd = DestinationIndex
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	If mGraphWithMissingData = False Then
		'Set  the first sample to the actual value
		CurveY(cd, ib) = CurveY(cs, ib)
		ib = ib + 1

		'Yt = yd[t-1]  + Kt (ys[t]-yd[t-1])
		For i = ib To ie
			CurveY(cd, i) =   CurveY(cd, i - 1) + Kt * (CurveY(cs, i) - CurveY(cd, i - 1))
		Next
	Else
		If Not(CurveY(cs, ib) < mMissingDataValue) Then
			'Set  the first sample to the actual value
			CurveY(cd, ib) = mMissingDataValue
		Else
			CurveY(cd, ib) = CurveY(cs, ib)
		End If
		
		ib = ib + 1
		
		For i = ib To ie
			'Yt = yd[t-1]  + Kt (ys[t]-yd[t-1])
			If CurveY(cs, i) < mMissingDataValue Then
				If CurveY(cd, i - 1) < mMissingDataValue Then
					CurveY(cd, i) =   CurveY(cd, i - 1) + Kt * (CurveY(cs, i) - CurveY(cd, i - 1))
				Else
					CurveY(cd, i) = CurveY(cs, i)
				End If
			Else
				CurveY(cd, i) = mMissingDataValue
			End If
		Next
	End If
	CurveYName(cd) = CurveYName(cs) & " smoothed/" & Kt
	CurveYUnit(cd) = CurveYUnit(cs)
End Sub

'Smooths the source curve and saves the result in the destination curve, sort of high pass filter
'The smoothing algorithm is a first order lead which implements an step response
'and exponential decay to a step input. Kt must be smaller than 1.0
'yd = Kt (ys[t]- yd[t-1])
'ydLast = y[t-1]  + yt
'yd = destination  ys = source
'Routine kindly provided by rgarnett1955
'Example:
'<code>xGraph1.CalcSmoothExponentialLead(2, 4, 0.5, False)</code>
Public Sub CalcSmoothExponentialLead(SourceIndex As Int, DestinationIndex As Int, Kt As Double, ZoomedPartOnly As Boolean)
	Private i, cs, cd, ib, ie As Int
	Private yLast As Double
	
	cs = SourceIndex
	cd = DestinationIndex
	
	ib = 0
	ie = ScaleX.NbSamples - 1
	If Zoomed = True And ZoomedPartOnly = True Then
		ib = ScaleX.IBegin
		ie = ScaleX.IEnd
	End If
	
	If mGraphWithMissingData = False Then
		'Set  the first sample to the actual value
		yLast = CurveY(cs, ib)
		CurveY(cd, ib) = 0

		ib = ib + 1
		
		'yd = Kt (ys[t]- yd[t-1])
		'ydLast = y[t-1]  + yt
		For i = ib To ie
			CurveY(cd, i) = Kt * (CurveY(cs, i) - yLast)
			yLast = yLast + CurveY(cd, i)
		Next
	Else
		If Not(CurveY(cs, ib) < mMissingDataValue) Then
			yLast = mMissingDataValue
			CurveY(cd, ib) = mMissingDataValue
		Else
			yLast = CurveY(cs, ib)
			CurveY(cd, ib) = 0
		End If

		ib = ib + 1
		
		For i = ib To ie
			If CurveY(cs, i) < mMissingDataValue Then
				If yLast < mMissingDataValue Then
					CurveY(cd, i) = Kt * (CurveY(cs, i) - yLast)
					yLast =   yLast + CurveY(cd, i)
				Else
					yLast = CurveY(cs, i)
					CurveY(cd, i) = mMissingDataValue
				End If
			Else
				yLast = mMissingDataValue
				CurveY(cd, i) = mMissingDataValue
			End If
		Next
	End If

	CurveYName(cd) = CurveYName(cs) & " lead/" & Kt
	CurveYUnit(cd) = CurveYUnit(cs)
End Sub

Public Sub UnZoom
	SetZoomIndexes(0, ScaleX.NbSamples)
	xcvsCursor.ClearRect(RectZoomCursorArea)
	If mSynchronizeGraphs = True Then
		mGraphToSynchronize.SetZoomIndexes(0, ScaleX.NbSamples)
		mGraphToSynchronize.xcvsCursor.ClearRect(mGraphToSynchronize.RectZoomCursorArea)
		xcvsZoomedArea.ClearRect(xcvsZoomedArea.TargetRect)
	End If
End Sub

'Sets one of the two cursors
'XIndex = sample index, in the curve array
'CursorIndex = 0 or 1, index of the cursor
Public Sub SetCursor(XIndex As Int, CursorIndex As Int, Color As Int)
	Private TC As CursorsData
	
	If CursorIndex > 1 Then
		Return
	End If
	
	TC.Initialize
	TC.XIndex = XIndex
	TC.Color = Color
	TC.XValue = CurveX(XIndex)
	TC.Rect.Initialize(0, 0, 1dip, 1dip)
	If lstTwoCursors.Size = 0 And CursorIndex = 0 Or lstTwoCursors.Size = 1 And CursorIndex = 1 Then
		lstTwoCursors.Add(TC)
	Else If lstTwoCursors.Size = 0 And CursorIndex = 1 Then
	Else
		lstTwoCursors.Set(CursorIndex, TC)
	End If
	
	If mSynchronizeGraphs = True Then
		TC.Initialize
		TC.XIndex = XIndex
		TC.Color = Color
		TC.XValue = CurveX(XIndex)
		If mGraphToSynchronize.lstTwoCursors.Size = 0 And CursorIndex = 0 Or lstTwoCursors.Size = 1 And CursorIndex = 1 Then
			lstTwoCursors.Add(TC)
		Else If mGraphToSynchronize.lstTwoCursors.Size = 0 And CursorIndex = 1 Then
		Else
			mGraphToSynchronize.lstTwoCursors.Set(CursorIndex, TC)
		End If
	End If
	DrawTwoCursors

End Sub

'Adds a cursor with the given color by touching the graph
Public Sub AddCursor(Color As Int)
	If lstTwoCursors.Size < 2 Then
		Private TC As CursorsData
		TC.Initialize
		TC.Color = Color
		lstTwoCursors.Add(TC)
		If mSynchronizeGraphs = True Then
			mGraphToSynchronize.lstTwoCursors.Add(TC)
		End If

		mCursorMode = 2
		mCurrentCursor = lstTwoCursors.Size - 1
		xlblComments.Text = "Select the position of the cursor"
		xlblComments.Visible = True
	#If B4J
		Private pnl As Pane
		pnl = xpnlCursor
		pnl.MouseCursor = fx.Cursors.HAND
	#End If
	End If
End Sub

'Removes one or both cursors.
'Set Index = 0 or 1 as cursor index to delete one cursor 
'Set Index = 2 to delete both cursors
'When you remove cursor(0) cursor(1) becomes cursor(0), it is removed from the list
'If there is only one Cursor, then any index value will remove the cursor.
Public Sub RemoveCursor(Index As Int)
	Private TC As CursorsData
	
	If mCursorMode = 2 Then 'avoids an error if the AddCursor mode is active and RemoveCursor is called
		mCursorMode = -1
		xlblComments.Text = ""
		xlblComments.Visible = False
		Return
	End If
	
	If lstTwoCursors.Size = 2 Then
		Select Index
			Case 0
				TC = lstTwoCursors.Get(0)
				xcvsTwoCursors.ClearRect(TC.Rect)
				lstTwoCursors.RemoveAt(0)
			Case 1
				TC = lstTwoCursors.Get(1)
				xcvsTwoCursors.ClearRect(TC.Rect)
				lstTwoCursors.RemoveAt(1)
			Case 2
				TC = lstTwoCursors.Get(1)
				xcvsTwoCursors.ClearRect(TC.Rect)
				TC = lstTwoCursors.Get(0)
				xcvsTwoCursors.ClearRect(TC.Rect)
				lstTwoCursors.RemoveAt(1)
				lstTwoCursors.RemoveAt(0)
		End Select
		If mSynchronizeGraphs = True Then
			Select Index
				Case 0
					TC = mGraphToSynchronize.lstTwoCursors.Get(0)
					mGraphToSynchronize.xcvsTwoCursors.ClearRect(TC.Rect)
					mGraphToSynchronize.lstTwoCursors.RemoveAt(0)
				Case 1
					TC = mGraphToSynchronize.lstTwoCursors.Get(1)
					mGraphToSynchronize.xcvsTwoCursors.ClearRect(TC.Rect)
					mGraphToSynchronize.lstTwoCursors.RemoveAt(1)
				Case 2
					TC = mGraphToSynchronize.lstTwoCursors.Get(1)
					mGraphToSynchronize.xcvsTwoCursors.ClearRect(TC.Rect)
					TC = mGraphToSynchronize.lstTwoCursors.Get(0)
					mGraphToSynchronize.xcvsTwoCursors.ClearRect(TC.Rect)
					mGraphToSynchronize.lstTwoCursors.RemoveAt(1)
					mGraphToSynchronize.lstTwoCursors.RemoveAt(0)
			End Select
		End If
		DrawTwoCursors
	Else If lstTwoCursors.Size = 1 Then
		TC = lstTwoCursors.Get(0)
		xcvsTwoCursors.ClearRect(TC.Rect)
		lstTwoCursors.RemoveAt(0)
		If mSynchronizeGraphs = True Then
			TC = mGraphToSynchronize.lstTwoCursors.Get(0)
			mGraphToSynchronize.xcvsTwoCursors.ClearRect(TC.Rect)
			mGraphToSynchronize.lstTwoCursors.RemoveAt(0)
		End If
		DrawTwoCursors
	End If
End Sub

'Gets the current number of cursors
Public Sub getNumberOfCursors As Int
	Return lstTwoCursors.Size
End Sub

'checks if there is a Cursor near the X coordinate
'Returns the cursor index or -1
Private Sub ChekTwoCursor(x As Int, y As Int) As Int
	Private i, ix, j As Int
	Private dx As Int
	Private TC As CursorsData
	
	i = -1
	dx = 5dip
	For i = 0 To lstTwoCursors.Size -1
		TC = lstTwoCursors.Get(i)
		ix = Graph.Left + (TC.XIndex - ScaleX.IBegin) / (ScaleX.IEnd - ScaleX.IBegin) * Graph.Width
		If (y >= Graph.Top And y < Graph.Bottom) And x >= ix - dx And x <= ix + dx Then
			j = i
			Exit
		Else
			j = -1
		End If
	Next
	Return j
End Sub

'If you have two xGraph objects you can synchronize them.
'Condition: the X scales must be the same
'Cursors and zoom are active on both objects
'GraphToSynchronize = xGraph object to synchronize
'SelectedGraphShow = True shows a line at the right side of the graph, with the SelectedGraphColor
'SelectedGraphColor = color of the line at the right side of the graph
'SynchronizeZoom = True synchronizes the zoom in both graphs
'                = False you can have two different zoom levels in the two graphs
'DisplaySynchronizedZoomArea = True, when one graph is zoomed and the other not, displays the zoomed area in the other graph 
'														 = False, does not display the zoomed area
'Example code: <code>
'xGraph1.SetGraphToSynchronize(xGraph2, True, xui.Color_Red, True)
'xGraph2.SetGraphToSynchronize(xGraph1, True, xui.Color_Blue, True)</code>
'To synchronize two xGraph objects, you need to add the two lines above in your code
Public Sub SetGraphToSynchronize(GraphToSynchronize As xGraph, SelectedGraphShow As Boolean, SelectedGraphColor As Int, SynchronizeZoom As Boolean, DisplaySynchronizedZoomArea As Boolean)
	mGraphToSynchronize = GraphToSynchronize
	mSelectedGraphShow = SelectedGraphShow
	mSelectedGraphColor = SelectedGraphColor
	mSynchronizeZoom = SynchronizeZoom
	mSynchronizeGraphs = True
End Sub

'Desynchronizes two synchronized xGraph objects
Public Sub DeSynchronize
	mSynchronizeGraphs = False
End Sub

'When two xGraph objects are synchronized
'Synchronize the zoom in both graphs.
Public Sub setSynchronizeZoom(Synchronize As Boolean)
	mSynchronizeZoom = Synchronize
	mGraphToSynchronize.mSynchronizeZoom = Synchronize
End Sub

Public Sub getSynchronizeZoom As Boolean
	Return mSynchronizeZoom
End Sub

 'When two xGraph objects are synchronized
 'and when one graph is zoomed and the other not, 
 'True > displays the zoomed area in the other graph 
 'False > does not display the zoomed area in the other graph 
Public Sub setScaleOnZoomedPartOnly(ScaleOnZoomedPartOnly As Boolean)
	Graph.ScaleOnZoomedPartOnly = ScaleOnZoomedPartOnly
End Sub

Public Sub getScaleOnZoomedPartOnly As Boolean
	Return Graph.ScaleOnZoomedPartOnly
End Sub


 'When two xGraph objects are synchronized
 'and when one graph is zoomed and the other not, 
 'True > displays the zoomed area in the other graph 
 'False > does not display the zoomed area in the other graph 
Public Sub setDisplaySynchronizedZoomArea(DisplaySynchronizedZoomArea As Boolean)
	mDisplaySynchronizedZoomArea = DisplaySynchronizedZoomArea
End Sub

Public Sub getDisplaySynchronizedZoomArea As Boolean
	Return mDisplaySynchronizedZoomArea
End Sub

'Sets the xGraph object to Selected or not 
'Selected = True, draws a colored line at the right side.
'Selected = False, removes the colored line
'Used when two xGraph objects are synchronized
'Draws a line at the right side of the graph
Public Sub SelectGraph(Selected As Boolean)
	mSynchGraphSelected = Selected
	If Selected = False Then
		Private rct As B4XRect
		rct.Initialize(xpnlCursor.Width - 3dip, 0, xpnlCursor.Width, xpnlCursor.Height)
		xcvsCursor.ClearRect(RectSelectedFull)
	Else
		xcvsCursor.DrawRect(RectSelected, mSelectedGraphColor, True, 1dip)
	End If
	xcvsCursor.Invalidate
End Sub

Private Sub GetSemiTransparentColor(Alpha As Int, Color As Int) As Int
	Private r, g, b As Int
	
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	Return xui.Color_ARGB(Alpha, r, g, b)
End Sub

'returns white for a dark color or returns black for a light color for a good contrast between background and text colors
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

