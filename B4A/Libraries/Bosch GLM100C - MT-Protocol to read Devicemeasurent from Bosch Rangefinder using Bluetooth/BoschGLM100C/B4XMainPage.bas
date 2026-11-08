B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BoschGLM-Project.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private btnSearchForDevices As B4XView
	Private btnAllowConnection As B4XView
	Private rp As RuntimePermissions
	Private admin As BluetoothAdmin
	Public BluetoothState, ConnectionState As Boolean
	Private AnotherProgressBar1 As AnotherProgressBar
	Private CLV As CustomListView
	Private phone As Phone
	Private ion As Object
	Public bosch As GLM100C
	Private scanclv As CustomListView
	Private kvs As KeyValueStore
	Private usethismac As String
End Sub

'You can add more parameters here.
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	kvs.Initialize(File.DirInternal,"kvs.dat")
	admin.Initialize("admin")
	usethismac = ""	
	bosch.Initialize("Bosch",False)
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	AnotherProgressBar1.Tag = 1
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



'Private Sub Admin_StateChanged (NewState As Int, OldState As Int)
'	Log("state changed: " & NewState)
'	BluetoothState = NewState = admin.STATE_ON
'	StateChanged
'End Sub

Sub StartDiscovery()
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
	bosch.startDiscovery
	
End Sub

Sub btnSearchForDevices_Click
	StartDiscovery
End Sub
Sub Bosch_status(value As String)
	Log($"Connectionstatus: ${value}"$)	
	If value = "Connected" Then
		'Connectionstatus: Connected
		HideProgress(AnotherProgressBar1.Tag)
	End If
End Sub
Sub Bosch_devicefound(BluetoothDevice As Object)
	Log($"Bosch-Device found: ${BluetoothDevice}"$)
	
	' The following lines regarding the MTBluetoothDevice are not needed 
	' but can be used to get the Address and Displayname of the Device
	Dim dev As MTBluetoothDevice = BluetoothDevice
	Log($"Address: ${dev.DeviceAddress}"$)
	Log($"Displayname: ${dev.DisplayName}"$)
	'Log($"Name: ${BluetoothDevice.DeviceName}"$)
	'Log($"Alias: ${BluetoothDevice.DeviceAlias}"$)
	CLV.AddTextItem($"${dev.DisplayName}: ${dev.DeviceAddress}"$, dev)
	
	If usethismac <> "" Then
		If dev.DeviceAddress = usethismac Then
			ShowProgress
			Log(bosch.connect(dev))
		End If
	End If
	' Connect to the Device in this Event. Use the Object-reference BluetoothDevice here!
End Sub
Sub Bosch_measure(value As Float)
	Log($"Bosch_measure = ${NumberFormat(value,0,5)}"$)
	scanclv.AddTextItem(NumberFormat(value,0,5),value)
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
End Sub


Private Sub StateChanged
	btnSearchForDevices.Enabled = BluetoothState
	btnAllowConnection.Enabled = BluetoothState
End Sub

Sub CLV_ItemClick (Index As Int, Value As Object)
	Dim dev As MTBluetoothDevice = Value
	kvs.Put("BoschMac",dev.DeviceAddress)
	kvs.Put("BoschName",dev.DisplayName)
	ToastMessageShow($"Trying to connect to: ${dev.DisplayName} ${dev.DeviceAddress}"$, True)
	Log(bosch.connect(Value))
	ShowProgress
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


Private Sub B4XPage_Appear
	CLV.Clear
	Log($"B4XPage_Appear.bosch.ConnectionState: ${bosch.ConnectionState}"$)
	Log($"B4XPage_Appear.bosch.Connected: ${bosch.Connected}"$)
	Log($"B4XPage_Appear.kvs.ContainsKey("BoschMac"): ${kvs.ContainsKey("BoschMac")}"$)
	Log($"B4XPage_Appear.kvs.ContainsKey("BoschName"): ${kvs.ContainsKey("BoschName")}"$)
	
	If (bosch.ConnectionState = 12 Or bosch.ConnectionState = 0) And bosch.Connected = False And kvs.ContainsKey("BoschMac") And kvs.ContainsKey("BoschName") Then
		usethismac = kvs.Get("BoschMac")
		Log($"B4XPage_Appear.usethismac: ${usethismac} Starting Discovery"$)
		StartDiscovery
	End If
End Sub