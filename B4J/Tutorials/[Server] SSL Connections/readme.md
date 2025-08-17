### [Server] SSL Connections by Erel
### 03/13/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/40130/)

Starting from B4J v2.00 the server can listen to two ports, the standard insecure port (http) and a secure port (https).  
  
The default port for http is 80 and for https is 443. These ports are used when the url doesn't explicitly specify a port number.  
  
It is recommended to go over the Wikipedia article to learn more about HTTPS: <http://en.wikipedia.org/wiki/HTTP_Secure>  
  
SSL connections require some configuration. First you need a keystore file that stores the public and private keys. You can either purchase a key from a certificate authority or create one yourself. In the later case the browser will show a warning as the certificate cannot be verified.  
  
These instructions explain how to create a key: <https://jetty.org/docs/jetty/12/operations-guide/keystore/index.html>  
  
The server configuration is done with SslConfiguration object. This code should be called before the server is stared.  

```B4X
Private Sub ConfigureSSL (SslPort As Int)  
   'example of SSL connector configuration  
   Dim ssl As SslConfiguration  
   ssl.Initialize  
   ssl.SetKeyStorePath(File.DirApp, "test2.keystore") 'path to keystore file  
   ssl.KeyStorePassword = "123456"  
   ssl.KeyManagerPassword = "654321"  
   srvr.SetSslConfiguration(ssl, SslPort)  
   'add filter to redirect all traffic from http to https (optional)  
   srvr.AddFilter("/*", "HttpsFilter", False)  
End Sub
```

  
We need to create a SslConfiguration object and set the path and passwords of the keystore file.  
Then we call Server.SetSslConfiguration with the configuration object and the https port we want to listen to.  
  
  
We can use a Filter class to redirect all http traffic to https:  

```B4X
'Return True to allow the request to proceed.  
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean  
   If req.Secure Then  
     Return True  
   Else  
     resp.SendRedirect(req.FullRequestURI.Replace("http:", "https:") _  
       .Replace(Main.srvr.Port, Main.srvr.SslPort))  
     Return False  
   End If  
End Sub
```

  
This code checks whether the request is a secure request. If not it redirects the request to the https port and sets the scheme to https.  
  
Note that trying to connect with http to the https port or with https to the http port will result with an error.  
  
Filters do not apply to web sockets. You can use WebSocket.Secure to make sure that a secure connection has been made (this will be the case if the current request is a https request, unless someone has tampered the JavaScript code).