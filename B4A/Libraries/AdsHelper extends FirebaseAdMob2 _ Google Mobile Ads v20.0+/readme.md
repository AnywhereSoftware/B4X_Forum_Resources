### AdsHelper extends FirebaseAdMob2 / Google Mobile Ads v20.0+ by Erel
### 09/03/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/129696/)

AdsHelper is a class that adds the following features:  
  
- Managing the user consent with Google's User Messaging Platform: <https://developers.google.com/admob/ump/android/quick-start>  
- App Open Ads: <https://developers.google.com/admob/android/app-open-ads>  
  
It can be extended with more features.  
  
Instructions:  
1. It is important to read Google's documentation and understand the main concepts.  
2 Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
CreateResourceFromFile (Macro, FirebaseAdMob2.FirebaseAds)  
AddReplacement($ADMOB_APP_ID$, ca-app-pub-1267570xxxxx0~676xxxxx) 'your app id here
```

  
  
3. This class should be used in B4XPages projects. With some work you can use it in non-B4XPages but you will need to handle the much more complicated life cycle and split the tasks between the activity and the starter service.  
4. Add to Main:  

```B4X
#AdditionalJar: com.google.android.ump:user-messaging-platform
```

  
  
  
**Consent**  
  
Sign up to Funding Choices and create an EU consent message: <https://support.google.com/fundingchoices/answer/9180084>  
The logic itself is simple:  

```B4X
If Ads.GetConsentStatus = "UNKNOWN" Or Ads.GetConsentStatus = "REQUIRED" Then  
    Wait For (Ads.RequestConsentInformation(False)) Complete (Success As Boolean)  
End If  
If Ads.GetConsentStatus = "REQUIRED" And Ads.GetConsentFormAvailable Then  
    Wait For (Ads.ShowConsentForm) Complete (Success As Boolean)  
End If
```

  
We check the consent status. If it is unknown we request new information.  
If the consent status is REQUIRED and a consent form is available then we show it.  
The consent status is managed by Google and is cached locally.  
  
In order to debug it we can set a test device and set the location to be in the EU (True) or outside (False):  

```B4X
Ads.ResetConsentStatus  
Ads.SetConsentDebugParameters("77A04EE40B2AFED2AFC67701365187EC", True)
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/111603)  
  
**App Open Ads**  
  
These are ads that appear when the app has moved to the foreground. It is configured to appear if the app was more than 2 minutes in the background and then resumed.  
  
Instructions:  
1. Call Ads.FetchOpenAd once.  
2.  

```B4X
Private Sub B4XPage_Foreground  
    Ads.ShowOpenAdIfAvailable  
End Sub  
  
Private Sub B4XPage_Background  
    Ads.Background  
End Sub
```

  
  
AdsHelper class is included in the attached project.  
The project will fail to run unless you set the correct app id in the manifest editor.  
  
Updated version by [USER=10835]@Jack Cole[/USER], including an example of using AdHelper in non-B4XPages project: <https://www.b4x.com/android/forum/threads/adshelper-extension-for-traditional-b4a-apps-more.131798/>  
  
**Updates**  
  
1.01 - Fixes compatibility issue with FetchOpenAd call and B4A v13.4 SDK.