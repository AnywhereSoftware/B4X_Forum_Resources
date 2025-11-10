### GoogleMaps Tutorial by Erel
### 11/05/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/47019/)

The iGoogleMaps library allows you to show a map inside your app:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-11-17_09.18.50.png)  
  
It is similar to B4A GoogleMaps library.  
  
In order to use it you need to get a free api key from Google. Follow the "Obtaining an API Key" steps: <https://developers.google.com/maps/documentation/ios/start#obtaining_an_api_key>  
Start with the attached project. You will need to change the package name.  
  
When you are ready to start a new project you need to:  
Add these two attributes to your project (if you want to show the user location):  

```B4X
#PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>Used to display the current navigation data.</string>  
#PlistExtra:<key>NSLocationUsageDescription</key><string>Used to display the current navigation data.</string>
```

  
You can change the description text.  
  
Copy the GoogleMaps.bundle folder from the example project (under Files\Special) to Files\Special in your project.  
  
You can download the example project from: <https://www.b4x.com/b4i/files/GoogleMaps.zip>  
  
**Updates:**  
  
- Example updated with B4i v10+ and Google Maps v10.4.0 requirements. The bundle was updated.