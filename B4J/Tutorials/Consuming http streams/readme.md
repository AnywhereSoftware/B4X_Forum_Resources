### Consuming http streams by Erel
### 11/22/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/111542/)

Standard http communication is made of a request being sent from the client to the server and the server response sent back to the client.  
As I'm sure you know you should use OkHttpUtils2 for such requests.  
  
There are other protocols such as WebSockets that allow bi-directional and long lasting communication between the client and server.  
  
There are some cases where the server keeps the connection open and streams data to the client. Assuming that WebSockets are not used then such cases require non-standard handling.  
  
The attached MJPEG class uses a custom OutputStream (implemented with inline Java) together with B4XBytesBuilder to read the data as it comes and keep the connection open.  
It is a port of [this decoder](https://www.b4x.com/android/forum/threads/b4x-class-mjpeg-decoder.73702/#content), which was implemented with raw sockets and AsyncStreams.  
The Data\_Available event is raised whenever new data is available.  
  
Note that this code can be easily ported to B4A.  
  
If making many connections at the same time then it is better to move OkHttpClient out of the class and reuse it.  
  
![](https://www.b4x.com/basic4android/images/java_7NSX9XANRZ.png)