### FirebaseAdMob2 - Google Mobile Ads SDK v20+ by Erel
### 08/18/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/129609/)

**Edit:** The underlying Google SDK is compatible with Android 8+ (api 26+). It is recommended to set minSdkVersion in the manifest editor to 26.  
  
This is a wrapper for Google Mobile Ads v20+ SDK.  
It is a modified version of FirebaseAdmob (1).  
This library works with Google Mobile Ads v20+. The previous library works with v19-.  
  
Note that you can use FirebaseAdMob2 without creating a Firebase account.  
  
It supports banner ads and interstitial ads.  
  
Instructions:  
1. Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
CreateResourceFromFile (Macro, FirebaseAdMob.FirebaseAds)  
AddReplacement($ADMOB_APP_ID$, ca-app-pub-12673333333~67613333333)
```

  
  
2. Initialize MobileAds:  

```B4X
Dim m As MobileAds  
Wait For (m.Initialize) MobileAds_Ready  
m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("77A04EE40B2AFED2AFC67701365187EC"))) 'optional. Array with test device ids. See unfiltered logs to find id.
```

  
  
3. Banner ad:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   Dim AdaptiveSize As Map = GetAdaptiveAdSize  
   'Add Private BannerAd As AdView in Globals sub  
   BannerAd.Initialize2("BannerAd", "ca-app-pub-3940256099942544/6300978111",AdaptiveSize.Get("native"))  
   Activity.AddView(BannerAd, 0, 0,  AdaptiveSize.Get("width"), AdaptiveSize.Get("height"))  
   BannerAd.LoadAd  
End Sub  
  
Sub GetAdaptiveAdSize As Map  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim AdSize As JavaObject  
    Dim width As Int = 100%x / GetDeviceLayoutValues.Scale  
    Dim Native As JavaObject = AdSize.InitializeStatic("com.google.android.gms.ads.AdSize").RunMethod("getCurrentOrientationAnchoredAdaptiveBannerAdSize", Array(ctxt, width))  
    Return CreateMap("native": Native, "width": Native.RunMethod("getWidthInPixels", Array(ctxt)), _  
        "height": Native.RunMethod("getHeightInPixels", Array(ctxt)))  
End Sub  
  
Sub Ad_ReceiveAd  
    Log("Adview received")  
End Sub  
  
Sub Ad_FailedToReceiveAd (ErrorCode As String)  
    Log("Failed: " & ErrorCode)  
End Sub  
  
Sub Ad_AdClosed  
    Log("Closed")  
End Sub  
  
Sub Ad_AdOpened  
    Log("Opened")  
End Sub
```

  
  
4. Interstitial ad:  

```B4X
'Add Private iAd As InterstitialAd in Globals sub  
iad.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")  
iad.LoadAd  
  
  
Sub iAd_ReceiveAd  
    Log("IAd received. Now wait for the right moment to show the ad.")  
    If ad.Ready Then  
       ad.Show 'bad example. You should instead wait for the correct time and show it when it makes sense.  
    End If  
End Sub  
  
Sub iAd_FailedToReceiveAd (ErrorCode As String)  
    Log("Failed: " & ErrorCode)  
End Sub  
  
Sub iAd_AdClosed  
    Log("Closed")  
End Sub  
  
Sub iAd_AdOpened  
    Log("Opened")  
End Sub
```

  
  
Libraries developers:  
[SPOILER]Source code: <https://github.com/AnywhereSoftware/B4A/blob/769ccea0f435d1b5cd59dc89f5237385d7850dcb/Libs_FirebaseAdMob/src/anywheresoftware/b4a/admobwrapper/AdViewWrapper.java>  
It depends on: C:\Android\extras\b4a\_remote\com\google\android\gms\play-services-ads-lite\20.0.0\unpacked-play-services-ads-lite-20.0.0\jars\classes.jar[/SPOILER]  
  
For more advanced features, use FirebaseAdMob2 with AdsHelper: <https://www.b4x.com/android/forum/threads/adshelper-extends-firebaseadmob2-google-mobile-ads-v20-0.129696/>  
  
Updates:  
  
v3.22 - Adds missing dependency: androidx.tracing:tracing  
v2.13 - Internal library in B4A v10.9. Deprecated Google consent SDK was removed as it caused app to be rejected.  
v2.12 - Fixed typo in MobileAds.SetConfiguration (it was SetConfigutation by mistake).