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
	Private socket As ServerSocket 'ignore
	Private broker As MqttBroker
	Private client As MqttClient
	Private clientType As String = "Primary"
	Private clientId As String
	Private serverIP As String
	Private host As String = "127.0.0.1"
	Private port As Int = 51041
	Private connected As Boolean
	Private Started As Boolean
	Private devices As List
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private toast As BCToast
	Private const TOPIC_ALL As String = "all/#"
	Private const TOPIC_PING As String = "all/ping"
	Private const TOPIC_CONNECT As String = "all/connect"
	Private const TOPIC_DISCONNECT As String = "all/disconnect"
	Private const TOPIC_PRIMARY As String = "all/primary"
	Private const TOPIC_SECONDARY As String = "all/secondary"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Cashier")
	toast.Initialize(Root)
	devices.Initialize
	broker.Initialize("", port)
	broker.DebugLog = True
	#If B4J
	serverIP = socket.GetMyIP
	#Else
	serverIP = socket.GetMyWifiIP
	#End If
	B4XPages.SetTitle(Me, clientType & " (Cashier) IP: " & serverIP)
	Label1.Text = $"IP: ${serverIP}"$
	StartBroker
	StartClient
End Sub

Private Sub BtnProduct1_Click
	SendMessage(TOPIC_SECONDARY, "Add Product", CreateProduct("01", "Apple", 1.00))
End Sub

Private Sub BtnProduct2_Click
	SendMessage(TOPIC_SECONDARY, "Add Product", CreateProduct("02", "Milk", 10.00))
End Sub

Private Sub BtnClear_Click
	SendMessage(TOPIC_SECONDARY, "Clear Products", Null)
End Sub

Public Sub StartBroker
	If Not(Started) Then
		'broker.Start
		Dim server As JavaObject = broker.As(JavaObject).GetField("server")
		Dim pck As String = GetType(Me) & "$MyHandler"
		Dim handler As JavaObject
		handler.InitializeNewInstance(pck, Array(Me))
		Dim handlers As List = Array(handler)
		server.RunMethod("startServer", Array(broker.As(JavaObject).GetField("config"), handlers))
		Started = True
	End If
End Sub

Public Sub StartClient
	If connected Then client.Close
	clientId = clientType & Rnd(1, 10000000)
	client.Initialize("client", $"tcp://${host}:${port}"$, clientId)
	Dim mo As MqttConnectOptions
	mo.Initialize("", "")
	Dim Msg As Message = CreateMessage(clientType, $"Disconnected from ${clientId}"$, Null)
	Dim Data() As Byte = serializator.ConvertObjectToBytes(Msg)
	'This message will be sent if the client is disconnected unexpectedly.
	mo.SetLastWill(TOPIC_DISCONNECT, Data, 0, False)
	client.Connect2(mo)
End Sub

Private Sub CreateMessage (From As String, Action As String, Payload As Object) As Message
	Dim t1 As Message
	t1.Initialize
	t1.From = From
	t1.Action = Action
	t1.Payload = Payload
	Return t1
End Sub

Public Sub CreateProduct (Code As String, Name As String, Price As Double) As Product
	Dim t1 As Product
	t1.Initialize
	t1.Code = Code
	t1.Name = Name
	t1.Price = Price
	Return t1
End Sub

Public Sub SendMessage (Topic As String, MessageType As String, Payload As Object)
	If connected Then
		Dim Msg As Message = CreateMessage(clientType, MessageType, Payload)
		Dim Data() As Byte = serializator.ConvertObjectToBytes(Msg)
		client.Publish2(Topic, Data, 0, False)
	End If
End Sub

Public Sub Disconnect
	If connected Then client.Close
End Sub

Public Sub ShowMessage (Message1 As Message)
	Label1.Text = Message1.Action
End Sub

Private Sub client_Connected (Success As Boolean)
	Log($"Connected: ${Success}"$)
	If Success Then
		connected = True
		client.Subscribe(TOPIC_ALL, 0)
	Else
		Log(LastException.Message)
		toast.Show("Error connecting: " & LastException)
	End If
End Sub

Private Sub client_Disconnected
	connected = False
	broker.Stop
	Started = False
End Sub

Private Sub client_MessageArrived (Topic As String, Payload() As Byte)
	If Topic = TOPIC_PING Then Return
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	Select Topic
		Case TOPIC_CONNECT	' New client has connected
			Dim User As String = receivedObject
			Log($"${Topic}: ${User}"$)
			If devices.IndexOf(User) = -1 Then devices.Add(User)
			Dim strMessage As String = $"${User} is connected"$
			toast.Show(strMessage)
			Label2.Text = strMessage
			Dim Msg As Message = CreateMessage(clientType, $"Connected to ${clientId} at IP: ${serverIP}"$, Null)
			Dim Data() As Byte = serializator.ConvertObjectToBytes(Msg)
			client.Publish2(TOPIC_PRIMARY, Data, 0, False)
		Case TOPIC_DISCONNECT	' A client has disconnected
			Dim User As String = receivedObject
			Log($"${Topic}: ${User}"$)
			If devices.IndexOf(User) >= 0 Then devices.RemoveAt(devices.IndexOf(User))
			Dim strMessage As String = $"${User} is disconnected"$
			toast.Show(strMessage)
			Label2.Text = strMessage
		Case Else
			'Log(Topic)
			toast.Show(Topic)
			Dim Msg As Message = receivedObject
			ShowMessage(Msg)
	End Select
End Sub

Private Sub Broker_Connect (Msg As Object)
    Log("Connect: " & Msg)
End Sub

Private Sub Broker_Disconnect (Msg As Object)
    Log("Disconnect: " & Msg)
End Sub

Private Sub Broker_ConnectionLost (Msg As Object)
    Log("ConnectionLost: " & Msg)
End Sub
Private Sub Broker_Publish (msg As Object)
    Log("Publish: " & msg)
End Sub
Private Sub Broker_Subscribe (msg As Object)
    Log("Subscribe: " & msg)
End Sub
Private Sub Broker_Unsubscribe (msg As Object)
    Log("Unsubscribe: " & msg)
End Sub
Private Sub Broker_MessageAcknowledged (msg As Object)
    Log("MessageAcknowledged: " & msg)
End Sub

#if Java
import io.moquette.interception.messages.*;
public static class MyHandler implements io.moquette.interception.InterceptHandler {
    BA ba;
    public MyHandler(B4AClass parent) {
        this.ba = parent.getBA();
    }
     public String getID() {
        return "handler";
    }

    public Class<?>[] getInterceptedMessageTypes() {return ALL_MESSAGE_TYPES;}

    public void onConnect(InterceptConnectMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_connect", msg);
    }

    public void onDisconnect(InterceptDisconnectMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_disconnect", msg);
    }

    public void onConnectionLost(InterceptConnectionLostMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_connectionlost", msg);
    }

    public void onPublish(InterceptPublishMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_publish", msg);
    }

    public void onSubscribe(InterceptSubscribeMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_subscribe", msg);
    }

    public void onUnsubscribe(InterceptUnsubscribeMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_unsubscribe", msg);
    }

    public void onMessageAcknowledged(InterceptAcknowledgedMessage msg) {
        this.ba.raiseEventFromUI(this, "broker_messageacknowledged", msg);
    }
}
#End If