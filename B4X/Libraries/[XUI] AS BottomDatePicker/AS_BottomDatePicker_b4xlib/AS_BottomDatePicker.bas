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
	-BugFix
#End If

#Event: ConfirmButtonClicked
#Event: SelectedDateChanged(Date As Long)
#Event: SelectedDateRangeChanged(StartDate As Long, EndDate As Long)


Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xDatePicker As AS_DatePicker
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xlbl_ConfirmationButton As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_BodyHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_ConfirmationMode As String
	Private m_SelectMode As String
	
	Private m_SelectedDate As Long
	Private m_SelectedStartDate As Long
	Private m_SelectedEndDate As Long
	
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xlbl_ConfirmationButton = CreateLabel("xlbl_ConfirmationButton")
	xpnl_DragIndicator = xui.CreatePanel("")
	
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_HeaderHeight = 20dip
	m_BodyHeight = 350dip
	m_ConfirmationMode = getConfirmationMode_SelectionChanged
	
	m_SelectMode = getSelectMode_Day
	
	m_SelectedDate = DateTime.Now
	m_SelectedStartDate = DateTime.Now
	m_SelectedEndDate = DateTime.Now
	
End Sub

Public Sub ShowPicker
	
	Dim DatePickerHeight As Float = m_BodyHeight
	Dim SafeAreaHeight As Float = 0
	
	If m_ConfirmationMode = getConfirmationMode_Button Then
		m_BodyHeight = m_BodyHeight + 50dip
	End If
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,m_BodyHeight,m_BodyHeight,m_HeaderHeight,xParent.Width,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,xParent.Width/2 - 70dip/2,m_HeaderHeight - 6dip,70dip,6dip)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,255,255,255),0,0,3dip)
	
	xlbl_ConfirmationButton.RemoveViewFromParent
	
	If m_ConfirmationMode = getConfirmationMode_Button Then
	
		xlbl_ConfirmationButton.Text = "Confirm"
		xlbl_ConfirmationButton.TextColor = xui.Color_White
		xlbl_ConfirmationButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)
		xlbl_ConfirmationButton.SetTextAlignment("CENTER","CENTER")
		
		Dim ConfirmationButtoHeight As Float = 40dip
		
		BottomCard.BodyPanel.AddView(xlbl_ConfirmationButton,xParent.Width/2 - 220dip/2,m_BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,220dip,ConfirmationButtoHeight)
	
	End If
	

	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,xParent.Width,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,xParent.Width,DatePickerHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	
	'xpnl_Body.SetLayoutAnimated(0,0,0,xParent.Width,m_BodyHeight)
	xpnl_Body.LoadLayout("frm_DatePicker")
	
	xDatePicker.SelectedDate = DateTime.Now
	xDatePicker.SelectMode = m_SelectMode
	xDatePicker.HeaderColor = m_HeaderColor
	xDatePicker.HeaderProperties.Height = 60dip
	xDatePicker.HeaderProperties.ArrowsVisible = False
	xDatePicker.RefreshHeader
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

#Region Properties

Public Sub getSelectedDate As Long
	Return m_SelectedDate
End Sub

Public Sub getSelectedStartDate As Long
	Return m_SelectedStartDate
End Sub
'Only in Range mode
Public Sub getSelectedEndDate As Long
	Return m_SelectedEndDate
End Sub

Public Sub setSelectMode(Mode As String)
	m_SelectMode= Mode
End Sub

Public Sub getSelectMode As String
	Return m_SelectMode
End Sub

Public Sub setTextColor(Color As Int)
	
	xDatePicker.BodyProperties.TextColor = Color
	xDatePicker.HeaderProperties.TextColor = Color
	xDatePicker.WeekNameProperties.TextColor = Color
	xpnl_DragIndicator.Color = xui.Color_ARGB(80,GetARGB(Color)(1),GetARGB(Color)(2),GetARGB(Color)(3))
	
	xDatePicker.RefreshHeader
	xDatePicker.Refresh
End Sub

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
	xpnl_Body.Color = Color
	xpnl_Header.Color = Color
	xDatePicker.BodyColor = Color
	xDatePicker.HeaderColor = Color
	xDatePicker.WeekNameProperties.Color = Color
	xDatePicker.Refresh
	xDatePicker.RefreshHeader
End Sub

Public Sub getConfirmationButton As B4XView
	Return xlbl_ConfirmationButton
End Sub

'SelectionChanged - The menu closes when the user has selected a day
'Button - The menu closes only when the user clicks on the confirmation button
'Default: SelectionChanged
Public Sub setConfirmationMode(Mode As String)
	m_ConfirmationMode = Mode
End Sub

Public Sub getDatePicker As AS_DatePicker
	Return xDatePicker
End Sub

#End Region

#Region Enums

Public Sub getSelectMode_Day As String
	Return "Date"
End Sub

Public Sub getSelectMode_Range As String
	Return "Range"
End Sub

Public Sub getConfirmationMode_Button As String
	Return "Button"
End Sub

Public Sub getConfirmationMode_SelectionChanged As String
	Return "SelectionChanged"
End Sub

#End Region

#Region Events

#If B4J
Private Sub xlbl_ConfirmationButton_MouseClicked (EventData As MouseEvent)
	ConfirmButtonClicked
End Sub
#Else
Private Sub xlbl_ConfirmationButton_Click
	ConfirmButtonClicked
End Sub
#End If


Private Sub xDatePicker_SelectedDateChanged(Date As Long)	
	m_SelectedDate = Date
	m_SelectedStartDate = Date
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged",1) Then
		CallSub2(mCallBack, mEventName & "_SelectedDateChanged",Date)
	End If
	Sleep(250)
	If m_ConfirmationMode = getConfirmationMode_SelectionChanged And m_SelectMode = getSelectMode_Day Then
		BottomCard.Hide(False)
	End If
End Sub

Private Sub xDatePicker_SelectedDateRangeChanged(StartDate As Long, EndDate As Long)
	m_SelectedStartDate = StartDate
	m_SelectedEndDate = EndDate
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateRangeChanged",2) Then
		CallSub3(mCallBack, mEventName & "_SelectedDateRangeChanged",StartDate,EndDate)
	End If
	Sleep(250)
	If m_ConfirmationMode = getConfirmationMode_SelectionChanged Then
		BottomCard.Hide(False)
	End If
End Sub

Private Sub ConfirmButtonClicked
	BottomCard.Hide(False)
	If xui.SubExists(mCallBack, mEventName & "_ConfirmButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ConfirmButtonClicked")
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

#End Region
