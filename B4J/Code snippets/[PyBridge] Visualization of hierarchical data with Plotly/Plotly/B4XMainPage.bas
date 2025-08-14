B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Plotly.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe


'pip install plotly
'pip install "plotly[express]"
'pip install pandas

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private WebView1 As WebView
	Private pd As PyWrapper
	Private px As PyWrapper
	Private MenuBar1 As MenuBar
	Private DataFrame As PyWrapper
	Private AnotherProgressBar1 As AnotherProgressBar
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	MenuBar1.Enabled = False
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	MenuBar1.Enabled = True
	Py.RunNoArgsCode("import plotly.express as px")
	px = Py.ImportModule("plotly.express")
	pd = Py.ImportModule("pandas")
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
	AnotherProgressBar1.Visible = False
	ShowGraph("Treemap")
End Sub

Private Sub MenuBar1_Action
	ShowGraph(Sender.As(MenuItem).Text.Replace("_", "")) 'remove the mnemonic underscore.
End Sub

Private Sub ShowGraph(GraphType As String)
	WebView1.LoadHtml("")
	AnotherProgressBar1.Visible = True
	Dim Path As List = Array(px.Run("Constant").Arg("World"), "Continent", "Country")
	Dim res As PyWrapper
	Select GraphType
		Case "Treemap"
			res = CreateTreemap(DataFrame, Path, "Population", "Treemap Graph")
		Case "Icicle"
			res = CreateIcicle(DataFrame, Path, "Population", "Icicle Graph")
		Case "Sunburst"
			res = CreateSunburst(DataFrame, Path, "Population", "Sunburst Graph")
		Case "Scatter"
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
	WebView1.LoadHtml(res.Value)
	AnotherProgressBar1.Visible = False
End Sub

Private Sub ColorToPythonHex(clr As Int) As String 'ignore
	Dim bc As ByteConverter
	Return "#" & bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr))).SubString(2) 'skip the alpha byte
End Sub

Private Sub CreateDataframe (Data As List, Columns As List) As PyWrapper
	Return pd.Run("DataFrame").Arg(Data).ArgNamed("columns", Columns)
End Sub

Private Sub CreateScatter (DataFrame1 As PyWrapper, XColumn As String, YColumn As String, ColorColumn As String, SizeColumn As String, Title As String) As PyWrapper
	Dim fig As PyWrapper = px.Run("scatter").Arg(DataFrame1).ArgNamed("title", Title).ArgNamed("x", XColumn).ArgNamed("y", YColumn)
	If ColorColumn <> "" Then fig = fig.ArgNamed("color", ColorColumn)
	If SizeColumn <> "" Then fig = fig.ArgNamed("size", SizeColumn)
	Return fig.Run("to_html").ArgNamed("config", CreateMap("displayModeBar": False))
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
	return fig.to_html(config={'displayModeBar': False} )
"$
	Return Py.RunCode("CreateSunburst", Array(DataFrame1, Path, Values), Code)
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
	return fig.to_html(config={'displayModeBar': False} )
"$
	Return Py.RunCode("CreateIcicle", Array(DataFrame1, Path, Values), Code)
End Sub

Private Sub CreateTreemap (DataFrame1 As PyWrapper, Path As List, Values As String, Title As String) As PyWrapper
	Dim Code As String = $"
def CreateTreemap (Dataframe, Path, Values):
	fig = px.treemap(Dataframe, path=Path, values=Values,
		color="Continent", color_discrete_sequence=px.colors.qualitative.Pastel)
	fig.update_traces(root_color="lightgrey", marker={"cornerradius": 5})
	fig.update_layout(margin = dict(t=50, l=25, r=25, b=25))
	fig.update_layout(title='${Title}')
	return fig.to_html(config={'displayModeBar': False} )
"$
	Return Py.RunCode("CreateTreemap", Array(DataFrame1, Path, Values), Code)
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub


