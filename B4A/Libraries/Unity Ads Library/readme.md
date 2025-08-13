### Unity Ads Library by Pendrush
### 04/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120648/)

Original library: <https://github.com/Unity-Technologies/unity-ads-android>  
Based on Unity Ads Library v4.14.2 (16 Apr 2025).  
Banner, Interstitial and Rewarded Video.  
  
If you have problem compiling app please check **[**THIS**](https://www.b4x.com/android/forum/threads/unity-ads-library.120648/page-2#post-1021660)** post.  
  
app-ads.txt: <https://docs.unity.com/ads/en-us/manual/app-ads-txt>  
  
Tutorial for AdMob mediation: [AdMob mediation - UnityAds (not tested)](https://www.b4x.com/android/forum/threads/admob-mediation-unityads-not-tested.166508/).  
  
  
> **UnityAds  
>   
> Author:** Author: Unity - B4a Wrapper: Pendrush  
> **Version:** 4.91  
>
> - **UnityAdsBanner**
>
> - **Events:**
>
> - **OnBannerClick**
> - **OnBannerFailedToLoad** (Error As String)
> - **OnBannerLeftApplication**
> - **OnBannerLoaded**
> - **OnBannerShown**
> - **OnInitializationComplete**
> - **OnInitializationFailed** (Error As String)
>
> - **Functions:**
>
> - **BringToFront**
> - **Initialize** (arg1 As String)
> - **InitializeBanner** (EventName As String, GameID As String, TestMode As Boolean, PlacementID As String)
> *Initializes banner 320x50  
>  EventName - Event name  
>  GameID - The Unity Game ID for your Project, located in the developer dashboard.  
>  TestMode - When set to true, only test ads display.  
>  PlacementID - The Placement ID, located on the developer dashboard.   
>  UnityAdsBanner.InitializeBanner("BannerAd", "3054608", True, "banner")  
>  Activity.AddView(UnityAdsBanner, 100%x/2-160dip, 0, 320dip, 50dip)*- **InitializeBanner300x250** (EventName As String, GameID As String, TestMode As Boolean, PlacementID As String)
> *Initializes banner 300x250  
>  EventName - Event name  
>  GameID - The Unity Game ID for your Project, located in the developer dashboard.  
>  TestMode - When set to true, only test ads display.  
>  PlacementID - The Placement ID, located on the developer dashboard.   
>  UnityAdsBanner.InitializeBanner300x250("BannerAd", "3054608", True, "banner")  
>  Activity.AddView(UnityAdsBanner, 100%x/2-150dip, 0, 300dip, 250dip)*- **InitializeBanner300x300** (EventName As String, GameID As String, TestMode As Boolean, PlacementID As String)
> *Initializes banner 300x300  
>  EventName - Event name  
>  GameID - The Unity Game ID for your Project, located in the developer dashboard.  
>  TestMode - When set to true, only test ads display.  
>  PlacementID - The Placement ID, located on the developer dashboard.   
>  UnityAdsBanner.InitializeBanner300x300("BannerAd", "3054608", True, "banner")  
>  Activity.AddView(UnityAdsBanner, 100%x/2-150dip, 0, 300dip, 300dip)*- **InitializeBanner450x450** (EventName As String, GameID As String, TestMode As Boolean, PlacementID As String)
> *Initializes banner 450x450  
>  EventName - Event name  
>  GameID - The Unity Game ID for your Project, located in the developer dashboard.  
>  TestMode - When set to true, only test ads display.  
>  PlacementID - The Placement ID, located on the developer dashboard.   
>  UnityAdsBanner.InitializeBanner450x450("BannerAd", "3054608", True, "banner")  
>  Activity.AddView(UnityAdsBanner, 100%x/2-225dip, 0, 450dip, 450dip)*- **Invalidate**
> - **Invalidate2** (arg0 As android.graphics.Rect)
> - **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **IsInitialized** As Boolean
> - **LoadBanner**
> *Load banner Ad.*- **onInitializationComplete**
> - **onInitializationFailed** (error As com.unity3d.ads.UnityAds.UnityAdsInitializationError, message As String)
> - **RemoveView**
> - **RequestFocus** As Boolean
> - **SendToBack**
> - **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
> - **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
> - **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
> - **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
>
> - **Properties:**
>
> - **Background** As android.graphics.drawable.Drawable
> - **Color** As Int [write only]
> - **Enabled** As Boolean
> - **Height** As Int
> - **Left** As Int
> - **Padding** As Int()
> - **Parent** As Object [read only]
> - **Tag** As Object
> - **Top** As Int
> - **Visible** As Boolean
> - **Width** As Int
>
> - **UnityAdsInterstitial**
>
> - **Events:**
>
> - **OnUnityAdsAdLoaded** (PlacementID As String)
> - **OnUnityAdsFailedToLoad** (Error As String)
> - **OnUnityAdsShowClick** (PlacementID As String)
> - **OnUnityAdsShowComplete** (PlacementID As String, State As String)
> - **OnUnityAdsShowFailure** (Error As String)
> - **OnUnityAdsShowStart** (PlacementID As String)
>
> - **Functions:**
>
> - **InitializeInterstitial** (EventName As String, GameID As String, TestMode As Boolean, PlacementID As String)
> *EventName - Event name  
>  GameID - The Unity Game ID for your Project, located in the developer dashboard.  
>  TestMode - When set to true, only test ads display.  
>  PlacementID - The Placement ID, located on the developer dashboard.   
>  UnityAdsInterstitial.InitializeInterstitial("InterstitialAds", "14851", True, "rewardedVideo")*- **IsInitialized** As Boolean
> - **LoadAd**
> *Load Interstitial/Rewarded Ad.*- **ShowAd**
> *Show Ad*

  
Add this code to main:  

```B4X
    #MultiDex: True  
    #AdditionalJar: androidx.asynclayoutinflater:asynclayoutinflater  
    #AdditionalJar: androidx.collection:collection  
    #AdditionalJar: androidx.concurrent:concurrent-futures  
    #AdditionalJar: androidx.coordinatorlayout:coordinatorlayout  
    #AdditionalJar: androidx.cursoradapter:cursoradapter  
    #AdditionalJar: androidx.datastore:datastore  
    #AdditionalJar: androidx.documentfile:documentfile  
    #AdditionalJar: androidx.fragment:fragment  
    #AdditionalJar: androidx.interpolator:interpolator  
    #AdditionalJar: androidx.legacy:legacy-support-core-ui  
    #AdditionalJar: androidx.legacy:legacy-support-core-utils  
    #AdditionalJar: androidx.lifecycle:lifecycle-common  
    #AdditionalJar: androidx.lifecycle:lifecycle-livedata  
    #AdditionalJar: androidx.lifecycle:lifecycle-livedata-core  
    #AdditionalJar: androidx.lifecycle:lifecycle-process  
    #AdditionalJar: androidx.lifecycle:lifecycle-runtime  
    #AdditionalJar: androidx.lifecycle:lifecycle-runtime-ktx  
    #AdditionalJar: androidx.lifecycle:lifecycle-service  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel-ktx  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel-savedstate  
    #AdditionalJar: androidx.localbroadcastmanager:localbroadcastmanager  
    #AdditionalJar: androidx.print:print  
    #AdditionalJar: androidx.profileinstaller:profileinstaller  
    #AdditionalJar: androidx.sqlite:sqlite  
    #AdditionalJar: androidx.sqlite:sqlite-framework  
    #AdditionalJar: androidx.work:work-runtime  
    #AdditionalJar: androidx.work:work-runtime-ktx  
    #AdditionalJar: androidx.webkit:webkit  
    #AdditionalJar: com.google.android.gms:play-services-cronet  
    #AdditionalJar: com.google.android.gms:play-services-base  
    #AdditionalJar: com.google.android.gms:play-services-basement  
    #AdditionalJar: com.google.android.gms:play-services-tasks  
    #AdditionalJar: com.google.protobuf:protobuf-java-lite  
    #AdditionalJar: com.google.protobuf:protobuf-kotlin-lite  
    #AdditionalJar: org.chromium.net:cronet-api  
    #AdditionalJar: room-common-2.2.5  
    #AdditionalJar: room-runtime-2.2.5.aar
```

  
  
  
Add this in your manifest:  

```B4X
AddManifestText(<queries>  
        <intent>  
            <action android:name="com.attribution.REFERRAL_PROVIDER" />  
        </intent>  
    </queries>)  
  
AddApplicationText(<activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentSoftwareActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="false"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitSoftwareActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="false"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.ads.adplayer.FullScreenWebViewDisplay"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <provider  
            android:name="androidx.startup.InitializationProvider"  
            android:authorities="${applicationId}.androidx-startup" >  
            <meta-data  
                android:name="androidx.lifecycle.ProcessLifecycleInitializer"  
                android:value="androidx.startup" />  
            <meta-data  
                android:name="com.unity3d.services.core.configuration.AdsSdkInitializer"  
                android:value="androidx.startup" />  
        </provider>)
```

  
  
  
**Versions:  
  
v4.89**  

- Fixed bug in library: when you show banner once and close page/activity, you are not able to show banner again.
- Added missing permission: android.permission.ACCESS\_ADSERVICES\_AD\_ID.
- Updated example app.
- OkHttp library need to be included in project, check example app.

  
**v4.90**  

- Added new banners: 300x250, 300x300 and 450x450.
- Updated example app.

  
**v4.91**  

- Update for original library. [Changelog](https://docs.unity.com/ads/en-us/manual/Changelog#Version_4.14.2_-_released_2025-04-16).
- Updated example app (Manifest changes).

  
Download library from: <https://mega.nz/file/UcwwnDDY#IhKJrDeGOkC4BdHJMEPEKlCZlifRxifaUMFrskWfdvk>