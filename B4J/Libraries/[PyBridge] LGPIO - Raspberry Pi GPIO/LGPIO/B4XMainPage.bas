B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=LGPIOExample.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private LedPin, ButtonPin As Int
	Private gpio As LGPIO
	Private Label1 As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("/usr/bin/python")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	LedPin = 21
	ButtonPin = 20
	gpio.Initialize(Py, Me, "gpio")
	gpio.Open(0)
	gpio.ClaimOutput(LedPin)
	gpio.Write(LedPin, 1)
	gpio.ClaimAlert(ButtonPin, gpio.EDGE_BOTH, gpio.SET_PULL_UP)
	gpio.DebounceMicros(ButtonPin, 10000)
End Sub

Private Sub btnToggle_Click
	Dim CurrentValue As PyWrapper = gpio.Read(LedPin)
	Wait For (CurrentValue.Fetch) Complete (CurrentValue As PyWrapper)
	gpio.Write(LedPin, IIf(CurrentValue.Value.As(Int) = 1, 0, 1))
	gpio.Read(ButtonPin).Print2("button level: ", "", False)
End Sub

Private Sub GPIO_StateChanged (Pin As Int, Level As Int)
	Log(Pin & ": " & Level)
	If Level = 1 Then
		Label1.Text = "Button up"
	Else
		Label1.Text = "Button down"
	End If
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	gpio.Close
	Sleep(50)
	Return True
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

