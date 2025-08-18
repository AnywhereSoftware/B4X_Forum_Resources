### AdManager Library by Pendrush
### 02/22/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/122111/)

Wrapper for AdManager Library: <https://developers.google.com/ad-manager/mobile-ads-sdk/android/quick-start>  
Banner, Interstitial and Rewarded Ads only.  
  
> **AdManager  
>   
> Author:** Author: Google - B4a Wrapper: Pendrush  
> **Version:** 1.52  
>
> - **AdManager**
>
> - **Events:**
>
> - **AdClicked**
> - **AdExpanded**
> - **AdFailedToLoad** (Error As String)
> - **AdImpression**
> - **AdLoaded**
> - **AdOpened**
>
> - **Fields:**
>
> - **ADSIZE\_BANNER** As com.google.android.gms.ads.AdSize
> *Mobile Marketing Association (MMA) banner ad size (320x50 density-independent pixels).*- **ADSIZE\_FULL\_BANNER** As com.google.android.gms.ads.AdSize
> *Interactive Advertising Bureau (IAB) full banner ad size (468x60 density-independent pixels)*- **ADSIZE\_LARGE\_BANNER** As com.google.android.gms.ads.AdSize
> *Large banner ad size (320x100 density-independent pixels).*- **ADSIZE\_LEADERBOARD** As com.google.android.gms.ads.AdSize
> *Interactive Advertising Bureau (IAB) leaderboard ad size (728x90 density-independent pixels).*- **ADSIZE\_MEDIUM\_RECTANGLE** As com.google.android.gms.ads.AdSize
> *Interactive Advertising Bureau (IAB) medium rectangle ad size (300x250 density-independent pixels).*
> - **Functions:**
>
> - **BringToFront**
> - **Initialize** (EventName As String)
> *Initialize Banner Ad   
>  AdManager1.Initialize("AdManager1")*- **Invalidate**
> - **Invalidate2** (arg0 As android.graphics.Rect)
> - **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **IsInitialized** As Boolean
> - **LoadNonPersonalized** (AdUnitId As String, AdSize As com.google.android.gms.ads.AdSize)
> *Loads an Non Personalized ad.   
>  AdManager1.LoadNonPersonalized("/6499/example/banner", size.Native)*- **LoadPersonalized** (AdUnitId As String, AdSize As com.google.android.gms.ads.AdSize)
> *Loads an Personalized ad.   
>  AdManager1.LoadPersonalized("/6499/example/banner", size.Native)*- **Pause**
> *This method should be called in the parent Activity\_Pause method.*- **RemoveView**
> - **RequestFocus** As Boolean
> - **Resume**
> *This method should be called in the parent Activity\_Resume method.*- **SendToBack**
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
> - **AdManagerInterstitial**
>
> - **Events:**
>
> - **AdDismissedFullScreenContent**
> - **AdFailedToLoad** (Error As String)
> - **AdFailedToShowFullScreenContent** (Error As String)
> - **AdLoaded**
> - **AdShowedFullScreenContent**
>
> - **Functions:**
>
> - **Initialize** (EventName As String, AdUnitId As String)
> *Initialize Interstitial Ad.   
>  AdManagerInterstitial1.Initialize("AdManagerInterstitial1", "/6499/example/interstitial")*- **IsInitialized** As Boolean
> - **IsLoaded** As Boolean
> *Returns True if the Ad was successfully loaded and is ready to be shown.*- **LoadNonPersonalized**
> *Load an Non Personalized ad.*- **LoadPersonalized**
> *Load an Personalized ad.*- **Show**
> *Show the Interstitial Ad.*
> - **AdManagerRewarded**
>
> - **Events:**
>
> - **AdDismissedFullScreenContent**
> - **AdFailedToLoad** (Error As String)
> - **AdFailedToShowFullScreenContent** (Error As String)
> - **AdLoaded**
> - **AdShowedFullScreenContent**
> - **UserEarnedReward** (RewardType As String, RewardAmount As Int)
>
> - **Functions:**
>
> - **Initialize** (EventName As String, AdUnitId As String)
> *Initialize Rewarded Ad.   
>  AdManagerRewarded1.Initialize("AdManagerRewarded1", "ca-app-pub-3940256099942544/5354046379")*- **IsInitialized** As Boolean
> - **IsLoaded** As Boolean
> *Returns True if a Rewarded Ad is available and is ready to be shown.*- **LoadNonPersonalized**
> *Load an Non Personalized ad.*- **LoadPersonalized**
> *Load an Personalized ad.*- **Show**
> *Show the Rewarded Ad.*
> - **MobileAdsSdk**
>
> - **Functions:**
>
> - **Initialize**

  
  
Add this in manifest (replace **ca-app-pub-3940256099942544~3347511713** with your APP ID):  

```B4X
AddApplicationText(  
<meta-data  
android:name="com.google.android.gms.ads.APPLICATION_ID"  
android:value="ca-app-pub-3940256099942544~3347511713"/>  
  
<meta-data  
            android:name="com.google.android.gms.ads.AD_MANAGER_APP"  
            android:value="true"/>   
            <activity  
            android:name="com.google.android.gms.ads.AdActivity"  
            android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" />   
           
            <activity android:name="com.google.android.gms.common.api.GoogleApiActivity"  
          android:theme="@android:style/Theme.Translucent.NoTitleBar"  
          android:exported="false"/>  
            <meta-data  
          android:name="com.google.android.gms.version"  
          android:value="@integer/google_play_services_version" />  
        <receiver  
                    android:name="com.google.android.gms.measurement.AppMeasurementReceiver"  
                    android:enabled="true"  
                    android:exported="false" >  
                </receiver>  
       
          <service  
                    android:name="com.google.android.gms.measurement.AppMeasurementService"  
                    android:enabled="true"  
                    android:exported="false" />  
                   
         <receiver  
                    android:name="com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver"  
                    android:enabled="true"  
                    android:exported="true"  
                    android:permission="android.permission.INSTALL_PACKAGES" >  
                    <intent-filter>  
                        <action android:name="com.android.vending.INSTALL_REFERRER" />  
                    </intent-filter>  
        </receiver>  
        <service  
                    android:name="com.google.android.gms.measurement.AppMeasurementJobService"  
                    android:enabled="true"  
                    android:exported="false"  
                    android:permission="android.permission.BIND_JOB_SERVICE" />)
```

  
  
  
v1.52 new banner sizes for static banners:  

- ADSIZE\_BANNER - Mobile Marketing Association (MMA) banner ad size (320x50 density-independent pixels).
- ADSIZE\_FULL\_BANNER - Interactive Advertising Bureau (IAB) full banner ad size (468x60 density-independent pixels).
- ADSIZE\_LARGE\_BANNER - Large banner ad size (320x100 density-independent pixels).
- ADSIZE\_LEADERBOARD - Interactive Advertising Bureau (IAB) leaderboard ad size (728x90 density-independent pixels).
- ADSIZE\_MEDIUM\_RECTANGLE - Interactive Advertising Bureau (IAB) medium rectangle ad size (300x250 density-independent pixels).