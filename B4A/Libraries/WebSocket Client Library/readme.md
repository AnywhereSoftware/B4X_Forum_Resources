### WebSocket Client Library by Erel
### 04/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/40221/)

This library allows you to create WebSocket connections with servers that support WebSockets.  
It is based on this open source project: <http://autobahn.ws/android/#>  
  
The main benefit of this library is that you can use it to communicate with [B4J WebApp solutions](http://www.b4x.com/android/forum/threads/39811/#content).  
  
The attached example includes a class named WebSocketHandler. With this class you can send events to the server and the server can send events to the device.  
  
![](https://www.b4x.com/android/forum/attachments/24449)  
  
The server code is very simple:  

```B4X
Sub Class_Globals  
   Private ws As WebSocket  
   Private timer1 As Timer  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Private Sub WebSocket_Connected (WebSocket1 As WebSocket)  
   ws = WebSocket1  
   timer1.Initialize("timer1", 1000)  
   timer1.Enabled = True  
End Sub  
  
Sub Timer1_Tick  
'This method will raise the event on the device  
   ws.RunFunction("ServerTime", Array As Object(DateTime.Time(DateTime.Now)))  
   ws.Flush  
End Sub  
  
'event from the device  
Sub Device_Message(Params As Map)  
   Log("Device message: " & Params.Get("message"))  
End Sub  
  
Private Sub WebSocket_Disconnected  
   timer1.Enabled = False  
   Log("disconnected")  
End Sub
```

  
  
**Sending events to the server**  
  
WebSocketHandler.SendEventToServer takes the event name (not prefix in this case) and the data. The data is a Map that is converted to a JSON string. Note that the event name must include an underscore.  
  

```B4X
Sub btnSend_Click  
   Dim data As Map  
   data.Initialize  
   data.Put("message", EditText1.Text)  
   wsh.SendEventToServer("Device_Message", data)  
End Sub
```

  
  
**Receiving events from the server**  
  

```B4X
Sub wsh_ServerTime(Params As List)  
   'example of a server push message  
   lblServerTime.Text = "Server Time: " & Params.Get(0)  
End Sub
```

  
  
The sub name in this case is made of the prefix set in the Initialize method and the event name as received from the server. There should be a single parameter which is a List.  
  
**How to run this example?**  
  
You need the latest version of B4J: <http://www.b4x.com/android/b4j.html>  
Download and run the server example.  
You will need to open the firewall port (51042).  
  
Set the address in the client code to match the server address.  
  
**Updates**  
  
v2.11: New Headers Map that can be used to add headers to the upgrade request (<https://www.b4x.com/android/forum/threads/websocketclient-authorization.116574/#post-729213>)  
v2.10: New BinaryMessage event and SendBinary method.  
v2.01: Fixes an issue with ssl disconnections that can throw the network on main thread exception.  
  
v2.00: Based on the latest version of autobahn-java: <https://github.com/crossbario/autobahn-java>  
Adds support for SSL connections (wss://) including using custom trust managers (mainly to accept self signed certificates).  
SSL support is problematic on devices prior to Android 5. To support Android 4+ devices you need to update the security provider: <https://www.b4x.com/android/forum/threads/ssl-websocket-client.88472/page-2#post-560044>