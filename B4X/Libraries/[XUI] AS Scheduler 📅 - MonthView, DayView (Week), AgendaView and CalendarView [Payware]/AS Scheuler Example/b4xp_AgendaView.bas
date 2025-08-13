B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ASScheduler_AgendaView1 As ASScheduler_AgendaView
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
	Root.LoadLayout("frm_AgendaView")
	
	B4XPages.SetTitle(Me,"AgendaView")
	
	ASScheduler_AgendaView1.StartDate = DateTime.Now 'DateTime.Now is default
	ASScheduler_AgendaView1.CreateScheduler 'Makes the Scheduler visible
	
End Sub

#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If Width < Height Then
		ASScheduler_AgendaView1.mBase.SetLayoutAnimated(0,0,0,Width,Height)
	Else
		ASScheduler_AgendaView1.mBase.SetLayoutAnimated(0,B4XPages.GetNativeParent(Me).SafeAreaInsets.Left,0,Width - B4XPages.GetNativeParent(Me).SafeAreaInsets.Left,Height)
	End If
	
End Sub
#End If

Private Sub ASScheduler_AgendaView1_AppointmentClick (Appointment As ASScheduler_Appointment)
	Log("AppointmentClick: " & Appointment.Name)
	'Log(DateUtils.TicksToString(Appointment.StartDate))
	wait for (xui.MsgboxAsync("AppointmentClick: " & Appointment.Name,"Test").As(Object)) Msgbox_Result (Result As Int)
End Sub

Private Sub ASScheduler_AgendaView1_WeekClick (StartDate As Long)
	Log("WeekClick: " & DateUtils.TicksToString(StartDate))
End Sub

Private Sub ASScheduler_AgendaView1_MonthClick (StartDate As Long)
	Log("MonthClick: " & DateUtils.TicksToString(StartDate))
End Sub

'Here you cann add layouts or custom views to the panels
Private Sub ASScheduler_AgendaView1_CustomDrawMonth (StartDate As Long,BackgroundPanel As B4XView)
	
	'Here you can add whatever you want
	'For example a ImageView with seasons pictures of the current month
	'Or a button
	'Or a complete layout
	
	'The BackgroundPanel already has a label
	Dim xlbl_CurrentMonth As B4XView = BackgroundPanel.GetView(0) 'The default label which shows the current month
	xlbl_CurrentMonth.Text = xlbl_CurrentMonth.Text
	
	'Add a custom item
'	Dim lbl As Label
'	lbl.Initialize("")
'	Dim xlbl As B4XView = lbl
'	xlbl.Text = "This is a Custom Text " & DateUtils.TicksToString(StartDate)
'	xlbl.As(B4XView).TextColor = xui.Color_White
'	BackgroundPanel.AddView(xlbl,0,BackgroundPanel.Height - 20dip,BackgroundPanel.Width,20dip)
	
End Sub

Private Sub ASScheduler_AgendaView1_CustomDrawWeek (StartDate As Long,BackgroundPanel As B4XView)
	
	'The BackgroundPanel already has views
	'Displays for example: May 02 - 08
	Dim xlbl_WeekRangeText As B4XView = BackgroundPanel.GetView(0) 'Ignore
	'The green dot to indicate that this week is the current week
	Dim xpnl_CurrentDateIndicator As B4XView = BackgroundPanel.GetView(1) 'Ignore
	
End Sub

Private Sub ASScheduler_AgendaView1_CustomDrawEmptyState (StartDate As Long,BackgroundPanel As B4XView)
	
	'The BackgroundPanel already has views
	'Displays for example: No appointments available
	Dim xlbl_EmptyText As B4XView = BackgroundPanel.GetView(0) 'ignore
	
	
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
		
		ASScheduler_AgendaView1.Theme = ASScheduler_AgendaView1.Theme_Light
			
		Root.SetColorAnimated(500,Root.Color,ASScheduler_AgendaView1.Theme_Light.BackgroundColor_Body)
			
	Else
		xlbl_ThemeMode.Tag = "Dark"
		xlbl_ThemeMode.Font = xui.CreateMaterialIcons(25)
		xlbl_ThemeMode.Text = Chr(0xE430)
		xlbl_ThemeMode.TextColor = xui.Color_White

		ASScheduler_AgendaView1.Theme = ASScheduler_AgendaView1.Theme_Dark
		
		Root.SetColorAnimated(500,Root.Color,ASScheduler_AgendaView1.Theme_Dark.BackgroundColor_Body)
		
	End If
	
End Sub