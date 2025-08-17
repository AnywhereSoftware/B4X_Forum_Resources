###  jMQTT - Official MQTT client by Erel
### 04/15/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/59472/)

Implementation of MQTT client based on the Paho open source project: <http://www.eclipse.org/paho/>  
  
See this tutorial for more information: <https://www.b4x.com/android/forum/threads/iot-mqtt-protocol.59471/>  
  
jMQTT v1.26 is compatible with B4J and B4A (older versions weren't compatible with B4A).  
  
Instructions for jMQTT v1.25:  
[spoiler]  
If building a standalone package then add this to the main module:  

```B4X
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.paho.client.mqttv3.spi.NetworkModuleFactory with org.eclipse.paho.client.mqttv3.internal.TCPNetworkModuleFactory, org.eclipse.paho.client.mqttv3.internal.SSLNetworkModuleFactory,  org.eclipse.paho.client.mqttv3.internal.websocket.WebSocketNetworkModuleFactory, org.eclipse.paho.client.mqttv3.internal.websocket.WebSocketSecureNetworkModuleFactory;
```

  
[/spoiler]