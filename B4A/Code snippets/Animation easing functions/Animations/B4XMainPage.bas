B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private SPx(4), SPy(4), SS1, SS2, BPx(4), BPy(4), BPRx(4), BPRy(4) As Double
	Private SPabcd(4) As Double
	Private pnlAnimationInOut, pnlCSplineCoefs, pnlCBezierCoefs As B4XView
	Private pnlDrawing, pnlGraphBackground, pnlGraph, pnlMovement As B4XView
	Private cvsDrawing, cvsGraphBackground, cvsGraph, cvsMovement As B4XCanvas
	Private lblSlope1, lblSlope2 As B4XView
	Private lblBCoefX1, lblBCoefY1, lblBCoefX2, lblBCoefY2 As B4XView
	Private Radius, Position, Position1, Position2 As Int
	Private FrameX0, FrameY0, FrameX1, FrameY1, FrameW, FrameH As Int
	Private AnimationType, AnimationInOut As String
	
	Private PointIndex As Int
	Private Snapped As Boolean
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	cvsDrawing.Initialize(pnlDrawing)
	cvsGraphBackground.Initialize(pnlGraphBackground)
	cvsGraph.Initialize(pnlGraph)
	cvsMovement.Initialize(pnlMovement)
	
	AnimationType = "Linear"
	AnimationInOut = "In"
	
	Radius = pnlDrawing.Height / 2
	Position1 = Radius
	Position2 = pnlDrawing.Width - Radius
	Position = Position1
	DrawCircle(Position1)
	
	GraphInit
	CSplineInit
	CBezierInit
	DrawEasing
End Sub

Private Sub pnlDrawing_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnlDrawing.TOUCH_ACTION_DOWN Then
		If Position = Position1 Then
			Position = Position2
			AnimateTo(Position1, Position2, 1000)
		Else
			Position = Position1
			AnimateTo(Position2, Position1, 1000)
		End If
	End If
End Sub

Private Sub AnimateTo(MoveFrom As Int, MoveTo As Int, Duration As Int)
	Private CurrentPosition As Int
	Private BeginTime As Long = DateTime.Now
	
	CurrentPosition = MoveTo
	Dim tempValueA As Float
	Do While DateTime.Now < BeginTime + Duration
		tempValueA = CallAnimation(DateTime.Now - BeginTime, MoveFrom, MoveTo - MoveFrom, Duration)
'		tempValueA = CubicTimeEaseInOut(DateTime.Now - BeginTime, MoveFrom, MoveTo - MoveFrom, Duration)
		DrawCircle(tempValueA)
		Sleep(5)
		If MoveTo <> CurrentPosition Then Return 'will happen if another update has started
	
		DrawMovingDot(DateTime.Now - BeginTime, Duration)
	Loop
	DrawCircle(CurrentPosition)
	cvsMovement.ClearRect(cvsMovement.TargetRect)
End Sub

Private Sub DrawCircle(x As Int)
	Private r As Int
	
	r = pnlDrawing.Height / 2
	cvsDrawing.DrawRect(cvsDrawing.TargetRect, xui.Color_Blue, True, 1dip)
	cvsDrawing.DrawCircle(x, r, r, xui.Color_Red, True, 1dip)
	cvsDrawing.Invalidate
End Sub

Private Sub CallAnimation(x As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	Dim tempValueA As Float
	
	Select AnimationInOut
		Case "In"
			Select AnimationType
				Case "Linear"
					tempValueA = LinearEase(x, Start, ChangeValue, Duration)
				Case "Quad"
					tempValueA = QuadEaseIn(x, Start, ChangeValue, Duration)
				Case "Cubic"
					tempValueA = CubicEaseIn(x, Start, ChangeValue, Duration)
				Case "Quartic"
					tempValueA = QuarticEaseIn(x, Start, ChangeValue, Duration)
				Case "Quint"
					tempValueA = QuintEaseIn(x, Start, ChangeValue, Duration)
				Case "Sine"
					tempValueA = SineEaseIn(x, Start, ChangeValue, Duration)
				Case "Expo"
					tempValueA = ExpoEaseIn(x, Start, ChangeValue, Duration)
				Case "CSpline"
					tempValueA = CSplineEase(x, Start, ChangeValue, Duration)
				Case "CBezier"
					tempValueA = CBezierEase(x, Start, ChangeValue, Duration)
			End Select
		Case "Out"
			Select AnimationType
				Case "Linear"
					tempValueA = LinearEase(x, Start, ChangeValue, Duration)
				Case "Quad"
					tempValueA = QuadEaseOut(x, Start, ChangeValue, Duration)
				Case "Cubic"
					tempValueA = CubicEaseOut(x, Start, ChangeValue, Duration)
				Case "Quartic"
					tempValueA = QuarticEaseOut(x, Start, ChangeValue, Duration)
				Case "Quint"
					tempValueA = QuintEaseOut(x, Start, ChangeValue, Duration)
				Case "Sine"
					tempValueA = SineEaseOut(x, Start, ChangeValue, Duration)
				Case "Expo"
					tempValueA = ExpoEaseOut(x, Start, ChangeValue, Duration)
				Case "CSpline"
					tempValueA = CSplineEase(x, Start, ChangeValue, Duration)
				Case "CBezier"
					tempValueA = CBezierEase(x, Start, ChangeValue, Duration)
			End Select
		Case "InOut"
			Select AnimationType
				Case "Linear"
					tempValueA = LinearEase(x, Start, ChangeValue, Duration)
				Case "Quad"
					tempValueA = QuadEaseInOut(x, Start, ChangeValue, Duration)
				Case "Cubic"
					tempValueA = CubicEaseInOut(x, Start, ChangeValue, Duration)
				Case "Quartic"
					tempValueA = QuarticEaseInOut(x, Start, ChangeValue, Duration)
				Case "Quint"
					tempValueA = QuintEaseInOut(x, Start, ChangeValue, Duration)
				Case "Sine"
					tempValueA = SineEaseInOut(x, Start, ChangeValue, Duration)
				Case "Expo"
					tempValueA = ExpoEaseInOut(x, Start, ChangeValue, Duration)
				Case "CSpline"
					tempValueA = CSplineEase(x, Start, ChangeValue, Duration)
				Case "CBezier"
					tempValueA = CBezierEase(x, Start, ChangeValue, Duration)
			End Select
	End Select
	Return tempValueA
End Sub

'Linear easing from http://gizma.com/easing/
Private Sub LinearEase(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * (t) + Start
End Sub

'Quad easing in from http://gizma.com/easing/
Private Sub QuadEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * (t * t) + Start
End Sub

'Quad easing out from http://gizma.com/easing/
Private Sub QuadEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = 1 - t
	Return ChangeValue * (1 - t * t) + Start
End Sub

'Quad easing out from http://gizma.com/easing/	???
Private Sub QuadEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t < 0.5 Then
		Return ChangeValue * 2 * t * t + Start
	Else
		t = -2 * t + 2
		Return ChangeValue * (1 - (t * t) / 2) + Start
	End If
End Sub

'Cubic easing out from http://gizma.com/easing/
Private Sub CubicEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * (t * t * t) + Start
End Sub

'Cubic easing out from http://gizma.com/easing/
Private Sub CubicEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = 1 - t
	Return ChangeValue * (1 - (t * t * t)) + Start
End Sub

'Cubic easing out from http://gizma.com/easing/
Private Sub CubicEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t < 0.5 Then
		Return ChangeValue * 4 * t * t * t + Start
	Else
		t = -2 * t + 2
		Return ChangeValue * (1 - (t * t * t) / 2) + Start
	End If
End Sub

'Quartic easing in from http://gizma.com/easing/
Private Sub QuarticEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * (t * t * t * t) + Start
End Sub

'Quartic easing out from http://gizma.com/easing/
Private Sub QuarticEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = 1 - t
	Return ChangeValue * (1 - (t * t * t * t)) + Start
End Sub

'Quartic easing in/out from http://gizma.com/easing/
Private Sub QuarticEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t < 0.5 Then 
		Return ChangeValue * 8 * (t * t * t * t) + Start
	Else
		t = -2 * t + 2
		Return ChangeValue * (1 - (t * t * t * t) / 2) + Start
	End If
End Sub

'Quint easing in from http://gizma.com/easing/
Private Sub QuintEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * t * t * t * t * t + Start
End Sub

'Quint easing out from http://gizma.com/easing/
Private Sub QuintEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = 1 - t
	Return ChangeValue * (1 - t * t * t * t * t) + Start
End Sub

'Quint easing in/out from http://gizma.com/easing/
Private Sub QuintEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t < 0.5 Then
		Return ChangeValue * 16 * t * t * t * t * t + Start
	Else
		t = -2 * t + 2
		Return ChangeValue * (1 - (t * t * t * t * t) / 2) + Start
	End If
End Sub

'Sine easing in from http://gizma.com/easing/
Private Sub SineEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * (1 - Cos(t * cPI / 2)) + Start
End Sub

'Sine easing out from http://gizma.com/easing/
Private Sub SineEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return ChangeValue * Sin(t * cPI / 2) + Start
End Sub

'Sine easing in/out from http://gizma.com/easing/
Private Sub SineEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	Return -ChangeValue * (Cos(t * cPI) - 1) / 2 + Start
End Sub

'Expo easing in from http://gizma.com/easing/
Private Sub ExpoEaseIn(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t = 0 Then
		Return Start
	Else
		t = 10 * t - 10
		Return ChangeValue * Power(2, t) + Start
	End If
End Sub

'Expo easing out from http://gizma.com/easing/
Private Sub ExpoEaseOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = -10 * t
	Return ChangeValue * (1 - Power(2, t)) + Start
End Sub

'Expo easing in/out from http://gizma.com/easing/
Private Sub ExpoEaseInOut(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	If t = 0 Then
		Return Start
	Else If t < 0.5 Then
		t = 20 * t - 10
		Return ChangeValue * Power(2, t) / 2 + Start
	Else
		t = -20 * t + 10
		Return ChangeValue * (2 - Power(2, t)) / 2 + Start
	End If
End Sub

'Cubic spline easing
Private Sub CSplineEase(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	
	Return ChangeValue * (SPabcd(0) * t * t * t + SPabcd(1) * t * t + SPabcd(2) * t) + Start
End Sub

'Cubic Bezier easing
Private Sub CBezierEase(t As Float, Start As Float, ChangeValue As Float, Duration As Int) As Float
	t = t / Duration
	t = CBezierGetTFromX(t)
	Return ChangeValue * (3 * BPRy(1) * (1 - t) * (1 - t) * t + 3 * BPRy(2) * (1 - t) * t * t + t * t * t) + Start
End Sub

#If B4A
Private Sub rbtAnimationInOut_CheckedChange(Checked As Boolean)
	Private rbt As RadioButton
	
	If Checked = True Then
		rbt = Sender
		AnimationInOut = rbt.Tag
			
		DrawEasing
	End If
End Sub

Private Sub rbtAnimationType_CheckedChange(Checked As Boolean)
	Private rbt As RadioButton
	
	If Checked = True Then
		rbt = Sender
		AnimationType = rbt.Tag
		
		pnlAnimationInOut.Visible = False
		pnlCSplineCoefs.Visible = False
		pnlCBezierCoefs.Visible = False
		Select AnimationType
			Case "CSpline"
				pnlCSplineCoefs.Visible = True
			Case "CBezier"
				pnlCBezierCoefs.Visible = True
			Case Else
				pnlAnimationInOut.Visible = True
		End Select
		DrawEasing
	End If

End Sub
#Else If B4J
Private Sub rbtAnimationInOut_SelectedChange(Selected As Boolean)
	Private rbt As RadioButton
	
	If Selected = True Then
		rbt = Sender
		AnimationInOut = rbt.Tag
		
		DrawEasing
	End If
End Sub

Private Sub rbtAnimationType_SelectedChange(Selected As Boolean)
	Private rbt As RadioButton
	
	If Selected = True Then
		rbt = Sender
		AnimationType = rbt.Tag

		pnlAnimationInOut.Visible = False
		pnlCSplineCoefs.Visible = False
		pnlCBezierCoefs.Visible = False
		Select AnimationType
			Case "CSpline"
				pnlCSplineCoefs.Visible = True
			Case "CBezier"
				pnlCBezierCoefs.Visible = True
			Case Else
				pnlAnimationInOut.Visible = True
		End Select
		DrawEasing
	End If
End Sub
#End If

Private Sub pnlGraph_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnlGraph.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	Private Snap As Int
	
	Snap = 10dip
	Select Action
		Case pnlGraph.TOUCH_ACTION_DOWN
			Select AnimationType
				Case "CSpline"
					If x >= SPx(1) - Snap And x <= SPx(1) + Snap And y >= SPy(1) - Snap And y <= SPy(1) + Snap Then
						PointIndex = 1
						Snapped = True
					Else If x >= SPx(2) - Snap And x <= SPx(2) + Snap And y >= SPy(2) - Snap And y <= SPy(2) + Snap Then
						PointIndex = 2
						Snapped = True
					Else
						Snapped = False
					End If
				Case "CBezier"
					If x >= BPx(1) - Snap And x <= BPx(1) + Snap And y >= BPy(1) - Snap And y <= BPy(1) + Snap Then
						PointIndex = 1
						Snapped = True
					Else If x >= BPx(2) - Snap And x <= BPx(2) + Snap And y >= BPy(2) - Snap And y <= BPy(2) + Snap Then
						PointIndex = 2
						Snapped = True
					Else
						Snapped = False
					End If
			End Select
		Case pnlGraph.TOUCH_ACTION_MOVE
			If Snapped = True Then
				Select AnimationType
					Case "CSpline"
						SPx(PointIndex) = Max(FrameX0, Min(x, FrameX1))
						SPy(PointIndex) = Max(FrameY0, Min(y, FrameY1))
						SPabcd = CSplineGetABCD
					Case "CBezier"
						BPx(PointIndex) = Max(FrameX0, Min(x, FrameX1))
						BPy(PointIndex) = Max(FrameY0, Min(y, FrameY1))
						BPRx(PointIndex) = (BPx(PointIndex) - FrameX0) / FrameW
						BPRy(PointIndex) = (FrameY1 - BPy(PointIndex)) / FrameH
						UpdateCBezierCoefs
				End Select
				DrawEasing
				DrawPointsAndLines
			End If
		Case pnlGraph.TOUCH_ACTION_UP
	End Select
End Sub

Private Sub GraphInit
	Private Margin = 10dip As Int
	
	FrameX0 = Margin
	FrameY0 = Margin
	FrameX1 = pnlGraph.Width - Margin
	FrameY1 = pnlGraph.Width - Margin
	FrameW = FrameX1 - FrameX0
	FrameH = FrameY1 - FrameY0
End Sub

Private Sub CSplineInit
	SPx(0) = FrameX0
	SPy(0) = FrameY1
	SPx(1) = FrameX0 + FrameW / 2
	SPy(1) = FrameY1
	SPx(2) = FrameX0 + FrameW / 2
	SPy(2) = FrameY0
	SPx(3) = FrameX1
	SPy(3) = FrameY0
	SPabcd = CSplineGetABCD
End Sub

Private Sub UpdateCSplineCoefs
	lblSlope1.Text = NumberFormat(SS1, 1, 4)
	lblSlope2.Text = NumberFormat(SS2, 1, 4)
End Sub

Private Sub CBezierInit
	BPx(0) = FrameX0
	BPy(0) = FrameY1
	BPx(1) = FrameX0 + FrameW / 2
	BPy(1) = FrameY1
	BPx(2) = FrameX0 + FrameW / 2
	BPy(2) = FrameY0
	BPx(3) = FrameX1
	BPy(3) = FrameY0
	BPRx(1) = 0.5
	BPRy(1) = 0
	BPRx(2) = 0.5
	BPRy(2) = 1
	UpdateCBezierCoefs
'	a = p3 - 3 * p2 + 3 * p1 - p0
'	b = 3 * p2 - 6 * p1 + 3 * p0
'	c = 3 * p1 - 3 * p0
'	d = p0
End Sub

Private Sub UpdateCBezierCoefs
	lblBCoefX1.Text = NumberFormat(BPRx(1), 1, 3)
	lblBCoefY1.Text = NumberFormat(BPRy(1), 1, 3)
	lblBCoefX2.Text = NumberFormat(BPRx(2), 1, 3)
	lblBCoefY2.Text = NumberFormat(BPRy(2), 1, 3)
End Sub

Private Sub CBezierGetTFromX (x0 As Double) As Double
	' https://en.wikipedia.org/wiki/B%C3%A9zier_curve
	Private t, Limit, x As Double
	
	t = x0
	Limit = 0.001
	Do Until Abs(x - x0) < Limit
		x = 3 * BPRx(1) * (1 - t) * (1 - t) * t + 3 * BPRx(2) * (1 - t) * t * t + t * t * t
		If Abs(x - x0) > Limit Then
			If x - x0 > 0 Then
				t = t - t / 2
			Else
				t = t + t / 2
			End If
		End If
	Loop
	Return t
End Sub

'Gets the a, b, c and d coefficients of a cubic spline.
'Given two points and two slopes.
Private Sub CSplineGetABCD As Double()
'	https://math.stackexchange.com/questions/1522439/generalised-formula-For-fitting-a-cubic-between-two-points-with-specified-slopes
	Private Sabcd(4) As Double
	Private m1, m2 As Double
	
	'SP(0) is the first point
	'SP(1) is the point to calculate the slope of the point
	'SP(2) is the point to calculate the slope of the second point
	'SP(3) is the second point
	m1 = (SPy(0) - SPy(1)) / (SPx(1) - SPx(0))
	m2 = (SPy(2) - SPy(3)) / (SPx(3) - SPx(2))
	
	'general equations with two points P1(x1,y1) and P2(x2,y2) and two slopes m1 and m2.
'	Sabcd(0) = (m1 + m2 - 2 * (y2 - y1) / (x2 - x1)) / (x2 - x1) / (x2 - x1)
'	Sabcd(1) = (m2 - m1) / 2 / (x2 - x1) - 3 / 2 * ( x1 + x2) * Sabcd(0)
'	Sabcd(2) = m1 -3 * x1 * x1 * Sabcd(0) - 2 * x1 * Sabcd(1)
'	Sabcd(3) = y1 - x1 * x1 * x1 * Sabcd(0) - x1 * x1 * Sabcd(1) - x1 * Sabcd(2)

	'above equations simplified with x1 = y1 = 0  and x2 = y2 = 1
	Sabcd(0) = m1 + m2 - 2
	Sabcd(1) = (m2 - m1 - 3 * Sabcd(0)) / 2
	Sabcd(2) = m1 
	Sabcd(3) = 0
	
	SS1 = m1
	SS2 = m2
	UpdateCSplineCoefs
	
	Return Sabcd
End Sub

Private Sub DrawEasing
	Private i As Int
	Private n As Int
	Private x0, y0, x1, y1 As Int
	Private dx As Double
	
	Select AnimationType 
		Case "CSpline", "CBezier"
			n = 40
		Case Else
			n = 20
	End Select
	dx = FrameW / n
	cvsGraphBackground.ClearRect(cvsGraph.TargetRect)
	DrawPoint(cvsGraphBackground, FrameX0, FrameY1, xui.Color_Black)
	DrawPoint(cvsGraphBackground, FrameX1, FrameY0, xui.Color_Black)
	x0 = FrameX0
	y0 = FrameY1
	For i = 1 To n
		x1 = FrameX0 + i * dx
		y1 = CallAnimation(i, FrameY1, -FrameH, n)
		cvsGraphBackground.DrawLine(x0, y0, x1, y1, xui.Color_Blue, 1dip)
		x0 = x1
		y0 = y1
	Next
	
	cvsGraph.ClearRect(cvsGraph.TargetRect)
	Select AnimationType
		Case "CSpline", "CBezier"
			DrawPointsAndLines
	End Select
	cvsGraphBackground.Invalidate
End Sub

Private Sub DrawMovingDot(t As Float, Duration As Int)
	Private x, r As Int
	Private y As Float
	
	t = Min(t, Duration)
	cvsMovement.ClearRect(cvsMovement.TargetRect)
	r = 3dip
	x = FrameX0 + t / Duration * FrameW
	y = CallAnimation(t, FrameY1, -FrameH, Duration)
	cvsMovement.DrawCircle(x, y, r, xui.Color_Red, True, 1dip)
	cvsMovement.Invalidate
End Sub

Private Sub DrawPoint(cvs As B4XCanvas, x As Int, y As Int, Color As Int)
	Private rect As B4XRect
	Private dd = 5dip As Int
	rect.Initialize(x - dd, y - dd, x + dd, y + dd)
	cvs.DrawRect(rect, Color, True, 1dip)
End Sub

Private Sub DrawPointsAndLines
	cvsGraph.ClearRect(cvsGraph.TargetRect)
	Select AnimationType
		Case "CSpline"
			DrawPoint(cvsGraph, SPx(1), SPy(1), xui.Color_RGB(0, 128, 0))
			DrawPoint(cvsGraph, SPx(2), SPy(2), xui.Color_Red)
			cvsGraph.DrawLine(SPx(0), SPy(0), SPx(1), SPy(1), xui.Color_RGB(0, 128, 0), 1dip)
			cvsGraph.DrawLine(SPx(2), SPy(2), SPx(3), SPy(3), xui.Color_Red, 1dip)
		Case "CBezier"
			DrawPoint(cvsGraph, BPx(1), BPy(1), xui.Color_RGB(0, 128, 0))
			DrawPoint(cvsGraph, BPx(2), BPy(2), xui.Color_Red)
			cvsGraph.DrawLine(BPx(0), BPy(0), BPx(1), BPy(1), xui.Color_RGB(0, 128, 0), 1dip)
			cvsGraph.DrawLine(BPx(2), BPy(2), BPx(3), BPy(3), xui.Color_Red, 1dip)
	End Select
	cvsGraph.Invalidate
End Sub