B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private py As PyBridge
	Private pd As PyWrapper
	Private px As PyWrapper
	Private DataFrame As PyWrapper
	Type GraphRequest (GraphType As String, Callback As Object)
End Sub

Public Sub Initialize
	Main.PyWorker = Me
	Start
	StartMessageLoop
End Sub

Private Sub Start
	py.Initialize(Me, "py")
	Dim opt As PyOptions = py.CreateOptions("Python/python/python.exe")
	py.Start(opt)
	Wait For py_Connected (Success As Boolean)
	If Success = False Then
		py_Disconnected
		Return
	End If
	py.RunNoArgsCode("import plotly.express as px")
	py.RunNoArgsCode("import plotly.io as pio")
	px = py.ImportModule("plotly.express")
	pd = py.ImportModule("pandas")
	Dim RawData As List = File.ReadString(File.DirAssets, "countries.json") _
		.As(JSON).ToMap.Get("countries").As(Map).Get("country")
	Dim Columns As List = Array("Continent", "Country", "Population")
	Dim Data As List = B4XCollections.CreateList(Null)
	For Each c As Map In RawData
		Dim Country As String = c.Get("countryName")
		Dim Population As Long = c.Get("population")
		Dim Continent As String = c.Get("continentName")
		Data.Add(Array(Continent, Country, Population))
	Next
	DataFrame = CreateDataframe(Data, Columns)
End Sub

Public Sub Show_Graph (Request As GraphRequest)
	Dim Path As List = Array(px.Run("Constant").Arg("World"), "Continent", "Country")
	Dim res As PyWrapper
	Select Request.GraphType
		Case "treemap"
			res = CreateTreemap(DataFrame, Path, "Population", "Treemap Graph")
		Case "icicle"
			res = CreateIcicle(DataFrame, Path, "Population", "Icicle Graph")
		Case "sunburst"
			res = CreateSunburst(DataFrame, Path, "Population", "Sunburst Graph")
		Case "scatter"
			Dim data As List = B4XCollections.CreateList(Null)
			Dim Categories As List = Array("Cat #1", "Cat #2", "Cat #3")
			Dim columns As List = Array("X", "Y", "Size", "Category")
			For i = 1 To 20
				Dim category As Int = Rnd(0, Categories.Size)
				data.Add(Array(Rnd(0, 100000) / 100, Rnd(0, 100000) / 100, Rnd(1, 1000), Categories.Get(category)))
			Next
			Dim df As PyWrapper = CreateDataframe(data, columns)
			res = CreateScatter(df, "X", "Y", "Category", "Size", "Scatter Graph")
	End Select
	Wait For (res.Fetch) Complete (res As PyWrapper)
	CallSubDelayed2(Request.Callback, "Graph_Response", res.Value)
End Sub


Private Sub CreateDataframe (Data As List, Columns As List) As PyWrapper
	Return pd.Run("DataFrame").Arg(Data).ArgNamed("columns", Columns)
End Sub

Private Sub CreateScatter (DataFrame1 As PyWrapper, XColumn As String, YColumn As String, ColorColumn As String, SizeColumn As String, Title As String) As PyWrapper
	Dim fig As PyWrapper = px.Run("scatter").Arg(DataFrame1).ArgNamed("title", Title).ArgNamed("x", XColumn).ArgNamed("y", YColumn)
	If ColorColumn <> "" Then fig = fig.ArgNamed("color", ColorColumn)
	If SizeColumn <> "" Then fig = fig.ArgNamed("size", SizeColumn)
	Return fig.Run("to_html").ArgNamed("config", CreateMap("displayModeBar": False)).ArgNamed("include_plotlyjs", False).ArgNamed("full_html", False)
End Sub

Private Sub CreateSunburst (DataFrame1 As PyWrapper, Path As List, Values As String, Title As String) As PyWrapper
	Dim Code As String = $"
def CreateSunburst (Dataframe, Path, Values):
	fig = px.sunburst(Dataframe, path=Path, values=Values,
		color="Continent", color_discrete_sequence=px.colors.qualitative.Pastel)
	fig.update_traces(root_color="lightgrey")
	fig.update_traces(textinfo="label+value")
	fig.update_layout(margin = dict(t=50, l=25, r=25, b=25))
	fig.update_layout(title='${Title}')
	return pio.to_html(fig, include_plotlyjs=False, full_html=False)
"$
	Return py.RunCode("CreateSunburst", Array(DataFrame1, Path, Values), Code)
End Sub


Private Sub CreateIcicle (DataFrame1 As PyWrapper, Path As List, Values As String, Title As String) As PyWrapper
	Dim Code As String = $"
def CreateIcicle (Dataframe, Path, Values):
	fig = px.icicle(Dataframe, path=Path, values=Values,
		color="Continent", color_discrete_sequence=px.colors.qualitative.Pastel)
	fig.update_traces(root_color="lightgrey")
	fig.update_traces(textinfo="label+value")
	fig.update_layout(margin = dict(t=50, l=25, r=25, b=25))
	fig.update_layout(title='${Title}')
	return pio.to_html(fig, include_plotlyjs=False, full_html=False)
"$
	Return py.RunCode("CreateIcicle", Array(DataFrame1, Path, Values), Code)
End Sub

Private Sub CreateTreemap (DataFrame1 As PyWrapper, Path As List, Values As String, Title As String) As PyWrapper
	Dim Code As String = $"
def CreateTreemap (Dataframe, Path, Values):
	fig = px.treemap(Dataframe, path=Path, values=Values,
		color="Continent", color_discrete_sequence=px.colors.qualitative.Pastel)
	fig.update_traces(root_color="lightgrey", marker={"cornerradius": 5})
	fig.update_layout(margin = dict(t=50, l=25, r=25, b=25))
	fig.update_layout(title='${Title}')
	return pio.to_html(fig, include_plotlyjs=False, full_html=False)
"$
	Return py.RunCode("CreateTreemap", Array(DataFrame1, Path, Values), Code)
End Sub

Private Sub py_Disconnected
	Log("PyBridge disconnected!!!")
	Sleep(60000)
	Start
End Sub

