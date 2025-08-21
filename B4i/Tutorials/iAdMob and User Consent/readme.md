### iAdMob and User Consent by Erel
### 12/11/2019
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/93381/)

More information: <https://developers.google.com/admob/ios/eu-consent>  
  
By default, AdMob serves personalized ads.  
With the new GDPR law, publishers (you) need to request consent before the private data can be used to serve personalized ads to EU users.  
  
The main steps are:  
  
1. Check the current consent state when the app starts.  
2. If the consent state is unknown and the user is from the EU (or his location is unknown) then show the consent form.  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-24_12.20.36.png)  
  
3. Show non-personalized or personalized ads based on the consent state and location.  
  
Note that the Google consent form will only work if there are 12 or less ad technology providers. There are 200 by default so you need to change it in your AdMob console:  
Blocking Controls - EU USER CONSENT tab:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-23_16.09.16.png)  
  
**Testing**  
  
In order to test the behavior you can can add your device as a test device and set whether the location should be treated as coming from the EU:  

```B4X
consent.LogDeviceIdForDebugging  
consent.AddTestDevice("927915D1-CAE8-4F99-B04C-57345B7DECF4")  
consent.SetDebugGeography(True) 'comment for regular operation (True = from EU)
```

  
  
You can set the consent state yourself and it will be saved automatically by setting the ConsentState property. This can be useful for debugging and to allow the user to change the previously selected option.  
  
**Code:**  

```B4X
'Application_Start  
consent.Initialize("consent")  
consent.LogDeviceIdForDebugging  
consent.AddTestDevice("927915D1-CAE8-4F99-B04C-57345B7DECF4")  
consent.SetDebugGeography(True) 'comment for regular operation  
consent.RequestInfoUpdate(Array("pub-133333329340"))  
Wait For consent_InfoUpdated (Success As Boolean)  
If Success = False Then  
   Log($"Error getting consent state: ${LastException}"$)  
End If  
Log($"Consent state: ${consent.ConsentState}"$) '0 - UNKNOWN, 1 - NON_PERSONALIZED, 2 - PERSONALIZED  
Log(consent.IsRequestLocationInEeaOrUnknown)  
ConsentStateAvailable  
'**********************  
  
Sub ConsentStateAvailable  
   If consent.ConsentState = consent.STATE_UNKNOWN And consent.IsRequestLocationInEeaOrUnknown Then  
       consent.ShowConsentForm(Page1, "https://www.mysite.com/privacy.html", True, True, True)  
       Wait For Consent_FormResult (Success As Boolean, UserPrefersAdFreeOption As Boolean)  
       If Success Then  
           Log($"Consent form result: ${consent.ConsentState}, AdFree: ${UserPrefersAdFreeOption}"$)  
       Else  
           Log($"Error: ${LastException}"$)  
       End If  
   End If  
   LoadAd  
End Sub  
  
  
Sub LoadAd  
   Dim builder As AdRequestBuilder  
   builder.Initialize  
   If consent.IsRequestLocationInEeaOrUnknown And consent.ConsentState <> consent.STATE_PERSONALIZED Then  
       builder.NonPersonalizedAds  
   End If  
   builder.AddTestDevice("bb5420c11bebc5700781d810ca2bc2d0") 'this is a different id than the above. Check the logs for the correct id.  
   ad.LoadAdWithBuilder(builder)  
End Sub
```

  
  
**Ad free option**  
  
If the user selects this option then the ConsentState will be kept UNKNOWN and UserPrefersAdFreeOption will be true (nothing else happens).  
  
**Bundle**  
Unzip the attached zip and copy PersonalizedAdConsent.bundle to <project>Files\Special:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-24_12.25.26.png)