B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'version 1.14
#Event: ActionClicked (Index As Int, ActionText As String)
Sub Class_Globals
	Private mCLV As CustomListView
	Type SwipeItem (Value As Object, Actions As List, IsSwiped As Boolean, MaxSwipe As Int, Open As Boolean)
	Public Base As B4XView
	Private TouchXStart, TouchYStart As Float
	Private HandlingSwipe As Boolean
	Private ActionsPanel As B4XView
	Private LastSwipedItem As Int = -1
	Public ActionColors As Map
	Private xui As XUI
	Private cvs As B4XCanvas
	Private mCallback As Object
	Private mEventName As String
	Private mPullToRefreshPanel As B4XView
	Private PullToRefreshSwipe As Boolean 'ignore
	Private WaitingForRefreshToComplete As Boolean
	#if B4A
	Private mScrollingDisabled As Boolean
	#End If
End Sub

Public Sub Initialize (clv As CustomListView, Callback As Object, EventName As String)
	#if B4A
	Dim creator As TouchPanelCreator
	Base = creator.CreateTouchPanel("TouchPanel")
	#else if B4i
	Base = xui.CreatePanel("")
	Dim nme As NativeObject = Me
	Dim no As NativeObject = Base
	no.RunMethod("addGestureRecognizer:", Array(nme.RunMethod("CreateRecognizer", Null)))
	#end if
	ActionsPanel = xui.CreatePanel("")
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
	mCLV = clv
	mCLV.AsView.Parent.AddView(Base, mCLV.AsView.Left, mCLV.AsView.Top, mCLV.AsView.Width, mCLV.AsView.Height)
	mCLV.AsView.RemoveViewFromParent
	Base.AddView(mCLV.AsView, 0, 0, Base.Width, Base.Height)
	mCallback = Callback
	mEventName = EventName
End Sub


Public Sub CreateItemValue(Value As Object, Actions As List) As SwipeItem
	Dim m As SwipeItem
	m.Initialize
	m.Value = Value
	m.Actions = Actions
	Return m
End Sub

Private Sub ChangeOffset(index As Int, dx As Int, complete As Boolean) As Boolean
	If index < 0 Or index >= mCLV.Size Then Return False
	Dim item As CLVItem = mCLV.GetRawListItem(index)
	If Not(item.Value Is SwipeItem) Then Return False
	Dim m As SwipeItem = item.Value
	If m.IsSwiped = False And complete = True Then Return False
	If m.IsSwiped = False Then
		If m.Actions.IsInitialized And m.Actions.Size > 0 Then
			m.IsSwiped = True
			If ActionsPanel.Parent.IsInitialized Then ActionsPanel.RemoveViewFromParent
			item.Panel.Parent.AddView(ActionsPanel, 0, item.Panel.Top, item.Panel.Width, item.Panel.Height)
			ActionsPanel.SendToBack
			m.MaxSwipe = CreateActionButtons(m.Actions)
			LastSwipedItem = index
		Else
			Return False
		End If
	End If
	Dim NewLeft As Int = Max(Min(item.Panel.Left + dx, 0), -m.MaxSwipe)
	If complete Then
		If (m.Open = False And NewLeft >= -40dip) Or (m.Open = True And NewLeft >= -m.MaxSwipe + 10dip) Then
			item.Panel.SetLayoutAnimated(200, 0, item.Panel.Top, item.Panel.Width, item.Panel.Height)
			m.IsSwiped = False
			m.Open = False
			ActionsPanel.RemoveViewFromParent
		Else 
			item.Panel.SetLayoutAnimated(200, -m.MaxSwipe, item.Panel.Top, item.Panel.Width, item.Panel.Height)
			m.Open = True
		End If
	Else

		item.Panel.Left = NewLeft
	End If
	Return True
End Sub

Private Sub ChangeYOffset(dy As Int, complete As Boolean) 'ignore
	If WaitingForRefreshToComplete Then Return
	Dim NewTop As Int = Min(Max(mCLV.AsView.Top + dy, 0), mPullToRefreshPanel.Height)
	mCLV.AsView.Top = NewTop
	If NewTop = mPullToRefreshPanel.Height Then
		RaiseRefreshEvent
	End If
	If complete Then
		mCLV.AsView.SetLayoutAnimated(200, 0, 0, mCLV.AsView.Width, mCLV.AsView.Height)
	End If
End Sub

Private Sub RaiseRefreshEvent
	WaitingForRefreshToComplete = True
	HandlingSwipe = False
	CallSub(mCallback, mEventName & "_RefreshRequested")
End Sub

Public Sub ScrollChanged (offset As Int)
	#if B4i
	Dim sv As ScrollView = mCLV.sv
	Dim no As NativeObject = sv
	
	If offset <= 0 And mPullToRefreshPanel.IsInitialized Then
		sv.Bounces = True
		mPullToRefreshPanel.Visible = True
		no.RunMethod("setShowsVerticalScrollIndicator:", Array(False))
		If offset <= -mPullToRefreshPanel.Height Then
			sv.ScrollEnabled = False
			sv.ScrollTo(0, 0, False)
			mCLV.AsView.Top = mPullToRefreshPanel.Height
			RaiseRefreshEvent
			
		End If
	Else
		sv.Bounces = False
		no.RunMethod("setShowsVerticalScrollIndicator:", Array(True))
	End If
	#End If
	
End Sub

Public Sub RefreshCompleted
	If WaitingForRefreshToComplete = False Then Return
	WaitingForRefreshToComplete = False
	mPullToRefreshPanel.Visible = False
	mCLV.AsView.SetLayoutAnimated(200, 0, 0, mCLV.AsView.Width, mCLV.AsView.Height)
	#if B4i
	Dim sv As ScrollView = mCLV.sv
	sv.ScrollEnabled = True
	#End If
End Sub

Private Sub CreateActionButtons (actions As List) As Int
	ActionsPanel.RemoveAllViews
	Dim LastX As Int = 0
	For Each action As String In actions
		Dim l As Label
		l.Initialize("lbl")
		Dim xlbl As B4XView = l
		xlbl.Text = action
		xlbl.Color = ActionColors.GetDefault(action, xui.Color_White)
		xlbl.SetTextAlignment("CENTER", "CENTER")
		xlbl.Font = xui.CreateDefaultBoldFont(20)
		xlbl.TextColor = xui.Color_Black
		Dim width As Int = Max(40dip, cvs.MeasureText(action, xlbl.Font).Width + 20dip)
		ActionsPanel.AddView(xlbl, ActionsPanel.Width - width - LastX, 0, width, ActionsPanel.Height)
		LastX = LastX + width
	Next
	Return LastX
End Sub

Private Sub Lbl_Click
	Dim lbl As B4XView = Sender
	Dim index As Int = LastSwipedItem
	CloseLastSwiped
	CallSub3(mCallback, mEventName & "_ActionClicked", index, lbl.Text)
End Sub

Public Sub CloseLastSwiped
	ChangeOffset(LastSwipedItem, 10000dip, True)
	LastSwipedItem = -1
End Sub

Public Sub Resize(Width As Int, Height As Int)
	CloseLastSwiped
	ActionsPanel.Width = Width
	Base.SetLayoutAnimated(0, Base.Left, Base.Top, Width, Height)
	If mPullToRefreshPanel.IsInitialized Then
		mPullToRefreshPanel.SetLayoutAnimated(0, 0, 0, Width, mPullToRefreshPanel.Height)
	End If
End Sub

Public Sub setPullToRefreshPanel(pnl As B4XView)
	If pnl.Parent.IsInitialized Then pnl.RemoveViewFromParent
	If mPullToRefreshPanel.IsInitialized Then mPullToRefreshPanel.RemoveViewFromParent
	mPullToRefreshPanel = pnl
	Base.AddView(mPullToRefreshPanel, 0, 0, Base.Width, mPullToRefreshPanel.Height)
	mPullToRefreshPanel.SendToBack
	mPullToRefreshPanel.Visible = False
End Sub

Public Sub getPullToRefreshPanel As B4XView
	Return mPullToRefreshPanel
End Sub



#if B4A

Public Sub getScrollingEnabled As Boolean
	Return Not(mScrollingDisabled)
End Sub

Public Sub setScrollingEnabled (b As Boolean)
	mScrollingDisabled = Not(b)
End Sub

Private Sub TouchPanel_OnInterceptTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If mScrollingDisabled Or HandlingSwipe Or WaitingForRefreshToComplete Then Return True
	Select Action
		Case Base.TOUCH_ACTION_DOWN
			TouchXStart = X
			TouchYStart = Y
			HandlingSwipe = False
		Case Base.TOUCH_ACTION_MOVE
			Dim dx As Float = Abs(x - TouchXStart)
			Dim dy As Float = Abs(y - TouchYStart)
			If mPullToRefreshPanel.IsInitialized And mCLV.sv.ScrollViewOffsetY = 0 And y - TouchYStart > 3dip Then
				HandlingSwipe = True
				PullToRefreshSwipe = True
				mPullToRefreshPanel.Visible = True
				CloseLastSwiped
			Else If dy < 20dip And dx > 10dip And mCLV.Size > 0 Then
				If HandlingSwipe = False Then
					Dim NewSwipeItem As Int = mCLV.FindIndexFromOffset(TouchYStart + mCLV.sv.ScrollViewOffsetY)
					If NewSwipeItem <> LastSwipedItem Then CloseLastSwiped
					LastSwipedItem = NewSwipeItem
				End If
				HandlingSwipe = True
				PullToRefreshSwipe = False
			End If
	End Select
	Return HandlingSwipe
End Sub

Private Sub TouchPanel_OnTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If mScrollingDisabled Or HandlingSwipe = False Or WaitingForRefreshToComplete Then Return True
	If PullToRefreshSwipe Then
		Select Action
			Case Base.TOUCH_ACTION_MOVE
				Dim dy As Float = y - TouchYStart
				TouchYStart = Y
				ChangeYOffset(dy, False)
			Case Base.TOUCH_ACTION_UP
				ChangeYOffset(dy, True)
				HandlingSwipe = False
		End Select
	Else
		Select Action
			Case Base.TOUCH_ACTION_MOVE
				Dim dx As Float = x - TouchXStart
				TouchXStart = X
				HandlingSwipe = ChangeOffset(LastSwipedItem, dx, False)
			Case Base.TOUCH_ACTION_UP
				ChangeOffset(LastSwipedItem, 0, True)
				HandlingSwipe = False
		End Select
	End If
	Return True
End Sub
#end if

#if B4i
Private Sub Pan_Event (pan As Object)
	If WaitingForRefreshToComplete Or getScrollingEnabled = False Then Return
	Dim rec As NativeObject = pan
	Dim points() As Float = rec.ArrayFromPoint(rec.RunMethod("locationInView:", Array(Base)))
	Dim x As Float = points(0)
	Dim state As Int = rec.GetField("state").AsNumber
	Select state
		Case 1 'began
			TouchXStart = x
			TouchYStart = points(1)
			If HandlingSwipe = False Then
				Dim NewSwipeItem As Int = mCLV.FindIndexFromOffset(TouchYStart + mCLV.sv.ScrollViewOffsetY)
				If NewSwipeItem <> LastSwipedItem Then CloseLastSwiped
				LastSwipedItem = NewSwipeItem
			End If
			HandlingSwipe = True
		Case 2 'changed
			Dim dx As Float = x - TouchXStart
			ChangeOffset(LastSwipedItem, dx, False)
			TouchXStart = X
		Case 3 'ended
			HandlingSwipe = False
			ChangeOffset(LastSwipedItem, 0, True)
	End Select
End Sub

Public Sub getScrollingEnabled As Boolean
	Dim sv As ScrollView = mCLV.sv
	Return sv.ScrollEnabled
End Sub

Public Sub setScrollingEnabled (b As Boolean)
	Dim sv As ScrollView = mCLV.sv
	sv.ScrollEnabled = b
End Sub

#end if

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

