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
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_CalendarViewMonth")
	
	B4XPages.SetTitle(Me,"CalendarView Month")
	
End Sub

Private Sub ASScheduler_CalendarViewMonth1_SelectedDateChanged(Date As Long)
	Log("SelectedDateChanged: " & DateUtils.TicksToString(Date))
End Sub


Private Sub ASScheduler_CalendarViewMonth1_AppointmentClick(Appointment As ASScheduler_Appointment)
	Log("AppointmentClick: " & Appointment.Name)
End Sub

Private Sub ASScheduler_CalendarViewMonth1_HiddenAppointmentClick(ListOfAppointments As List)
	Log("HiddenAppointmentClick: " & ListOfAppointments.Size)
End Sub