### targetSdkVersion 34 foreground service for mediaPlayback by Addo
### 07/04/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161948/)

by following [USER=1]@Erel[/USER] Update on this Post <https://www.b4x.com/android/forum/threads/background-location-tracking.99873/#post-993226>  
  
targeting Sdkversion = 34, if you have a foregroundservice that do media play back in the background you will need to add this to your manifest in order to migrate to targetsdk 34  
  

```B4X
' sdk 34  
SetServiceAttribute(Your_Service_Name, android:foregroundServiceType, "mediaPlayback")  
AddPermission(android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK)
```

  
  
Starting service Code  
  

```B4X
Private Sub StartForegroundService(Service As Object)  
    Dim p As Phone  
    If p.SdkVersion <= 26 Then  
        StartService(Service)  
        Return  
    End If  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim intent As JavaObject  
    intent.InitializeNewInstance("android.content.Intent", Array(ctxt, Service))  
    ctxt.RunMethod("startForegroundService", Array(intent))  
End Sub
```

  
  
  
here is a list of foreground service types.  
  
<https://developer.android.com/develop/background-work/services/fg-service-types>  
  
in short  
  

```B4X
[camera=64, connectedDevice=16, dataSync=1, location=8, mediaPlayback=2, mediaProjection=32, microphone=128, phoneCall=4]
```

  
  
this code may not be useful on the next B4a Release, have a great day.