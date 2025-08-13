### iAdMob by Erel
### 01/04/2024
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/47319/)

**Latest version: <https://www.b4x.com/android/forum/threads/firebase-admob-v3-00.144798/#content>**  
  
iAdMob v1.10 adds support for interstitial ads (full screen ads).  
  
In order to show an interstitial ad you need to first request an ad and wait for the Ready event.  
If Success is true then there is an ad ready to be displayed. You can then call iad.Show(Page) to show it.  
You can also call iad.RequestAd again to request a new ad.  
  
Note that you can show test ads by calling:  

```B4X
iad.SetTestDevices(Array("121212121212")) 'id that is displayed in the logs
```

  
The ready event:  

```B4X
Sub iad_Ready (Success As Boolean)  
   If Success Then  
     Log("iad is ready.")  
     iad.Show(Page1)  
   Else  
     Log("Failed to load full screen ad: " & LastException)  
   End If  
End Sub
```

  
  
Note that you can show the ad after this event. This event only means that there is an ad ready to be displayed.  
  
**Library installation**  
  
iAdMob is an internal library now. It is preinstalled with the IDE.  
  
If you are using a local Mac builder you need to download the new SDK and copy GoogleMobileAds.framework to the Libs folder: [www.b4x.com/b4i/files/libGoogleAdMobAds.a.zip](https://www.b4x.com/b4i/files/libGoogleAdMobAds.a.zip)  
  
**Update:**  
  
Starting from Google Maps Ads SDK v7.42.0 it is required to add these lines:  

```B4X
#PlistExtra: <key>GADIsAdManagerApp</key><true/>  
#AdditionalLib: libsqlite3.dylib  
#AdditionalLib: libz.dylib  
#AdditionalLib: WebKit.framework
```