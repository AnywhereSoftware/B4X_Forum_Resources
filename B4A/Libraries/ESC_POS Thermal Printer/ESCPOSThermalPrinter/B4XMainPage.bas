B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private admin As BluetoothAdmin
	Private serial As Serial
	Private AnotherProgressBar1 As AnotherProgressBar
	Private mB4XPrinter As B4XPrinter
	Type NameAndMac (Name As String, Mac As String)
	Public BluetoothState, ConnectionState As Boolean
	Private rp As RuntimePermissions
	Private btnAllowConnection As B4XView
	Private CLV As CustomListView
	Private phone As Phone
	Private ion As Object
	Private btnSearchForDevices As B4XView
	
	Private nName As String 
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	admin.Initialize("admin")
	serial.Initialize("serial")
	mB4XPrinter.Initialize
'
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	AnotherProgressBar1.Tag = 1
	B4XPages.AddPageAndCreate("ESC printer", mB4XPrinter)
	StartBluetooth
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub StartBluetooth
	If admin.IsEnabled = False Then
		Wait For (EnableBluetooth) Complete (Success As Boolean)
		If Success = False Then
			ToastMessageShow("Impossibile abilitare il Bluetooth", True)
		End If
	End If
	BluetoothState = admin.IsEnabled
'	StateChanged
End Sub

Private Sub EnableBluetooth As ResumableSub
	ToastMessageShow("Abilitazione dell'adattatore Bluetooth...", False)
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
'	StateChanged
End Sub


Sub btnSearchForDevices_Click
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False And rp.Check(rp.PERMISSION_ACCESS_COARSE_LOCATION) = False Then
		ToastMessageShow("Nessun permesso...", False)
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
		ToastMessageShow("Errore durante l'avvio del processo di rilevamento.", True)
	Else
		CLV.Clear
		Dim Index As Int = ShowProgress
		Wait For Admin_DiscoveryFinished
		HideProgress(Index)
		If CLV.Size = 0 Then
			ToastMessageShow("Nessun dispositivo trovato.", True)
		End If
	End If
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



Private Sub btnAllowConnection_Click
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


Private Sub StateChanged
	btnSearchForDevices.Enabled = BluetoothState
	btnAllowConnection.Enabled = BluetoothState
	'ChatPage1.btnSend.Enabled = ConnectionState
End Sub

Sub CLV_ItemClick (Index As Int, Value As Object)
	Dim nm As NameAndMac = Value
	ToastMessageShow($"Tentativo di connessione a: ${nm.Name}"$, True)
	serial.Connect(nm.Mac)
	Dim Index As Int = ShowProgress
	Wait For Serial_Connected (Success As Boolean)
	HideProgress(Index)
	If Success = False Then
		Log(LastException.Message)
		ToastMessageShow("Error connecting: " & LastException.Message, True)
	Else
		nName = nm.Name
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

Sub AfterSuccessfulConnection()
	
	ConnectionState = True
	B4XPages.ShowPage("ESC printer")
	mB4XPrinter.LabDevice.Text = nName
End Sub

Public Sub Disconnect
	serial.Disconnect
End Sub

Private Sub Admin_DeviceFound (Name As String, MacAddress As String)
	Log(Name & ":" & MacAddress)
	Dim nm As NameAndMac = CreateNameAndMac(Name, MacAddress)
	CLV.AddTextItem($"${nm.Name}: ${nm.Mac}"$, nm)
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