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
#End If

#Event: ActionButtonClicked
#Event: Close

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xDateTimePicker As AS_WheelDateTimePicker 'ignore
	
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
	Private m_DateTimePickerTheme As AS_WheelDateTimePicker_Theme
	Private m_ActionButtonColor As Int
	Private m_ActionButtonTextColor As Int
	Private m_PickerHeight As Float = 250dip
	
	Type AS_BottomWheelDateTimePicker_Theme(BodyColor As Int,DragIndicatorColor As Int,ActionButtonColor As Int,ActionButtonTextColor As Int,DateTimePickerTheme As AS_WheelDateTimePicker_Theme)
	
End Sub

Public Sub getTheme_Light As AS_BottomWheelDateTimePicker_Theme
	
	Dim Theme As AS_BottomWheelDateTimePicker_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.DragIndicatorColor = xui.Color_Black
	Theme.ActionButtonColor = xui.Color_Black
	Theme.ActionButtonTextColor = xui.Color_White
	Theme.DateTimePickerTheme = xDateTimePicker.Theme_Light
	Theme.DateTimePickerTheme.BackgroundColor = Theme.BodyColor
	Theme.DateTimePickerTheme.FadeColor = Theme.BodyColor
	
	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_BottomWheelDateTimePicker_Theme
	
	Dim Theme As AS_BottomWheelDateTimePicker_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.DragIndicatorColor = xui.Color_White
	Theme.ActionButtonColor = xui.Color_White
	Theme.ActionButtonTextColor = xui.Color_Black
	Theme.DateTimePickerTheme = xDateTimePicker.Theme_Dark
	Theme.DateTimePickerTheme.BackgroundColor = Theme.BodyColor
	Theme.DateTimePickerTheme.FadeColor = Theme.BodyColor
	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_BottomWheelDateTimePicker_Theme)
	
	m_HeaderColor = Theme.BodyColor
	m_BodyColor = Theme.BodyColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	m_ActionButtonColor = Theme.ActionButtonColor
	m_ActionButtonTextColor = Theme.ActionButtonTextColor
	m_DateTimePickerTheme = Theme.DateTimePickerTheme
	
	setColor(m_BodyColor)
	
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
	
	m_DragIndicatorColor = xui.Color_ARGB(80,255,255,255)
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_ActionButtonColor = xui.Color_White
	m_ActionButtonTextColor = xui.Color_Black
	
	m_HeaderHeight = 30dip
	m_ActionButtonVisible = False

	xpnl_Body.SetLayoutAnimated(0,0,0,Parent.Width,m_PickerHeight)
	xpnl_Body.LoadLayout("frm_BottomWheelDateTimePicker")
	m_DateTimePickerTheme = xDateTimePicker.Theme_Dark

End Sub

Public Sub ShowPicker
	
	Dim SheetWidth As Float = IIf(m_SheetWidth=0,xParent.Width,m_SheetWidth)
	
	Dim BodyHeight As Float = m_PickerHeight
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
	
	xpnl_Header.AddView(xpnl_DragIndicator,SheetWidth/2 - 70dip/2,m_HeaderHeight - 6dip,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	xlbl_ActionButton.RemoveViewFromParent
	
	If m_ActionButtonVisible Then
	
		xlbl_ActionButton.Text = "Choose"
		xlbl_ActionButton.TextColor = m_ActionButtonTextColor
		xlbl_ActionButton.SetColorAndBorder(m_ActionButtonColor,0,0,10dip)
		xlbl_ActionButton.SetTextAlignment("CENTER","CENTER")
		
		Dim ConfirmationButtoHeight As Float = 40dip
		Dim ConfirmationButtoWidth As Float = 220dip
		If SheetWidth < ConfirmationButtoWidth Then ConfirmationButtoWidth = SheetWidth - 20dip
		
		BottomCard.BodyPanel.AddView(xlbl_ActionButton,SheetWidth/2 - ConfirmationButtoWidth/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,ConfirmationButtoWidth,ConfirmationButtoHeight)
	
	End If
	
	'xpnl_Body.RemoveViewFromParent
	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,SheetWidth,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,SheetWidth,m_PickerHeight)
	BottomCard.CornerRadius_Header = 30dip/2

	xpnl_Body.Color = m_BodyColor
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xDateTimePicker.WheelPicker.ItemTextProperties
	ItemTextProperties.TextFont = xui.CreateDefaultBoldFont(18)
	xDateTimePicker.WheelPicker.ItemTextProperties = ItemTextProperties
	xDateTimePicker.WheelPicker.RowHeightSelected = 40dip
	xDateTimePicker.WheelPicker.RowHeightUnSelected = 40dip
	xDateTimePicker.ThemeChangeTransition = xDateTimePicker.ThemeChangeTransition_None
	xDateTimePicker.Theme = m_DateTimePickerTheme
	xDateTimePicker.Create
	Sleep(0)
	BottomCard.Show(False)
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

#Region Properties

Public Sub getWheelDateTimePicker As AS_WheelDateTimePicker
	Return xDateTimePicker
End Sub

Public Sub getPickerType As String
	Return xDateTimePicker.PickerType
End Sub

Public Sub setPickerType(PickerType As String)
	xDateTimePicker.PickerType = PickerType
End Sub

Public Sub getDatePicker_MinDate As Long
	Return xDateTimePicker.MinDate
End Sub

Public Sub getDatePicker_MaxDate As Long
	Return xDateTimePicker.MaxDate
End Sub

Public Sub setDatePicker_MinDate(Date As Long)
	xDateTimePicker.MinDate = Date
End Sub

Public Sub setDatePicker_MaxDate(Date As Long)
	xDateTimePicker.MaxDate = Date
End Sub

Public Sub getHour As Int
	Return xDateTimePicker.Hour
End Sub

Public Sub setHour(Hour As Int)
	 xDateTimePicker.Hour = Hour
End Sub

Public Sub setMinute(Minute As Int)
	 xDateTimePicker.Minute = Minute
End Sub

Public Sub getMinute As Int
	Return xDateTimePicker.Minute
End Sub

'The separator between hour and minute is usually a colon ( : )
Public Sub getTimePicker_TimeDivider As Boolean
	Return xDateTimePicker.ShowTimeDivider
End Sub

Public Sub setTimePicker_TimeDivider(TimeDivider As Boolean)
	xDateTimePicker.ShowTimeDivider = TimeDivider
End Sub

'Display time unit (12hour 05 min) can be changed with the HourShort and MinuteShort property
Public Sub getTimePicker_TimeUnit As Boolean
	Return xDateTimePicker.ShowTimeUnit
End Sub

Public Sub setTimePicker_TimeUnit(TimeUnit As Boolean)
	xDateTimePicker.ShowTimeUnit = TimeUnit
End Sub

'Show the AM and PM column
Public Sub getTimePicker_ShowAMPM As Boolean
	Return xDateTimePicker.showAMPM
End Sub

Public Sub setTimePicker_ShowAMPM(AMPM As Boolean)
	xDateTimePicker.showAMPM = AMPM
End Sub

'Show the date column in the TimePicker
Public Sub getTimePicker_ShowDate As Boolean
	Return xDateTimePicker.showDate
End Sub

Public Sub setTimePicker_ShowDate(Show As Boolean)
	xDateTimePicker.showDate = Show
End Sub

Public Sub getTimePicker_HourShortText As String
	Return xDateTimePicker.HourShortText
End Sub

Public Sub setTimePicker_HourShortText(HourShort As String)
	xDateTimePicker.HourShortText = HourShort
End Sub

Public Sub getTimePicker_MinuteShortText As String
	Return xDateTimePicker.MinuteShortText
End Sub

Public Sub setTimePicker_MinuteShortText(MinuteShort As String)
	xDateTimePicker.MinuteShortText = MinuteShort
End Sub

Public Sub getTimePicker_MinuteSteps As Int
	Return xDateTimePicker.MinuteSteps
End Sub

Public Sub setTimePicker_MinuteSteps(MinuteSteps As Int)
	xDateTimePicker.MinuteSteps = MinuteSteps
End Sub

'Set it after you set the PickerType
Public Sub getDate As Long
	Return xDateTimePicker.Date
End Sub

Public Sub setDate(Date As Long)
	xDateTimePicker.Date = Date
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

Public Sub setTextColor(Color As Int)
	xpnl_DragIndicator.Color = xui.Color_ARGB(80,GetARGB(Color)(1),GetARGB(Color)(2),GetARGB(Color)(3))
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

#End Region

#Region Events

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack, mEventName & "_Close",0) Then
		CallSub(mCallBack, mEventName & "_Close")
	End If
End Sub

#If B4J
Private Sub xlbl_ActionButton_MouseClicked (EventData As MouseEvent)
	ActionButtonClicked(Sender)
End Sub
#Else
Private Sub xlbl_ActionButton_Click
	ActionButtonClicked(Sender)
End Sub
#End If

Private Sub ActionButtonClicked(xLabel As B4XView)
	XUIViewsUtils.PerformHapticFeedback(xLabel)
	If xui.SubExists(mCallBack, mEventName & "_ActionButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ActionButtonClicked")
	End If
End Sub

#End Region

#Region Enums

Public Sub getThemeChangeTransition_Fade As String
	Return "Fade"
End Sub

Public Sub getThemeChangeTransition_None As String
	Return "None"
End Sub

Public Sub getPickerType_TimePicker As String
	Return "TimePicker"
End Sub

Public Sub getPickerType_DatePicker As String
	Return "DatePicker"
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

