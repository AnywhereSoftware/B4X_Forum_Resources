B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BluetoothChat.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private btnSearchForDevices As B4XView
	Private btnAllowConnection As B4XView
	Private rp As RuntimePermissions
	Private AStream As AsyncStreams
	Private serial As Serial
	Private admin As BluetoothAdmin
	Type NameAndMac (Name As String, Mac As String)
	Public BluetoothState, ConnectionState As Boolean
	Private ChatPage1 As ChatPage
	Private AnotherProgressBar1 As AnotherProgressBar
	Private CLV As CustomListView
	Private phone As Phone
	Private ion As Object
End Sub

'You can add more parameters here.
Public Sub Initialize
	admin.Initialize("admin")
	serial.Initialize("serial")
	ChatPage1.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	AnotherProgressBar1.Tag = 1
	B4XPages.AddPageAndCreate("Chat Page", ChatPage1)
	StartBluetooth
End Sub


Private Sub StartBluetooth
	If admin.IsEnabled = False Then
		Wait For (EnableBluetooth) Complete (Success As Boolean)
		If Success = False Then
			ToastMessageShow("Failed to enable bluetooth", True)
		End If
	End If
	BluetoothState = admin.IsEnabled
	StateChanged
End Sub

Private Sub EnableBluetooth As ResumableSub
	ToastMessageShow("Enabling Bluetooth adapter...", False)
	Dim p As Phone
	If p.SdkVersion >= 31 Then
		rp.CheckAndRequest("android.permission.BLUETOOTH_CONNECT")
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then Return False
		If p.SdkVersion >= 33 Then
			Dim in As Intent
			in.Initialize("android.bluetooth.adapter.action.REQUEST_ENABLE", "")
			StartActivityForResult(in)
			Wait For ion_Event (MethodName As String, Args() As Object)
			Return admin.IsEnabled			
		End If
	End If
	Return admin.Enable
End Sub

Private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(ion, i))
End Sub

Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub



Private Sub Admin_StateChanged (NewState As Int, OldState As Int)
	Log("state changed: " & NewState)
	BluetoothState = NewState = admin.STATE_ON
	StateChanged
End Sub


Sub btnSearchForDevices_Click
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False And rp.Check(rp.PERMISSION_ACCESS_COARSE_LOCATION) = False Then
		ToastMessageShow("No permission...", False)
		Return
	End If
	If phone.SdkVersion >= 31 Then
		For Each Permission As String In Array("android.permission.BLUETOOTH_SCAN", "android.permission.BLUETOOTH_CONNECT")
			rp.CheckAndRequest(Permission)
			Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
			If Result = False Then
				ToastMessageShow("No permission...", False)
				Return
			End If
		Next
	End If
	Dim success As Boolean = admin.StartDiscovery
	If success = False Then
		ToastMessageShow("Error starting discovery process.", True)
	Else
		CLV.Clear
		Dim Index As Int = ShowProgress
		Wait For Admin_DiscoveryFinished
		HideProgress(Index)
		If CLV.Size = 0 Then
			ToastMessageShow("No device found.", True)
		End If
	End If
End Sub

Sub btnAllowConnection_Click
	If phone.SdkVersion >= 31 Then
		rp.CheckAndRequest("android.permission.BLUETOOTH_CONNECT")
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			ToastMessageShow("No permission...", False)
			Return
		End If
	End If
	'this intent makes the device discoverable for 300 seconds.
	Dim i As Intent
	i.Initialize("android.bluetooth.adapter.action.REQUEST_DISCOVERABLE", "")
	i.PutExtra("android.bluetooth.adapter.extra.DISCOVERABLE_DURATION", 300)
	StartActivity(i)
	serial.Listen
End Sub



Public Sub SendMessage (msg As String)
	AStream.Write(msg.GetBytes("utf8"))
End Sub

Private Sub AStream_NewData (Buffer() As Byte)
	ChatPage1.NewMessage(BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
End Sub

Private Sub AStream_Error
	ToastMessageShow("Connection is broken.", True)
	ConnectionState = False
	StateChanged
End Sub

Private Sub AStream_Terminated
	AStream_Error
End Sub

Public Sub Disconnect
	If AStream.IsInitialized Then AStream.Close
	serial.Disconnect
End Sub

Private Sub Admin_DeviceFound (Name As String, MacAddress As String)
	Log(Name & ":" & MacAddress)
	Dim nm As NameAndMac = CreateNameAndMac(Name, MacAddress)
	CLV.AddTextItem($"${nm.Name}: ${nm.Mac}"$, nm)
End Sub

Private Sub StateChanged
	btnSearchForDevices.Enabled = BluetoothState
	btnAllowConnection.Enabled = BluetoothState
	ChatPage1.btnSend.Enabled = ConnectionState
End Sub

Sub CLV_ItemClick (Index As Int, Value As Object)
	Dim nm As NameAndMac = Value
	ToastMessageShow($"Trying to connect to: ${nm.Name}"$, True)
	serial.Connect(nm.Mac)
	Dim Index As Int = ShowProgress
	Wait For Serial_Connected (Success As Boolean)
	HideProgress(Index)
	If Success = False Then
		Log(LastException.Message)
		ToastMessageShow("Error connecting: " & LastException.Message, True)
	Else
		AfterSuccessfulConnection
	End If
	StateChanged
End Sub

'will be called when a client connects to this device
Sub Serial_Connected (Success As Boolean)
	If Success Then
		AfterSuccessfulConnection
		StateChanged
	End If
End Sub

Sub AfterSuccessfulConnection
	If AStream.IsInitialized Then AStream.Close
	'prefix mode! Change to non-prefix mode if communicating with non-B4X device.
	AStream.InitializePrefix(serial.InputStream, False, serial.OutputStream, "astream")
	ConnectionState = True
	B4XPages.ShowPage("Chat Page")
End Sub

Sub ShowProgress As Int
	AnotherProgressBar1.Tag = AnotherProgressBar1.Tag + 1
	AnotherProgressBar1.Visible = True
	Return AnotherProgressBar1.Tag
End Sub

Sub HideProgress (Index As Int)
	If Index = AnotherProgressBar1.Tag Then
		AnotherProgressBar1.Visible = False
	End If
End Sub

Public Sub CreateNameAndMac (Name As String, Mac As String) As NameAndMac
	Dim t1 As NameAndMac
	t1.Initialize
	t1.Name = Name
	t1.Mac = Mac
	Return t1
End Sub

Private Sub B4XPage_Appear
	CLV.Clear
End Sub