### [server] listen to an additional http port by Erel
### 02/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/159255/)

```B4X
Private Sub AddHttpPort(port As Int)  
    Dim server As JavaObject = srvr.As(JavaObject).GetField("server")  
    Dim Connector As JavaObject  
    Connector.InitializeNewInstance("org.eclipse.jetty.server.ServerConnector", Array(server))  
    Connector.RunMethod("setPort", Array(port))  
    server.RunMethod("addConnector", Array(Connector))  
End Sub
```

  
  
Call it before calling srvr.Start.  
Depends on JavaObject.