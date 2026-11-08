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
	
	Private Crypto As Cryptography
	Private Key As String
	
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
	
	
	'Install Lib : pip install cryptography
	
	
	Dim EncryptString As String = "user@example.com"
	Crypto.Initialize
	
	'Get new key
	Wait For (Crypto.GetKey) Complete (newkey As String)
	Key = newkey
	Log("key = "&Key)
	
	'Encrypt
	Wait For (Crypto.Encrypt(EncryptString, Key)) Complete (EncryptedData As String)
	Log("Encrypted : "&EncryptedData)
	
	'Decrypt
	Wait For (Crypto.Decrypt(EncryptedData, key)) Complete (value As String)
	Log("Decrypted : " & value)
	
End Sub

Private Sub Py_ferneterror(error As Map)
	Log(error.Get("error"))
End Sub





Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub
