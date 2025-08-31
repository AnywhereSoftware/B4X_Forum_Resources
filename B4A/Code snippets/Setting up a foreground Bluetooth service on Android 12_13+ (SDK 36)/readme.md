### Setting up a foreground Bluetooth service on Android 12/13+ (SDK 36) by MbedAndroid
### 08/24/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168245/)

Struggling to get BT to work on SDK 36, and with some help of my friend Chat, we finally got it to work. I asked Chat to resume the points you have to pay attention to, if you want BT get to work on android 14+ Note: you dont need all the permissions as listed here, but Chat took my manifest to report.  
[HEADING=2]Setting up a foreground Bluetooth service on Android 12/13+ (SDK 36)[/HEADING]  
  
**1. Manifest Service Declaration**  
Use AddApplicationText to declare the service with the correct foregroundServiceType attributes:  
  
  
  

```B4X
AddApplicationText(  
  <service  
      android:name=".blth"  
      android:enabled="true"  
      android:exported="false"  
      android:foregroundServiceType="dataSync|connectedDevice"/>  
)
```

  

- dataSync is commonly needed for general foreground operations.
- connectedDevice is required for Bluetooth-connected foreground services.
- **Do not** include parentheses or quotes incorrectly—must be valid XML.
- **2. Permissions**
Make sure you declare all necessary permissions for Bluetooth and foreground operation:

```B4X
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.BLUETOOTH_ADVERTISE)  
AddPermission(android.permission.BLUETOOTH_CONNECT)  
AddPermission(android.permission.BLUETOOTH_SCAN)  
AddPermission(android.permission.REQUEST_INSTALL_PACKAGES)  
AddPermission(android.permission.ACCESS_COARSE_LOCATION)  
AddPermission(android.permission.ACCESS_MOCK_LOCATION)  
AddPermission("android.permission.FOREGROUND_SERVICE")  
AddPermission("android.permission.FOREGROUND_SERVICE_CONNECTED_DEVICE")  
AddPermission(android.permission.ACCESS_NETWORK_STATE)  
AddPermission("android.permission.RECEIVE_BOOT_COMPLETED") 'for starting service after reboot  
AddPermission("android.permission.BIND_JOB_SERVICE")
```

- FOREGROUND\_SERVICE\_CONNECTED\_DEVICE is **mandatory** for SDK 36+ if using foregroundServiceType="connectedDevice".

---

**3. Service Start Implementation (B4A)**
When starting the service, use a JavaObject to call startForeground with the correct type:
- Sub Service\_Start (StartingIntent As Intent)
If AStream.IsInitialized Then AStream.Close
AStream.InitializePrefix(Main.serial1.InputStream, False, Main.serial1.OutputStream, "AStream")
Notification1.Initialize
Notification1.Icon = "icon"
Notification1.Vibrate = False
Notification1.AutoCancel = True
Notification1.Sound = False
Notification1.SetInfo(Main.progname, Main.ProgVersion, Main)
Dim jo As JavaObject
jo.InitializeContext
If Sys.Sdk >= 29 Then
' Android 10 (API 29) ''method with 3 parameters
Dim args(3) As Object
args(0) = 1
args(1) = Notification1
args(2) = 16 ' FOREGROUND\_SERVICE\_TYPE\_CONNECTED\_DEVICE
jo.RunMethod("startForeground", args)
Else
' older versions, method with 2 parameters
Dim args(2) As Object
args(0) = 1
args(1) = Notification1
jo.RunMethod("startForeground", args)
End If
Log("BT service start")
End Sub



- args(2) = 4 corresponds to FOREGROUND\_SERVICE\_TYPE\_CONNECTED\_DEVICE.
- Make sure the notification is initialized **before** starting foreground.

---

**4. Common Pitfalls**

- **Manifest Parsing Errors:** Avoid wrapping the XML in parentheses or extra quotes in AddApplicationText.
- **Foreground Service Crash:** Happens if foregroundServiceType in manifest does **not** match the type used in startForeground.
- **Missing Permissions:** SDK 31+ enforces FOREGROUND\_SERVICE\_CONNECTED\_DEVICE for Bluetooth-connected services.
- **Initialization:** JavaObject.InitializeContext must use **context**, not Me.

---

**5. Notes**

- Tested on **SDK 36 / Android 14**: service starts correctly, no crash, and Bluetooth connection works.
- Optional: consider handling auto-reconnect and updating notifications to keep the service robust.