###  BLE 2 - Bluetooth Low Energy by Erel
### 01/04/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/59937/)

This library replaces the previous BLE library.  
It is simpler to use and it is more powerful. Its API is based on B4i [iBLE library](https://www.b4x.com/android/forum/threads/46099/#content) which makes it easy to reuse B4i code.  
  
See the iBLE tutorial: <https://www.b4x.com/android/forum/threads/ble-bluetooth-low-energy-library.46099/#content>  
  
Tips & Notes  
  
- You can call Manager.Scan2 with AllowDuplicates set to True if you want to monitor the state of an unconnected device.  
- The AdvertisingData map in DeviceFound event holds pairs of integers as keys (data types) and bytes arrays as values.  
- Call ReadData2 if you are only interested in a single characteristic.  
- BLE is only supported on Android 4.3+.  
  
See the attached example. Note that the important code in in the Starter service module.  
  
**Edit:**  
  
A new version of BLE\_Example was uploaded. targetSdkVersion is now set to 29  
Setting the targetSdkVersion to 29 requires some changes:  
  
1. Add the fine location permission in the manifest editor.  
2. Request this permission with RuntimePermissions.  
  
Otherwise scanning will fail with a message visible in the unfiltered logs.  
  
BLE2 is an internal library now. It is included in the IDE.  
  
Example is based on B4XPages and will work with B4A and B4i.  
  
**Updates:**  
- Example updated with targetSdkVersion = 31. Note the permissions in the manifest editor:  

```B4X
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.BLUETOOTH_SCAN)  
AddPermission(android.permission.BLUETOOTH_CONNECT)
```

  
And requesting at runtime:  

```B4X
Dim Permissions As List  
Dim phone As Phone  
If phone.SdkVersion >= 31 Then  
    Permissions = Array("android.permission.BLUETOOTH_SCAN", "android.permission.BLUETOOTH_CONNECT", rp.PERMISSION_ACCESS_FINE_LOCATION)  
Else  
    Permissions = Array(rp.PERMISSION_ACCESS_FINE_LOCATION)  
End If  
For Each per As String In Permissions  
    rp.CheckAndRequest(per)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result = False Then  
        ToastMessageShow("No permission: " & Permission, True)  
        Return  
    End If  
Next
```