### jWebSocketClient library by Erel
### 12/04/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/40985/)

**Note:** this library depends on jetty\_b4j.jar, which is included in jServer3.zip: <https://www.b4x.com/android/forum/threads/jserver3.141323/#content>  
  
With this library you can implement WebSocket clients. The API is identical to the B4A library: <http://www.b4x.com/android/forum/threads/websocket-client-library.40221/#content> (except of the object name which is WebSocketClient).  
  
It is based on Jetty WebSocket client implementation.  
  
The push client example was ported to B4J: <http://www.b4x.com/android/forum/threads/custom-websocket-based-push-framework.40272/>  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-14_12.44.33.png)  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-14_12.47.54.png)  
  
![](https://www.b4x.com/android/forum/attachments/24996)  
  
This means that you can now implement an (almost) always connected solution with bi-directional communication running on Androids, desktops and browsers.  
  
This is an internal library.  
  
Updates:  
v1.13 - New SendTextAsync and SendBinaryAsync methods. Do not use SendText / SendBinary. By mistake they are sending the messages on the main thread which can lead to bad things. The old methods are kept for backward compatibility.