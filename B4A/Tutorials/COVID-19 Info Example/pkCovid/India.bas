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
	Private sSrcAPI As String = "https://api.rootnet.in/covid19-in/stats/latest"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("countries")
	
	Lbl_Location.Text = "Indian Data (MoHFW)"
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
'		Dim lastRefreshed As String = root.Get("lastRefreshed")
		Dim data As Map = root.Get("data")
		Dim summary As Map = data.Get("summary")
		Dim summarytotal As Int = summary.Get("total")
'		Dim confirmedButLocationUnidentified As Int = summary.Get("confirmedButLocationUnidentified")
		Dim confirmedCasesForeign As Int = summary.Get("confirmedCasesForeign")
		Dim discharged As Int = summary.Get("discharged")
		Dim confirmedCasesIndian As Int = summary.Get("confirmedCasesIndian")
		Dim deaths As Int = summary.Get("deaths")
		Dim regional As List = data.Get("regional")

		Dim CaseResult0 As String = "Total: " & NumberFormat(summarytotal, 0, 0) & _
									" | Discharged: " & NumberFormat(discharged, 0, 0) & _
									" | Active: " & NumberFormat(summarytotal - (discharged + deaths), 0, 0) & CRLF & _
									" | Deaths: " & NumberFormat(deaths, 0, 0)
									
		Dim CaseResult00 As String = "Indian: " & NumberFormat(confirmedCasesIndian, 0, 0) & _
										" | Foreigners: " & NumberFormat(confirmedCasesForeign, 0, 0)
		
		ListView1.AddSingleLine("Summary: ")
		ListView1.AddTwoLines(CaseResult0, CaseResult00)

'		Dim success As String = root.Get("success")
		Dim lastOriginUpdate As String = root.Get("lastOriginUpdate")
		lastOriginUpdate = lastOriginUpdate.Replace("T", " ")
		lastOriginUpdate = lastOriginUpdate.Replace("Z", " ")
		ListView1.AddTwoLines("Last Updated:" & lastOriginUpdate, "")

		For Each colregional As Map In regional
			Dim loc As String = colregional.Get("loc")
			Dim discharged As Int = colregional.Get("discharged")
			Dim confirmedCasesForeign As Int = colregional.Get("confirmedCasesForeign")
			Dim confirmedCasesIndian As Int = colregional.Get("confirmedCasesIndian")
			Dim deaths As Int = colregional.Get("deaths")
			Dim totalConfirmed As Int = colregional.Get("totalConfirmed")
					
			Dim CaseResult1 As String = "Confirmed: " & NumberFormat(totalConfirmed, 0, 0) & _
										" | Discharged: " & NumberFormat(discharged, 0, 0) & _
										" | Active: " & NumberFormat(totalConfirmed - (discharged + deaths), 0, 0) & CRLF & _
										" | Deaths: " & NumberFormat(deaths, 0, 0)
										
			Dim CaseResult2 As String =  "Indian: " & NumberFormat(confirmedCasesIndian, 0, 0) & _
											" | Foreigners: " & NumberFormat(confirmedCasesForeign, 0, 0)
			
			ListView1.AddSingleLine(loc)
			ListView1.AddTwoLines(CaseResult1, CaseResult2)
		Next
		
	End If

	CovidStates.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

