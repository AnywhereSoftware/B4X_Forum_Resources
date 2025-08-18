###  MQTT - Connect & Reconnect by Erel
### 09/27/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/80815/)

The **ConnectAndReconnect** sub takes care of connecting to the broker and reconnecting if the connection has broken.  
It sends a "ping" request every 5 seconds to help the MQTT client recognize network failures.  
  
It is a nice example of how Wait For and Sleep can help to manage the network state which is completely asynchronous.  
The ConnectAndReconnect sub will keep running until you set the *working* variable to False.  
  

```B4X
Sub ConnectAndReconnect  
   Do While working  
     If mqtt.IsInitialized Then mqtt.Close  
       Do While mqtt.IsInitialized  
            Sleep(100)  
        Loop  
     mqtt.Initialize("mqtt", "ssl://io.adafruit.com:8883", "B4X" & Rnd(0, 999999999))  
     Dim mo As MqttConnectOptions  
     mo.Initialize(username, password)  
     Log("Trying to connect")  
     mqtt.Connect2(mo)  
     Wait For Mqtt_Connected (Success As Boolean)  
     If Success Then  
       Log("Mqtt connected")  
       Do While working And mqtt.Connected  
         mqtt.Publish2("ping", Array As Byte(0), 1, False) 'change the ping topic as needed  
         Sleep(5000)  
       Loop  
       Log("Disconnected")  
     Else  
       Log("Error connecting.")  
     End If  
     Sleep(5000)  
   Loop  
End Sub
```

  
  
In B4A it is recommended to put it in the starter service:  

```B4X
Sub Process_Globals  
   Private working As Boolean = True  
   Private mqtt As MqttClient  
End Sub  
  
Sub Service_Create  
   working = True  
   ConnectAndReconnect  
End Sub
```

  
  
It is recommended to use B4XPages and call it from B4XPage\_Created.  
  
  
Set *working* to False before you close the connection.  
Make sure to only call this code once.  
  
This code is compatible with B4A, B4i and B4J.