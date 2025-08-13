### Background location tracking by Erel
### 07/03/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/99873/)

![](https://www.b4x.com/basic4android/images/SS-2018-11-29_15.48.38.png)  
  
Simple example of a foreground service that keeps the process running in the background. The current location is shown in the persistent notification.  
  
The app starts at boot and theoretically should run all the time. It also schedules itself to run with StartServiceAt. This can help in cases where the OS kills the process.  
  
Relevant example, based on this example, which plays music in the background: <https://www.b4x.com/android/forum/threads/background-task.111106/#post-693336>  
  
Updates:  
  
- Project updated with targetSdkVersion = 34.  
This update required several changes:  

1. New non-dangerous permission:

```B4X
AddPermission(android.permission.FOREGROUND_SERVICE_LOCATION)
```

With the above change the service can be started from the activity and run theoretically forever. However if we also want to start tracking after the device is booted then we need to follow several additional steps:2. We need to receive the ACCESS\_BACKGROUND\_LOCATION permission. This is a special permission and it is granted in the settings app. We can only help the user get into the settings app - see Activity\_Resume code.
3. The Tracker service can no longer be started after boot directly. This is related to the fact that we must make it a foreground service and it is impossible to do without the ACCESS\_BACKGROUND\_LOCATION permission. So the solution is to add a Receiver that starts after boot (see manifest editor), checks whether we have the permission and then starts the service with a call to StartForegroundService sub. Note that this sub doesn't actually moves the service to the foreground state. Instead it tells the system that the target service will be moved to the foreground. This is something that is required since Android 8 and in previous cases it was possible to manage it internally.

  
- Project updated with targetSdkVersion = 33 and the handling of the new post notifications permission.