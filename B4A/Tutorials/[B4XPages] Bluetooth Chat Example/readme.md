### [B4XPages] Bluetooth Chat Example by Erel
### 06/22/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/119014/)

![](https://www.b4x.com/android/forum/attachments/95662)  
  
Updated implementation, based on B4XPages of <https://www.b4x.com/android/forum/threads/android-bluetooth-bluetoothadmin-tutorial.14768/#content>.  
  
The code is much simpler compared to the previous example.  
Note that you can call Serial.Listen without making the device discoverable. This is useful for cases where the devices were already paired once.  
  
**Updates:**  
  
- Example updated with targetSdkVersion 33. Note the new method to enable Bluetooth if needed.  
- Example updated with targetSdkVersion 31 requirements.  
Note the new permissions in the manifest editor:  

```B4X
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.BLUETOOTH_ADVERTISE)  
AddPermission(android.permission.BLUETOOTH_CONNECT)  
AddPermission(android.permission.BLUETOOTH_SCAN)
```

  
These are runtime permissions and are requested at runtime.  
  
![](https://www.b4x.com/android/forum/attachments/143132)