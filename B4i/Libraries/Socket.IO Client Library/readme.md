### Socket.IO Client Library by Biswajit
### 05/15/2022
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/117619/)

Here is the Socket.IO Client library wrap for this [Github Project](https://github.com/socketio/socket.io-client-swift).  
[Click here](https://www.b4x.com/android/forum/threads/socket-io-client-library.117638/) for the B4A wrapper  
  
**iSocketIOClient  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.4  
**Dependency:** iRandomAccessFile  

- **iSocketIOClient**
*SocketIOClient library wrapper for b4i.*

- **Events:**

- **Ack** (data As String)
- **CustomUserEvents** (data As List, ack As Object)
- **OnConnect** (data As List)
- **OnConnecting** (data As List)
- **OnDisconnect** (data As List)
- **OnError** (data As List)
- **OnReconnectAttempt** (data As List)
- **OnReconnecting** (data As List)

- **Functions:**

- **AddListener** (forEvent As String, callbackSub As String) As String
*Add custom event listener. It will return an UUID. Use that UUID to remove this particular listener.  
 <b>Example:</b> <code>socket.AddListener("serverevent","appevent")</code>*- **Connect** (host As String, namespace As String, params As Map, secure As Boolean, server\_version As Int)
*Connect SocketIO to the server  
 For default namespace pass null  
 Pass server\_version 2 if you use socket.io v2 on the server. For socket.io v3 or later send 3  
<b>Example:</b> <code>socket.connect("<http://172.0.0.1:999/>",null,null,false)</code>  
 Other parameters will have default value as followings:  
 <b>reconnection</b> = True  
 <b>reconnectionAttempts</b> = Infinite  
 <b>reconnectionDelay</b> = 1  
 <b>reconnectionDelayMax</b> = 10  
 <b>timeout</b> = 30*- **ConnectWithOptions** (host As String, namespace As String, params As Map, secure As Boolean, reconnection As Boolean, reconnectionAttempts As Int, reconnectionDelay As Int, reconnectionDelayMax As Int, timeout As Int, server\_version As Int)
*Connect SocketIO to the server with custom options  
 For default namespace pass null  
 Pass server\_version 2 if you use socket.io v2 on the server. For socket.io v3 or later send 3  
<b>Example:</b> <code>socket.connect("<http://172.0.0.1:999/>",null,CreateMap("test":"data"),false, true, 5,1,10,30) </code>*- **DebugLog** (enable As Boolean)
*Turn on debug log. Must be called before connecting. If you are already connected call disconnect then connect again.*- **Disconnect**
*Disconnect SocketIO  
 On successful disconnection it will raise 'OnDisconnect' event*- **EmitBinary** (event As String, data As Object)
*Same as EmitString but used to send object. Usually used to forward an object to another device.  
 <b>NOTE:</b> Internally it use the B4XSerializor to serialize the object.  
 <b>Example:</b> <code>socket.EmitBinary("serverevent",anyObject)</code>*- **EmitString** (event As String, data As Object)
*Sends a message to the server, requesting an ack.  
 <b>NOTE:</b> It is upto the server send an ack back, just calling this method does not mean the server will acknowledge.  
 <b>Example:</b> <code>socket.EmitString("serverevent","something")</code>  
 <b>Getting Acknowledgment from server</b><code>  
 Sub serverevent\_Ack(data As String)  
 Log(data)  
 End Sub</code>*- **Initialize** (EventName As String)
*Initializes the Socket.io object*- **IsInitialized** As Boolean
*Tests whether this object was initialized.*- **RemoveAllListener** (forEvent As String)
*Remove all event listeners for given eventname  
 <b>Example:</b> <code>socket.RemoveAllListener("serverevent")</code>*- **RemoveListener** (listenerUUID As String)
*Remove a particular event listener  
 <b>Example:</b> <code>socket.RemoveListener("uuid\_received\_from\_AddListener")</code>*- **SendAck** (ack As Object, data As String)
*Call to acknowledge receiving an event.*
  
**Installation:**  

1. Copy XML file to B4I additional library folder.
2. Copy .framework, .h and .a files to Libs folder of the local build server

**Example Attached.**  
For the server code you can check [Socket.IO Github example](https://github.com/socketio/socket.io/blob/master/examples/chat/index.js) or you can use this following chat server example (written in javascript) [attached]:  
  

```B4X
const express = require("express");  
const app = express();  
const { createServer } = require("http");  
const { Server } = require("socket.io");  
var users = {};  
  
// *** FOR SECURE CONNECTION *** //  
  
// const fs = require('fs');  
// var options = {  
//   key: fs.readFileSync('./key.pem'),  
//   cert: fs.readFileSync('./cert.pem'),  
//   passphrase: "password of cert/key file"  
// };  
  
// const httpServer = createServer(options, app);  
  
// *** FOR NON-SECURE CONNECTION *** //  
const httpServer = createServer(app);  
  
const io = new Server(httpServer,{allowEIO3: true});  
  
io.on("connection", (socket) => {  
    console.log("User Connected.");  
  
    socket.on('user_msg', function(data,callback){  
        io.emit('new_message', data);  
        callback("Data Received");  
    });  
  
    socket.on('disconnect', function(data){  
        console.log('User disconnected. Reason: ' + data);  
    });  
  
    socket.on('error',function(er){  
        console.log(er);  
    });  
});  
  
httpServer.listen(5555, function(){  
  console.log('listening on *:5555');  
});
```

  
  
**To run this example server code:**  

1. Download **NodeJS**.
2. Install it.
3. Download library zip file and extract.
4. Run **cmd** inside **server** folder
5. Run **npm install**
6. It will take some time to complete.
7. After that run **node app.js**
8. It will show ***listening on \*:5555***
9. Now create you app and connect.
10. ***That's it!***

**Update v1.01:**  

1. Added **ConnectParams** method for sending additional GET parameters.

**Update v1.30:**  

1. *Completely rewritten from scratch (though the methods are almost the same)*
2. Support binary transfer.

1. Any object you send from B4I will only be accessible from B4I directly.
2. For B4A, use B4XSerializer in B4A to convert the received object buffer to object.
3. You cannot access the object from the server.

3. Add multiple listeners to a particular event
4. Remove all listeners for a particular event or one by one
5. Now you can send multiple parameters from the server and receive them as a list.

**Update v1.40:**   

1. Based on the latest working version.
2. Connection methods' signatures have been changed. Check above.
3. This version is compatible with Socket.io server v2, v3, v4.
4. Now you have to pass the server version while connecting to the server.

1. For v2.x.x pass 2
2. For v3.x.x and later pass 3

5. Socket.io server v1 is no longer supported. Those who want to use v1 download the older wrapper and frameworks.
6. **Consider this as the last update because** [**Objective-C is no longer supported.**](https://nuclearace.github.io/Socket.IO-Client-Swift/15to16.html)

**[[SIZE=5]Download all the files from here[/SIZE]](https://drive.google.com/file/d/1-vAfHtKf35ElV_mQvKT5OgstG-1bhPCJ/view?usp=sharing)**  
  
**Download previous version** [**from here**](https://drive.google.com/file/d/1GLAT1bazKAN3pkiJapV3VGyn1VCEi_Nr/view?usp=sharing)