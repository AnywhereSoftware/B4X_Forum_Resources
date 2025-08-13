### Geofence - Monitoring a region in the background by Erel
### 02/01/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/84767/)

Geofencing is an Android feature that allows your app to be notified when the user enters or exits a monitored region.  
  
The nice thing about this feature is that your app doesn't need to run for monitoring to work.  
It will be started automatically when needed.  
  
The GeofenceService uses JavaObject to implement the Geofencing API: <https://developer.android.com/training/location/geofencing.html>  
  
Configuration steps  
- Add GeofenceService from the example project to your app.  
- Add this code to the manifest editor:  

```B4X
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
- Add geofences regions with code such as:  

```B4X
'Geofence regions are defined as a circle with a center point and radius.  
Sub AddGeofence  
   rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
   Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
   If Result Then  
       Dim geo As Geofence  
       geo.Initialize  
       geo.Id = "Test1"  
       geo.Center.Initialize2(32.8372, 35.2698) 'change location!  
       geo.RadiusMeters = 100  
       geo.ExpirationMs = DateTime.TicksPerDay 'expire after one day  
       CallSubDelayed3(GeofenceService, "AddGeofence", Me, geo)  
       Wait For Geofence_Added (Success As Boolean)  
       Log("Geofence added: " & Success)  
   End If  
End Sub
```

  
- Add the event subs to the starter service:  

```B4X
Public Sub Geofence_Enter (Id As String)  
   Dim n As Notification  
   n.Initialize  
   n.Icon = "icon"  
   n.SetInfo("Enter: " & Id, "Enter", Main)  
   n.Notify(1)  
   ToastMessageShow("Enter: " & Id, True)  
End Sub  
  
Public Sub Geofence_Exit (Id As String)  
   Log("Exit: " & Id)  
   ToastMessageShow("Exit: " & Id, True)  
   Dim n As Notification  
   n.Initialize  
   n.Icon = "icon"  
   n.SetInfo("Exit: " & Id, "Exit", Main)  
   n.Notify(2)  
End Sub
```

  
- Add to the main module:  

```B4X
#AdditionalJar: com.google.android.gms:play-services-location
```

  
  
Note that monitored regions are cleared when the device is restarted. You can add another service with #StartAtBoot set to true and add the regions there.  
  
**Updates:**  
  
- Uses a receiver instead of service. Services will fail on newer version of Android.