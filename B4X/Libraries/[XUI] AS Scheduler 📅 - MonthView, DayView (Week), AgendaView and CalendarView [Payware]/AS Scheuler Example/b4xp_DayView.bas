B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xlbl_ThemeMode As B4XView
	Private ASScheduler_DayView1 As ASScheduler_DayView
	Private B4XComboBox1 As B4XComboBox
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_DayView")
	
	B4XPages.SetTitle(Me,"DayView")
	
	ASScheduler_DayView1.CreateScheduler

	B4XComboBox1.SetItems(Array As String("1-Day","3-Days","5-Days","7-Days"))

End Sub

#Region Events

Private Sub ASScheduler_DayView1_AppointmentClick(Appointment As ASScheduler_Appointment)
	Log("ASScheduler_MonthView1_AppointmentClick: " & Appointment.Name)
	'Log(DateUtils.TicksToString(Appointment.StartDate))
	wait for (xui.MsgboxAsync("ASScheduler_MonthView1_AppointmentClick: " & Appointment.Name,"Test").As(Object)) Msgbox_Result (Result As Int)
End Sub

Private Sub ASScheduler_DayView1_AppointmentLongClick(Appointment As ASScheduler_Appointment)
	Log("ASScheduler_MonthView1_AppointmentLongClick: " & Appointment.Name)
	wait for (xui.MsgboxAsync("ASScheduler_MonthView1_AppointmentLongClick: " & Appointment.Name,"Test").As(Object)) Msgbox_Result (Result As Int)
End Sub

Private Sub ASScheduler_DayView1_TimeBlockClick(StartDate As Long, EndDate As Long)
	wait for (xui.MsgboxAsync("ASScheduler_DayView1_TimeBlockClick: " & DateUtils.TicksToString(StartDate) & " - " & DateUtils.TicksToString(EndDate),"Test").As(Object)) Msgbox_Result (Result As Int)
End Sub

Private Sub ASScheduler_DayView1_TimeBlockLongClick(StartDate As Long, EndDate As Long)
	wait for (xui.MsgboxAsync("ASScheduler_DayView1_TimeBlockLongClick: " & DateUtils.TicksToString(StartDate) & " - " & DateUtils.TicksToString(EndDate),"Test").As(Object)) Msgbox_Result (Result As Int)
End Sub

Private Sub ASScheduler_DayView1_Created
	Log("Created")
End Sub


Private Sub ASScheduler_DayView1_VisibleDateRangeChanged(FirstDay As Long, LastDay As Long)
	Log("VisibleDateRangeChanged FirstDay: " & DateUtils.TicksToString(FirstDay) & " - LastDay: " & DateUtils.TicksToString(LastDay))
End Sub

#End Region


Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
	Dim BottomGap As Float = 0dip
	#If B4I
	BottomGap = B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
	#End If
	
	ASScheduler_DayView1.Base_Resize(Width,Height - ASScheduler_DayView1.mBase.Top - BottomGap)
	
End Sub

#If B4J
Private Sub xlbl_ThemeMode_MouseClicked (EventData As MouseEvent)
	SwitchTheme
End Sub

#Else
Private Sub xlbl_ThemeMode_Click
	SwitchTheme
End Sub
#End If

Private Sub SwitchTheme
	
	If xlbl_ThemeMode.Tag = "Dark" Then
		xlbl_ThemeMode.Tag = "Light"
		xlbl_ThemeMode.Font = xui.CreateFontAwesome(25)
		xlbl_ThemeMode.Text = Chr(0xF186)
		xlbl_ThemeMode.TextColor = xui.Color_Black
		
		ASScheduler_DayView1.Theme = ASScheduler_DayView1.Theme_Light
			
		Root.SetColorAnimated(500,Root.Color,ASScheduler_DayView1.Theme_Light.BackgroundColor_Body)
			
	Else
		xlbl_ThemeMode.Tag = "Dark"
		xlbl_ThemeMode.Font = xui.CreateMaterialIcons(25)
		xlbl_ThemeMode.Text = Chr(0xE430)
		xlbl_ThemeMode.TextColor = xui.Color_White
		
		ASScheduler_DayView1.Theme = ASScheduler_DayView1.Theme_Dark
		
		Root.SetColorAnimated(500,Root.Color,ASScheduler_DayView1.Theme_Dark.BackgroundColor_Body)
		
	End If
	
End Sub

Private Sub B4XComboBox1_SelectedIndexChanged (Index As Int)
	
	Select Index
		Case 0
			ASScheduler_DayView1.DayCount = ASScheduler_DayView1.DayCount_OneDay
		Case 1
			ASScheduler_DayView1.DayCount = ASScheduler_DayView1.DayCount_ThreeDays
		Case 2
			ASScheduler_DayView1.DayCount = ASScheduler_DayView1.DayCount_FiveDays
		Case 3
			ASScheduler_DayView1.DayCount = ASScheduler_DayView1.DayCount_SevenDays
	End Select
	ASScheduler_DayView1.RefreshScheduler
End Sub