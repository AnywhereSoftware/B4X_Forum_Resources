### FirebaseAdMob - Admob ads integrated with Firebase backend by Erel
### 06/16/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67710/)

**Use FirebaseAdMob2 instead: <https://www.b4x.com/android/forum/threads/firebaseadmob2-google-mobile-ads-sdk-v20.129609/>**  
  
[SPOILER="Deprecated"]This library required B4A v6+.  
  
This library allows showing AdMob ads. It is integrated with Firebase services so you can better track and analyze the results.  
<https://firebase.google.com/docs/admob/>  
  
It supports banner ads and interstitial ads (full screen ads).  
  
First you need to follow the Firebase integration tutorial: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
Make sure to include the Ads manifest snippet.  
  
Full example that shows a banner ad and an interstitial ad when clicking on the activity:  

```B4X
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
   Private BannerAd As AdView  
   Private IAd As InterstitialAd  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   BannerAd.Initialize2("BannerAd", "ca-app-pub-3940256099942544/6300978111", BannerAd.SIZE_SMART_BANNER)  
   Dim height As Int  
   If GetDeviceLayoutValues.ApproximateScreenSize < 6 Then  
    'phones  
    If 100%x > 100%y Then height = 32dip Else height = 50dip  
   Else  
    'tablets  
    height = 90dip  
   End If  
   Activity.AddView(BannerAd, 0dip, 100%y - height, 100%x, height)  
   BannerAd.LoadAd  
   IAd.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")  
   IAd.LoadAd  
End Sub  
  
Sub Activity_Click  
   If IAd.Ready Then IAd.Show  
End Sub  
  
Sub IAD_AdClosed  
   IAd.LoadAd 'prepare a new ad  
End Sub
```

  
These are test ids and they will show test ads.  
  
**Edit:** It is also required to request user consent for personalized ads. See this tutorial: <https://www.b4x.com/android/forum/threads/firebaseadmob-and-user-consent.93347/#post-590593>  
  
V1.60 - **Few new requirements**, explained here: <https://www.b4x.com/android/forum/threads/firebaseadmob-v1-6.108552/>  
V1.50 - Adds support for requesting consent.  
V1.31 - Fixes an issue related to InMobi mediation ads.  
V1.30 - Adds support for rewarded video ads: <https://www.b4x.com/android/forum/threads/firebaseadmob-rewarded-video-ads.71430/>  
V1.20 - Adds support for native ads: <https://www.b4x.com/android/forum/threads/firebaseadmob-admob-ads-integrated-with-firebase-backend.67710/page-3>[/SPOILER]