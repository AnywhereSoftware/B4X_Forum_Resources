### Localhost ServerSocket without triggering Windows Firewall popup by Erel
### 02/04/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165431/)

Depends on jNetwork v1.21+ (<https://www.b4x.com/android/forum/threads/updates-to-internal-libaries.48274/post-1014241>)  
  

```B4X
Private Sub InitializeWithLoopback(Server As ServerSocket, EventName As String, vPort As Int)  
    Server.Initialize(-1, EventName)  
    Dim ia As JavaObject  
    ia = ia.InitializeStatic("java.net.InetAddress").RunMethod("getLoopbackAddress", Null)  
    Dim s As JavaObject = Server  
    Dim socket As JavaObject  
    socket.InitializeNewInstance("java.net.ServerSocket", Array(vPort, 50, ia))  
    s.SetField("ssocket", socket)  
End Sub
```

  
  
Usage example:  

```B4X
Dim srvr As ServerSocket  
InitializeWithLoopback(srvr, "srvr", 12345)
```

  
  
The socket will only accept connections from the current computer, useful for communication with other processes. No annoying firewall dialog will appear.