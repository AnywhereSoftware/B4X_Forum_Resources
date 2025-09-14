B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-BugFixes
	-Add GetItems - Get all items as list of AS_SelectionList_Item
V1.02
	-Improvements
	-Add SetSelections2 - Set the Selections via a list
	-Add get and set SideGap
		-Default: 10dip
	-Add get SelectedItemProperties
	-Add get ItemProperties
V1.03
	-New SelectionIconAlignment - Alignment of the check icon of an item when it is selected
		-Default: Right
		-Left or Right
	-New - get and set ShowSeperators
	-Update - If you set MaxVisibleItems to 0 then no limit is now set
V1.04
	-New SelectionItemChanged Event - In the event, the item that was checked/unchecked is returned in order to be able to react better instead of always having to go through the complete selected item list
V1.05
	-New DeselectItem - Deselect by AS_SelectionList_Item or AS_SelectionList_SubItem
	-New DeselectItem2 - Deselect by Value
#End If

#Event: ActionButtonClicked
#Event: Close
#Event: SelectionChanged
#Event: SelectionItemChanged(Item As Object,Checked As Boolean)

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private m_SelectionList As AS_SelectionList
	Private xpnl_ItemsBackground As B4XView
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xlbl_ActionButton As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_ActionButtonVisible As Boolean
	Private m_DragIndicatorColor As Int
	Private m_SheetWidth As Float = 0
	Private m_MaxVisibleItems As Int = 5
	Private m_ActionButtonBackgroundColor As Int
	Private m_ActionButtonTextColor As Int
	
	Type AS_BottomSelectionList_Theme(BodyColor As Int,TextColor As Int,DragIndicatorColor As Int,SelectionList As AS_SelectionList_Theme,ActionButtonBackgroundColor As Int,ActionButtonTextColor As Int)
	
End Sub

Public Sub getTheme_Light As AS_BottomSelectionList_Theme
	
	Dim Theme As AS_BottomSelectionList_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.TextColor = xui.Color_Black
	Theme.DragIndicatorColor = xui.Color_Black
	Theme.ActionButtonBackgroundColor = xui.Color_Black
	Theme.ActionButtonTextColor = xui.Color_White

	Dim SelectionListTheme As AS_SelectionList_Theme = m_SelectionList.Theme_Light
	SelectionListTheme.BackgroundColor = Theme.BodyColor
	SelectionListTheme.Item_BackgroundColor = Theme.BodyColor
	Theme.SelectionList = SelectionListTheme

	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_BottomSelectionList_Theme
	
	Dim Theme As AS_BottomSelectionList_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.TextColor = xui.Color_White
	Theme.DragIndicatorColor = xui.Color_White
	Theme.ActionButtonBackgroundColor = xui.Color_White
	Theme.ActionButtonTextColor = xui.Color_Black

	Dim SelectionListTheme As AS_SelectionList_Theme = m_SelectionList.Theme_Dark
	SelectionListTheme.BackgroundColor = Theme.BodyColor
	SelectionListTheme.Item_BackgroundColor = Theme.BodyColor
	Theme.SelectionList = SelectionListTheme

	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_BottomSelectionList_Theme)
	
	m_HeaderColor = Theme.BodyColor
	m_BodyColor = Theme.BodyColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	m_ActionButtonBackgroundColor = Theme.ActionButtonBackgroundColor
	m_ActionButtonTextColor = Theme.ActionButtonTextColor
	setColor(m_BodyColor)
	m_SelectionList.Theme = Theme.SelectionList
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xlbl_ActionButton = CreateLabel("xlbl_ActionButton")
	xpnl_DragIndicator = xui.CreatePanel("")
	xpnl_ItemsBackground = xui.CreatePanel("")
	
	m_SelectionList.Initialize(Me,"SelectionList")
	m_SelectionList.CreateViewPerCode(xpnl_ItemsBackground,0,0,100dip,100dip)
	m_SelectionList.ThemeChangeTransition = "None"
	m_SelectionList.Theme = m_SelectionList.Theme_Dark
	
	m_DragIndicatorColor = xui.Color_ARGB(80,255,255,255)
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_ActionButtonBackgroundColor = xui.Color_White
	m_ActionButtonTextColor = xui.Color_Black
	
	m_HeaderHeight = 30dip
	m_ActionButtonVisible = False

End Sub

Public Sub Clear
	m_SelectionList.Clear
End Sub

'Get all items as list of AS_SelectionList_Item
Public Sub GetItems As List
	Return m_SelectionList.GetItems
End Sub

Public Sub AddItem(Text As String,Icon As B4XBitmap,Value As Object) As AS_SelectionList_Item
	Return m_SelectionList.AddItem(Text,Icon,Value)
End Sub

Public Sub ShowPicker
	
	Dim SheetWidth As Float = IIf(m_SheetWidth=0,xParent.Width,m_SheetWidth)
	
	Dim ListHeight As Float = m_SelectionList.ItemProperties.Height*IIf(m_MaxVisibleItems=0,m_SelectionList.Size, Min(m_SelectionList.Size,m_MaxVisibleItems))
	Dim BodyHeight As Float = ListHeight
	Dim SafeAreaHeight As Float = 0
	
	If m_ActionButtonVisible Then
		BodyHeight = BodyHeight + 50dip
	End If
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	BodyHeight = BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	BodyHeight = BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,BodyHeight,BodyHeight,m_HeaderHeight,SheetWidth,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,SheetWidth/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	xlbl_ActionButton.RemoveViewFromParent
	
	If m_ActionButtonVisible Then
	
		xlbl_ActionButton.Text = "Confirm"
		xlbl_ActionButton.TextColor = m_ActionButtonTextColor
		xlbl_ActionButton.SetColorAndBorder(m_ActionButtonBackgroundColor,0,0,10dip)
		xlbl_ActionButton.SetTextAlignment("CENTER","CENTER")
		
		Dim ConfirmationButtoHeight As Float = 40dip
		Dim ConfirmationButtoWidth As Float = 220dip
		If SheetWidth < ConfirmationButtoWidth Then ConfirmationButtoWidth = SheetWidth - 20dip
		
		BottomCard.BodyPanel.AddView(xlbl_ActionButton,SheetWidth/2 - ConfirmationButtoWidth/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,ConfirmationButtoWidth,ConfirmationButtoHeight)
	
	End If
	

	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,SheetWidth,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,SheetWidth,ListHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	xpnl_ItemsBackground.RemoveViewFromParent
	xpnl_Body.AddView(xpnl_ItemsBackground,0,0,xpnl_Body.Width,ListHeight)
	m_SelectionList.Base_Resize(xpnl_ItemsBackground.Width,xpnl_ItemsBackground.Height)
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

#Region Properties

'Left or Right
'Default: Right
Public Sub setSelectionIconAlignment(Alignment As String)
	m_SelectionList.SelectionIconAlignment = Alignment
End Sub

Public Sub getSelectionIconAlignment As String
	Return m_SelectionList.SelectionIconAlignment
End Sub

Public Sub setShowSeperators(ShowSeperators As Boolean)
	m_SelectionList.ShowSeperators = ShowSeperators
End Sub

Public Sub getShowSeperators As Boolean
	Return m_SelectionList.ShowSeperators
End Sub

Public Sub getItemProperties As AS_SelectionList_ItemProperties
	Return m_SelectionList.ItemProperties
End Sub

Public Sub getSelectedItemProperties As AS_SelectionList_SelectedItemProperties
	Return m_SelectionList.SelectedItemProperties
End Sub

'Default: 10dip
Public Sub setSideGap(SideGap As Float)
	m_SelectionList.SideGap = SideGap
End Sub

Public Sub getSideGap As Float
	Return m_SelectionList.SideGap
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_SelectionList.ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_SelectionList.ThemeChangeTransition
End Sub

'Single or Multi
Public Sub getSelectionMode As String
	Return m_SelectionList.SelectionMode
End Sub

Public Sub setSelectionMode(SelectionMode As String)
	m_SelectionList.SelectionMode = SelectionMode
End Sub

'<code>
'	For Each Item As AS_SelectionList_Item In BottomSelectionList.GetSelections
'		Log("Item selected: " & Item.Text)
'	Next
'</code>
Public Sub GetSelections As List
	Return m_SelectionList.GetSelections
End Sub

'<code>BottomSelectionList.SetSelections(Array As Object(1,3))</code>
Public Sub SetSelections(Values() As Object)
	m_SelectionList.SetSelections(Values)
End Sub

'<code>
'	Dim lst As List
'	lst.Initialize
'	lst.Add(1)
'	lst.Add(3)
'	BottomSelectionList.SetSelections2(lst)
'</code>
Public Sub SetSelections2(Values As List)
	m_SelectionList.SetSelections2(Values)
End Sub

'Returns True if the item was found
Public Sub DeselectItem(Item As Object) As Boolean
	Return m_SelectionList.DeselectItem(Item)
End Sub

'Returns True if the item was found
Public Sub DeselectItem2(Value As Object) As Boolean
	Return m_SelectionList.DeselectItem2(Value)
End Sub

'The maximum number of items that are visible before it becomes a list and must be scrolled
'Default: 5
Public Sub setMaxVisibleItems(MaxVisibleItems As Int)
	m_MaxVisibleItems = MaxVisibleItems
End Sub

Public Sub getMaxVisibleItems As Int
	Return m_MaxVisibleItems
End Sub

Public Sub getSelectionList As AS_SelectionList
	Return m_SelectionList
End Sub

'Set the value to greater than 0 to set a custom width
'Set the value to 0 to use the full screen width
'Default: 0
Public Sub setSheetWidth(SheetWidth As Float)
	m_SheetWidth = SheetWidth
End Sub

Public Sub getSheetWidth As Float
	Return m_SheetWidth
End Sub

Public Sub setDragIndicatorColor(Color As Int)
	m_DragIndicatorColor = Color
End Sub

Public Sub getDragIndicatorColor As Int
	Return m_DragIndicatorColor
End Sub

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	If BottomCard.IsInitialized Then BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
	xpnl_Body.Color = Color
	xpnl_Header.Color = Color
End Sub

Public Sub getColor As Int
	Return m_BodyColor
End Sub

Public Sub getActionButton As B4XView
	Return xlbl_ActionButton
End Sub

Public Sub getActionButtonVisible As Boolean
	Return m_ActionButtonVisible
End Sub

Public Sub setActionButtonVisible(Visible As Boolean)
	m_ActionButtonVisible = Visible
End Sub

'Get the number of items
Public Sub getSize As Int
	Return m_SelectionList.Size
End Sub

#End Region

#Region Events

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack, mEventName & "_Close",0) Then
		CallSub(mCallBack, mEventName & "_Close")
	End If
End Sub

#If B4J
Private Sub xlbl_ActionButton_MouseClicked (EventData As MouseEvent)
	ActionButtonClicked
End Sub
#Else
Private Sub xlbl_ActionButton_Click
	ActionButtonClicked
End Sub
#End If

Private Sub ActionButtonClicked
	XUIViewsUtils.PerformHapticFeedback(xpnl_ItemsBackground)
	If xui.SubExists(mCallBack, mEventName & "_ActionButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ActionButtonClicked")
	End If
End Sub

Private Sub SelectionList_SelectionChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectionChanged",0) Then
		CallSub(mCallBack, mEventName & "_SelectionChanged")
	End If
End Sub

Private Sub SelectionList_SelectionItemChanged(Item As Object,Checked As Boolean)
	If xui.SubExists(mCallBack, mEventName & "_SelectionItemChanged",2) Then
		CallSub3(mCallBack, mEventName & "_SelectionItemChanged",Item,Checked)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

#End Region

#Region Enums

Public Sub getThemeChangeTransition_Fade As String
	Return "Fade"
End Sub

Public Sub getThemeChangeTransition_None As String
	Return "None"
End Sub

Public Sub getSelectionMode_Single As String
	Return "Single"
End Sub

Public Sub getSelectionMode_Multi As String
	Return "Multi"
End Sub


Public Sub getSelectionIconAlignment_Left As String
	Return "LEFT"
End Sub

Public Sub getSelectionIconAlignment_Right As String
	Return "RIGHT"
End Sub

#End Region

#Region Types

#End Region
