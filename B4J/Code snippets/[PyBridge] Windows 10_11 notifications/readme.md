### [PyBridge] Windows 10/11 notifications by Erel
### 03/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166091/)

![](https://www.b4x.com/android/forum/attachments/162485)  
  
Based on: <https://github.com/GitHub30/win11toast>  
Many options.  
  
Install:  
pip install win11toast  
  
Code:  

```B4X
Private Sub ShowNotification(Title As String, Body As String, AppId As String) As PyWrapper  
    Dim toast As PyWrapper = Py.ImportModuleFrom("win11toast", "toast")  
    Return toast.Call.Arg(Title).Arg(Body).ArgNamed("app_id", AppId)  
End Sub  
  
Private Sub ShowNotificationWithCallback(Title As String, Body As String, AppId As String, Tag As Int) As PyWrapper  
    Dim toast As PyWrapper = ShowNotification(Title, Body, AppId)  
    Return toast.ArgNamed("on_click", _  
        Py.Lambda($"args: bridge_instance.raise_event('notificationclick', {'tag': ${Tag}})"$))  
End Sub
```

  
  
You can add named parameters to customize the notification:  

```B4X
ShowNotification("This is the title", "And this is the body", "B4J") _  
        .ArgNamed("icon", "C:\Users\H\Documents\logo.png") _  
        .ArgNamed("image", "C:\Users\H\Documents\logo.png")
```

  
  
![](https://www.b4x.com/android/forum/attachments/162487)  
  
And if you want to handle the click event:  

```B4X
ShowNotificationWithCallback("This is the title", "And this is the body", "B4J", 5)  
  
Private Sub Py_NotificationClick (Args As Map)  
    Log("notification clicked: tag = " & Args.Get("tag"))  
End Sub
```