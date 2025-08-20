B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#Event: StateChanged (Open As Boolean)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Private mSideWidth As Int
	Private mLeftPanel As B4XView
	Private mDarkPanel As B4XView
	Private mBasePanel As B4XView
	Private mCenterPanel As B4XView
	Public ExtraWidth As Int = 50dip
	Private TouchXStart, TouchYStart As Float 'ignore
	Private IsOpen As Boolean
	Private HandlingSwipe As Boolean
	Private StartAtScrim As Boolean 'ignore
	Private mEnabled As Boolean = True
End Sub

Public Sub Initialize (Callback As Object, EventName As String, Parent As B4XView, SideWidth As Int)
	mEventName = EventName
	mCallBack = Callback
	mSideWidth = SideWidth
	#if B4A
	Dim creator As TouchPanelCreator
	mBasePanel = creator.CreateTouchPanel("base")
	#else if B4i
	mBasePanel = xui.CreatePanel("")
	Dim nme As NativeObject = Me
	Dim no As NativeObject = mBasePanel
	no.RunMethod("addGestureRecognizer:", Array(nme.RunMethod("CreateRecognizer", Null)))
	#Else If B4J
	mBasePanel = xui.CreatePanel("")
	#End If
	Parent.AddView(mBasePanel, 0, 0, Parent.Width, Parent.Height)
	mCenterPanel = xui.CreatePanel("")
	mBasePanel.AddView(mCenterPanel, 0, 0, mBasePanel.Width, mBasePanel.Height)
	mDarkPanel = xui.CreatePanel("dark")
	mBasePanel.AddView(mDarkPanel, 0, 0, mBasePanel.Width, mBasePanel.Height)
	mLeftPanel = xui.CreatePanel("LeftPanel")
	mBasePanel.AddView(mLeftPanel, -SideWidth, 0, SideWidth, mBasePanel.Height)
	mLeftPanel.Color = xui.Color_Red
	#if B4A
	Dim p As Panel = mLeftPanel
	p.Elevation = 4dip
	#Else If B4i
	Dim p As Panel = mDarkPanel
	p.UserInteractionEnabled = False
	p.SetBorder(0, 0, 0)
	p = mLeftPanel
	p = mCenterPanel
	p.SetBorder(0, 0, 0)
	p = mBasePanel
	p.SetBorder(0, 0, 0)
	#Else If B4J
	Private jo = mDarkPanel As JavaObject
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
End Sub

Private Sub LeftPanel_Click
	
End Sub

#if B4A

Private Sub Base_OnTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If mEnabled = False Then Return False
	Dim LeftPanelRightSide As Int = mLeftPanel.Left + mLeftPanel.Width
	If HandlingSwipe = False And x > LeftPanelRightSide Then
		If IsOpen Then
			TouchXStart = X
			If Action = mBasePanel.TOUCH_ACTION_UP Then setLeftOpen(False)
			Return True
		End If
		If IsOpen = False And x > LeftPanelRightSide + ExtraWidth Then
			Return False
		End If
	End If
	Select Action
		Case mBasePanel.TOUCH_ACTION_MOVE
			Dim dx As Float = x - TouchXStart
			TouchXStart = X
			If HandlingSwipe Or Abs(dx) > 3dip Then
				HandlingSwipe = True
				ChangeOffset(mLeftPanel.Left + dx, True, False)
			End If
		Case mBasePanel.TOUCH_ACTION_UP
			If HandlingSwipe Then
				ChangeOffset(mLeftPanel.Left, False, False)
			End If
			HandlingSwipe = False
	End Select
	Return True
End Sub

'Return True to "steal" the event from the child views
Private Sub Base_OnInterceptTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If mEnabled = False Then Return False
	If IsOpen = False And x > mLeftPanel.Left + mLeftPanel.Width + ExtraWidth Then Return False
	If IsOpen And x > mLeftPanel.Left + mLeftPanel.Width Then
		'handle all touch events right of the opened side menu
		Return True
	End If
	If HandlingSwipe Then Return True
	Select Action
		Case mBasePanel.TOUCH_ACTION_DOWN
			TouchXStart = X
			TouchYStart = Y
			HandlingSwipe = False
		Case mBasePanel.TOUCH_ACTION_MOVE
			Dim dx As Float = Abs(x - TouchXStart)
			Dim dy As Float = Abs(y - TouchYStart)
			If dy < 20dip And dx > 10dip Then
				HandlingSwipe = True
			End If
	End Select
	Return HandlingSwipe
End Sub
#End If

#if B4i
Private Sub Pan_Event (pan As Object)
	Dim rec As NativeObject = pan
	Dim points() As Float = rec.ArrayFromPoint(rec.RunMethod("locationInView:", Array(mBasePanel)))
	Dim x As Float = points(0)
	Dim state As Int = rec.GetField("state").AsNumber
	Dim LeftPanelRightSide As Int = mLeftPanel.Left + mLeftPanel.Width
	Select state
		Case 1 'began
			If mEnabled = False Then
				CancelGesture(rec)
				Return
			End If
			If x > LeftPanelRightSide Then
				If IsOpen = False And x > LeftPanelRightSide + ExtraWidth Then
					CancelGesture(rec)
					HandlingSwipe = False
					Return
				End If
			End If
			StartAtScrim = x > LeftPanelRightSide
			HandlingSwipe = True
			TouchXStart = x
		Case 2 'changed
			If mLeftPanel.Left < 0 Or x <= LeftPanelRightSide Then
				Dim dx As Float = x - TouchXStart
				ChangeOffset(mLeftPanel.Left + dx, True, False)
				StartAtScrim = False
			End If
			TouchXStart = X
		Case 3
			HandlingSwipe = False
			If IsOpen And StartAtScrim And x > LeftPanelRightSide Then
				setLeftOpen(False)
			Else
				ChangeOffset(mLeftPanel.Left, False, False)
			End If
	End Select
End Sub

Private Sub CancelGesture (rec As NativeObject)
	rec.SetField("enabled", False)
	rec.SetField("enabled", True)
End Sub
#end if
#if B4i or B4J
Private Sub Dark_Touch(Action As Int, X As Float, Y As Float)
	If HandlingSwipe = False And Action = mDarkPanel.TOUCH_ACTION_UP Then
		 setLeftOpen(False)
	End If
End Sub
#end if


Private Sub ChangeOffset (x As Float, CurrentlyTouching As Boolean, NoAnimation As Boolean)
	x = Max(-mSideWidth, Min(0, x))
	Dim VisibleOffset As Int = mSideWidth + x
	#if B4i
	Dim p As Panel = getLeftPanel
	If mLeftPanel.Left = -mSideWidth And x > -mSideWidth Then
		p.SetShadow(xui.Color_Black, 2, 0, 0.5, True)
	Else If x = -mSideWidth Then
		p.SetShadow(0, 0, 0, 0, True)
	End If
	#End If
	If CurrentlyTouching = False Then
		If (IsOpen And VisibleOffset < 0.8 * mSideWidth) Or (IsOpen = False And VisibleOffset < 0.2 * mSideWidth) Then
			x = -mSideWidth
			SetIsOpen(False)
		Else
			x = 0
			SetIsOpen(True)
		End If
		Dim dx As Int = Abs(mLeftPanel.Left - x)
		Dim duration As Int = Max(0, 200 * dx / mSideWidth)
		If NoAnimation Then duration = 0
		mLeftPanel.SetLayoutAnimated(duration, x, 0, mLeftPanel.Width, mLeftPanel.Height)
		mDarkPanel.SetColorAnimated(duration, mDarkPanel.Color, OffsetToColor(x))
		#if B4i
		Dim p As Panel = mDarkPanel
		p.UserInteractionEnabled = IsOpen
		p = getLeftPanel
		#Else If B4J
		Private jo = mDarkPanel As JavaObject
		jo.RunMethod("setMouseTransparent", Array(Not(IsOpen)))
		#End If
	Else
		mDarkPanel.Color = OffsetToColor(x)
		mLeftPanel.Left = x
	End If
End Sub

Private Sub SetIsOpen (NewState As Boolean)
	If IsOpen = NewState Then Return
	IsOpen = NewState
	If xui.SubExists(mCallBack, mEventName & "_StateChanged", 1) Then
		CallSubDelayed2(mCallBack,  mEventName & "_StateChanged", IsOpen)
	End If
End Sub

Private Sub OffsetToColor (x As Int) As Int
	Dim Visible As Float = (mSideWidth + x) / mSideWidth
	Return xui.Color_ARGB(100 * Visible, 0, 0, 0)
End Sub

Public Sub getLeftOpen As Boolean
	Return IsOpen
End Sub

Public Sub setLeftOpen (b As Boolean)
	If b = IsOpen Then Return
	Dim x As Float
	If b Then x = 0 Else x = -mSideWidth
	ChangeOffset(x, False, False)
End Sub

Public Sub getLeftPanel As B4XView
	Return mLeftPanel
End Sub

Public Sub getCenterPanel As B4XView
	Return mCenterPanel
End Sub

Public Sub Resize(Width As Int, Height As Int)
	If IsOpen Then ChangeOffset(-mSideWidth, False, True)
	mBasePanel.SetLayoutAnimated(0, 0, 0, Width, Height)
	mLeftPanel.SetLayoutAnimated(0, mLeftPanel.Left, 0, mLeftPanel.Width, mBasePanel.Height)
	mDarkPanel.SetLayoutAnimated(0, 0, 0, Width, Height)
	mCenterPanel.SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub

Public Sub getGestureEnabled As Boolean
	Return mEnabled
End Sub

Public Sub setGestureEnabled (b As Boolean)
	mEnabled = b
End Sub

#if OBJC
- (NSObject*) CreateRecognizer{
 	 UIPanGestureRecognizer *rec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [rec setMinimumNumberOfTouches:1];
    [rec setMaximumNumberOfTouches:1];
	return rec;
}
-(void) action:(UIPanGestureRecognizer*)rec {
	[self.bi raiseEvent:nil event:@"pan_event:" params:@[rec]];
}
#End If



