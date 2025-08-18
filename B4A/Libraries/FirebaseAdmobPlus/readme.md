### FirebaseAdmobPlus by ArminKh1993
### 03/18/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126078/)

**[SIZE=5]FirebaseAdmobPlus is no longer supported, please check out[/SIZE]**[SIZE=5] **GoogleMobileAds lib**[/SIZE]  
[[SIZE=5]https://www.b4x.com/android/forum/threads/googlemobileadssdk.128787/[/SIZE]](https://www.b4x.com/android/forum/threads/googlemobileadssdk.128787/)  
  
  
Hi  
This is a full wrapper over goolgle ads sdk.  
<https://developers.google.com/admob/android/quick-start>  
  
**It supports** **:**  
 - Banner (Also Adaptive Banner) | <https://developers.google.com/admob/android/banner>  
 - Interstitial | <https://developers.google.com/admob/android/interstitial>  
 - Rewerded | <https://developers.google.com/admob/android/rewarded-ads>  
 - AppOpenAds | <https://developers.google.com/admob/android/app-open-ads>  
 - UnifiedNative | <https://developers.google.com/android/reference/com/google/android/gms/ads/formats/UnifiedNativeAd>  
  
First you need to follow the Firebase integration tutorial: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
Make sure to include the Ads manifest snippet.  
  
**Note:**   
 - This library is compatible with Admob version 19.6 or higher, So if you see any errors, please update your SDK first.  
![](https://www.b4x.com/android/forum/attachments/105571)  
  
 - This library will be updated as soon as Google launches the new Google Mobile Ads SDK for Android version 20.0.0 In early 2021. So several APIs currently available will be changed or retired. See this <https://developers.google.com/admob/android/migration>  
  
 - You should initialialize MobileSdk at first once and wait for MobileAds\_onInitializationComplete  
then you can add your ads.  
like this:  

```B4X
    Dim MobileAds As MobileAds  
        MobileAds.Initialize  
    Wait For MobileAds_onInitializationComplete  
        ' Here You Can Load Your Ads
```

  
  
 - For video ads to show successfully in your banner ad views, hardware acceleration must be enabled.(Add to manifest)  

```B4X
SetApplicationAttribute(android:hardwareAccelerated, "true")
```

  
  
- By default, the Google Mobile Ads SDK initializes app measurement and begins sending user-level event data to Google immediately when the app starts.  
 This initialization behavior ensures you can enable AdMob user metrics without making additional code changes.  
 However, if your app requires user consent before these events can be sent, you can delay app measurement until you explicitly initialize the Mobile Ads SDK or load an ad.  
 To delay app measurement, add the following <meta-data> tag in your Manifest.  
 Delay app measurement until MobileAds.initialize() is called.  

```B4X
AddApplicationText(  
    <meta-data  
        android:name="com.google.android.gms.ads.DELAY_APP_MEASUREMENT_INIT"  
        android:value="true"/>  
)
```