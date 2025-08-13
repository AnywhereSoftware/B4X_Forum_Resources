### UserNotificationCenter class - RemoveAllPendingNotifications by Alexander Stolte
### 12/02/2023
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/157762/)

<https://www.b4x.com/android/forum/threads/usernotificationcenter-class.117925/#content>  
  
This is an addition to the UserNotificationCenter class.  
  
<https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649509-removeallpendingnotificationrequ?language=objc>  

```B4X
'Removes all of your app’s pending local notifications.  
Public Sub RemoveAllPendingNotifications  
    NotificationCenter.RunMethod("removeAllPendingNotificationRequests", Array())  
End Sub
```