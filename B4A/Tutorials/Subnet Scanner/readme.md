### Subnet Scanner by Didier9
### 08/25/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/108970/)

Here is a simple subnet scanner. It scans the current class C subnet for a particular port number and tries to open a connection.  
  
It logs all the IPs that are found to have that port open in a listview. I use it with my IoT gizmos on an Android 5.1 phone (just realize I have not tried on anything else).  
  
![](https://www.b4x.com/android/forum/attachments/83386)  
  
It is a little more complicated than it needs to be. For one, the Starter module is unnecessary. But this is the structure I use for my network-aware apps where I like the socket to be opened in Starter so that I can keep it open when switching activities.  
The Callback mechanism (Dispatch) can be used to steer the messages from the socket in the Starter module back to the proper, currently open activity.