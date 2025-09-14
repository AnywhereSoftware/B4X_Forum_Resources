B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'version 0.18
Sub Class_Globals
	Private mWV As WebView
	Private Base As B4XView
	Private TouchYStart As Float
	Private HandlingSwipe As Boolean
	Private xui As XUI
	'Private mCallback As Object
	'Private mEventName As String
	Private mPullToRefreshPanel As B4XView
	Private PullToRefreshSwipe As Boolean 'ignore
	Private WaitingForRefreshToComplete As Boolean
	Private ProgressBar1 As B4XView
	Private ProgressBarColor As Int = Colors.Gray
	Private tim As Timer
End Sub

'pass your Webview to be refreshed
Public Sub Initialize (cWV As WebView)	', Callback As Object, EventName As String
	Dim creator As TouchPanelCreator
	Base = creator.CreateTouchPanel("TouchPanel")
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 1dip, 1dip)
	mWV = cWV
	Dim p1 As B4XView = mWV.Parent
	p1.AddView(Base, mWV.Left, mWV.Top, mWV.Width, mWV.Height)
	mWV.RemoveView
	Base.AddView(mWV, 0, 0, Base.Width, Base.Height)
	'mCallback = Callback
	'mEventName = EventName
	Dim p2 As B4XView = xui.CreatePanel("")
	p2.SetLayoutAnimated(0, 0, 0, mWV.Width, 60dip)
	p2.LoadLayout("PullToRefresh")
	setPullToRefreshPanel(p2)
	tim.Initialize("tim", 500)
End Sub

Private Sub setPullToRefreshPanel(pnl As B4XView)
	If pnl.Parent.IsInitialized Then pnl.RemoveViewFromParent
	If mPullToRefreshPanel.IsInitialized Then mPullToRefreshPanel.RemoveViewFromParent
	mPullToRefreshPanel = pnl
	Base.AddView(mPullToRefreshPanel, 0, 0, Base.Width, mPullToRefreshPanel.Height)
	mPullToRefreshPanel.SendToBack
	mPullToRefreshPanel.Visible = False
	ProgressBar1.Left = ((mWV.Width - mWV.Left) - ProgressBar1.Width)/2
	ProgressBar1.Visible = True
	setProgress_Color(ProgressBarColor)
End Sub

Private Sub TouchPanel_OnInterceptTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If HandlingSwipe Or WaitingForRefreshToComplete Then Return True
	Select Action
		Case Base.TOUCH_ACTION_DOWN
			TouchYStart = Y
			HandlingSwipe = False
		Case Base.TOUCH_ACTION_MOVE
			Dim dy As Float = Abs(y - TouchYStart)

			If mPullToRefreshPanel.IsInitialized And y - TouchYStart > 3dip Then
				If WebView_ScrollPosition = 0 Then	'only at the top position
					HandlingSwipe = True
					PullToRefreshSwipe = True
					mPullToRefreshPanel.Visible = True
				End If
			Else If dy < 20dip Then
				Return False
			End If
	End Select
	Return HandlingSwipe
End Sub

Private Sub TouchPanel_OnTouchEvent (Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If HandlingSwipe = False Or WaitingForRefreshToComplete Then Return True
	If PullToRefreshSwipe Then
		Select Action
			Case Base.TOUCH_ACTION_MOVE
				Dim dy As Float = y - TouchYStart
				TouchYStart = Y
				If WebView_ScrollPosition = 0 Then	'only at the top position
					ChangeYOffset(dy, False)
				End If
			Case Base.TOUCH_ACTION_UP
				ChangeYOffset(dy, True)
				HandlingSwipe = False
		End Select
	End If
	Return True
End Sub

Private Sub ChangeYOffset(dy As Int, complete As Boolean)
	If WaitingForRefreshToComplete Then Return
	Dim NewTop As Int = Min(Max(mWV.Top + dy, 0), mPullToRefreshPanel.Height)
	mWV.Top = NewTop
	If NewTop = mPullToRefreshPanel.Height Then
		RaiseRefreshEvent
	End If
	If complete Then
		mWV.SetLayoutAnimated(200, 0, 0, mWV.Width, mWV.Height)
	End If
End Sub

Private Sub tim_Tick
	tim.Enabled = False
	RaiseRefreshEvent
End Sub

'show progress right now (for ex. if to jump to another URL)
Public Sub Pull_Immediately
	HandlingSwipe = True
	PullToRefreshSwipe = True
	mPullToRefreshPanel.Visible = True
	ChangeYOffset(mPullToRefreshPanel.Height, False)	'show progressbar immediately
End Sub

Private Sub WebView_ScrollPosition As Int
	Dim jo As JavaObject = mWV
	Dim pos As Int = jo.RunMethod("getScrollY", Null) 
	Return pos
End Sub

'color or the animating circle
Public Sub setProgress_Color (NewColor As Int)
	Dim jo As JavaObject = ProgressBar1
	jo = jo.RunMethod("getIndeterminateDrawable", Null)
	jo.RunMethod("setColorFilter", Array (NewColor, "SRC_IN"))
End Sub

Private Sub RaiseRefreshEvent
	WaitingForRefreshToComplete = True
	HandlingSwipe = False
	Swipe_RefreshRequested	'CallSub(mCallback, mEventName & "_RefreshRequested")
End Sub

'call to exit refresh mode
Public Sub RefreshCompleted
	If WaitingForRefreshToComplete = False Then Return
	WaitingForRefreshToComplete = False
	mPullToRefreshPanel.Visible = False
	mWV.SetLayoutAnimated(200, 0, 0, mWV.Width, mWV.Height)
End Sub

'instead of the event - WebView can be refreshed here
Private Sub Swipe_RefreshRequested
	Sleep(1000)
	mWV.StopLoading
	If mWV.Url = "" Or mWV.Url = Null Or mWV.Url = "null" Then
		mWV.LoadHtml("No URL to load")
	Else
		mWV.LoadUrl(mWV.Url)	'refresh the page
	End If
End Sub