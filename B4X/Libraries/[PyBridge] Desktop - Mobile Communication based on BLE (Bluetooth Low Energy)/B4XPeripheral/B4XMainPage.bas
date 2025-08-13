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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XPeripheral.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	#if B4A
	Private manager As BleManager2
	Private peripheral As BlePeripheral2
	#else if B4i
	Private peripheral As PeripheralManager
	#End If
	Private connectedCentrals As Map
	Private NotAvailable As Boolean 'ignore
	Private btnSend As B4XView
	Private txtMessage As B4XFloatTextField
	Private txtLogs As B4XView
	Private ProgressDialog As B4XProgressDialog
	Private Toast As BCToast
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	#if B4A
	Wait For (GetBluetoothPermissions) Complete (Success As Boolean)
	If Success = False Then
		MsgboxAsync("No permission to start bluetooth", "")
		Return
	End If
	manager.Initialize("manager")
	#else if B4i
	peripheral.Initialize("peripheral")
	If Root.Width = 0 Then
		Wait For B4XPage_Resize (Width As Int, Height As Int)
	End If
	#End If
	connectedCentrals.Initialize
	ProgressDialog.Initialize(Root)
	Toast.Initialize(Root)
	SetState(False)
End Sub

#if B4A
Private Sub GetBluetoothPermissions As ResumableSub
	Dim Permissions As List
	Dim phone As Phone
	Private rp As RuntimePermissions
	If phone.SdkVersion >= 31 Then
		'note that android.permission.BLUETOOTH_SCAN is required for central BLE.
		Permissions = Array("android.permission.BLUETOOTH_ADVERTISE", "android.permission.BLUETOOTH_CONNECT", rp.PERMISSION_ACCESS_FINE_LOCATION)
	Else
		Permissions = Array(rp.PERMISSION_ACCESS_FINE_LOCATION)
	End If
	For Each per As String In Permissions
		rp.CheckAndRequest(per)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			Toast.Show("No permission: " & Permission)
			Return False
		End If
	Next
	Return True
End Sub

Private Sub Manager_StateChanged (State As Int)
	If State <> manager.STATE_POWERED_ON Then
		Toast.Show("Please enable Bluetooth")
		NotAvailable = True
	Else
		peripheral.Initialize("peripheral", manager)
		If peripheral.IsPeripheralSupported = False Then
			Toast.Show("Peripheral mode not supported.")
			NotAvailable = True
		Else
			peripheral.Start("B4APeripheral")
			Wait For Peripheral_Start (Success As Boolean)
			Log("Peripheral started successfully? " & Success)
		End If
	End If
	SetState(False)
End Sub

Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	txtLogs.Height = NewHeight - 2dip - txtLogs.Top	
End Sub
#else if B4i
Sub Peripheral_StateChanged (State As Int)
	If State <> peripheral.STATE_POWERED_ON Then
		ProgressDialog.Hide
		Toast.Show("Bluetooth is not enabled")
	Else
		peripheral.Start("B4iPeripheral")
		SetState(False)
	End If
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	txtLogs.SetLayoutAnimated(0, txtLogs.Left, txtLogs.Top, txtLogs.Width, _
		txtLogs.As(View).CalcRelativeKeyboardHeight(Height) - 2dip)
End Sub

#end if


Sub Peripheral_Subscribe (CentralId As String)
	connectedCentrals.Put(CentralId, "")
	Log("Connected: " & connectedCentrals)
	SetState(True)
End Sub

Sub Peripheral_Unsubscribe(CentralId As String)
	connectedCentrals.Remove(CentralId)
	Dim connected As Boolean = connectedCentrals.Size > 0
	SetState(connected)
End Sub

#if B4i
Sub Peripheral_NewData (Data() As Byte)
#else if B4A
Sub Peripheral_NewData (DeviceId As String, Data() As Byte)
#End If
	NewMessage(Data)
End Sub

Public Sub NewMessage(msg() As Byte)
	txtLogs.Text = BytesToString(msg, 0, msg.Length, "utf8") & CRLF & txtLogs.Text
End Sub

Sub SendMessage (msg() As Byte)
	peripheral.Write(Null, msg)
End Sub

Sub SetState (Connected As Boolean)
	btnSend.Enabled = Connected
	txtMessage.TextField.Enabled = Connected
	If Connected Then
		ProgressDialog.Hide
	Else If NotAvailable = False Then
		ProgressDialog.ShowDialog("Waiting for connections...")
	End If
End Sub

Sub IME_HandleAction As Boolean
	btnSend_Click
	Return True 'don't close the keyboard
End Sub

Sub btnSend_Click
	If txtMessage.Text.Length = 0 Then Return
	Dim s As String = "Peripheral: " & txtMessage.Text
	SendMessage(s.GetBytes("utf8"))
	NewMessage(s.GetBytes("utf8"))
	txtMessage.RequestFocusAndShowKeyboard
	txtMessage.TextField.SelectAll
End Sub

Private Sub txtMessage_EnterPressed
	btnSend_Click
End Sub