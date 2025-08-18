### [WebApp] Web Apps Overview by Erel
### 05/30/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/39811/)

![](http://www.b4x.com/basic4android/images/SS-2014-04-10_17.09.21.png)  
  
B4J v2.00 adds support for web applications based on [WebSocket](http://en.wikipedia.org/wiki/WebSocket) technology. With WebSocket The browser and the server maintain an open communication channel.  
This channel allows us to build web apps where all (or most) of the logic is implemented in the server.  
  
The new framework is implemented in jServer library. It adds a new type of "handler" named WebSocket.  
The browser UI is implemented in html / css.  
  
**B4J Web App Goals**  

- Simple to build real-world web applications with the same libraries and similar code as done in B4J / B4A.
- Good performance.
- Very easy to extend.

**You can see several online examples here:** <https://www.b4x.com:51041>  
  
The source code of all these examples is attached to this post.  
  
**What you need to know?**  

- Server library tutorial: [[Server] Building web servers with B4J](http://www.b4x.com/android/forum/threads/37172/#content)
This tutorial was written before WebSockets were available.- Html / CSS - Required for the UI.
- (recommended) Basic knowledge of jQuery. JQuery is a JavaScript library that simplifies access to html elements. B4J WebSocket client side implementation is based on jQuery.

**Which browsers are supported?**  
  
All modern browsers support web sockets. See this table: <http://caniuse.com/websockets>  
Android is a bit late here. The Chrome browser (compatible with Android 4.0+) supports web sockets.  
  
**How to deploy?**  
  
The compiled jar file is a standard Java app. The web server is embedded in this jar.  
Any computer with Java 8+ installed can run it (including boards such as Raspberry Pi).  
Shared hosting solutions will not work as they don't support Java. VPS solutions will work.  
You can also turn a local computer into a public web server with a dynamic dns service:  
<http://www.b4x.com/android/forum/threads/server-upload-files-from-your-b4a-app-to-your-b4j-server-over-the-internet.37201/#content>  
Tip: if you are running it in linux then you should use the nohup command.  
  
**Where do I go from here?**  
  
[[WebApp] Hello World Web App](http://www.b4x.com/android/forum/threads/39808/#content)  
Other tutorials: <http://www.b4x.com/android/forum/pages/results/?query=webapp&page=1&prefix=18>  
  
The online examples project is attached.  
The full project depends on a MySQL database (and several other libraries - see post #19).  
**You can start with the NoMySQL project which doesn't depend on MySQL.**  
  
The full project depends on: [jBuilderUtils](https://www.b4x.com/android/forum/attachments/jbuilderutils-zip.41578/), [jExcel](https://www.b4x.com/android/forum/threads/jexcel-library.35004/#content), [ByteConverter](https://www.b4x.com/android/forum/threads/byteconverter-library.6787/#content) and [Encryption.](https://www.b4x.com/android/forum/threads/base64-and-encryption-library.6839/#content)  
  
Updates  
  
- b4j\_ws.js v0.92 is included in the zips. It fixes a potential issue where events are registered multiple times.