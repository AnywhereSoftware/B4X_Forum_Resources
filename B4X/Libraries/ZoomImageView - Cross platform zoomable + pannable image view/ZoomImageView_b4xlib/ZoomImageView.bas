B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
#Event: Click
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public ImageView As B4XView
	Private pnl As B4XView
	Public pnlBackground As B4XView
	Private IVOffsetX, IVOffsetY As Float
	Private ImageRatio As Float
	#if B4A
	Private ScaleDetector As JavaObject
	Private PrevSpan As Float
	#Else If B4i
	Private PreNumberOfTouches As Int
	#End If
	Private TouchDown As Boolean
	Private StartLeft, StartTop, StartX, StartY As Int
	Public ClickThreshold As Int = 200
	Private ClickStart As Long
	Private DisableClickEvent As Boolean 'ignore
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	pnlBackground = xui.CreatePanel("")
	mBase.SetColorAndBorder(mBase.Color, 0, 0, 0)
	Dim IV As ImageView
	IV.Initialize("")
	ImageView = IV
	pnl = xui.CreatePanel("pnl")
	mBase.AddView(pnl, 0, 0, mBase.Width, mBase.Height)
	pnl.AddView(pnlBackground, 0, 0, mBase.Width, mBase.Height)
	pnlBackground.AddView(ImageView, 0, 0, mBase.Width, mBase.Height)
	#if B4J
	Dim jo As JavaObject = pnl
	Dim ScrollEvent As JavaObject = jo.CreateEventFromUI("javafx.event.EventHandler", "ScrollChanged", Null)
	jo.RunMethod("setOnScroll", Array(ScrollEvent))
	#Else If B4A
	Dim jo As JavaObject = pnl
	Dim TouchListener As Object = jo.CreateEvent("android.view.View$OnTouchListener", "TouchListener", False)
	jo.RunMethod("setOnTouchListener", Array(TouchListener))
	Dim ScaleListener As Object = jo.CreateEventFromUI("android.view.ScaleGestureDetector$OnScaleGestureListener", "ScaleListener", True)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ScaleDetector.InitializeNewInstance("android.view.ScaleGestureDetector", Array(ctxt, ScaleListener))
	Dim version As JavaObject
	Dim sdk As Int = version.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")
	If sdk >= 19 Then
		ScaleDetector.RunMethod("setQuickScaleEnabled", Array(False))
	End If
	#Else If B4i
	Dim nme As NativeObject = Me
	Dim no As NativeObject = pnl
	no.RunMethod("addGestureRecognizer:", Array(nme.RunMethod("CreateRecognizer", Null)))
	#end if
End Sub

#if B4J
Private Sub ScrollChanged_Event (MethodName As String, Args() As Object) As Object
	If MethodName = "handle" Then
		Dim ev As JavaObject = Args(0)
		Dim delta As Float = ev.RunMethod("getDeltaY", Null)
		Dim Zoom As Float
		If delta > 0 Then
			Zoom = 1.1
		Else
			Zoom = 0.9
		End If
		ZoomChanged(ev.RunMethod("getX", Null), ev.RunMethod("getY", Null), Zoom)
	End If
	Return Null
End Sub
#end if

Public Sub SetBitmap(bmp As B4XBitmap)
	If bmp.IsInitialized = False Then
		ImageView.SetBitmap(Null)
		Return
	Else
		ImageView.SetBitmap(bmp)
	End If
	#if B4A
	Dim iv As ImageView = ImageView
	iv.Gravity = Gravity.FILL
	#End If
	ImageRatio = bmp.Width / bmp.Height
	Reset
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	Reset
End Sub

Private Sub Reset
	pnlBackground.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	If ImageView.GetBitmap.IsInitialized Then
		Dim ContainerWidth As Int = mBase.Width
		Dim ContainerHeight As Int = mBase.Height
		Dim ivr As Float = ContainerWidth / ContainerHeight
		If ImageRatio > ivr Then
			IVOffsetX = 0
			IVOffsetY = (ContainerHeight - 1 / ImageRatio * ContainerWidth) / 2 / ContainerHeight
		Else
			IVOffsetY = 0
			IVOffsetX = (ContainerWidth - ImageRatio * ContainerHeight) / 2 / ContainerWidth
		End If
		Dim left As Int = pnlBackground.Width * IVOffsetX
		Dim top As Int = pnlBackground.Height * IVOffsetY
		ImageView.SetLayoutAnimated(0, left, top, pnlBackground.Width - 2 * left, pnlBackground.Height - 2 * top)
	Else
		ImageView.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Width)
	End If
End Sub

#if B4A
Private Sub TouchListener_Event (MethodName As String, Args() As Object) As Object
	if MethodName <> "onTouch" Then Return Null
	Dim MotionEvent As JavaObject = Args(1)
	If 1 = MotionEvent.RunMethod("getPointerCount", Null) Then
		Dim action As Int = MotionEvent.RunMethod("getAction", Null)
		If action = 0 Then ClickStart = DateTime.Now
		pnl_Touch(action, MotionEvent.RunMethod("getX", Null), MotionEvent.RunMethod("getY", Null))
	End If
	ScaleDetector.RunMethod("onTouchEvent", Array(MotionEvent))
	Return True
End Sub

Private Sub ScaleListener_Event (MethodName As String, Args() As Object) As Object
	Dim ScaleGestureDetector As JavaObject = Args(0)
	If ScaleGestureDetector.RunMethod("isInProgress", Null) = False Then
		Return True
	End If
	TouchDown = False
	Dim x As Float = ScaleGestureDetector.RunMethod("getFocusX", Null)
	Dim y As Float = ScaleGestureDetector.RunMethod("getFocusY", Null)
	Dim currentspan As Float = ScaleGestureDetector.RunMethod("getCurrentSpan", Null)
	If MethodName = "onScaleBegin" Then
		PrevSpan = currentspan
		pnl_Touch(pnl.TOUCH_ACTION_DOWN, x, y)
		Return True
	Else If MethodName = "onScaleEnd" Or currentspan = 0 Then
		Return True
	End If
	Dim delta As Float = Power(currentspan / PrevSpan, 2)
	PrevSpan = currentspan
	ZoomChanged(x, y, delta)
	Return True
End Sub
#else if B4i
Private Sub Pinch_Event (Pinch As Object)
	Dim rec As NativeObject = Pinch
	Dim points() As Float = rec.ArrayFromPoint(rec.RunMethod("locationInView:", Array(pnl)))
	Dim x As Float = points(0)
	Dim y As Float = points(1)
	Dim scale As Float = rec.GetField("scale").AsNumber
	Dim NumberOfTouches As Int = rec.GetField("numberOfTouches").AsNumber
	rec.SetField("scale", 1)
	Dim state As Int = rec.GetField("state").AsNumber
	Select state
		Case 1 'began
			DisableClickEvent = True
		Case 2 'changed
			If scale <> 1 Then
				ZoomChanged(x, y, scale)
			Else if NumberOfTouches = 1 Then
				If PreNumberOfTouches <> 1 Then
					pnl_Touch(pnl.TOUCH_ACTION_DOWN, x, y)
				Else
					pnl_Touch(pnl.TOUCH_ACTION_MOVE, x, y)
				End If
			End If
		Case 3
			DisableClickEvent = False
	End Select
	PreNumberOfTouches = NumberOfTouches
End Sub
#End If


Private Sub ZoomChanged (x As Int, y As Int, ZoomDelta As Float)
	Dim ivx As Float = x - pnlBackground.Left
	Dim ivy As Float = y - pnlBackground.Top
	ZoomDelta = Max(ZoomDelta, mBase.Width / pnlBackground.Width)
	pnlBackground.SetLayoutAnimated(0, x - ivx * ZoomDelta, y - ivy * ZoomDelta, pnlBackground.Width * ZoomDelta, pnlBackground.Height * ZoomDelta)
	SetImageViewLayout
End Sub

Private Sub pnl_Touch (Action As Int, X1 As Float, Y1 As Float)
	If Action = pnl.TOUCH_ACTION_DOWN Or TouchDown = False Then
		StartLeft = pnlBackground.Left
		StartTop = pnlBackground.Top
		StartX = X1
		StartY = Y1
		TouchDown = True
		If xui.IsB4A = False Then ClickStart = DateTime.Now
	Else If Action = pnl.TOUCH_ACTION_MOVE And TouchDown Then
		pnlBackground.Left = Min(0.5 * mBase.Width, StartLeft + 1.2 * (X1 - StartX))
		pnlBackground.Left = Max(-(pnlBackground.Width - 0.5 * mBase.Width), pnlBackground.Left)
		pnlBackground.Top = Min(0.5 * mBase.Height, StartTop + 1.2 * (Y1 - StartY))
		pnlBackground.Top = Max(-(pnlBackground.Height - 0.5 * mBase.Height), pnlBackground.Top)
		SetImageViewLayout
	Else if Action = pnl.TOUCH_ACTION_UP Then
		TouchDown = False
		If DateTime.Now - ClickStart < ClickThreshold And DisableClickEvent = False Then
			If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
				CallSub(mCallBack, mEventName & "_Click")
			End If
		End If
	Else
		'Log("touch cancelled")
	End If
End Sub

Private Sub SetImageViewLayout
	Dim left As Int = pnlBackground.Width * IVOffsetX
	Dim top As Int = pnlBackground.Height * IVOffsetY
	ImageView.SetLayoutAnimated(0, left, top, pnlBackground.Width - 2 * left, pnlBackground.Height - 2 * top)
End Sub

#if OBJC
- (NSObject*) CreateRecognizer{
 	 UIPinchGestureRecognizer  *rec = [[UIPinchGestureRecognizer  alloc] initWithTarget:self action:@selector(action:)];
	return rec;
}
-(void) action:(UIPanGestureRecognizer*)rec {
	[self.bi raiseEvent:nil event:@"pinch_event:" params:@[rec]];
}
#End If