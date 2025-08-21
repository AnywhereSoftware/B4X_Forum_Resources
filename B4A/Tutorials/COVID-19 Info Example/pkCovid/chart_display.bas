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
	Private CountriesData As B4XOrderedMap
	Type CountryDataPoint (Date As Long, TotalCases As Int, TotalDeaths As Int, Country As String)
	Private parser As CSVParser
'	Private LastMaxDate As Long

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private CLV As CustomListView
	Private PCLV As PreoptimizedCLV
	Private Charts As List
	Private xChart1 As xChart
	Private xui As XUI
	Private pnlChartBase As B4XView
	Private Lbl_Location As Label
	Private Btn_Back As Button
	Private Lbl_Source As Label
	Private sSrcAPI As String = "https://covid.ourworldindata.org/data/ecdc/full_data.csv"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	parser.Initialize
	Activity.LoadLayout("charts")
	
	Lbl_Location.Text = "World Corona Charts"
	Lbl_Source.Text = "source » " & sSrcAPI

	PCLV.Initialize(Me, "PCLV", CLV)
	DateTime.DateFormat = "yyyy-MM-dd"
	CountriesData.Initialize
	PCLV.NumberOfSteps = 20
	
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download(sSrcAPI)
	Wait For (j) JobDone(j As HttpJob)
	
	If j.Success Then
		LoadData(j.GetString)
	Else
		LoadData(File.ReadString(File.DirAssets, "full_data.csv"))
	End If
	j.Release
	
	Charts.Initialize
	For Each country As String In CountriesData.Keys
		PCLV.AddItem(200dip, xui.Color_White, country)
	Next
	PCLV.Commit
	PCLV.lblHint.Font = xui.CreateDefaultBoldFont(30)
	PCLV.lblHint.TextColor = xui.Color_Black

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

Sub PCLV_HintRequested (Index As Int) As Object
	Dim cs As CSBuilder
	cs.Initialize
	Dim counter As Int
	For i = Index To Min(CLV.Size - 1, Index + 10)
		If counter = 3 Then
			cs.Color(0xFF878787)
		End If
		cs.Append(CLV.GetValue(i)).Append(CRLF)
		counter = counter + 1
	Next
	Return cs.PopAll
End Sub

Sub CLV_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For Each i As Int In PCLV.VisibleRangeChanged(FirstIndex, LastIndex)
		Dim item As CLVItem = CLV.GetRawListItem(i)
		Dim pnl As B4XView = xui.CreatePanel("")
		item.Panel.AddView(pnl, 0, 0, item.Panel.Width, item.Panel.Height)
		AddChart(pnl, item.Value)
	Next
End Sub

Sub AddChart (pnl As B4XView, Country As String)
	Dim UnusedChartBase As B4XView
	For Each ChartBase As B4XView In Charts
		If ChartBase.Parent.IsInitialized = False Then
			UnusedChartBase = ChartBase
			Exit
		End If
	Next
	If UnusedChartBase.IsInitialized = False Then
		pnl.LoadLayout("Item")
		Charts.Add(pnlChartBase)
		pnlChartBase.Tag = xChart1
		UnusedChartBase = pnlChartBase
	Else
		pnl.AddView(UnusedChartBase, 0, 0, pnl.Width, pnl.Height)
	End If
	UnusedChartBase.GetView(1).Text = Country
	Dim Chart As xChart = UnusedChartBase.Tag
	Chart.ClearData
	Chart.AddLine("Cases", xui.Color_Blue)
	Chart.AddLine("Deaths", xui.Color_Red)
	AddPointsToChart(CountriesData.Get(Country), Chart)
	Chart.DrawChart
End Sub

Sub LoadData (csv As String)
	Dim TableData As List
	TableData.Initialize
	If ReadCountriesData(csv, TableData) = False Then
		Log("No new data")
		Return
	End If
	
'	ReadCountriesData(csv, TableData)
	
End Sub

Sub ReadCountriesData (csv As String, TableData As List) As Boolean
	Log("Read countries data")
	Dim Data As List = parser.Parse(csv, ",", True)
	Dim CurrentCountry As String
	Dim NewData As B4XOrderedMap
	
	NewData.Initialize
	Dim MaxDate As Long
	
	For Each row() As String In Data
		Dim Country As String = row(1)
		If row(4) = "" Then row(4) = "0"
		If row(5) = "" Then row(5) = "0"
		If Country <> CurrentCountry Then
			CurrentCountry = Country
			Dim CountryDataPoints As List
			CountryDataPoints.Initialize
			NewData.Put(CurrentCountry, CountryDataPoints)
		End If
		Dim Date As Long = DateTime.DateParse(row(0))
		MaxDate = Max(MaxDate, Date)
		CountryDataPoints.Add(CreateCountryDataPoint(Date, row(4), row(5), Country))
	Next
	
	Activity.Title = $"Corona Cases Charts ($Date{MaxDate})"$
	NewData.Keys.Sort(True)
	For Each c As String In NewData.Keys
		TableData.Add(Array(c))
	Next
	
'	If LastMaxDate <> MaxDate Then
'		LastMaxDate = MaxDate
		CountriesData = NewData
		Return True
'	Else
'		Return False
'	End If

End Sub

Sub AddPointsToChart (Points As List, Chart As xChart)
	For Each cdp As CountryDataPoint In Points
		Chart.AddLineMultiplePoints(DateTime.Date(cdp.Date), Array As Double(cdp.TotalCases, cdp.TotalDeaths), False)
	Next
End Sub

Public Sub CreateCountryDataPoint (Date As Long, TotalCases As Int, TotalDeaths As Int, Country As String) As CountryDataPoint
	Dim t1 As CountryDataPoint
	t1.Initialize
	t1.Date = Date
	t1.TotalCases = TotalCases
	t1.TotalDeaths = TotalDeaths
	t1.Country = Country
	Return t1
End Sub

