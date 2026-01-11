B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Header
' File:			BuWizz2Controller
' Brief:		B4X, B4J Client controlling a BuWizz2 Brick via BLE using HMI tiles.
' Date:			2026-01-05
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	This B4X Application (B4A, B4J) connects As a BLE Central (GATT Client)
'				To an ESP32 running B4R firmware acting As a BLE Peripheral (GATT Server).
'    			The ESP32 BLE Peripheral advertises DHT22 temperature And humidity data
'    			and listens For commands written by connected BLE Centrals.
'
'    			In the B4J VERSION, BLE communication Is performed through a PyBridge
'    			process that uses the Bleak library. The PyBridge handles BLE operations
'    			and forwards data between the B4J client And the ESP32 BLE Peripheral.
'
'				ESP32 = BLE Peripheral + GATT Server
'				B4A/B4J = BLE Central + GATT Client
'
' Hardware:		B4A:
'				- Acer A11, 11-inch (27.9 cm) display, 1920 x 1200 px, Android 14
'				- Galaxy A13, 6.5-inch display, 1080 x 2408 px, Android 14, One UI 6.1
'				B4J:
'				- Acer NITRO 5, 15,6-inch (39.6 cm), 1920 x 1080 px, Windows 11
'				- Acer V3-771G, 17.6-inch (44.7 cm), 1600 x 900 px, Ubuntu
' Software: 	B4A 13.40 (64 bit), B4J 10.30 (64 bit), Java JDK 19
' Libraries:	B4A: BLE2 1.41, B4XPages 1.12
'				B4J: PyBridge 1.00, Bleak 1.02, ByteConverter 1.10, HMITiles 1.40
'				Min versions to include.
' Bleak:		Install:
'				Set python path under Tools: C:\Prog\B4J\Libraries\Python\python\python.exe
'				Open global Python shell: ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
'				From folder C:\Prog\B4J\Libraries\Python\Notebooks> run: pip install bleak
'				https://www.b4x.com/android/forum/threads/pybridge-bleak-bluetooth-ble.165982/
' Notes:		Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'				Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'				Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'				Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'				ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Private Sub Class_Globals
	Private Const VERSION As String = "BuWizz2Controller v20260105"
	Private ABOUT As String 	= $"${VERSION} (c) 2025-2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private Root As B4XView
	Private xui As XUI
	
	' Tiles
	Private TileButtonConnect As HMITileButton
	Private TileEventViewer As HMITileEventViewer
	Private TileSeekBarSpeed As HMITileSeekBar
	Private TileReadoutSpeed As HMITileReadout
	Private TileSelectDirection As HMITileSelect
	Private LabelAbout As Label

	' BLE
	#if B4A
	Public BLEMgr As BleManager2
	' Scan Timer
	Private BLEScanTimer As Timer
	Private BLE_SCAN_TIMER_INTERVAL As Long = 1000
	Private BLE_SCAN_TIMER_TIMEOUT As Long = 10000	' Stop scanning after NN seconds
	Private BLEScanTimerCounter As Long = 0
	Private IsDeviceFound As Boolean = False
	Private rp As RuntimePermissions
	#end if
	#if B4J
	Public BLEMgr As BLEManager
	#End If
	Private IsConnected As Boolean = False

	' BuWizz2
	Private BuWizz As BuWizz2Controller
	Private Port As Byte = 0
End Sub

#Region B4XPages
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	' Load layout case sensitive
	Root.LoadLayout("MainPage")

	' UI
	' UI  additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	#if B4A
	B4XPages.SetTitle(Me, $"${VERSION} (B4A)"$)
	#End If
	#if B4J
	B4XPages.SetTitle(Me, $"${VERSION} (B4J)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	#End If
	LabelAbout.Text = ABOUT

	' CustomView require short sleep
	Sleep(1)
	' Add customviews
	SetTilesInitialState
	
	' Add info to the event log
	TileEventViewer.Insert($"[B4XPage_Created] ${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewer.Insert($"[B4XPage_Created] BLE disconnected"$, HMITileUtils.EVENT_LEVEL_WARNING)

	' Init BuWizz2Controller
	BuWizz.Initialize(B4XPages.GetPage("Mainpage"))

	' Init scan timer - enabled false, is set to true after BLE connected
	#if B4A
	BLEScanTimer.Initialize("BleScanTimer", BLE_SCAN_TIMER_INTERVAL)
	BLEScanTimer.Enabled = False
	#end if

	' BLE B4A & B4J
	' BLE Manager Initialize	
	#if B4A
	' BLE init object with event statechanged
	BLEMgr.Initialize("BLEMgr")
	#End If

	#if B4J
	' BLE init object
	BLEMgr.Initialize(B4XPages.GetPage("MainPage"), _ 
					  BuWizz.BLE_MAC, _ 
					  BuWizz.SERVICE_UUID, _ 
					  BuWizz.CHAR_UUID_RX, _ 
					  BuWizz.CHAR_UUID_TX)
	Wait For (BLEMgr.Start) complete (result As Boolean)
	If result Then
		TileEventViewer.Insert($"[B4XPage_Created] PyBridge started, BLE initialized"$, HMITileUtils.EVENT_LEVEL_INFO)
	Else
		TileEventViewer.Insert($"[B4XPage_Created] Failed to start the PyBridge initialize BLE"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
	#End If

End Sub

Private Sub B4XPage_Background
	#if B4A
	BLEMgr.Disconnect
	#End If
	#if B4J
	BLEMgr.PyBridgeKillProcess
	#End If
End Sub

' These subs are triggered by the BLEMgr pybridge events
#if B4J
Public Sub PyBridgeDisconnected
	IsConnected = False
	TileEventViewer.Insert($"[PyBridgeDisconnected] ${"Disconnected"}"$, HMITileUtils.EVENT_LEVEL_WARNING)
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
End Sub
#End If

' ================================================================
' B4A BLE MANAGER
' ================================================================
#Region B4A-BLE-Manager
#if B4A
' BLEScanTimer_Tick
' Runs every second when scan is started.
' If no device found, timer stops and event is logged.
Private Sub BLEScanTimer_Tick
	BLEScanTimerCounter = BLEScanTimerCounter + 1
	If BLEScanTimerCounter > Round(BLE_SCAN_TIMER_TIMEOUT / BLE_SCAN_TIMER_INTERVAL) And Not(IsDeviceFound) Then
		BLEMgr.StopScan
		BLEScanTimer.Enabled = False
		TileEventViewer.Insert($"[BLEScanTimer_Tick] Device ${BuWizz.BLE_DEVICE_NAME } not found. Timeout reached."$, HMITileUtils.EVENT_LEVEL_ALARM)
		Log($"[BLEScanTimer_Tick][E] Device ${BuWizz.BLE_DEVICE_NAME } not found. Timeout reached."$)
		TileButtonConnectUpdate(IsConnected)
	End If
End Sub

Public Sub Connect
	' Ensure to add permission to manifest ACCESS_FINE_LOCATION, BLUETOOTH_SCAN, BLUETOOTH_CONNECT)
	Dim Permissions As List
	Dim phone As Phone

	If phone.SdkVersion >= 31 Then
		Permissions = Array("android.permission.BLUETOOTH_SCAN", "android.permission.BLUETOOTH_CONNECT", rp.PERMISSION_ACCESS_FINE_LOCATION)
	Else
		Permissions = Array(rp.PERMISSION_ACCESS_FINE_LOCATION)
	End If
	For Each per As String In Permissions
		rp.CheckAndRequest(per)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			ToastMessageShow("No permission: " & Permission, True)
			Return
		End If
	Next

	' Check if BLE is powered on
	If BLEMgr.State <> BLEMgr.STATE_POWERED_ON Then
		TileEventViewer.Insert("[Connect] Scan failed, BLE not powered on.", HMITileUtils.EVENT_LEVEL_ALARM)
		Log($"[Connect][E] BLE not powered on."$)
	Else
		TileEventViewer.Insert("[Connect] Scan started...", HMITileUtils.EVENT_LEVEL_INFO)
		' Start scanning for devices > raised event Manager_DeviceFound
		BLEMgr.Scan2(Array As String(BuWizz.SERVICE_UUID), False)
	End If
End Sub

Public Sub Disconnect
	If IsConnected Then
		BLEMgr.Disconnect
		BLEScanTimer.Enabled = False
	End If
End Sub

' BLEMgr_DeviceFound
' Event triggered by manager.scan/scan2.
Private Sub BLEMgr_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)
'	TileEventViewer.Insert($"[Manager_DeviceFound] Name ${Name}, ID ${Id}"$, HMITileUtils.EVENT_LEVEL_INFO)
	Log($"[BLEMgr_DeviceFound][I] name=${Name}, id=${Id}, rssi=${RSSI}, advertisingdata=${AdvertisingData}"$)
	
'	If Name == BLEConstants.BLE_DEVICE_NAME Then
	If Id = BuWizz.BLE_MAC Then
		BLEMgr.StopScan
		TileEventViewer.Insert($"[Manager_DeviceFound] Connecting to ${Name}, ID ${Id}"$, HMITileUtils.EVENT_LEVEL_INFO)
		Log($"[Manager_DeviceFound][I] connecting to ${Name}"$)
		IsDeviceFound = True
		BLEScanTimer.Enabled = False
		' Disabling auto connect can make the connection quicker
		BLEMgr.Connect2(Id, False)
	End If
End Sub

' BLEMgr_Connected
' Event triggered by BLEMgr.connect/connect2.
Private Sub BLEMgr_Connected (services As List)
	Log($"[BLEMgr_Connected] services=${services}"$)
	IsConnected = True

	' Set notify flag. Note UUIDs must be lowercase
	BLEMgr.SetNotify(BuWizz.SERVICE_UUID.ToLowerCase, BuWizz.CHAR_UUID_RX.ToLowerCase, True)
	Sleep(10)
	
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert($"[BLEMgr_Connected] OK"$, HMITileUtils.EVENT_LEVEL_INFO)
	Log($"[BLEMgr_Connected] OK"$)
End Sub

Private Sub BLEMgr_Disconnected
	If Not(IsConnected) Then Return
	IsConnected = False
	SetTilesInitialState
	TileEventViewer.Insert($"[BLEMgr_Disconnected] OK"$, HMITileUtils.EVENT_LEVEL_WARNING)
	Log($"[BLEMgr_Disconnected] OK"$)
End Sub

' BLEMgr_DataAvailable
' Received data from the service.
Private Sub BLEMgr_DataAvailable (ServiceId As String, Characteristics As Map)
'	Log($"[BLEMgr_DataAvailable] serviceid=${ServiceId}, characteristics=${Characteristics}"$)
'	For Each id As String In Characteristics.Keys
'		' The CHAR_UUID_RX is used to read the data (byte array)
'		' [BLEMgr_DataAvailable] serviceid=6e400001-b5a3-f393-e0a9-e50e24dcca9e, characteristics={6e400003-b5a3-f393-e0a9-e50e24dcca9e=[B@54eaf38}
'		If id == BLEConstants.CHAR_UUID_RX.tolowercase Then
'			Dim data() As Byte = Characteristics.Get(id)
'			TileEventViewer.Insert($"[Manager_DataAvailable] data=${Convert.HexFromBytes(data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
'
'			Log($"[BLEMgr_DataAvailable] data=${Convert.HexFromBytes(data)}"$)
'			' [BLEMgr_DataAvailable] data=0904123F
'			' Example data for device id=09 (DHT11), command 04 (GET_VALUE), data=123F=temperature HEX 12 (DEC 18), humidity HEX 3F (DEC 63)
'			' [BLEMgr_DataAvailable] data=0D0201
'			' Example data for device id=0D (PIR SENSOR), command 02 (GET_STATE), data=01 (detected)
'
'			' Process BLE data
'			ProcessBLE(data)
'		End If		
'	Next
End Sub

Private Sub BLEMgr_StateChanged (State As Int)
	Dim statetext As String
	Select State
		Case BLEMgr.STATE_POWERED_OFF
			statetext = "POWERED OFF"
		Case BLEMgr.STATE_POWERED_ON
			statetext = "POWERED ON"
		Case BLEMgr.STATE_UNSUPPORTED
			statetext = "UNSUPPORTED"
	End Select
	TileEventViewer.Insert($"[Manager_StateChanged] ${statetext}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Public Sub Write(data() As Byte)
	BLEMgr.WriteData(BuWizz.SERVICE_UUID, BuWizz.CHAR_UUID_TX, data)
End Sub
#End If
#End Region

' ================================================================
' B4J BLE MANAGER
' ================================================================
#Region B4J-BLE-MANAGER
' HandleBLEConnect
' Set the connect button state.
' Parameters:
'	state Boolean - True connected else disconnected
Public Sub HandleBLEConnect(state As Boolean)
	If state Then
		TileEventViewer.Insert($"[HandleBLEConnect] ${"Connected"} to ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
	Else
		TileEventViewer.Insert($"[HandleBLEConnect] ${"Disconnected"} from ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
	IsConnected = state
	TileButtonConnectUpdate(IsConnected)
End Sub

' HandleBLENotification
' Process the data received from BLE notify.
' Get the device id as first byte and then parse the data according device byte pattern.
' Parameters:
'	data Byte Array - Response from the BLE device
Public Sub HandleBLENotification(payload() As Byte)
'	Dim item As String = $"[HandleBLENotification] value=${Convert.ByteConv.HexFromBytes(payload)}"$
'
'	TileEventViewer.Insert(item, HMITileUtils.EVENT_LEVEL_INFO)
'
'	ProcessBLE(payload)
End Sub

#If B4J
Public Sub Write(data() As Byte)
	BLEMgr.Write(data)
End Sub
#End If
#End Region

' ================================================================
' BLE PROCESS DATA
' ================================================================
#Region BLE Process Data
Private Sub ProcessBLE(payload() As Byte)	'ignore
	TileEventViewer.Insert($"[ProcessBLE] ${Convert.HexFromBytes(payload)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

' ================================================================
' UI
' ================================================================

' SetTilesInitialState
' Set all tiles to its initial state.
' The string "--" indicates, no value received.
Private Sub SetTilesInitialState
	TileButtonConnect.SetStateFontFontAwesome
	TileButtonConnectUpdate(IsConnected)
	
	TileSelectDirection.AddAll(Array As String("STP", "FWD", "BCK"))
	TileSelectDirection.SelectedIndex = 0
	
	TileSeekBarSpeed.Value = 0
	TileReadoutSpeed.Value = 0
End Sub

#Region TileButtonConnect_Click
' TileButtonConnect_Click
' Connect or disconnect from the BLE device.
Private Sub TileButtonConnect_Click
	' Connect
	If Not(IsConnected) Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Connecting to ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
		#if B4A
		BLEScanTimer.Enabled = True
		Connect
		TileButtonConnectUpdate(True)
		#End If

		#if B4J
		' Scan and connect > see event handlebleconnect
		Wait For (BLEMgr.Scan) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BLEMgr.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
		#End If
		Return		
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Disconnecting from ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		#if B4A
		Disconnect
		TileButtonConnectUpdate(False)
		#End If
		
		#if B4J
		' Disconnect > see event PyBridgeDisconnected
		Wait For(BLEMgr.Disconnect) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BLEMgr.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
		#End If
		Return	
	End If
End Sub

' Update the button UI color & text.
Private Sub TileButtonConnectUpdate(state As Boolean)
	If Not(TileButtonConnect.IsInitialized) Then Return
	TileButtonConnect.State = state
	TileButtonConnect.StateText = IIf(state, Chr(0xF0C1), Chr(0xF127))
End Sub
#End Region

#Region TileSeekBarSpeed
Private Sub TileSeekBarSpeed_ValueChanged (Value As Int)
	If Value > 0 And TileSelectDirection.SelectedIndex == BuWizz.DIRECTION_STP Then
		TileSelectDirection.SelectedIndex = BuWizz.DIRECTION_FWD
	End If
	SetSpeed
	TileEventViewer.Insert($"[TileSeekBarSpeed_ValueChanged] speed=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

#Region TileEventViewer/Info
#if B4J
Private Sub TileEventViewer_Click(EventData As MouseEvent)
	Log(BLEMgr.LastMsg)
End Sub
#end if

Private Sub TileEventViewer_ItemClick (Index As Int, Value As Object)
	
End Sub
#End Region


#Region Speed
' Set the speed and the direction.
' Slider value: > 50 direction forward, < 50 direction backwards.
Private Sub SetSpeed
	Dim speed As Float = 0

	' Determine direction
	Select TileSelectDirection.SelectedIndex
		Case BuWizz.DIRECTION_STP
			speed = 0
			TileSeekBarSpeed.Value = 0
			TileReadoutSpeed.Value = NumberFormat(speed, 0, 0)
		Case BuWizz.DIRECTION_FWD
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + BuWizz.SPEED_OFFSET, 0, 100 + BuWizz.SPEED_OFFSET, BuWizz.SPEED_MIN, BuWizz.SPEED_MAX)
			Else
				speed = 0				
			End If
			TileReadoutSpeed.Value = NumberFormat(TileSeekBarSpeed.Value, 0, 0)
		Case BuWizz.DIRECTION_BCK
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + BuWizz.SPEED_OFFSET, 0, 100 + BuWizz.SPEED_OFFSET, BuWizz.SPEED_MIN, BuWizz.SPEED_MAX)
				speed = speed * -1
			Else
				speed = 0
			End If
			TileReadoutSpeed.Value = NumberFormat(TileSeekBarSpeed.Value, 0, 0)
	End Select
	
	' Set the power level for the BuWizz2 controller
	BuWizz.SetPowerLevel(Port, speed)
	
	' Gimmick
	If TileReadoutSpeed.Value > 90 Then
		'TileReadoutSpeed.SetAlarm(TileReadoutSpeed.Value)
	else if TileReadoutSpeed.Value > 70 Then
		'TileReadoutSpeed.SetWarning(TileReadoutSpeed.Value)
	Else
		'TileReadoutSpeed.SetInfo(TileReadoutSpeed.Value)
	End If

	' LOg	
	Dim msg As String = $"[SetSpeed] sliderspeed=${NumberFormat(TileSeekBarSpeed.Value,0,0)},speed=${NumberFormat(Abs(speed),0,0)},dir=${TileSelectDirection.Selected}"$
	TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_INFO)
	Log(msg)
End Sub
#End Region

Private Sub TileSelectDirection_ValueChanged (Value As Object)
	If IsConnected Then
		' Stop first
		BuWizz.SetPowerLevel(Port, 0)
		' Set speed
		SetSpeed	
	End If
End Sub