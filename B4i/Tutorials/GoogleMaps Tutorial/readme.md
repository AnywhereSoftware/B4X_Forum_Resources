### GoogleMaps Tutorial by Erel
### 01/30/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/47019/)

The iGoogleMaps library allows you to show a map inside your app:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-11-17_09.18.50.png)  
  
It is similar to B4A GoogleMaps library.  
  
1. In order to use it you need to get a free api key from Google. Follow the "Obtaining an API Key" steps: <https://developers.google.com/maps/documentation/ios/start#obtaining_an_api_key>  
  
2. If you are using a local Mac builder then you need to first download the SDK to your Mac computer: [www.b4x.com/b4i/files/GoogleMaps.framework.zip](https://www.b4x.com/b4i/files/GoogleMaps.framework.zip) (download it from your Mac).  
And copy GoogleMaps.framework package to the Libs folder.  
  
Start with the attached project. You will need to change the package name.  
  
When you are ready to start a new project you need to:  
3. Add these two attributes to your project (if you want to show the user location):  

```B4X
#PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>Used to display the current navigation data.</string>  
#PlistExtra:<key>NSLocationUsageDescription</key><string>Used to display the current navigation data.</string>
```

  
You can change the description text.  
4. Set the minimum version to 11:  

```B4X
#MinVersion: 11
```

  
  
5. Copy the GoogleMaps.bundle folder from the example project (under Files\Special) to Files\Special in your project.  
  
You can download the example project from: <https://www.b4x.com/b4i/files/GoogleMaps.zip>  
  
**Updates:**  
  
- GoogleMaps iOS SDK v6.0.1 was uploaded to the builders.  
Make sure to update Files\Special\GoogleMaps.bundle from the example project.  
If using a local Mac then update the Mac frameworks (see step #2 above)  
Set the minimum version to 11: #MinVersion: 11