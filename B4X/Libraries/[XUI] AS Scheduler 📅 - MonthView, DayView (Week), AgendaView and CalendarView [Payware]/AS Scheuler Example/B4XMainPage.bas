B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xpnl_Buttons As B4XView
	
	Private p_DayView As b4xp_DayView
	Private p_MonthView As b4xp_MonthView
	Private p_AgendaView As b4xp_AgendaView
	Private p_CalendarView As b4xp_CalendarView
	Private p_CalendarViewMonth As b4xp_CalendarViewMonth
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"Home")
	
	B4XPages.AddPage("b4xp_DayView",p_DayView.Initialize)
	B4XPages.AddPage("b4xp_MonthView",p_MonthView.Initialize)
	B4XPages.AddPage("b4xp_AgendaView",p_AgendaView.Initialize)
	B4XPages.AddPage("b4xp_CalendarView",p_CalendarView.Initialize)
	B4XPages.AddPage("b4xp_CalendarViewMonth",p_CalendarViewMonth.Initialize)
	
	#If B4A
	B4XPage_Resize(Root.Width,Root.Height)
	#End If
	
	ASSchedulerUtils.API.ClearAppointments
	ASSchedulerUtils.API.ClearBlackouts
	ASSchedulerUtils.API.ClearSpecialDays
	
	Dim StartDate As Long = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now),8,0,0)

	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 1","Description",xui.Color_ARGB(255,73, 98, 164),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 2","Description",xui.Color_ARGB(255,141, 68, 173),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 3","Description",xui.Color_ARGB(255,45, 136, 121),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 4","Description",xui.Color_ARGB(255,140, 198, 101),False,StartDate + DateTime.TicksPerDay,StartDate + DateTime.TicksPerDay + DateTime.TicksPerHour*1))
	
	'Recurring
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_AppointmentRecurring(0,"Recurring Appointment 1","Description",xui.Color_ARGB(255,85,139,110),False,StartDate + DateTime.TicksPerDay*7,StartDate + (DateTime.TicksPerDay*7) + DateTime.TicksPerHour*2,True,ASSchedulerUtils.Recurring_Week,1))
	
	'***Random Appointments
	Dim p As Period
	p.Initialize
	p.Days = -7
		
	For i = 0 To 15 -1
		p.Days = p.Days + i
		Dim Start As Long = DateUtils.AddPeriod(DateTime.Now,p)
		If DateUtils.IsSameDay(DateTime.Now,Start) Then Continue
		
		For i2 = 0 To Rnd(1,5)
			Start = Start + DateTime.TicksPerHour*(Rnd(1,4))
			ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test" & i2,"Description",GetAppointmentColor,False,Start,Start + (DateTime.TicksPerHour*2)))
		Next
	Next
	
	
	p.Days = -12
	ASSchedulerUtils.API.CreateBlackout(ASSchedulerUtils.CreateASScheduler_Blackout(0,DateUtils.AddPeriod(DateTime.Now,p),DateUtils.AddPeriod(DateTime.Now,p) + (DateTime.TicksPerDay*4)))

	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	xpnl_Buttons.Top = Height/2 - xpnl_Buttons.Height/2
End Sub

#If B4J
Private Sub xlbl_OpenDayView_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenDayView_Click
#End If
	B4XPages.ShowPage("b4xp_DayView")
End Sub

#If B4J
Private Sub xlbl_OpenMonthView_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenMonthView_Click
#End If

	B4XPages.ShowPage("b4xp_MonthView")
End Sub

#If B4J
Private Sub xlbl_OpenAgendaView_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenAgendaView_Click
#End If
	B4XPages.ShowPage("b4xp_AgendaView")
End Sub

#If B4J
Private Sub xlbl_OpenCalendarView_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenCalendarView_Click
#End If
	B4XPages.ShowPage("b4xp_CalendarView")
End Sub

#If B4J
Private Sub xlbl_OpenCalendarViewMonth_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenCalendarViewMonth_Click
#End If

	B4XPages.ShowPage("b4xp_CalendarViewMonth")
End Sub

Private Sub GetAppointmentColor As Int
	Select Rnd(1,5)
		Case 1
			Return xui.Color_ARGB(255,45, 136, 121)
		Case 2
			Return xui.Color_ARGB(255,73, 98, 164)
		Case 3
			Return xui.Color_ARGB(255,141, 68, 173)
		Case 4
			Return xui.Color_ARGB(255,140, 198, 101)
	End Select
	Return xui.Color_Red
End Sub