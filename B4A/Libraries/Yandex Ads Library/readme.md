### Yandex Ads Library by Pendrush
### 04/18/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166552/)

Based on Yandex Mobile Ads 7.12.1 (15 Apr 2025) from [HERE](https://ads.yandex.com/helpcenter/en/dev/android/quick-start) and [HERE](https://github.com/yandexmobile/yandex-ads-sdk-android).  
Banner, Interstitial and Rewarded Ads.  
  
It depends of enormous amount of libraries. I have a really hard time to make it to work.  
  
app-ads.txt: <https://ads.yandex.com/helpcenter/en/support/faq/app-ads-txt>  
  
Include OkHttp library in your project, you don't need to initialize library, just include it by checking library in Libraries Manager tab inside B4A.  
  
> **Pnd\_YandexAds  
>   
> Author:** Author: Yandex - B4a Wrapper: Pendrush  
> **Version:** 1.12  
>
> - **Pnd\_YandexAds**
>
> - **Events:**
>
> - **OnBannerAdClicked**
> - **OnBannerAdFailedToLoad** (AdRequestError As String)
> - **OnBannerAdImpression** (ImpressionData As String)
> - **OnBannerAdLoaded**
> - **OnLeftApplication**
> - **OnReturnedToApplication**
> - **OnSdkInitializationComplete**
>
> - **Functions:**
>
> - **BringToFront**
> - **Initialize** (EventName As String)
> *Initialize Yandex SDK. This is first steps, no matter what type of ads you are using.  
>  EventName - Event name  
>  Yandex.Initialize("Yandex")*- **InitializeBanner** (AdUnitId As String, AdWidth As Int)
> *Initialize Banner Ad.  
>  AdUnitId - Banner AdUnitId.  
>  AdWidth - Should be 100%x.  
>  Yandex.InitializeBanner("demo-banner-yandex", 100%x)*- **Invalidate**
> - **Invalidate2** (arg0 As android.graphics.Rect)
> - **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **IsInitialized** As Boolean
> - **LoadBanner**
> *Load Banner Ad.*- **RemoveView**
> - **RequestFocus** As Boolean
> - **SendToBack**
> - **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
> - **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
> - **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
> - **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
> - **ShowDebugPanel**
> *Launches SDK debug panel.*
> - **Properties:**
>
> - **AgeRestrictedUser** As Boolean [write only]
> *Set a value indicating whether user is a child or undefined age.  
>  Need to be executed before initialize SDK.  
>  True if user falls under COPPA restrictions, otherwise False.*- **AppAdAnalyticsReporting** As Boolean [write only]
> *Enable or disable reporting for ad events that are automatically sent to AppMetrica for applications.  
>  Need to be executed before initialize SDK.  
>  If the value is set to True reports for ad events will be sent, otherwise not.*- **Background** As android.graphics.drawable.Drawable
> - **BannerHeight** As Int [read only]
> *Returns the actual height of banner in pixels, not in dip.  
>  Use DipToCurrent to convert pixels to dip.  
>  Dim BannerHeight As Int = DipToCurrent(Yandex.BannerHeight)  
>  Root.AddView(Yandex, 0, 100%y - BannerHeight, 100%x, BannerHeight)*- **Color** As Int [write only]
> - **Enabled** As Boolean
> - **EnableDebugErrorIndicator** As Boolean [write only]
> *Enable or disable visibility error indicator in Debug Mode.  
>  Need to be executed before initialize SDK.  
>  If set to True, visibility error indicator will be displayed, otherwise not.*- **EnableLogging** As Boolean [write only]
> *Enables SDK logs.  
>  Need to be executed before initialize SDK.  
>  If set to True, logs will be enabled, otherwise disabled.*- **Height** As Int
> - **Left** As Int
> - **LocationConsent** As Boolean [write only]
> *Enables location usage for ad loading.  
>  Need to be executed before initialize SDK.  
>  If set to True, location will be used for ads loading, otherwise not.*- **Padding** As Int()
> - **Parent** As Object [read only]
> - **Tag** As Object
> - **Top** As Int
> - **UserConsent** As Boolean [write only]
> *Set a value indicating whether user from GDPR region allowed to collect personal data which is used for analytics and ad targeting.  
>  Need to be executed before initialize SDK.  
>  True if user provided consent to collect personal data, otherwise False.*- **Visible** As Boolean
> - **Width** As Int
>
> - **Pnd\_YandexAdsInterstitial**
>
> - **Events:**
>
> - **OnInterstitialAdClicked**
> - **OnInterstitialAdDismissed**
> - **OnInterstitialAdFailedToLoad** (AdRequestError As String)
> - **OnInterstitialAdFailedToShow** (AdError As String)
> - **OnInterstitialAdImpression** (ImpressionData As String)
> - **OnInterstitialAdLoaded**
> - **OnInterstitialAdShown**
>
> - **Functions:**
>
> - **Initialize** (EventName As String, AdUnitId As String)
> *Initialize Interstitial Ad.  
>  EventName - Event name.  
>  AdUnitId - Interstitial Ad AdUnitId.  
>  YandexInterstitial.Initialize("YandexInterstitial", "demo-interstitial-yandex")*- **IsInitialized** As Boolean
> - **Load**
> *Starts loading the Interstitial Ad on a background thread.*- **Show**
> *Shows the Interstitial Ad.*
> - **Pnd\_YandexAdsRewarded**
>
> - **Events:**
>
> - **OnRewardedAdClicked**
> - **OnRewardedAdDismissed**
> - **OnRewardedAdFailedToLoad** (AdRequestError As String)
> - **OnRewardedAdFailedToShow** (AdError As String)
> - **OnRewardedAdImpression** (ImpressionData As String)
> - **OnRewardedAdLoaded**
> - **OnRewardedAdReward** (RewardType As String, RewardAmount As Int)
> - **OnRewardedAdShown**
>
> - **Functions:**
>
> - **Initialize** (EventName As String, AdUnitId As String)
> *Initialize Rewarded Ad.  
>  EventName - Event name.  
>  AdUnitId - Rewarded Ad AdUnitId.  
>  YandexRewarded.Initialize("YandexRewarded", "demo-rewarded-yandex")*- **IsInitialized** As Boolean
> - **Load**
> *Starts loading the Rewarded Ad on a background thread.*- **Show**
> *Shows the Rewarded Ad.*

  
  
Add this to main:  

```B4X
    #MultiDex: True    
    #AdditionalJar: androidx.appcompat:appcompat  
    #AdditionalJar: androidx.appcompat:appcompat-resources  
    #AdditionalJar: androidx.emoji2:emoji2  
    #AdditionalJar: androidx.emoji2:emoji2-views-helper  
    #AdditionalJar: androidx.customview:customview-poolingcontainer  
    #AdditionalJar: androidx.interpolator:interpolator  
    #AdditionalJar: androidx.profileinstaller:profileinstaller  
    #AdditionalJar: androidx.recyclerview:recyclerview  
    #AdditionalJar: androidx.resourceinspection:resourceinspection-annotation  
    #AdditionalJar: androidx.transition:transition  
    #AdditionalJar: androidx.vectordrawable:vectordrawable  
    #AdditionalJar: androidx.vectordrawable:vectordrawable-animated  
    #AdditionalJar: androidx.viewpager2:viewpager2  
    #AdditionalJar: com.android.installreferrer:installreferrer  
    #AdditionalJar: com.android.tools:annotations    
    #AdditionalJar: analytic-adapter-0.6.0.aar  
    #AdditionalJar: analytics-7.7.2.aar  
    #AdditionalJar: analytics-ad-revenue-7.7.2.aar  
    #AdditionalJar: analytics-appsetid-7.7.2.aar  
    #AdditionalJar: analytics-billing-interface-7.7.2.aar  
    #AdditionalJar: analytics-billing-v6-7.7.2.aar  
    #AdditionalJar: analytics-common-logger-7.7.2.aar  
    #AdditionalJar: analytics-core-api-7.7.2.aar  
    #AdditionalJar: analytics-core-utils-7.7.2.aar  
    #AdditionalJar: analytics-gpllibrary-7.7.2.aar  
    #AdditionalJar: analytics-identifiers-7.7.2.aar  
    #AdditionalJar: analytics-location-7.7.2.aar  
    #AdditionalJar: analytics-location-api-7.7.2.aar  
    #AdditionalJar: analytics-logger-7.7.2.aar  
    #AdditionalJar: analytics-modules-api-7.7.2.aar  
    #AdditionalJar: analytics-ndkcrashes-api-7.7.2.aar  
    #AdditionalJar: analytics-network-7.7.2.aar  
    #AdditionalJar: analytics-network-tasks-7.7.2.aar  
    #AdditionalJar: analytics-proto-7.7.2.aar  
    #AdditionalJar: analytics-remote-permissions-7.7.2.aar  
    #AdditionalJar: androidsvg-aar-1.4.aar  
    #AdditionalJar: api-common-1.5.0  
    #AdditionalJar: api-compiled-1.5.0  
    #AdditionalJar: api-public-1.5.0  
    #AdditionalJar: appmetrica-adapter-0.6.0.aar  
    #AdditionalJar: assertion-31.4.0.aar  
    #AdditionalJar: beacon-31.4.0.aar  
    #AdditionalJar: datastore-1.0.0.aar  
    #AdditionalJar: datastore-core-1.0.0  
    #AdditionalJar: div-31.4.0.aar  
    #AdditionalJar: div-core-31.4.0.aar  
    #AdditionalJar: div-data-31.4.0.aar  
    #AdditionalJar: div-evaluable-31.4.0  
    #AdditionalJar: div-histogram-31.4.0.aar  
    #AdditionalJar: div-json-31.4.0.aar  
    #AdditionalJar: div-states-31.4.0.aar  
    #AdditionalJar: div-storage-31.4.0.aar  
    #AdditionalJar: div-svg-31.4.0.aar  
    #AdditionalJar: javax.inject-1  
    #AdditionalJar: kotlinx-serialization-core-jvm-1.5.1  
    #AdditionalJar: kotlinx-serialization-json-jvm-1.5.1  
    #AdditionalJar: logging-31.4.0.aar  
    #AdditionalJar: mobileads-7.12.1.aar  
    #AdditionalJar: proto-0.6.0.aar  
    #AdditionalJar: utils-31.4.0.aar
```

  
  
Add this to the manifest:  

```B4X
CreateResourceFromFile(Macro, Core.NetworkClearText)  
AddApplicationText(  
        <meta-data  
            android:name="com.yandex.mobile.ads.AUTOMATIC_SDK_INITIALIZATION"  
            android:value="false" />  
        <activity  
            android:name="com.yandex.mobile.ads.common.AdActivity"  
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"  
            android:theme="@style/MonetizationAdsInternal.AdActivity" />  
        <provider  
            android:name="com.yandex.mobile.ads.core.initializer.MobileAdsInitializeProvider"  
            android:authorities="${applicationId}.MobileAdsInitializeProvider"  
            android:exported="false" />  
        <activity  
            android:name="com.yandex.mobile.ads.features.debugpanel.ui.IntegrationInspectorActivity"  
            android:exported="false"  
            android:theme="@style/DebugPanelTheme" />  
        <provider  
            android:name="com.yandex.mobile.ads.features.debugpanel.data.local.DebugPanelFileProvider"  
            android:authorities="${applicationId}.monetization.ads.inspector.fileprovider"  
            android:exported="false"  
            android:grantUriPermissions="true" >  
            <meta-data  
                android:name="android.support.FILE_PROVIDER_PATHS"  
                android:resource="@xml/debug_panel_file_paths" />  
        </provider>  
        <service  
            android:name="io.appmetrica.analytics.internal.AppMetricaService"  
            android:enabled="true"  
            android:exported="false"  
            android:process=":AppMetrica" >  
            <intent-filter>  
                <category android:name="android.intent.category.DEFAULT" />  
  
                <action android:name="io.appmetrica.analytics.IAppMetricaService" />  
  
                <data android:scheme="appmetrica" />  
            </intent-filter>  
        </service>  
        <provider  
            android:name="io.appmetrica.analytics.internal.PreloadInfoContentProvider"  
            android:authorities="${applicationId}.appmetrica.preloadinfo.retail"  
            android:enabled="true"  
            android:exported="true"  
            android:process=":AppMetrica" />)
```

  
  
  
**Versions:**  
  
 **v1.12**  

- Original library update. [Changelog](https://ads.yandex.com/helpcenter/en/dev/android/changelog-android).
- Updated example app.

  
Download library from: <https://mega.nz/file/5c400CgY#ixrDYO3L6LURZSHaWsLW73nCdLcenRsyK7Oz3C4x7Jo>  
Check example app for implementation.