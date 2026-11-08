B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@

' Animates the bounds and opacity of an already-mounted native view.
'
' The motion language follows Flutter: the Easing method accepts the
' classic Curves.* names and the recommended durations follow the
' Material 3 motion duration tokens (150ms-300ms for micro-interactions).
Sub Class_Globals
	Private xui As XUI
	Private mView As B4XView
	Private mDuration As Int
	Private mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight As Int
	Private mHasPosition As Boolean
	Private mHasSize As Boolean
	Private mTargetAlpha As Float
	Private mHasAlpha As Boolean
	Private mCurveName As String
	Private mCallbackTarget As Object
	Private mCallbackName As String
	Private mRunId As Int
	Private mRunning As Boolean
End Sub

' Creates a reusable, one-shot animation descriptor.
Public Sub Initialize As UIAnimation
	Cancel
	mView = Null
	mDuration = 240
	mTargetLeft = 0
	mTargetTop = 0
	mTargetWidth = 0
	mTargetHeight = 0
	mHasPosition = False
	mHasSize = False
	mTargetAlpha = 1.0
	mHasAlpha = False
	mCurveName = ""
	mCallbackTarget = Null
	mCallbackName = ""
	Return Me
End Sub

' Selects the native view whose bounds and opacity will be animated.
Public Sub TargetView(View As B4XView) As UIAnimation
	mView = View
	Return Me
End Sub

' Sets the duration in milliseconds. Negative values become zero.
Public Sub Duration(Milliseconds As Int) As UIAnimation
	mDuration = Max(0, Milliseconds)
	Return Me
End Sub

' Sets the destination position while preserving the current size.
Public Sub MoveTo(Left As Int, Top As Int) As UIAnimation
	mTargetLeft = Left
	mTargetTop = Top
	mHasPosition = True
	Return Me
End Sub

' Sets the destination size while preserving the current position.
Public Sub SizeTo(Width As Int, Height As Int) As UIAnimation
	mTargetWidth = Max(0, Width)
	mTargetHeight = Max(0, Height)
	mHasSize = True
	Return Me
End Sub

' Sets both destination position and size.
Public Sub MoveAndResize(Left As Int, Top As Int, Width As Int, Height As Int) As UIAnimation
	MoveTo(Left, Top)
	SizeTo(Width, Height)
	Return Me
End Sub

' Registers Sub EventName with no parameters for successful completion.
Public Sub OnCompleted(Target As Object, EventName As String) As UIAnimation
	mCallbackTarget = Target
	mCallbackName = EventName
	Return Me
End Sub

' Sets the view opacity immediately, without animating.
' This is useful to prepare a staggered entrance before starting fades.
Public Sub SetAlpha(Alpha As Float) As UIAnimation
	ApplyAlpha(ClampAlpha(Alpha))
	Return Me
End Sub

' Sets the target opacity (0.0 to 1.0) applied during the next Start.
Public Sub FadeTo(Alpha As Float) As UIAnimation
	mTargetAlpha = ClampAlpha(Alpha)
	mHasAlpha = True
	Return Me
End Sub

' Convenience: fades to fully visible over the given duration.
Public Sub FadeIn(Milliseconds As Int) As UIAnimation
	Duration(Milliseconds)
	FadeTo(1.0)
	Return Me
End Sub

' Convenience: fades to fully transparent over the given duration.
Public Sub FadeOut(Milliseconds As Int) As UIAnimation
	Duration(Milliseconds)
	FadeTo(0.0)
	Return Me
End Sub

' Selects the Flutter-style curve used to drive the animation.
' Supported names: linear, ease, easeIn, easeOut, easeInOut,
' fastOutSlowIn, easeInQuad, easeOutQuad, easeInCubic, easeOutCubic,
' easeInOutCubic, easeInBack, easeOutBack, easeInOutBack.
' Unknown names fall back to the native Android transition.
Public Sub Easing(Curve As String) As UIAnimation
	mCurveName = Curve.Trim.ToLowerCase
	Return Me
End Sub

' Starts or restarts the animation. A new Start invalidates the previous
' completion callback. Bounds-only animations without an explicit curve
' use the native Android transition; opacity or curve requests are driven
' by a library frame loop so the curve controls bounds and opacity alike.
Public Sub Start As UIAnimation
	If mView = Null Then Return Me
	If mView.IsInitialized = False Then Return Me
	If mHasPosition = False And mHasSize = False And mHasAlpha = False Then Return Me
	If mHasPosition = False Then
		mTargetLeft = mView.Left
		mTargetTop = mView.Top
	End If
	If mHasSize = False Then
		mTargetWidth = mView.Width
		mTargetHeight = mView.Height
	End If
	mRunId = mRunId + 1
	mRunning = True
	Dim currentRun As Int = mRunId
	If mDuration <= 0 Then
		If mHasPosition Or mHasSize Then mView.SetLayoutAnimated(0, mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight)
		If mHasAlpha Then ApplyAlpha(mTargetAlpha)
		FinishRun(currentRun)
	Else If mCurveName.Trim <> "" Or mHasAlpha Then
		RunFrameLoop(currentRun)
	Else
		mView.SetLayoutAnimated(mDuration, mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight)
		WaitForCompletion(currentRun)
	End If
	Return Me
End Sub

' Cancels the native transition at its current bounds and suppresses completion.
Public Sub Cancel As UIAnimation
	mRunId = mRunId + 1
	If mView <> Null Then
		If mView.IsInitialized Then
			mView.SetLayoutAnimated(0, mView.Left, mView.Top, mView.Width, mView.Height)
		End If
	End If
	mRunning = False
	Return Me
End Sub

Public Sub IsRunning As Boolean
	Return mRunning
End Sub

' Steps the animation frame by frame (~10ms per frame) so the selected
' curve drives bounds and opacity with a consistent rhythm. The run id
' keeps Cancel and newer Starts authoritative.
Private Sub RunFrameLoop(RunId As Int) As ResumableSub
	Dim startLeft As Int = mView.Left
	Dim startTop As Int = mView.Top
	Dim startWidth As Int = mView.Width
	Dim startHeight As Int = mView.Height
	Dim startAlpha As Float = 1.0
	If mHasAlpha Then startAlpha = ReadAlpha
	Dim frames As Int = Max(1, mDuration / 10)
	Dim frameDuration As Int = Max(1, mDuration / frames)
	For frame = 1 To frames
		If RunId <> mRunId Or mRunning = False Then Return Null
		Dim t As Float = frame / frames
		Dim eased As Float = CurveValue(mCurveName, t)
		If mHasPosition Or mHasSize Then
			Dim left As Int = Round(startLeft + (mTargetLeft - startLeft) * eased)
			Dim top As Int = Round(startTop + (mTargetTop - startTop) * eased)
			Dim width As Int = Round(startWidth + (mTargetWidth - startWidth) * eased)
			Dim height As Int = Round(startHeight + (mTargetHeight - startHeight) * eased)
			Try
				mView.SetLayoutAnimated(0, left, top, width, height)
			Catch
				Cancel
				Return Null
			End Try
		End If
		If mHasAlpha Then ApplyAlpha(startAlpha + (mTargetAlpha - startAlpha) * eased)
		Sleep(frameDuration)
	Next
	If RunId <> mRunId Or mRunning = False Then Return Null
	If mHasPosition Or mHasSize Then
		mView.SetLayoutAnimated(0, mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight)
	End If
	If mHasAlpha Then ApplyAlpha(mTargetAlpha)
	FinishRun(RunId)
	Return Null
End Sub

Private Sub FinishRun(RunId As Int)
	If RunId <> mRunId Or mRunning = False Then Return
	mRunning = False
	If mCallbackTarget = Null Then Return
	If mCallbackName.Trim = "" Then Return
	If SubExists(mCallbackTarget, mCallbackName) Then CallSub(mCallbackTarget, mCallbackName)
End Sub

' Sleep(0) keeps zero-duration completion on the same asynchronous path.
Private Sub WaitForCompletion(RunId As Int)
	Sleep(mDuration)
	FinishRun(RunId)
End Sub

' ===== Flutter curve evaluation =====
' The named curves replicate Flutter's Curves.* cubic-beziers with the
' leading point at (0,0) and the trailing point at (1,1).
Private Sub CurveValue(Name As String, T As Float) As Float
	Select Case Name
		Case "linear"
			Return T
		Case "ease"
			Return CubicBezier(T, 0.25, 0.1, 0.25, 1.0)
		Case "easein"
			Return CubicBezier(T, 0.42, 0.0, 1.0, 1.0)
		Case "easeout"
			Return CubicBezier(T, 0.0, 0.0, 0.58, 1.0)
		Case "easeinout"
			Return CubicBezier(T, 0.42, 0.0, 0.58, 1.0)
		Case "fastoutslowin"
			Return CubicBezier(T, 0.4, 0.0, 0.2, 1.0)
		Case "easeinquad"
			Return CubicBezier(T, 0.11, 0.0, 0.5, 0.0)
		Case "easeoutquad"
			Return CubicBezier(T, 0.5, 1.0, 0.25, 1.0)
		Case "easeincubic"
			Return CubicBezier(T, 0.32, 0.0, 0.67, 0.0)
		Case "easeoutcubic"
			Return CubicBezier(T, 0.33, 1.0, 0.68, 1.0)
		Case "easeinoutcubic"
			Return CubicBezier(T, 0.65, 0.0, 0.35, 1.0)
		Case "easeinback"
			Return CubicBezier(T, 0.6, -0.28, 0.735, 0.045)
		Case "easeoutback"
			Return CubicBezier(T, 0.175, 0.885, 0.32, 1.275)
		Case "easeinoutback"
			Return CubicBezier(T, 0.68, -0.6, 0.32, 1.6)
	End Select
	Return T
End Sub

' Evaluates Cubic(x1, y1, x2, y2) at T. The x(t) polynomial is inverted
' with Newton iterations; a failed or flat solve degrades to linear.
Private Sub CubicBezier(T As Float, X1 As Float, Y1 As Float, X2 As Float, Y2 As Float) As Float
	Dim t As Float = T
	For i = 1 To 10
		Dim x As Float = BezierComponent(t, X1, X2)
		Dim dx As Float = BezierDerivative(t, X1, X2)
		If Abs(dx) < 0.00001 Then Exit
		Dim nextT As Float = t - (x - T) / dx
		If nextT < 0 Then nextT = 0
		If nextT > 1 Then nextT = 1
		If Abs(nextT - t) < 0.00001 Then
			t = nextT
			Exit
		End If
		t = nextT
	Next
	Return BezierComponent(t, Y1, Y2)
End Sub

Private Sub BezierComponent(T As Float, Control1 As Float, Control2 As Float) As Float
	Dim u As Float = 1 - T
	Return 3 * u * u * T * Control1 + 3 * u * T * T * Control2 + T * T * T
End Sub

Private Sub BezierDerivative(T As Float, Control1 As Float, Control2 As Float) As Float
	Dim u As Float = 1 - T
	Return 3 * u * u * Control1 + 6 * u * T * (Control2 - Control1) + 3 * T * T * (1 - Control2)
End Sub

' ===== Native opacity access =====
' Android views expose alpha through View.setAlpha(View.getAlpha). The
' library uses JavaObject here, the same way other widgets reach native
' drawables, so application code never leaves the declarative API.
Private Sub ApplyAlpha(Alpha As Float)
	If mView = Null Then Return
	If mView.IsInitialized = False Then Return
	Dim native As JavaObject = mView
	native.RunMethod("setAlpha", Array(Alpha))
End Sub

Private Sub ReadAlpha As Float
	If mView = Null Then Return 1.0
	If mView.IsInitialized = False Then Return 1.0
	Try
		Dim native As JavaObject = mView
		Return native.RunMethod("getAlpha", Null)
	Catch
		Return 1.0
	End Try
End Sub

Private Sub ClampAlpha(Value As Float) As Float
	If Value < 0 Then Return 0
	If Value > 1 Then Return 1
	Return Value
End Sub
