### Geofence - Monitoring a region by Erel
### 10/28/2019
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/81464/)

This example extends iLocation library to allow monitoring regions in the background.  
  
The code is pretty simple. You first need to create a circular region which you want to track and then call MonitorRegion to start tracking it.  
  
The RegionEnter / RegionExit events will be raised, even if the app is in the background.  
The StateChanged event is called once after each call to MonitorRegion.  
  
A few notes:  
- The minimum radius is 100 meters. The OS uses less accurate means to determine the location so it is not very accurate. You can start another app that uses the GPS while testing it.  
- The example tracks a single region. You can track up to 20 regions.  
- Don't kill the app with a swipe as it will prevent it from being started.  
- Run your app in release mode if you want to test the background behavior. It should show a notification when the app is in the background and it detects a state change.  
- No special background mode is required.  
  
  
You need to add these lines to the example:  

```B4X
#PlistExtra:<key>NSLocationAlwaysAndWhenInUseUsageDescription</key><string>Monitor some region.</string>  
#PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>Monitor some region.</string>
```