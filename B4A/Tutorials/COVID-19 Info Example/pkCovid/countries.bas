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
	Private sSrcAPI As String = "https://corona.lmao.ninja/v2/countries?sort=cases"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("countries")
	
	Lbl_Location.Text = "World Corona Data"
	Lbl_Source.Text = "source » " & sSrcAPI
	ProgressDialogShow2("Downloading data...", False)
End Sub

Sub Activity_Resume
	countrieslist
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub countrieslist
	ListView1.Clear
	ListView1.SingleLineLayout.ItemHeight = 25dip
	ListView1.SingleLineLayout.Label.TextSize = 16
	ListView1.SingleLineLayout.Label.TextColor = Colors.White
	ListView1.SingleLineLayout.Label.Gravity = Gravity.LEFT
	ListView1.SingleLineLayout.Label.Gravity = Gravity.BOTTOM
	ListView1.TwoLinesLayout.ItemHeight = 60dip
	ListView1.TwoLinesLayout.Label.TextSize = 11
	ListView1.TwoLinesLayout.Label.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.Label.Gravity=Gravity.TOP
	ListView1.TwoLinesLayout.SecondLabel.TextSize = 11
	ListView1.TwoLinesLayout.SecondLabel.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.SecondLabel.Gravity=Gravity.TOP
	
	Dim countryNo As Int
	Dim CovidCountries As HttpJob
	CovidCountries.Initialize("GetDetails", Me)
	CovidCountries.Download(sSrcAPI)

	Wait For (CovidCountries) JobDone(CovidCountries As HttpJob)
	
	ProgressDialogHide
			
	If CovidCountries.Success Then
		Dim parser As JSONParser
		parser.Initialize(CovidCountries.GetString)
		Dim root As List = parser.NextArray
		For Each colroot As Map In root
			Dim continent As String = colroot.Get("continent")
			Dim country As String = colroot.Get("country")
			Dim cases As String = colroot.Get("cases")
			Dim critical As String = colroot.Get("critical")
			Dim active As String = colroot.Get("active")
			Dim testsPerMillion As String = colroot.Get("testsPerOneMillion")
			Dim recovered As String = colroot.Get("recovered")
			Dim tests As String = colroot.Get("tests")
			Dim deathsPerMillion As String = colroot.Get("deathsPerOneMillion")
			Dim casesPerMillion As String = colroot.Get("casesPerOneMillion")
'			Dim countryInfo As Map = colroot.Get("countryInfo")
'			Dim flag As String = countryInfo.Get("flag")
'			Dim _id As Int = countryInfo.Get("_id")
'			Dim iso2 As String = countryInfo.Get("iso2")
'			Dim lat As Int = countryInfo.Get("lat")
'			Dim long As Int = countryInfo.Get("long")
'			Dim iso3 As String = countryInfo.Get("iso3")
'			Dim updated As String = colroot.Get("updated")
			Dim deaths As String = colroot.Get("deaths")
			Dim todayCases As String = colroot.Get("todayCases")
			Dim todayDeaths As String = colroot.Get("todayDeaths")

'			Log("country: " & country)
'			Log(cases & ":" &  active & ":" & recovered & ":" & critical & ":" & deaths)
'			Log(todayCases & ":" &  todayDeaths)

			If recovered = "null" Then
				recovered = "0"
			End If
			
			If Not(country = "Total:") Then
				Dim CaseResult1 As String = "Cases:" & NumberFormat(cases, 0, 0) & _
										" | Active:" & NumberFormat(active, 0, 0) & _
										" | Recovered:" & NumberFormat(recovered, 0, 0) & _
										" | Critical:" & NumberFormat(critical, 0, 0) & _
										" | Deaths:" & NumberFormat(deaths, 0, 0) & _
										" | Cases/million:" & NumberFormat(casesPerMillion, 0, 0) & _
										" | Deaths/million:" & NumberFormat(deathsPerMillion, 0, 0)
										
				Dim CaseResult2 As String = "Todays Cases:" & NumberFormat(todayCases, 0, 0) & _
										" | Todays Deaths:" & NumberFormat(todayDeaths, 0, 0) & CRLF & _
										"Total Tests:" & NumberFormat(tests, 0, 0) & _
										" | Tests/million:" & NumberFormat(testsPerMillion, 0, 0)
			
				countryNo = countryNo +1
				ListView1.AddSingleLine(countryNo & ". " & country & " [" & continent & "]")
				ListView1.AddTwoLines(CaseResult1, CaseResult2)
			End If
		Next
	End If

	CovidCountries.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

'### Not Working ###
'Sub UnixTimeToDateTime(xUnixTime As Long) As String
'	Dim targetDate As Long = DateUtils.UnixTimeToTicks(xUnixTime)
'	DateTime.DateFormat = "dd-MMM-yyyy"
'	DateTime.TimeFormat = "HH:mm:ss"
'	DateTime.SetTimeZone(0)
'	
''	Log (DateTime.Date(targetDate))   '25.03.2014
''	Log (DateTime.Time(targetDate))   '10:52:50
'	Return DateTime.Date(targetDate) & " " & DateTime.Time(targetDate)
'		
''	DateTime.TimeFormat = "dd/MMM/yyyy HH:mm:ss"
''	Dim StartTimeText As String = DateTime.Time(xUnixTime*1000)	'convert to milliseconds
'''	Log("EPOCH converted to: " & StartTimeText)
''	Return StartTimeText
'End Sub

'Sub IIF(c As Boolean, TrueRes As String, FalseRes As String)
'	If c Then Return TrueRes Else Return FalseRes
'End Sub


