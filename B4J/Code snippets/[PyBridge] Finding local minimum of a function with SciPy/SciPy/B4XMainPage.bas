B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private optimize As PyWrapper
	Private np As PyWrapper
	Private plt As PyWrapper
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
	RunImports
	
	Dim func As PyWrapper = Py.Lambda("x: (x - 3) ** 2 + 2 * x - 1") '** is the power operator.
	Dim res As PyWrapper = optimize.Run("minimize").Arg(func).Arg(Array(10))
	res.Print
	Dim x As PyWrapper = res.GetField("x").Get(0) 'get is an array with a single element
	Dim min_value As PyWrapper = res.GetField("fun")
	func.Call.Arg(x).Print2("X minimum: ", "", False)
	PlotFunc(func, -10, 10)
	'mark the minimum point
	plt.Run("plot").Arg(x).Arg(min_value).ArgNamed("marker", "o").ArgNamed("color", "red")
	plt.Run("show") 'this is a modal call. Program will stop until plot is closed.
	
	'example with a 2d function:
	Dim func As PyWrapper = Py.Lambda("x: np.sin(x[0]) + np.cos(x[1]) + 0.1 * (x[0] ** 2 + x[1] ** 2)") 'x is a vector with 2 elements
	Dim res As PyWrapper = optimize.Run("minimize").Arg(func).Arg(Array(2, 2))
	res.Print
	Dim x As PyWrapper = res.GetField("x") 'x is an array with two elements
	Dim min_value As PyWrapper = res.GetField("fun")
	Dim ax As PyWrapper = Plot2DFunc(func, -10, 10, -10, 10)
	'mark the minimum point:
	ax.Run("scatter").Arg(x.Get(0)).Arg(x.Get(1)).Arg(min_value).ArgNamed("color", "red").ArgNamed("s", 100)
	plt.Run("show")
End Sub

Private Sub RunImports
	np = Py.ImportModule("numpy")
	Py.RunNoArgsCode("import numpy as np")
	optimize = Py.ImportModule("scipy.optimize")
	plt = Py.ImportModule("matplotlib.pyplot")
	Py.ImportModuleFrom("mpl_toolkits.mplot3d", "Axes3D")
End Sub

Private Sub PlotFunc (Func As PyWrapper, FromX As Object, ToX As Object)
	Dim x As PyWrapper = Linspace(FromX, ToX, 100)
	Dim y As PyWrapper = Func.Call.Arg(x)
	plt.Run("plot").Arg(x).Arg(y)
End Sub

Private Sub Plot2DFunc(Func As PyWrapper, FromX As Object, ToX As Object, FromY As Object, ToY As Object) As PyWrapper
	Dim x As PyWrapper = Linspace(FromX, ToX, 100)
	Dim y As PyWrapper = Linspace(FromY, ToY, 100)
	Dim mesh As PyWrapper = np.Run("meshgrid").Arg(x).Arg(y)
	Dim z As PyWrapper = Func.Call.Arg(mesh)
	Dim fig As PyWrapper = plt.Run("figure")
	Dim ax As PyWrapper = fig.Run("add_subplot").Arg(111).ArgNamed("projection", "3d")
	ax.Run("plot_surface").Arg(mesh.Get(0)).Arg(mesh.Get(1)).Arg(z)
	Return ax
End Sub

Private Sub Linspace (Start As Object, Stop As Object, NumberOfPoints As Object) As PyWrapper
	Return np.Run("linspace").Arg(Start).Arg(Stop).Arg(NumberOfPoints)
End Sub



Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub


