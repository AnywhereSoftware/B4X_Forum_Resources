###  jMQTTBroker2 Extension‌ by teddybear
### 09/09/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172012/)

This is an extension to Erel's jMqttBroker2, with the base library sourced from [this thread](https://www.b4x.com/android/forum/threads/b4j-jmqttbroker-v2-added-the-onconnect-and-ondisconnect-for-broker-interceptor.167524/#content).  
This version introduces WebSocket support and multi-user capabilities, and interceptor can be enabled.  
Using interceptor makes debugging easier.  

```B4X
Sub Process_Globals  
   
End Sub  
  
Sub AppStart (Args() As String)  
    Dim brokerEx As MqttBroker2Ex  
    brokerEx.Initialize(51042)  
    brokerEx.DebugLog = True  
    brokerEx.WebsocketPort=51043  
  
    Dim users As Map = CreateMap("admin": "admin123", "user1": "user1123", "device1": "device123")  
    brokerEx.SetUsers(users)  
    'If a configuration file is specified, the broker will start according to its settings,  
    'overriding the properties mentioned above  
    'If you use a configuration file, you can enable all features of the MQTT broker, such as SSL, WSS and more.  
'    brokerEx.ConfigFile="moquette.conf"  
    brokerEx.EableInterceptor("ic", Me)  
    brokerEx.start  
   
    StartMessageLoop  
End Sub  
  
Private Sub IC_Connect (Msg As Map)  
    Log("Connect:" & Msg)  
End Sub  
  
Private Sub IC_Disconnect (Msg As Map)  
    Log("Disconnect: " & Msg)  
End Sub  
  
Private Sub IC_ConnectionLost (Msg As Map)  
    Log("ConnectionLost: " & Msg)  
End Sub  
  
Private Sub IC_Publish (Msg As Map)  
    Log("Publish: " & Msg)  
End Sub  
  
Private Sub IC_Subscribe (msg As Map)  
    Log("Subscribe: " & msg)  
End Sub  
  
Private Sub IC_Unsubscribe (msg As Map)  
    Log("Unsubscribe: " & msg)  
End Sub  
  
Private Sub IC_MessageAcknowledged (msg As Object)  
    Log("MessageAcknowledged: " & msg)  
End Sub
```

  
  
If you want to use all the features of jMqttBroker2, you can set up a configuration file. They can be found in moquette2.jar.  
  
2.1x add Interceptor support  
2.2x enable all features  
  
The example and libraries are attached