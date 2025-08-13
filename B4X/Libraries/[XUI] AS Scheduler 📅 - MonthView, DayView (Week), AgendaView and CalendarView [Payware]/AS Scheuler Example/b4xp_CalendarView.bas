B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ASScheduler_CalendarViewMonth1 As ASScheduler_CalendarViewMonth
	Private ASScheduler_CalendarViewWeek1 As ASScheduler_CalendarViewWeek
	
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
	Root.LoadLayout("frm_CalendarView")
	
	B4XPages.SetTitle(Me,"CalendarView")
	
End Sub

Private Sub ASScheduler_CalendarViewMonth1_SelectedDateChanged(Date As Long)
	Log("SelectedDateChanged: " & DateUtils.TicksToString(Date))
End Sub

Private Sub ASScheduler_CalendarViewWeek1_SelectedDateChanged(Date As Long)
	Log("SelectedDateChanged: " & DateUtils.TicksToString(Date))
End Sub


Private Sub ASScheduler_CalendarViewMonth1_AppointmentClick(Appointment As ASScheduler_Appointment)
	Log("AppointmentClick: " & Appointment.Name)
End Sub

Private Sub ASScheduler_CalendarViewMonth1_HiddenAppointmentClick(ListOfAppointments As List)
	Log("HiddenAppointmentClick: " & ListOfAppointments.Size)
End Sub

Private Sub ASScheduler_CalendarViewMonth1_CustomHeaderText(Date As Long, xlbl_HeaderText As B4XView)
	If ASScheduler_CalendarViewMonth1.CurrentView = ASScheduler_CalendarViewMonth1.CurrentView_MonthView Then
		xlbl_HeaderText.Text = "Test " &  DateUtils.GetMonthName(Date) & " " & DateTime.GetYear(Date)
	End If
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
		
		ASScheduler_CalendarViewMonth1.Theme = ASScheduler_CalendarViewMonth1.Theme_Light
		ASScheduler_CalendarViewWeek1.Theme = ASScheduler_CalendarViewWeek1.Theme_Light
			
		Root.Color = ASScheduler_CalendarViewMonth1.Theme_Light.BodyColor
	Else
		xlbl_ThemeMode.Tag = "Dark"
		xlbl_ThemeMode.Font = xui.CreateMaterialIcons(25)
		xlbl_ThemeMode.Text = Chr(0xE430)
		xlbl_ThemeMode.TextColor = xui.Color_White

		ASScheduler_CalendarViewMonth1.Theme = ASScheduler_CalendarViewMonth1.Theme_Dark
		ASScheduler_CalendarViewWeek1.Theme = ASScheduler_CalendarViewWeek1.Theme_Dark
		
		Root.Color = ASScheduler_CalendarViewMonth1.Theme_Dark.BodyColor
	End If
	
End Sub

