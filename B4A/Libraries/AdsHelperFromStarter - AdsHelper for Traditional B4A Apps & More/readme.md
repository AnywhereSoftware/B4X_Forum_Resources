### AdsHelperFromStarter - AdsHelper for Traditional B4A Apps & More by Jack Cole
### 04/13/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/147393/)

I wanted to share an update that I have made to the [AdsHelper extension class](https://www.b4x.com/android/forum/threads/adshelper-extension-for-traditional-b4a-apps-more.131798/#content). The example app loads AdsHelperFromStarter through the starter service. The reason that this matters, is that it can load App Open, Rewarded Interstitial and Rewarded Video ads when the app starts. The ads can then be shown from any activity. You don't have to try to load all the ads again if you go to a new activity. You should interact with the class through the starter service.  
  
For example to show an App Open Ad from an activity call:  

```B4X
Starter.Ads.ShowOpenAdIfAvailable(1)
```

  
  
If you are using rewarded interstitial or rewarded videos, you can set app wide global variables from the starter service (for example if Pro mode for your app is enabled after they watch the video). Events are called in the class, starter, and current activity. If you are going to show ads in the current activity, you need to set Starter.AdsSecondaryCallbackModule=Me. In the example app, see the implementation in TestActivity2. The test app loads the ads from the starter, but you can show them in either Main or TestActivity2.  
  

```B4X
Sub Activity_Resume  
    Starter.AdsSecondaryCallbackModule=Me  
    iAd.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")  
    iAd.LoadAd  
End Sub
```

  
  
Features:  

- support for rewarded video ads
- events for rewarded video
- events for [rewarded interstitial](https://www.b4x.com/android/forum/threads/adshelper-extends-firebaseadmob2-google-mobile-ads-v20-0.129696/post-815445)
- events for open ads
- auto re-loading of ads after dismissing (can be set via a parameter)
- parameter for open ads for setting the background delay before allowing the ad to show
- incorporated [native ad example](https://www.b4x.com/android/forum/threads/b4xpages-native-ads-with-mediaview-firebaseadmob2-and-mobile-ads-sdk-v20.131211/) and moved the code into a separate class
- example of a fixed size banner ad (300x250)
- support for traditional B4A apps
- ads load initially from the starter service

![](https://www.b4x.com/android/forum/attachments/141166)  
  
**Known Issues:** There is a bit of an issue with the Open Ads in that you are pretty much stuck with the orientation of the device that the user has chosen when the app starts. This means that if they start in Landscape and switch to Portrait, the app open ad will show in Landscape.  
  
I have not tested this with a B4XPages app.