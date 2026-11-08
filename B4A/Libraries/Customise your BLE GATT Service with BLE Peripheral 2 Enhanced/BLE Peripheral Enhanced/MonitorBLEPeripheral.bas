B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=12.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Public Manager As BleManager2
	Public ConnectedCentrals As Map
	Private Peripheral As BlePeripheral2Enhanced
	Public NotAvailable As Boolean
End Sub

Sub Service_Create
	Manager.Initialize("Manager")
	ConnectedCentrals.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Private Sub Manager_StateChanged (State As Int)
	If State <> Manager.STATE_POWERED_ON Then
		ToastMessageShow("Please enable Bluetooth", True)
		NotAvailable = True
	Else
		Peripheral.Initialize("Peripheral", Manager)

		If Peripheral.IsPeripheralSupported = False Then
			ToastMessageShow("Peripheral mode not supported.", True)
			NotAvailable = True
		Else
			'Create your own custom GATT Primary Service UUID - Service UUID
			Peripheral.CreatePrimaryServiceUUID = "DADCD468-1F09-476D-9B00-B547A86981B8"
			'Create your own custom GATT Characteristic UUIDs - Characteristic UUID~Read~Write~Notify
			Peripheral.CreateCharacteristicUUIDs = Array As String("D3DE8C5C-6EE4-43D6-8A5B-61D45BFA16C2,True,True,True", "37CCFFD4-5870-4A83-B224-5F0DC4EEB968,True,True,False", "0B494FBF-6ACC-4DE2-86FE-390CFA74EE07,True,False,False", "691EF90F-1CCD-401D-A0C5-A404442C7B25,False,True,False", "D37D2315-A55F-409E-A004-E9E071583E00,False,True,False", "FB3833FC-0FCD-4EE8-A2F0-04A6B49A26C9,False,True,False", "E77BBA92-A801-4151-8105-1AEF427C4AF7,True,True,False")
			'Set the read values for selected characteristics (Optional)
			Peripheral.SetCharacteristicReadValues = Array As String ("0B494FBF-6ACC-4DE2-86FE-390CFA74EE07,B4A Read Only Value")
			'Start BLE GATT Service
			Peripheral.Start2("B4A GATT Service", CreateAdvertiseSettings)
			
			Wait For Peripheral_Start (Success As Boolean)
			Log($"Peripheral started successfully = ${Success}"$)
		End If
	End If
	SetState(False)
End Sub

'**************************** Added  new event (Optional) - Fires when a client (central device) connects/disconnects ****************************
Sub Peripheral_ConnectionStatus (DeviceId As String, ConnectionState As String)
	Log($"Device ${DeviceId} is ${ConnectionState}"$)
End Sub
'*************************************************************************************************************************************************

Sub Peripheral_Subscribe (CentralId As String)
	ConnectedCentrals.Put(CentralId, "")
	Log("Connected: " & ConnectedCentrals)
	'Manager.SetNotify("00000001-0000-1000-8000-00805f9b34fb", "00002901-0000-1000-8000-00805f9b34fb", True)
	SetState(True)
End Sub

Sub Peripheral_Unsubscribe(CentralId As String)
	ConnectedCentrals.Remove(CentralId)
	Dim connected As Boolean = ConnectedCentrals.Size > 0
	SetState(connected)
End Sub

''**************************** Erels original event ****************************
'Sub Peripheral_NewData (DeviceId As String, Data() As Byte)
'	Peripheral.Write(Null, Data) 'send the message to all subscribed centrals (this can be removed for one to one connections).
'	CallSub2(Main, "NewMessage", Data)
'End Sub

'**************************** Added new event (Optional) - Can replace original _NewData event ****************************
Sub Peripheral_NewData2 (DeviceId As String, Data() As Byte, CharacteristicUUID As String, DataAsStr As String, DataAsHex As String, DataAsBin As String)
	Log(">>>>>>> Peripheral_NewData2 <<<<<<<")
	Log("------- Data via new sub signature -------")
	Log($"Received by UUID: ${CharacteristicUUID}"$)
	Log($"Raw bytes data: ${Data}"$)
	Log($"Data as str: ${DataAsStr}"$)
	Log($"Data as hex: ${DataAsHex}"$)
	Log($"Data as bin: ${DataAsBin}"$)
	Log("------------------------------------------------------------------------")
	Log("------- Data via variables/fields -------")
	Log($"Received by UUID: ${Peripheral.GetCharacteristicUUID}"$)
	Log($"Data as str: ${Peripheral.GetDataAsString}"$)
	Log($"Data as hex: ${Peripheral.GetDataAsHexadecimal(True)}"$)
	Log($"Data as bin: ${Peripheral.GetDataAsBinary}"$)
'**************************************************************************************************************************
	
	Peripheral.Write(Null, Data) 'send the message to all subscribed centrals (this can be removed for one to one connections).
	CallSub2(Main, "NewMessage", Data)
End Sub

Sub SendMessage (msg() As Byte)
	Peripheral.Write(Null, msg)
End Sub

Sub SetState (Connected As Boolean)
	CallSub2(Main, "SetState", Connected)
End Sub

'Optional - Bypass the default settings for the BLE GATT service
Private Sub CreateAdvertiseSettings As Object
	'More advertise settings online https://developer.android.com/reference/android/bluetooth/le/AdvertiseSettings.Builder

	Dim Builder As JavaObject
		Builder.InitializeNewInstance("android.bluetooth.le.AdvertiseSettings.Builder", Null)
		'Builder.RunMethod("setDiscoverable", Array(True))
		Builder.RunMethod("setConnectable", Array(True))
		Builder.RunMethod("setAdvertiseMode", Array(2)) '2 '0 = ADVERTISE_MODE_LOW_POWER, 1 = ADVERTISE_MODE_BALANCED (balanced power mode), 2 = ADVERTISE_MODE_LOW_LATENCY (high power mode)
		Builder.RunMethod("setTxPowerLevel", Array(3)) '3 '0 = ADVERTISE_TX_POWER_ULTRA_LOW, 1 = ADVERTISE_TX_POWER_LOW, 2 = ADVERTISE_TX_POWER_MEDIUM, 3 = ADVERTISE_TX_POWER_HIGH
		Builder.RunMethod("setTimeout", Array(0))
		Return Builder.RunMethod("build", Null)
End Sub
