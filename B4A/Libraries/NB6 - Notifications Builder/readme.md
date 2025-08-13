### NB6 - Notifications Builder by Erel
### 03/12/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/91819/)

**Background**  
  
  
The notifications features changed a lot as Android evolved. Android 8 (with targetSdkVersion 26+) adds another complexity with the introduction of notification channels.  
  
The built-in Notification object was rewritten in B4A v8 to work properly with all versions.  
This is a good option if you are interested in simple notifications.  
  
  
**Now for the new option.**  
  
NB6 is a class that builds both simple and complex notifications:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-12_18.00.49.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-12_17.40.35.png)  
  
It is quite simple to use and the attached example demonstrates most of the features.  
**NB6 works with all versions of Android, however it focuses on Android 6+ devices.** On older devices (Android 5-) it will show a basic notification similar to the one created with the built-in Notification object.  
  
Steps to create a notification:  
- Initialize a NB6 object. You need to pass a ChannelId, Channel Name and Importance Level values.  
Starting from Android 8+ some of the features are set in the notification channel and not in each notification separately. Once a notification channel is created, it cannot be modified.  
If you want to make changes then you need to change the id or uninstall the app (reinstalling is not enough).  
NB6 internally adds the importance level string to the channel id. So in most cases you can use the same value for all notifications.  
The importance levels are: MIN, LOW, DEFAULT and HIGH.  
LOW+ is required for foreground service notifications.  
DEFAULT and HIGH enable sounds.  
HIGH enables the headup notifications.  
  
- Set the properties. You must set SmallIcon.  
- Call Build. The last parameter is the activity that will be started when the user clicks on the notification.  
Build returns a notification object.  
- Call Notification.Notify to show the notification.  
  
Example:  

```B4X
Sub Simple_Notification  
   Dim n As NB6  
   n.Initialize("default", Application.LabelName, "DEFAULT").AutoCancel(True).SmallIcon(smiley)  
   n.Build("Title", "Content", "tag1", Me).Notify(4) 'It will be Main (or any other activity) instead of Me if called from a service.  
End Sub
```

  
  
  
**Notes & Tips**  
  
- Unlike the built-in Notification object where the icons must be added as resources, NB6 expects bitmaps. This makes it easier to work with NB6.  
- Starting from Android 5.1+ the notifications colors are ignored. The transparent parts are used as a mask.  
- Don't use the starter service as the target for button actions or delete actions. Use a different service. The starter service cannot be started from a receiver as happens here.  
- The notification behavior depends on the launcher. Not all features will work on all devices, even if they run the latest version of Android. 'Not work' means that it will be ignored.  
- NB6 is a class module and it uses JavaObject to call the native APIs. The code is quite simple and can be extended.  
- The class is included in the attached example. You need to add it to your project and add a reference to the JavaObject library.  
  
  
**NB6 is included as an internal library.**