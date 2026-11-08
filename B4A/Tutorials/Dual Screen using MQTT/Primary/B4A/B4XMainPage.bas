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
	Public connected As Boolean
	Private Root As B4XView
	Private xui As XUI
	Private serializator As B4XSerializator
	Private server As ServerSocket 'ignore
	Private broker As MqttBroker
	Private client As MqttClient
	Private clientId As String
	Private serverIP As String
	Private host As String = "127.0.0.1"
	Private port As Int = 51041
	Private Started As Boolean
	Private devices As List
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private const TOPIC_ALL As String = "all"
	Private const TOPIC_CONNECT As String = "all/connect"
	Private const TOPIC_DISCONNECT As String = "all/disconnect"
	Private const TOPIC_PRIMARY As String = "all/primary"
	Private const TOPIC_SECONDARY As String = "all/secondary"
	'Private const TOPIC_USERS As String = "all/users"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Cashier")
	B4XPages.SetTitle(Me, "Primary (Cashier)")
	broker.Initialize("", port)
	broker.DebugLog = True
	devices.Initialize
	serverIP = server.GetMyWifiIP
	Label1.Text = $"IP: ${serverIP}"$
	StartBroker
	StartClient
End Sub

Private Sub BtnProduct1_Click
	SendMessageToSecondary("Product A			10.00")
End Sub

Private Sub BtnProduct2_Click
	SendMessageToSecondary("Product B			299.50")
End Sub

Public Sub StartBroker
	If Not(Started) Then
		broker.Start
		Started = True
	End If
End Sub

Public Sub StartClient
	If connected Then client.Close
	clientId = "primary" & Rnd(1, 10000000)
	client.Initialize("client", $"tcp://${host}:${port}"$, clientId)
	Dim mo As MqttConnectOptions
	mo.Initialize("", "")
	'this message will be sent if the client is disconnected unexpectedly.
	mo.SetLastWill(TOPIC_DISCONNECT, Data(clientId), 0, False)
	client.Connect2(mo)
End Sub

Public Sub Data (Text As String) As Byte()
	Return serializator.ConvertObjectToBytes(Text)
End Sub

Private Sub CreateMessage (Body As String) As Byte()
	Dim m As Message
	m.Initialize
	m.Body = Body
	m.From = "Primary"
	Return serializator.ConvertObjectToBytes(m)
End Sub

Public Sub SendMessageToAll (Body As String)
	If connected Then
		client.Publish2(TOPIC_ALL, CreateMessage(Body), 0, False)
	End If
End Sub

Public Sub SendMessageToSecondary (Body As String)
	If connected Then
		'client.Publish(TOPIC_SECONDARY, Body.GetBytes("UTF8"))
		client.Publish2(TOPIC_SECONDARY, CreateMessage(Body), 0, False)
	End If
End Sub

Public Sub Disconnect
	If connected Then client.Close
End Sub

Public Sub ShowMessage (Message1 As Message)
	Label1.Text = Message1.Body
End Sub

'Public Sub ShowUsers '(Users1 As List)
'	'users = Users1
'	Dim strMessage As String
'	For Each device As String In devices
'		strMessage = $"${device} is connected"$
'		ToastMessageShow(strMessage, True)
'		Label2.Text = strMessage
'	Next
'End Sub

Private Sub client_Connected (Success As Boolean)
	Log($"Connected: ${Success}"$)
	If Success Then
		connected = True
		'B4XPages.ShowPage("ChatPage")
		client.Subscribe(TOPIC_ALL & "/#", 0)
		'client.Publish2(TOPIC_CONNECT, Data(clientId), 0, False)
	Else
		Log(LastException.Message)
		ToastMessageShow("Error connecting: " & LastException, True)
	End If
End Sub

Private Sub client_Disconnected
	connected = False
	broker.Stop
	Started = False
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	Select Topic
		Case TOPIC_CONNECT	' New client has connected
			Dim User As String = receivedObject
			Log($"${Topic}: ${User}"$)
			If devices.IndexOf(User) = -1 Then devices.Add(User)
			'ShowUsers
			Dim strMessage As String = $"${User} is connected"$
			ToastMessageShow(strMessage, True)
			Label2.Text = strMessage
			'client.Publish2(TOPIC_USERS, serializator.ConvertObjectToBytes(users), 0, False)
			Dim msg As String = $"Connected to ${clientId} at IP: ${serverIP}"$
			client.Publish2(TOPIC_PRIMARY, Data(msg), 0, False)
			'ToastMessageShow($"${User} is connected"$, True)
		Case TOPIC_DISCONNECT	' A client has disconnected
			Dim User As String = receivedObject
			Log($"${Topic}: ${User}"$)
			If devices.IndexOf(User) >= 0 Then devices.RemoveAt(devices.IndexOf(User))
			'ShowUsers
			Dim strMessage As String = $"${User} is disconnected"$
			ToastMessageShow(strMessage, True)
			Label2.Text = strMessage
			'client.Publish2(TOPIC_USERS, serializator.ConvertObjectToBytes(users), 0, False)			
			'ToastMessageShow($"${User} disconnected"$, True)
		'Case TOPIC_USERS
		'	Dim UsersList As List = receivedObject
		'	ShowUsers(UsersList)
		Case TOPIC_PRIMARY
			' ignore
		Case TOPIC_SECONDARY
			' ignore		
		Case Else
			Log(Topic)
			Dim m As Message = receivedObject
			ShowMessage(m)
	End Select
End Sub