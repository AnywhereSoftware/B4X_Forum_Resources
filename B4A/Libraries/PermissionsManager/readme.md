### PermissionsManager by Ivica Golubovic
### 05/15/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/145185/)

**PermissionsManager** is a library that enables the management of runtime permissions. This library completely replaces the standard **RuntimePermissions** library with the addition of modern dangerous permissions and special permissions that require approval via the settings application.  
  
This library contains constants for:  

1. **Dangerous** permissions,
2. **Special** permissions.

  
For both types of permissions, the request principle is the same and is performed via one of the CheckAndRequestPermission methods. Example:  

```B4X
Dim PM As PermissionsManager  
PM.CheckAndRequestPermission(PermissionsManager.DANGEROUS_WRITE_EXTERNAL_STORAGE)  
Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
'or  
'Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
If Result Then  
    'Allowed  
End If
```

  

```B4X
Dim PM As PermissionsManager  
PM.CheckAndRequestPermission(PermissionsManager.SPECIAL_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)  
Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
'or  
'Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
If Result Then  
    'Allowed  
End If
```

  
Of course, all permissions must be declared in the manifest, either automatically or manually.  
  
As of version 1.2, the **PermissionsManagerFileProvider** class is included in the library. This **FileProvider** reduces the size of the final application by 0.5MB compared to the standard **B4A FileProvider**. This is made possible by wrapping the **FileProvider** class from the **androidx.core:core** package.  
  
As of version 1.3, the **PermissionsManagerFileProvider** class is replaced with **FileProvider** static class module (B4X module).  
  
To use **FileProvider** add the following lines to the manifest:  

```B4X
AddApplicationText(  
<provider  
android:name="igolub.permissionmanager.b4a.PMFileProvider"  
android:authorities="$PACKAGE$.provider"  
android:exported="false"  
android:grantUriPermissions="true">  
<meta-data  
android:name="android.support.FILE_PROVIDER_PATHS"  
android:resource="@xml/provider_paths"/>  
</provider>  
)  
CreateResource(xml, provider_paths,  
<files-path name="name" path="shared" />  
)
```

  
  
**PermissionsManager  
Author:** Ivica Golubovic  
**Version:** 1.3  

- **FileProvider**
*Copy next lines to manifest:<code>  
 AddApplicationText(  
 <provider  
 android:name="igolub.permissionmanager.b4a.PMFileProvider"  
 android:authorities="$PACKAGE$.provider"  
 android:exported="false"  
 android:grantUriPermissions="true">  
 <meta-data  
 android:name="android.support.FILE\_PROVIDER\_PATHS"  
 android:resource="@xml/provider\_paths"/>  
 </provider>  
 )  
 CreateResource(xml, provider\_paths,  
 <files-path name="name" path="shared" />  
 )  
 </code>*

- **Functions:**

- **GetFileUri** (FileName As String) As Object
- **SetFileUriAsIntentData** (mIntent As Intent, FileName As String)

- **Properties:**

- **SharedFolder** As String [read only]
- **UseFileProvider** As Boolean [read only]

- **PermissionsManager**

- **Fields:**

- **DANGEROUS\_ACCEPT\_HANDOVER** As String
*Allows a calling application to continue a call which was started in another application. An example is a video calling application that wants to continue a voice call on the user's mobile network.  
 Constant Value: "android.permission.ACCEPT\_HANDOVER".  
 Add line to manifest: <code>AddPermission("android.permission.ACCEPT\_HANDOVER")</code>  
 Added in API level 28.*- **DANGEROUS\_ACCESS\_BACKGROUND\_LOCATION** As String
*Allows an application To access location in the background. If you're requesting this permission, you must also request either ACCESS\_COARSE\_LOCATION or ACCESS\_FINE\_LOCATION. Requesting this permission by itself doesn't give you location access.  
 Constant Value: "android.permission.ACCESS\_BACKGROUND\_LOCATION".  
 Add line to manifest: <code>AddPermission("android.permission.ACCESS\_BACKGROUND\_LOCATION")</code>  
 Added in API level 29..*- **DANGEROUS\_ACCESS\_COARSE\_LOCATION** As String
*Allows an application To access approximate location. Alternatively, you might want ACCESS\_FINE\_LOCATION.  
 Constant Value: "android.permission.ACCESS\_COARSE\_LOCATION".  
 Add line to manifest: <code>AddPermission("android.permission.ACCESS\_COARSE\_LOCATION")</code>  
 Added in API level 1.*- **DANGEROUS\_ACCESS\_FINE\_LOCATION** As String
*Allows an application to access precise location. Alternatively, you might want ACCESS\_COARSE\_LOCATION.  
 Constant Value: "android.permission.ACCESS\_FINE\_LOCATION".  
 Add line to manifest: <code>AddPermission("android.permission.ACCESS\_FINE\_LOCATION")</code>  
 Added in API level 1.*- **DANGEROUS\_ACCESS\_MEDIA\_LOCATION** As String
*Allows an application to access any geographic locations persisted in the user's shared collection.  
 Constant Value: "android.permission.ACCESS\_MEDIA\_LOCATION".  
 Add line to manifest: <code>AddPermission("android.permission.ACCESS\_MEDIA\_LOCATION")</code>  
 Added in API level 29.*- **DANGEROUS\_ACTIVITY\_RECOGNITION** As String
*Allows an application to recognise physical activity.  
 Constant Value: "android.permission.ACTIVITY\_RECOGNITION".  
 Add line to manifest: <code>AddPermission("android.permission.ACTIVITY\_RECOGNITION")</code>  
 Added in API level 29.*- **DANGEROUS\_ADD\_VOICEMAIL** As String
*Allows an application to add voice mails into the system.  
 Constant Value: "com.android.voicemail.permission.ADD\_VOICEMAIL".  
 Add line to manifest: <code>AddPermission("com.android.voicemail.permission.ADD\_VOICEMAIL")</code>  
 Added in API level 14.*- **DANGEROUS\_ANSWER\_PHONE\_CALLS** As String
*Allows the application to answer an incoming phone call.  
 Constant Value: "android.permission.ANSWER\_PHONE\_CALLS".  
 Add line to manifest: <code>AddPermission("android.permission.ANSWER\_PHONE\_CALLS")</code>  
 Added in API level 26.*- **DANGEROUS\_BLUETOOTH\_ADVERTISE** As String
*Required to be able to advertise to nearby Bluetooth devices.  
 Constant Value: "android.permission.BLUETOOTH\_ADVERTISE".  
 Add line to manifest: <code>AddPermission("android.permission.BLUETOOTH\_ADVERTISE")</code>  
 Added in API level 31.*- **DANGEROUS\_BLUETOOTH\_CONNECT** As String
*Required to be able to connect to paired Bluetooth devices.  
 Constant Value: "android.permission.BLUETOOTH\_CONNECT".  
 Add line to manifest: <code>AddPermission("android.permission.BLUETOOTH\_CONNECT")</code>  
 Added in API level 31.*- **DANGEROUS\_BLUETOOTH\_SCAN** As String
*Required to be able to discover and pair nearby Bluetooth devices.  
 Constant Value: "android.permission.BLUETOOTH\_SCAN".  
 Add line to manifest: <code>AddPermission("android.permission.BLUETOOTH\_SCAN")</code>  
 Added in API level 31.*- **DANGEROUS\_BODY\_SENSORS** As String
*Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate.  
 Constant Value: "android.permission.BODY\_SENSORS".  
 Add line to manifest: <code>AddPermission("android.permission.BODY\_SENSORS")</code>  
 Added in API level 20.*- **DANGEROUS\_BODY\_SENSORS\_BACKGROUND** As String
*Allows an application to access data from sensors that the user uses to measure what is happening inside their body, such as heart rate. If you're requesting this permission, you must also request BODY\_SENSORS. Requesting this permission by itself doesn't give you Body sensors access.  
 Constant Value: "android.permission.BODY\_SENSORS\_BACKGROUND".  
 Add line to manifest: <code>AddPermission("android.permission.BODY\_SENSORS\_BACKGROUND")</code>  
 Added in API level 33.*- **DANGEROUS\_CALL\_PHONE** As String
*Allows an application to initiate a phone call without going through the Dialler user interface for the user to confirm the call.  
 Constant Value: "android.permission.CALL\_PHONE".  
 Add line to manifest: <code>AddPermission("android.permission.CALL\_PHONE")</code>  
 Added in API level 1.*- **DANGEROUS\_CAMERA** As String
*Required to be able to access the camera device. This will automatically enforce the uses-feature manifest element for all camera features. If you do not require all camera features or can properly operate if a camera is not available, then you must modify your manifest as appropriate in order to install on devices that don't support all camera features.  
 Constant Value: "android.permission.CAMERA".  
 Add line to manifest: <code>AddPermission("android.permission.CAMERA")</code>  
 Added in API level 1.*- **DANGEROUS\_GET\_ACCOUNTS** As String
*Allows access to the list of accounts in the Accounts Service.  
 Constant Value: "android.permission.GET\_ACCOUNTS".  
 Add line to manifest: <code>AddPermission("android.permission.GET\_ACCOUNTS")</code>  
 Added in API level 1.*- **DANGEROUS\_NEARBY\_WIFI\_DEVICES** As String
*Required to be able to advertise and connect to nearby devices via Wi-Fi.  
 Constant Value: "android.permission.NEARBY\_WIFI\_DEVICES".  
 Add line to manifest: <code>AddPermission("android.permission.NEARBY\_WIFI\_DEVICES")</code>  
 Added in API level 33.*- **DANGEROUS\_POST\_NOTIFICATIONS** As String
*Allows an application to post notifications.  
 Constant Value: "android.permission.POST\_NOTIFICATIONS".  
 Add line to manifest: <code>AddPermission("android.permission.POST\_NOTIFICATIONS")</code>  
 Added in API level 33.*- **DANGEROUS\_PROCESS\_OUTGOING\_CALLS** As String
*Allows an application to see the number being dialled during an outgoing call with the option to redirect the call to a different number or abort the call altogether.  
 Constant Value: "android.permission.PROCESS\_OUTGOING\_CALLS".  
 Add line to manifest: <code>AddPermission("android.permission.PROCESS\_OUTGOING\_CALLS")</code>  
 Added in API level 1.  
 Deprecated in API level 29.*- **DANGEROUS\_READ\_CALENDAR** As String
*Allows an application to read the user's calendar data.  
 Constant Value: "android.permission.READ\_CALENDAR".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_CALENDAR")</code>  
 Added in API level 1.*- **DANGEROUS\_READ\_CALL\_LOG** As String
*Allows an application to read the user's call log.  
 Constant Value: "android.permission.READ\_CALL\_LOG".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_CALL\_LOG")</code>  
 Added in API level 16.*- **DANGEROUS\_READ\_CONTACTS** As String
*Allows an application to read the user's contacts data.  
 Constant Value: "android.permission.READ\_CONTACTS".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_CONTACTS")</code>  
 Added in API level 1.*- **DANGEROUS\_READ\_EXTERNAL\_STORAGE** As String
*Allows an application to read from external storage. Note: Starting in API level 33, this permission has no effect. If your app accesses other apps' media files, request one or more of these permissions instead: READ\_MEDIA\_IMAGES, READ\_MEDIA\_VIDEO, READ\_MEDIA\_AUDIO.  
 Starting in API level 29, applications don't need to request this permission to access files in their app-specific directory on external storage, or their own files in the MediaStore. Apps shouldn't request this permission unless they need to access other apps' files in the MediaStore.  
 Constant Value: "android.permission.READ\_EXTERNAL\_STORAGE".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_EXTERNAL\_STORAGE")</code>  
 Added in API level 16.*- **DANGEROUS\_READ\_MEDIA\_AUDIO** As String
*Allows an application to read audio files from external storage.  
 Constant Value: "android.permission.READ\_MEDIA\_AUDIO".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_MEDIA\_AUDIO")</code>  
 Added in API level 33.*- **DANGEROUS\_READ\_MEDIA\_IMAGES** As String
*Allows an application to read image files from external storage.  
 Constant Value: "android.permission.READ\_MEDIA\_IMAGES".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_MEDIA\_IMAGES")</code>  
 Added in API level 33.*- **DANGEROUS\_READ\_MEDIA\_VIDEO** As String
*Allows an application to read video files from external storage.  
 Constant Value: "android.permission.READ\_MEDIA\_VIDEO".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_MEDIA\_VIDEO")</code>  
 Added in API level 33.*- **DANGEROUS\_READ\_PHONE\_NUMBERS** As String
*Allows read access to the device's phone number(s). This is a subset of the capabilities granted by READ\_PHONE\_STATE but is exposed to instant applications.  
 Constant Value: "android.permission.READ\_PHONE\_NUMBERS".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_PHONE\_NUMBERS")</code>  
 Added in API level 26.*- **DANGEROUS\_READ\_PHONE\_STATE** As String
*Allows read only access to phone state, including the current cellular network information, the status of any ongoing calls, and a list of any PhoneAccounts registered on the device.  
 Constant Value: "android.permission.READ\_PHONE\_STATE".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_PHONE\_STATE")</code>  
 Added in API level 1.*- **DANGEROUS\_READ\_SMS** As String
*Allows an application to read SMS messages.  
 Constant Value: "android.permission.READ\_SMS".  
 Add line to manifest: <code>AddPermission("android.permission.READ\_SMS")</code>  
 Added in API level 1.*- **DANGEROUS\_RECEIVE\_MMS** As String
*Allows an application to monitor incoming MMS messages.  
 Constant Value: "android.permission.RECEIVE\_MMS".  
 Add line to manifest: <code>AddPermission("android.permission.RECEIVE\_MMS")</code>  
 Added in API level 1.*- **DANGEROUS\_RECEIVE\_SMS** As String
*Allows an application to receive SMS messages.  
 Constant Value: "android.permission.RECEIVE\_SMS".  
 Add line to manifest: <code>AddPermission("android.permission.RECEIVE\_SMS")</code>  
 Added in API level 1.*- **DANGEROUS\_RECEIVE\_WAP\_PUSH** As String
*Allows an application to receive WAP push messages.  
 Constant Value: "android.permission.RECEIVE\_WAP\_PUSH".  
 Add line to manifest: <code>AddPermission("android.permission.RECEIVE\_WAP\_PUSH")</code>  
 Added in API level 1.*- **DANGEROUS\_RECORD\_AUDIO** As String
*Allows an application to record audio.  
 Constant Value: "android.permission.RECORD\_AUDIO".  
 Add line to manifest: <code>AddPermission("android.permission.RECORD\_AUDIO")</code>  
 Added in API level 1.*- **DANGEROUS\_SEND\_SMS** As String
*Allows an application to send SMS messages.  
 Constant Value: "android.permission.SEND\_SMS".  
 Add line to manifest: <code>AddPermission("android.permission.SEND\_SMS")</code>  
 Added in API level 1.*- **DANGEROUS\_USE\_SIP** As String
*Allows an application to use SIP service.  
 Constant Value: "android.permission.USE\_SIP".  
 Add line to manifest: <code>AddPermission("android.permission.USE\_SIP")</code>  
 Added in API level 9.*- **DANGEROUS\_UWB\_RANGING** As String
*Required to be able to range to devices using ultra-wideband.  
 Constant Value: "android.permission.UWB\_RANGING".  
 Add line to manifest: <code>AddPermission("android.permission.UWB\_RANGING")</code>  
 Added in API level 31.*- **DANGEROUS\_WRITE\_CALENDAR** As String
*Allows an application to write the user's calendar data.  
 Constant Value: "android.permission.WRITE\_CALENDAR".  
 Add line to manifest: <code>AddPermission("android.permission.WRITE\_CALENDAR")</code>  
 Added in API level 1.*- **DANGEROUS\_WRITE\_CALL\_LOG** As String
*Allows an application to write (but not read) the user's call log data.  
 Constant Value: "android.permission.WRITE\_CALL\_LOG".  
 Add line to manifest: <code>AddPermission("android.permission.WRITE\_CALL\_LOG")</code>  
 Added in API level 16.*- **DANGEROUS\_WRITE\_CONTACTS** As String
*Allows an application to write the user's contacts data.  
 Constant Value: "android.permission.WRITE\_CONTACTS".  
 Add line to manifest: <code>AddPermission("android.permission.WRITE\_CONTACTS")</code>  
 Added in API level 1.*- **DANGEROUS\_WRITE\_EXTERNAL\_STORAGE** As String
*Allows an application to write to external storage. Note: If your application targets API level 29 or higher, this permission has no effect.  
 Constant Value: "android.permission.WRITE\_EXTERNAL\_STORAGE".  
 Add line to manifest: <code>AddPermission("android.permission.WRITE\_EXTERNAL\_STORAGE")</code>  
 Added in API level 4.*- **SPECIAL\_APP\_NOTIFICATION** As String
*Show notification settings for a single application (in most case's it's unrestricted by default).  
 Constant Value: "android.settings.APP\_NOTIFICATION\_SETTINGS"  
 Added in API level 26.*- **SPECIAL\_APP\_NOTIFICATION\_BUBBLE** As String
*Show notification bubble settings for a single application.  
 Constant Value: "android.settings.APP\_NOTIFICATION\_BUBBLE\_SETTINGS"  
 Added in API level 29.*- **SPECIAL\_IGNORE\_BACKGROUND\_DATA\_RESTRICTIONS** As String
*Show screen for controlling background data restrictions for a particular application (in most case's it's unrestricted by default).  
 Constant Value: "android.settings.IGNORE\_BACKGROUND\_DATA\_RESTRICTIONS\_SETTINGS"  
 Add line to manifest: <code>AddPermission("android.permission.ACCESS\_NETWORK\_STATE")</code>  
 Added in API level 24.*- **SPECIAL\_INSTALL\_FROM\_UNKNOWN\_SOURCES** As String
*Allows to install applications from unknown sources.  
 Added in API level 1.  
 Deprecated in API level 26. Use SPECIAL\_REQUEST\_INSTALL\_PACKAGES instead.  
 Use this permission only for devices up to SDK25. In higher SDK versions, this setting does not exist and during the check, the return result will always be False.*- **SPECIAL\_MANAGE\_EXTERNAL\_STORAGE** As String
*Allows an application a broad access to external storage in scoped storage. Intended to be used by few applications that need to manage files on behalf of the users.  
 Constant Value: "android.permission.MANAGE\_EXTERNAL\_STORAGE".  
 Add line to manifest: <code>AddPermission("android.permission.MANAGE\_EXTERNAL\_STORAGE")</code>  
 Added in API level 30.*- **SPECIAL\_MANAGE\_MEDIA** As String
*Allows an application to modify and delete media files on this device or any connected storage device without user confirmation.  
 IMPORTANT: Applications must already be granted the READ\_EXTERNAL\_STORAGE or MANAGE\_EXTERNAL\_STORAGE permissions for this permission to take effect.  
 Constant Value: "android.permission.MANAGE\_MEDIA".  
 Add line to manifest: <code>AddPermission("android.permission.MANAGE\_MEDIA")</code>  
 Added in API level 31.*- **SPECIAL\_PACKAGE\_USAGE\_STATS** As String
*Allows an application to collect component usage statistics.  
 Constant Value: "android.permission.PACKAGE\_USAGE\_STATS".  
 Add line to manifest: <code>AddPermission("android.permission.PACKAGE\_USAGE\_STATS")</code>  
 Added in API level 23.*- **SPECIAL\_REQUEST\_IGNORE\_BATTERY\_OPTIMIZATIONS** As String
*Constant Value: "android.permission.REQUEST\_IGNORE\_BATTERY\_OPTIMIZATIONS".  
 Add line to manifest: <code>AddPermission("android.permission.REQUEST\_IGNORE\_BATTERY\_OPTIMIZATIONS")</code>  
 Added in API level 23.*- **SPECIAL\_REQUEST\_INSTALL\_PACKAGES** As String
*Allows an application to request installing packages. Applications targeting APIs greater than 25 must hold this permission in order to use Intent.ACTION\_INSTALL\_PACKAGE.  
 Constant Value: "android.permission.REQUEST\_INSTALL\_PACKAGES".  
 Add line to manifest: <code>AddPermission("android.permission.REQUEST\_INSTALL\_PACKAGES")</code>  
 Added in API level 26.  
 For lower SDK devices use SPECIAL\_INSTALL\_FROM\_UNKNOWN\_SOURCES.*- **SPECIAL\_SCHEDULE\_EXACT\_ALARM** As String
*Allows applications to use exact alarm APIs.  
 This is a special access permission that can be revoked by the system or the user. It should only be used to enable user-facing features that require exact alarms.  
 Constant Value: "android.permission.SCHEDULE\_EXACT\_ALARM".  
 Add line to manifest: <code>AddPermission("android.permission.SCHEDULE\_EXACT\_ALARM")</code>  
 Added in API level 31.*- **SPECIAL\_SYSTEM\_ALERT\_WINDOW** As String
*Allows an application to be shown on top of all other applications. Very few applications should use this permission; these windows are intended for system-level interaction with the user.  
 Constant Value: "android.permission.SYSTEM\_ALERT\_WINDOW".  
 Add line to manifest: <code>AddPermission("android.permission.SYSTEM\_ALERT\_WINDOW")</code>  
 Added in API level 1.*- **SPECIAL\_WRITE\_SETTINGS** As String
*Allows an application to read or write the system settings.  
 Constant Value: "android.permission.WRITE\_SETTINGS".  
 Add line to manifest: <code>AddPermission("android.permission.WRITE\_SETTINGS")</code>  
 Added in API level 1*
- **PermissionsManager**

- **Events:**

- **ApplicationResumeAllowed**

- **Functions:**

- **CheckAndRequestPermission** (Permission As String)
*Checks whether the application has been granted the specified permission. If not then the user will be shown a dialog asking for permission.  
 The Activity\_PermissionResult or B4XPage\_PermissionResult will be raised with the result (in all cases).  
 This method can only be called from an Activity.*- **CheckAndRequestPermission2** (Permission As String, DescriptionDialogText As String, DescriptionDialogTitle As String, DialogCloseButtonText As String)
*Checks whether the application has been granted the specified permission. If not, dialog with specified DescriptionText and Title will be shown in which you can explain to user for what the application requires this permission. After user closes dialog, a default dialog with asking for permission will be shown.  
 The Activity\_PermissionResult or B4XPage\_PermissionResult will be raised with the result (in all cases).  
 This method can only be called from an Activity.*- **CheckPermission** (Permission As String) As Boolean
*Checks whether the application has been granted the specified permission.  
 This method can be called from a Service.*- **GetAllSafeDirsExternal** (subFolder As String) As List
*Returns an List with all the external folders available to your application.   
 The first element will be the same as the value returned from GetSafeDirDefaultExternal.  
 On Android 4.4+ no permission is required to access these folders.  
 On older versions only one folder will be returned. You should add the permission as explained in GetSafeDirDefaultExternal documentation.  
 SubFolder - A sub folder that will be created for your application. Pass an empty string if not needed.*- **GetSafeDirDefaultExternal** (subFolder As String) As String
*Returns the path to the app's default folder on the secondary storage device.  
 The path to File.DirInternal will be returned if there is no secondary storage available.  
 It is a better alternative to File.DirDefaultExternal. On Android 4.4+ no permission is required to access this folder.  
 SubFolder - A sub folder that will be created for your application. Pass an empty string if not needed.*- **IsDangerous** (Permission As String) As Boolean
*Check if the permission is Dangerous permission.*- **IsDangerousOrSpecial** (Permission As String) As Boolean
*Check if the permission is Special or Dangerous permission.*- **IsSpecial** (Permission As String) As Boolean
*Check if the permission is Special permission.*
- **Properties:**

- **AllPermissionsInManifestFile** As List [read only]
*Returns the List of all permissions specified in manifest file. You can use this list to ask for all permissions in manifest at the same time.  
 Example: <code>  
 For Each permission As String In PermissionManager1.AllPermissionsInManifestFile  
 PermissionManager1.CheckAndRequestPermission(permission)  
 Wait For Activity\_PermissionResult (permission As String, Result As Boolean)  
 Next</code>*- **ApplicationResumeAllowed** As Boolean
*You can use this property to prevent the application to resume until the permissions requesting process will finish. Before start of permissions requesting process you need to set this value to False. When permissions process is finished, you must set this value to True. PermissionsManager\_ApplicationResumeAllowed event will be triggered when you set value to True. Default value is True.  
 Example: <code>  
 PermissionManager1.ApplicationResumeAllowed=False 'Start preventing Application to resume.  
 For Each permission As String In PermissionManager1.AllPermissionsInManifestFile  
 PermissionManager1.CheckAndRequestPermission(permission)  
 Wait For Activity\_PermissionResult (permission As String, Result As Boolean)  
 Next  
 PermissionManager1.ApplicationResumeAllowed=True 'Stop preventing Application to resume.</code>  
 On Activity\_Resume or other part of code for which you want to prevent to resume until permissions requesting process is ended:  
 Example:<code>  
 If PermissionsManager1.ApplicationResumeAllowed=False Then  
 Wait For PermissionsManager\_ApplicationResumeAllowed   
 End If  
 'Rest of the code…</code>*- **DeviceSDK** As Int [read only]
*Returns the integer value of device's SDK version.  
 You don't need Phone library.*
  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>