### jServer (5) based on Jetty 12.1 by Erel
### 07/13/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171536/)

This is a beta version.  
  
Download link:  
<https://www.b4x.com/b4j/files/jserver5.zip>  
  
Copy the files to the internal libraries folder (keep the inner jserver folder). The files are different than jServer(4) files so both will work together.  
The library is named jServer5. It will be renamed to jServer with the next release of B4J.  
  
Java 17+ is required.  
  
There is a new optional event for WebSocket handlers:  

```B4X
'Return False to reject the upgrade request.  
Private Sub WebSocket_Upgrade (UpgradeRequest As ServletRequest) As Boolean  
    Return True  
End Sub
```

  
You can use it to create a http session and to reject upgrade requests.  
  
**WebSocket.Flush is no longer needed and the method doesn't do anything.**  
  
If you used JavaObject to access Jetty APIs then they might need to be updated. Other than that, existing projects should work with no changes.  
  
Standalone package declarations:  

```B4X
#PackagerProperty: AdditionalModuleInfoString = provides org.slf4j.spi.SLF4JServiceProvider with org.eclipse.jetty.logging.JettyLoggingServiceProvider;  
#PackagerProperty: AdditionalModuleInfoString = exports anywheresoftware.b4j.object;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.io.ssl.ALPNProcessor.Server with org.eclipse.jetty.alpn.java.server.JDK9ServerALPNProcessor;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.http.HttpFieldPreEncoder with org.eclipse.jetty.http.Http10FieldPreEncoder, org.eclipse.jetty.http.Http11FieldPreEncoder;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.util.security.CredentialProvider;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.io.ssl.ALPNProcessor.Server;  
#PackagerProperty: IncludedModules = jdk.charsets, jdk.crypto.ec  
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, www temp\build\bin\www /E
```