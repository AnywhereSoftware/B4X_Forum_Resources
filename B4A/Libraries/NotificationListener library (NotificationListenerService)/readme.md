### NotificationListener library (NotificationListenerService) by Erel
### 07/07/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/35630/)

The NotificationListener library allows you to access the device notifications.  
  
With this library you can listen to new notifications and removed notifications.  
  
You can also clear existing notifications.  
  
There are some steps that you need to follow in order to use this feature:  
- Make sure that the IDE references android.jar from API level 18+.  
- Download the attached library and copy it to the libraries folder.  
- Add a Service module named NotificationService (must be this exact name).  
- Add the following code to the manifest editor:  

```B4X
AddApplicationText(  
<service android:name="anywheresoftware.b4a.objects.NotificationListenerWrapper"  
   android:label="Notification Listener"  
   android:exported="false"  
  android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">  
  <intent-filter>  
  <action android:name="android.service.notification.NotificationListenerService" />  
  </intent-filter>  
</service>)
```

  
You can change the value of android:label.  
  
- The user must enable your app before it can listen to notifications. This is done by sending the following intent:  

```B4X
Sub btnEnableNotifications_Click  
   Dim In As Intent  
   In.Initialize("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS", "")  
   StartActivity(In)  
End Sub
```

  
  
The user will see the following screen:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-12-12_13.06.15.png)  
  
In the service you should create a NotificationListener object and let it handle the StartingIntent:  

```B4X
Sub Process_Globals  
   Private listener As NotificationListener  
End Sub  
Sub Service_Create  
   listener.Initialize("listener")  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
   If listener.HandleIntent(StartingIntent) Then Return  
End Sub
```

  
The following events will be raised: NotificationPosted and NotificationRemoved.  
  
See the attached example. It extracts data out of the notifications and print it to the logs:  
![](http://www.b4x.com/basic4android/images/SS-2013-12-12_13.08.18.png)  
  
  
**Tips**  
  
- The notifications will also be handled when your app is not running. The service will first be created.  
- There is no way to check whether the app is enabled or not.  
- If your service is configured incorrectly when you enable the app then nothing will work and there will be no error message. Even after you reinstall the app. In that case you should either change the app package name or restart the device.  
- You can also reach the settings screen by going to Settings > Security > Notification Access.  
  
Updates:  
  
- Example updated with targetSdkVersion=34 - android:exported="false" added to the service declaration and the permission to post notifications is requested.