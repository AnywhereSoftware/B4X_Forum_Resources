### UserNotificationCenter class - Time sensitive notifications by Alexander Stolte
### 06/09/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/161573/)

<https://www.b4x.com/android/forum/threads/usernotificationcenter-class.117925/#content>  
  
This is an addition to the UserNotificationCenter class.  
  
 I need a notification that is displayed on the lock screen and is not immediately pushed to the notification center. You can do this by declaring a notification as “time critical” via the UNNotificationInterruptionLevel.  
  
<https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel?language=objc>  
<https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel/timesensitive?language=objc>  
  
Thanks to [USER=1]@Erel[/USER] for his answer here:  
<https://www.b4x.com/android/forum/threads/usernotificationcenter-set-interruptionlevel-for-time-sensitive-notifications.161561/post-991171>  
  
**[SIZE=5]Steps[/SIZE]**  

1. Go to the Apple developer console
2. Open the Identifiers
3. Open the one from your app
4. Scroll down to "Time Sensitive Notifications" and check this option
5. save it and update your mobileprovision file from the app and download it

![](https://www.b4x.com/android/forum/attachments/154481)  
  
6. Add this line to the Project Attributes in the main module of your app  

```B4X
#Entitlement: <key>com.apple.developer.usernotifications.time-sensitive</key><true/>
```

  
7. Open the "UserNotificationCenter" class and add the following line to the [ICODE]CreateNotificationWithContent[/ICODE] sub  

```B4X
Public Sub CreateNotificationWithContent(Title As String, Body As String, Identifier As String, Category As String, MillisecondsFromNow As Long)  
    Dim ln As NativeObject  
    ln = ln.Initialize("UNMutableNotificationContent").RunMethod("new", Null)  
    ln.SetField("title", Title)  
    ln.SetField("body", Body)  
    ln.SetField("interruptionLevel", 2) 'Add this line - 2 = UNNotificationInterruptionLevelTimeSensitive  
    Dim n As NativeObject  
    ln.SetField("sound", n.Initialize("UNNotificationSound").RunMethod("defaultSound", Null))  
    If Category <> "" Then ln.SetField("categoryIdentifier", Category)  
    Dim trigger As NativeObject  
    trigger = trigger.Initialize("UNTimeIntervalNotificationTrigger").RunMethod("triggerWithTimeInterval:repeats:", Array(MillisecondsFromNow / 1000, False))  
    Dim request As NativeObject  
    request = request.Initialize("UNNotificationRequest").RunMethod("requestWithIdentifier:content:trigger:", _  
       Array(Identifier, ln, trigger))  
    Dim NotificationCenter As NativeObject  
    NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)  
    NotificationCenter.RunMethod("addNotificationRequest:", Array(request))  
End Sub
```

  
  
8. Done  
  
Open the app and the following item should now be available in the app settings on the iPhone:  
  
![](https://www.b4x.com/android/forum/attachments/154482)  
  
The notification is marked as "Time sensitive" and is now visible at the lockscreen for 1 hour  
![](https://www.b4x.com/android/forum/attachments/154483)