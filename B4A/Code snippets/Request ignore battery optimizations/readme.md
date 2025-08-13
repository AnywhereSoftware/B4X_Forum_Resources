### Request ignore battery optimizations by Erel
### 05/15/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167008/)

The following code will show a dialog that asks the user to whitelist the app and ignore battery optimizations. This is useful if your app needs to run in the background.  
  
Note that it is likely that your app will not be accepted to Google Play with this request so it is more useful for non-Google Play (<https://developer.android.com/training/monitoring-device-state/doze-standby>). There is a "safer" solution that opens the settings. From my tests it doesn't seem to work properly.  
  

```B4X
'Depends on Phone library  
Private Sub CheckAndRequestIgnoreBatteryOptimizations As ResumableSub  
    Dim p As Phone  
    If p.SdkVersion < 23 Then Return True  
    Dim context As JavaObject  
    context.InitializeContext  
    Dim PowerManager As JavaObject = context.RunMethod("getSystemService", Array("power"))  
    Dim ignoring As Boolean = PowerManager.RunMethod("isIgnoringBatteryOptimizations", Array(Application.PackageName))  
    If ignoring Then Return True  
    Dim in As Intent  
    in.Initialize("android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS", "package:" & Application.PackageName)  
    StartActivity(in)  
    Wait For B4XPage_Appear 'Change to Activity_Resume if mistakenly not using B4XPages.  
    Return PowerManager.RunMethod("isIgnoringBatteryOptimizations", Array(Application.PackageName))  
End Sub
```

  
Manifest editor:  

```B4X
AddPermission(android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
```

  
  
Usage:  

```B4X
Private Sub Button1_Click  
    Wait For (CheckAndRequestIgnoreBatteryOptimizations) Complete (Ignoring As Boolean)  
    Log(Ignoring)  
End Sub
```