### STARTTLS - upgrading a non-tls socket to a tls socket. by Erel
### 08/19/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/133555/)

Upgrading from a non-tls connection to a tls connection only makes sense when dealing with a protocol that specifically requires it. It is much simpler and also a bit more secure to start with a TLS connection, instead of upgrading it after the connection is made.  
  
The most common case for this upgrade is SMTP in STARTTLS mode. This feature is already implemented in (i/j)Net libraries.  
  
The steps to implements the TLS upgrade are:  
1. Set a timeout to the network socket and set AsyncStreams.ContinueAfterTimeout = True.  
This timeout is needed to allow us to later stop AsyncStreams from reading the streams without closing them.  
  
Example (using AsyncStreamsText class):  

```B4X
Socket1.As(JavaObject).GetFieldJO("socket").RunMethod("setSoTimeout", Array(1000)) 'timeout of 1 second  
AST.Initialize(Me, "AST", Socket1.InputStream, Socket1.OutputStream)  
AST.astreams.ContinueAfterTimeout = True
```

  
The timeout cannot be too short as it will break the TLS handshake.  
  
2. When the connection should be upgraded:  
 - Create a SSLSocket using JavaObject.  
 - Call AsyncStreams.StopWithoutClosingStreams  
 - Call Sleep with a duration larger than the socket timeout.  
 - Start the handshake.  
  
3. Create a new AsyncStreams with the new streams.  
  
In order to test it I've wrote a draft of a SMTP client. It is attached.  
  
It depends on jRandomAccessFile v2.34+: <https://www.b4x.com/android/forum/threads/updates-to-internal-libaries.48274/post-844245>  
  
![](https://www.b4x.com/android/forum/attachments/1629300282873-png.117971/)