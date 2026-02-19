### jServer & jWebSocketClient using Jetty 11.0.26 by Chris2
### 02/16/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170233/)

I did this more as a learning exercise than anything else and also because I noted a later version of [jetty 11](https://jetty.org/download.html) had been released that addressed a CVE ([CVE-2025-5115](https://github.com/advisories/GHSA-mmxm-8w33-wc4h)) .  
I thought I'd post it here in case anyone is interested.  
Also, because I really didn't know what I was doing, and was largely copying the work of [USER=1]@Erel[/USER], [USER=12970]@tchart[/USER], & [USER=125673]@teddybear[/USER], I'd be grateful if someone can check what I've done here and point out any problems. Thanks.  
Credits & helpful info:  
[USER=12970]@tchart[/USER] - <https://www.b4x.com/android/forum/threads/jserver-4-keeping-jetty-up-to-date.161151/post-988986>  
[USER=1]@Erel[/USER] - <https://www.b4x.com/android/forum/threads/jwebsocketclientv2.156357/post-963635>, <https://www.b4x.com/android/forum/threads/jserver-v4-0-based-on-jetty-11.140437/>  
[USER=125673]@teddybear[/USER] - <https://www.b4x.com/android/forum/threads/jserver-11-0-20-jserver-11-0-21-packaging-error.162092/post-994492>,  
  
A version of jServer based on [Jetty 11.0.26](https://jetty.org/download.html) is available to download from [here](https://drive.google.com/file/d/1e0ZnQAAM9wCTgaoWy0kfBxMX71UAvSCi/view?usp=sharing) (too big for forum attachment), and attached is a version of the jWebSocketClient library that uses that jServer-11.0.26.  
jServer-11.0.26 is based on [jServer 4.03](https://www.b4x.com/android/forum/threads/jserver-v4-0-based-on-jetty-11.140437/page-2#post-889892)  
jWebSocketClient-11.0.26 is based on [jWebSocketClient V2](https://www.b4x.com/android/forum/threads/jwebsocketclientv2.156357/post-963635)  
  
To install:  
**jServer-11.0.26**  
Download the zip file from [here](https://drive.google.com/file/d/1e0ZnQAAM9wCTgaoWy0kfBxMX71UAvSCi/view?usp=sharing), and extract the contents into the internal libraries folder. You should then have *jServer-11.0.26.jar*, *jServer-11.0.26.xml*, and the folder *jserver-11.0.26* which contains 37 jar files.  
Refresh your libraries in B4J. The new version should appear as jServer-11.0.26.  
  
As per [USER=1]@Erel[/USER]'s original jServer v4.0 post, the following declarations are needed for the standalone packager:  

```B4X
#PackagerProperty: AdditionalModuleInfoString = provides org.slf4j.spi.SLF4JServiceProvider with org.eclipse.jetty.logging.JettyLoggingServiceProvider;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.io.ssl.ALPNProcessor.Server with org.eclipse.jetty.alpn.java.server.JDK9ServerALPNProcessor;  
#PackagerProperty: AdditionalModuleInfoString = provides org.eclipse.jetty.http.HttpFieldPreEncoder with org.eclipse.jetty.http2.hpack.HpackFieldPreEncoder, org.eclipse.jetty.http.Http1FieldPreEncoder;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.util.security.CredentialProvider;  
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.io.ssl.ALPNProcessor.Server;  
#PackagerProperty: IncludedModules = jdk.charsets, jdk.crypto.ec, java.sql, java.instrument, java.xml, java.security.jgss, java.rmi, java.naming, java.management, java.desktop
```

  
[note the extra IncludedModules based on [USER=125673]@teddybear[/USER]'s & [USER=12970]@tchart[/USER]'s [help](https://www.b4x.com/android/forum/threads/jserver-11-0-20-jserver-11-0-21-packaging-error.162092/post-994492)]  
  
**jWebSocketClient-11.0.26:**   
Copy the contents of the attached zip (jWebScocketClient-11.0.26.zip containing *jWebSocketClient-11.0.26.jar* & *jWebSocketClient-11.0.26.xml*) to the internal libraries folder.  
Refresh your libraries in B4J. The new version should appear as jWebScocketClient-11.0.26.  
  
As per [USER=1]@Erel[/USER]'s post above in order to build a standalone package you need:  

```B4X
#AdditionalJar: jserver-11.0.26/jetty-webapp-11.0.26.jar  
#PackagerProperty: AdditionalModuleInfoString = provides org.slf4j.spi.SLF4JServiceProvider with org.eclipse.jetty.logging.JettyLoggingServiceProvider;  
#PackagerProperty: IncludedModules = java.desktop, jdk.charsets, jdk.crypto.ec
```

  
[note the addition of java.desktop in the IncludedModules]  
  
[EDIT: I have found that some apps using the jWebScocketClient-11.0.26 library need extra IncludedModules. I suggest that anyone encountering java.lang.ClassNotFoundException errors when using these libraries follow [@Daestrum's instructions here](https://www.b4x.com/android/forum/threads/solved-missing-java-class-in-a-packaged-exe.118705/post-742706) to determine which modules need to be added]  
  
[SPOILER="What I did:"]  
**jServer-11.0.26**  
1. Copied the jar/xml from jServer 4.03, and renamed to jServer-11.0.26.jar & jServer-11.0.26.xml.  
  
2. Downloaded Jetty 11.0.26, created a folder called jserver-11.0.26 in the B4J internal libraries folder and copied the required files from jetty 11.0.26 into the jserver-11.0.26 folder.  
[NOTE: the downloaded Jetty 11.0.26 file contained many more jar files than in the existing jserver folders; I copied across only the new equivalents of the jar files that existed in the original jserver folder - I presume the others are not needed (perhaps someone can confirm this?)]  
  
3. Amended the jServer-11.0.26.xml file sections <version> to 11.26, & each <dependsOn> to use the jServer 11.0.26 files in a folder named *jserver-11.0.26*.  
  
4. Removed the module info (module-info.class) from these jars:  
jetty-io-11.0.26.jar,  
jetty-alpn-java-server-11.0.26.jar,  
http2-server-11.0.26.jar,  
http2-hpack-11.0.26.jar,  
http2-common-11.0.26.jar,  
jetty-alpn-server-11.0.26.jar.  
  
5. Added the IncludedModules as described above  
  
After this, my server app runs OK through the IDE and building a standalone package goes through without any errors too.  
  
  
**jWebSocketClient-11.0.26**  
1. Copied the existing library files (jWebSocketClient.jar & jWebSocketClient.xml) and renamed them with '-11.0.26' appended to the file name - *jWebSocketClient-11.0.26.jar & jWebSocketClient-11.0.26.xm*l).  
  
2. Ammended the jWebSocketClient-11.0.26.xml file sections <version> to 11.26, & each <dependsOn> to use the jServer 11.0.26 files in a folder named *jserver-11.0.26*.  
  
3. In app main module changed the existing dependency to  

```B4X
#AdditionalJar: jserver-11.0.26/jetty-webapp-11.0.26.jar
```

  
and added the IncludedModules declaration described in [USER=1]@Erel[/USER]'s post linked above.  
  
At this point the app ran OK but building a stand-alone package generated an error:  
> Exception in thread "main" java.lang.module.FindException: Module org.slf4j not found, required by org.eclipse.jetty.util

  
4. Based on [USER=125673]@teddybear[/USER]'s post above, I removed the module info (module-info.class) from jetty-util-11.0.26.jar.  
  
A new error:  
> Exception in thread "main" java.lang.module.FindException: Module org.slf4j not found, required by org.eclipse.jetty.websocket.core.common

  
5. Removed the module info (module-info.class) from websocket-core-common-11.0.26.jar, then ….  
> module-info.java:7: error: package javax.imageio.spi is not visible  
> uses javax.imageio.spi.ImageReaderSpi;  
>  ^  
>  (package javax.imageio.spi is declared in module java.desktop, but module b4j does not read it)  
> 1 error

6. So I added java.desktop to the #PackagerProperty: IncludedModules declaration.  
  
And now the app seems to be running and packaging successfully.  
  
[/SPOILER]