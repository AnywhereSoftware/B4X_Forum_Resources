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
	Private ASScheduler_MonthView1 As ASScheduler_MonthView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	ASSchedulerUtils.API.ClearAppointments

	'HeatMap Example Data
	For i = 1 To 40 -1
		Dim p As Period
		p.Initialize
		p.Days = i
		Dim Date As Long = DateUtils.AddPeriod(DateTime.Now,p)
		For z = 1 To Rnd(2,12) -1
			ASScheduler_MonthView1.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_AppointmentRecurring(0,"Test1","Description",xui.Color_ARGB(255,73, 98, 164),False,Date,Date+DateTime.TicksPerHour,False,"day",7))
		Next
	Next

	ASScheduler_MonthView1.CreateScheduler
	
'	Sleep(500)
'	ASScheduler_MonthView1.Scroll2Date(DateTime.Now)
	
End Sub


