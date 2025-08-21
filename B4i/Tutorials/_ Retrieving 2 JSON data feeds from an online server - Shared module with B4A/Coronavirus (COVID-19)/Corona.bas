B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals

'***********************************
'   SHARED CLASS FOR B4A AND B4i   *
'***********************************

	Public AppName As String = "Coronavirus (COVID-19)"	
	Private WorldTotal() As String = Array As String("https://corona.lmao.ninja/v2/all", "https://corona.lmao.ninja/v2/countries")

	Public WD As WorldData
	Public MapCountryInfo As Map
	Private LstCountries As List

	Type WorldData(Confirmed As Int, Recovering As Int, Recovered As Int, Deceased As Int, ConfirmedToday As Int, DeceasedToday As Int)
End Sub

Public Sub Initialize
	WD.Initialize
	LstCountries.Initialize
	MapCountryInfo.Initialize
End Sub

'START SEARCHING FOR THE IMAGES ON PIXABAY
Sub FetchCoronaJSON() As ResumableSub
	Dim WorldResults As Boolean

	For i = 0 To WorldTotal.Length - 1
		Dim Job As HttpJob
			Job.Initialize(Null, Me)
			Job.Download(WorldTotal(i))

		Wait For (Job) JobDone(Job As HttpJob)
		If Job.Success Then
			Wait For (ParseJSONResults(Job.GetString, WorldResults)) Complete (Completed As Boolean)
		End If
		Job.Release
		WorldResults = Not(WorldResults)
	Next
	Return True
End Sub

'PARSE THE JSON FILE INFORMATION
Sub ParseJSONResults(JSONResults As String, WorldResults As Boolean) As ResumableSub
	Dim Parser As JSONParser
		Parser.Initialize(JSONResults)

	If Not(WorldResults) Then
		Dim WorldRoot As Map = Parser.NextObject
		WD.Confirmed = WorldRoot.Get("cases")
		WD.Recovering = WorldRoot.Get("cases") - WorldRoot.Get("recovered") - WorldRoot.Get("deaths")
		WD.Recovered = WorldRoot.Get("recovered")
		WD.Deceased = WorldRoot.Get("deaths")
		WD.ConfirmedToday = WorldRoot.Get("todayCases")
		WD.DeceasedToday = WorldRoot.Get("todayDeaths")

		CallSub(Main, "PopulateWorldTotals") 'Updates worls totals on the main app screen
	Else
		MapCountryInfo.Clear		
		LstCountries.Clear
		LstCountries.Add("SELECT COUNTRY")
		
		Dim CountryRoot As List = Parser.NextArray
		For Each ColRoot As Map In CountryRoot
			Dim Country As String = ColRoot.Get("country")
			Dim Cases As Int = ColRoot.Get("cases")
			Dim Recovered As Int = ColRoot.Get("recovered")
			Dim CountryInfo As Map = ColRoot.Get("countryInfo")
			Dim FlagURL As String = CountryInfo.Get("flag")
			Dim Deaths As Int = ColRoot.Get("deaths")
			Dim TodayCases As Int = ColRoot.Get("todayCases")
			Dim TodayDeaths As Int = ColRoot.Get("todayDeaths")

			LstCountries.Add(Country)
			MapCountryInfo.Put(Country, Array As Object(Cases,  Cases - Recovered - Deaths, Recovered, Deaths, TodayCases, TodayDeaths, FlagURL))
		Next
		CallSubDelayed2(Main, "PopulateB4XCmbCountry", LstCountries) 'Populates the combobox with 
	End If
	Return True
End Sub

'DOWNLOAD THE IMAGES
Public Sub DownloadFlagImage(ImgURL As String) As ResumableSub
	Dim Job As HttpJob
		Job.Initialize(Null, Me)
		Job.Download(ImgURL)

	Wait For (Job) JobDone(Job As HttpJob)
	If Job.Success Then
		Dim BmpFlag As Bitmap = Job.GetBitmapResize(80dip, 80dip, True)
	End If
	Job.Release
	Return BmpFlag
End Sub
