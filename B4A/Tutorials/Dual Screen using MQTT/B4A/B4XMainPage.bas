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
	Private client As MqttClient
	Private clientId As String
	Private host As String = "192.168.50.91"
	Private const port As Int = 51041
	Private LblText As B4XView
	Private Label2 As B4XView
	'Private const TOPIC_ALL As String = "all"
	Private const TOPIC_CONNECT As String = "all/connect"
	Private const TOPIC_DISCONNECT As String = "all/disconnect"
	Private const TOPIC_PRIMARY As String = "all/primary"
	Private const TOPIC_SECONDARY As String = "all/secondary"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Display")
	B4XPages.SetTitle(Me, "Secondary (Customer)")
	StartClient
End Sub

Public Sub StartClient
	If connected Then client.Close
	clientId = "secondary" & Rnd(1, 10000000)
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

'Private Sub CreateMessage (Body As String) As Byte()
'	Dim m As Message
'	m.Initialize
'	m.Body = Body
'	m.From = "Secondary"
'	Return serializator.ConvertObjectToBytes(m)
'End Sub

'Public Sub SendMessageToAll (Body As String)
'	If connected Then
'		client.Publish2(TOPIC_ALL, CreateMessage(Body), 0, False)
'	End If
'End Sub

'Public Sub SendMessageToSecondary (Body As String)
'	If connected Then
'		'client.Publish(TOPIC_SECONDARY, Body.GetBytes("UTF8"))
'		client.Publish2(TOPIC_SECONDARY, CreateMessage(Body), 0, False)
'	End If
'End Sub

'Public Sub SendMessageToPrimary (Body As String)
'	If connected Then
'		'client.Publish(TOPIC_SECONDARY, Body.GetBytes("UTF8"))
'		client.Publish2(TOPIC_PRIMARY, CreateMessage(Body), 0, False)
'	End If
'End Sub

Public Sub Disconnect
	If connected Then client.Close
End Sub

Public Sub ShowMessage (Message1 As Message)
	LblText.Text = LblText.Text & CRLF & Message1.Body
End Sub

Public Sub ShowStatus (Message2 As String)
	Label2.Text = Message2
End Sub

Private Sub client_Connected (Success As Boolean)
	Log($"Connected: ${Success}"$)
	If Success Then
		connected = True
		'client.Subscribe(TOPIC_ALL & "/#", 0)
		'client.Subscribe(TOPIC_CONNECT, 0)
		'client.Subscribe(TOPIC_DISCONNECT, 0)
		client.Subscribe(TOPIC_PRIMARY, 0)
		client.Subscribe(TOPIC_SECONDARY, 0)
		'client.Publish2(TOPIC_CONNECT, Data("Primary"), 0, False)
		client.Publish2(TOPIC_CONNECT, Data(clientId), 0, False)
	Else
		Log(LastException.Message)
		ToastMessageShow("Error connecting: " & LastException, True)
	End If
End Sub

Private Sub client_Disconnected
	connected = False
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	Select Topic
		Case TOPIC_PRIMARY
			Dim s As String = receivedObject
			ShowStatus(s)
		Case TOPIC_SECONDARY
			Dim m As Message = receivedObject
			ShowMessage(m)
	End Select
End Sub