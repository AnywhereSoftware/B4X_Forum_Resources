B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Notes
'Project:		rBLEBeacon
'Description:	Basic Example for the B4R Library rBLEBeacon.
'				Get advertised counter value..
'				B4ABeaconClient B4XPages application.
'				* scan for the BLE device with name BLEBeacon.
'				* Get the advertised data and extract the counter value.
'				* display the counter value.
'BLE:			Device name: BLEBeacon, MAC: 30:C9:22:D1:80:2E
'Source:		BLEBeaconClient.b4a
'Date:			See globals version
'Author:		Robert W.B. Linn
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Sub Class_Globals
	Private VERSION As String	= "BLEBeaconClient v20250211"
	Private INFO As String		= "rBLEBeacon Basic Example"
	
	'Debug mode for extensive logging to the IDE
	Private DEBUG As Boolean 	= True
	'Private DEBUG As Boolean 	= False
	
	'Core	
	Private xui As XUI
	Private Root As B4XView

	'Views
	Private btnScan As B4XView
	Private lblState As B4XView
	Private lblScanStatus As B4XView
	Private pbScan As B4XLoadingIndicator
	Private lblInfo As B4XView
	Private lblCounterValue As B4XView
	Private lblAdvertisedTime As B4XView
	
	'BLE Manager
	'Communication
	Private DEVICE_NAME As String			= "BLEBeacon"			'Default device name of the ESP32 BLE beacon as set in B4R	'ignore
	Private DEVICE_MAC As String			= "30:C9:22:D1:80:2E"	'MAC address of the ESP32 BLE beacon	'ignore
	Private SCAN_DURATION As Short = 5000							'Max 5 seconds scannning - see StartScan

	#if B4A
	Private Manager As BleManager2
	Private rp As RuntimePermissions
	#else if B4i
	Private manager As BleManager
	#end if
	Public  BeaconFound As Boolean = False
	Private currentStateText As String = "UNKNOWN"

	'Eddystone
	Private EDDYSTONE_UID_SIZE As Byte = 18 	'Used to extract advertised data from ESP32 (see B4R)
		
	'Timer reading advertised data
	Private TimerScanData As Timer
	Private TimerScanDataInterval As Long = 10000
	
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

	'View settings
	B4XPages.SetTitle(Me, VERSION)
	lblCounterValue.Text = "--"
	lblInfo.Text = INFO

	'Init timerscandata - is enabled after initial scan
	TimerScanData.Initialize("TimerScanData", TimerScanDataInterval)
	TimerScanData.Enabled = False

	'Init the BLE manager
	Manager.Initialize("manager")

	'Init state changed
	StateChanged

	'Initial scan
	InitialScan
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Exit the app?", "Confirmation", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		'Completely close the app
		ExitApplication
	End If
	Return True
End Sub
#End Region

#Region TimerScanData
'Handle tick events.
Sub TimerScanData_Tick
	Log($"[TimerScanData_Tick] StartScan"$)
	StartScan
End Sub
#End Region

#Region InitialScan
Sub InitialScan
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
			ToastMessageShow($"[ERROR] No BLE permission: ${Permission}"$, True)
			Return
		End If
	Next
	#end if

	'Start scanning
	TimerScanData.Enabled = True
	StateChanged
End Sub

#Region UIButtons
Private Sub btnScan_Click
	'Enable or disable the timer to scan for beacon data
	TimerScanData.Enabled = Not(TimerScanData.Enabled)
	'Update state
	StateChanged
End Sub
#End Region

#Region BLEScanningState
'Handle changing the BLE scanning state
Public Sub StateChanged
	lblState.Text = currentStateText
	lblScanStatus.Text = IIf(TimerScanData.Enabled, "ON", "OFF")
	pbScan.Hide

	If Not(TimerScanData.Enabled) Then
		lblCounterValue.Text = "--"
	End If
End Sub
#End Region

#Region BLEScan
'Start scanning for BLE beacon device
'The scan duration is set to max 5 seconds (or other = see globals).
'The event manager_devicefound is raised.
Public Sub StartScan
	'If DEBUG Then Log($"[StartScan] Start"$)
	
	BeaconFound = False
	
	'Check BLE turned on
	If Manager.State <> Manager.STATE_POWERED_ON Then
		Log($"[ERROR][StartScan] BLE is not not powered on."$)
		ToastMessageShow($"[ERROR][StartScan] BLE is not not powered on."$, True)
	Else
		'Start scanning - show progressbar
		pbScan.Show
		
		'Scan for all
		Manager.Scan(Null)
		Sleep(SCAN_DURATION)
		Manager.StopScan
		
		pbScan.Hide
		
		If Not(BeaconFound) Then 
			TimerScanData.Enabled = False
			StateChanged
		End If
	End If
	
	'If DEBUG Then Log($"[StartScan] End"$)
End Sub
#End Region

'Set the counter data to the UI field
'Extract the data from the advertised key -1, i.e. 17 which is the last byte is the countervalue.
'AdvertisingData key=-1,hex='Example advertised data (see rBLEBeacon.cpp):
'00D20C9CB0A5D94BF7A3E1D20C9CB0A5D9F017
Sub SetSensorData(advertisingData As Map)
	' Manufacturer Data (Raw BLE Data)
    If advertisingData.ContainsKey(-1) Then
        Dim rawData() As Byte = advertisingData.Get(-1)
  
        'Ensure data is long enough to contain Eddystone UID (17+ bytes)
		If rawData.Length > EDDYSTONE_UID_SIZE Then
			'Extract data after Eddystone UID
			Dim sensorData(rawData.Length - EDDYSTONE_UID_SIZE) As Byte
			bc.ArrayCopy(rawData, EDDYSTONE_UID_SIZE, sensorData, 0, rawData.Length - EDDYSTONE_UID_SIZE)
			If DEBUG Then Log($"[ExtractData] rawdata=${bc.HexFromBytes(rawData)}, sensordata=${bc.HexFromBytes(sensorData)} (${sensorData.Length})"$)

			Dim counterhex As String
			'If sensorData.Length == 1 Then counterhex = $"${${HexFromByte(sensorData(0))}"$
			counterhex = $"${HexFromByte(sensorData(1))}${HexFromByte(sensorData(0))}"$
			If DEBUG Then Log($"[ExtractData] counter=${counterhex} (${sensorData.Length})"$)

			'Update the fields
			lblCounterValue.Text	= NumberFormat2(Bit.ParseInt(counterhex, 16), 0, 0, 0, False)
			lblAdvertisedTime.Text	= DateTime.Time(DateTime.Now)
		Else
			Log("[ERROR][SetSensorData] No sensor data found.")
		End If
	Else
		Log("[ERROR][SetSensorData] No manufacturer data found.")
    End If
End Sub

#Region BLEManager
'If the device name is found, extract the sensor data from the advertised data and update the UI fields.
'Using the ID = MAC is faster
Sub Manager_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)

	'Leave if the device is not found
	If Not(Id.EqualsIgnoreCase(DEVICE_MAC)) Then Return

	'Log($"[Manager_DeviceFound] name=${Name}, id=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)
	'If Not(Name.EqualsIgnoreCase(DEVICE_NAME)) Then Return
	Log($"[Manager_DeviceFound] name=${Name}, id=${Id}, rssi=${RSSI}, advertisingdata=",${AdvertisingData}"$)

	BeaconFound = True
	pbScan.Hide
	
	If DEBUG Then
		' Loop through the advertisement data map and log each key and value
		For Each key As Object In AdvertisingData.Keys
			Dim value As Object = AdvertisingData.Get(key)
			Log($"AdvertisingData key=${key},hex=${bc.HexFromBytes(value)}"$)
       
			' Check for manufacturer data key (key=0, usually indicates manufacturer-specific data)
			If key.As(String) == 0 Then
				Dim manufacturerData() As Byte = value
				Log("Manufacturer Data (Raw): " & bc.hexfrombytes(manufacturerData))
			End If
		Next		
	End If
	
	'Extract and set the data in the fields
	SetSensorData(AdvertisingData)
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
	StateChanged
End Sub
#End Region

#Region Helper
'Return a HEX string from single byte.
Public Sub HexFromByte(b As Byte) As String
	Return bc.HexFromBytes(Array As Byte(b))
End Sub
#End Region
