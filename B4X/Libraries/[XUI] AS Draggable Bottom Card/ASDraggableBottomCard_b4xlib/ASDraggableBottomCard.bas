B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@

#If Documentation
Updates
V1.00
	-Release
V1.01
	-Various bug fixes and improvements
	-The menu no longer closes when the last swipe went up, so it is now possible for the user to cancel a full close
V1.02
	-Add CornerRadius_Header - sets the CornerRadius of the header
		-dont use asdbc_main.HeaderPanel.Height if your set the corner radius, the returning height is not the display height
		-use HeaderHeight instead
	-Add HeaderHeight - gets the displayed header height
	-Supports now B4J
V1.03
	-Add set FirstHeight - sets the FirstHeight - The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the first height
	-Add set SecondHeight - sets the SecondHeight - The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the second height
	-Important BugFixes!
V1.04
	-BugFix on Drag with finger - much more better experience now!
V1.05
	-Add get IsOpenHalf - Returns True if the view is half expanded
	-Add get IsOpenFull - Returns True if the view is full expanded
	-Add IsDraggable - set it to false to disable touch gestures on header
	-Add some property descriptions
V1.06
	-B4I and B4J - Body can now be dragged too
V1.07
	-BugFixes
	-Significant handling improvements when working with 2 heights
V1.08
	-Add get DarkPanel
	-Add DarkPanelClickable - If false then does the menu not close when you click on the dark area
		-Default: True
V1.09
	-Add UserCanClose - If False then the user can expand the menu, but not close
V1.10
	-Add set and get BodyDrag - Call it before "Create"
		-If True then you can drag the body too
		-Not working if a list is in the body
	-BugFixes
V1.11
	-Add BodyDragPanel
V1.12
	-B4I only remove GestureRecognizer
V1.13
	-Add get and set HeaderPanel
	-Add get and set BodyPanel
V1.14
	-B4J BugFix
V1.15
	-B4I Improvements - the entire screen is now used for the background shadow
		-When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
		-The height of the area is now determined and the gap closed
		-B4XPages is now required in B4I
V1.16
	-BugFix
V1.17
	-BugFixes and Improvements
	-Change - The menu now has the DarkPanel as parent and no longer the root page
		-You don't notice it in use
		-This allows you to add custom views to the DarkPanel and these are then above the BodyPanel and do not have to work on the root form
	-New get and set BottomOffset - A value to display the menu above the keyboard, for example, if you set the value to the keyboard height
		-Default: 0
	-Change The corner radius is now only applied to the top corners
V1.18
	-New ShowCustom - You have to extend the menu manually
		-The Open Event is triggered and the DarkPanel becomes visible
#End If

#Event: Opened
#Event: Closed
#Event: Open
#Event: Close
#Event: VisibleBodyHeightChanged (height as double)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	'Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private mDarkPanel As B4XView
	Private xpnl_Parent As B4XView
	
	Private downy As Float
	Private old_top As Float
	
	Private g_first_height,g_second_height,g_width,g_header_height As Float
	Private g_orientation As Int
	
	Public g_show_duration As Int = 250
	Public g_hide_duration As Int = 700
	Private g_darkpanel_alpha As Int = 165
	Private g_IsDraggable As Boolean = True
	Private mDarkPanelClickable As Boolean = True
	Private mUserCanClose As Boolean = True
	'Private g_BodyDraggable As Boolean = False
	Private m_TopBarOffset As Float = 0
	Private m_BottomOffset As Float = 0
	
	Private m_BodyDrag As Boolean = False
	Private expand_state As Int = 0
	
	Private disable_touch As Boolean = False
	
	Private last_swipe2top As Boolean = False
	Private inClosingProcess As Boolean = False
	
	'Private CornerRadius As Float = 10dip
	
	'Views
	Private xpnl_CardBase As B4XView
	Private xpnl_CardHeader As B4XView
	Private xpnl_CardBody As B4XView
	
	#If B4I 
'	Private gr_Header As GestureRecognizer
'	Private gr_Body As GestureRecognizer
	Private nome As NativeObject=Me
	Private mView As View'ignore
	Private mView2 As View'ignore
	#end if
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub Create (Parent As B4XView,first_height As Float,second_height As Float,header_height As Float,width As Float,orientation As Int)
	'mBase = Base
	g_first_height = first_height
	g_second_height = second_height
	g_width = width
	g_orientation = orientation
	g_header_height = header_height
	xpnl_Parent = Parent
	ini_views(Parent)

	#if B4A
	Base_Resize(Parent.Width,Parent.Height)
	Private r As Reflector
	r.Target = xpnl_CardBase
	r.SetOnTouchListener("xpnl_CardHeader_Touch2")
	#Else IF B4I	
	'gr_Header.Initialize("tmp",Me,xpnl_CardHeader)
	'gr_Header.AddPanGesture(1,2)
	
	AddPanGesture(1,2)
	
'	If m_BodyDrag Then
'		gr_Body.Initialize("tmpBody",Me,xpnl_CardBody)
'		gr_Body.AddPanGesture(1,2)
'	End If
	#End If
	Base_Resize(Parent.Width,Parent.Height)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
  Dim tmp_left As Float = 0
	If g_orientation = Orientation_MIDDLE Then
		tmp_left = Width/2 - g_width/2
		Else If g_orientation = Orientation_RIGHT Then
			tmp_left = Width - g_width
	End If
  
	mDarkPanel.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_CardBase.SetLayoutAnimated(0,tmp_left,Height + g_first_height,g_width,g_first_height + g_header_height)
	
	xpnl_CardHeader.SetLayoutAnimated(0,0,0,g_width,g_header_height)
	
	xpnl_CardBody.SetLayoutAnimated(0,0,g_header_height,g_width,g_first_height)
	
	'VisibleBodyHeightChanged
	'xpnl_CardHeader.Color = xui.Color_Green
	'xpnl_CardBody.Color = xui.Color_Blue
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
	Dim jo As JavaObject = pnl
	Dim shape As JavaObject
	Dim cx As Double = pnl.Width
	Dim cy As Double = pnl.Height * 2
	shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
	If radius > 0 Then
		Dim d As Double = radius
		shape.RunMethod("setArcHeight", Array(d))
		shape.RunMethod("setArcWidth", Array(d))
	End If
	jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
#end if
End Sub

Private Sub ini_views(Parent As B4XView)
	xpnl_CardBase = xui.CreatePanel("xpnl_CardBase")
	xpnl_CardHeader = xui.CreatePanel("xpnl_header")
	xpnl_CardBody = xui.CreatePanel("")
	mDarkPanel = xui.CreatePanel("mDarkPanel")
	
'	Parent.AddView(mDarkPanel,0,0,0,0) 'Old
'	Parent.AddView(xpnl_CardBase,0,0,0,0)

	Parent.AddView(mDarkPanel,0,0,Parent.Width,Parent.Height) 'New
	mDarkPanel.AddView(xpnl_CardBase,0,0,0,0)

	xpnl_CardBase.AddView(xpnl_CardHeader,0,0,0,0)
	xpnl_CardBase.AddView(xpnl_CardBody,0,0,0,0)
	'xpnl_CardBase.Color = xui.Color_Red
	mDarkPanel.Color = xui.Color_ARGB(g_darkpanel_alpha,0,0,0)
	mDarkPanel.Visible = False
End Sub

Public Sub Show(ignore_event As Boolean)
	ShowIntern(ignore_event,False)
End Sub

'The Open Event is triggered and the DarkPanel becomes visible
'You have to extend the menu manually
'<code>
'	BottomCard.ShowCustom
'	BottomCard.CardBase.SetLayoutAnimated(250,0,BottomCard.DarkPanel.Height - 400dip,BottomCard.DarkPanel.Width,400dip)
'</code>
Public Sub ShowCustom
	
	If xui.SubExists(mCallBack,mEventName & "_Open",0) Then
		CallSub(mCallBack,mEventName & "_Open")
	End If
	
	#If B4I
	m_TopBarOffset = B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).RootPanel.Top
	#End If
	
	mDarkPanel.SetLayoutAnimated(0,0,-m_TopBarOffset,xpnl_Parent.Width,xpnl_Parent.Height + m_TopBarOffset)
	mDarkPanel.Enabled = True
	If mDarkPanel.Visible = False Then
		mDarkPanel.SetVisibleAnimated(g_show_duration,True)
	End If
	
End Sub

Private Sub ShowIntern(ignore_event As Boolean,fromtouch As Boolean)
	'xpnl_CardBase.Visible = True
	If xui.SubExists(mCallBack,mEventName & "_Open",0) Then
		CallSub(mCallBack,mEventName & "_Open")
	End If
	
	#If B4I
	m_TopBarOffset = B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).RootPanel.Top
	#End If
	
	mDarkPanel.SetLayoutAnimated(0,0,-m_TopBarOffset,xpnl_Parent.Width,xpnl_Parent.Height + m_TopBarOffset)
	mDarkPanel.Enabled = True
	If mDarkPanel.Visible = False Then
		mDarkPanel.SetVisibleAnimated(g_show_duration,True)
	End If
	disable_touch = True
	If expand_state = 1 Then
		xpnl_CardBase.Height = g_second_height + g_header_height
		xpnl_CardBase.SetLayoutAnimated(g_show_duration,xpnl_CardBase.Left,mDarkPanel.Height - g_first_height - g_header_height - m_BottomOffset,g_width,g_second_height + g_header_height + m_BottomOffset)
		xpnl_CardBody.Height = g_second_height
		Sleep(g_show_duration)
		xpnl_CardBase.Height = g_first_height + g_header_height + m_BottomOffset
		xpnl_CardBody.Height = g_first_height
		VisibleBodyHeightChanged
	Else
		xpnl_CardBase.Height = g_second_height + g_header_height + m_BottomOffset
		xpnl_CardBase.SetLayoutAnimated(g_show_duration,xpnl_CardBase.Left,mDarkPanel.Height - g_second_height - g_header_height  - m_BottomOffset,g_width,g_second_height + g_header_height + m_BottomOffset)
		xpnl_CardBody.Height = g_second_height
		VisibleBodyHeightChanged
		If fromtouch = False Then Sleep(g_show_duration)
		'VisibleBodyHeightChanged
	End If
	old_top = xpnl_CardBase.Top
	disable_touch = False
	expand_state = 1
	If ignore_event = False Then
		'Sleep(g_show_duration)
		If xui.SubExists(mCallBack,mEventName & "_Opened",0) Then
			CallSub(mCallBack,mEventName & "_Opened")
		End If
	Else
	End If
End Sub
'hides/close the view
Public Sub Hide	(ignore_event As Boolean)
	If inClosingProcess Then Return
	inClosingProcess = True
	expand_state = 0
	If xui.SubExists(mCallBack,mEventName & "_Close",0) Then
		CallSub(mCallBack,mEventName & "_Close")
	End If

	xpnl_CardBase.SetLayoutAnimated(g_hide_duration,xpnl_CardBase.Left,mDarkPanel.Height + g_first_height,g_width,xpnl_CardBase.Height)
	'xpnl_CardBase.SetVisibleAnimated(g_hide_duration,False)
	mDarkPanel.SetVisibleAnimated(g_hide_duration,False)
	If ignore_event = False Then
		Sleep(g_hide_duration)
		If xui.SubExists(mCallBack,mEventName & "_Closed",0) Then
			CallSub(mCallBack,mEventName & "_Closed")
		End If
	Else
		Sleep(g_hide_duration)
	End If
	xpnl_CardBase.Height = g_first_height + g_header_height
	Sleep(0)
	inClosingProcess = False
End Sub

#If B4A

Private Sub xpnl_CardHeader_Touch2(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
	Return HandleTouch(Action,y)
End Sub

#Else If B4I

Private Sub uigesture_pan(state As Int,x As Float, y As Float, obj As Object)
	Select state
		Case 1 'STATE_Begin
			HandleTouch(xpnl_CardBase.TOUCH_ACTION_DOWN,y)
		Case 2 'STATE_Changed
			HandleTouch(xpnl_CardBase.TOUCH_ACTION_MOVE,y)
		Case 3 'STATE_End
			HandleTouch(xpnl_CardBase.TOUCH_ACTION_UP,y)
	End Select
End Sub

#Else IF B4J
Private Sub xpnl_CardBase_Touch (Action As Int, X As Float, Y As Float)
	If Action <> xpnl_CardHeader.TOUCH_ACTION_MOVE_NOTOUCH Then
		HandleTouch(Action,y)
	End If
End Sub
#End If

Private Sub HandleTouch(Action As Int,y As Float) As Boolean
	If g_IsDraggable = False Or disable_touch = True Then Return False
	If Action = xpnl_CardBase.TOUCH_ACTION_DOWN Then
		downy  = y
	End If

	VisibleBodyHeightChanged

	If Action = xpnl_CardBase.TOUCH_ACTION_DOWN Then
		'downy  = y
		old_top = xpnl_CardBase.Top
		'Log("TOUCH_ACTION_DOWN: " & y)
	Else if Action = xpnl_CardBase.TOUCH_ACTION_MOVE Then
		If y < downy Then
			last_swipe2top = True
		Else
			last_swipe2top = False
		End If
			
		If mUserCanClose = True Then
			xpnl_CardBase.Top = Max(mDarkPanel.Height - g_second_height - g_header_height - m_TopBarOffset,xpnl_CardBase.Top + y - downy)
		Else
			xpnl_CardBase.Top = Min(mDarkPanel.Height - g_first_height - g_header_height - m_TopBarOffset,Max(mDarkPanel.Height - g_second_height - g_header_height ,xpnl_CardBase.Top + y - downy))
		End If

		If xpnl_CardBase.Top < (mDarkPanel.Height - g_first_height) Then
			expand_state = 2
			xpnl_CardBody.Height = g_second_height
			xpnl_CardBase.Height = g_second_height + g_header_height
			'Log("jo")
		Else
			expand_state = 1
		End If
		VisibleBodyHeightChanged
	Else if Action = xpnl_CardBase.TOUCH_ACTION_UP Then
		If expand_state = 1 And old_top < xpnl_CardBase.Top And last_swipe2top = False And mUserCanClose = True Then
			Hide(False)
		Else if expand_state = 2 And old_top < xpnl_CardBase.Top Then
			expand_state = 1
			ShowIntern(True,True)
		Else
			ShowIntern(True,True)
		End If
	End If
	Return True
End Sub
'If False then the user can expand the menu, but not close
Public Sub getUserCanClose As Boolean
	Return mUserCanClose
End Sub

Public Sub setUserCanClose(CanClose As Boolean)
	mUserCanClose = CanClose
End Sub

Public Sub getDarkPanel As B4XView
	Return mDarkPanel
End Sub
'gets the card base - the main panel that hold the body- and header-panel
Public Sub getCardBase As B4XView
	Return xpnl_CardBase
End Sub

Public Sub getFirstHeight As Float
	Return g_first_height
End Sub
'sets or gets the first height - body height
'The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the first height
Public Sub setFirstHeight(height As Float)
	g_first_height = height
	If expand_state = 1 Then
		ExpandHalf
	End If
End Sub

Public Sub getSecondHeight As Float
	Return g_second_height
End Sub
'sets or gets the second height - body height
'The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the second height
Public Sub setSecondHeight(height As Float)
	g_second_height = height
	If expand_state = 2 Then
		ExpandFull
	End If
End Sub
'gets the header height
Public Sub getHeaderHeight As Float
	Return g_header_height
End Sub

'sets the corner radius of the header
Public Sub setCornerRadius_Header(radius As Float)
	
	xpnl_CardHeader.Height = g_header_height
	SetPanelCornerRadius(xpnl_CardBase,radius,True,True,False,False)
	SetPanelCornerRadius(xpnl_CardHeader,radius,True,True,False,False)
	SetCircleClip(xpnl_CardHeader,radius)

End Sub
'expand the view full - second height + header height
Public Sub ExpandFull	
	expand_state = 2
	ShowIntern(True,True)
End Sub
'expand the view in half mode - first height + header height
Public Sub ExpandHalf	
	expand_state = 1
	ShowIntern(True,False)
End Sub
'gets or sets the header panel - Load your header layout
Public Sub getHeaderPanel As B4XView
	Return xpnl_CardHeader	
End Sub

Public Sub setHeaderPanel(HeaderPanel As B4XView)
	xpnl_CardHeader = HeaderPanel
End Sub

'gets or sets the body panel - Load your body layout
Public Sub getBodyPanel As B4XView
	Return xpnl_CardBody
End Sub

Public Sub setBodyPanel(BodyPanel As B4XView)
	xpnl_CardBody = BodyPanel
End Sub

Public Sub Orientation_LEFT As Int
	Return 0
End Sub

Public Sub Orientation_MIDDLE As Int
	Return 1
End Sub

Public Sub Orientation_RIGHT As Int
	Return 2
End Sub
'Returns True if the view is expanded/open
Public Sub getIsOpen As Boolean
	If expand_state = 0 Then Return False Else Return True
End Sub
'Returns True if the view is half expanded
Public Sub getIsOpenHalf As Boolean
	If expand_state = 1 Then Return True Else Return False
End Sub
'Returns True if the view is full expanded
Public Sub getIsOpenFull As Boolean
	If expand_state = 2 Then Return True Else Return False
End Sub
'set it to false to disable touch gestures on header panel
Public Sub setIsDraggable(draggable As Boolean)
	g_IsDraggable = draggable
End Sub

Public Sub getIsDraggable As Boolean
	Return g_IsDraggable
End Sub

Public Sub getDarkPanelAlpha As Int
	Return g_darkpanel_alpha
End Sub

Public Sub getDarkPanelClickable As Boolean
	Return mDarkPanelClickable
End Sub

Public Sub setDarkPanelClickable(Clickable As Boolean)
	mDarkPanelClickable = Clickable
End Sub

Public Sub setDarkPanelAlpha(alpha As Int)
	If alpha >= 0 And alpha <=255 Then
		g_darkpanel_alpha = alpha
	End If
End Sub
'Set it before you call "Create"
Public Sub getBodyDrag As Boolean
	Return m_BodyDrag
End Sub

Public Sub setBodyDrag(Enabled As Boolean)
	m_BodyDrag = Enabled
End Sub

Public Sub getBottomOffset As Float
	Return m_BottomOffset
End Sub

Public Sub setBottomOffset(BottomOffset As Float)
	m_BottomOffset = BottomOffset
End Sub

Private Sub VisibleBodyHeightChanged
	If xui.SubExists(mCallBack,mEventName & "_VisibleBodyHeightChanged",1) Then
		CallSub2(mCallBack,mEventName & "_VisibleBodyHeightChanged",xpnl_CardBody.Height)
	End If
End Sub

#IF B4J
Private Sub mDarkPanel_MouseClicked (EventData As MouseEvent)
	If mDarkPanelClickable = False Then Return
	mDarkPanel.Enabled = False
	Hide(False)
End Sub
#Else
Private Sub mDarkPanel_Click
If mDarkPanelClickable = False Then Return
	mDarkPanel.Enabled = False
	Hide(False)
End Sub
#End If

Private Sub SetPanelCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean)
    #If B4I
	'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352
	View.SetColorAndBorder(View.Color,0,0,CornerRadius)
	Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)
	View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)
    #Else If B4A
	'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392
    Dim cdw As ColorDrawable
    cdw.Initialize(View.Color, 0)
    View.As(View).Background = cdw
    Dim jo As JavaObject = View.As(View).Background
    If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then
        jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))
    End If
    #Else If B4J
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965
    Dim Corners As String = ""
    Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
    Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
    Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "
    Corners = Corners & IIf(BottomRight, CornerRadius, 0)
    CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)
    #End If
End Sub

#IF B4I

Private Sub AddPanGesture(MinimumTouch As Int, MaximumTouch As Int)
	mView = xpnl_CardHeader
	nome.RunMethod("grPan:::",Array(xpnl_CardHeader,MinimumTouch,MaximumTouch))
	If m_BodyDrag Then
		mView2 = xpnl_CardBody
	nome.RunMethod("grPan:::",Array(xpnl_CardBody,MinimumTouch,MaximumTouch))
	End If
End Sub

#End If

#If OBJC

/////////// PAN ///////////

-(void)grPan :(UIView*)v :(int)mintouch :(int)maxtouch
{
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePan:)];
 
 [pan setMaximumNumberOfTouches:maxtouch];
 [pan setMinimumNumberOfTouches:mintouch];
pan.delegate=self;
 [v addGestureRecognizer:pan];

}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {  

	int st =gestureRecognizer.state;
float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

    [self.bi raiseEvent:nil event:@"uigesture_pan::::" params:@[@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

-(void)grPan2 :(UIView*)v :(int)mintouch :(int)maxtouch
{
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePan:)];
 
 [pan setMaximumNumberOfTouches:maxtouch];
 [pan setMinimumNumberOfTouches:mintouch];
pan.delegate=self;
 [v addGestureRecognizer:pan];

}

- (void)handlePan2:(UIPanGestureRecognizer *)gestureRecognizer {  

	int st =gestureRecognizer.state;
float x= [gestureRecognizer locationInView:(self._mview2).object].x;
float y= [gestureRecognizer locationInView:(self._mview2).object].y;

    [self.bi raiseEvent:nil event:@"uigesture_pan::::" params:@[@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

#End If
