B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Btn_Back As Button
	Private ListView1 As ListView
	Private Lbl_Location As Label
	Private Lbl_Source As Label
	Private sSrcAPI As String = "https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("countries")
	
	Lbl_Location.Text = "Indian Data (Unofficial)"
	Lbl_Source.Text = "source » " & sSrcAPI

	ProgressDialogShow2("Downloading data...", False)
End Sub

Sub Activity_Resume
	States_list
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub States_list
	ListView1.Clear
	ListView1.SingleLineLayout.ItemHeight = 25dip
	ListView1.SingleLineLayout.Label.TextSize = 16
	ListView1.SingleLineLayout.Label.TextColor = Colors.White
	ListView1.SingleLineLayout.Label.Gravity = Gravity.LEFT
	ListView1.TwoLinesLayout.ItemHeight = 60dip
	ListView1.TwoLinesLayout.Label.TextSize = 12
	ListView1.TwoLinesLayout.Label.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.Label.Gravity=Gravity.TOP
	ListView1.TwoLinesLayout.SecondLabel.TextSize = 12
	ListView1.TwoLinesLayout.SecondLabel.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.SecondLabel.Gravity=Gravity.TOP

	Dim CovidStates As HttpJob
	CovidStates.Initialize("GetDetails", Me)
	CovidStates.Download(sSrcAPI)
	
	Wait For (CovidStates) JobDone(CovidStates As HttpJob)

	ProgressDialogHide
		
	If CovidStates.Success Then
		Dim parser As JSONParser
		parser.Initialize(CovidStates.GetString)
		
		Dim root As Map = parser.NextObject
		Dim data As Map = root.Get("data")
'		Dim lastRefreshed As String = data.Get("lastRefreshed")
		Dim total As Map = data.Get("total")
		
		Dim recovered As Int = total.Get("recovered")
		Dim active As Int = total.Get("active")
		Dim confirmed As Int = total.Get("confirmed")
		Dim deaths As Int = total.Get("deaths")
'		Dim source As String = data.Get("source")
		Dim statewise As List = data.Get("statewise")

		Dim CaseResult0 As String = "Confirmed: " & NumberFormat(confirmed, 0, 0) & _
									" | Recovered: " & NumberFormat(recovered, 0, 0)
		Dim CaseResult00 As String = "Active: " & NumberFormat(active, 0, 0) & _
										" | Deaths: " & NumberFormat(deaths, 0, 0)
		
		
		ListView1.AddSingleLine("Summary: ")
		ListView1.AddTwoLines(CaseResult0, CaseResult00)
		
'		Dim success As String = root.Get("success")
		Dim lastOriginUpdate As String = root.Get("lastOriginUpdate")
		lastOriginUpdate = lastOriginUpdate.Replace("T", " ")
		lastOriginUpdate = lastOriginUpdate.Replace("Z", " ")
		ListView1.AddTwoLines("Last Updated:" & lastOriginUpdate, "")

		For Each colstatewise As Map In statewise
			Dim recovered As Int = colstatewise.Get("recovered")
			Dim active As Int = colstatewise.Get("active")
			Dim state As String = colstatewise.Get("state")
			Dim confirmed As Int = colstatewise.Get("confirmed")
			Dim deaths As Int = colstatewise.Get("deaths")


			Dim CaseResult1 As String = "Confirmed: " & NumberFormat(confirmed, 0, 0) & _
										" | Recovered: " & NumberFormat(recovered, 0, 0) 
			Dim CaseResult2 As String =  "Active: " & NumberFormat(active, 0, 0) & _
											" | Deaths: " & NumberFormat(deaths, 0, 0)
			
			ListView1.AddSingleLine(state)
			ListView1.AddTwoLines(CaseResult1, CaseResult2)
		Next
	End If

	CovidStates.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

