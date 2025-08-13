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
	Private AS_CalendarExpandable1 As AS_CalendarExpandable
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS CalendarExpandable")

	For i = 0 To 5 -1
	
		Dim Day As Long = DateTime.Now - DateTime.TicksPerDay*14+DateTime.TicksPerDay*i
	
		AS_CalendarExpandable1.Add_AppointmentType1(Day,xui.Color_ARGB(255,45, 136, 121))
		AS_CalendarExpandable1.Add_AppointmentType1(Day,xui.Color_ARGB(255,73, 98, 164))
		AS_CalendarExpandable1.Add_AppointmentType1(Day,xui.Color_ARGB(255,141, 68, 173))
	
		Dim Day As Long = DateTime.Now - DateTime.TicksPerDay*7+DateTime.TicksPerDay*i
		
		AS_CalendarExpandable1.Add_AppointmentType2(Day,xui.Color_ARGB(255,73, 98, 164),DateUtils.GetDayOfWeekName(Day),xui.Color_White)
	
	Next
	
	AS_CalendarExpandable1.Add_AppointmentType3(DateTime.Now + DateTime.TicksPerDay,DateTime.Now + DateTime.TicksPerDay*3,xui.Color_ARGB(255,45, 136, 121))
	
	AS_CalendarExpandable1.Refresh
	
End Sub

Private Sub AS_CalendarExpandable1_CustomDrawDay_MonthView (Date As Long, Views As ASCalendarExpandable_CustomDrawDay)

End Sub

Private Sub AS_CalendarExpandable1_CustomDrawDay_WeekView (Date As Long, Views As ASCalendarExpandable_CustomDrawDay)

End Sub