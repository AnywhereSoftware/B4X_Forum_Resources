###  MQTT Chat Room by Erel
### 11/18/2019
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/61568/)

It's time to learn how to use MQTT: <https://www.b4x.com/android/forum/threads/59471/#content>  
It is simple and powerful. In most cases MQTT is the best solution for low level networks. Low level network means a network solution that is traditionally based on ServerSocket + Socket + AsyncStreams.  
  
In this example we implement a chat room with one or more users. The MQTT broker is embedded in the Android app (jMqttBroker library). The clients are Android, iOS or desktop apps. Any number of users can join.  
  
  
![](https://www.b4x.com/android/forum/attachments/39859) ![](https://www.b4x.com/android/forum/attachments/39863)  
  
![](https://www.b4x.com/basic4android/images/SS-2015-12-21_14.40.07.png)  
  
When you start the Android app you can choose whether it will be the server. The other clients will connect to the server.  
  
The messages are serialized with B4XSerializator (RandomAccessFile library). B4XSerializator is very useful for cross platform communication.  
  
Users can join and leave the chat room. The list of users will be updated automatically.  
Note the usage of the LastWill feature. When a client is disconnected unexpectedly (and only if it is unexpectedly) the LastWill message will be sent. This allows us to remove the client from the list.  
  
The UI state is managed by StateManager (in B4A and B4i).  
It is a simple and flexible UI implemented with anchors. Note that it properly handles the soft keyboard changes.  
  
jMQTT library: <https://www.b4x.com/android/forum/threads/59472/#content>  
jMqttBroker: <https://www.b4x.com/android/forum/threads/mqttbroker.61548>  
  
Extension to this example with auto discovery: <https://www.b4x.com/android/forum/posts/480542/>