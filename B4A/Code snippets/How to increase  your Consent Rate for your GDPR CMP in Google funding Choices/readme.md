### How to increase  your Consent Rate for your GDPR CMP in Google funding Choices by Hadi57
### 12/22/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/137061/)

Hi Friends,  
As you maybe know Google can completely turn off your Ads, if EU users do not consent in GDPR CMP pop-up and there is no working solution for that. But there are some strategies that I use for increase Consent Rate that lead to show/serve more Ads and increase Monetization.  
Please share your thoughts and strategies  
Hope it may be useful to you  
  
1. When you setup your GDPR Massage you can create the message with: A. two options (Consent / Manage options) or B. with three options (Consent / Do not Consent / Manage options), it highly recommended to choose A. with two options (Consent / Manage options).  
![](https://www.b4x.com/android/forum/attachments/123344)  
if you select B. three options (Consent / Do not Consent / Manage options), most likely users will select "Do not Consent ", but if you choose A. two options (Consent / Manage options), they can either press "Consent" button or if they select "manage options" and will have more options to configure in there, so most likely users would avoid having to deal with that complications so they will just likely go back and consent instead.  
  
  
2. change title of button from "Consent" to "I understand", This doesn't necessarily tell them that they are consenting to something, just confirming that they understand the content of your pop-up message, so you are most likely going to get click for the right button.  
  
![](https://www.b4x.com/android/forum/attachments/123345)  
  
3. Check Consent status, and if your user did not consent, show CMP message again at next application run.  
By AdsHelper class ([this](https://www.b4x.com/android/forum/threads/adshelper-extends-firebaseadmob2-google-mobile-ads-v20-0.129696/) and [this](https://www.b4x.com/android/forum/threads/adshelper-extension-for-traditional-b4a-apps-more.131798/)) you can only understand if user submitted the CMP message or not, but you can't understand if users consent or didn't (and also users selection is enough for serving ads or not), **Get\_CMP\_Status** function can return different value for "OBTAINED" when user consent or didn't consent.  
[Ref.](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-And-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md)  
  

```B4X
    If Get_CMP_Status = 31  Then  
        AdsHelper.ResetConsentStatus  
    End If  
  
'Return Value = 0: UNKNOWN, 1: NOT_REQUIRED, 2: REQUIRED, 3: OBTAINED, 31: OBTAINED (didno Consent, BAD), 32: OBTAINED (Consent, GOOD)  
Private Sub Get_CMP_Status As Int  
    Dim ctxt As JavaObject: ctxt.InitializeContext  
    Dim Preferences As JavaObject  
    Dim SharedPreferences As JavaObject = Preferences.InitializeStatic("android.preference.PreferenceManager").RunMethod("getDefaultSharedPreferences", Array(ctxt))  
    
    Dim javamap As Object = SharedPreferences.RunMethod("getAll", Null)  
    Dim all As Map: all.Initialize  
    Dim mo As JavaObject = all: mo.RunMethod("putAll", Array(javamap))  
  
    Dim gdprApplies As Int = all.GetDefault("IABTCF_gdprApplies", -1)  
    Dim PublisherCC As String = all.GetDefault("IABTCF_PublisherCC", "*")  
    Dim VendorConsents As String = all.GetDefault("IABTCF_VendorConsents", "")  
    Dim CmpSdkID As Int = all.GetDefault("IABTCF_CmpSdkID", 0)  
  
    Dim Ret As Int = 0        'gdprApplies = -1  
    If gdprApplies = 0 Then Ret = 1  
    If gdprApplies = 1 Then  
        Ret = 2  
        If PublisherCC <> "*" Then  
            Ret = 3  
            If VendorConsents = "0" Then Ret = 31  
            If VendorConsents.Length > 10 Then Ret = 32  
        End If  
    End If  
    If Ret> 0 And CmpSdkID <> 300 Then LogColor("Warning: Check CMP Function", Colors.Red)  
    Return Ret  
End Sub
```