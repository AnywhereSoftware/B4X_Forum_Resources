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
	
	Private pLib As PassLib
	Private Password As String
	Private Algo As String
	'Argon2
	Private TimeCost As Int
	Private MemoryCost As Int
	Private Parallelism As Int
	
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
	
	'pip install passlib
	'pip install "bcrypt==4.0.1"
	'pip install argon2-cffi
	
	'valid algorithms
	'1 - bcrypt
	'2 - pbkdf2
	'3 - argon2 - The best
	'4 - scrypt
	'5 - sha512_crypt - Only Unix/Linux

	pLib.Initialize
	Password = "my_new_password_to_hash"
	Algo = "argon2"
	
	'only for argon2. The parameters will not be taken into account for other algorithms
	TimeCost = 3 'Number of iterations (more = more secure)
	MemoryCost = 65536 'Memory used in Kb
	Parallelism = 4 'Number of threads (useful on multi-core CPUs)
	
	' Hash
	Wait For (pLib.EncryptPassword(Password, Algo, TimeCost, MemoryCost, Parallelism)) Complete (hashed As String)
	Log("Hashed password : " & hashed)

	Sleep(1000)

	' Verification
	Wait For (pLib.VerifyPassword(Password, hashed, Algo)) Complete (isValid As Boolean)
	Log("Valid password ? " & isValid)

End Sub

Sub Py_passliberror(data As Map)
	Dim s As String = data.Get("error")
	Log(s)
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub




