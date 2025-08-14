B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private serializator As B4XSerializator
	Private client As MqttClient
	Private clientId As String
	Private clientType As String = "Secondary"
	Private host As String = "192.168.50.42"
	Private port As Int = 51041
	Private connected As Boolean
	Private working As Boolean
	Private LblText As B4XView
	Private LblTotal As B4XView
	Private LblStatus As B4XView
	'Private const TOPIC_ALL As String = "all/#"
	Private const TOPIC_PING As String = "all/ping"
	Private const TOPIC_CONNECT As String = "all/connect"
	Private const TOPIC_DISCONNECT As String = "all/disconnect"
	Private const TOPIC_PRIMARY As String = "all/primary"
	Private const TOPIC_SECONDARY As String = "all/secondary"
	Private BtnWorking As B4XView
	Private toast As BCToast
	Private total As Double
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Display")
	B4XPages.SetTitle(Me, clientType & " (Customer)")
	clientId = clientType & Rnd(1, 10000000)
	toast.Initialize(Root)
	'BtnWorking_Click ' immediate start
End Sub

Private Sub BtnWorking_Click
	working = Not(working)
	BtnWorking.Text = "Working = " & IIf(working, "True", "False")
	If working Then
		ConnectAndReconnect
	Else 
		Disconnect
	End If
End Sub

Public Sub Data (Text As String) As Byte()
	Return serializator.ConvertObjectToBytes(Text)
End Sub

Sub ConnectAndReconnect
	Do While working
		If client.IsInitialized Then client.Close
		Do While client.IsInitialized
			Sleep(100)
		Loop
		toast.Show("Trying to connect")
		client.Initialize("client", $"tcp://${host}:${port}"$, clientId)
		Dim mo As MqttConnectOptions
		mo.Initialize("", "")
		mo.SetLastWill(TOPIC_DISCONNECT, Data(clientId), 0, False)
		client.Connect2(mo)
		'Log("Trying to connect")
		
		Wait For client_Connected (Success As Boolean)
		If Success Then
			toast.Show("Connected")
			SubscribeTopics
			Do While working And client.Connected
				If connected = False Then
					client.Publish2(TOPIC_CONNECT, Data(clientId), 0, False)
					connected = True
				End If
				client.Publish2(TOPIC_PING, Array As Byte(0), 1, False) 'change the ping topic as needed
				Sleep(5000)
				' Continuous pinging
			Loop
			toast.Show("Disconnected")
		Else
			toast.Show("Error connecting.")
		End If
		LblStatus.Text = "Waiting for primary device..."
		Sleep(5000)
		' Wait 5 seconds before reconnect
	Loop
End Sub

Public Sub Disconnect
	'working = False
	'If client.Connected Then client.Publish2(TOPIC_DISCONNECT, Data(clientId), 0, False)
	UnsubscribeTopics
End Sub

Public Sub ShowMessage (Message1 As Message)
	Select Message1.Action
		Case "Clear Products"
			total = 0
			LblText.Text = ""
			LblTotal.Text = "$0.00"
		Case "Add Product"
			Dim Product1 As Product = Message1.Payload
			total = total + Product1.Price
			LblText.Text = LblText.Text & CRLF & Product1.Name & TAB & TAB & Product1.Price
			LblTotal.Text = "$" & NumberFormat2(total, 1, 2, 2, True)
		Case Else
			Log(Message1)
	End Select
End Sub

Public Sub ShowStatus (Message2 As String)
	LblStatus.Text = Message2
End Sub

Sub SubscribeTopics
	client.Subscribe(TOPIC_PRIMARY, 0)
	client.Subscribe(TOPIC_SECONDARY, 0)
	client.Publish2(TOPIC_CONNECT, Data(clientId), 0, False)
	'subscribed = True
End Sub

Sub UnsubscribeTopics
	If connected Then
		client.Unsubscribe(TOPIC_PRIMARY)
		client.UnSubscribe(TOPIC_SECONDARY)
		client.Publish2(TOPIC_DISCONNECT, Data(clientId), 0, False)
		client.Close
	End If
	'connected = False
	'subscribed = False
	working = False
	LblStatus.Text = "Waiting for primary device..."
End Sub

Private Sub client_Disconnected
	connected = False
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	Select Topic
		Case TOPIC_PRIMARY
			Dim Msg As Message = receivedObject
			ShowStatus(Msg.Action)
		Case TOPIC_SECONDARY
			Dim m As Message = receivedObject
			ShowMessage(m)
	End Select
End Sub