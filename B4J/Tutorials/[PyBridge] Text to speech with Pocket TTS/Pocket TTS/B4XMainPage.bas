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

'pip install pocket-tts

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private TTSModel As PyWrapper
	Private VoiceState As PyWrapper
	Private Winsound As PyWrapper
	Private ScipyWavfile As PyWrapper
	Private IO As PyWrapper
	Private TextArea1 As B4XView
	Private B4XLoadingIndicator1 As B4XLoadingIndicator
	Private Button1 As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	SetBusy(True)
	TextArea1.Text = $"Testing text-to-speech with B4J and PyBridge.

Hello!

What is your name?"$
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	Dim PocketTTS As PyWrapper = Py.ImportModule("pocket_tts")
	Winsound = Py.ImportModule("winsound")
	ScipyWavfile = Py.ImportModule("scipy.io.wavfile")
	IO = Py.ImportModule("io")
	TTSModel = PocketTTS.GetField("TTSModel").Run("load_model")
	
	Py.ImportModule("pocket_tts.utils.utils").GetField("PREDEFINED_VOICES").ToList.Print2("Available voices:", "", False)
	Wait For (Py.Flush) Complete (Success As Boolean)
	Log("Loading voice information")
	VoiceState = TTSModel.Run("get_state_for_audio_prompt").Arg("alba")
	Wait For (Py.Flush) Complete (Success As Boolean)
	If Success Then
		Log("ready")
	Else
		Log("error: " & Py.PyLastException)
	End If
	SetBusy(False)
	
End Sub

Private Sub SetBusy (Busy As Boolean)
	Button1.Enabled = Not(Busy)
	If Busy Then B4XLoadingIndicator1.Show Else B4XLoadingIndicator1.Hide
End Sub

Private Sub Button1_Click
	TextToSpeech(TextArea1.Text)
	SetBusy(True)
End Sub

Private Sub TextToSpeech(Text As String)
	Dim audio As PyWrapper = TTSModel.Run("generate_audio").Arg(VoiceState).Arg(Text)
	Wait For (Py.Flush) Complete (Success As Boolean)
	SetBusy(False)
	Dim buffer As PyWrapper = IO.Run("BytesIO")
	ScipyWavfile.Run("write").Arg(buffer).Arg(TTSModel.GetField("sample_rate")).Arg(audio.Run("numpy"))
	PlayAudioData(buffer)
End Sub

Private Sub PlayAudioData (Buffer As PyWrapper)
	Winsound.Run("PlaySound").Arg(Buffer.Run("getvalue")).Arg(Winsound.GetField("SND_MEMORY"))
End Sub



Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub




