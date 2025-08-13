### Device Administrator library by Erel
### 08/09/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/19208/)

Starting from Android 2.2 (api level 8), Android allows application to be registered as administrators.  
Administrator apps have the following special features:  
- Manually lock the screen  
- Set the minimum password length and quality  
- Wipe the entire device  
- Set the maximum allowed time before the device locks  
- Request the user to change password  
- Manually set a new password  
- Disable the camera  
- Track password changes  
- Some other security features as described [here](http://developer.android.com/intl/fr/guide/topics/admin/device-admin.html).  
  
Note that the password is the screen lock password (other passwords are not affected).  
  
The user needs to enable the admin app before it can have any special privileges.  
This is done either by calling Manager.Enable or from the Security settings page.  
The user will see a message with the policies that this app requests:  
  
![](http://www.b4x.com/basic4android/images/SS-2012-07-02_17.35.01.png)  
  
The user can always disable an administrator app from the Security settings page. The idea is that in your app you should check whether the admin is enabled and the password meets the requirements. If they don't then you do not give access to some resource such as the company's server.  
  
**How to**  
A working example is attached to this project. It is recommended to start with it.  
Add the following code to the manifest editor:  
  

```B4X
AddApplicationText(<receiver android:name="anywheresoftware.b4a.objects.AdminReceiver2"  
  android:permission="android.permission.BIND_DEVICE_ADMIN"  
  android:exported="true">  
  <meta-data android:name="android.app.device_admin"  
  android:resource="@xml/device_admin" />  
  <intent-filter>  
  <action android:name="android.app.action.DEVICE_ADMIN_ENABLED" />  
  </intent-filter>  
</receiver>)  
  
CreateResource(xml, device_admin.xml,  
<device-admin xmlns:android="http://schemas.android.com/apk/res/android">  
  <uses-policies>  
  <limit-password />  
  <reset-password />  
  <force-lock />  
  </uses-policies>  
</device-admin>  
)
```

  
  
3. Declare an AdminManager object. With this object you can ask the user to enable the admin app and access the special privileges.  
  
4. (optional) Add a service named ManagerService. This service will allow you to track password changes and changes to the admin app enabled status. See the attached example.  
  
  
The latest version of this library is included in the IDE.  
  
**Upgrading from v1.00**  
  
The receiver name has changed. You need to update the manifest editor code.  
The user will probably need to re-enable the admin app. V1.00 library is attached to allow developers to keep the previous version if prefered.