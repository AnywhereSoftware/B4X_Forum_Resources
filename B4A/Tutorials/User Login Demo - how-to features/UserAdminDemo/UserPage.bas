B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private bar As StdActionBar
	Private lblName As Label
	Private lblDate As Label
	Private lblTime As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	Activity.LoadLayout("UserPage")
	Activity.Title = "Welcome"
	'show info
	lblName.Text = "Hello " & Starter.LoggedInUser & ","
	
	DateTime.DateFormat = "MM/dd/yyyy"
	DateTime.TimeFormat = "h:mm a"
	lblDate.Text = "Today's date is:" & TAB & TAB & DateTime.Date(DateTime.Now)
	lblTime.Text = "and the time is:" & TAB & TAB & DateTime.Time(DateTime.Now)
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	Activity.Finish
End Sub