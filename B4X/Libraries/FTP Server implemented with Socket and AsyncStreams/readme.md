###  FTP Server implemented with Socket and AsyncStreams by Erel
### 07/18/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/74320/)

![](https://www.b4x.com/images/ftp.gif)  
(Note that the FTP client above is not part of this solution. It only demonstrates how you can use a standard FTP client to communicate with the server.)  
  
This is an example of using low level network features to implement a high level protocol.  
It is an implementation of a standard FTP server. You can use standard FTP client programs to send or receive files.  
As it is based on AsyncStreams and it can handle multiple concurrent connections.  
It is compatible with B4J, B4i and B4A.  
**Note that only passive mode (which is the preferred method) is implemented.**   
  
It is a good example of using classes to handle multiple clients.  
The solution is made of three classes:  
*FTPServer* - There is a single instance of this class. It manages the server socket that listens on the control port (main port).  
It also manages the connected clients and assigns a data port for each client.  
  
*FTPClient* - There is an instance of this class for each active connection. It uses AsyncStreamsText class to read the clients text commands. It creates a new FTPDataConnection instance for each task that requires communication over the data socket (upload, download and list files).  
  
*FTPDataConnection* - An instance is created for each data task. It sends or receives the data and then closes the connection. Note that a new method was added to AsyncStreams that allows closing the channel after the data was sent (SendAllAndClose). Clients expect the data socket to be closed after the data is sent. There isn't any other cue that tells the client that all data was sent.  
  
Not all commands are implemented. The common feature are supported: upload, download, delete, rename, list and others.  
  
In B4A and B4J, JavaObject is used to call a native API that gets the canonical path and verify that the path is inside the set directory. There is no equivalent API in iOS. It is less important as each app is sandboxed anyway.  
  
Using the server is simple:  

```B4X
server.Initialize(Main, "FTPServer")  
server.SetPorts(51041, 51042, 51142)  
server.AddUser("Test", "test") 'user name and password.  
server.BaseDir = File.DirRootExternal  
server.Start
```

  
SetPorts - Sets the control port and the range of available data ports. When running on a non-mobile device, you need to make sure that the firewall allows incoming connections on all these ports.  
AddUser - Adds a user name and password. You can call it multiple times.  
BaseDir - Sets the client root folder.  
  
In B4i you also need to stop the server when the application moves to the background and start it again when it resumes.  
  
Implementing an FTP server that properly supports multiple clients is not a simple task. The code itself is not too complicated and is a good example for anyone who is working with network sockets.  
  
  
![](https://www.b4x.com/basic4android/images/SS-2016-12-19_16.47.26.png)  
  
**Updates**  
  
V1.10 - Implemented as a cross platform b4xlib. Fixes an issue with uploading of small files. Adds support for UTF8 files and folders names.  
  
Example is attached. FTPServer.b4xlib is the library itself.