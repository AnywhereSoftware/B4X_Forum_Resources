### Android 14 / targetSdkVersion 34 and Services by Erel
### 08/05/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/162140/)

*B4A v13.0+ should be used with targetSdkVersion 34+.*  
  
Android 14 continues the longtime trend of making services less flexible and more difficult to use (converging to iOS background tasks features from 2014).  
Many of the previous use cases for services are better covered by receivers: [Receivers and Services in 2023+](https://www.b4x.com/android/forum/threads/145370/#content)  
  
Another common use case for services was to overcome the activities complex lifecycle. This is not relevant if using B4XPages, where a single activity is used and it is not paused. For non-B4XPages projects, you can continue to use the starter service for such cases. Don't use regular services as they will be killed when the app is in the background.  
  
We are mostly left with foreground services. Example: a music app that wants to continue playing while the app is in the background. By having a foreground service, the OS will not kill the process.  
  
Starting from Android 14 foreground services must have a defined foreground service type.  
The list of types is available here: <https://developer.android.com/about/versions/14/changes/fgs-types-required>  
The suitability of the selected type and the app will/might be checked by Google Play review team (thus it is less relevant for non-Google Play apps).  
  
Continuing the example of a music app: <https://developer.android.com/about/versions/14/changes/fgs-types-required#media>  
We need to add two things to the manifest editor - permission and service type:  

```B4X
AddPermission(android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK)  
SetServiceAttribute(MyMusicService, android:foregroundServiceType, "mediaPlayback")
```

  
Note that all of these permissions are non-dangerous (no need to request at runtime).  
  
There is a general "short service" type which gives your app about 3 minutes to run in the background. This can be useful for downloads or other tasks that shouldn't be interrupted.  
You can read about its requirements here: <https://developer.android.com/about/versions/14/changes/fgs-types-required#short-service>  
A new timeout event is now available and it is raised when the OS requests the service to stop being foreground:  

```B4X
'This is only needed if you have declared the foreground service type to be shortService!  
Private Sub Service_Timeout(Params As Map)  
    Service.StopForeground(NotificationId)  
End Sub
```

  
Not calling StopForeground will cause the app to crash.  
This event will only be raised on Android 14+.  
  
There is also a "special use" type which is flexible but requires Google Play reviewers approval: <https://developer.android.com/about/versions/14/changes/fgs-types-required#special-use>