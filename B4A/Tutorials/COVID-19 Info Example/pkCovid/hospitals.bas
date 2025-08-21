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
	Private sSrcAPI As String = "https://api.rootnet.in/covid19-in/hospitals/beds"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("hospitals")
	
	Lbl_Location.Text = "India Hospital Data"
	Lbl_Source.Text = "source » " & sSrcAPI

	ProgressDialogShow2("Downloading data...", False)
End Sub

Sub Activity_Resume
	Hospitals_List
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Hospitals_List
	
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

	Dim CovidHospitals As HttpJob
	CovidHospitals.Initialize("GetDetails", Me)
	CovidHospitals.Download(sSrcAPI)
	
	Wait For (CovidHospitals) JobDone(CovidHospitals As HttpJob)

	ProgressDialogHide
		
	If CovidHospitals.Success Then
		Dim parser As JSONParser
		parser.Initialize(CovidHospitals.GetString)
		
		Dim root As Map = parser.NextObject
'		Dim lastRefreshed As String = root.Get("lastRefreshed")
		Dim data As Map = root.Get("data")
		Dim summary As Map = data.Get("summary")
		Dim ruralHospitals As Int = summary.Get("ruralHospitals")
		Dim urbanBeds As Int = summary.Get("urbanBeds")
		Dim totalHospitals As Int = summary.Get("totalHospitals")
		Dim totalBeds As Int = summary.Get("totalBeds")
		Dim ruralBeds As Int = summary.Get("ruralBeds")
		Dim urbanHospitals As Int = summary.Get("urbanHospitals")
		Dim sources As List = data.Get("sources")

		Dim CaseResult0 As String = "Rural Hospitals: " & NumberFormat(ruralHospitals, 0, 0) & _
									" | Rural Beds: " & NumberFormat(ruralBeds, 0, 0) & CRLF & _
									" | Urban Hospitals: " & NumberFormat(urbanHospitals, 0, 0) & _
									" | Urban Beds: " & NumberFormat(urbanBeds, 0, 0)
									
		Dim CaseResult00 As String = "Total Hospitals: " & NumberFormat(totalHospitals, 0, 0) & _
										" | Total Beds: " & NumberFormat(totalBeds, 0, 0)
			
		ListView1.AddSingleLine("Hospitals & Beds: ")
		ListView1.AddTwoLines(CaseResult0, CaseResult00)
			
		For Each colsources As Map In sources
			Dim lastOriginUpdate As String = colsources.Get("lastUpdated")
			Dim url As String = colsources.Get("url")
			
			lastOriginUpdate = lastOriginUpdate.Replace("T", " ")
			lastOriginUpdate = lastOriginUpdate.Replace("Z", " ")
			ListView1.AddTwoLines("Last Updated:" & lastOriginUpdate, url)
		Next

		Dim regional As List = data.Get("regional")
		For Each colregional As Map In regional
			Dim ruralHospitals As Int = colregional.Get("ruralHospitals")
			Dim urbanBeds As Int = colregional.Get("urbanBeds")
			Dim totalHospitals As Int = colregional.Get("totalHospitals")
			Dim totalBeds As Int = colregional.Get("totalBeds")
			Dim state As String = colregional.Get("state")
			Dim ruralBeds As Int = colregional.Get("ruralBeds")
'			Dim asOn As String = colregional.Get("asOn")
			Dim urbanHospitals As Int = colregional.Get("urbanHospitals")

			Dim CaseResult0 As String = "Rural Hospitals: " & NumberFormat(ruralHospitals, 0, 0) & _
									" | Rural Beds: " & NumberFormat(ruralBeds, 0, 0) & CRLF & _
									" | Urban Hospitals: " & NumberFormat(urbanHospitals, 0, 0) & _
									" | Urban Beds: " & NumberFormat(urbanBeds, 0, 0)
									
			Dim CaseResult00 As String = "Total Hospitals: " & NumberFormat(totalHospitals, 0, 0) & _
										" | Total Beds: " & NumberFormat(totalBeds, 0, 0)
		
			ListView1.AddSingleLine("State: " & state)
			ListView1.AddTwoLines(CaseResult0, CaseResult00)
		Next
'		Dim success As String = root.Get("success")
'		Dim lastOriginUpdate As String = root.Get("lastOriginUpdate")
	End If

	CovidHospitals.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub


