### UserNotificationCenter class - Schedule Notifications by Alexander Stolte
### 05/05/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/157768/)

<https://www.b4x.com/android/forum/threads/usernotificationcenter-class.117925/#content>  
  
This is an addition to the UserNotificationCenter class.  
  
<https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app?language=objc>  
  

```B4X
Sub Class_Globals  
    Private NotificationCenter As NativeObject  
    Type NotificationCenter_DateComponents(Year As Int,Month As Int,Day As Int,Hour As Int, Minute As Int, Second As Int,Weekday As Int)  
End Sub
```

  
  

```B4X
Public Sub CreateNotificationWithContentAndScheduling(Title As String, Body As String, Identifier As String, Category As String,DateComponent As NotificationCenter_DateComponents,Repeats As Boolean)  
    Dim ln As NativeObject  
    ln = ln.Initialize("UNMutableNotificationContent").RunMethod("new", Null)  
    ln.SetField("title", Title)  
    ln.SetField("body", Body)  
    Dim n As NativeObject  
    ln.SetField("sound", n.Initialize("UNNotificationSound").RunMethod("defaultSound", Null))  
    If Category <> "" Then ln.SetField("categoryIdentifier", Category)  
   
    Dim dateComponents As NativeObject  
    dateComponents = dateComponents.Initialize("NSDateComponents").RunMethod("new", Null)  
    If DateComponent.Year > 0 Then dateComponents.SetField("year", DateComponent.Year)  
    If DateComponent.Month > 0 Then dateComponents.SetField("month", DateComponent.Month)  
    If DateComponent.Day > 0 Then dateComponents.SetField("day", DateComponent.Day)  
    If DateComponent.Hour > 0 Then dateComponents.SetField("hour", DateComponent.Hour)  
    If DateComponent.Minute > 0 Then dateComponents.SetField("minute", DateComponent.Minute)  
    If DateComponent.Second > 0 Then dateComponents.SetField("second", DateComponent.Second)  
    If DateComponent.Weekday > 0 Then dateComponents.SetField("weekday", DateComponent.Weekday)  
   
    Dim trigger As NativeObject  
    trigger = trigger.Initialize("UNCalendarNotificationTrigger").RunMethod("triggerWithDateMatchingComponents:repeats:", Array(dateComponents, Repeats))  
    Dim request As NativeObject  
    request = request.Initialize("UNNotificationRequest").RunMethod("requestWithIdentifier:content:trigger:", _  
       Array(Identifier, ln, trigger))  
    Dim NotificationCenter As NativeObject  
    NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)  
    NotificationCenter.RunMethod("addNotificationRequest:", Array(request))  
End Sub
```

  
  
Examples:  
Every Monday at 14 o clock  

```B4X
            Dim DateComponent As NotificationCenter_DateComponents  
            DateComponent.Initialize  
            DateComponent.Weekday = 2  
            DateComponent.Hour = 14  
            DateComponent.Minute = 0  
           
            Main.UNC.CreateNotificationWithContentAndScheduling("Weekly Staff Meeting","Every Monday at 2pm" , "meetings", "Meeting_001",DateComponent,True)
```

  
Every day at 14 o clock  

```B4X
            Dim DateComponent As NotificationCenter_DateComponents  
            DateComponent.Initialize  
            DateComponent.Day = 1  
            DateComponent.Hour = 14  
            DateComponent.Minute = 0  
            Main.UNC.CreateNotificationWithContentAndScheduling("Weekly Staff Meeting","Every day at 2pm" , "meetings", "Meeting_001",DateComponent,True)
```