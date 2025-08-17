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
	Private Broker As MqttBroker
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Broker.Initialize("broker", 51042)
	Dim server As JavaObject = Broker.As(JavaObject).GetField("server")
	Dim pck As String = GetType(Me) & "$MyHandler"
	Dim handler As JavaObject
	handler.InitializeNewInstance(pck, Array(Me))
	Dim handlers As List = Array(handler)
	server.RunMethod("startServer", Array(Broker.As(JavaObject).GetField("config"), handlers))
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
		BA.Log("msg"+msg);
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

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub