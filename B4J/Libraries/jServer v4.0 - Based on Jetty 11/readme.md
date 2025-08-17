### jServer v4.0 - Based on Jetty 11 by Erel
### 07/22/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/140437/)

**Starting from B4J v9.80 this library is included as an internal library.** Old library: <https://www.b4x.com/android/forum/threads/141323/#content>  
This is a new version of jServer. It is based on Jetty 11.0.9. Previous versions were based on an early version of Jetty 9.  
There were many improvements in Jetty during the last couple of years: <https://github.com/eclipse/jetty.project/releases>  
  
It requires Java 11+.  
It works with the standalone packager with these declarations:  

```B4X
#PackagerProperty: AdditionalModuleInfoString = provides org.slf4j.spi.SLF4JServiceProvider with org.eclipse.jetty.logging.JettyLoggingServiceProvider;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.io.ssl.ALPNProcessor.Server with org.eclipse.jetty.alpn.java.server.JDK9ServerALPNProcessor;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.http.HttpFieldPreEncoder with org.eclipse.jetty.http2.hpack.HpackFieldPreEncoder, org.eclipse.jetty.http.Http1FieldPreEncoder;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.util.security.CredentialProvider;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.io.ssl.ALPNProcessor.Server;  
#PackagerProperty: IncludedModules = jdk.charsets, jdk.crypto.ec  
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, www temp\build\bin\www /E
```

  
  
Note that http sessions are not created automatically for WebSockets. You can use this filter handler to create it: <https://www.b4x.com/android/forum/threads/safari-session-variables-in-b4j-v4.61652/post-389898> (apparently it relied on a feature not supported by WebSocket specs).  
  
b4j\_ws.js v0.93 is attached. It includes a fix suggested by [USER=974]@alwaysbusy[/USER]: <https://www.b4x.com/android/forum/threads/jserver-v4-0-based-on-jetty-11.140437/post-889892>  
  
Updates:  
- v4.03 - suppresses the stack trace logs for ClosedChannelExceptions, which can happen sporadically on disconnections.