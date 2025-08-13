B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Information
'Project: BLE-PyBridge Example 
'Date: 20250309
'Author: Robert W.B. Linn
'Description: The B4J application (app) connects as a client with an ESP32 running as Bluetooth Low Energy (BLE) server.
'The BLE-Server advertises DHT22 sensor data temperature & humidity and listens to commands send from connected clients.
'The communication between the B4J-Client and the BLE-Server is managed by the PyBridge with Bleak.
'The data is passed thru the PyBridge and to be handled by client or BLE server.
'Source: blepybridge.b4j, B4J 10.20 BETA #3 (64 bit)
'
'Additional Libraries: PyBridge (0.70 or higher), Bleak (1.01 or higher)
'Install Bleak Example
'Set python path under Tools: C:\Prog\B4J\Libraries\Python\python\python.exe
'Open global Python shell: ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
'From folder C:\Prog\B4J\Libraries\Python\Notebooks> run: pip install bleak

'BLE-Server Advertisements [B4R > BLE-TCP-Bridge > B4J] 
'6 bytes = 2 bytes T (int, NNNN) + 2 bytes H (int, NNNN) + 2 bytes I (int, NNNN) As Little
'Example 4A06 7719 8813 > t=1610 (064ª),h=6519 (1977), i=5000 (1388) (i = advertising interval)
'
'B4J-Client Commands [B4J > BLE-TCP-Bridge > B4R]
'Set Traffic-Light: 2 Bytes; 1=01 RED,02  YELLOW,03 GREEN; Byte 2=00 LED OFF Or 01 ON. Example 0101 set LED RED ON.
'Set Advertising Interval: Byte 1=04; Byte2=00-3C (DEC 60). Example 0414 For interval 20 s.

'Communication Flow:
'App (B4J 10.x) <--> PyBridge/Bleak (Python 3.11.x) <--> BLE-Server (B4R 4.x)
#End Region

Sub Class_Globals
	Private VERSION As String = "rBLEServer Example BLEPyBridge v20250310"
	
	Private Root As B4XView
	Private xui As XUI
	Private LabelBLEState As B4XView
	Private LabelTemperature As B4XView
	Private LabelHumidity As B4XView
	Private LabelInterval As B4XView
	Private CustomListViewLog As CustomListView
	Private ButtonConnect As B4XView
	Private ProgressBarScan As AnotherProgressBar
	Private B4XSeekBarInterval As B4XSeekBar
	Private LabelSeekBarIntervalValue As B4XView
	Private ButtonIntervalSet As B4XView
	Private CheckBoxLED As B4XView

	'PyBridge
	Private Py As PyBridge

	'BLE
	Private SERVICE_UUID As String = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
	Private CHARACTERISTIC_UUID As String = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"				'Flags read,notify,write
	Private BLE_SERVER_NAME As String = "BLEServer"												'Name set in B4R program
	Private ScanState_Init = 0, ScanState_Not_Scanning = 1, ScanState_Scanning = 2 As Int
	Private ble As Bleak																		'Bleak instance
	Private BleDevice As BleakDevice
	Private BleCLient As BleakClient															'Bleak client connected to the ble device
	Private IsConnected As Boolean = False

	'Helper
	Private bc As ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	'UI settings
	B4XPages.SetTitle(Me, VERSION)
	LabelBLEState.Text = "Disconnected"

	'PyBridge with event Py
	Py.Initialize(Me, "Py")

	'Set options: path to the python exe
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")

	'Start the bridge with options set
	Py.Start(opt)
	SetScanState(ScanState_Init)

	'Connect to the pybridge
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("[ERROR][PyBridge] Failed to start Python process.")
		Return
	End If
	'Stop scanning state
	SetScanState(ScanState_Not_Scanning)
	
	'Init BLE using Bleak and pybridge instance
	ble.Initialize(Me, "ble", Py)

	'Start ble connection
	ButtonConnect_Click
End Sub

'Close the b4xpages app. Prior closing the PyBridge is stopped.
Private Sub B4XPage_CloseRequest As ResumableSub
	LogColor($"[B4XPage_CloseRequest] starting..."$, xui.Color_Red)
	Py.KillProcess
	Sleep(100)
	LogColor($"[B4XPage_CloseRequest] done..."$, xui.Color_Red)
	Return True
End Sub

Private Sub B4XPage_Background
	'NOT USED
End Sub

#Region UI
'Connect to the BLE-Server using its service uuid.
Private Sub ButtonConnect_Click
	' Scan for devices using service uuid.
	Log($"[ButtonConnect_Click] scanning devices. serviceuuid=: ${SERVICE_UUID}"$)
	' The event ble_devicefound is raised.
	Wait For (ble.Scan(Array As String(SERVICE_UUID))) Complete (Success As Boolean)
	' Devices found
	If Success Then
		Log($"[ButtonConnect_Click] devices found."$)
		SetScanState(ScanState_Scanning)
	Else
		Log(Py.PyLastException)
	End If
End Sub

'Handle LED checkbox changes to set the RED LED state.
Private Sub CheckBoxLED_CheckedChange(Checked As Boolean)
	SetLED(Checked)
End Sub

'Set the RED LED on the ESP32 by writing 2 bytes.
'Command: 0x010x00|0x01 = 01 for the command, 00 or 01 for the LED state.
Private Sub SetLED(state As Boolean)
	Dim command() As Byte = IIf(state, Array As Byte(0x01, 0x01), Array As Byte(0x01, 0x00) )
	BLE_Write(command)
	CustomListViewLog_Insert($"[SetLED] ${DateTime.time(DateTime.now)} :: LED state changed to ${IIf(state,"ON","OFF")}"$)
End Sub

'Set the BLEServer advertising interval.
'Command: 0x040x00-0C = 04 for the command, 00-3C for the interval 0-60 s.
Private Sub ButtonIntervalSet_Click
	Dim command(2) As Byte
	command(0) = 0x04
	command(1) = IntToByte(B4XSeekBarInterval.Value)
	BLE_Write(command)
	CustomListViewLog_Insert($"[B4XSeekBarInterval_ValueChanged] value=${B4XSeekBarInterval.Value}, hex=${bc.HexFromBytes(command)}"$)
End Sub

'Change the interval. Click set to change on the BLEServer.
Private Sub B4XSeekBarInterval_ValueChanged (Value As Int)
	LabelSeekBarIntervalValue.Text = $"${Value} s."$
End Sub

'Insert logentry at first position.
Private Sub CustomListViewLog_Insert(item As String)
	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
	'CustomListViewLog.Add(CustomListViewLog_CreateItem(item), "")
End Sub

'Create logentry item.
Sub CustomListViewLog_CreateItem(item As String) As Pane
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Color = xui.Color_White
	pnl.SetLayoutAnimated(0, 0, 0, CustomListViewLog.AsView.Width, 30dip)
	Dim lbl As B4XView = XUIViewsUtils.CreateLabel
	lbl.Text = item
	lbl.SetTextAlignment("CENTER", "LEFT")
	lbl.Font = xui.CreateDefaultBoldFont(14)
	pnl.AddView(lbl, 0, 0, CustomListViewLog.AsView.Width, 30dip)
	Return pnl
End Sub
#End Region

#Region BLE
Private Sub SetScanState(State As Int)
	ProgressBarScan.Visible = State = ScanState_Scanning
End Sub

'BLE device found, check for BLE-Server.
Private Sub BLE_DeviceFound(Device As BleakDevice)
	'Do nothing if not scanning
	If ble.IsScanning = False Then Return
	'Log($"[ble_DeviceFound] ${Device.DeviceId}, Name=${Device.Name}, Services=${Device.ServiceUUIDS}, ServiceData=${Device.ServiceData}"$)

	'Check if BLE-Server found
	If Device.name.EqualsIgnoreCase(BLE_SERVER_NAME) Then
		'Assign the device found to the global bledevice
		BleDevice = Device
		Log($"[ble_DeviceFound][BleDevice] ${BleDevice.DeviceId}, Name=${BleDevice.Name}, Services=${BleDevice.ServiceUUIDS}, ServiceData=${BleDevice.ServiceData}"$)

		'Stop scan
		ble.StopScan
		SetScanState(ScanState_Not_Scanning)

		'Connect to the BLE-Server using the global bledevice
		BLE_Connect
	End If
End Sub

'Connect to the BLE-Server.
Private Sub BLE_Connect
	Dim item As String
	
	'Create a new ble client from the global bledevice
	BleCLient = ble.CreateClient(BleDevice)
	
	'Connect to the bledevice
	Log($"[BLE_Connect] connecting. deviceid=${BleDevice.DeviceId}"$)
	Wait For (BleCLient.Connect) Complete (Success As Boolean)
	If Success Then
		IsConnected = True
		item = $"[BLE_Connect] connected. deviceid=${BleDevice.DeviceId}"$
		Sleep(10)
		BLE_Notify
		LabelBLEState.Text = "Connected"
		Log(item)
	Else
		IsConnected = False
		item = $"[ERROR][BLE_Connect] ${ParseErrorMessage(Py.PyLastException)}"$
		xui.MsgboxAsync(ParseErrorMessage(Py.PyLastException), "failed to connect: " & BleDevice.DeviceId)
		LabelBLEState.Text = "Disconnected"
		LogError(item)
	End If

	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
End Sub

Private Sub BLE_DeviceDisconnected(DeviceId As String)
	'
End Sub

'Handle notification received.
Private Sub BLE_CharNotify(Notification As BleakNotification)
	Dim item As String
	'item = $"[BLE_CharNotify] value=${Notification.Value}, charuuid=${Notification.CharacteristicUUID}"$
	'CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")

	'Get the notification value arraybytes
	Dim buffer() As Byte = Notification.Value

	'Convert rawdata to data (little-endian)
	Dim temperature As Float = IntFromBytes(buffer(1),buffer(0)) / 100
	Dim humidity As Float = IntFromBytes(buffer(3),buffer(2)) / 100
	Dim interval As Short = IntFromBytes(buffer(5),buffer(4)) / 1000

	'Update UI
	LabelTemperature.Text = $"${temperature} °C"$
	LabelHumidity.Text = $"${humidity} %RH"$
	LabelInterval.Text = $"Advertising interval"$

	'Check interval changed to update the seekbar
	If interval <> B4XSeekBarInterval.Value Then
		B4XSeekBarInterval.Value = interval
		LabelSeekBarIntervalValue.Text = $"${interval} s"$
	End If

	item = $"[BLE_CharNotify] ${DateTime.time(DateTime.now)} :: ${temperature} °C, ${humidity} %RH, ${interval} s"$
	CustomListViewLog_Insert(item)
End Sub

'Read data from the ble-server using the read characteristic.
Private Sub BLE_Read
	Dim item As String
	If Not(IsConnected) Then Return

	Wait For (BleCLient.ReadChar(CHARACTERISTIC_UUID)) Complete (Result As PyWrapper)
	If Result.IsSuccess = False Then
		item = $"[ERROR][BLE_Read] ${B4XPages.MainPage.ParseErrorMessage(Result.ErrorMessage)}"$
	Else
		'Get the received data as bytearray
		Dim data() As Byte = Result.Value
		'item = BytesToString(data, 0, data.Length, "ascii")
		item = $"[BLE_Read] data=${bc.HexFromBytes(data)}"$
	End If

	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
End Sub

'NOT USED
'Private Sub NotificationEvent(n As BleakNotification)
'	Dim item As String
'	item = $"Notification=${BytesToString(n.Value, 0, n.Value.Length, "ASCII")}"$
'	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
'End Sub

'Set the ble notify flag using the notify characteristic.
Private Sub BLE_Notify
	Dim item As String
	If Not(IsConnected) Then Return

	Wait For (BleCLient.SetNotify(CHARACTERISTIC_UUID)) Complete (Result As PyWrapper)
	If Result.IsSuccess = False Then
		item = $"[ERROR][BLE_SetNotify] ${B4XPages.MainPage.ParseErrorMessage(Result.ErrorMessage)}"$
	Else
		item = "[BLE_SetNotify] OK. Waiting for data..."
	End If

	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
End Sub

'Write data to the ble-server using the write characteristic.
Private Sub BLE_Write(b() As Byte)
	Dim item As String
	If Not(IsConnected) Then Return

	'Write bytes to the characteristic
	Dim rs As Object = BleCLient.Write(CHARACTERISTIC_UUID, b)
	Wait For (rs) Complete (Result2 As PyWrapper)
	If Result2.IsSuccess = False Then
		item = $"[ERROR][BLE_Write] ${B4XPages.MainPage.ParseErrorMessage(Result2.ErrorMessage)}"$
	Else
		item = $"[BLE_Write] OK. data=${bc.HexFromBytes(b)}"$
	End If

	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
End Sub

'If device.Name <> "" Then lblName.Text = lblName.Text & $" (${device.Name})"$
'	Dim sb As StringBuilder
'	sb.Initialize
'	sb.Append($"Discovered time $Time{DateTime.Now}"$).Append(CRLF)
'	sb.Append("RSSI: ").Append(device.RSSI).Append(CRLF)
'	sb.Append(BytesMapToString(device.ManufacturerData, "Manufacturer data"))
'	sb.Append(BytesMapToString(device.ServiceData, "Service data"))
'	sb.Append("Services: ").Append(ListToString(device.ServiceUUIDS)).Append(CRLF)
'	txtOther.Text = sb.ToString

#End Region

#Region PyBridge
Private Sub Py_Disconnected
	LabelBLEState.Text = "Disconnected"
	Log("[Py_Disconnected] PyBridge disconnected")
End Sub
#End Region

#Region Helper
'Iterate over map keys and values.
Public Sub PrintMap(m As Map)
	For Each key As String In m.Keys
		Dim value As String = m.Get(key)
		Log($"key: ${key}, value: ${value}"$)
	Next
End Sub

'Convert 2 bytes to an int.
'Ensure to set endian right.
Public Sub IntFromBytes(b1 As Byte, b2 As Byte) As Int
	Dim hex As String = bc.HexFromBytes(Array As Byte(b1,b2))
	Dim result As Int = Bit.ParseInt(hex, 16)
	'Log($"[IntFromBytes] hex=${hex}, int=${result}"$)
	Return result
End Sub

'Convert int 0-255 to 1 byte.
Public Sub IntToByte(value As Int) As Byte
	If value >= 0 And value <= 255 Then
		Dim result As Byte = value
	End If
	'Log($"[IntToBytes] int=${value}, hex=${bc.HexFromBytes(Array As Byte(result))}"$)
	Return result
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

Public Sub BytesMapToString(map As Map, Title As String) As String
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
#End Region
