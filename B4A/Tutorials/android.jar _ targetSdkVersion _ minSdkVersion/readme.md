### android.jar / targetSdkVersion / minSdkVersion by Erel
### 10/18/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/87610/)

There are several versioned components that affect the compilation process and the runtime behavior of our apps.  
The purpose of this tutorial is to explain the differences between them and help you choose which version to use.  
  
Each Android version is mapped to an api level. You can see this mapping here: <https://en.wikipedia.org/wiki/Android_version_history#Overview>  
The api level is used in our code.  
  
**minSdkVersion**  
  
Set in the manifest editor. Default value is 5 (Android 2.0). This one is very simple. Your app will only run on devices running this OS version or higher.  
In most cases you can leave it with the default value or set it to 16 to target Android 4.1+ and (theoretically) lose 1% of the devices.  
  
**android.jar**  
  
Set under Tools - Configure Paths. android.jar is a referenced library. It is only used during compilation.  
It doesn't affect the runtime behavior and it will not cause your app not to run on older versions.  
Use the latest version available to avoid compilation errors.  
  
**targetSdkVersion**  
  
Set in the manifest editor.  
This one is a bit more confusing. It helps with backwards compatibility.  
I will explain it with an example. Google introduced the runtime permissions system in Android 6 (API 23). Requesting runtime permissions requires developers to update their existing apps. Forcing this feature on existing apps would have broken 90% of the apps (only when they run on Android 6+).  
The way to solve it is to check the targetSdkVersion value. If it is 22 or below then the system knows that the app doesn't handle the changes introduced in API 23+ and it runs it without those changes.  
This means that an app with targetSdkVersion set to 14 (Android 4.0) will run properly on an Android 8.0 device and it will not be required to request runtime permissions, nor handle any other breaking change.  
  
Q: Will my app run on Android 4.0 if targetSdkVersion is set to 8.0?  
A: Yes.  
  
Q: Can I use new features without setting the targetSdkVersion to a higher version?  
A: In most cases yes.  
  
The minimum version for Google Play app is 26. It will be raised to 28 on August 2019.  
  
Q: What are the consequences of raising the targetSdkVersion?  
A: There are many changes that might affect your app.  
  
The most common are:  
- 22 (?) - notifications icons colors are ignored. Alpha levels used as a mask.  
- 23 - runtime permissions (<https://www.b4x.com/android/forum/threads/runtime-permissions-android-6-0-permissions.67689/#content>)  
- 23 - Setting system settings require special handling - WRITE\_SETTINGS permission (<https://www.b4x.com/android/forum/threads/permission-write_settings.94311/#post-596846>)  
- 24 - must use FileProvider when sharing files (<https://www.b4x.com/android/forum/threads/class-fileprovider-share-files.97865/>)  
- 24 - Default background color is white (<https://www.b4x.com/android/forum/threads/version-safe-themes.87694/>)  
- 24 - Setting the volume or the ringer mode will throw an error if the user set the Do Not Disturb mode. Your app can request special access: <https://www.b4x.com/android/forum/threads/set-volume-error.92938/#post-588012>  
- 26 - notifications will not work without channels (<https://www.b4x.com/android/forum/threads/version-safe-notification.87663/>)  
- 26 - background limits. Features such as push notifications, StartServiceAt or #StartAtBoot will only work with B4A v8+.  
- 26 - installation from unknown sources requires explicit setting: <https://www.b4x.com/android/forum/threads/version-safe-apk-installation.87667/>  
- 28 - Foreground services require a new non-dangerous permission. It is added automatically if using B4A v9+.  
- 28 - The old http SDK is not available by default. This will cause problems with native libraries such as Google Maps who rely on the old SDK. To enable it: <https://www.b4x.com/android/forum/threads/solved-stdactionbar-error-in-android-9-pie.103247/#post-649875>  
- 28 - Non-ssl (non-https) communication is not permitted by default. It can be enabled in B4A v9+ by adding this line to the manifest editor:  

```B4X
CreateResourceFromFile(Macro, Core.NetworkClearText)
```

  
  
- 29 - No permission to access File.DirRootExternal, even with the STORAGE permission. For now there is a simple workaround:  

```B4X
SetApplicationAttribute(android:requestLegacyExternalStorage, true)
```

  
**It will not work with targetSdkVersion=30.** Avoid using File.DirRootExternal. Either use File.DirInternal or RuntimePermissions.GetSafeDirDefaultExternal.  
Options to access the secondary storage: <https://www.b4x.com/android/forum/threads/saveas-let-the-user-select-a-target-folder.129897/#content>  
- 29 - Foreground service declaration for "background" location tracking: <https://www.b4x.com/android/forum/threads/background-location-tracking.99873/#content>  
Note that the app is considered to be in the foreground state and you do not need to request the new special ACCESS\_BACKGROUND\_LOCATION permission.  
- 29 - BluetoothAdmin.StartDiscovery and BLEManager.StartScan require the ACCESS\_FINE\_LOCATION permission. Previously the COARSE location was enough.  
- 29 - new "dangerous" (runtime) ACTIVITY\_RECOGNITION permission required for the activity recognition service.  
- 30 - The requestLegacyExternalStorage attribute is no longer supported.  
- 31 - The user can limit the location permission to coarse even when fine is requested. Your code should handle this case: <https://www.b4x.com/android/forum/threads/b4a-v11-50-has-been-released.139288/#content>  
- 31 - Push notifications should be sent as high priority messages.  
- 31 - StartServiceAt will not work. Use StartServiceAtExact and add to manifest editor:  

```B4X
 AddPermission(android.permission.SCHEDULE_EXACT_ALARM)
```

  
- 31 - PackageManager.GetInstalledPackages no longer works without specific declarations in the manifest editor: <https://stackoverflow.com/questions/67189934/how-to-get-a-list-of-installed-apps-in-android-11>  
- 31 - Receivers replace most of the services use cases: [Receivers and Services in 2023+](https://www.b4x.com/android/forum/threads/145370/#content)  
- 33 - Notifications require permission: <https://www.b4x.com/android/forum/threads/notifications-permission-with-targetsdkversion-33.148233/>  
- 33 - NEARBY\_WIFI\_DEVICES permission instead of location permission. Relevant for hotspot: <https://www.b4x.com/android/forum/threads/start-local-hotspot.98664/#content>  
  
  
  
Q: Can I test the new behavior changes with a device running an older version of Android?  
A: **No. This means that you must test your app on devices running a recent version of Android.**  
  
Additional changes in Android 10 that are not related to the targetSdkVersion value:  

- StartActivity from a service will not work if there is no visible activity. As a workaround you can request the special "draw over apps" permission: <https://www.b4x.com/android/forum/threads/draw-on-top-of-other-apps-permission.90513/>
It will allow StartActivity to work.- Most of the device unique ids are not exposed. Two are available:
Advertising id: <https://www.b4x.com/android/forum/threads/101050/#content>
Phone.GetSettings ("android\_id") - <https://www.b4x.com/android/forum/threads/get-unique-id-for-user.124396/#content>