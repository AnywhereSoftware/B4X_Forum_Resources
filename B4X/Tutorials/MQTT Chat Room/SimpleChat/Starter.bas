B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Private broker As MqttBroker
	Private client As MqttClient
	Private const port As Int = 51042
	Private serializator As B4XSerializator
	Public connected As Boolean
	Private brokerStarted As Boolean
	Private users As List
	Public isServer As Boolean
	Private currentName As String
End Sub

Sub Service_Create
	broker.Initialize("", port)
	broker.DebugLog = False
	users.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public Sub ConnectTo(Host As String, Name As String)
	currentName = Name
	isServer = Host = "127.0.0.1"
	If isServer Then
		If brokerStarted = False Then
			broker.Start
			brokerStarted = True
		End If
		users.Clear
		Host = "127.0.0.1"
	End If
	If connected Then client.Close
	client.Initialize("client", $"tcp://${Host}:${port}"$, "android" & Rnd(1, 10000000))
	Dim mo As MqttConnectOptions
	mo.Initialize("", "")
	'this message will be sent if the client is disconnected unexpectedly.
	mo.SetLastWill("all/disconnect", serializator.ConvertObjectToBytes(currentName), 0, False)
	client.Connect2(mo)
End Sub

Private Sub client_Connected (Success As Boolean)
	Log($"Connected: ${Success}"$)
	If Success Then
		connected = True
		client.Subscribe("all/#", 0)
		client.Publish2("all/connect", serializator.ConvertObjectToBytes(currentName), 0, False)
	Else
		ToastMessageShow("Error connecting: " & LastException, True)
	End If
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	If Topic = "all/connect" Or Topic = "all/disconnect" Then
		'new client has connected or disconnected
		Dim newUser As String = receivedObject
		If isServer Then
			Log($"${Topic}: ${newUser}"$)
			Dim index As Int = users.IndexOf(newUser)
			If Topic.EndsWith("connect") And index = -1 Then users.Add(newUser)
			If Topic.EndsWith("disconnect") And index >= 0 Then users.RemoveAt(index)
			client.Publish2("all/users", serializator.ConvertObjectToBytes(users), 0, False)
		End If
	Else if Topic = "all/users" Then
		Dim newUsers As List = receivedObject
		CallSubDelayed2(Chat, "NewUsers", newUsers) 'this will start the chat activity if it wasn't started yet.
	Else
		Dim m As Message = receivedObject
		CallSub2(Chat, "NewMessage", m)
	End If
		
End Sub

Public Sub SendMessage(Body As String)
	If connected Then
		client.Publish2("all", CreateMessage(Body), 0, False)
	End If
End Sub

Public Sub Disconnect
	If connected Then client.Close
End Sub

Private Sub CreateMessage(Body As String) As Byte()
	Dim m As Message
	m.Initialize
	m.Body = Body
	m.From = currentName
	Return serializator.ConvertObjectToBytes(m)
End Sub

Private Sub client_Disconnected
	connected = False
	If IsPaused(Chat) = False Then
		CallSub(Chat, "Disconnected")
	End If
	If isServer Then
		broker.Stop
		brokerStarted = False
	End If
End Sub


Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
