### jWebSocketClient v2 accept all certificates by Erel
### 10/25/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/157001/)

Useful when you want to make a not so secure connection to a server with self signed certificate:  

```B4X
Sub Process_Globals  
    Private MainForm As Form  
    Private xui As XUI   
    Private ws As WebSocketClient  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    ws.Initialize("ws")  
    SetAcceptAll(ws)      
    ws.Connect("wss://ws.postman-echo.com/raw")  
    Wait For ws_Connected  
    Log("connected")  
    ws.SendTextAsync("test")  
End Sub  
  
Private Sub SetAcceptAll (WebSocket As WebSocketClient)  
    Dim ssl As JavaObject  
    ssl.InitializeNewInstance("org.eclipse.jetty.util.ssl.SslContextFactory.Client", Array(True))  
    Dim ClientConnector As JavaObject  
    ClientConnector.InitializeNewInstance("org.eclipse.jetty.io.ClientConnector", Null)  
    ClientConnector.RunMethod("setSslContextFactory", Array(ssl))  
    Dim Infos As JavaObject  
    Infos.InitializeArray("org.eclipse.jetty.io.ClientConnectionFactory$Info", Array())  
    Dim HttpTransport As JavaObject  
    HttpTransport.InitializeNewInstance("org.eclipse.jetty.client.dynamic.HttpClientTransportDynamic", Array(ClientConnector, Infos))  
    Dim HttpClient As JavaObject  
    HttpClient.InitializeNewInstance("org.eclipse.jetty.client.HttpClient", Array(HttpTransport))  
    Dim jo As JavaObject = WebSocket  
    Dim wsc As JavaObject  
    wsc.InitializeNewInstance("org.eclipse.jetty.websocket.client.WebSocketClient", Array(HttpClient))  
    jo.SetField("wsc", wsc)  
End Sub  
   
Sub ws_Closed (Reason As String)  
    Log("closed: " & Reason)  
End Sub  
  
Sub ws_TextMessage (Message As String)  
    Log("message: " & Message)  
    ws.Close  
End Sub
```