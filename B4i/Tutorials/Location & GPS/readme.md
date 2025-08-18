### Location & GPS by Erel
### 02/16/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/46148/)

The iLocation library allows you to get the current known location and to monitor location updates. You can also monitor the device heading direction.  
  
As the location is considered a private information, you can only get the location if the user has allowed you to get the location. This type of authorization is different than Android permissions system. At runtime the user can decide whether to allow your app do use this service or not.  
  
![](http://www.b4x.com/basic4android/images/SS-2014-10-27_15.33.40.png)  
  
The AuthorizationStatusChanged event is raised after you initialize LocationManager. It will also be raised after the user has changed the authorization status from the device settings (Under Privacy - Location Services).  
  
The authorization status can be in one of the following states:  
- Not determined - This will be the status when the user first runs your app. You should call LocationManager.Start. The user will be asked to approve it.  
- Authorized - The user has already allowed your app to use this service.  
- Not authorized - You need to ask the user to go to the settings page and enabled this service.  
  

```B4X
Private Sub LocManager_AuthorizationStatusChanged (Status As Int)  
   lblEnable.Visible = (LocManager.AuthorizationStatus = LocManager.AUTHORIZATION_DENIED _  
     OR LocManager.AuthorizationStatus = LocManager.AUTHORIZATION_RESTRICTED)  
   StartLocationUpdates  
End Sub  
  
Private Sub StartLocationUpdates  
   'if the user allowed us to use the location service or if we never asked the user before then we call LocationManager.Start.  
   If LocManager.IsAuthorized OR LocManager.AuthorizationStatus = LocManager.AUTHORIZATION_NOT_DETERMINED Then  
     LocManager.Start(0)  
   End If  
   LocManager.StartHeading  
End Sub
```

  
  
Note that you can safely call Start multiple times.  
  
Once we are authorized to use the location service we can start to work with the LocationChanged event.  
  
It will fire once with the last known location and then whenever there is a new known location.  
  
![](http://www.b4x.com/basic4android/images/SS-2014-10-27_15.53.21.png)  
  
**Notes  
-** Monitoring the device heading doesn't require any special permission.  
- If the heading accuracy is important then you need to handle the AllowCalibration event and return true:  

```B4X
Sub LocManager_AllowCalibration As Boolean  
   Return True  
End Sub
```

  
The device built-in calibration screen may show if calibration is required.  
- You need to add the following two lines to your app:  

```B4X
  #PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>Used to display the current navigation data.</string>  
   #PlistExtra:<key>NSLocationUsageDescription</key><string>Used to display the current navigation data.</string>
```

  
This message will be displayed to the user, explaining why the location services are required. The first line is for iOS 8+ and the second is for iOS 7.