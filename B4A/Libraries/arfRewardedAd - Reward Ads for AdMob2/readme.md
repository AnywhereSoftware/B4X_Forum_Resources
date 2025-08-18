### arfRewardedAd - Reward Ads for AdMob2 by arfprogramas
### 06/11/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/131549/)

Hello  
  
I'd like to share a class that I made for Reward Ads that I use in my apps/games.   
It's little bit different from what is found here: <https://www.b4x.com/android/forum/threads/adshelper-extends-firebaseadmob2-google-mobile-ads-v20-0.129696/#post-815445>  
  
Before starts, another excellent option is found here: <https://www.b4x.com/android/forum/threads/adshelper-extends-firebaseadmob2-google-mobile-ads-v20-0.129696/post-828193>  
  
This class works both on B4XPages or non-B4XPages.  
  
**Depends on:**  
<https://www.b4x.com/android/forum/threads/firebaseadmob2-google-mobile-ads-sdk-v20.129609/>  
  
**How it works:**  
Starter service:  

```B4X
Sub Service_Start (StartingIntent As Intent)  
 RewardAd.Initialize(Me, "RewardAd", False, "ca-app-pub-xxxxxxx/xxxxxx", True, True)  
 Dim m As MobileAds  
 Wait For (m.Initialize) MobileAds_Ready  
 RewardAd.LoadAd  
End Sub
```

  
  
Activity or class (b4xpages):  

```B4X
Sub Activity_Resume (or B4XPage_Appear)  
 Starter.RewardAd.Callback = Me  
End Sub
```

  
  
RewardAd.Initialize(Callback As Object, EventName As String, Intersticial As Boolean, AdUnit As String, AutoLoad As Boolean, NonPersonalizedAds As Boolean)  
Intersticial = True -> Rewarded Intersticial Ad -> <https://developers.google.com/admob/android/rewarded-interstitial>  
Intersticial = False -> Rewarded Ad -> <https://developers.google.com/admob/android/rewarded-fullscreen>  
AutoLoad -> load new ad every time  
NonPersonalizedAds -> True (family program)  
  
**When you want to use:**  

```B4X
If Starter.RewardAd.Ready Then  
Starter.RewardAd.Show  
End If
```

  
  
**Callbacks:**  

```B4X
Sub RewardAd_Rewarded (Item As Object)  
    …  
End Sub
```

  
  

```B4X
Sub RewardAd_AdClosed  
    'If you set AutoLoad true, you don't need load another ad here.  
End Sub
```