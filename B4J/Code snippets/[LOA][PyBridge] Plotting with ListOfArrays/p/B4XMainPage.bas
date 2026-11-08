B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

'depends on:
'pip install matplotlib
'pip install pandas

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private Sales As ListOfArrays
	Private B4XImageView1 As B4XImageView
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
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	Py.ImportModule("pandas")
	Sales = LOAUtils.CreateEmpty(Array("Month", "Sales", "Advertising"))
	Sales.AddRow(Array("Jan", 120, 10))
	Sales.AddRow(Array("Feb", 170, 15))
	Sales.AddRow(Array("Mar", 110, 12))
	Sales.AddRow(Array("Apr", 210, 20))
	Sales.AddRow(Array("May", 160, 24))
	Sales.AddRow(Array("Jun", 250, 22))
	Sales.AddRow(Array("Jul", 190, 30))
	Sales.AddRow(Array("Aug", 300, 28))
	Sales.AddRow(Array("Sep", 230, 35))
	Sales.AddRow(Array("Oct", 340, 38))
	Sales.AddRow(Array("Nov", 260, 42))
	Sales.AddRow(Array("Dec", 390, 48))
End Sub



Private Sub btnSimpleBar_Click
	Dim df As PyWrapper = LOAToDataFrame(Sales)
	Dim ax As PyWrapper = SimpleBar(df)
	GetImageAndShow(ax)
End Sub

Private Sub SimpleBar (df As PyWrapper) As PyWrapper
	Dim ax As PyWrapper = df.Run("plot").ArgNamed("kind", "bar").ArgNamed("x", "Month").ArgNamed("y", "Sales")
	Return ax
End Sub

Private Sub GetImageAndShow(ax As PyWrapper)
	Wait For (PlotToImage(ax)) Complete (Result As B4XBitmap)
	B4XImageView1.Bitmap = Result
End Sub

Private Sub btnNiceBar_Click
	Dim df As PyWrapper = LOAToDataFrame(Sales)
	Dim ax As PyWrapper = df.Run("plot").ArgNamed("kind", "bar").ArgNamed("x", "Month").ArgNamed("y", "Sales") _ 
		.ArgNamed("legend", False).ArgNamed("width", 0.7).ArgNamed("color", "#4E79A7").ArgNamed("figsize", Array(8, 5)) '800 x 500 image
	ax.Run("set_title").Arg("Monthly Sales").ArgNamed("fontsize", 18).ArgNamed("weight", "bold").ArgNamed("pad", 20)
	ax.Run("set_ylabel").Arg("Sales").ArgNamed("fontsize", 12)
	ax.Run("set_xlabel").Arg("")
	ax = NiceBar(ax)
	GetImageAndShow(ax)
End Sub



Private Sub NiceBar (ax As Object) As PyWrapper
	Dim Code As String = $"
def NiceBar (ax):
	
	fig = ax.get_figure()
	# Remove clutter
	ax.spines["top"].set_visible(False)
	ax.spines["right"].set_visible(False)
	ax.spines["left"].set_visible(False)

	# Horizontal grid only
	ax.yaxis.grid(True, linestyle="--", alpha=0.3)
	ax.set_axisbelow(True)

	# Value labels
	for container in ax.containers:
	    ax.bar_label(
	        container,
	        fmt="%.0f",
	        padding=4,
	        fontsize=11,
	        weight="bold"
	    )

	# Nice margins
	ax.margins(y=0.15)
	fig.tight_layout(pad=2)
	return ax
"$
	Return Py.RunCode("NiceBar", Array(ax), Code)
End Sub

Private Sub btnPie_Click
	Dim df As PyWrapper = LOAToDataFrame(Sales)

	Dim ax As PyWrapper = df.Run("plot").ArgNamed("kind", "pie") _
        .ArgNamed("y", "Sales") _
        .ArgNamed("labels", df.Get("Month")) _
        .ArgNamed("autopct", "%1.0f%%") _
        .ArgNamed("startangle", 90) _
        .ArgNamed("legend", False) _
        .ArgNamed("figsize", Array(8, 5)) _
		.ArgNamed("labeldistance", 1.15) _
        .ArgNamed("pctdistance", 0.78)
	ax = NicePie(ax)
	ax.Run("set_ylabel").Arg("")
	ax.Run("set_title").Arg("Monthly Sales").ArgNamed("fontsize", 18).ArgNamed("fontweight", "bold")

	GetImageAndShow(ax)
End Sub

Private Sub NicePie(ax As Object) As PyWrapper
	Dim Code As String = $"
def NicePie(ax):
	fig = ax.get_figure()
	wedges = ax.patches
	for w in wedges:
		w.set_edgecolor('white')
		w.set_linewidth(2)
		w.set_width(0.45)
	for t in ax.texts:
		if '%' in t.get_text():
			t.set_fontweight('bold')
	fig.tight_layout(pad=2)
	return ax
"$
	Return Py.RunCode("NicePie", Array(ax), Code)
End Sub

Private Sub btnScatter_Click
	Dim df As PyWrapper = LOAToDataFrame(Sales)

	Dim ax As PyWrapper = df.Run("plot") _
        .ArgNamed("kind", "scatter") _
        .ArgNamed("x", "Advertising") _
        .ArgNamed("y", "Sales") _
        .ArgNamed("s", 120) _ 'points size
        .ArgNamed("figsize", Array(8, 5))

	ax.Run("set_title").Arg("Advertising vs Sales") _
        .ArgNamed("fontsize", 18) _
        .ArgNamed("weight", "bold")

	ax = NiceScatter(ax)

	GetImageAndShow(ax)
End Sub

Private Sub NiceScatter(ax As Object) As PyWrapper
	Dim Code As String = $"
def NiceScatter(ax):
	fig = ax.get_figure()
	ax.spines['top'].set_visible(False)
	ax.spines['right'].set_visible(False)
	ax.grid(True, linestyle='--', alpha=0.3)
	ax.set_axisbelow(True)
	fig.tight_layout(pad=2)
	return ax
"$
	Return Py.RunCode("NiceScatter", Array(ax), Code)
End Sub

Private Sub PlotToImage (ax As PyWrapper) As ResumableSub
	Dim BytesIO As PyWrapper = Py.ImportModuleFrom("io", "BytesIO")
	Dim rv As PyWrapper = BytesIO.Call
	Dim fig As PyWrapper = ax.Run("get_figure")
	fig.Run("tight_layout")
	fig.Run("savefig").Arg(rv).ArgNamed("format", "png")
	Dim plt As PyWrapper = Py.ImportModule("matplotlib.pyplot")
	plt.Run("close").Arg(fig)
	Wait For (rv.Run("getvalue").Fetch) Complete (img As PyWrapper)
	Return Py.ImageFromBytes(img.Value)
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

'Converts a LOA to DataFrame.
Public Sub LOAToDataFrame (LOA As ListOfArrays) As PyWrapper
	Dim Code As String = $"
def LOAToDataFrame (LOA):
    df = pandas.DataFrame(LOA[1:], columns=LOA[0])
    return df
"$
	Return Py.RunCode("LOAToDataFrame", Array(LOA.mInternalArray), Code)
End Sub


