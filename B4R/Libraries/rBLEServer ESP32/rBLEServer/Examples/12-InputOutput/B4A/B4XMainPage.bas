B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Notes
'Project:		rBLEServer
'Description:	InputOutput Example for the B4R Library rBLEServer.
'				B4AServerClient B4XPages application.
'				* connect to the BLE Server named BLEServer or use the MAC address.
'				* set the state of the traffic-light connected to the BLE Server.
'				* get the state of the traffic-light set by the push-button connected to the BLE Server.
'BLE:			Device name: BLEServer, MAC: 30:C9:22:D1:80:2E
'Source:		InputOutputExample.b4r
'Date:			See globals version
'Author:		Robert W.B. Linn
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Sub Class_Globals
	Private VERSION As String	= "BLEServerClient v20250207"
	Private INFO As String		= "rBLEServer InputOutput Example"
	
	'Debug mode for extensive logging to the IDE
	'Private DEBUG As Boolean 	= True
	'Private DEBUG As Boolean 	= False 'True
	
	'Core	
	Private xui As XUI
	Private Root As B4XView

	'Views
	Private btnDisconnect As B4XView
	Private btnScan As B4XView
	Private lblDeviceStatus As B4XView
	Private lblState As B4XView
	Private pbScan As B4XLoadingIndicator
	Private lblInfo As B4XView
	Private btnTrafficLightRed As B4XView
	Private btnTrafficLightYellow As B4XView
	Private btnTrafficLightGreen As B4XView

	'Dialog
	Private Dialog As B4XDialog

	'BLE Manager
	'Communication
	Private DEVICE_NAME As String			= "BLEServer"								'Default device name of the ESP32 BLE server as set in B4R
	Private DEVICE_MAC As String			= "30:C9:22:D1:80:2E"						'MAC address of the ESP32 BLE server	'ignore
	Private SERVICE_UUID As String 			= "6e400001-b5a3-f393-e0a9-e50e24dcca9e"	'UART Service (must be lowercase!)
	Private CHARACTERISTICS_UUID As String 	= "6e400002-b5a3-f393-e0a9-e50e24dcca9e"	'UART Characteristics (must be lowercase!)

	'Private BLEConnected As Boolean 			= False										'Flag indicating ble connection
	'Public BLEResponse(50) As Byte														'Response from the display after receiving command
	'Private BLEResponseLength As Byte

	Private SCAN_DURATION As Short = 5000			'Max 5 seconds scannning - see StartScan
	Private BLE_MTU_SIZE As Int = 100				'Increase MTU size as test to check if working.
	#if B4A
	Private Manager As BleManager2
	Private rp As RuntimePermissions
	#else if B4i
	Private manager As BleManager
	#end if
	Public  Connected As Boolean = False
	Private ConnectedName As String

	Private currentStateText As String = "UNKNOWN"
	Private currentState As Int

	'TrafficLight LEDs
	Private LED_RED As Byte = 0x19
	Private LED_YELLOW As Byte = 0x21
	Private LED_GREEN As Byte = 0x20
		
	'Helper
	Private bc As ByteConverter	'ignore
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

#Region B4XPages
'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	'Dialog
	Dialog.Initialize(Root)
	Dialog.Title = ""

	'View settings
	B4XPages.SetTitle(Me, VERSION)
	lblInfo.Text = INFO
	SetTrafficLight(0)

	'Init the BLE manager
	Manager.Initialize("manager")
	'Init state changed
	StateChanged
	'Start scan & connect
	btnScan_Click
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Exit the app?", "Confirmation", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		'Disconnect from the BLEServer
		If Connected Then
			btnDisconnect_Click
		End If
		'Completely close the app
		ExitApplication
	End If
	Return True
End Sub
#End Region

#Region UIButtons
Private Sub btnScan_Click
	#if B4A
	'Don't forget to add permission to manifest
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
	#end if
	'Start scanning
	StartScan
End Sub

Private Sub btnDisconnect_Click
	Log($"[btnDisconnect_Click] disconnecting"$)
	Manager.Disconnect
	Manager_Disconnected
End Sub

Private Sub btnTrafficLightRed_Click
	Manager_Write(Array As Byte(LED_RED))
End Sub

Private Sub btnTrafficLightYellow_Click
	Manager_Write(Array As Byte(LED_YELLOW))
End Sub

Private Sub btnTrafficLightGreen_Click
	Manager_Write(Array As Byte(LED_GREEN))
End Sub
#End Region

#Region TrafficLight
'Set the trafficlight. For the selected LED set alpha higfh else low intensity.
Private Sub SetTrafficLight(led As Byte)
	Dim borderwidth As Int = 5dip
	Dim bordercornerradius As Int = 20dip
	Dim bordercolor As Int = xui.Color_DarkGray
	
	'Set all LEDs to low alpha
	Dim alpha As Byte = 100
	btnTrafficLightRed.SetColorAndBorder(xui.Color_ARGB(alpha,255,0,0), borderwidth, bordercolor, bordercornerradius)
	btnTrafficLightYellow.SetColorAndBorder(xui.Color_ARGB(alpha,255,255,0), borderwidth, bordercolor, bordercornerradius)
	btnTrafficLightGreen.SetColorAndBorder(xui.Color_ARGB(alpha,0,128,0), borderwidth, bordercolor, bordercornerradius)

	'Set selected LED to high alpha
	alpha = 255
	Select led
		Case LED_RED
			btnTrafficLightRed.SetColorAndBorder(xui.Color_ARGB(alpha,255,0,0), borderwidth, bordercolor, bordercornerradius)
		Case LED_YELLOW
			btnTrafficLightYellow.SetColorAndBorder(xui.Color_ARGB(alpha,255,255,0), borderwidth, bordercolor, bordercornerradius)
		Case LED_GREEN
			btnTrafficLightGreen.SetColorAndBorder(xui.Color_ARGB(alpha,0,128,0), borderwidth, bordercolor, bordercornerradius)
		'Case Else
		'	Log($"[ERROR][Manager_DataAvailable] Unknown LED=${led}"$)
	End Select
End Sub
#End Region

#Region BLEState
'Handle changing the BLE connection state
Public Sub StateChanged
	Log($"[StateChanged] connected=${Connected}"$)
	lblState.Text = currentStateText
	If Connected Then
		lblDeviceStatus.Text = "Connected: " & ConnectedName
	Else
		lblDeviceStatus.Text = "Not connected"
	End If
	'Set the UI views according connect state
	btnDisconnect.Enabled = Connected
	btnScan.Enabled = Not(Connected)
	btnScan.Enabled = (currentState = Manager.STATE_POWERED_ON) And Connected = False
	pbScan.Hide
End Sub
#End Region

#Region BLEScan
'Start scanning for BLE devices with service uuid set in LEDMatrixPanel.
'The scan duration is set to max 5 seconds.
'The event manager_devicefound is raised.
Public Sub StartScan
	Log($"[StartScan] Start"$)
	'Check BLE turned on
	If Manager.State <> Manager.STATE_POWERED_ON Then
		Log($"[ERROR][StartScan] BLE is not not powered on."$)
		ToastMessageShow($"[ERROR][StartScan] BLE is not not powered on."$, True)
	Else
		'Start scanning - show progressbar
		pbScan.Show
		'Manager.Scan(Null)
		Manager.Scan2(Array As String(SERVICE_UUID), False)
		Sleep(SCAN_DURATION)
		Manager.StopScan
		pbScan.Hide
		If Not(Connected) Then ToastMessageShow($"[ERROR][StartScan] Device not found."$, True)
	End If
	Log($"[StartScan] End"$)
End Sub
#End Region

#Region BLEManager
'If the service UUId is found, then stop scanning and connect to the device by device name set .
'The event manager_connected is raised.
Sub Manager_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)
	Log($"[Manager_DeviceFound ] name=${Name}, id=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)

	'If Id = DEVICE_MAC Then
	If Name = DEVICE_NAME Then
		ConnectedName = Name

		Manager.StopScan
		pbScan.Hide
		Log($"[Manager_DeviceFound] Connecting..."$)

		#if B4A
		Manager.Connect2(Id, False) 'disabling auto connect can make the connection quicker
		#else if B4I
		manager.Connect(Id)
		#end if
	End If
End Sub

'Event after manager has connected to the device
Sub Manager_Connected (services As List)
	Log("[Manager_Connected] Connected start")
	For Each service As String In services
		Log($"[Manager_Connected] service=${service}"$)
	Next
	
	Connected = True

	StateChanged

	'Set the notify flag
	Try
		Log("[Manager_Connected] ReadCharacteristic before SetNotify")
		Manager.GetCharacteristicProperties(SERVICE_UUID, CHARACTERISTICS_UUID)
		'Allow some delay for proper descriptor discovery
		Sleep(500)
		Log("[Manager_Connected] setnotify")
		Manager.SetNotify(SERVICE_UUID, CHARACTERISTICS_UUID, True)
		'Allow some delay for proper notification setting
		Sleep(500)
		'Read the last stored value from the characteristic
		Log("[Manager_Connected] ReadData")
		'Manager.ReadData(SERVICE_UUID)
		Manager.ReadData2(SERVICE_UUID, CHARACTERISTICS_UUID)
	Catch
		Log($"[ERROR[Manager_Connected] setnotify=${LastException}"$)
	End Try

	'Increase the MTU - important for sending large data packets like for commandsettext
	Try
		Manager.RequestMtu(BLE_MTU_SIZE)		
	Catch
		Log($"[ERROR[Manager_Connected] requestmtu=${LastException}"$)
	End Try
	
	Log("[Manager_Connected] Connected done")
End Sub

'Disconnected from the device
Sub Manager_Disconnected
	Connected = False
	'Log($"[Manager_Disconnected] connected=${connected}"$)
	StateChanged
End Sub

Sub Manager_StateChanged (State As Int)
	Select State
		Case Manager.STATE_POWERED_OFF
			currentStateText = "POWERED OFF"
		Case Manager.STATE_POWERED_ON
			currentStateText = "POWERED ON"
		Case Manager.STATE_UNSUPPORTED
			currentStateText = "UNSUPPORTED"
	End Select
	currentState = State
	StateChanged
End Sub

'Handle new data from the display
Sub Manager_DataAvailable(ServiceId As String, Characteristics As Map)
	'Log($"[Manager_DataAvailable] serviceid=${ServiceId},characteristics=${Characteristics}"$)
	'key=6e400002-b5a3-f393-e0a9-e50e24dcca9e

	If Characteristics.ContainsKey(CHARACTERISTICS_UUID) Then
		'Get the response data from the characteristics - this is a single byte
		Dim response() As Byte = Characteristics.Get(CHARACTERISTICS_UUID)
		If response.Length == 1 Then
			'[Manager_DataAvailable] 6e400002-b5a3-f393-e0a9-e50e24dcca9e byte HEX=19, DEC=25
			Log($"[Manager_DataAvailable] ${CHARACTERISTICS_UUID} byte HEX=${bc.hexfrombytes(response)}, DEC=${response(0)}"$)
			Dim LED As Byte = response(0)
			SetTrafficLight(LED)
		End If		
	Else
		Return
	End If
End Sub

'NOT USED - see Manager_Write
'Android determines the writing type based on the characteristics properties.
'Sub Manager_WriteComplete (Characteristic As String, Status As Int)
'	Log($"[Manager_WriteComplete] characteristic=${Characteristic},status=${Status}"$)
'	'Read the response > event manager_dataavailable
'	Manager.ReadData2(SERVICE_UUID, Characteristic)
'End Sub

'Event after changing the MTU size (range 23 - 517 bytes ) 
Sub Manager_MTUChanged (Success As Boolean, Value As Int)
	Log($"[Manager_MTUChanged] success=${Success},mtu=${Value}"$)
End Sub
#End Region

#Region Write

'Write data (byte array) to the BLE server via the blemanager.
'Manager.WriteData is asynchronous. Call it and Wait For Manager_WriteComplete (Characteristic As String, Status As Int)
'Check the Data length. It should be short. 20 bytes Or less.
'Call readresponse to trigger reading the response data from the blemanager.
'The response is handled by the event Manager_DataAvailable(ServiceId As String, Characteristics As Map)
Private Sub Manager_Write(data() As Byte)
	If data.Length == 0 Then
		Log($"[ERROR][Manager_Write] No data."$)
		Return
	End If
	If Connected Then
		'Important to set a short sleep to let any previous write operation complete
		Sleep(100)

		'Write the data async
		Manager.WriteData(SERVICE_UUID, CHARACTERISTICS_UUID, data)

		'Wait for completion
		Wait For Manager_WriteComplete (Characteristic As String, Status As Int)

		'Handle the response status
		Log($"[Manager_Write] writecomplete status=${Status}"$)
		'Status 0 is OK
		If Status == 0 Then
			'Log($"[Manager_Write] writecomplete trigger readresponse"$)
			'Read the response > event manager_dataavailable
			'Manager.ReadData2(SERVICE_UUID, Characteristic)
		End If
	Else
		Log($"[ERROR][Manager_Write] Not connected to the BLE server."$)
	End If
End Sub

'Write data with response
'manager.WriteDataWithResponse(svc, charact, order)
'Wait For Manager_WriteComplete (Characteristic As String, Success As Boolean)


'Example writedata using javaobjects
'Sub WriteData(Service As String, Characteristic As String, Value As String) As Boolean
'	Dim jo As JavaObject = Manager
'	Dim gatt As JavaObject = jo.GetField("gatt")
'	Dim serv As JavaObject = jo.RunMethod("getService", Array(Service))
'	Dim char As Object = jo.RunMethod("getChar", Array(serv, Characteristic ))
'	char.RunMethod("setValue", Array(Value))
'	Return gatt.RunMethod("writeCharacteristic", Array(char))
'End Sub
#End Region

#Region Helper
'Utility to convert short UUIDs to long format on Android
Private Sub UUID(id As String) As String 'ignore
#if B4A
	Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"
#else if B4I
	Return id.ToUpperCase
#End If
End Sub
#End Region
