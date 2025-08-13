B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=TTS.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe


'dependencies: pip install pyttsx3

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private TextField1 As B4XView
	Private Ttsx3Engine As PyWrapper
	
	Private Button1 As B4XView
	Private ListView1 As ListView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	opt.EnvironmentVars.Put("PATH", GetEnvironmentVariable("PATH", "")) 'will not be required with PyBridge 1+.	
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	'pip install pyttsx3
	Wait For (CreateEngine) Complete (Success As Boolean)
	If Success = False Then
		TextField1.Text = "Failed to create TTS engine: " & Py.PyLastException
		Log(TextField1.Text)
		Return
	End If
	TextField1.Enabled = Success
	Button1.Enabled = Success
End Sub

Private Sub CreateEngine As ResumableSub
	Ttsx3Engine = Py.ImportModule("pyttsx3").Run("init")
	Dim voices As PyWrapper = Ttsx3Engine.Run("getProperty").Arg("voices")
	'Get the voices names:
	Dim VoicesNames As PyWrapper = Py.Map_(Py.Lambda("v: v.name"), voices).ToList
	Wait For (VoicesNames.Fetch) Complete (voices As PyWrapper)
	For Each Voice As String In voices.Value.As(List)
		ListView1.Items.Add(Voice)
	Next
	Wait For (Py.Flush) Complete (Success As Boolean)
	Return Success
End Sub

Private Sub ListView1_SelectedIndexChanged(Index As Int)
	Dim voices As PyWrapper = Ttsx3Engine.Run("getProperty").Arg("voices")
	Ttsx3Engine.Run("setProperty").Arg("voice").Arg(voices.Get(Index).GetField("id"))
End Sub

Private Sub Say(Text As String)
	Button1.Enabled = False
	Ttsx3Engine.Run("say").Arg(Text)
	Ttsx3Engine.Run("runAndWait")
	Ttsx3Engine.Run("stop")
	Wait For (Py.Flush) Complete (Success As Boolean)
	Button1.Enabled = True
End Sub

Private Sub Button1_Click
	Say(TextField1.Text)
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub
