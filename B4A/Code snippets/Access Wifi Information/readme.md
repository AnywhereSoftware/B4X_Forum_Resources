### Access Wifi Information by Erel
### 05/18/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/117901/)

This code takes care of requesting the location permission which is needed on Android 8+:  
  

```B4X
Sub GetWifiInfo As ResumableSub  
    Dim p As Phone  
    Dim WifiManager As JavaObject  
    Dim WifiInfo As JavaObject  
    WifiManager = WifiManager.InitializeContext.RunMethod("getSystemService", Array("wifi"))  
    If p.SdkVersion >= 27 Then  
        Dim rp As RuntimePermissions  
        rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
        If Result = False Then Return WifiInfo  
    End If  
    WifiInfo = WifiManager.RunMethod("getConnectionInfo", Null)  
    Return WifiInfo  
End Sub
```

  
Manifest editor:  

```B4X
AddPermission(android.permission.ACCESS_WIFI_STATE)  
AddPermission(android.permission.ACCESS_FINE_LOCATION)
```

  
Depends on: Phone, JavaObject and RuntimePermissions  
  
Usage example:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Wait For (GetWifiInfo) Complete (WifiInfo As JavaObject)  
    If WifiInfo.IsInitialized Then  
        Log(WifiInfo.RunMethod("getSSID", Null))  
    End If  
End Sub
```

  
Other WifiInfo methods: <https://developer.android.com/reference/android/net/wifi/WifiInfo>  
  
Note that the information will not be available on Android 8+ if location services are disabled.