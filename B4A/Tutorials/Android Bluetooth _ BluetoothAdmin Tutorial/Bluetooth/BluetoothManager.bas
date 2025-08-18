B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
Sub Class_Globals
	Private AStream As AsyncStreams
	Private serial As Serial
	Private admin As BluetoothAdmin
	Public foundDevices As List
	Type NameAndMac (Name As String, Mac As String)
	Public BluetoothState, ConnectionState As Boolean
End Sub

Public Sub Initialize
	admin.Initialize("admin")
	serial.Initialize("serial")
	If admin.IsEnabled = False Then
		If admin.Enable = False Then
			ToastMessageShow("Error enabling Bluetooth adapter.", True)
		Else
			ToastMessageShow("Enabling Bluetooth adapter...", False)
		End If
	Else
		BluetoothState = True
	End If
End Sub

Private Sub Admin_StateChanged (NewState As Int, OldState As Int)
	Log("state changed: " & NewState)
	BluetoothState = NewState = admin.STATE_ON
	NotifyOfStateChanged
End Sub



Public Sub ConnectTo (Device As NameAndMac)
	serial.Connect(Device.Mac)
End Sub

Private Sub Serial_Connected (Success As Boolean)
	Log("connected: " & Success)
	CallSub2(Main, "AfterConnect", Success) 'allow the activity to hide the progress dialog
	ConnectionState = Success
	If Success = False Then
		Log(LastException.Message)
		ToastMessageShow("Error connecting: " & LastException.Message, True)
	Else
		If AStream.IsInitialized Then AStream.Close
		'prefix mode! Change to non-prefix mode if communicating with non-B4X device.
		AStream.InitializePrefix(serial.InputStream, False, serial.OutputStream, "astream")
		StartActivity(ChatActivity)
	End If
	NotifyOfStateChanged
End Sub

Public Sub SendMessage (msg As String)
	AStream.Write(msg.GetBytes("utf8"))
End Sub

Private Sub AStream_NewData (Buffer() As Byte)
	CallSub2(ChatActivity, "NewMessage", BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
End Sub

Private Sub AStream_Error
	ToastMessageShow("Connection is broken.", True)
	ConnectionState = False
	NotifyOfStateChanged
End Sub

Private Sub AStream_Terminated
	AStream_Error
End Sub

Public Sub Disconnect
	If AStream.IsInitialized Then AStream.Close
	serial.Disconnect
End Sub

Public Sub SearchForDevices As Boolean
	foundDevices.Initialize
	Return admin.StartDiscovery
End Sub

Private Sub Admin_DiscoveryFinished
	CallSub(Main, "DiscoverFinished")
End Sub

Private Sub Admin_DeviceFound (Name As String, MacAddress As String)
	Log(Name & ":" & MacAddress)
	Dim nm As NameAndMac
	nm.Name = Name
	nm.Mac = MacAddress
	foundDevices.Add(nm)
End Sub

Public Sub ListenForConnections
	'this intent makes the device discoverable for 300 seconds.
	Dim i As Intent
	i.Initialize("android.bluetooth.adapter.action.REQUEST_DISCOVERABLE", "")
	i.PutExtra("android.bluetooth.adapter.extra.DISCOVERABLE_DURATION", 300)
	StartActivity(i)
	serial.Listen
End Sub

Private Sub NotifyOfStateChanged
	For Each Target In Array(Main, ChatActivity)
		CallSub(Target, "UpdateState")
	Next
End Sub