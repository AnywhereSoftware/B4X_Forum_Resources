B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Ctrl + click to open Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'dependencies: pip install scikit-learn matplotlib
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Type TrainingData (XTrain As PyWrapper, YTrain As PyWrapper, XTest As PyWrapper, YTest As PyWrapper)
	Private AnotherProgressBar1 As AnotherProgressBar
	Private B4XImageView1 As B4XImageView
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions(File.Combine(File.DirApp, "Python/python/python.exe"))
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	'load the data
	Dim su As StringUtils
	Dim Headers As List
	Headers.Initialize
	Dim data As List = su.LoadCSV2(File.DirAssets, "diabetes_dataset.csv", ",", Headers)
	Dim bmi As List
	bmi.Initialize
	Dim target As List
	target.Initialize
	For Each row() As String In data
		bmi.Add(Array(row(2).As(Double))) 'the X input is expected to be a list of arrays.
		target.Add(row(10).As(Double))
	Next
	'split
	Dim TD As TrainingData = SplitData(bmi, target, 0.9)
	'train the model
	Dim LinearRegression As PyWrapper = Py.ImportModuleFrom("sklearn.linear_model", "LinearRegression")
	Dim regressor As PyWrapper = LinearRegression.Call.Run("fit").Arg(TD.XTrain).Arg(TD.YTrain)
	
	'evaluate
	Dim metrics As PyWrapper = Py.ImportModule("sklearn.metrics")
	Dim TestPred As PyWrapper = regressor.Run("predict").Arg(TD.XTest)
	Dim MeanSquareError As PyWrapper = metrics.Run("mean_squared_error").Arg(TD.YTest).Arg(TestPred)
	Dim R2Score As PyWrapper = metrics.Run("r2_score").Arg(TD.YTest).Arg(TestPred)
	Wait For (Py.FetchObjects(Array(MeanSquareError, R2Score))) Complete (Fetched As List)
	Log($"Mean squared error: $1.2{Fetched.Get(0)}"$)
	Log($"Coefficient of determination: $1.2{Fetched.Get(1)}"$)
	'plot
	Dim TrainPrediction As PyWrapper = regressor.Run("predict").Arg(TD.XTrain)
	Wait For (PlotResults(TD, TrainPrediction, TestPred)) Complete (Image As B4XBitmap)
	AnotherProgressBar1.Visible = False
	B4XImageView1.Bitmap = Image
End Sub

Private Sub PlotResults (Data As TrainingData, TrainPrediction As PyWrapper, TestPrediction As PyWrapper) As ResumableSub
	Dim plt As PyWrapper = Py.ImportModule("matplotlib.pyplot")
	Dim ax As PyWrapper = plt.Run("subplots").ArgNamed("ncols", 2).ArgNamed("sharex", True).ArgNamed("sharey", True) _
		.ArgNamed("figsize", Array(12, 8)).Get(1)
	DrawGraph(ax.Get(0), Data.XTrain, Data.YTrain, TrainPrediction, "Train data points", "Train set")
	DrawGraph(ax.Get(1), Data.XTest, Data.YTest, TestPrediction, "Test data points", "Test set")
	ax.Get(0).Run("get_figure").Run("suptitle").Arg("Linear Regression")
	plt.Run("tight_layout")
	'plt.Run("show") 'to show the standard plot window.
	
	'or if you want to return an image:
	Dim buffer As PyWrapper = Py.ImportModule("io").Run("BytesIO")
	plt.Run("savefig").Arg(buffer)
	Wait For (buffer.Fetch) Complete (buffer As PyWrapper)
	Return Py.ImageFromBytes(buffer.Value)
End Sub

Private Sub DrawGraph(Axes As PyWrapper, XData As PyWrapper, YData As PyWrapper, YPred As PyWrapper, Title As String, XLabel As String)
	Dim PlotProps As Map = CreateMap("linewidth": 3, "color": "tab:orange", "label": "Model predictions")
	Dim labels As Map = CreateMap("xlabel": "Normalized BMI", "ylabel": "Target", "title": Title)
	Axes.Run("scatter").Arg(XData).Arg(YData).ArgNamed("label", XLabel)
	Axes.Run("plot").Arg(XData).Arg(YPred).ArgsNamed(PlotProps)
	Axes.Run("set").ArgsNamed(labels)
	Axes.Run("legend")
End Sub

Private Sub SplitData (X As List, Y As List, TrainSizeRatio As Double) As TrainingData
	Dim TrainSize As Int = X.Size * TrainSizeRatio
	Dim res As TrainingData
	res.Initialize
	res.XTrain = Py.WrapObject(SubList(X, 0, TrainSize))
	res.YTrain = Py.WrapObject(SubList(Y, 0, TrainSize))
	res.XTest = Py.WrapObject(SubList(X, TrainSize, X.Size))
	res.YTest = Py.WrapObject(SubList(Y, TrainSize, Y.Size))
	Return res
End Sub

'This will be included in B4XCollections
Public Sub SubList (Items As List, StartIndex As Int, EndIndex As Int) As List
	Dim res As List
	res.Initialize
	For i = StartIndex To EndIndex - 1
		res.Add(Items.Get(i))
	Next
	Return res
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

