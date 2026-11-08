B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SciPyCurveFit.zip
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
	Private Pane1 As B4XView
	Private cvs As B4XCanvas
	Private Points As List
	Private gap As Int = 10dip
	Private X0, Y0 As Double
	Private Width, Height As Double
	Type MyFunction (Function As PyWrapper, Params As List, IsValid As Boolean, Color As Int)
	Private functions As List
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	cvs.Initialize(Pane1)
	Points.Initialize
	functions.Initialize
	Draw
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	RunImports
	functions.Add(CreateMyFunction(Py.Lambda("x, a, b: a * x + b"), xui.Color_Blue)) 'linear function
	functions.Add(CreateMyFunction(Py.Lambda("x, a, b, c: a * x ** 2 + b * x + c"), xui.Color_Green)) '2nd degree polynom
	functions.Add(CreateMyFunction(Py.Lambda("x, a, b, c, d: a * x ** 3 + b * x ** 2 + c * x + d"), xui.Color_Gray)) '3rd degree polynom
End Sub

Private Sub B4XPage_Resize (Width1 As Int, Height1 As Int)
	cvs.Resize(Pane1.Width, Pane1.Height)
	Draw
End Sub

Private Sub RunImports
	np = Py.ImportModule("numpy")
	Py.RunNoArgsCode("import numpy as np")
	optimize = Py.ImportModule("scipy.optimize")
	'curve_fit returns a numpy ndarray. It is not serializable by default so add a custom converter:
	Dim converters As PyWrapper = Py.Bridge.GetField("comm").GetField("serializator").GetField("converters")
	converters.Set(np.GetField("ndarray"), Py.Lambda("arr: arr.tolist()"))
End Sub

Sub Draw
	X0 = gap
	Width = cvs.TargetRect.Width
	Height = cvs.TargetRect.Height
	Y0 = Height - gap
	cvs.ClearRect(cvs.TargetRect)
	cvs.DrawLine(X0, 0, X0, Y0, xui.Color_Black, 2dip)
	cvs.DrawLine(X0, Y0, cvs.TargetRect.Width, Y0, xui.Color_Black, 2dip)
	For Each p() As Double In Points
		Dim s() As Float = PointToScreen(p)
		cvs.DrawCircle(s(0), s(1), 8dip, xui.Color_Red, True, 0)
	Next
	If functions.Size > 0 Then
 		Dim x As PyWrapper = Linspace(0, 1, 100) '100 points between 0 to 1. No real reason to use Python linspace here but it was already implemented...
		Wait For (x.Fetch) Complete (x As PyWrapper)
		For Each func As MyFunction In functions
			If func.IsValid = False Then Return
			Dim y As PyWrapper = func.Function.Call.Arg(x).Args(func.Params) 'call the function with the vector X and the learned parameters.
			Wait For (y.Fetch) Complete (y As PyWrapper)
			Dim x_values As List = x.Value
			Dim y_values As List = y.Value
			For i = 1 To x_values.Size - 1
				Dim p1() As Double = Array As Double(x_values.Get(i - 1), y_values.Get(i - 1))
				Dim p2() As Double = Array As Double(x_values.Get(i), y_values.Get(i))
				Dim s1() As Float = PointToScreen(p1)
				Dim s2() As Float = PointToScreen(p2)
				cvs.DrawLine(s1(0), s1(1), s2(0), s2(1), func.Color, 3dip)
			Next
		Next
	End If
	cvs.Invalidate
End Sub

Private Sub Solve
	'Split the points into X and Y lists:
	Dim x As List
	x.Initialize
	Dim y As List
	y.Initialize
	For Each p() As Double In Points
		x.Add(p(0))
		y.Add(p(1))
	Next
	For Each func As MyFunction In functions
		Dim params As PyWrapper = optimize.Run("curve_fit").Arg(func.Function).Arg(x).Arg(y).Get(0) 'ignoring the covariance
		Wait For (params.Fetch) Complete (params As PyWrapper)
		func.IsValid = params.IsSuccess 'it will fail if there aren't enough points or if it wasn't able to solve the regression.
		If params.IsSuccess Then
			func.Params = params.Value
		End If
	Next
End Sub

Sub PointToScreen(p() As Double) As Float()
	Return Array As Float(p(0) * Width + X0, _
		-p(1) * Height + Y0)
End Sub

Sub Pane1_Touch (Action As Int, X As Float, Y As Float)
	If Action = Pane1.TOUCH_ACTION_UP Then
		Points.Add(Array As Double((X - X0)  / Width, (Y0 - Y) / Height))
		Solve
		Draw
	End If
End Sub

Sub Button1_Click
	Points.Clear
	For Each func As MyFunction In functions
		func.IsValid = False
	Next
	Draw
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


Public Sub CreateMyFunction (Function As PyWrapper, Color As Int) As MyFunction
	Dim t1 As MyFunction
	t1.Initialize
	t1.Function = Function
	t1.Color = Color
	Return t1
End Sub