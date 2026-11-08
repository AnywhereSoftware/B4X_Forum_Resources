B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' ================================================================
' File:			BLEClientPy
' Brief:		A dedicated BLE Client bound to a known MAC + service + RX/TX characteristics.
'				Included in the BleCentralPy.b4xlib.
' Date:			2026-02-01
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	BleCentralPy is a B4J BLE Central implementation built on Python Bleak using the B4J PyBridge.
'				- Single-device BLE client
'				- Known MAC address
'				- Self-managed Scan > Connect flow
'				- Enables BLE scanning and GATT access on desktop platforms.
'				- Scans only to find that device, Automatically connects when found.
'				This B4J application (app) connects As a client with an ESP32 running As Bluetooth Low Energy (BLE) server.
'				The communication between the B4J-Client and the BLE-Server is managed by the PyBridge with Bleak.
'				The data is passed thru the PyBridge and to be handled by client or BLE server.
'
' Events:		PyBridge
'				EventName_PyBridgeStarted
'				EventName_PyBridgeStartFailed
'				EventName_PyDisconnected
'				BLE
'				EventName_Connected
'				EventName_Disconnected
'				EventName_ConnectionFailed
'				EventName_DeviceNotFound
'				EventName_CharNotify(payload() As Byte)
'				PyBridge & BLE
'				EventName_Error
'
' Notes:		Log message:
''					java.net.SocketException: Connection reset
'					AsyncStreams$AIN.readNumberOfBytes
'				Happens when: ESP32 drops connection, Bleak closes socket, Java side still blocking on Read > ignore this message
'
' Software: 	B4J 10.30 (64 bit), JDK 19
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
' ================================================================

Private Sub Class_Globals
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
	#if rpi
	Private PATH_TO_PYTHON As String = "/home/USERNAME/bleak-env/bin/python"
	#end if
	Private Py As PyBridge

	' Scan Timer
	Private mBleScanTimer As Timer	
	Private BLE_SCAN_TIMER_INTERVAL As Long	= 1000
	Private BLE_SCAN_TIMER_TIMEOUT As Long	= 10000			' Stop scanning after NN seconds
	Private mBleScanTimerCounter As Long	= 0
	Private IsDeviceFound As Boolean 		= False

	' Logging as public access
	Public LastMsg As String
	
	' Class locals
	Private mCallback  As Object
	Private mEventName As String
	Private mByteConv As ByteConverter
End Sub

' ================================================================
' Initialize
' ================================================================
#Region Initialize
' Initialize
' Initializes the object.
' Parameters
'	Target 
'	EventName 
'	mac
'	serviceuuid
'	charrxuuid
'	chartxuuid
' Returns
'	state Boolean - State
Public Sub Initialize(Target As Object, EventName As String, mac As String, serviceuuid As String, charrxuuid As String, chartxuuid As String)
	mCallback = Target
	mEventName = EventName
	mBleMAC = mac
	mBleServiceUUID = serviceuuid
	mBleCharRXUUID = charrxuuid
	mBleCharTXUUID = chartxuuid
	' mBleDeviceName = BLEConstants.BLE_DEVICE_NAME
	
	mBleScanTimer.Initialize("BleScanTimer", BLE_SCAN_TIMER_INTERVAL)
	mBleScanTimer.Enabled = False

	Log($"[BleClientPy.Initialize][I] MAC=${mac}, UUID service=${serviceuuid}, rx=${charrxuuid}, tx=${chartxuuid}"$)
End Sub

' Start
' Start the PyBridge and then initialize BLE instance
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

' ================================================================
' PyBridge
' ================================================================
#Region PyBridge
' Start the PyBridge
Public Sub PyBridgeStart As ResumableSub
	LastMsg = ""
	
	' PyBridge with event Py, like Py_Connected, Py_Disconnected
	Log($"[BleClientPy.PyBridgeStart][I] Initialize..."$)
	Py.Initialize(Me, "Py")

	' Set options: path to the python exe
	Dim opt As PyOptions = Py.CreateOptions(PATH_TO_PYTHON)

	' Start the Python bridge with options set
	Py.Start(opt)

	' Connect to the pybridge using Py instance
	Wait For Py_Connected (Success As Boolean)
	If Success Then
		LastMsg = $"[BleClientPy.PyBridgeStart][I] Python process started."$
		CallSubDelayed(mCallback, mEventName & "_PyBridgeStarted")
		Return True
	Else
		LastMsg = $"[BleClientPy.PyBridgeStart][E] Failed to start Python process."$
		CallSubDelayed(mCallback, mEventName & "_PyBridgeStartFailed")
		Return False
	End If
End Sub

' Event triggered by pybridge disconnected from pybridge object (Py).
Private Sub Py_Disconnected
	IsConnected = False
	LastMsg = $"[BleClientPy.Py_Disconnected][W] PyBridge disconnected"$
	CallSubDelayed(mCallback, mEventName & "_PyDisconnected")
End Sub

' Kills the pybridge process and closes the connection
Public Sub PyBridgeKillProcess
	Py.KillProcess
	LastMsg = $"[BleClientPy.PyBridgeKillProcess][I] OK"$
	' Optional
	' CallSubDelayed(mCallback, mEventName & "_PyBridgeKillProcess")
End Sub
#End Region

' ================================================================
' BLE
' ================================================================
#Region BLE
Private Sub BleScanTimer_Tick
	mBleScanTimerCounter = mBleScanTimerCounter + 1
	If mBleScanTimerCounter > Round(BLE_SCAN_TIMER_TIMEOUT / BLE_SCAN_TIMER_INTERVAL) And Not(IsDeviceFound) Then
		mBle.StopScan
		mBleScanTimer.Enabled = False
		LastMsg = $"[BleClientPy.BleScanTimer][E] Device Not found (MAC=${mBleMAC}, Name=${mBleDeviceName}). Timeout reached."$
		CallSubDelayed(mCallback, mEventName & "_DeviceNotFound")
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
		Log($"[BleClientPy.Scan][I] Scanning devices, serviceuuid=${mBleServiceUUID}"$)

		' Start scanning
		' Event ble_devicefound is raised.
		mBleScanTimerCounter = 0
		mBleScanTimer.Enabled = True
		IsDeviceFound = False
		Wait For (mBle.Scan(null)) Complete (Success As Boolean)
		' Wait For (mBle.Scan(Array As String(mBleServiceUUID))) Complete (Success As Boolean)
		' Devices found
		If Success Then
			LastMsg = $"[BleClientPy.Scan][I] Devices found."$
			result = True
		Else
			LastMsg = $"[BleClientPy.Scan][E] ${Py.PyLastException}"$
			CallSubDelayed(mCallback, mEventName & "_Error")
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
	Log($"[BleClientPy.BLE_DeviceFound][I] Mac=${Device.DeviceId} (${mBleMAC}), Name=${Device.Name}, Services=${Device.ServiceUUIDS}, ServiceData=${Device.ServiceData}"$)

	' Check if BLE device is found
	' Changed from Device.DeviceId.EqualsIgnoreCase(mBleMAC) / Device.name.EqualsIgnoreCase(mBleDeviceName)
	If _
    (mBleMAC <> "" And Device.DeviceId.EqualsIgnoreCase(mBleMAC)) Or _
    (mBleDeviceName <> "" And Device.Name.EqualsIgnoreCase(mBleDeviceName)) Then
		IsDeviceFound = True

		'Assign the device found to the global bledevice
		mBleDevice = Device
		Log($"[BleClientPy.BLE_DeviceFound][I] id=${mBleDevice.DeviceId}, name=${mBleDevice.Name}, services=${mBleDevice.ServiceUUIDS}, servicedata=${mBleDevice.ServiceData}"$)

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
	' Log($"[BleClientPy.BLEConnect][I] Connecting to deviceid=${mBleDevice.DeviceId}"$)
	Wait For (mBleCLient.Connect) Complete (Success As Boolean)
	If Success Then
		IsConnected = True
		Sleep(10)
		SetNotify
		LastMsg = $"[BleClientPy.Connect][I] OK"$
		CallSubDelayed(mCallback, mEventName & "_Connected")
	Else
		IsConnected = False
		LastMsg = $"[BleClientPy.Connect][E] ${ParseErrorMessage(Py.PyLastException)}"$
		CallSubDelayed(mCallback, mEventName & "_ConnectionFailed")
	End If
	Return IsConnected
End Sub

Public Sub Disconnect As ResumableSub
	' Guard: nothing to disconnect
	If mBleCLient = Null Or Not(mBleCLient.IsInitialized) Then
		IsConnected = False
		LastMsg = "[BleClientPy.Disconnect][I] Skipped: Client not initialized"
		Return True
	End If

	' Guard: already disconnected
	If IsConnected = False Then
		LastMsg = "[BleClientPy.Disconnect][I] Already disconnected"
		Return True
	End If

	Try
		Wait For (mBleCLient.Disconnect) Complete (Success As Boolean)
		If Success Then
			IsConnected = False
			LastMsg = $"[BleClientPy.Disconnect][I] OK ${mBleDevice.DeviceId}"$
		Else
			LastMsg = $"[BleClientPy.Disconnect][E] ${ParseErrorMessage(Py.PyLastException)}"$
		End If
	Catch
		' Covers socket reset during app shutdown
		IsConnected = False
		LastMsg = "[BleClientPy.Disconnect][W] Forced disconnect during shutdown"
	End Try
	
	' No need to trigger an event because handled by BLE_DeviceDisconnected
	' CallSubDelayed(mCallback, mEventName & "_Disconnected")
	Return True
End Sub

' Event triggered by ble (Bleak.b4xlib).
Private Sub BLE_DeviceDisconnected(DeviceId As String)
	' Ignore stale callbacks
	If IsConnected = False Then Return

	IsConnected = False
	LastMsg = $"[BleClientPy.BLE_DeviceDisconnected][I] ${DeviceId}"$

	CallSubDelayed(mCallback, mEventName & "_Disconnected")
End Sub

' Handle notification received.
' Event triggered by ble (Bleak.b4xlib).
Private Sub BLE_CharNotify(Notification As BleakNotification)
	' Log($"[BleClientPy.BLE_CharNotify][I] Charuuid=${Notification.CharacteristicUUID}"$)
	CallSubDelayed2(mCallback, mEventName & "_CharNotify", Notification.value)
End Sub

'Read data from the ble-server using the read characteristic.
Public Sub Read
	If Not(IsConnected) Then Return

	Wait For (mBleCLient.ReadChar(mBleCharRXUUID)) Complete (Result As PyWrapper)
	If Result.IsSuccess Then
		'Get the received data as bytearray
		Dim data() As Byte = Result.Value
		'item = BytesToString(data, 0, data.Length, "ascii")
		LastMsg = $"[BleClientPy.Read][I] data=${mByteConv.HexFromBytes(data)}"$
	Else
		LastMsg = $"[BleClientPy.Read][E] ${ParseErrorMessage(Result.ErrorMessage)}"$
		CallSubDelayed(mCallback, mEventName & "_Error")
	End If
End Sub

' Set the ble notify flag using the notify characteristic.
Public Sub SetNotify
	If Not(IsConnected) Or mBleCLient = Null Then Return

	Wait For (mBleCLient.SetNotify(mBleCharRXUUID)) Complete (Result As PyWrapper)
	If Not(Result.IsSuccess) Then
		LastMsg = $"[BleClientPy.SetNotify][E] ${ParseErrorMessage(Result.ErrorMessage)}"$
		CallSubDelayed(mCallback, mEventName & "_Error")
	Else
		LastMsg = $"[BleClientPy.SetNotify][I] OK. Waiting for data..."$
	End If
End Sub

' Write
' Write data to the ble device using the write characteristic.
' Parameters:
'	b Byte Array - Data to write to the BLE device.
Public Sub Write(b() As Byte)
	If Not(IsConnected) Then Return

	' Log($"[BleClientPy.Write] data=${mByteConv.HexFromBytes(b)}"$)
	'Write bytes to the characteristic
	Dim rs As Object = mBleCLient.Write(mBleCharTXUUID, b)
	Wait For (rs) Complete (Result2 As PyWrapper)
	If Result2.IsSuccess Then
		LastMsg = $"[BleClientPy.Write][I] OK, data=${mByteConv.HexFromBytes(b)}"$
	Else
		LastMsg = $"[BleClientPy.Write][E] ${ParseErrorMessage(Result2.ErrorMessage)}"$
		CallSubDelayed(mCallback, mEventName & "_Error")
	End If
	Sleep(1)
End Sub
#End Region

' =================================================================
' Helpers
' =================================================================
#Region Helpers
' ------------------------------------------------------------
' ParseErrorMessage
'
' Extracts a clean error message from a standardized exception line.
' Expected input format example:
'   "(TimeoutError) - Method: BLE.PyBridge: Something went wrong"
' Parameters:
'	Raw String - Raw message
' Returns:
'   String - Extracted readable message
' ------------------------------------------------------------
Public Sub ParseErrorMessage(Raw As String) As String
	Dim m As Matcher = Regex.Matcher("\(([^)]+)\) - Method: [^.]+\.[^:]+:(.*)$", Raw)
	If m.Find Then
		Dim msg As String = m.Group(1)
		If m.Group(2).Trim <> "" Then msg = msg & " - " & m.Group(2)
		Return msg
	End If
	Return Raw
End Sub
#End Region

