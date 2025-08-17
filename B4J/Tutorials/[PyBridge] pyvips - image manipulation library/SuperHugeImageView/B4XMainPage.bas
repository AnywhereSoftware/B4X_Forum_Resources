B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SuperHugeIV.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private HugeImageView1 As HugeImageView
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
	Dim PathToVips As String = "C:\Users\H\Downloads\projects\vips-dev-8.16\bin" '<----
	opt.EnvironmentVars.Put("PATH", opt.EnvironmentVars.Get("PATH") & ";" & PathToVips)
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	HugeImageView1.SetBitmap("D:\path_to_large_image", "", True)
End Sub

Private Sub HugeImageView1_Progress (Visible As Boolean)
	AnotherProgressBar1.Visible = Visible
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

