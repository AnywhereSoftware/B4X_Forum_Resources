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
	Private ASScheduler_AgendaView1 As ASScheduler_AgendaView
	Private ASScheduler_DayView1 As ASScheduler_DayView
	
	Private ASViewPager1 As ASViewPager

	Private AS_TabMenuAdvanced1 As AS_TabMenuAdvanced
	Private AS_PopupMenu1 As ASPopupMenu
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Scheduler ContextMenu")
	
	AddPages 'Add the Pages to the ASViewPager and Add Tabs to the ASTabMenuAdvanced
	
	ASSchedulerUtils.API.ClearAppointments 'Clear all appointment, so the appointments are always up to date
	
	Dim StartDate As Long = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now),8,0,0)
	
	'Adds some test appointments
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 1","Description",xui.Color_ARGB(255,73, 98, 164),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 2","Description",xui.Color_ARGB(255,141, 68, 173),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 3","Description",xui.Color_ARGB(255,45, 136, 121),False,StartDate,StartDate + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 4","Description",xui.Color_ARGB(255,140, 198, 101),False,StartDate + DateTime.TicksPerDay,StartDate + DateTime.TicksPerDay + DateTime.TicksPerHour*1))
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_Appointment(0,"Test Appointment 5","Description",xui.Color_ARGB(255,140, 198, 101),False,StartDate + DateTime.TicksPerDay*2,StartDate + DateTime.TicksPerDay*2 + DateTime.TicksPerHour*1))
	
	'Recurring
	ASSchedulerUtils.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_AppointmentRecurring(0,"Recurring Appointment 1","Description",xui.Color_ARGB(255,85,139,110),False,StartDate + DateTime.TicksPerDay*7,StartDate + (DateTime.TicksPerDay*7) + DateTime.TicksPerHour*2,True,ASSchedulerUtils.Recurring_Week,1))
	
	Sleep(0)
	
	ASScheduler_MonthView1.CreateScheduler 'Makes the Scheduler visible
	ASScheduler_AgendaView1.CreateScheduler 'Makes the Scheduler visible
	ASScheduler_DayView1.CreateScheduler 'Makes the Scheduler visible
	
	AS_PopupMenu1.Initialize(Root,Me,"AS_PopupMenu1")
	
	AS_PopupMenu1.MenuCornerRadius = 2dip
	AS_PopupMenu1.BackgroundPanelColor = xui.Color_Transparent
	AS_PopupMenu1.ItemBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	
End Sub

Private Sub AddPages
	
	AS_TabMenuAdvanced1.TabProperties.TextFont = xui.CreateDefaultBoldFont(15) 'Makes the Tab font bold
	
	'Add 3 tabs to the TabMenu
	AS_TabMenuAdvanced1.AddTab("MonthView",Null,Null)
	AS_TabMenuAdvanced1.AddTab("DayView",Null,Null)
	AS_TabMenuAdvanced1.AddTab("AgendaView",Null,Null)
	
	'Adds the MonthView to the ViewPager
	Dim xpnl_MonthView As B4XView = xui.CreatePanel("")
	xpnl_MonthView.SetLayoutAnimated(0,0,0,Root.Width,ASViewPager1.Base.Height)
	xpnl_MonthView.LoadLayout("frm_MonthView")
	ASViewPager1.AddPage(xpnl_MonthView,"")
	
	'Adds the DayView to the ViewPager
	Dim xpnl_DayView As B4XView = xui.CreatePanel("")
	xpnl_DayView.SetLayoutAnimated(0,0,0,Root.Width,ASViewPager1.Base.Height)
	xpnl_DayView.LoadLayout("frm_DayView")
	ASViewPager1.AddPage(xpnl_DayView,"")
	
	'Adds the AgendaView to the ViewPager
	Dim xpnl_AgendaView As B4XView = xui.CreatePanel("")
	xpnl_AgendaView.SetLayoutAnimated(0,0,0,Root.Width,ASViewPager1.Base.Height)
	xpnl_AgendaView.LoadLayout("frm_AgendaView")
	ASViewPager1.AddPage(xpnl_AgendaView,"")
	
End Sub

Private Sub ASScheduler_AgendaView1_AppointmentRightClick(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	OpenContextMenu(Appointment,HoverOverInfos)
End Sub

Private Sub ASScheduler_DayView1_AppointmentRightClick(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	OpenContextMenu(Appointment,HoverOverInfos)
End Sub

Private Sub ASScheduler_MonthView1_AppointmentRightClick(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	OpenContextMenu(Appointment,HoverOverInfos)
End Sub

Private Sub OpenContextMenu(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)'ignore
	
	AS_PopupMenu1.Clear
	AS_PopupMenu1.AddMenuItem("Option 1",1)
	AS_PopupMenu1.AddMenuItem("Option 2",2)
	AS_PopupMenu1.AddMenuItem("Option 3",3)
	AS_PopupMenu1.AddMenuItem("Option 4",4)
	
	Dim MenuWidth As Float = 150dip
	
	Dim MenuLeft As Float = HoverOverInfos.x - Main.MainForm.WindowLeft - MenuWidth
	Dim MenuTop As Float = HoverOverInfos.y - Main.MainForm.WindowTop - AS_PopupMenu1.MenuHeight/2 + HoverOverInfos.AppointmentHeight/2
	
	'If there is no space to display the menu on the left or right, then the menu should be placed at the top under the appointment
	If MenuLeft < 0 And MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth + MenuLeft + MenuWidth >= Root.Width Then
			
		MenuLeft = MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth/2 - MenuWidth/2
		MenuTop = HoverOverInfos.y - Main.MainForm.WindowTop + HoverOverInfos.AppointmentHeight
			
		If MenuTop + AS_PopupMenu1.MenuHeight > Root.Height Then
			MenuTop = HoverOverInfos.y - Main.MainForm.WindowTop - AS_PopupMenu1.MenuHeight
		End If
			
	Else 'If there is room left and right, then:
		
		If MenuLeft + MenuWidth < 0 Or MenuLeft < 0 Then
			MenuLeft = MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth
		End If
		
		If MenuTop + AS_PopupMenu1.MenuHeight > Root.Height Then
			MenuTop = MenuTop - ((MenuTop + AS_PopupMenu1.MenuHeight)-Root.Height)
		End If
		
	End If
	
	AS_PopupMenu1.OpenMenuAdvanced(MenuLeft,MenuTop,MenuWidth)
	
End Sub

Private Sub AS_TabMenuAdvanced1_TabClick (Index As Int)
	ASViewPager1.CurrentIndex = Index
End Sub


