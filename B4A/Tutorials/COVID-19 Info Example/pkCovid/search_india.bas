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
	Private IME As IME
	Private Btn_Back As Button
	Private ListView1 As ListView
	Private Lbl_Location As Label
	Private Lbl_Source As Label

	Private Lbl_Source As Label
	Private sSrcAPI As String = "https://api.covid19india.org/state_district_wise.json"
	Private cmb_states As B4XComboBox
	Private State_Name As String

	Private Lbl_Totals As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("searchindia")
	
	IME.Initialize("IME")
	Lbl_Location.Text = "Indian State-Wide Data"
	Lbl_Source.Text = "source » " & sSrcAPI

	Get_States

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Get_States
	Dim searchindia As HttpJob
	
	searchindia.Initialize("GetDetails", Me)
	searchindia.Download(sSrcAPI)
	
	Wait For (searchindia) JobDone(searchindia As HttpJob)
	ProgressDialogHide
	
	If searchindia.Success Then
		cmb_states.cmbBox.Add("Select State")
			
		Dim parser As JSONParser
		parser.Initialize(searchindia.GetString)
		Dim root As Map = parser.NextObject
		For Each selState As String In root.Keys
			If (selState <> "State Unassigned") Then
				cmb_states.cmbBox.Add(selState)
			End If
		Next
	End If
	
	searchindia.Release

End Sub

Sub indiasearch
	Dim nCount As Int
	Dim nDistrictNo As Int
	Dim nTotalCases As Int
	Dim nTotalActive As Int
	Dim nTotalRecovered As Int
	Dim nTotalDeceased As Int

	ListView1.Clear
	ListView1.SingleLineLayout.ItemHeight = 32dip
	ListView1.SingleLineLayout.Label.TextSize = 16
	ListView1.SingleLineLayout.Label.TextColor = Colors.White
	ListView1.SingleLineLayout.Label.Gravity = Gravity.LEFT
	ListView1.SingleLineLayout.Label.Gravity = Gravity.BOTTOM
	ListView1.TwoLinesLayout.ItemHeight = 50dip
	ListView1.TwoLinesLayout.Label.TextSize = 12
	ListView1.TwoLinesLayout.Label.TextColor = Colors.ARGB(175, 255, 255, 255)
	ListView1.TwoLinesLayout.Label.Gravity=Gravity.TOP
	ListView1.TwoLinesLayout.SecondLabel.TextSize = 12
	ListView1.TwoLinesLayout.SecondLabel.TextColor = Colors.ARGB(175, 255, 255, 255)
	ListView1.TwoLinesLayout.SecondLabel.Gravity=Gravity.TOP

	Dim searchindia As HttpJob
	searchindia.Initialize("GetDetails", Me)
	searchindia.Download(sSrcAPI)
	
	Wait For (searchindia) JobDone(searchindia As HttpJob)
	
	ProgressDialogHide
	
	If searchindia.Success Then
		Dim parser As JSONParser
		parser.Initialize(searchindia.GetString)

		Dim root As Map = parser.NextObject
		Dim selState As Map = root.Get(State_Name)
		Dim districtData As Map = selState.Get("districtData")
		
		For Each districts As Map In districtData.Values
			If districtData.GetKeyAt(nCount) <> "Other State" Then
				nDistrictNo = nDistrictNo +1
				ListView1.AddSingleLine(nDistrictNo & ". " & districtData.GetKeyAt(nCount))
				nCount = nCount + 1
			
				Dim Confirmed As Int = districts.GetDefault("confirmed", "0")
				Dim Active As Int = districts.GetDefault("active", "0")
				Dim Recovered As Int = districts.GetDefault("recovered", "0")
				Dim Deceased As Int = districts.GetDefault("deceased", "0")
			
				nTotalCases = nTotalCases + Confirmed
				nTotalActive = nTotalActive + Active
				nTotalRecovered = nTotalRecovered + Recovered
				nTotalDeceased = nTotalDeceased + Deceased
		
				Dim CaseResult1 As String = "Cases:" & NumberFormat(Confirmed, 0, 0) & _
										" | Active:" & NumberFormat(Active, 0, 0) & CRLF 
				Dim CaseResult2 As String = "Recovered:" & NumberFormat(Recovered, 0, 0) & _
										" | Deaths:" & NumberFormat(Deceased, 0, 0)
										
				ListView1.AddTwoLines(CaseResult1, CaseResult2)
			Else
				Dim Confirmed As Int = districts.GetDefault("confirmed", "0")
				Dim Active As Int = districts.GetDefault("active", "0")
				Dim Recovered As Int = districts.GetDefault("recovered", "0")
				Dim Deceased As Int = districts.GetDefault("deceased", "0")
			
				nTotalCases = nTotalCases + Confirmed
				nTotalActive = nTotalActive + Active
				nTotalRecovered = nTotalRecovered + Recovered
				nTotalDeceased = nTotalDeceased + Deceased
				nCount = nCount + 1
			End If
		Next
		Lbl_Totals.Text = "Total Cases:" & nTotalCases & " || Total Active:" & nTotalActive & CRLF & _
							"Total Recovered:" & nTotalRecovered & " || Total Deaths:" & nTotalDeceased
		
	Else
		ToastMessageShow("State data not found", True)
	End If

	searchindia.Release

End Sub

Sub Btn_Back_Click
	IME.HideKeyboard
	StartActivity(Main)
	Activity.Finish
End Sub

Sub cmb_states_SelectedIndexChanged (Index As Int)
	If cmb_states.SelectedItem <> "Select State" Then
		State_Name = cmb_states.SelectedItem
		ProgressDialogShow2("Searching data...", False)
		indiasearch
	End If
End Sub


