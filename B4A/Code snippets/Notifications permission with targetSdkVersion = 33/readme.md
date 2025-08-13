### Notifications permission with targetSdkVersion = 33 by Erel
### 06/06/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/148233/)

There is a new "dangerous" (runtime) permission On Android 13+ devices required for showing notifications. When targetSdkVersion < 33, the OS will show the permission dialog automatically before the notification is displayed.  
Once we switch to targetSdkVersion=33 we are responsible for requesting it ourselves. This has the advantage that we can control the exact point where it will be requested.  
  
This code handles this:  
Depends on JavaObject and Phone libraries.  

```B4X
'Make sure that targetSdkVersion >= 33  
Private Sub CheckAndRequestNotificationPermission As ResumableSub  
    Dim p As Phone  
    If p.SdkVersion < 33 Then Return True  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim targetSdkVersion As Int = ctxt.RunMethodJO("getApplicationInfo", Null).GetField("targetSdkVersion")  
    If targetSdkVersion < 33 Then Return True  
    Dim NotificationsManager As JavaObject = ctxt.RunMethod("getSystemService", Array("notification"))  
    Dim NotificationsEnabled As Boolean = NotificationsManager.RunMethod("areNotificationsEnabled", Null)  
    If NotificationsEnabled Then Return True  
    Dim rp As RuntimePermissions  
    rp.CheckAndRequest(rp.PERMISSION_POST_NOTIFICATIONS)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean) 'change to Activity_PermissionResult if non-B4XPages.  
    Log(Permission & ": " & Result)  
    Return Result  
End Sub
```

  
  
Usage example:  

```B4X
Private Sub Button1_Click  
    Wait For (CheckAndRequestNotificationPermission) Complete (HasPermission As Boolean)  
    If HasPermission Then  
        Dim n As Notification  
        n.Initialize  
        n.Icon = "icon"  
        n.SetInfo("This is the title", "and this is the body.", Main) 'Change Main to "" if this code is in the main module.  
        n.Notify(1)  
    Else  
        Log("no permission")  
        ToastMessageShow("no permission", True)  
    End If  
End Sub
```