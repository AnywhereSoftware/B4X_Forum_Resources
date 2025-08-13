### B4A-Bridge source code by Erel
### 09/02/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/8153/)

[B4A-Bridge](http://www.b4x.com/forum/basic4android-getting-started-tutorials/7978-b4a-bridge-new-way-connect-your-device.html) is made of two components. One component is running on the device and the other is embedded in the IDE.  
The device side is the server side. It waits for connections and when a connection is established it handles the "action" messages.  
  
The code itself is made of a simple activity:  
  
![](https://lh3.googleusercontent.com/arSsfzqjKtq2_v9Moofj4SgiWWet6WOFH-P1Z2NuxbMo4yB6yqsGaoioptbDdbMCZw4=h900)  
  
  
And a service that is doing most of the job.  
All the network communication is handled by an AsyncStreams object. AsyncStreams are very useful for networking and other external communication.  
  
In this case the AsyncStreams object is initialized in prefix mode. In this mode we always receive complete messages which makes things simpler.  
See this tutorial for more information: [AsyncStreams Tutorial](http://www.b4x.com/forum/showthread.php?p=43664)  
  
This code is a good example for networking and working with service.  
You are welcomed to examine the code and ask any question about it.  
  
Source code: <https://github.com/AnywhereSoftware/B4A-Bridge>