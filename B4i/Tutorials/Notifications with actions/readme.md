### Notifications with actions by Erel
### 09/18/2024
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/100623/)

![](https://www.b4x.com/basic4android/images/SS-2018-12-20_16.03.33.png)  
  
It is possible to add a list of actions to the push notifications. The list becomes visible when the user 3d touches the notification or drags it with two fingers.  
Note that it is an iOS 10+ feature.  
  
Before you start make sure to first implement the standard push notifications and see that they work with the B4J code.  
  
Steps to add actions:  
  
1. Add this code at the end of the main module:  

```B4X
#AdditionalLib: UserNotifications.framework  
#if OBJC  
#import <UserNotifications/UserNotifications.h>  
@end  
@interface b4i_main (notification) <UNUserNotificationCenterDelegate>  
@end  
@implementation b4i_main (notification)  
- (void)userNotificationCenter:(UNUserNotificationCenter *)center  
didReceiveNotificationResponse:(UNNotificationResponse *)response  
         withCompletionHandler:(void (^)(void))completionHandler {  
       B4I* bi = [b4i_main new].bi;  
[bi raiseEvent:nil event:@"usernotification_action:" params:@[response]];  
completionHandler();  
   }  
#End If
```

  
  
Define the list of actions in SetCategories. Call SetCategories from ApplicationStart.  
  

```B4X
Sub SetCategories  
   
   Dim category As NativeObject  
   category = category.Initialize("UNNotificationCategory")  
   'create a list with the action identifiers and titles: <——————————————–  
   Dim actions As List = Array(CreateAction("a1", "Action 1"), CreateAction("a2", "Action 2"))  
   
   Dim intentIdentifiers As List = Array()  
   category = category.RunMethod("categoryWithIdentifier:actions:intentIdentifiers:options:", _  
       Array("category 1", actions, intentIdentifiers, 1))  
   Dim NotificationCenter As NativeObject  
   
   NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)  
   Dim set As NativeObject  
   set = set.Initialize("NSSet").RunMethod("setWithObject:", Array(category))  
   NotificationCenter.RunMethod("setNotificationCategories:", Array(set))  
   Log(Me)  
   NotificationCenter.SetField("delegate", Me)  
End Sub  
  
Sub CreateAction (Identifier As String, Title As String) As Object  
   Dim acceptAction As NativeObject  
   acceptAction.Initialize("UNNotificationAction")  
   '5 = AuthenticationRequired + Foreground  
   acceptAction = acceptAction.RunMethod("actionWithIdentifier:title:options:", Array(Identifier, Title, 5))  
   Return acceptAction  
End Sub  
  
Private Sub UserNotification_Action (Response As Object)  
   Dim n As NativeObject = Response  
   Dim ActionIdentifier As String = n.GetField("actionIdentifier").AsString  
   Msgbox($"User clicked on : ${ActionIdentifier}"$, "")  
End Sub
```

  
  
Step 3: B4J code!  
Set the category in the push notification json message:  

```B4X
If Topic.StartsWith("ios_") Then  
        'B4i  
        Dim Badge As Int = 0  
        Dim iosalert As Map =  CreateMap("title": Title, "body": Body)  
        message.Put("notification", iosalert)  
        message.Put("apns", CreateMap("headers": _  
            CreateMap("apns-priority": "10"), _  
            "payload": CreateMap("aps": CreateMap("sound":"default", "badge": Badge, "category": "category 1")))) '<— category is set here  
    Else  
        'B4A  
        message.Put("android", CreateMap("priority": "high"))  
    End If
```

  
  
UserNotification\_Action event will be called when the user pressed on an action.