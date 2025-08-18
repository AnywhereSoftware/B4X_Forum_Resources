### Push notifications by Erel
### 06/21/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/48562/)

New: <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-server-not-required.68645/>  
  
Old, don't use:  
[spoiler]  
B4i v1.50 added support for push notifications. Push notifications feature requires some configuration.  
Patience is a virtue ;)  
  
The following steps are required inside Apple developer console:  
1. Create a new explicit (non-wildcard) App ID with the package name of the push app. For example anywheresoftware.b4i.push. Enable push notification service.  
2. Create an Apple Push Notification SSL certificate. Use the same certSigningRequest.csr file that you previously created.  
3. Create a provision file with the new App ID.  
  
Note that you can always delete all certificates and provisions and start from scratch.  
  
The last step is done in the IDE by clicking on Tools - Build Server - Create Push Keystore. This sends the required files to the Mac builder which then creates a file named push.keystore. This file will be used by the [B4X Push Server](https://www.b4x.com/android/forum/threads/b4x-push-server.48560/) to connect to Apple service.  
  
Make sure to switch to HD by clicking on the small gear button:  
  
[MEDIA=youtube]HPCXlHc0mA4[/MEDIA]  
  
At the end of the process the key folder should look like:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-12-24_11.45.12.png)  
  
**Code**  
  
Whenever the app starts we need to register the app for remote notifications. This is done with this code:  

```B4X
App.RegisterUserNotifications(True, True, True) 'allow badge, sound and alert  
App.RegisterForRemoteNotifications
```

  
  
The PushToken event will be raised with the device token. We then send the token to the push server:  

```B4X
Private Sub Application_PushToken (Success As Boolean, Token() As Byte)  
   If Success Then  
     Dim bc As ByteConverter  
     Dim j As HttpJob  
     j.Initialize("j", Me)  
     j.PostString(ServerUrl & "/devicetoken", "token=" & bc.HexFromBytes(Token) & "&type=1")  
   Else  
     Log("Error getting token: " & LastException)  
   End If  
End Sub  
  
Private Sub JobDone(j As HttpJob)  
   If j.Success Then  
     Log("Token uploaded successfully.")  
   Else  
     Log("Error uploading token")  
   End If  
   j.Release  
End Sub
```

  
  
The Application\_RemoteNotification event will be raised when a message arrives while the app is in the foreground. If the app is not in the foreground then a standard alert message will appear. The user can click on the message to start the app.  
The Application\_RemoteNotification event will be fired after the app has started.  
  

```B4X
Private Sub Application_RemoteNotification (Message As Map, CompletionHandler As CompletionHandler)  
   Log("Remote notification: " & Message)  
   Dim m As Map = Message.Get("aps")  
   Log(m)  
   Log(m.Get("alert"))  
   CompletionHandler.Complete  
End Sub
```

  
  
Note the new signature of Application\_RemoteNotification. You should call CompletionHandler.Complete once you are done with the task related to the message. This is mainly important for silent push messages, though you should always call it.  
  
You should use the #ProvisionFile attribute to explicitly select the push.mobileprovision file.  
  
See also:  
Apple documentation: <https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/CommunicatingWIthAPS.html>  
B4X Push Server: <https://www.b4x.com/android/forum/threads/b4x-push-server.48560/>  
[SIZE=4]**[Managing multiple certificates / provision files](https://www.b4x.com/android/forum/threads/managing-multiple-certificates-provision-files.48539/)**[/SIZE][/spoiler][SIZE=4][/SIZE]