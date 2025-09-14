B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add get and set DialogYesText
		-Default: OK
	-Add get and set DialogNoText
		-Default: CANCEL
	-Add get and set DialogCancelText
V1.02
	-BugFixes
	-Add SetDarkMode - Sets the dialog to DarkMode
	-Add SetLightMode - Sets the dialog to LightMode
V1.03
	-Add Close - Closes the Dialog
V1.04
	-BugFix on TimeFormat_12h and PM times
	-B4J - Buttons should now work
V1.05
	-Keyboard Type on the TextFields are now numbers
V1.06
	-Add set Date - You can now set the initial time with ticks
	-BugFix on TimeFormat_12h
	-Add isPm to AS_TimePickerDialog_DialogResponse
	-Add Date to AS_TimePickerDialog_DialogResponse
	-If you are using the TimeFormat 12h then the DialogResponse.Hour returns now 0-12 and you need to check with .isPm if it is am or pm
V1.07
	-New get Dialog - gets the B4XDialog
#End If

Sub Class_Globals
	
	Type AS_TimePickerDialog_Theming(BackgroundColor As Int,ThumbColor As Int,ClockTextColor As Int,DialogButtonTextColor As Int,EditTextColor As Int,EditTextFocusColor As Int,TimePickerBackgroundColor As Int)
	Type AS_TimePickerDialog_DialogResponse(Result As Int,Hour As Int,Minute As Int,isPm As Boolean,Date As Long)
	
	Private g_Theming As AS_TimePickerDialog_Theming
	
	Private m_Dialog As B4XDialog
	Private xui As XUI
	Private xtf_Hour As B4XView
	Private xtf_Minutes As B4XView
	Private AS_TimerPicker1 As AS_TimerPicker
	Private isIgnoreTimePickerEvent As Boolean = True
	Private m_KeyboardEnabled As Boolean
	Private m_MinuteSteps As Int
	Private m_TimeFormat As String
	
	Private xpnl_TimePickerBackground As B4XView
	Private xlbl_Seperator As B4XView
	Private xlbl_Hour As B4XView
	Private xlbl_Minutes As B4XView

	Private xpnl_AmPm As B4XView
	Private xlbl_Am As B4XView
	Private xlbl_Pm As B4XView
	Private m_HapticFeedback As Boolean = True 'Ignore
	Private m_Hour As Int
	Private m_Minute As Int
	Private m_isPm As Boolean
	Private m_DialogYesText As String
	Private m_DialogNoText As String
	Private m_DialogCancelText As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As B4XView)
	
	m_Dialog.Initialize(Parent)

	m_MinuteSteps = 1
	m_TimeFormat = getTimeFormat_24h

	m_DialogYesText = "OK"
	m_DialogNoText = "CANCEL"

	g_Theming.Initialize
	SetLightMode

	m_Hour = DateTime.GetHour(DateTime.Now)
	m_Minute = DateTime.GetMinute(DateTime.Now)

End Sub

'<code>	Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
'If PickerDialogResponse.Result = xui.DialogResponse_Positive Then
'End If</code>
Public Sub ShowDialog As ResumableSub
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.SetLayoutAnimated(0,0,0,Min(400dip,m_Dialog.mParent.Width - 40dip),500dip)
	xpnl_Background.LoadLayout("frm_TimePickerDialog")
	
	#If B4I
	xtf_Hour.As(TextField).KeyboardType = xtf_Hour.As(TextField).TYPE_NUMBER_PAD
	xtf_Minutes.As(TextField).KeyboardType = xtf_Minutes.As(TextField).TYPE_NUMBER_PAD
	#Else If B4A
	xtf_Hour.As(EditText).InputType = xtf_Hour.As(EditText).INPUT_TYPE_NUMBERS
	xtf_Minutes.As(EditText).InputType = xtf_Minutes.As(EditText).INPUT_TYPE_NUMBERS
	#End If
	
	m_Dialog.BorderCornersRadius = 20dip
	m_Dialog.BorderWidth = 0
	xpnl_Background.Color = g_Theming.BackgroundColor
	xpnl_TimePickerBackground.Color = g_Theming.TimePickerBackgroundColor
	AS_TimerPicker1.BackgroundColor = g_Theming.TimePickerBackgroundColor
	AS_TimerPicker1.ThumbColor = g_Theming.ThumbColor
	AS_TimerPicker1.ThumbLineColor = g_Theming.ThumbColor
	AS_TimerPicker1.TextColor = g_Theming.ClockTextColor
	m_Dialog.ButtonsTextColor = g_Theming.DialogButtonTextColor
	m_Dialog.BackgroundColor = g_Theming.BackgroundColor
	m_Dialog.ButtonsColor = xui.Color_Transparent
	xtf_Hour.TextColor = g_Theming.EditTextColor
	xtf_Minutes.TextColor = g_Theming.EditTextColor
	xtf_Minutes.Color = g_Theming.TimePickerBackgroundColor
	xtf_Hour.Color = g_Theming.TimePickerBackgroundColor
	xlbl_Seperator.TextColor = g_Theming.ClockTextColor
	xlbl_Hour.TextColor = g_Theming.EditTextColor
	xlbl_Minutes.TextColor = g_Theming.EditTextColor
	xlbl_Hour.Color = g_Theming.TimePickerBackgroundColor
	xlbl_Minutes.Color = g_Theming.TimePickerBackgroundColor
	xlbl_Am.TextColor = g_Theming.EditTextColor
	xlbl_Pm.TextColor = g_Theming.EditTextColor
	xpnl_AmPm.SetColorAndBorder(g_Theming.TimePickerBackgroundColor,0,0,10dip)
	SetCircleClip(xpnl_AmPm,10dip)
	
	AS_TimerPicker1.MinuteSteps = m_MinuteSteps
	AS_TimerPicker1.TimeFormat = m_TimeFormat
	
	xtf_Hour.Visible = m_KeyboardEnabled
	xtf_Minutes.Visible = m_KeyboardEnabled
	xlbl_Hour.Visible = m_KeyboardEnabled = False
	xlbl_Minutes.Visible = m_KeyboardEnabled = False
	
	ColorChange(True)
	
	
	If m_TimeFormat = getTimeFormat_12h Then
		
		xpnl_AmPm.Visible = True
		
		xtf_Hour.Width = IIf(xpnl_Background.Width < 400dip,(xpnl_Background.Width - 40dip - xlbl_Seperator.Width - xpnl_AmPm.Width)/2, 140dip)
		xtf_Minutes.Width = IIf(xpnl_Background.Width < 400dip,(xpnl_Background.Width - 40dip - xlbl_Seperator.Width - xpnl_AmPm.Width)/2, 140dip)
		
		xpnl_AmPm.Left = xpnl_Background.Width - 10dip - xpnl_AmPm.Width
		
		xtf_Minutes.Left = xpnl_AmPm.Left - 10dip - xtf_Minutes.Width
		xlbl_Seperator.Left = xtf_Minutes.Left - 5dip - xlbl_Seperator.Width
		xtf_Hour.Left = xlbl_Seperator.Left - 5dip - xtf_Hour.Width
		
		xtf_Hour.Text = IIf(m_Hour > 12,NumberFormat(m_Hour-12,2,0),NumberFormat(m_Hour,2,0))
		
	Else
			
		xtf_Hour.Width = IIf(xpnl_Background.Width < 400dip,(xpnl_Background.Width - 40dip - xlbl_Seperator.Width)/2, 160dip)
		xtf_Minutes.Width = IIf(xpnl_Background.Width < 400dip,(xpnl_Background.Width - 40dip - xlbl_Seperator.Width)/2, 160dip)
			
		xpnl_AmPm.Visible = False
		xlbl_Seperator.Left = xpnl_Background.Width/2 - xlbl_Seperator.Width/2
		xtf_Hour.Left = xlbl_Seperator.Left - 5dip - xtf_Hour.Width
		xtf_Minutes.Left = xlbl_Seperator.Left + xlbl_Seperator.Width + 5dip
			
		xtf_Hour.Text = NumberFormat(m_Hour,2,0)
			
	End If
	
	AS_TimerPicker1.Hours = m_Hour
	AS_TimerPicker1.Minutes =  m_Minute
	xtf_Minutes.Text = NumberFormat(m_Minute,2,0)
	xlbl_Hour.Text = xtf_Hour.Text
	xlbl_Minutes.Text = xtf_Minutes.Text
	
	xlbl_Hour.Left = xtf_Hour.Left
	xlbl_Minutes.Left = xtf_Minutes.Left
	xlbl_Hour.Width = xtf_Hour.Width
	xlbl_Minutes.Width = xtf_Hour.Width
	
	If m_isPm Then
		xlbl_Pm.Color = xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3))
	Else
		xlbl_Am.Color = xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3))
	End If
	
	Sleep(0)
	isIgnoreTimePickerEvent = False

	SetCircleClip(xpnl_Background,20dip)

#If B4J
	CSSUtils.SetStyleProperty(xtf_Hour, "-fx-padding", "0 0 0 0")
	CSSUtils.SetStyleProperty(xtf_Minutes, "-fx-padding", "0 0 0 0")
#End If


	Wait For (m_Dialog.ShowCustom(xpnl_Background,m_DialogYesText,m_DialogNoText,m_DialogCancelText)) Complete (Result As Int)
	Dim PickerDialogResponse As AS_TimePickerDialog_DialogResponse
	PickerDialogResponse.Initialize
	PickerDialogResponse.Result = Result
	PickerDialogResponse.Hour = AS_TimerPicker1.Hours
	PickerDialogResponse.Minute = AS_TimerPicker1.Minutes
	PickerDialogResponse.isPm = m_isPm Or IIf(PickerDialogResponse.Hour > 11,True,False)
	If m_TimeFormat = getTimeFormat_12h Then
		PickerDialogResponse.Date = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.now),DateTime.GetMonth(DateTime.now),DateTime.GetDayOfMonth(DateTime.now),IIf(m_isPm,PickerDialogResponse.Hour +12,PickerDialogResponse.Hour),PickerDialogResponse.Minute,0)
	Else
		PickerDialogResponse.Date = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.now),DateTime.GetMonth(DateTime.now),DateTime.GetDayOfMonth(DateTime.now),PickerDialogResponse.Hour,PickerDialogResponse.Minute,0)
	End If
	Return PickerDialogResponse
End Sub

'Closes the dialog
Public Sub Close
	m_Dialog.Close(xui.DialogResponse_Cancel)
End Sub

Public Sub getDialog As B4XDialog
	Return m_Dialog
End Sub

Private Sub ColorChange(isHour As Boolean)
	
	If isHour Then
		xlbl_Hour.SetColorAndBorder(xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3)),0,0,10dip)
		xlbl_Minutes.SetColorAndBorder(g_Theming.TimePickerBackgroundColor,0,0,10dip)
		xtf_Hour.SetColorAndBorder(xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3)),0,0,10dip)
		xtf_Minutes.SetColorAndBorder(g_Theming.TimePickerBackgroundColor,0,0,10dip)
		xlbl_Hour.TextColor = g_Theming.EditTextFocusColor
		xlbl_Minutes.TextColor = g_Theming.EditTextColor
		xtf_Hour.TextColor = g_Theming.EditTextFocusColor
		xtf_Minutes.TextColor = g_Theming.EditTextColor
	Else
		xlbl_Hour.SetColorAndBorder(g_Theming.TimePickerBackgroundColor,0,0,10dip)
		xlbl_Minutes.SetColorAndBorder(xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3)),0,0,10dip)
		xtf_Hour.SetColorAndBorder(g_Theming.TimePickerBackgroundColor,0,0,10dip)
		xtf_Minutes.SetColorAndBorder(xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3)),0,0,10dip)
		xlbl_Hour.TextColor = g_Theming.EditTextColor
		xlbl_Minutes.TextColor = g_Theming.EditTextFocusColor
		xtf_Hour.TextColor = g_Theming.EditTextColor
		xtf_Minutes.TextColor = g_Theming.EditTextFocusColor
	End If
	
End Sub

Public Sub SetDarkMode As AS_TimePickerDialog_Theming
	g_Theming.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	g_Theming.ClockTextColor = xui.Color_White
	g_Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.EditTextColor = xui.Color_White
	g_Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	Return g_Theming
End Sub

Public Sub SetLightMode As AS_TimePickerDialog_Theming
	g_Theming.BackgroundColor = xui.Color_White
	g_Theming.ClockTextColor = xui.Color_Black
	g_Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.EditTextColor = xui.Color_Black
	g_Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)
	g_Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,245,246,247)
	Return g_Theming
End Sub

#Region Enums

Public Sub getTimeFormat_12h As String
	Return "12h"
End Sub

Public Sub getTimeFormat_24h As String
	Return "24h"
End Sub

#End Region

#Region Properties

Public Sub setDate(Date As Long)
	m_Hour = DateTime.GetHour(Date)
	m_Minute = DateTime.GetMinute(Date)
	m_isPm = IIf(m_Hour >= 12,True,False)
End Sub

Public Sub setisPm(isPm As Boolean)
	m_isPm = isPm
End Sub

Public Sub setDialogCancelText(Text As String)
	m_DialogCancelText = Text
End Sub

Public Sub getDialogCancelText As String
	Return m_DialogCancelText
End Sub
'Default: CANCEL
Public Sub setDialogNoText(Text As String)
	m_DialogNoText = Text
End Sub

Public Sub getDialogNoText As String
	Return m_DialogNoText
End Sub
'Default: OK
Public Sub setDialogYesText(Text As String)
	m_DialogYesText = Text
End Sub

Public Sub getDialogYesText As String
	Return m_DialogYesText
End Sub

Public Sub getMinute As Int
	Return m_Minute
End Sub

Public Sub setMinute(Minute As Int)
	m_Minute = Minute
End Sub

Public Sub getHour As Int
	Return m_Hour
End Sub

Public Sub setHour(Hour As Int)
	m_Hour = Hour
End Sub

'24h|12h
'Default: 24h
Public Sub setTimeFormat(Format As String)
	m_TimeFormat = Format
End Sub

Public Sub getTimeFormat As String
	Return m_TimeFormat
End Sub

'Indicates in how many steps the selector can be moved
'Default: 1
Public Sub setMinuteSteps(Steps As Int)
	m_MinuteSteps = Steps
End Sub

Public Sub getMinuteSteps As Int
	Return m_MinuteSteps
End Sub

Public Sub Theming As AS_TimePickerDialog_Theming
	Return g_Theming
End Sub

Public Sub getKeyboardEnabled As Boolean
	Return m_KeyboardEnabled
End Sub

Public Sub setKeyboardEnabled(Enabled As Boolean)
	m_KeyboardEnabled = Enabled
End Sub

'Public Sub getHapticFeedback As Boolean
'	Return m_HapticFeedback
'End Sub
'
'Public Sub setHapticFeedback(Haptic As Boolean)
'	m_HapticFeedback = Haptic
'End Sub

#End Region

#Region Events

#If B4I
Private Sub xtf_Hour_BeginEdit
	ColorChange(True)
	xtf_Hour.SelectAll
	AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_HourSelection)
End Sub

Private Sub xtf_Minutes_BeginEdit
	ColorChange(False)
	xtf_Minutes.SelectAll
	AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_MinuteSelection)
End Sub

#End If

Private Sub xtf_Hour_TextChanged (OldText As String, NewText As String)
	isIgnoreTimePickerEvent = True
	If IsNumber(NewText) And NewText >= 0 And NewText <= 23 Then
		AS_TimerPicker1.Hours = NewText
	Else If NewText = "" Then
			
	Else
		AS_TimerPicker1.Hours = OldText
		xtf_Hour.Text = OldText
	End If
	Sleep(0)
	isIgnoreTimePickerEvent = False
End Sub

Private Sub xtf_Minutes_TextChanged (OldText As String, NewText As String)
	isIgnoreTimePickerEvent = True
	If IsNumber(NewText) And NewText >= 0 And NewText <= 59 Then
		AS_TimerPicker1.Minutes = NewText
	Else If NewText = "" Then
	Else
		AS_TimerPicker1.Minutes = OldText
		xtf_Minutes.Text = OldText
	End If
	Sleep(0)
	isIgnoreTimePickerEvent = False
End Sub

#If B4I
Private Sub xtf_Hour_EndEdit
	If xtf_Hour.Text = "" Then
		AS_TimerPicker1.Hours = 0
		xtf_Hour.Text = 0
	End If
End Sub
#Else
Private Sub xtf_Hour_FocusChanged (HasFocus As Boolean)
	If HasFocus = False Then
		If xtf_Hour.Text = "" Then
			AS_TimerPicker1.Hours = 0
			xtf_Hour.Text = 0
		End If
		Else
		ColorChange(True)
		AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_HourSelection)
		#If B4J
		Sleep(0)
		#End If
		xtf_Hour.SelectAll
	End If
End Sub
#End If

Private Sub xtf_Minutes_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		ColorChange(False)
		AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_MinuteSelection)
			#If B4J
		Sleep(0)
		#End If
		xtf_Minutes.SelectAll
	End If
End Sub

Private Sub xtf_Hour_EnterPressed
	xtf_Minutes.RequestFocus
End Sub


Private Sub AS_TimerPicker1_SelectedHourChanged (Hour As Int)
	If isIgnoreTimePickerEvent = False Then
		#If B4I
	B4XPages.GetNativeParent(B4XPages.MainPage).ResignFocus
	#Else If B4A
	Dim ime As IME
	ime.Initialize("")
	ime.HideKeyboard
		#End If
		xtf_Hour.Text =  NumberFormat(Hour,2,0)
		xlbl_Hour.Text =  NumberFormat(Hour,2,0)
	End If
End Sub

Private Sub AS_TimerPicker1_SelectedMinuteChanged (Minute As Int)
	If isIgnoreTimePickerEvent = False Then
		#If B4I
	B4XPages.GetNativeParent(B4XPages.MainPage).ResignFocus
		#Else If B4A
		Dim ime As IME
		ime.Initialize("")
		ime.HideKeyboard
	#End If
		xtf_Minutes.Text = NumberFormat(Minute,2,0)
		xlbl_Minutes.Text = NumberFormat(Minute,2,0)
	End If
End Sub

Private Sub AS_TimerPicker1_SelectedHour (Hour As Int)
	ColorChange(False)
End Sub

#If B4J
Private Sub xlbl_Am_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Am_Click
#End If
	m_isPm = False
	HourClick
	xlbl_Am.Color = xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3))
	xlbl_Pm.Color = g_Theming.TimePickerBackgroundColor
End Sub

#If B4J
Private Sub xlbl_Pm_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Pm_Click
#End If
	m_isPm = True
	HourClick
	xlbl_Pm.Color = xui.Color_ARGB(40,GetARGB(g_Theming.EditTextFocusColor)(1),GetARGB(g_Theming.EditTextFocusColor)(2),GetARGB(g_Theming.EditTextFocusColor)(3))
	xlbl_Am.Color = g_Theming.TimePickerBackgroundColor
End Sub

Private Sub HourClick
	ColorChange(True)
	AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_HourSelection)
End Sub

#If B4J
Private Sub xlbl_Hour_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Hour_Click
#End If
	HourClick
End Sub

#If B4J
Private Sub xlbl_Minutes_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Minutes_Click
#End If
	ColorChange(False)
	AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_MinuteSelection)
End Sub

#End Region

#Region Functions

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
Dim jo As JavaObject = pnl
Dim shape As JavaObject
Dim cx As Double = pnl.Width
Dim cy As Double = pnl.Height
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
	pnl.SetColorAndBorder(pnl.Color,0,0,radius)
	#Else If B4I
'	Dim NaObj As NativeObject = pnl
'	Dim BorderWidth As Float = NaObj.GetField("layer").GetField("borderWidth").AsNumber
'	' *** Get border color ***
'	Dim noMe As NativeObject = Me
'	Dim BorderUIColor As Int = noMe.UIColorToColor (noMe.RunMethod ("borderColor:", Array (pnl)))
'	pnl.SetColorAndBorder(pnl.Color,BorderWidth,BorderUIColor,radius)
#end if
End Sub

#End Region
