### Socket.IO Client Library by Biswajit
### 06/27/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/117638/)

Hi everyone,  
  
Here is the Socket.IO Client library wrap for this [Github Project](https://github.com/socketio/socket.io-client-java).  
[Click here](https://www.b4x.com/android/forum/threads/socket-io-client-library.117619/) for the B4i wrapper  
  
**SocketIOClient  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 2.5  
**Dependency:** OkHttpUtils2  

- **SocketIOClient**
Method:

- **initialize**(EventName As String)
- **connect** (host As String, params As  String, secure As Boolean)
- **connectWithOptions**(host As String, params As  String, secure As Boolean, reconnection As Boolean, reconnectionAttempts As Long, reconnectionDelay As Long, reconnectionDelayMax As Long, timeout As Long)
- **disconnect**()
- **emit**(event As String, data As Object)
- **addEvent**(event As String, callback As String)
- **removeEvent**(event As String, callback As String)
- **sendAck**(ack As  Object, data() As  Object)

- **Events:**

- **OnConnecting:** will be raised at the first time it tries to connect to the server
- **OnConnectError**(error As Object)**:** will be raised if any error occurs when connecting
- **OnConnectionTimeout**(timeout As Object)******:****** will be raised if the connection does not receive a response from the server after approximately 30 seconds
- **OnConnect:** will be raised on successful connection
- **OnDisconnect**(reason As Object)**:** will be raised on connection disconnect. If the disconnection was initiated by the server, you need to reconnect manually else it will try itself to reconnect
- **OnReconnectAttempt**(attemptNumber As Object)**:** will be raised if it tries to reconnect after connection timeout or if connection disconnected from client side
- **OnReconnecting**(attemptNumber As Object)**:** will be raised on reconnection attempt
- **OnReconnect**(attemptNumber As Object)**:** will be raised on successful connection after connection timeout or if connection disconnected from client side
- **OnReconnectError**(error As Object)**:** will be raised if any error occurs when reconnecting
- **OnReconnectFailed:** will be raised if when couldn’t reconnect within reconnectionAttempts
- **OnError**(error As Object)**:** will be raised if any error occurs

  
**Example Attached.**  
For the server code you can check [Socket.IO Github example](https://github.com/socketio/socket.io/blob/master/examples/chat/index.js) or you can use this following chat server example (written in javascript) [attached]:  
  
[PHP]  
var express = require('express');  
var app = express();  
  
// \*\*\* FOR HTTPS CONNECTION \*\*\* //  
// const fs = require('fs');  
  
// var options = {  
// key: fs.readFileSync('./key.pem'),  
// cert: fs.readFileSync('./cert.pem'),  
// passphrase: "password of cert/key file"  
// };  
  
// var server = require('https').createServer(options, app);  
// \*\*\* FOR HTTPS CONNECTION \*\*\* //  
  
  
// \*\*\* FOR HTTP CONNECTION \*\*\* //  
var server = require('http').Server(app);  
// \*\*\* FOR HTTP CONNECTION \*\*\* //  
  
var io = require('socket.io')(server);  
var users = {};  
  
  
server.listen(999, function(){  
 console.log('listening on \*:999');  
});  
  
io.sockets.on('connection', function(socket){  
 console.log("User Connected");  
  
 socket.on('user\_msg', function(data,callback){  
 io.emit('new\_message', data);  
 callback("Data Received");  
 });  
  
 socket.on('disconnect', function(data){  
 console.log('User disconnected');  
 });  
});  
[/PHP]  
  
**To run this example server code:**  

1. Download **NodeJS**.
2. Install it.
3. Download library zip file and extract.
4. Run **cmd** inside **server** folder
5. Run **npm install**
6. It will take some time to complete.
7. After that run **node app.js**
8. It will show ***listening on \*:999***
9. Now create you app and connect.
10. ***That's it!***
11. If you want to use **HTTPS** (secure connection) then for testing you can generate **key** and **cert** file using **openssl**
Eg: openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
**Update v2:**  

1. Now you can declare this in process\_globals
2. Some event signature has been modified (please check above)
3. New event added **OnError**

**Update v2.1:**  

1. Conflict with B4A OkHttpUtils2 library (Fixed)

**Update v2.2:**  

1. Added support for a secure connection.

**Update v2.3:**  

1. Now you can detect data delivery via an acknowledgment of the emit event (**Check Attached Example**).

**Update v2.4:**  

1. Send acknowledgment with data to the server on receiving a message.

**Update v2.5:**  

1. Added query parameter support.

**Update v2.6:**  

1. Send any object instead of a string.