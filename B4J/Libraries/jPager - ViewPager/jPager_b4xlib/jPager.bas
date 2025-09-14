B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'jPager
'Author: Alexander Stolte
'Version: V1.00
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-BugFix
V1.02
	-Add get and set LazyLoading
	-Add get and set LazyLoadingExtraSize
V1.03
	-Add AllowNext
		-Default: True
		-If False: Prevents the user from moving to the next page
			-The NextPage function will not work
			-The CurrentIndex property can be used without restrictions
	-Add AllowBack
		-Default: True
		-If False: Prevents the user from moving to the previous page
			-The PreviousPage function will not work
			-The CurrentIndex property can be used without restrictions
#End If

#DesignerProperty: Key: Orientation, DisplayName: Orientation, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical , Description: If Horizontal use the Left and Right keys to swipe. If Vertical use the Up and Down keys to swipe
#DesignerProperty: Key: Carousel, DisplayName: Carousel, FieldType: Boolean, DefaultValue: False, Description: Infinite swipe
#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: False, Description: Activates lazy loading
#DesignerProperty: Key: LazyLoadingExtraSize, DisplayName: Lazy Loading Extra Size, FieldType: Int, DefaultValue: 5, MinRange: 0

#Event: PageChanged(Index as int)
#Event: LazyLoadingAddContent(Parent As B4XView, Value As Object)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Pager As B4XView
	
	Private m_Carousel As Boolean
	Private m_LazyLoading As Boolean
	Private m_LazyLoadingExtraSize As Int
	Private m_AllowNext As Boolean = True
	Private m_AllowBack As Boolean = True
	
	Private m_Index As Int
	Private m_Orientation As String = "Horizontal"
	
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
  	
	xpnl_Pager = xui.CreatePanel("xpnl_Pager")
	mBase.AddView(xpnl_Pager,0,0,mBase.Width,mBase.Height)
	
	Dim r As Reflector
	r.Target = xpnl_Pager 
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_PRESSED")
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_RELEASED")
	
	m_Orientation = Props.GetDefault("Orientation","Horizontal")
	m_Carousel = Props.GetDefault("Carousel",False)
	m_LazyLoading = Props.GetDefault("LazyLoading",False)
	m_LazyLoadingExtraSize = Props.GetDefault("LazyLoadingExtraSize",5)
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xpnl_Pager.SetLayoutAnimated(0,0,0,Width,Height)
	
	xpnl_Pager.GetView(m_Index).SetLayoutAnimated(0,0,0,Width,Height)
	
	For i = 0 To xpnl_Pager.NumberOfViews -1		
		xpnl_Pager.GetView(i).SetLayoutAnimated(0,0,0,Width,Height)
	Next
	
End Sub

#Region Properties

'If False: Prevents the user from moving to the next page
'	-The NextPage function will not work
'	-The CurrentIndex property can be used without restrictions
Public Sub AllowNext(Allow As Boolean)
	m_AllowNext = Allow
End Sub

'If False: Prevents the user from moving to the previous page
'	-The PreviousPage function will not work
'	-The CurrentIndex property can be used without restrictions
Public Sub AllowBack(Allow As Boolean)
	m_AllowBack = Allow
End Sub

Public Sub setLazyLoadingExtraSize(Size As Int)
	m_LazyLoadingExtraSize = Size
End Sub

Public Sub getLazyLoadingExtraSize As Int
	Return m_LazyLoadingExtraSize
End Sub

Public Sub setLazyLoading(Enabled As Boolean)
	m_LazyLoading = Enabled
End Sub

Public Sub getLazyLoading As Boolean
	Return m_LazyLoading
End Sub

Public Sub Clear
	xpnl_Pager.RemoveAllViews
	m_Index = 0
End Sub

Public Sub RemovePageAt(Index As Int)
	xpnl_Pager.As(Pane).RemoveNodeAt(Index)
	If Index = m_Index Then
		setIndex(IIf((m_Index +1) >= xpnl_Pager.NumberOfViews,m_Index -1,m_Index +1))	
	End If
End Sub

Public Sub AddPage(PagePanel As B4XView,Value As Object)
	Dim isFirstPanel As Boolean = False
	PagePanel.Tag = Value
	'xpnl_Pager.AddView(PagePanel,IIf(xpnl_Pager.NumberOfViews > 0,mBase.Width,0),0,mBase.Width,mBase.Height)
	If xpnl_Pager.NumberOfViews > 0 Then 
		PagePanel.Visible = False
		Else
		isFirstPanel  = True
	End If
	xpnl_Pager.AddView(PagePanel,0,0,mBase.Width,mBase.Height)
	If isFirstPanel And m_LazyLoading Then InternLazyLoading
End Sub

Public Sub AddPageAt(Index As Int,PagePanel As B4XView,Value As Object)
	PagePanel.Tag = Value
	xpnl_Pager.As(Pane).InsertNode(Index,PagePanel,0,0,mBase.Width,mBase.Height)
End Sub

'Returns the Panel stored at the specified index.
Public Sub GetPanel(Index As Int) As B4XView
	Return xpnl_Pager.GetView(Index)
End Sub
'Returns the Value stored at the specified index.
Public Sub GetValue(Index As Int) As Object
	Return xpnl_Pager.GetView(Index).Tag
End Sub

Public Sub NextPage
	If m_AllowNext = False Then Return
	If m_Carousel = False And (m_Index +1) >= xpnl_Pager.NumberOfViews Then Return
	setIndex(IIf(m_Carousel And (m_Index +1) >= xpnl_Pager.NumberOfViews,0,m_Index +1))
	PageChanged
End Sub

Public Sub PreviousPage
	If m_AllowBack = False Then Return
	If m_Carousel = False And (m_Index -1) < 0 Then Return
	setIndex(IIf(m_Carousel And (m_Index -1) < 0,xpnl_Pager.NumberOfViews -1,m_Index -1))
	PageChanged
End Sub

Public Sub Commit
	InternLazyLoading
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

#End Region

#Region InternFucntions

Private Sub SetIndexIntern(OldIndex As Int,NewIndex As Int)
	m_Index = NewIndex
	xpnl_Pager.GetView(OldIndex).Visible = False
	xpnl_Pager.GetView(m_Index).Visible = True
	PageChanged
End Sub

Private Sub InternLazyLoading
	For i = 0 To xpnl_Pager.NumberOfViews - 1
		Dim p As B4XView = xpnl_Pager.GetView(i)
		If i > m_Index - m_LazyLoadingExtraSize And i < m_Index + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				LazyLoadingAddContent(p,xpnl_Pager.GetView(i).Tag)
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

Private Sub xpnl_Pager_MouseClicked (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub

Private Sub xpnl_Pager_MouseEntered (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub

Private Sub et_Filter (EventData As Event)
	Dim jo As JavaObject = EventData
	Dim code As String = jo.RunMethod("getCode", Null)
	Dim EventType As String = jo.RunMethod("getEventType", Null)

	If EventType = "KEY_RELEASED" Then
		'Log("Code: " & code)
		If m_Orientation = "Horizontal" Then
			If code = "RIGHT" Then
				NextPage
			Else If code = "LEFT" Then
				PreviousPage
			End If
		Else
			If code = "DOWN" Then
				NextPage
			Else If code = "UP" Then
				PreviousPage
			End If
		End If
	End If
End Sub

Private Sub PageChanged
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_PageChanged",m_Index)
	End If
	If m_LazyLoading Then InternLazyLoading
End Sub

Private Sub LazyLoadingAddContent(Parent As B4XView,Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_LazyLoadingAddContent", 2) Then
		CallSub3(mCallBack, mEventName & "_LazyLoadingAddContent",Parent,Value)
	End If
End Sub

#End Region