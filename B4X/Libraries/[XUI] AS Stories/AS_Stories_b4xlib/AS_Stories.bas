B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
'AS_Stories
'Author: Alexander Stolte
'Version: V1.00
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-B4A - Click events of views are now triggered
	-Add ResetAutoPlay - Resets the autplay on the current index
V1.02
	-Add AddPage2 - with a AutoPlayInterval parameter
	-Add GetPage
	-Add get and set AutoPlayInterval
#End If

#DesignerProperty: Key: Carousel, DisplayName: Carousel, FieldType: Boolean, DefaultValue: False, Description: Infinite swipe
#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: False, Description: Activates lazy loading
#DesignerProperty: Key: LazyLoadingExtraSize, DisplayName: Lazy Loading Extra Size, FieldType: Int, DefaultValue: 5, MinRange: 0

#DesignerProperty: Key: ProgressHeight, DisplayName: Progress Height, FieldType: Int, DefaultValue: 3, MinRange: 0
#DesignerProperty: Key: ProgressPrimaryColor, DisplayName: Progress Primary Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ProgressSecondaryColor, DisplayName: Progress Secondary Color, FieldType: Color, DefaultValue: 0x50FFFFFF

#DesignerProperty: Key: AutoPlay, DisplayName: Auto Play, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: AutoPlayInterval, DisplayName: Auto Play Interval, FieldType: Int, DefaultValue: 4000, MinRange: 0

#Event: PageChanged(Index as int)
#Event: LazyLoadingAddContent(Parent As B4XView, Value As Object)
#Event: AutoPlayEnd
#Event: AutoPlayPause
#Event: AutoPlayContinue

Sub Class_Globals
	
	Type AS_Stories_Page(Value As Object,CustomAutoPlayInterval As Long)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Pager As B4XView
	
	Private m_Carousel As Boolean
	Private m_LazyLoading As Boolean
	Private m_LazyLoadingExtraSize As Int
	Private m_TouchWidth As Float = 100dip
	Private m_Index As Int
	Private m_ProgressHeight As Float
	Private m_ProgressPrimaryColor As Int
	Private m_ProgressSecondaryColor As Int
	Private m_AutoPlay As Boolean
	Private m_AutoPlayInterval As Long
	
	Private xpnl_TouchPanel As B4XView
	Private xpnl_ProgressBar As B4XView
	Private tmr_AutoPlayInterval As Timer
	Private xcv As B4XCanvas
	Private CurrentAutoPlay As Long
	Private m_TouchDownTime As Long
	Private m_Pause As Boolean = False

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
	
	m_ProgressHeight = DipToCurrent(Props.Get("ProgressHeight"))
	m_ProgressPrimaryColor = xui.PaintOrColorToColor(Props.Get("ProgressPrimaryColor"))
	m_ProgressSecondaryColor = xui.PaintOrColorToColor(Props.Get("ProgressSecondaryColor"))
	m_Carousel = Props.GetDefault("Carousel",False)
	m_LazyLoading = Props.GetDefault("LazyLoading",False)
	m_LazyLoadingExtraSize = Props.GetDefault("LazyLoadingExtraSize",5)
	m_AutoPlay = Props.Get("AutoPlay")
	m_AutoPlayInterval = Props.Get("AutoPlayInterval")
	
	xpnl_Pager = xui.CreatePanel("xpnl_Pager")
	mBase.AddView(xpnl_Pager,0,0,mBase.Width,mBase.Height)
	
	xpnl_TouchPanel = xui.CreatePanel("xpnl_TouchPanel")

	xpnl_ProgressBar = xui.CreatePanel("")
	
	xpnl_TouchPanel.Color = xui.Color_Transparent
	
	mBase.AddView(xpnl_TouchPanel,0,0,mBase.Width,mBase.Height)
	
	mBase.AddView(xpnl_ProgressBar,0,0,mBase.Width,50dip)
	xpnl_ProgressBar.Color = xui.Color_Transparent
	
	xcv.Initialize(xpnl_ProgressBar)
	
	#If B4A
	xpnl_Pager.BringToFront
	xpnl_ProgressBar.BringToFront
	#End If
	
	#If B4J
	Dim r As Reflector
	r.Target = xpnl_Pager
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_PRESSED")
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_RELEASED")
	#End If

	tmr_AutoPlayInterval.Initialize("tmr_AutoPlayInterval",50)
	
	Sleep(0)
	
	tmr_AutoPlayInterval.Enabled = m_AutoPlay
	
		#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xpnl_Pager.SetLayoutAnimated(0,0,0,Width,Height)
	
	If xpnl_Pager.NumberOfViews > 0 Then
		xpnl_Pager.GetView(m_Index).SetLayoutAnimated(0,0,0,Width,Height)
	End If
	
	For i = 0 To xpnl_Pager.NumberOfViews -1
		xpnl_Pager.GetView(i).SetLayoutAnimated(0,0,0,Width,Height)
	Next
	
	DrawProgress
	
End Sub

Private Sub DrawProgress
	
	xcv.ClearRect(xcv.TargetRect)
	
	Dim GapBetween As Float = 5dip
	Dim LineWidth As Float = mBase.Width/xpnl_Pager.NumberOfViews
	
	For i = 0 To xpnl_Pager.NumberOfViews
		
		xcv.DrawLine(LineWidth*i,Max(m_ProgressHeight*2,12dip),LineWidth*(i+1) -GapBetween,Max(m_ProgressHeight*2,12dip),m_ProgressSecondaryColor,m_ProgressHeight)
		
	Next
	
	For i = 0 To m_Index
		
		If i = m_Index And m_AutoPlay Then
			
			Dim ThisPage As AS_Stories_Page = xpnl_Pager.GetView(m_Index).Tag
			Dim AutoPlayInterval As Long = IIf(ThisPage.CustomAutoPlayInterval = 0,m_AutoPlayInterval,ThisPage.CustomAutoPlayInterval)
			Dim Progress As Int = (CurrentAutoPlay / AutoPlayInterval) * 100
			Dim WidthProgress As Float = (Progress / 100) * LineWidth
			
			xcv.DrawLine(LineWidth*i,Max(m_ProgressHeight*2,12dip),Max(LineWidth*i, LineWidth*i - GapBetween + WidthProgress),Max(m_ProgressHeight*2,12dip),m_ProgressPrimaryColor,m_ProgressHeight)
			Else
			xcv.DrawLine(LineWidth*i,Max(m_ProgressHeight*2,12dip),LineWidth*(i+1) -GapBetween,Max(m_ProgressHeight*2,12dip),m_ProgressPrimaryColor,m_ProgressHeight)
		End If
		
	Next
	
	xcv.Invalidate
	
End Sub

#Region Properties

'Gets or sets the touch panel width
'Default: 100dip
Public Sub getTouchWidth As Float
	Return m_TouchWidth
End Sub

Public Sub setTouchWidth(Width As Float)
	m_TouchWidth = Width
End Sub

Public Sub Clear
	xpnl_Pager.RemoveAllViews
	m_Index = 0
End Sub

Public Sub RemovePageAt(Index As Int)
	#If B4J
	xpnl_Pager.As(Pane).RemoveNodeAt(Index)
	#Else
	xpnl_Pager.GetView(Index).RemoveViewFromParent
	#End If
	
	If Index = m_Index Then
		setIndex(IIf((m_Index +1) >= xpnl_Pager.NumberOfViews,m_Index -1,m_Index +1))
	End If
End Sub

Public Sub AddPage(PagePanel As B4XView,Value As Object)
	Dim Page As AS_Stories_Page
	Page.Initialize
	Page.Value = Value
	Page.CustomAutoPlayInterval = 0
	
	Dim isFirstPanel As Boolean = False
	PagePanel.Tag = Page
	If xpnl_Pager.NumberOfViews > 0 Then
		PagePanel.Visible = False
	Else
		isFirstPanel  = True
	End If
	xpnl_Pager.AddView(PagePanel,0,0,mBase.Width,mBase.Height)
	If isFirstPanel And m_LazyLoading Then LazyLoading
End Sub

'CustomAutoPlayInterval - A custom auto play interval is set for this page, all other pages where none is set have the normal AutoPlayInterval
Public Sub AddPage2(PagePanel As B4XView,CustomAutoPlayInterval As Long,Value As Object)
	Dim Page As AS_Stories_Page
	Page.Initialize
	Page.Value = Value
	Page.CustomAutoPlayInterval = CustomAutoPlayInterval
	
	Dim isFirstPanel As Boolean = False
	PagePanel.Tag = Page
	If xpnl_Pager.NumberOfViews > 0 Then
		PagePanel.Visible = False
	Else
		isFirstPanel  = True
	End If
	xpnl_Pager.AddView(PagePanel,0,0,mBase.Width,mBase.Height)
	If isFirstPanel And m_LazyLoading Then LazyLoading
End Sub

'Public Sub AddPageAt(Index As Int,PagePanel As B4XView,Value As Object)
'	PagePanel.Tag = Value
'	#If B4J
'	xpnl_Pager.As(Pane).InsertNode(Index,PagePanel,0,0,mBase.Width,mBase.Height)
'	#Else
'	xpnl_Pager.
'	#End IF
'End Sub

'Returns the Panel stored at the specified index.
Public Sub GetPanel(Index As Int) As B4XView
	Return xpnl_Pager.GetView(Index)
End Sub
'Returns the Value stored at the specified index.
Public Sub GetValue(Index As Int) As Object
	Return xpnl_Pager.GetView(Index).Tag.As(AS_Stories_Page).Value
End Sub

Public Sub GetPage(Index As Int) As AS_Stories_Page
	Return xpnl_Pager.GetView(Index).Tag
End Sub

Public Sub NextPage
	If m_Index < xpnl_Pager.NumberOfViews -1 Then CurrentAutoPlay = 0
	AutoPlayContinue
	If m_Carousel = False And (m_Index +1) >= xpnl_Pager.NumberOfViews Then Return
	'setIndex(IIf(m_Carousel And (m_Index +1) >= xpnl_Pager.NumberOfViews,0,m_Index +1))
	SetIndexIntern(m_Index,IIf(m_Carousel And (m_Index +1) >= xpnl_Pager.NumberOfViews,0,m_Index +1))
End Sub

Public Sub PreviousPage
	CurrentAutoPlay = 0
	AutoPlayContinue
	If m_Carousel = False And (m_Index -1) < 0 Then Return
	'setIndex(IIf(m_Carousel And (m_Index -1) < 0,xpnl_Pager.NumberOfViews -1,m_Index -1))
	SetIndexIntern(m_Index,IIf(m_Carousel And (m_Index -1) < 0,xpnl_Pager.NumberOfViews -1,m_Index -1))
End Sub

Public Sub Commit
	LazyLoading
End Sub

Public Sub setIndex(Index As Int)
	'Log("setIndex: " & Index)
	SetIndexIntern(m_Index,Index)
End Sub

Public Sub getIndex As Int
	Return m_Index
End Sub

Public Sub getSize As Int
	Return xpnl_Pager.NumberOfViews
End Sub

Public Sub getHeaderPanel As B4XView
	Return xpnl_ProgressBar
End Sub

Public Sub setAutoPlay(Enabled As Boolean)
	m_AutoPlay = Enabled
	tmr_AutoPlayInterval.Enabled = Enabled
End Sub

'Reset the auto play on the current index
Public Sub ResetAutoPlay
	CurrentAutoPlay = 0
End Sub

'Call Resume to start
Public Sub Pause
	m_Pause = True
End Sub
'Call Pause to stop
Public Sub Resume
	m_Pause = False
End Sub

Public Sub getAutoPlayInterval As Long
	Return m_AutoPlayInterval
End Sub

Public Sub setAutoPlayInterval(AutoPlayInterval As Long)
	m_AutoPlayInterval = AutoPlayInterval
End Sub

#End Region

#Region InternFucntions

Private Sub SetIndexIntern(OldIndex As Int,NewIndex As Int)
	m_Index = NewIndex
	xpnl_Pager.GetView(OldIndex).Visible = False
	xpnl_Pager.GetView(m_Index).Visible = True
	PageChanged
End Sub

Private Sub LazyLoading
	For i = 0 To xpnl_Pager.NumberOfViews - 1
		Dim p As B4XView = xpnl_Pager.GetView(i)
		If i > m_Index - m_LazyLoadingExtraSize And i < m_Index + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				LazyLoadingAddContent(p,xpnl_Pager.GetView(i).Tag.As(AS_Stories_Page).Value)
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews '<--- remove the layout
			End If
		End If
	Next
End Sub

#End Region

#Region Events

Private Sub tmr_AutoPlayInterval_Tick
	If m_Pause = False Then	CurrentAutoPlay = CurrentAutoPlay +50
	
	Dim ThisPage As AS_Stories_Page = xpnl_Pager.GetView(m_Index).Tag
	Dim AutoPlayInterval As Long = IIf(ThisPage.CustomAutoPlayInterval = 0,m_AutoPlayInterval,ThisPage.CustomAutoPlayInterval)
	
	If CurrentAutoPlay >= AutoPlayInterval Then
		
		If m_Index = (getSize-1) Then
			tmr_AutoPlayInterval.Enabled = False
			AutoPlayEnd
			Else
			CurrentAutoPlay = 0
		End If
		
		NextPage
	End If
	DrawProgress
End Sub

Private Sub xpnl_LeftTap_Click
	PreviousPage
End Sub

Private Sub xpnl_RightTap_Click
	NextPage
End Sub

Private Sub xpnl_TouchPanel_Touch(Action As Int, X As Float, Y As Float)
	Dim CurrentIndex As Int = m_Index
	
	If Action = xpnl_Pager.TOUCH_ACTION_DOWN Then
		m_TouchDownTime = DateTime.Now
	End If
	
	If Action = xpnl_Pager.TOUCH_ACTION_UP Then

		If DateTime.Now - m_TouchDownTime < 300 Or m_Pause = False Then
			m_TouchDownTime = -1
			If x <= m_TouchWidth Then
				PreviousPage
			Else If x >=mBase.Width - m_TouchWidth Then
				NextPage
			End If
		
		Else
			m_TouchDownTime = -1
			m_Pause = False
			AutoPlayContinue
		End If
		
	End If
	
	Sleep(300)
	
	If CurrentIndex = m_Index And Action = xpnl_Pager.TOUCH_ACTION_DOWN  And m_TouchDownTime > -1 Then
		m_Pause = True
		AutoPlayPause
	End If
End Sub

#If B4J

Private Sub xpnl_Pager_MouseClicked (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub

Private Sub xpnl_Pager_MouseEntered (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub
#Else



#End If

#If B4J

Private Sub et_Filter (EventData As Event)
	Dim jo As JavaObject = EventData
	Dim code As String = jo.RunMethod("getCode", Null)
	Dim EventType As String = jo.RunMethod("getEventType", Null)

	If EventType = "KEY_RELEASED" Then
		'Log("Code: " & code)
	
			If code = "RIGHT" Then
				NextPage
			Else If code = "LEFT" Then
				PreviousPage
			End If
	
	End If
End Sub

#End If

Private Sub AutoPlayContinue
	If xui.SubExists(mCallBack, mEventName & "_AutoPlayContinue", 0) Then
		CallSub(mCallBack, mEventName & "_AutoPlayContinue")
	End If
End Sub

Private Sub AutoPlayPause
	If xui.SubExists(mCallBack, mEventName & "_AutoPlayPause", 0) Then
		CallSub(mCallBack, mEventName & "_AutoPlayPause")
	End If
End Sub

Private Sub AutoPlayEnd
	If xui.SubExists(mCallBack, mEventName & "_AutoPlayEnd", 0) Then
		CallSub(mCallBack, mEventName & "_AutoPlayEnd")
	End If
End Sub

Private Sub PageChanged
	DrawProgress
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_PageChanged",m_Index)
	End If
	If m_LazyLoading Then LazyLoading
End Sub

Private Sub LazyLoadingAddContent(Parent As B4XView,Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_LazyLoadingAddContent", 2) Then
		CallSub3(mCallBack, mEventName & "_LazyLoadingAddContent",Parent,Value)
	End If
End Sub

#End Region