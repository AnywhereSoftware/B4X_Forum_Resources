### Share SQLite database between 2 devices by aeric
### 03/13/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/159882/)

This is just a proof of concept to show that Device A behave like a server hosting a database and Device B connects to it accessing the "shared" database. It is a response to [this question](https://www.b4x.com/android/forum/threads/share-folder-or-share-db-sqlite.159870/).  
  
Device A - Server (contains database)  
Device B - Client (does not have database)  
  
The idea is by implementing the Network example using AsyncStreams and B4XSerializator as [explained here](https://www.b4x.com/android/forum/threads/b4x-b4xpages-network-asyncstreams-b4xserializator.119011/).  
  
Use "Server" build configuration to compile the server.  
Use "Default" build configuration to compile the client.  
  
In client app, enter the server's IP to connect to.  
  
You can also test with B4J.  
  
![](https://www.b4x.com/android/forum/attachments/151785)