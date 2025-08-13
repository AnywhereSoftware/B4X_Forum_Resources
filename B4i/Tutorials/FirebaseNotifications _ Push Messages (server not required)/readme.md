### FirebaseNotifications / Push Messages (server not required) by Erel
### 06/26/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/68645/)

**Updated tutorial: <https://www.b4x.com/android/forum/threads/b4x-firebase-push-notifications-2023.148715/>**  
The configuration steps are still relevant.  
  
[MEDIA=vimeo]261132706[/MEDIA]  
  
Firebase Notifications service makes it relatively easy to send push messages.  
  
Integrating Firebase: <https://www.b4x.com/android/forum/threads/firebase-integration.68623/>  
  
Push messages in iOS requires some configuration.  
  
  
1. Create a new explicit (non-wildcard) **App ID** with the package name of the push app. For example anywheresoftware.b4i.push. Enable push notification service.  
2. Create an Apple Push Notification SSL certificate. Use the same certSigningRequest.csr file that you previously created.  
This can be done from App IDs - Choose the id - Edit.  
![](https://www.b4x.com/basic4android/images/SS-2016-07-04_17.19.12.png)  
  
**I recommend using a Production SSL Certificate with a Distribution / Ad Hoc provision profile.** This way you can use the same tokens during development and in production.  
  
3. Create a provision file with the new App ID.  
  
**Update:** It is simpler to use the new and recommended APN authentication keys: <https://www.b4x.com/android/forum/threads/firebase-messaging-apn-authentication-keys-vs-authentication-certificates.126402>  
  
**Old keys (works as well):**  
4. There should be a file named aps\_\*.cer in the keys folder. Now you should click on Tools - Build Server - Create Push Key - Firebase Service:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-04_17.25.02.png)  
  
This will create a file named firebase\_push.p12 in the keys folder. You need to upload it to [Firebase console](https://console.firebase.google.com) under Settings - CLOUD MESSAGING:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-04_17.35.51.png)  
**You only need to upload the production APN.**  
  
5. Download GoogleService-Info.plist and copy it to Files\Special folder.  
  
**Code**  
  
The code should be similar to:  

```B4X
#Entitlement: <key>aps-environment</key><string>production</string>  
'use the distribution certificate  
#CertificateFile: ios_distribution.cer  
'use the provision profile that goes with the explicit App Id  
#ProvisionFile: Firebase.mobileprovision  
Sub Process_Globals  
   Public App As Application  
   Public NavControl As NavigationController  
   Private Page1 As Page  
   Private analytics As FirebaseAnalytics  
   Private fm As FirebaseMessaging  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
   analytics.Initialize  
   NavControl = Nav  
   Page1.Initialize("Page1")  
   Page1.Title = "Page 1"  
   Page1.RootPanel.Color = Colors.White  
   NavControl.ShowPage(Page1)  
   App.RegisterUserNotifications(True, True, True)  
   App.RegisterForRemoteNotifications  
   fm.Initialize("fm")  
End Sub  
  
Private Sub fm_FCMConnected  
   Log("FCMConnected")  
   'here we can subscribe and unsubscribe from topics  
   fm.SubscribeToTopic("ios_general") 'add ios_ prefix to all topics  
End Sub  
  
Private Sub Application_RemoteNotification (Message As Map, CompletionHandler As CompletionHandler)  
   Log($"Message arrived: ${Message}"$)  
   Msgbox(Message, "Push message!")  
   CompletionHandler.Complete  
End Sub  
  
Private Sub Application_Active  
   fm.FCMConnect 'should be called from Application_Active  
End Sub  
  
Private Sub Application_Background  
   fm.FCMDisconnect 'should be called from Application_Background  
End Sub  
  
Sub Application_PushToken (Success As Boolean, Token() As Byte)  
   Log($"PushToken: ${Success}"$)  
   Log(LastException)  
End Sub
```

  
  
Use the attached B4J (non-ui) program to send messages. It handles ios messages a bit differently. There is an assumption that all iOS topics start with ios\_.