### FirebaseAdMob and User Consent by Erel
### 06/22/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/93347/)

**Use instead: [AdsHelper extends FirebaseAdMob2 / Google Mobile Ads v20.0+](https://www.b4x.com/android/forum/threads/129696/#content)**   
  
More information: <https://developers.google.com/admob/android/eu-consent>  
By default, AdMob serves personalized ads.  
With the new GDPR law, publishers (you) need to request consent before the private data can be used to serve personalized ads to EU users.  
  
The main steps are:  
  
1. Check the current consent state, usually in the starter service.  
2. If the consent state is unknown and the user is from the EU (or his location is unknown) then show the consent form.  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-23_15.56.06.png)  
  
This step must be done from an Activity.  
  
3. Show non-personalized or personalized ads based on the consent state and location.  
  
**The limit on 12 providers was removed. Make sure to use FirebaseAdMob v1.55+.**  
  
Note that the Google consent form will only work if there are 12 or less ad technology providers. There are 200 by default so you need to change it in your AdMob console:  
Blocking Controls - EU USER CONSENT tab:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-23_16.09.16.png)  
  
  
**Testing**  
  
In order to test the behavior you can can add your device as a test device and set whether the location should be treated as coming from the EU:  

```B4X
consent.AddTestDevice("D4AC977CA12D122C4563730CC762C302") 'check the unfiltered logs for the device id after calling RequestInfoUpdate  
consent.SetDebugGeography(True) 'True = EU, False = Non-EU
```

  
  
You can set the consent state yourself and it will be saved automatically by setting the ConsentState property. This can be useful for debugging and to allow the user to change the previously selected option.  
  
**Starter service code:**  
  

```B4X
Sub Service_Create  
   consent.Initialize("consent")  
   consent.AddTestDevice("D4AC977CA12D122C4563730CC762C302")  
   consent.SetDebugGeography(True) 'comment for regular operation  
   consent.RequestInfoUpdate(Array("pub-144444444"))  
   Wait For consent_InfoUpdated (Success As Boolean)  
   If Success = False Then  
       Log($"Error getting consent state: ${LastException}"$)  
   End If  
   Log($"Consent state: ${consent.ConsentState}"$)  
   Log("EU: " & consent.IsRequestLocationInEeaOrUnknown)  
   Do While IsPaused(Main)  
       Sleep(100)  
   Loop  
   CallSubDelayed(Main, "ConsentStateAvailable")  
End Sub
```

  
  
**Main activity code:**  
  

```B4X
'show the consent form if needed  
Sub ConsentStateAvailable  
   Dim consent As ConsentManager = Starter.consent  
   If consent.ConsentState = consent.STATE_UNKNOWN And consent.IsRequestLocationInEeaOrUnknown Then  
       'Set last parameter to False if you don't want to show the "pay for ad-free" option.  
       'Change privacy policy URL.  
       consent.ShowConsentForm("https://www.mysite.com/privacy.html", True, True, True)  
       Wait For Consent_FormResult (Success As Boolean, UserPrefersAdFreeOption As Boolean)  
       If Success Then  
           Log($"Consent form result: ${consent.ConsentState}, AdFree: ${UserPrefersAdFreeOption}"$)  
       Else  
           Log($"Error: ${LastException}"$)  
       End If  
   End If  
   LoadAd  
End Sub  
  
'load ads:  
Sub LoadAd  
   Dim builder As AdRequestBuilder  
   builder.Initialize  
   Dim consent As ConsentManager = Starter.consent  
   If consent.IsRequestLocationInEeaOrUnknown Then  
       If consent.ConsentState = consent.STATE_NON_PERSONALIZED Then  
           builder.NonPersonalizedAds  
       Else if consent.ConsentState = consent.STATE_UNKNOWN Then  
           Return  
       End If  
   End If  
   builder.AddTestDevice("D4AC977CA12D122C4563730CC762C302")  
   adview1.LoadAdWithBuilder(builder)  
End Sub
```

  
  
**Ad free option**  
  
If the user selects this option then the ConsentState will be kept UNKNOWN and UserPrefersAdFreeOption will be true (nothing else happens).  
  
  
Dependencies: FirebaseAdmob v1.50+ (<https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/#post-590564>)