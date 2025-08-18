B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public connected As Boolean
	Private manager As BleManager2
	Private ServiceId, ReadChar, WriteChar As String
	Private messagesToSend As List
End Sub

Sub Service_Create
	manager.Initialize("manager")
	ServiceId = UUID("0001")
	ReadChar = UUID("1001")
	WriteChar = UUID("1002")
	messagesToSend.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Private Sub Manager_StateChanged (State As Int)
	If State <> manager.STATE_POWERED_ON Then
		ToastMessageShow("Please enable Bluetooth", True)
	End If
End Sub

Public Sub StartScan
	Do While manager.State <> manager.STATE_POWERED_ON
		Log("waiting for Bluetooth to be available")
		Sleep(1000)		
	Loop
	manager.Scan(Array(ServiceId))
End Sub

Private Sub Manager_DeviceFound (Name As String, DeviceId As String, AdvertisingData As Map, RSSI As Double)
	Log($"DeviceFound: ${Name}"$)
	manager.Connect2(DeviceId, False)
End Sub

Private Sub Manager_Connected (Services As List)
	Log("Connected")
	manager.SetNotify(ServiceId, ReadChar, True)
	connected = True
	CallSub2(Main, "SetState", connected)
	messagesToSend.Clear
End Sub

Private Sub Manager_DataAvailable (SId As String, Characteristics As Map)
	Dim b() As Byte = Characteristics.Get(ReadChar)
	CallSub2(Main, "NewMessage", b)
End Sub

Public Sub SendMessage(msg() As Byte)
	messagesToSend.Add(msg)
	If messagesToSend.Size = 1 Then
		manager.WriteData(ServiceId, WriteChar, msg)
	End If
End Sub

Private Sub Manager_WriteComplete (Characteristic As String, Status As Int)
	If connected = False Or messagesToSend.Size = 0 Then Return
	messagesToSend.RemoveAt(0)
	If messagesToSend.Size > 0 Then
		Try
			manager.WriteData(ServiceId, WriteChar, messagesToSend.Get(0))
		Catch
			Log(LastException)
		End Try
	End If
End Sub

Private Sub Manager_Disconnected
	connected = False
	CallSub2(Main, "SetState", False)
	StartScan
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

Private Sub UUID(id As String) As String
#if B4A
	Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"
#else if B4I
	Return id.ToUpperCase
#End If
End Sub
