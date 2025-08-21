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
	Private IME As IME
	Private Lbl_Location As Label
	Private Btn_Search2 As SwiftButton
	Private Txt_CountrySearch As B4XFloatTextField
	Private Lbl_Source As Label
'	Private sSrcAPI As String = "https://coronavirus-19-api.herokuapp.com/countries/"
	Private sSrcAPI As String = "https://corona.lmao.ninja/v2/countries/"  'India?yesterday=false&strict=true&query"
	Private ListView1 As ListView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("searchcountry")
	
	IME.Initialize("IME")
	Lbl_Location.Text = "Search By Country"
	Lbl_Source.Text = "source » " & sSrcAPI
		
'	If FirstTime Then
'		nf = SetFormatChars(",", ".")
'	End If
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub covidsearch
	ListView1.Clear
	ListView1.SingleLineLayout.ItemHeight = 35dip
	ListView1.SingleLineLayout.Label.TextSize = 16
	ListView1.SingleLineLayout.Label.TextColor = Colors.White
	ListView1.SingleLineLayout.Label.Gravity = Gravity.CENTER_HORIZONTAL
	ListView1.SingleLineLayout.Label.Gravity = Gravity.CENTER_VERTICAL
	ListView1.TwoLinesLayout.ItemHeight = 22dip
	ListView1.TwoLinesLayout.Label.TextSize = 12
	ListView1.TwoLinesLayout.Label.TextColor = Colors.ARGB(175, 255, 255, 255)
	ListView1.TwoLinesLayout.Label.Gravity=Gravity.TOP
	ListView1.TwoLinesLayout.SecondLabel.TextSize = 11
	ListView1.TwoLinesLayout.SecondLabel.TextColor = Colors.ARGB(175, 255, 255, 255)
	ListView1.TwoLinesLayout.SecondLabel.Gravity=Gravity.TOP

	Dim searchcountry As HttpJob
	searchcountry.Initialize("GetDetails", Me)
	searchcountry.Download(sSrcAPI & Txt_CountrySearch.Text & "?yesterday=false&strict=true&query")
	
	Wait For (searchcountry) JobDone(searchcountry As HttpJob)
	
	ProgressDialogHide
		
	If searchcountry.Success Then
		If Not(searchcountry.GetString = "Country not found") Then
			Dim parser As JSONParser
			parser.Initialize(searchcountry.GetString)

			Dim root As Map = parser.NextObject
			Dim continent As String = root.Get("continent")
			Dim country As String = root.Get("country")
			Dim recoveredPerOneMillion As Double = func.IIF(root.Get("recoveredPerOneMillion")<>Null, root.Get("recoveredPerOneMillion"), 0)
			Dim cases As Int = root.Get("cases")
			Dim critical As Int = root.Get("critical")
			Dim active As Int = root.Get("active")
			Dim testsPerOneMillion As Int = root.Get("testsPerOneMillion")
			Dim population As Int = func.IIF(root.Get("population")<>Null, root.Get("population"), 0)
			Dim recovered As Int = func.IIF(root.Get("recovered")<>Null, root.Get("recovered"), 0)
			Dim tests As Int = func.IIF(root.Get("tests")<>Null, root.Get("tests"), 0)
			Dim criticalPerOneMillion As Double = root.Get("criticalPerOneMillion")
			Dim deathsPerOneMillion As Int = root.Get("deathsPerOneMillion")
			Dim todayRecovered As Int = func.IIF( root.Get("todayRecovered")<>Null, root.Get("todayRecovered"), 0)
			Dim casesPerOneMillion As Int = root.Get("casesPerOneMillion")
'			Dim countryInfo As Map = root.Get("countryInfo")
'			Dim flag As String = countryInfo.Get("flag")
'			Dim _id As Int = countryInfo.Get("_id")
'			Dim iso2 As String = countryInfo.Get("iso2")
'			Dim lat As Int = countryInfo.Get("lat")
'			Dim long As Int = countryInfo.Get("long")
'			Dim iso3 As String = countryInfo.Get("iso3")
'			Dim updated As String = root.Get("updated")
			Dim deaths As Int = root.Get("deaths")
			Dim activePerOneMillion As Double = root.Get("activePerOneMillion")
			Dim todayCases As Int = root.Get("todayCases")
			Dim todayDeaths As Int = root.Get("todayDeaths")

'			If population = Null Or population = "null" Then
'				population = "0"
'			End If
			
			ListView1.AddSingleLine(country & " [" & continent & "]")
			ListView1.AddTwoLines("Cases: " & NumberFormat(cases, 0, 0), "")
			ListView1.AddTwoLines("Active: " & NumberFormat(active, 0, 0), "")
			ListView1.AddTwoLines("Recovered: " & NumberFormat(recovered, 0, 0), "")
			ListView1.AddTwoLines("Critical: " & NumberFormat(critical, 0, 0), "")
			ListView1.AddTwoLines("Deaths: " & NumberFormat(deaths, 0, 0), "")
			ListView1.AddTwoLines("Cases/million: " & NumberFormat(casesPerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Active/million: " & NumberFormat(activePerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Recovered/million: " & NumberFormat(recoveredPerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Critical/million: " & NumberFormat(criticalPerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Deaths/million: " & NumberFormat(deathsPerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Todays Cases: " & NumberFormat(todayCases, 0, 0), "")
			ListView1.AddTwoLines("Todays Recovered: " & NumberFormat(todayRecovered, 0, 0), "")
			ListView1.AddTwoLines("Todays Deaths: " & NumberFormat(todayDeaths, 0, 0), "")
			ListView1.AddTwoLines("Total Tests: " & NumberFormat(tests, 0, 0), "")
			ListView1.AddTwoLines("Tests/million: " & NumberFormat(testsPerOneMillion, 0, 0), "")
			ListView1.AddTwoLines("Population: " & NumberFormat(population, 0, 0), "")

		Else
			ToastMessageShow("Country not found", True)
		End If
	Else
		ToastMessageShow("Country not found", True)
	End If

	searchcountry.Release

End Sub

Sub Btn_Back_Click
	IME.HideKeyboard
	StartActivity(Main)
	Activity.Finish
End Sub

Sub Btn_Search2_Click
	IME.HideKeyboard
	ProgressDialogShow2("Searching data...", False)
	covidsearch
End Sub

