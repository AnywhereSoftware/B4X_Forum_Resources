### Pangle Ads Library - TikTok Company by Pendrush
### 04/09/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166529/)

This wrapper is based on: <https://www.pangleglobal.com/zh/integration/integrate-pangle-sdk-for-android>  
Banner, Interstitial and Rewarded ads.  
  
If you use this library, you need to run app on real device, emulator is not supported.  
  
AdMob mediation is not possible at this time, as AdMob Pangle adapter target older Pangle SDK.  
  
app-ads.txt: <https://www.pangleglobal.com/integration/app-ads-txt>  
Pangle ads info: <https://www.pangleglobal.com/monetization>  
Available locations for Pangle ads : <https://ads.tiktok.com/help/article/available-locations-for-pangle-ads?lang=en>  
  
> **Pnd\_PangleAds  
>   
> Author:** Author: Pangle - B4a Wrapper: Pendrush  
> **Version:** 1.01  
>
> - **Pnd\_PangleAds**
>
> - **Events:**
>
> - **OnBannerAdClicked**
> - **OnBannerAdDismissed**
> - **OnBannerAdShowed**
> - **OnInitializeSdkFail** (Error As String)
> - **OnInitializeSdkSuccess**
> - **OnLoadBannerAdError** (Error As String)
> - **OnLoadBannerAdFailed**
> - **OnLoadBannerAdLoaded**
>
> - **Fields:**
>
> - **BANNER\_W\_300\_H\_250** As com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize
> - **BANNER\_W\_320\_H\_50** As com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize
> - **BANNER\_W\_728\_H\_90** As com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize
> - **PAG\_GDPR\_CONSENT\_TYPE\_CONSENT** As Int
> - **PAG\_GDPR\_CONSENT\_TYPE\_DEFAULT** As Int
> - **PAG\_GDPR\_CONSENT\_TYPE\_NO\_CONSENT** As Int
> - **PAG\_PA\_CONSENT\_TYPE\_CONSENT** As Int
> - **PAG\_PA\_CONSENT\_TYPE\_NO\_CONSENT** As Int
>
> - **Functions:**
>
> - **InitializeSdk** (EventName As String, AppId As String, GdprConsent As Int, PaConsent As Int, SupportMultiProcess As Boolean)
> *Initialize Pangle SDK. This is first steps, no matter what type of ads you are using.  
>  EventName - Event name  
>  AppId - Your application ID  
>  GdprConsent - Set the configuration of GDPR. Use on of PAG\_GDPR constants, for example: PangleAds.PAG\_GDPR\_CONSENT\_TYPE\_NO\_CONSENT  
>  PaConsent - Indicates whether the user agrees to the delivery of personalized ads. Use one of PAG\_PA constants, for example: PangleAds.PAG\_PA\_CONSENT\_TYPE\_NO\_CONSENT  
>  SupportMultiProcess - If your app supports multi-process, set this to true.  
>  PangleAds.InitializeSdk("PangleAds", "8025677", PangleAds.PAG\_GDPR\_CONSENT\_TYPE\_NO\_CONSENT, PangleAds.PAG\_PA\_CONSENT\_TYPE\_NO\_CONSENT, True)*- **IsInitialized** As Boolean
> - **LoadBanner** (SlotId As String, BannerSize As com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize)
> *Load banner Ad.  
>  SlotId - Slot Id for banner.  
>  BannerSize - Size of banner. Use one of BANNER constants.  
>  PangleAds.LoadBanner("980099802", PangleAds.BANNER\_W\_320\_H\_50)*
> - **Properties:**
>
> - **BannerView** As View [read only]
> *Return banner Ad as View.  
>  Root.AddView(PangleAds.BannerView, 100%x/2-160dip, 100%y-50dip, 320dip, 50dip)*
> - **Pnd\_PangleInterstitialAds**
>
> - **Events:**
>
> - **OnInterstitialAdClicked**
> - **OnInterstitialAdDismissed**
> - **OnInterstitialAdShowed**
> - **OnLoadInterstitialAdError** (Error As String)
> - **OnLoadInterstitialAdLoaded**
>
> - **Functions:**
>
> - **Initialize** (EventName As String)
> *Initialize interstitial Ad.  
>  EventName - Event name  
>  PangleInterstitialAds.Initialize("PangleAds")*- **IsInitialized** As Boolean
> - **LoadInterstitial** (SlotId As String)
> *Load interstitial Ad.  
>  SlotId - Slot Id for interstitial Ad.  
>  PangleInterstitialAds.LoadInterstitial("980088188")*- **Show**
> *Show interstitial Ad.  
>  PangleInterstitialAds.Show*
> - **Pnd\_PangleRewardedAds**
>
> - **Events:**
>
> - **OnLoadRewardedAdError** (Error As String)
> - **OnLoadRewardedAdLoaded**
> - **OnRewardedAdClicked**
> - **OnRewardedAdDismissed**
> - **OnRewardedAdShowed**
> - **OnRewardedAdUserEarnedReward** (RewardName As String, RewardAmount As Int)
> - **OnRewardedAdUserEarnedRewardFail** (Error As String)
>
> - **Functions:**
>
> - **Initialize** (EventName As String)
> *Initialize rewarded Ad.  
>  EventName - Event name  
>  PangleRewardedAds.Initialize("PangleAds")*- **IsInitialized** As Boolean
> - **LoadRewarded** (SlotId As String)
> *Load a rewarded Ad.  
>  SlotId - Slot Id for rewarded Ad.  
>  PangleRewardedAds.LoadRewarded("980088192")*- **Show**
> *Show rewarded Ad.  
>  PangleRewardedAds.Show*

  
  
Add this to main:  

```B4X
    #AdditionalJar: pag-sdk-7.1.0.4.aar  
    #AdditionalJar: tiktok-business-android-sdk-comp-1.3.7-rc.2.aar  
    #AdditionalJar: pag-sdk-ad-unfat-7104-20250326173127.aar  
    #AdditionalJar: pag-gecko-2.0.0.5.aar  
    #AdditionalJar: pag-apm-2.0.0.3.aar  
    #AdditionalJar: com.google.android.gms:play-services-ads-identifier
```

  
  
  
Add this to manifest:  

```B4X
AddApplicationText(<meta-data  
            android:name="com.bytedance.sdk.pangle.version"  
            android:value="7.1.0.4" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTCeilingLandingPageActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTLandingPageActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_landing_page" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTPlayableLandingPageActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_landing_page" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTVideoLandingPageLink2Activity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_landing_page" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTDelegateActivity"  
            android:launchMode="standard"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTWebsiteActivity"  
            android:launchMode="standard"  
            android:screenOrientation="portrait"  
            android:theme="@style/tt_privacy_landing_page" />  
  
        <service android:name="com.bytedance.sdk.openadsdk.multipro.aidl.BinderPoolService" />  
  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTAppOpenAdActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_app_open_ad_no_animation" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTRewardVideoActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_new" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTRewardExpressVideoActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_new" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTFullScreenVideoActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_new" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTFullScreenExpressVideoActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_new" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTInterstitialActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_interaction" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTInterstitialExpressActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_interaction" />  
        <activity  
            android:name="com.bytedance.sdk.openadsdk.activity.TTAdActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:launchMode="standard"  
            android:theme="@style/tt_full_screen_new" />)
```

  
  
  
Download library from: <https://mega.nz/file/scBXRIaK#svYxVhNMoHysrnBDSuu97NrBomwc_fyLIzkLKbYo3to>