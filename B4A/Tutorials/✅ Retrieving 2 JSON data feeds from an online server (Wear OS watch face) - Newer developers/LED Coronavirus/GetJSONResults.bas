B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals

	Public MapCountryInfo As Map
	Private LstCountries As List

	Type WorldData(Confirmed As Int, Recovering As Int, Recovered As Int, Deceased As Int, ConfirmedToday As Int, DeceasedToday As Int)
End Sub

Public Sub Initialize
	LstCountries.Initialize
	MapCountryInfo.Initialize
End Sub

'START SEARCHING FOR THE IMAGES ON PIXABAY
Public Sub FetchCoronaJSON() As ResumableSub
	Dim Job As HttpJob
		Job.Initialize(Null, Me)
		Job.Download("https://corona.lmao.ninja/v2/countries") 'V2 API

	Wait For (Job) JobDone(Job As HttpJob)
	If Job.Success Then
		Wait For (ParseJSONCountries(Job.GetString)) Complete (Completed As Boolean)
	End If
	Job.Release
	Return True
End Sub

'PARSE THE JSON FILE INFORMATION
Sub ParseJSONCountries(JSONResults As String) As ResumableSub
	Dim Parser As JSONParser
		Parser.Initialize(JSONResults)

		MapCountryInfo.Clear
		LstCountries.Clear
		LstCountries.Add("SELECT COUNTRY")

		Dim CountryRoot As List = Parser.NextArray
		For Each ColRoot As Map In CountryRoot
			Dim Country As String = ColRoot.Get("country")
			Dim CountryInfo As Map = ColRoot.Get("countryInfo")
			Dim FlagURL As String = CountryInfo.Get("flag")

			LstCountries.Add(Country)
			MapCountryInfo.Put(Country, FlagURL)
		Next
		CallSubDelayed2(Configuration, "PopulateSpnCountries", LstCountries) 'Populates the spinner with the country list
	Return True
End Sub

'START SEARCHING FOR THE IMAGES ON PIXABAY
Public Sub ParseJSONCountry(Country As String) As ResumableSub
	Dim Job As HttpJob
		Job.Initialize(Null, Me)
		Job.Download($"https://corona.lmao.ninja/v2/countries/${Country}"$) 'V2 API

	Wait For (Job) JobDone(Job As HttpJob)
	If Job.Success Then
		Dim Parser As JSONParser
			Parser.Initialize(Job.GetString)
	
		Dim Root As Map = Parser.NextObject
		LEDCorona.TodayCases = Root.Get("todayCases")
		LEDCorona.TodayDeaths = Root.Get("todayDeaths")
	End If
	Job.Release
	Return True
End Sub

'DOWNLOAD THE IMAGES
Public Sub DownloadFlagImage(FlagURL As String) As ResumableSub
	Dim Job As HttpJob
		Job.Initialize(Null, Me)
		Job.Download(FlagURL)

	Wait For (Job) JobDone(Job As HttpJob)
	If Job.Success Then
		Dim BmpFlag As Bitmap = Job.GetBitmapResize(80dip, 80dip, True)
	End If
	Job.Release
	Return BmpFlag
End Sub
