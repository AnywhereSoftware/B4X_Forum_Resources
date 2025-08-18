### [BANano] Beginning Firebase Messaging by Mashiane
### 12/29/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/125982/)

Ola  
  
For the past 3 days, I've been trying to make this work. Eish. This is the implementation so far. We are not there yet.  
  
1. You need a service worker file. We will create this after BANano.Build.  
2. You need a firebase cloud messaging project linked to a web project.  
  
**Reproduction**:  
  
1. Goto Firebase.  
2. Goto firebase console.  
3. Add Project > Project Name > Create Project  
  
On Project Overview  
Goto Project Settings > General > Your Apps > Select Web Platform  
  
Ensure you get your config settings, you will use these later.  
  
  
![](https://www.b4x.com/android/forum/attachments/1609237376737-png.105084/)  
  
On project settings, goto Cloud Messaging, then Web Push Notifications and generate the key/pair, this is something called a vapidKey, you will use this later.  
  
Update: Just found this for more clarity…  
  
<https://www.itwonders-web.com/blog/push-notification-using-firebase-demo-tutorial>