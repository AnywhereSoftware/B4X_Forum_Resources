### IronSource Ads by Pendrush
### 04/07/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130894/)

Original library: <https://github.com/ironsource-mobile/android-sdk/>  
Based on IronSource SDK v7.2.1.1 (21 Mar 2022)  
Banners and Interstitial only.  
  
> **IronSourceAds  
>   
> Author:** Author: IronSource - B4a Wrapper: Pendrush  
> **Version:** 7.21  
>
> - **IronSourceAds**
>
> - **Events:**
>
> - **AdClicked**
> - **AdLeftApplication**
> - **AdLoaded**
> - **AdLoadFailed** (Error As String)
> - **AdScreenDismissed**
> - **AdScreenPresented**
>
> - **Fields:**
>
> - **AD\_BANNER** As com.ironsource.mediationsdk.ISBannerSize
> *Standard Banner - 320x50*- **AD\_LARGE** As com.ironsource.mediationsdk.ISBannerSize
> *Large Banner - 320x90*- **AD\_RECTANGLE** As com.ironsource.mediationsdk.ISBannerSize
> *Medium Rectangular Banner - 300x250*- **AD\_SMART** As com.ironsource.mediationsdk.ISBannerSize
> *Smart Banner - If screen height ≤ 720 = 320x50, If screen height > 720 = 728x90*
> - **Functions:**
>
> - **BringToFront**
> - **DestroyBanner**
> *Destroy Banner*- **Initialize** (AppKey As String)
> *Initialize SDK*- **InitializeBanner** (EventName As String, BannerSize As com.ironsource.mediationsdk.ISBannerSize)
> *Initialize Banner*- **Invalidate**
> - **Invalidate2** (arg0 As android.graphics.Rect)
> - **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **IsInitialized** As Boolean
> - **LoadBanner**
> *Load Banner*- **LoadBannerWithPlacementName** (PlacementName As String)
> *Load Banner with placement name*- **RemoveView**
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
> - **IronSourceAdsInterstitial**
>
> - **Events:**
>
> - **InterstitialAdClicked**
> - **InterstitialAdClosed**
> - **InterstitialAdLoadFailed** (Error As String)
> - **InterstitialAdOpened**
> - **InterstitialAdReady**
> - **InterstitialAdShowFailed** (Error As String)
> - **InterstitialAdShowSucceeded**
>
> - **Functions:**
>
> - **InitializeInterstitial** (EventName As String)
> *Initialize Interstitial*- **IsReady** As Boolean
> *Check if Interstitial Ad is ready*- **LoadAd**
> *Load Interstitial Ad*- **ShowAd**
> *Show Interstitial Ad*- **ShowAdWithPlacementName** (PlacementName As String)
> *Show Interstitial Ad with placement name*

  
  
Add this to manifest:  

```B4X
AddApplicationText(<activity  
            android:name="com.ironsource.sdk.controller.ControllerActivity"  
            android:configChanges="orientation|screenSize"  
            android:hardwareAccelerated="true" />  
<activity  
            android:name="com.ironsource.sdk.controller.InterstitialActivity"  
            android:configChanges="orientation|screenSize"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.Translucent" />  
<activity  
            android:name="com.ironsource.sdk.controller.OpenUrlActivity"  
            android:configChanges="orientation|screenSize"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.Translucent" />  
<provider  
            android:authorities="${applicationId}.IronsourceLifecycleProvider"  
            android:name="com.ironsource.lifecycle.IronsourceLifecycleProvider" />)
```

  
  
  
Download library from [**THIS LINK**](https://www.dropbox.com/s/2tbxu2d82lqy9cr/IronSourceAdsLibrary.zip?dl=0).