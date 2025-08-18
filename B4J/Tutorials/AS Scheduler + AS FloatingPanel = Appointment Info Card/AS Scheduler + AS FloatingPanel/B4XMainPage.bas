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
	
	Private fp_Informations As AS_FloatingPanel
	Private ASViewPager1 As ASViewPager

	Private AS_TabMenuAdvanced1 As AS_TabMenuAdvanced
	Private m_LastTop,m_LastLeft As Float
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Scheduler + AS FloatingPanel")
	
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
	
	'Initializes the FloatingMenu
	fp_Informations.Initialize(Me,"fp_Informations",Root)
	
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

'Hover Over Events
Private Sub ASScheduler_MonthView1_HoverOverAppointment(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	ShowMenuOnAppointment(Appointment,HoverOverInfos)
End Sub

Private Sub ASScheduler_AgendaView1_HoverOverAppointment(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	ShowMenuOnAppointment(Appointment,HoverOverInfos)
End Sub

Private Sub ASScheduler_DayView1_HoverOverAppointment(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	ShowMenuOnAppointment(Appointment,HoverOverInfos)
End Sub

'Shows the Meenu on a appointment
Private Sub ShowMenuOnAppointment(Appointment As ASScheduler_Appointment,HoverOverInfos As ASScheduler_HoverOverInfos)
	
	If HoverOverInfos.Entered Then 'If the mouse entered the appointment
		
		m_LastTop = HoverOverInfos.Y 'Saves the latest mouse coordinates
		m_LastLeft = HoverOverInfos.x
		
		Sleep(1000) 'Since we don't want a menu to pop up every time we hover over an appointment, we specify a sleep of one minute
		
		'If the mouse is no longer over the appointment within the 1 second, then no menu is shown
		If m_LastTop <> HoverOverInfos.Y Or m_LastLeft <> HoverOverInfos.x Then Return
			
		Dim MenuWidth As Float = 300dip
		Dim MenuHeight As Float = 110dip
		
		Dim MenuLeft As Float = HoverOverInfos.x - Main.MainForm.WindowLeft - MenuWidth - fp_Informations.ArrowProperties.Height
		Dim MenuTop As Float = HoverOverInfos.y - Main.MainForm.WindowTop - MenuHeight/2 + HoverOverInfos.AppointmentHeight/2
		
		'If there is no space to display the menu on the left or right, then the menu should be placed at the top under the appointment
		If MenuLeft < 0 And MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth + MenuLeft + MenuWidth > Root.Width Then
			
			MenuLeft = MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth/2 - MenuWidth/2
			MenuTop = HoverOverInfos.y - Main.MainForm.WindowTop + HoverOverInfos.AppointmentHeight + fp_Informations.ArrowProperties.Height
			
			If MenuTop + MenuHeight > Root.Height Then
				
				MenuTop = HoverOverInfos.y - Main.MainForm.WindowTop - MenuHeight - fp_Informations.ArrowProperties.Height
				fp_Informations.ArrowProperties.ArrowOrientation = fp_Informations.ArrowOrientation_Bottom
				fp_Informations.ArrowProperties.Top = MenuHeight
				fp_Informations.OpenOrientation = fp_Informations.OpenOrientation_BottomTop
				Else
					
				fp_Informations.ArrowProperties.ArrowOrientation = fp_Informations.ArrowOrientation_Top
				fp_Informations.ArrowProperties.Top = 0
				fp_Informations.OpenOrientation = fp_Informations.OpenOrientation_TopBottom
				
			End If
			
			fp_Informations.ArrowProperties.Left = MenuWidth/2 - fp_Informations.ArrowProperties.Width/2
			
		Else 'If there is room left and right, then:
		
			If MenuLeft + MenuWidth < 0 Or MenuLeft < 0 Then
				fp_Informations.ArrowProperties.ArrowOrientation = fp_Informations.ArrowOrientation_Left
				fp_Informations.OpenOrientation = fp_Informations.OpenOrientation_LeftRight
			
				MenuLeft = MenuLeft + MenuWidth + HoverOverInfos.AppointmentWidth + fp_Informations.ArrowProperties.Height*2
			
			Else
				fp_Informations.ArrowProperties.ArrowOrientation = fp_Informations.ArrowOrientation_Right
				fp_Informations.OpenOrientation = fp_Informations.OpenOrientation_RightLeft
			End If
		
			If MenuTop + MenuHeight > Root.Height Then
				MenuTop = MenuTop - ((MenuTop + MenuHeight)-Root.Height)
				fp_Informations.ArrowProperties.Top = HoverOverInfos.y - Main.MainForm.WindowTop - MenuTop + HoverOverInfos.AppointmentHeight/4
			Else
				fp_Informations.ArrowProperties.Top = MenuHeight/2 - fp_Informations.ArrowProperties.Height/2
			End If
		
		End If
		
		fp_Informations.ArrowVisible = True
		fp_Informations.Panel.SetColorAndBorder(fp_Informations.Panel.Color,0,0,2dip)
		fp_Informations.BackgroundColor = xui.Color_ARGB(180,0,0,0)
		
		fp_Informations.PreSize(MenuWidth,MenuHeight)
		fp_Informations.Panel.RemoveAllViews
		fp_Informations.Panel.LoadLayout("frm_MenuLayout")
		FillMenuWithContent(fp_Informations.Panel,Appointment)
		fp_Informations.Show(MenuLeft,MenuTop,MenuWidth,MenuHeight)
	Else
		m_LastTop = 0
		m_LastLeft = 0
	End If
	
End Sub

Private Sub FillMenuWithContent(xpnl_Background As B4XView,Appointment As ASScheduler_Appointment)
	
	Dim xpnl_TitleBackground As B4XView = xpnl_Background.GetView(0)
	Dim xlbl_Title As B4XView = xpnl_Background.GetView(1)
	Dim xlbl_Description As B4XView = xpnl_Background.GetView(2)
	Dim xlbl_DateTime As B4XView = xpnl_Background.GetView(3)
	
	xpnl_TitleBackground.SetColorAndBorder(Appointment.Color,0,0,5dip)
	xlbl_Title.Text = Appointment.Name
	
	DateTime.TimeFormat = "HH:mm"
	DateTime.DateFormat = DateTime.DeviceDefaultDateFormat
	
	xlbl_Description.Text = Appointment.Description
	xlbl_DateTime.Text = DateUtils.GetMonthName(Appointment.StartDate) & ", " & DateTime.Date(Appointment.StartDate) & " " & DateTime.Time(Appointment.StartDate) & "-" & DateTime.Time(Appointment.EndDate)

End Sub

Private Sub AS_TabMenuAdvanced1_TabClick (Index As Int)
	ASViewPager1.CurrentIndex = Index
End Sub
