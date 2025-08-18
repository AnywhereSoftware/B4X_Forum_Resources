B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.17
@EndOfDesignText@
Sub Class_Globals
#if B4A
	Private manager As BleManager2
#else if B4I
	Private manager As BleManager
#end if

	Private CADENCE_SERVICE As String = "1816"
	Private CADENCE_MEASUREMENT As String = "2a5b"
	Private firstRead As Boolean
	Private lastcranktime=0 As Int
	Private lastwheeltime=0 As Int
	Private crot As Int
'	
End Sub

' attributes.put("00002a5b-0000-1000-8000-00805f9b34fb", "CSC Measurement");

Public Sub Initialize
	
	CADENCE_SERVICE = UUID(CADENCE_SERVICE)
	CADENCE_MEASUREMENT = UUID(CADENCE_MEASUREMENT)
	manager.Initialize("manager")
	Log("init cadence")

	''DeviceId: 84:DD:20:EC:87:14 panobike
'	
End Sub
Private Sub Manager_StateChanged (State As Int)
	Log($"CadenceStateChanged: ${State}"$)
'	CallSub("main","readSettings")
'	Log(Main.instellingen.mac)
	If State = manager.STATE_POWERED_ON Then
		Log("Cadencepower on")
		manager.Scan(Array(CADENCE_SERVICE))
'		manager.Scan(Null)
		Log("Cadencescanning")
	End If
End Sub

''registerApp() - UUID=03f7ed32-16bf-49f1-b909-f29bb37f694a
Private Sub Manager_DeviceFound (Name As String, DeviceId As String, AdvertisingData As Map, RSSI As Double)
	Log($"****************
Name: ${Name}
DeviceId: ${DeviceId}"$)
	
	Sleep(500)
	Private found=False As Boolean
	If Main.instellingen.sensors.Size>0 Then 
		For x=0 To Main.instellingen.sensors.size-1
			Main.instellingen.sensors.Get(X)
			Private sensor= Main.instellingen.sensors.Get(X) As sensortype
			If  sensor.DeviceID=DeviceId Then
				Log($"Connecting to existing: ${DeviceId}"$)
				manager.Connect(DeviceId)
				manager.StopScan
				found=True
			End If
		Next
	End If
	If found=False Then
		manager.Connect(DeviceId)
		manager.StopScan
		Private sensor As sensortype
	
		sensor.DeviceID=DeviceId
		sensor.Name=Name
		sensor.Sensortype=Main.CSC
		Main.instellingen.sensors.add(sensor)
		Log($"Connecting to new: ${DeviceId}"$)
		CallSub("main","writesettings")
	End If

End Sub
Sub speachTTS(voice As String)
	Log("voice" & voice)
	If Main.instellingen.tracksettings.TTSWPT Then Main.tts1.Speak(voice,False)
End Sub

Private Sub Manager_Connected (Services As List)
	Log("Cadence Connected")

	speachTTS("Cadence connected")
	firstRead = True
	manager.ReadData(CADENCE_SERVICE)
	Main.crankdata.crankconnected=True
	CallSub("main","ConnectIcon")
End Sub

Private Sub Manager_Disconnected
	Log("Disconnected Cadence")

	speachTTS("Cadence disconnected")
	Main.crankdata.crankconnected=False
End Sub


Private Sub Manager_DataAvailable (ServiceId As String, Characteristics As Map)



	Private b() As Byte = Characteristics.Get(CADENCE_MEASUREMENT)

	If b.Length=11 Then
	
		If Bit.And(b(0),1)>0 Then
			Private wtemp=ByteToInt(b(6),b(5)) As Int
			If firstRead Then lastwheeltime=wtemp
			If lastwheeltime<>wtemp Then
				Main.wheelrevolutions=(65536/Bit.And((wtemp-lastwheeltime),0xffff)+Main.wheelrevolutions)/2
			Else
'				Main.wheelrevolutions=0
			End If
			lastwheeltime=wtemp
'			Log("Wheel" &Main.wheelrevolutions)
		End If
		If Bit.And(b(0),2)>0 Then
'			 crot=ByteToInt(b(8),b(7)) As Int
			
			Private ctemp=ByteToInt(b(10),b(9)) As Int
			If firstRead Then lastcranktime=ctemp
			If lastcranktime<> ctemp Then
				Main.crankdata.CrankRevolutions=(65536/Bit.And((ctemp-lastcranktime),0xffff)+Main.crankdata.CrankRevolutions)/2
				Main.crankdata.CrankUpdated=True
			Else
'				Main.cadencerevolutions=0
			End If
			lastcranktime=ctemp
			Log("Cadence" &Main.crankdata.CrankRevolutions)
		End If
	End If
	If firstRead Then
		firstRead = False
		manager.SetNotify(CADENCE_SERVICE, CADENCE_MEASUREMENT, True)
		Return
	End If
End Sub


Sub ByteToInt(hi As Int,lo As Int) As Int
hi=Bit.ShiftLeft(Bit.And((hi+256),255),8)
lo=Bit.And((lo+256),255)
Return Bit.Or(hi,lo)
End Sub
'00002a5b-0000-1000-8000-00805f9b34fb
Private Sub UUID(id As String) As String
#if B4A
	Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"
#else if B4I
	Return id.ToUpperCase
#End If
End Sub

