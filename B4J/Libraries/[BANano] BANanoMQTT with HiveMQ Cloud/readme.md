### [BANano] BANanoMQTT with HiveMQ Cloud by Mashiane
### 04/04/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166439/)

Hi Fam  
  
Ensure you create credentials to login to your HiveMQ account.  
  
You get your **TSL WebSocket URL** which is like..  
  

```B4X
104bbaaaa07a4293456e659cf91023.s1.eu.hivemq.cloud:8884/mqtt
```

  
  
**Split these into various variables (done for brevity)**  
  

```B4X
"MQTTPort": 8884,  
    "MQTTUser": "ssssss",  
    "MQTTPwd": "sssss",  
    "MQTTHost": "104bbaaaa07a4293456e659cf91023.s1.eu.hivemq.cloud:",  
    "MQTTPath": "/mqtt"
```

  
  
**Code to connect**  
  

```B4X
Sub StartMQTT  
    MQTTConnected = False  
    MQTTConnect  
End Sub
```

  
  
**Code to Connect to HiveMQ**  
  

```B4X
Sub MQTTConnect  
    Log("MQTT - ConnectAndReconnect…")  
    MQTTWorking = True  
    MQTTTimer.Initialize("MQTTTimer", 5000) ' Timer checks every 5 seconds  
    MQTTTimer.Enabled = True  
  
    mqtt.Initialize("mqtt", MQTTHost, MQTTPort, MQTTPath, True, MQTTClientID)  
    Dim ops As BANanoMQTTConnectOptions  
    ops.Initialize(MQTTUser, MQTTPwd)  
    ops.CleanSession = False  
    ops.As(BANanoObject).SetField("keepAliveInterval", 60)  
'    ops.SetLastWill("connected", "N".GetBytes("UTF8"), 0, False)  
    mqtt.Connect2(ops)  
End Sub
```

  
  
**Code to fire when Connected (Still testing the ping stuff)**  
  

```B4X
Sub mqtt_Connected (Success As Boolean)  
    If Success Then  
        Log("Client: Mqtt connected")  
        MQTTConnected = True ' Mark the connection as established  
        MQTTTimer.Enabled = False ' Disable the timer once connected  
         
  
        mqtt.Subscribe("xxxx/#", 2)  
         
        ' Start periodic ping while connected  
        Do While MQTTWorking And MQTTConnected  
            mqtt.Publish2("ping", "A".GetBytes("UTF-8"), 2, False)  
            Sleep(60000) ' Ping every 1 minute  
        Loop  
    Else  
        MQTTPublish("connected", "N")  
        Log("Client: Could not connect to MQTT broker!")  
        MQTTConnected = False  
        MQTTTimer.Enabled = True  
        Log(LastException.message)  
    End If  
End Sub
```

  
  
**Timer That Fires when a disconnection event happens**  
  

```B4X
' Timer event for periodic checks  
Sub MQTTTimer_Tick  
    If Not(MQTTConnected) Then  
        Log("MQTT disconnected, attempting to reconnect…")  
        ' Attempt to reconnect  
        MQTTConnect  
    End If  
End Sub
```

  
  
**Code to Fire when disconnected**  
  

```B4X
private Sub mqtt_Disconnected  
    MQTTConnected = False  
    MQTTTimer.Enabled = True  
    Try  
        conversations.Offline  
'        App.ShowToastSuccess("Disconnected to MQTT Broker!")  
    Catch  
    End Try                'ignore  
End Sub
```

  
  
**Trapping Arriving Messages**  
  

```B4X
Private Sub mqtt_MessageArrived (Topic As String, Payload() As Byte)  
    Log("Client: mqtt_MessageArrived")  
    Log($"Topic: ${Topic}"$)  
     
    'ignore topics comings to myself  
    If Topic = MQTTTopic1 Then Return  
    'continue processing  
    Dim msg As String = BytesToString(Payload, 0, Payload.Length, "utf8")  
     
    If Topic.StartsWith("chats") Then  
        DoWhatEver  
    End If  
…..
```