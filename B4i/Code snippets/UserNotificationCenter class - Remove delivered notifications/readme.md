### UserNotificationCenter class - Remove delivered notifications by Alexander Stolte
### 06/09/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/161574/)

<https://www.b4x.com/android/forum/threads/usernotificationcenter-class.117925/#content>  
  
This is an addition to the UserNotificationCenter class.  
  
**Remove all delivered notifications**  
<https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/removealldeliverednotifications()?language=objc>  
  
"Use this method to remove all of your app’s delivered notifications from Notification Center. The method executes asynchronously, returning immediately and removing the identifiers on a background thread. This method does not affect any notification requests that are scheduled, but have not yet been delivered."  
  

```B4X
'Removes all of your app’s delivered notifications from Notification Center.  
Public Sub RemoveAllDeliveredNotifications  
    Try  
        NotificationCenter.RunMethod("removeAllDeliveredNotifications", Null)  
    Catch  
        Log(LastException)  
    End Try  
End Sub
```

  

```B4X
noti.RemoveAllDeliveredNotifications
```

  
  
**Remove delivered notifications with the specified identifiers**  
<https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/removedeliverednotifications(withidentifiers:)?language=objc>  
  
"Use this method to selectively remove notifications that you no longer want displayed in Notification Center. The method executes asynchronously, returning immediately and removing the specified notifications on a background thread."  
  

```B4X
'Removes your app’s notifications from Notification Center that match the specified identifiers.  
Public Sub RemoveDeliveredNotifications (Identifiers As List)  
    Try  
        NotificationCenter.RunMethod("removeDeliveredNotificationsWithIdentifiers:", Array(Identifiers))  
    Catch  
        Log(LastException)  
    End Try  
End Sub
```

  

```B4X
noti.RemoveDeliveredNotifications(Array As String("YourIdentifer1","YourIdentifer2"))
```