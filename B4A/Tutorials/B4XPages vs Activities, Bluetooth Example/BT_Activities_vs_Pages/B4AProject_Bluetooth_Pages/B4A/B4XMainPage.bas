B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

Sub Class_Globals
	Private rp As RuntimePermissions
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore

	Private btnSearchForDevices As B4XView
	Private btnAllowConnection As B4XView

	Public BTManager As BluetoothManager ' public for ChatPage access
	Private ChatPage1 As ChatPage
	Private AnotherProgressBar1 As AnotherProgressBar
	Private CLV As CustomListView
End Sub

Public Sub Initialize
	BTManager.Initialize(Me)
	ChatPage1.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	AnotherProgressBar1.Tag = 1
	B4XPages.AddPageAndCreate("Chat Page", ChatPage1)
End Sub

Private Sub B4XPage_Appear
	CLV.Clear
End Sub

Sub btnSearchForDevices_Click
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		ToastMessageShow("No permission...", False)
		Return
	End If
	Dim success As Boolean = BTManager.SearchForDevices
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
	BTManager.ListenForConnections
End Sub

Public Sub SendMessage (msg As String)
	BTManager.SendMessage(msg)
End Sub

Public Sub ConnectionState As Boolean
	Return BTManager.ConnectionState
End Sub

Public Sub Disconnect
	BTManager.Disconnect
End Sub

Private Sub NewMessage (msg As String)
	ChatPage1.NewMessage(msg)
End Sub

Public Sub UpdateState
	StateChanged
	For Each nm As NameAndMac In BTManager.foundDevices
		CLV.AddTextItem($"${nm.Name}: ${nm.Mac}"$, nm)
	Next
End Sub

Private Sub StateChanged
	btnSearchForDevices.Enabled = BTManager.BluetoothState
	btnAllowConnection.Enabled = BTManager.BluetoothState
	ChatPage1.btnSend.Enabled = BTManager.ConnectionState
End Sub

Sub CLV_ItemClick (Index As Int, Value As Object)
	Dim nm As NameAndMac = Value
	ToastMessageShow($"Trying to connect to: ${nm.Name}"$, True)
	BTManager.ConnectTo(nm)
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
Sub AfterSuccessfulConnection
	B4XPages.ShowPage("Chat Page")
	StateChanged
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
