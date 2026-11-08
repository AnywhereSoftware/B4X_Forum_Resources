B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4JCentral.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private btnSend As B4XView
	Private txtMessage As B4XFloatTextField
	Private txtLogs As B4XView
	Private BLE As Bleak
	Private ProgressDialog As B4XProgressDialog
	Private Toast As BCToast
	Private BLEClient As BleakClient
	Private ServiceId, ReadCharId, WriteCharId As String
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
	BLE.Initialize(Me, "BLE", Py)
	BLE.EnableDebugLogging 'comment to disable debug logging
	ProgressDialog.Initialize(Root)
	Toast.Initialize(Root)
	ServiceId = UUID("0001")
	ReadCharId = UUID("1001")
	WriteCharId = UUID("1002")
	FindPeripheral
End Sub

Private Sub FindPeripheral
	SetState(False)
	ProgressDialog.ShowDialog("Searching for peripheral")
	Wait For (BLE.Scan(Array(ServiceId))) Complete (Success As Boolean)
	If Success = False Then
		ProgressDialog.Hide
		Toast.Show("Failed to scan for devices: " & Py.PyLastException)
	End If
End Sub

Private Sub BLE_CharNotify (Notification As BleakNotification)
	NewMessage(Notification.Value)
End Sub

Private Sub BLE_DeviceDisconnected  (DeviceId As String)
	Toast.Show("Device disconnected")
	Rescan
End Sub

Private Sub Rescan
	SetState(False)
	ProgressDialog.Hide
	Sleep(3000)
	FindPeripheral
End Sub

Private Sub BLE_DeviceFound  (Device As BleakDevice)
	If BLE.IsScanning = False Then Return 'Events might be raised right after stopping scanning. Ignore them.
	Log("Device found: " & Device.DeviceId & ", " & Device.Name)
	BLEClient = BLE.CreateClient(Device)
	BLE.StopScan
	ProgressDialog.ShowDialog("Trying to connect: " & Device.DeviceId)
	Wait For (BLEClient.Connect) Complete (Success As Boolean)
	If Success Then
		ProgressDialog.ShowDialog("Subscribing for notifications")
		Wait For (BLEClient.SetNotify(ReadCharId)) Complete (Result As PyWrapper)
		If Result.IsSuccess Then
			SetState(True)
			txtMessage.RequestFocusAndShowKeyboard
		Else
			ShowError(Result.ErrorMessage)
			Rescan
		End If
	Else
		ShowError(Py.PyLastException)
		Rescan
	End If
End Sub

Private Sub ShowError (msg As String)
	Toast.Show("Error: [plain]" & msg & "[/plain]")
End Sub

Sub SetState (Connected As Boolean)
	btnSend.Enabled = Connected
	txtMessage.TextField.Enabled = Connected
	If Connected Then
		ProgressDialog.Hide
	End If
End Sub

Sub btnSend_Click
	If txtMessage.Text.Length = 0 Then Return
	Dim s As String = "B4J: " & txtMessage.Text
	Dim msg() As Byte = s.GetBytes("UTF8")
	NewMessage(msg)
	Wait For (BLEClient.Write(WriteCharId, msg)) Complete (Result As PyWrapper)
	If Result.IsSuccess = False Then
		ShowError(Result.ErrorMessage)
		BLEClient.Disconnect
		Rescan
		Return
	End If
	txtMessage.RequestFocusAndShowKeyboard
	txtMessage.TextField.SelectAll
End Sub

Private Sub UUID (id As String) As String
	Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"
End Sub


Public Sub NewMessage(msg() As Byte)
	txtLogs.Text = BytesToString(msg, 0, msg.Length, "utf8") & CRLF & txtLogs.Text
End Sub

Private Sub B4XPage_Background
	If BLEClient.IsInitialized Then BLEClient.Disconnect
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Private Sub txtMessage_EnterPressed
	Sleep(0)
	btnSend_Click
End Sub