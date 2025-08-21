###  Network + AsyncStreams + B4XSerializator by Erel
### 06/30/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/72149/)

**Better implementation, based on B4XPages: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-network-asyncstreams-b4xserializator.119011/#content>**  
  
New video tutorial:  
  
[MEDIA=vimeo]256762156[/MEDIA]  
  
  
  
  
![](https://www.b4x.com/basic4android/images/SS-2016-10-19_15.32.02.jpg)  
  
  
![](https://www.b4x.com/basic4android/images/SS-2017-07-11_10.53.45.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2017-07-11_11.03.32.png)  
  
  
This is a simple and important example. It demonstrates several good practices related to network communication.  
  
1. The network related code is in the Starter service. The network state is also stored in the starter service.  
2. The Activity is only responsible for the UI.  
3. Using B4XSerializator it is simple to work with types instead of strings or bytes. In this case the message structure is:  

```B4X
Type MyMessage (Name As String, Age As Int, Image() As Byte)
```

  
- Bitmaps cannot be directly serialized so we need to convert the bitmap to bytes and vice versa.  
- B4XSerializator is cross platform compatible. This means that you can send the exact same structure to B4J or B4i applications.  
  
**Platform specific notes**  
  
- The code in B4J and B4i is a bit simpler as there is no need to use a second module (starter module). All modules are always active in B4J and B4i.  
- In B4i we need to recreate the server socket when the application becomes active as the socket can become stale while the app is in the background (and not killed).  
- Windows firewall blocks incoming connections so if you want to connect to the B4J app, you need to first allow incoming communication on the relevant port.