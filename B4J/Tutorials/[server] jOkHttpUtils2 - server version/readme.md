### [server] jOkHttpUtils2 - server version by Erel
### 01/09/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/124350/)

OkHttpUtils2 methods are designed to be called on the main thread. This is the case in all platforms and configurations, except of B4J server solutions.  
  
Starting from jOkHttpUtils2 v2.95 it is possible to make it thread safe. This is done by following these steps:  
  
1. Add the SERVER conditional symbol to the build configuration (Ctrl + B).  
2. Add a reference to jBuilderUtils. Library: <https://www.b4x.com/android/forum/attachments/jbuilderutils-zip.41578/>  
3. The library code calls Main.srvr.CreateThreadSafeMap. If you named your server object differently then you need to add such public global variable and assign it the server object.  
  
You should see this message in the logs when the first request is sent: OkHttpUtils2 - server mode!  
  
Relevant tutorial: [Resumable Subs (wait for / sleep) in server handlers](https://www.b4x.com/android/forum/threads/81833/#content)