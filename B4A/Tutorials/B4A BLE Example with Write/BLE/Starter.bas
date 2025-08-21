B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.2
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public manager As BleManager2
	Public currentStateText As String = "UNKNOWN"
	Public currentState As Int
	Public connected As Boolean = False
	Public ConnectedName As String
	Private ConnectedServices As List
	Public rp As RuntimePermissions
End Sub

Sub Service_Create
	manager.Initialize("manager")
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public Sub ReadData
	For Each s As String In ConnectedServices
		manager.ReadData(s)
	Next
End Sub

Public Sub Disconnect
	manager.Disconnect
	Manager_Disconnected
End Sub

Sub Manager_StateChanged (State As Int)
	Select State
		Case manager.STATE_POWERED_OFF
			currentStateText = "POWERED OFF"
		Case manager.STATE_POWERED_ON
			currentStateText = "POWERED ON"
		Case manager.STATE_UNSUPPORTED
			currentStateText = "UNSUPPORTED"
	End Select
	currentState = State
	CallSub(Main, "StateChanged")
End Sub

Sub Manager_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)
	Log("Found: " & Name & ", " & Id & ", RSSI = " & RSSI & ", " & AdvertisingData) 'ignore
	CallSub3(Main, "DeviceAvailable", Name, Id)
End Sub

Sub ConnectDevice(Name As String, Id As String)
	ConnectedName = Name
	manager.StopScan
	manager.Connect2(Id, False) 'disabling auto connect can make the connection quicker
End Sub

Public Sub StartScan
	If manager.State <> manager.STATE_POWERED_ON Then
		Log("Not powered on.")
	Else If rp.Check(rp.PERMISSION_ACCESS_COARSE_LOCATION) = False Then
		Log("No location permission.")
	Else
		manager.Scan2(Null, False)
	End If
End Sub

Public Sub StopScan
	manager.StopScan
End Sub

Sub Manager_DataAvailable (ServiceId As String, Characteristics As Map)
	CallSub3(Main, "DataAvailable", ServiceId, Characteristics)
End Sub

Sub Manager_Disconnected
	Log("Disconnected")
	connected = False
	CallSub(Main, "StateChanged")
End Sub

Sub Manager_Connected (services As List)
	Log("Connected")
	connected = True
	ConnectedServices = services
	CallSub(Main, "StateChanged")
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

public Sub WriteData(Characteristic As Object, Value As String)
	If Not(connected) Then Return
	Dim myCharacteristic As Characteristic = Characteristic
	Log("Write: " & Value & " to " & myCharacteristic.CharacteristicId)
	manager.WriteData(myCharacteristic.ServiceId, myCharacteristic.CharacteristicId, Value.GetBytes("UTF8"))
End Sub
