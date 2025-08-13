B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ASScheduler_MonthView1 As ASScheduler_MonthView
	Private xlbl_ThemeMode As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_MonthView")
	
	
	ASScheduler_MonthView1.CreateScheduler
	
End Sub

#Region Events

Private Sub ASScheduler_MonthView1_FirstVisibleDay(Date As Long)
	'Log("FirstVisibleDay: " & DateUtils.TicksToString(Date))
	DateTime.DateFormat = "dd.MM.yyyy"
	Date = Date + DateTime.TicksPerDay*6 'if a new month starts in the week
	B4XPages.SetTitle(Me,"MonthView - " & DateUtils.GetMonthName(Date) & " " & DateTime.GetYear(Date))
End Sub

Private Sub ASScheduler_MonthView1_LastVisibleDay(Date As Long)
	'Log("LastVisibleDay: " & DateUtils.TicksToString(Date))
End Sub

Private Sub ASScheduler_MonthView1_CustomDrawDay(Date As Long, Views As ASScheduler_MonthView_CustomDrawDay)

	Dim DayOfWeek As Int  = DateTime.GetDayOfWeek(Date)
	If DayOfWeek = ASSchedulerUtils.WeekDay_Saturday Or DayOfWeek = ASSchedulerUtils.WeekDay_Sunday Then
		If DayOfWeek = ASSchedulerUtils.WeekDay_Saturday Then
			Views.BackgroundPanel.Color = xui.Color_ARGB(25,136,105,167)
		Else
			Views.BackgroundPanel.Color = xui.Color_ARGB(70,136,105,167)
		End If
	End If

	Dim Text As String = Views.xlbl_Day.Text
	If Text.Contains(".") Then
		Views.xlbl_Day.TextColor = xui.Color_RGB(245,0,87)
	End If


End Sub


Private Sub ASScheduler_MonthView1_Created
	Log("Created")
End Sub

#End Region


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
		
		ASScheduler_MonthView1.Theme = ASScheduler_MonthView1.Theme_Light
		Root.SetColorAnimated(500,Root.Color,ASScheduler_MonthView1.Theme_Light.BackgroundColor_Body)
	Else
		xlbl_ThemeMode.Tag = "Dark"
		xlbl_ThemeMode.Font = xui.CreateMaterialIcons(25)
		xlbl_ThemeMode.Text = Chr(0xE430)
		xlbl_ThemeMode.TextColor = xui.Color_White
		
		ASScheduler_MonthView1.Theme = ASScheduler_MonthView1.Theme_Dark

		Root.SetColorAnimated(500,Root.Color,ASScheduler_MonthView1.Theme_Dark.BackgroundColor_Body)
		
	End If

	
End Sub