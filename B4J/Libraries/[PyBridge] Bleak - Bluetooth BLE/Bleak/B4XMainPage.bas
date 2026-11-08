B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BleakExample.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

'dependencies: pip install bleak
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private ble As Bleak
	Private ScanProgress As AnotherProgressBar
	Private lstDevices As CustomListView
	Private btnScan As B4XView
	Private btnStopScan As B4XView
	Private ScanState_Init = 0, ScanState_Not_Scanning = 1, ScanState_Scanning = 2 As Int
	Private AddressesToPanels As Map = CreateMap()
	Private AddressesToDevices As Map = CreateMap()
	Public ddd1 As DDD
	Private Clients As List
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	ddd1.Initialize
	xui.RegisterDesignerClass(ddd1)
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	SetScanState(ScanState_Init)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	SetScanState(ScanState_Not_Scanning)
	ble.Initialize(Me, "ble", Py)
	Clients.Initialize
End Sub

Private Sub ble_DeviceFound  (Device As BleakDevice)
	'Log($"${Device.DeviceId}, Name=${Device.Name}, Services=${Device.ServiceUUIDS}, ServiceData=${Device.ServiceData}"$)
	If AddressesToPanels.ContainsKey(Device.DeviceId) = False Then
		Dim pnl As B4XView = xui.CreatePanel("")
		pnl.SetLayoutAnimated(0, 0, 0, lstDevices.AsView.Width, 205dip)
		pnl.LoadLayout("DeviceListItem")
		ddd1.GetViewByName(pnl, "btnConnect").Tag = Device.DeviceId
		lstDevices.Add(pnl, "")
		AddressesToPanels.Put(Device.DeviceId, pnl)
		Log($"adding ${Device.DeviceId}"$)
	End If
	AddressesToDevices.Put(Device.DeviceId, Device)
	UpdatePanel(AddressesToPanels.Get(Device.DeviceId), Device)
End Sub

Private Sub BytesMapToString(map As Map, Title As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	If map.Size > 0 Then
		sb.Append(Title).Append(CRLF)
		For Each key As Object In map.Keys
			Dim b() As Byte = map.Get(key)
			sb.Append($"${key}: ${BytesToString(b, 0, b.Length, "ASCII")}"$).Append(CRLF)
		Next
	End If
	Return sb.ToString
End Sub

Private Sub UpdatePanel(pnl As B4XView, device As BleakDevice)
	Dim lblName As B4XView = ddd1.GetViewByName(pnl, "lblName")
	Dim txtOther As B4XView = ddd1.GetViewByName(pnl, "txtOther")
	lblName.Text = device.DeviceId
	If device.Name <> "" Then lblName.Text = lblName.Text & $" (${device.Name})"$
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"Discovered time $Time{DateTime.Now}"$).Append(CRLF)
	sb.Append("RSSI: ").Append(device.RSSI).Append(CRLF)
	sb.Append(BytesMapToString(device.ManufacturerData, "Manufacturer data"))
	sb.Append(BytesMapToString(device.ServiceData, "Service data"))
	sb.Append("Services: ").Append(ListToString(device.ServiceUUIDS)).Append(CRLF)
	txtOther.Text = sb.ToString
End Sub

Private Sub SetScanState(State As Int)
	ScanProgress.Visible = State = ScanState_Scanning
	btnStopScan.Enabled = State = ScanState_Scanning
	btnScan.Enabled = State = ScanState_Not_Scanning
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Private Sub btnStopScan_Click
	ble.StopScan
	SetScanState(ScanState_Not_Scanning)
End Sub

Private Sub btnScan_Click
	AddressesToDevices.Clear
	AddressesToPanels.Clear
	lstDevices.Clear
	Wait For (ble.Scan(Null)) Complete (Success As Boolean)
	If Success Then
		Log("scanning for device")
		SetScanState(ScanState_Scanning)
	Else
		Log(Py.PyLastException)
	End If
End Sub

Private Sub btnConnect_Click
	Dim btn As B4XView = Sender.As(B4XView)
	Dim DeviceId As String = btn.Tag
	Dim pnl As B4XView = AddressesToPanels.Get(DeviceId)
	Dim AnotherProgressBar1 As AnotherProgressBar = ddd1.GetViewByName(pnl, "AnotherProgressBar1").Tag
	AnotherProgressBar1.Visible = True
	Dim client As BleakClient = ble.CreateClient(AddressesToDevices.Get(DeviceId))
	Log("Connecting to: " & DeviceId)
	Wait For (client.Connect) Complete (Success As Boolean)
	AnotherProgressBar1.Visible = False
	If Success Then
		Log("connected!")
		Dim cp As ClientPage
		cp.Initialize(client)
		Clients.Add(cp)
	Else
		Log(Py.PyLastException)
		xui.MsgboxAsync(ParseErrorMessage(Py.PyLastException), "failed to connect: " & DeviceId)
	End If
End Sub

Private Sub BLE_DeviceDisconnected  (DeviceId As String)
	For Each cp As ClientPage In Clients
		If cp.mClient.mDevice.DeviceId = DeviceId Then
			cp.SetState(False)
		End If
	Next
End Sub

Private Sub BLE_CharNotify (Notification As BleakNotification)
	For Each cp As ClientPage In Clients
		If cp.mClient.mDevice.DeviceId = Notification.ClientUUID Then
			cp.NotificationEvent(Notification)
		End If
	Next
End Sub

Public Sub PageClosed (cp As ClientPage)
	Clients.RemoveAt(Clients.IndexOf(cp))
End Sub

Public Sub ParseErrorMessage(Raw As String) As String
	Dim m As Matcher = Regex.Matcher("\(([^)]+)\) - Method: [^.]+\.[^:]+:(.*)$", Raw)
	Dim msg As String = Raw
	If m.Find Then
		msg = m.Group(1)
		If m.Group(2).Trim <> "" Then
			msg = msg & " - " & m.Group(2)
		End If
	End If
	Return msg
End Sub

Public Sub ListToString (props As List) As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each p As String In props
		sb.Append(p).Append(", ")
	Next
	If sb.Length > 0 Then sb.Remove(sb.Length - 2, sb.Length)
	Return sb.ToString
End Sub
