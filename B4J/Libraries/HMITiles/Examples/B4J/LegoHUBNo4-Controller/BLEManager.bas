B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#Region Class Header
' Class:		BLEManager
' Brief:		BLE manager to control the brick.
' Date:			2025-12-05
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	This B4J application (app) connects as a client with an ESP32 running as Bluetooth Low Energy (BLE) server.
'				The BLE-Server advertises DHT22 sensor data temperature & humidity and listens to commands send from connected clients.
'				The communication between the B4J-Client and the BLE-Server is managed by the PyBridge with Bleak.
'				The data is passed thru the PyBridge and to be handled by client or BLE server.
' DependsOn:	BLEConstants.bas
' Software: 	B4J 10.30(64 bit)
' Libraries:	PyBridge 1.00, Bleak 1.02, ByteConverter 1.10
' PyBridge:		MUST READ
'				https://www.b4x.com/android/forum/threads/pybridge-the-very-basics.165654/
'				Create a local Python runtime:
'					ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'				Open local Python shell: 
'					ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'				Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'					ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
' Bleak:		Install:
'				Set python path under Tools: 
'					C:\Prog\B4J\Libraries\Python\python\python.exe
'				Open global Python shell: 
'					ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
'				From folder C:\Prog\B4J\Libraries\Python\Notebooks> run: 
'					pip install bleak
'				Reference:
'					https://www.b4x.com/android/forum/threads/pybridge-bleak-bluetooth-ble.165982/
#End Region

Sub Class_Globals
	Public Logging As Boolean = False

	' Bleak
	Private mBle As Bleak					' Bleak Object
	Private mBleDevice As BleakDevice
	Private mBleDeviceName As String
	Private mBleMAC As String
	Private mBleCLient As BleakClient		' Bleak client connected to the ble device
	Private mBleServiceUUID As String
	Private mBleCharRXUUID As String
	Private mBleCharTXUUID As String
	Public IsConnected As Boolean = False	' Public

	
	' PyBridge
	Private PATH_TO_PYTHON As String = "Python/python/python.exe"
	' Set the path using Linux with f.e. B4JBridge
	#if linux
	Private PATH_TO_PYTHON As String = "/usr/bin/python3.12"
	#end if
	Private Py As PyBridge
	
	' MainPage
	Private mMainPage As B4XMainPage

	' Scan Timer
	Private mBleScanTimer As Timer	
	Private BLE_SCAN_TIMER_INTERVAL As Long = 1000
	Private BLE_SCAN_TIMER_TIMEOUT As Long = 10000	' Stop scanning after NN seconds
	Private mBleScanTimerCounter As Long = 0
	Private IsDeviceFound As Boolean = False
	
	' Logging as public access
	Public LastMsg As String
End Sub

#Region Initialize
' Initialize
' Initializes the object.
' Parameters
'	mainpage String - Mainpage as parent
' Returns
'	state Boolean - State
Public Sub Initialize(mainpage As B4XMainPage, mac As String, serviceuuid As String, charrxuuid As String, chartxuuid As String)
	mBleMAC = mac
	mBleServiceUUID = serviceuuid
	mBleCharRXUUID = charrxuuid
	mBleCharTXUUID = chartxuuid
	' mBleDeviceName = BLEConstants.BLE_DEVICE_NAME
	mMainPage = mainpage
	mBleScanTimer.Initialize("BleScanTimer", BLE_SCAN_TIMER_INTERVAL)
	mBleScanTimer.Enabled = False
End Sub

' Start
' Start the PyBridge and then initialize BLE
Public Sub Start As ResumableSub
	' Start the PyBridge
	Wait For (PyBridgeStart) complete (result As Boolean)
	If result Then
		' Init BLE using Bleak object and pybridge instance
		mBle.Initialize(Me, "ble", Py)
	End If
	Return result
End Sub
#End Region

#Region PyBridge
' Event triggered by pybridge disconnected from pybridge object (Py).
Private Sub Py_Disconnected
	IsConnected = False
	mMainPage.PyBridgeDisconnected
	LastMsg = $"[BLEManager.Py_Disconnected][W] PyBridge disconnected"$
	DoLog(LastMsg, False)
End Sub

Public Sub PyBridgeStart As ResumableSub
	LastMsg = ""
	
	' PyBridge with event Py, like Py_Connected, Py_Disconnected
	DoLog($"[BLEManager.PyBridgeStart] Py.Initialize..."$, False)
	Py.Initialize(Me, "Py")

	' Set options: path to the python exe
	Dim opt As PyOptions = Py.CreateOptions(PATH_TO_PYTHON)

	' Start the Python bridge with options set
	Py.Start(opt)

	' Connect to the pybridge using Py instance
	Wait For Py_Connected (Success As Boolean)
	If Not(Success) Then
		LastMsg = $"[BLEManager.PyBridgeStart][E] Failed to start Python process."$
		DoLog(LastMsg, True)
		Return False
	Else
		LastMsg = $"[BLEManager.PyBridgeStart][I] Python process started."$
		DoLog(LastMsg, False)
		Return True
	End If
End Sub

' Kills the pybridge process and closes the connection
Public Sub PyBridgeKillProcess
	Py.KillProcess
	LastMsg = $"[BLEManager.PyBridgeKillProcess][I] OK"$
	DoLog(LastMsg, False)
End Sub
#End Region

#Region BLE
Private Sub BleScanTimer_Tick
	mBleScanTimerCounter = mBleScanTimerCounter + 1
	If mBleScanTimerCounter > Round(BLE_SCAN_TIMER_TIMEOUT / BLE_SCAN_TIMER_INTERVAL) And Not(IsDeviceFound) Then
		mBle.StopScan
		mBleScanTimer.Enabled = False
		LastMsg = $"[BLEManager.BleScanTimer][E] Device ${mBleDeviceName } not found. Timeout reached."$
		DoLog(LastMsg, False)
		mMainPage.HandleBLEConnect(False)
	End If
End Sub
' Scan
' Scan for the device name given, which triggers events:
' Scan > DeviceFound > Connect
Public Sub Scan As ResumableSub
	Dim result As Boolean
	' Do nothing if already connected
	If IsConnected Then 
		result = True
		Return result
	End If
	
	' Not connected > start scanning for devices
	If Not(IsConnected) Then
		' Scan for devices using service uuid.
		DoLog($"[BLEManager.Scan][I] Scanning devices, serviceuuid=${mBleServiceUUID}"$, False)

		' Start scanning
		' Event ble_devicefound is raised.
		mBleScanTimerCounter = 0
		mBleScanTimer.Enabled = True
		IsDeviceFound = False
		Wait For (mBle.Scan(Array As String(mBleServiceUUID))) Complete (Success As Boolean)
		' Devices found
		If Success Then
			LastMsg = $"[BLEManager.Scan][I] Devices found."$
			DoLog(LastMsg, False)
			result = True
		Else
			LastMsg = $"[BLEManager.Scan][E] ${Py.PyLastException}"$
			DoLog(LastMsg, True)
			result = False
		End If
	Else
		Wait For(mBleCLient.Disconnect) Complete (Success As Boolean)
		result = Success
	End If
	Return result
End Sub

' BLE devices found, check for the BLE device name HomeKit32.
' If the BLE devicename is found > connect.
' Event triggered by ble.scan (Bleak.b4xlib).
Private Sub BLE_DeviceFound(Device As BleakDevice)
	' Do nothing if not scanning
	If mBle.IsScanning = False Then Return
	'Log($"[ble_DeviceFound] ${Device.DeviceId}, Name=${Device.Name}, Services=${Device.ServiceUUIDS}, ServiceData=${Device.ServiceData}"$)

	' Check if BLE device is found
	If Device.DeviceId.EqualsIgnoreCase(mBleMAC) Then
	'If Device.name.EqualsIgnoreCase(mBleDeviceName) Then
		IsDeviceFound = True

		'Assign the device found to the global bledevice
		mBleDevice = Device
		DoLog($"[BLEManager.BLE_DeviceFound][I] id=${mBleDevice.DeviceId}, name=${mBleDevice.Name}, services=${mBleDevice.ServiceUUIDS}, servicedata=${mBleDevice.ServiceData}"$, False)

		'Stop scan
		mBle.StopScan

		'Connect to the BLE device using the global mbledevice
		Connect
	End If
End Sub

' Connect to the BLE device as BLE client.
Public Sub Connect As ResumableSub
	'Create a new ble client from the global bledevice
	mBleCLient = mBle.CreateClient(mBleDevice)
	
	'Connect to the ble device
	Log($"[BLEManager.BLEConnect][I] Connecting to deviceid=${mBleDevice.DeviceId}"$)
	Wait For (mBleCLient.Connect) Complete (Success As Boolean)
	If Success Then
		IsConnected = True
		LastMsg = $"[BLEManager.BLEConnect] Connected"$
		DoLog(LastMsg, False)
		Sleep(10)
		SetNotify
	Else
		IsConnected = False
		LastMsg = $"[BLEManager.BLEConnect][E] ${Convert.ParseErrorMessage(Py.PyLastException)}"$
		DoLog(LastMsg, True)
	End If
	mMainPage.HandleBLEConnect(IsConnected)
	Return IsConnected
End Sub

Public Sub Disconnect As ResumableSub
	Wait For (mBleCLient.Disconnect) Complete (Success As Boolean)
	If Success Then
		IsConnected = False
		LastMsg = $"[BLEManager.Disconnect] Disconnected from deviceid=${mBleDevice.DeviceId}"$
		Sleep(10)
		SetNotify
		DoLog(LastMsg, False)
	Else
		IsConnected = True
		LastMsg = $"[BLEManager.Disconnect][E] ${Convert.ParseErrorMessage(Py.PyLastException)}"$
		DoLog(LastMsg, True)
	End If
	Return Success
End Sub

' Event triggered by ble (Bleak.b4xlib).
Private Sub BLE_DeviceDisconnected(DeviceId As String)
	IsConnected = False
	mMainPage.PyBridgeDisconnected
	LastMsg = $"[BLEManager.BLE_DeviceDisconnected][I] Device disconnected"$
	DoLog(LastMsg, False)
End Sub

' Handle notification received.
' Event triggered by ble (Bleak.b4xlib).
Private Sub BLE_CharNotify(Notification As BleakNotification)
	' Log($"[BLEManager.BLE_CharNotify][I] Charuuid=${Notification.CharacteristicUUID}"$)
	mMainPage.HandleBLENotification(Notification.value)
End Sub

'Read data from the ble-server using the read characteristic.
Public Sub Read
	If Not(IsConnected) Then Return

	Wait For (mBleCLient.ReadChar(mBleCharRXUUID)) Complete (Result As PyWrapper)
	If Not(Result.IsSuccess) Then
		LastMsg = $"[BLEManager.Read][E] ${Convert.ParseErrorMessage(Result.ErrorMessage)}"$
		DoLog(LastMsg, True)
	Else
		'Get the received data as bytearray
		Dim data() As Byte = Result.Value
		'item = BytesToString(data, 0, data.Length, "ascii")
		LastMsg = $"[BLEManager.Read][I] data=${Convert.ByteConv.HexFromBytes(data)}"$
		DoLog(LastMsg, False)
	End If
End Sub

'NOT USED
'Private Sub NotificationEvent(n As BleakNotification)
'	Dim item As String
'	item = $"Notification=${BytesToString(n.Value, 0, n.Value.Length, "ASCII")}"$
'	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
'End Sub

'Set the ble notify flag using the notify characteristic.
Public Sub SetNotify
	If Not(IsConnected) Then Return

	Wait For (mBleCLient.SetNotify(mBleCharRXUUID)) Complete (Result As PyWrapper)
	If Not(Result.IsSuccess) Then
		LastMsg = $"[BLEManager.SetNotify][E] ${Convert.ParseErrorMessage(Result.ErrorMessage)}"$
		DoLog(LastMsg, True)
	Else
		LastMsg = $"[BLEManager.SetNotify][I] OK. Waiting for data..."$
		DoLog(LastMsg, False)
	End If
End Sub

' Write
' Write data to the ble device using the write characteristic.
' Parameters:
'	b Byte Array - Data to write to the BLE device.
Public Sub Write(b() As Byte)
	If Not(IsConnected) Then Return

	DoLog($"[BLEManager.Write] data=${Convert.ByteConv.HexFromBytes(b)}"$, False)

	'Write bytes to the characteristic
	Dim rs As Object = mBleCLient.Write(mBleCharTXUUID, b)
	Wait For (rs) Complete (Result2 As PyWrapper)
	If Not(Result2.IsSuccess) Then
		LastMsg = $"[BLEManager.Write][E] ${Convert.ParseErrorMessage(Result2.ErrorMessage)}"$
		DoLog(LastMsg, True)
	Else
		LastMsg = $"[BLEManager.Write][I] OK, data=${Convert.ByteConv.HexFromBytes(b)}"$
		DoLog(LastMsg, False)
	End If
	Sleep(1)
End Sub

' WriteData
' Write data to the ble device using the write characteristic.
' This sub is to align with B4A BLE manager.
' Parameters:
'	serviceuuid String - NOT USED
'	characteristicuuid - NOT USED
'	b Byte Array - Data to write to the BLE device.
' Example:
'	BLEMgr.WriteData(BLEConstants.SERVICE_UUID, _
'					 BLEConstants.CHAR_UUID_TX, _
'					 command)
Public Sub WriteData(serviceuuid As String, _
					 characteristicuuid As String, _
					 b() As Byte)

	#if B4A
	' UUID must be in lowercase
	BLEMgr.WriteData(BLEConstants.SERVICE_UUID.ToLowerCase, _
					 BLEConstants.CHAR_UUID_TX.ToLowerCase, _
					 command)
	#End If

	#if B4J
	Write(b)
	#end if
End Sub
#End Region

Private Sub DoLog(text As String, error As Boolean)
	If error Then
		LogError(text)
	End If
	If Logging And Not(error) Then
		Log(text)
	End If
End Sub
