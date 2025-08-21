Type=StaticCode
Version=3.96
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@

Sub Process_Globals
	Private client As MqttClient
	Private const port As Int = 51042
	Private serializator As B4XSerializator
	Public connected As Boolean
	Private fx As JFX
	Private currentName As String
End Sub



Public Sub ConnectTo(Host As String, Name As String)
	Disconnect
	currentName = Name
	client.Initialize("client", $"tcp://${Host}:${port}"$, "desktop" & Rnd(1, 10000000))
	Dim mo As MqttConnectOptions
	mo.Initialize("", "")
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
		fx.Msgbox(Main.MainForm, "Error connecting: " & LastException, "")
	End If
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	If Topic = "all/connect" Or Topic = "all/disconnect" Then
		'new client has connected or disconnected
		'do nothing. The server will handle it.
	Else if Topic = "all/users" Then
		Dim newUsers As List = receivedObject
		Main.NewUsers(newUsers)
	Else
		Dim m As Message = receivedObject
		Main.NewMessage(m)
	End If
		
End Sub

Public Sub SendMessage(Body As String)
	If connected Then
		client.Publish2("all", CreateMessage(Body), 0, False)
	End If
End Sub

Public Sub Disconnect
	If connected Then 
		connected = False
		client.Publish2("all/disconnect", serializator.ConvertObjectToBytes(currentName), 0, False)
		client.Close
	End If
End Sub

Private Sub CreateMessage(Body As String) As Byte()
	Dim m As Message
	m.Initialize
	m.Body = Body
	m.From = currentName
	Return serializator.ConvertObjectToBytes(m)
End Sub

Private Sub client_Disconnected
	If connected Then
		fx.Msgbox(Main.MainForm, "Disconnected", "")
	End If
	connected = False
End Sub


Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
