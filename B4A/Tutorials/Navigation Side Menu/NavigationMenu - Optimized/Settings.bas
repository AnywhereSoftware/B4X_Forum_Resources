B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Dim xui As XUI
	Public Selected_DateFormat As String
	Public Selected_TimeFormat As String
	Public Selected_DurationFormat As String
End Sub

Sub Globals
	Dim bar As StdActionBar
	Private lvSettings As ListView
	Private pnlDateFormats As Panel
	Private pnlTimeFormats As Panel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("bar")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	Activity.LoadLayout("Settings")
	Settings_Props
	Load_Data
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	Activity.Finish
End Sub


Sub Settings_Props
	lvSettings.Padding = Array As Int(10dip,0,0,0)
	lvSettings.SingleLineLayout.Label.TextColor = 0xFFFF6600
	lvSettings.TwoLinesLayout.Label.TextColor = xui.Color_Black
	lvSettings.TwoLinesLayout.SecondLabel.TextColor = xui.Color_Gray
	lvSettings.TwoLinesLayout.SecondLabel.TextSize = 14
End Sub


Sub Load_Data
	lvSettings.Clear
	lvSettings.AddSingleLine2("GENERAL",0)
	lvSettings.AddTwoLines2("Date format", Selected_DateFormat,1)
	lvSettings.AddTwoLines2("Time format", Selected_TimeFormat,2)
	lvSettings.AddTwoLines2("Duration format", Selected_DurationFormat,3)
End Sub


Private Sub lvSettings_ItemClick (Position As Int, Value As Object)
	Select Value
		Case 1			'Date format
			pnlDateFormats.Visible = True
			pnlDateFormats.SetLayoutAnimated(500,(100%x / 2) - (pnlDateFormats.Width / 2),pnlDateFormats.Top,pnlDateFormats.Width,pnlDateFormats.Height)
		Case 2			'Time format
			pnlTimeFormats.Visible = True
			pnlTimeFormats.SetLayoutAnimated(500,(100%x / 2) - (pnlTimeFormats.Width / 2),pnlTimeFormats.Top,pnlTimeFormats.Width,pnlTimeFormats.Height)
		Case 3
			
	End Select
End Sub



Sub btnCloseDate_Click
	Dim b As Button = Sender
	Dim parent As B4XView = b.Parent
	parent.SetLayoutAnimated(500,100%x + 50dip,pnlDateFormats.Top,pnlDateFormats.Width,pnlDateFormats.Height)
End Sub

Private Sub SelectDateFormat_CheckedChange(Checked As Boolean)
	Dim rb As RadioButton = Sender
	Selected_DateFormat = rb.Text
	Load_Data
	btnCloseDate_Click
End Sub


Sub btnCloseTime_Click
	Dim b As Button = Sender
	Dim parent As B4XView = b.Parent
	parent.SetLayoutAnimated(500,100%x + 50dip,pnlTimeFormats.Top,pnlTimeFormats.Width,pnlTimeFormats.Height)
End Sub

Sub SelectTimeFormat_CheckedChange(Checked As Boolean)
	Dim rb As RadioButton = Sender
	Selected_TimeFormat = rb.Text
	Load_Data
	btnCloseTime_Click
End Sub


Sub CreatePanel
	Dim p As Panel
	p.Initialize("")
	p.Color = xui.Color_White
	p.Elevation = 5dip
	p.Height = 300dip
	p.Width = 120dip
	p.Top = 50dip
	p.Left = 50dip
End Sub