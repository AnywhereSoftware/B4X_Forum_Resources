### Custom notifications channel by Erel
### 01/15/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/91634/)

**Don't use this code. Use NB6 instead.**  
  
Starting from Android 8, notifications are grouped by channels. The notification behavior depends on the channel it belongs to.  
With B4A v8+ notification channels are created automatically based on the importance level.  
  
You can use the following code to manually create a notification channel with the same id as the notification channel that will be created internally. This allows you to override the notification behavior.  
  
Note that once a notification channel was created then you cannot change its behavior. This means that:  
  
1. You must call this code before you initialize the notification object.  
2. If you have already created a notification in the past then you need to uninstall the app to see the changes (clean the project afterward).  
  

```B4X
Sub CreateNotificationChannel(ImportanceLevel As Int)  
   Dim p As Phone  
   If p.SdkVersion >= 26 Then  
       Dim ctxt As JavaObject  
       ctxt.InitializeContext  
       Dim channelId As String = "channel_" & ImportanceLevel  
       Dim channel As JavaObject  
       channel.InitializeNewInstance("android.app.NotificationChannel", Array(channelId, Application.LabelName, ImportanceLevel))  
       'modify the channel  
       'For example: disable the badge feature  
       channel.RunMethod("setShowBadge", Array(False))  
        
       'set it  
       Dim manager As JavaObject = ctxt.RunMethod("getSystemService", Array("notification"))  
       manager.RunMethod("createNotificationChannel", Array(channel))  
        
   End If  
End Sub
```

  
  
Example:  

```B4X
Dim n As Notification  
   CreateNotificationChannel(n.IMPORTANCE_HIGH)  
   n.Initialize2(n.IMPORTANCE_HIGH)  
   n.Icon = "icon"  
   n.SetInfo("test", "test", Main)  
   n.Notify(1)
```

  
Depends on: Phone and JavaObject libraries. Requires B4A v8+