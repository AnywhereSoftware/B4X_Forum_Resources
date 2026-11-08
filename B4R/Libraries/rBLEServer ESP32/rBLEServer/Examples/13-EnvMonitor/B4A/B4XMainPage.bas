B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Notes
'Project:		rBLEServer
'Description:	EnvMonitor Example for the B4R Library rBLEServer.
'				Read DHT22 Temp+Hum sensor serialized data temperature & humidity.
'				B4AServerClient B4XPages application.
'				* connect to the BLE Server named BLEServer or use the MAC address.
'				* read DHT22 serialized data containing temperature & humidity as float.
'				* display the sensor data.
'BLE:			Device name: BLEServer, MAC: 30:C9:22:D1:80:2E
'Source:		BLEServerClient.b4a
'Date:			See globals version
'Author:		Robert W.B. Linn
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Sub Class_Globals
	Private VERSION As String	= "BLEServerClient v20250212"
	Private INFO As String		= "rBLEServer Environment Monitor Example"
	
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
	Private lblTemperatureValue As Label		'Must be label because typeface for digital font
	Private lblHumidityValue As Label			'Must be label because typeface for digital font
	Private btnPreferences As B4XView
	Private lblTemperatureIndicator As B4XView
	Private lblHumidityIndicator As B4XView
	Private lblAdvertiseInfo As B4XView

	'Dialogs
	Private PrefDialog As PreferencesDialog														'B4XPreferences dialog
	Private PrefOptionsFile As String				= "Preferences.json"						'File containing the app preferences content (folder dirapp)
	Private PrefOptions As Map																	'Preference options as a map
	Private PrefDialogFieldsFile As String			= "prefdialogfields.json"					'File containing the definition of B4XPreferences fields (folder dirassets)
	Private PREF_NAME_FIELD As String				= "name"
	Private PREF_MACADDRESS_FIELD As String			= "macaddress"
	Private PREF_USE_MACADDRESS_FIELD As String		= "usemacaddress"
	Private PREF_ADVERTISINGINTERVAL_FIELD As String= "advertisinginterval"						'BLEServer DHT22 data advertising interval in seconds

	Private Dialog As B4XDialog

	'BLE Manager
	'Communication
	Private SERVER_NAME As String					= "BLEServer"								'Default device name of the ESP32 BLE server as set in B4R
	Private SERVER_MACADDRESS As String				= "30:C9:22:D1:80:2E"						'MAC address of the ESP32 BLE server
	Private SERVICE_UUID As String 					= "6e400001-b5a3-f393-e0a9-e50e24dcca9e"	'UART Service (must be lowercase!)
	Private CHARACTERISTICS_UUID As String 			= "6e400002-b5a3-f393-e0a9-e50e24dcca9e"	'UART Characteristics (must be lowercase!)
	Private SCAN_DURATION As Short					= 5000										'Max 5 seconds scannning - see StartScan
	Private BLE_MTU_SIZE As Int						= 100										'Increase MTU size as test to check if working.
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

	'Serialized Data
	Private SerData As B4RSerializator
	Private SER_DATA_OBJECTS As Byte = 9
		
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
	'Set digital fonts for the value labels
	lblTemperatureValue.Typeface = Typeface.LoadFromAssets("digital.ttf")
	lblHumidityValue.Typeface = Typeface.LoadFromAssets("digital.ttf")
	lblTemperatureValue.Text = $"--"$
	lblHumidityValue.Text = $"--"$
	lblAdvertiseInfo.Text = $"Waiting for data..."$
	'Info about app
	lblInfo.Text = INFO

	'Init B4RSerializer
	SerData.Initialize

	'Init Preferences
	InitPreferences

	'Init the BLE manager
	Manager.Initialize("manager")

	'Init state changed
	StateChanged

	'Start ble scan & connect
	btnScan_Click
End Sub

'Handle page closerequest with either close prefdialog or close app.
Sub B4XPage_CloseRequest As ResumableSub
	If xui.IsB4A Then
		'Back key in Android
		If PrefDialog.BackKeyPressed Then 
			Return False
		Else
			Dim sf As Object = xui.Msgbox2Async("Exit the app?", "Confirmation", "Yes", "", "No", Null)
			Wait For (sf) Msgbox_Result (Result As Int)
			If Result = xui.DialogResponse_Positive Then
				'Disconnect from the BLEServer
				If Connected Then
					btnDisconnect_Click
				End If
				'Save the preferences
				SavePreferences
				'Completely close the app
				ExitApplication
			End If
		End If
	End If
	Return True
End Sub

'Don't miss the code in the Main module + manifest editor.
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	PrefDialog.KeyboardHeightChanged(NewHeight)
End Sub
#End Region

#Region Preferences
Private Sub InitPreferences
	xui.SetDataFolder ("preferences")

	PrefDialog.Initialize(Root, "Preferences Dialog", 300dip, 400dip)	'height default is 300dip

	PrefDialog.LoadFromJson(File.ReadString(File.DirAssets, PrefDialogFieldsFile))

	'Listener to check input values - see sub PrefDialog
	PrefDialog.SetEventsListener(Me, "PrefDialog")

	LoadPreferences
End Sub

'Load the preferences from the external file located in the dirapp folder
Private Sub LoadPreferences
	Log($"[LoadPreferences] folder=${xui.DefaultFolder}, file=${PrefOptionsFile}, exists=${File.Exists(xui.DefaultFolder, PrefOptionsFile)}"$)
	'Delete for tests or if field is added/changed
	'If File.Exists(xui.DefaultFolder, PrefOptionsFile) Then File.Delete(xui.DefaultFolder, PrefOptionsFile)

	'Check if the preffile exists, else create new with defaults
	If Not(File.Exists(xui.DefaultFolder, PrefOptionsFile)) Then
		'Set defaults
		PrefOptions = CreateMap(PREF_NAME_FIELD:SERVER_NAME, _ 
								PREF_MACADDRESS_FIELD:SERVER_MACADDRESS, _ 
								PREF_USE_MACADDRESS_FIELD:False, _ 
								PREF_ADVERTISINGINTERVAL_FIELD:5)
		'Save defaults as bytes
		File.WriteMap(xui.DefaultFolder, PrefOptionsFile, PrefOptions)
	End If
	
	'Read the prefoptions as bytes from the external file
	Try
		If File.Exists(xui.DefaultFolder, PrefOptionsFile) Then
			PrefOptions = File.ReadMap(xui.DefaultFolder, PrefOptionsFile)
			Log($"[LoadPreferences] folder=${xui.DefaultFolder}, options=${PrefOptions}"$)
		End If
	Catch
		Log($"[ERROR][LoadPreferences] ${LastException}"$)
	End Try
End Sub

'Save the preferences to the external file located in the dirapp folder
Private Sub SavePreferences
	Try
		File.WriteMap(xui.DefaultFolder, PrefOptionsFile, PrefOptions)
		Log($"[SavePreferences] folder=${xui.DefaultFolder}, options=${PrefOptions}"$)
	Catch
		Log($"[ERROR][SavePreferences] ${LastException}"$)
	End Try
End Sub

'Check the preferences key scaninterval
Private Sub PrefDialog_IsValid (TempData As Map) As Boolean
	'Key scaninterval
	Dim number As Int = TempData.GetDefault(PREF_ADVERTISINGINTERVAL_FIELD, 5)
	'Keep in range 5 to 3600 seconds
	If number < 5 Or number > 3600 Then
		PrefDialog.ScrollToItemWithError(PREF_ADVERTISINGINTERVAL_FIELD)
		Return False
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
	Manager.Disconnect
	Manager_Disconnected
	Log($"[btnDisconnect_Click] connected=${Connected}"$)
End Sub

Private Sub btnPreferences_Click
	Wait For (PrefDialog.ShowDialog(PrefOptions, "OK", "CANCEL")) Complete (Result As Int)
	'OK clicked > save the preferences
	If Result = xui.DialogResponse_Positive Then
		Log($"[btnPreferences_Click] result=${Result},options=${PrefOptions}"$)
		'Save the preferences to the xui.DefaultFolder
		SavePreferences
		'Write the new scan interval to the BLEServer
		Manager_Write(SerData.ConvertArrayToBytes(Array As Object(PrefOptions.Get(PREF_ADVERTISINGINTERVAL_FIELD))))
		'Show as info until new scan
		lblAdvertiseInfo.Text = $"Preferences updated.${CRLF}Advertising every ${PrefOptions.Get(PREF_ADVERTISINGINTERVAL_FIELD)} s."$
	End If
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
		lblTemperatureValue.Text = $"--"$
		lblHumidityValue.Text = $"--"$
		lblAdvertiseInfo.Text = $"No Data"$
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
	'Log($"[Manager_DeviceFound] name=${Name}, id=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)
	Dim found As Boolean = False

	'Check if servername or servermacaddress is used to find the bleserver
	If PrefOptions.Get(PREF_USE_MACADDRESS_FIELD) == False Then
		If Name = PrefOptions.Get(PREF_NAME_FIELD) Then
			Log($"[Manager_DeviceFound Name] name=${Name}, id(mac)=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)
			found = True
		End If
	Else
		If Id = PrefOptions.Get(PREF_MACADDRESS_FIELD) Then
			Log($"[Manager_DeviceFound MAC] name=${Name}, id(mac)=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)
			found = True
		End If
	End If

	'Device found, stop scanning and connect
	If found Then
		'Set connected name
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
	
	Sleep(500)
	Log($"[Manager_Connected] BLEServer write scaninterval=${PrefOptions.Get(PREF_ADVERTISINGINTERVAL_FIELD)}"$)
	'Write the new scan interval to the BLEServer
	Manager_Write(SerData.ConvertArrayToBytes(Array As Object(PrefOptions.Get(PREF_ADVERTISINGINTERVAL_FIELD))))

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

'Handle new data from the BLEserver.
Sub Manager_DataAvailable(ServiceId As String, Characteristics As Map)
	'Log($"[Manager_DataAvailable] serviceid=${ServiceId},characteristics=${Characteristics}"$)
	'key=6e400002-b5a3-f393-e0a9-e50e24dcca9e

	If Characteristics.ContainsKey(CHARACTERISTICS_UUID) Then
		'Get the response data from the characteristics - this is a single byte
		Dim response() As Byte = Characteristics.Get(CHARACTERISTICS_UUID)
		'Log($"[Manager_DataAvailable] ${CHARACTERISTICS_UUID} byte HEX=${bc.hexfrombytes(response)}"$)

		'Convert the response serialized data to objects
		Dim obj() As Object = SerData.ConvertBytesToArray(response)

		'Check if there are N objects (see SER_DATA_OBJECTS)
		If obj.Length == SER_DATA_OBJECTS Then
			'Set the labels temperature&humidity text,tag and the indicators color
			lblTemperatureValue.Text = $"${obj(0)}"$
			lblHumidityValue.Text = $"${obj(1)}"$
			lblTemperatureValue.Tag = $"${obj(2)},${obj(3)},${obj(4)}"$
			lblHumidityValue.Tag	= $"${obj(5)},${obj(6)},${obj(7)}"$
			lblTemperatureIndicator.Color = xui.Color_RGB(obj(2), obj(3), obj(4))
			lblHumidityIndicator.Color = xui.Color_RGB(obj(5), obj(6), obj(7))

			Dim interval As Int = obj(8)
			lblAdvertiseInfo.Text = $"Advertised at ${DateTime.Time(DateTime.Now)}${CRLF}"$ & _
								    $"Advertising every ${NumberFormat(obj(8) / 1000,0,0)} s.${CRLF}"$
			Log($"[Manager_DataAvailable] t=${obj(0)},h=${obj(1)},rgbtemperature=${lblTemperatureValue.Tag},rgbhumidity=${lblHumidityValue.Tag},interval=${NumberFormat(interval,0,0)}"$)
		Else
			lblTemperatureValue.Text = $"--"$
			lblHumidityValue.Text = $"--"$
			lblAdvertiseInfo.Text = $"Wrong number of objects (${obj.Length} instead ${SER_DATA_OBJECTS})."$
			Log($"[ERROR][Manager_DataAvailable] Wrong number of objects received, ${obj.Length} expect ${SER_DATA_OBJECTS}."$)
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
Private Sub Manager_MTUChanged (Success As Boolean, Value As Int)
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
		Log($"[Manager_Write] data=${bc.HexFromBytes(data)}"$)
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
