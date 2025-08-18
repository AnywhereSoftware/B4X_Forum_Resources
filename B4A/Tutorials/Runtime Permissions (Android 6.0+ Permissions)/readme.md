### Runtime Permissions (Android 6.0+ Permissions) by Erel
### 03/16/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/67689/)

**1. Edit: In B4XPages the permission result event signature is:** Wait For B4XPage\_PermissionResult (Permission As String, Result As Boolean)  
2. Important to read: <https://www.b4x.com/android/forum/threads/android-jar-targetsdkversion-minsdkversion.87610/#content>  
  
[MEDIA=vimeo]261306184[/MEDIA]  
  
  
If the targetSdkVersion is lower than 23 then the standard permissions system will be used on all devices including Android 6+, however soon all Google Play apps will need to set the targetSdkVersion to 26+.  
  
B4A v6.0 adds support for runtime permissions. The nice thing about runtime permissions is that the user is not asked for any permission when they install your application from Google Play. Instead they will be asked to approve "dangerous" permissions at runtime.  
  
Luckily most permissions are not considered dangerous. You can see the list of permissions that are considered dangerous here: <https://developer.android.com/guide/topics/permissions/overview.html#permission-groups>  
  
  
  
![](https://www.b4x.com/android/forum/attachments/44797)  
  
The CheckAndRequest method can only be called from an Activity.  
There is another method named Check that only tests whether the permission has already been approved or not. This method can be called from any module.  
It might be tempting to first test whether there is a permission and only if there is no permission call CheckAndRequest. However it will just make the program flow more complicated as you will need to deal with all cases anyway.  
As a general rule, you shouldn't call RuntimePermissions.Check from an Activity. It will be simpler to always call CheckAndRequest.  
  
**Listing the permissions**  
  
Not many are aware to the fact that you can see the project permissions by clicking on the List Permissions button that is inside the Logs tab:  
**A very common mistake is to request a permission at runtime that is not listed in the "permissions dialog". It will not work.**  
![](https://www.b4x.com/basic4android/images/SS-2016-06-08_15.06.00.png)  
  
The dangerous permissions are marked with \* (in B4A v6+).  
You don't need to ask for non-dangerous permissions.  
  
**READ\_EXTERNAL\_STORAGE / WRITE\_EXTERNAL\_STORAGE**  
  
This is the most common dangerous permission. It is added automatically when you use File.DirDefaultExternal or File.DirRootExternal.  
However there is a simple workaround for this.  
  
1. Use RuntimePermissions.GetSafeDirDefaultExternal("") instead of File.DirDefaultExternal. The parameter passed is an optional subfolder that will be created under the default folder.  
  
2. Add this code to the manifest editor:  

```B4X
AddManifestText(  
<uses-permission  
  android:name="android.permission.WRITE_EXTERNAL_STORAGE"  
  android:maxSdkVersion="19" />  
)
```

  
The explanation for this is that GetSafeDirDefaultExternal doesn't require any permission on Android 4.4+ (API 19) and requires the WRITE\_EXTERNAL\_STORAGE on older versions. The code above adds the permission to older devices.  
  
You only need to deal with WRITE\_EXTERNAL\_STORAGE at runtime if you need access to a folder other than the app's default external folder.  
  
Notes & tips:  
  
- You can only request permissions that were declared in the manifest file (this is usually taken care by the compiler).  
- Testing the permissions can be confusing as the user only needs to give permissions once. The solution is to uninstall the app from the device. Click on Ctrl + P (clean project) in the IDE and run again.  
- The user actually approves groups of permissions. So if the user has approved the read contacts permission they will not be asked to approve the write contacts permission.  
- Once you've uploaded your app to Google Play with targetSdkVersion set to 23 you cannot downgrade the target version back.  
- Some Android 4.4 (API 19) devices do not allow access to RuntimePermissions.GetSafeDirDefaultExternal without explicit permission although they should. It it therefore recommended to set android:maxSdkVersion to 19 in the version based permission. It was previously set to 18.