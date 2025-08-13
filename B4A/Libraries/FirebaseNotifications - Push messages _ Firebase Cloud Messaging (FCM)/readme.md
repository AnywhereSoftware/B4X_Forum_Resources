### FirebaseNotifications - Push messages / Firebase Cloud Messaging (FCM) by Erel
### 06/26/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67716/)

**Updated tutorial: <https://www.b4x.com/android/forum/threads/b4x-firebase-push-notifications-2023.148715/>**  
  
[MEDIA=vimeo]260077923[/MEDIA]  
  
**Clarification:** The nice thing about FCM is that your app doesn't need to run in order to receive messages. The FirebaseMessaging receiver will be started by the OS when a new message arrives.  
It is not a real issue, but if the user closed your app with a "force close" from the device settings then messages will not arrive, until the app is started again.  
On some misbehaving devices, killing the app with a swipe will also cause messages not to arrive, until the app is started again.  
  
Firebase Cloud Messaging service is a layer above Google Cloud Messaging service.  
It makes it simple to add support for push messages.  
  
Sending messages is done with a simple HTTP request. It is also possible to send message from the Firebase console, though it is not very useful and is actually more complicated than using the REST api.  
  
1. The first step is to follow the Firebase integration tutorial:  
<https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
  
Make sure to add the Notifications snippet.  
**You should also reference FirebaseAnalytics**  
  
2. Add a **Receiver** named FirebaseMessaging to your app (must be this name):  

```B4X
Sub Process_Globals  
    Private fm As FirebaseMessaging  
End Sub  
  
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)  
    If FirstTime Then  
        fm.Initialize("fm")  
    End If  
    fm.HandleIntent(StartingIntent)  
End Sub  
  
Public Sub SubscribeToTopics  
    fm.SubscribeToTopic("general")  
End Sub  
  
Sub fm_MessageArrived (Message As RemoteMessage)  
    Log("Message arrived")  
    Log($"Message data: ${Message.GetData}"$)  
    Dim n2 As Notification  
    n2.Initialize2(n2.IMPORTANCE_DEFAULT)  
    n2.Icon = "icon"  
    n2.SetInfo(Message.GetData.Get("title"), Message.GetData.Get("body"), Main)  
    n2.Notify(1)    
End Sub  
  
Sub fm_TokenRefresh (Token As String)  
    Log("TokenRefresh: " & Token)  
End Sub
```

  
  
fm\_MessageArrived will be raised whenever a message is received. In this case we show a notification. You can do whatever you need.  
  
We call SubscribeToTopics from the starter service to make sure that the app will be subscribed when it starts:  

```B4X
'Starter service  
Sub Process_Globals  
  
End Sub  
  
Sub Service_Create  
   CallSubDelayed(FirebaseMessaging, "SubscribeToTopics")  
End Sub
```

  
  
Now we can send messages to a "topic" and all the subscribed devices will receive it.  
  
See the code in the attached B4J tool. Note that the API\_KEY should be set in the B4J code. It shouldn't be distributed in your app.  
  
API\_KEY is the server key from:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-04-07_08.10.47.png)  
  
A simple non-ui B4J program is attached.  
  
**Note that messages sent from Firebase Console will not arrive in some cases. Use the B4J code to test it.**