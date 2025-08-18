###  Trust all SSL Socket by Erel
### 04/21/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/101952/)

Platforms: B4J (1st post) and B4A (2nd post)  
  
This code creates an SSL socket that doesn't verify the server certificate.  
  
Depends on jNet / Net and JavaObject libraries.  
  

```B4X
Private Sub CreateTrustAllSSLSocket (EventName As String) As Socket  
   Dim socket As Socket  
   socket.Initialize(EventName)  
   Dim jo As JavaObject = socket  
   jo.SetField("socket", CreateTrustAllSSLSocketFactory.RunMethod("createSocket", Null))  
   Return socket  
End Sub  
  
Sub CreateTrustAllSSLSocketFactory As JavaObject  
   Dim tm As CustomTrustManager  
   tm.InitializeAcceptAll  
   Dim SSLContext As JavaObject  
   SSLContext = SSLContext.InitializeStatic("javax.net.ssl.SSLContext").RunMethod("getInstance", Array("TLS"))  
   SSLContext.RunMethod("init", Array(Null, tm, Null))  
   Dim Factory As JavaObject = SSLContext.RunMethod("getSocketFactory", Null)  
   Return Factory  
End Sub
```

  
  
Usage:  

```B4X
Dim sock As Socket = CreateTrustAllSSLSocket("sock")
```

  
  
If you are building a standalone package then add this:  

```B4X
#PackagerProperty: VMArgs = –add-opens java.base/sun.security.ssl=b4j
```