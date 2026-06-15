### Undertow Server (Java Web Server) by tchart
### 06/12/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171245/)

As many have mentioned in the forum Jetty 11 is becoming problematic for some of us.  
  
I have attempted twice to create a Jetty 12 version for B4J but clearly, I am not as smart as Erel.  
  
After my last failed attempt (in December 2025) I decided to pivot and am now using Undertow server.  
  
Summary;  
  
***Undertow*** *is a lightweight, high-performance **Java web server and Servlet container** originally developed by JBoss/Red Hat and now widely used as part of **WildFly** and other Java platforms.*  
  
I have wrapped this as B4J library and have been using it for about 6 months.  
  
I tried to make the API as compatible with jServer but there are some differences - and also some improvements.  
  
Help/API - <https://help.qonda.app/b4x/undertow/>  
  
Download - <https://help.qonda.app/b4x/undertow/UndertowServer.zip>  
  
**[SIZE=5]IMPORTANT NOTES[/SIZE]**  

- Due to Undertows threading model I have not been able to get debugging in B4J to work. This may be an issue for you or not. The app will run in debug mode but will not stop on breakpoints.
- Undertow 2.3.23 is the final version that supports Java 11. I have not compiled 2.4 yet as I am not using Java 17 yet - but this is a priority for me.

I am happy to put the source on GitHub if anyone is interested.