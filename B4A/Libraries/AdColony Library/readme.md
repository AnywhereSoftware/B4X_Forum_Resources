### AdColony Library by Pendrush
### 01/13/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120665/)

Original library: <https://github.com/AdColony/AdColony-Android-SDK>  
Based on AdColony Library v4.6.5 (21 October 2021).  
Banner, Interstitial and Rewarded Interstitial.  
  
> **AdColonyAds  
>   
> Author:** Author: AdColony - B4a Wrapper: Pendrush  
> **Version:** 4.65  
>
> - **AdColonyBanner**
>
> - **Events:**
>
> - **OnClicked**
> - **OnClosed**
> - **OnLeftApplication**
> - **OnOpened**
> - **OnRequestFilled**
> - **OnRequestNotFilled**
>
> - **Fields:**
>
> - **AD\_BANNER** As Object
> *Supported Sizes:  
>  320×50 standard  
>  Min: 300×50  
>  Max: 450×75*- **AD\_LEADERBOARD** As Object
> *Supported Sizes:  
>  970×90 standard  
>  Min: 600×75  
>  Max: 1200×150  
>  8:1 aspect ratio*- **AD\_MEDIUM\_RECTANGLE** As Object
> *Supported Sizes:  
>  300×250 standard  
>  Min: 300×300  
>  Max: 450×450*- **AD\_SKYSCRAPER** As Object
> *Supported Sizes:  
>  160×600 standard  
>  Min: 160×640  
>  Max: 240×960*
> - **Functions:**
>
> - **BringToFront**
> - **Destroy**
> *Destroy banner Ad.*- **Initialize** (arg1 As String)
> - **InitializeBanner** (EventName As String, AppID As String, ZoneID As String, GDPR As Boolean, GDPRConsent As String, COPPA As Boolean, COPPAConsent As String, CCPA As Boolean, CCPAConsent As String)
> *GDPR - The value passed via setPrivacyFrameworkRequired() will determine the GDPR requirement of the user. If it's set to true, the user is subject to the GDPR laws.  
>  GDPRConsent - A value of "1" implies the user has given consent to store and process personal information and a value of "0" means the user has declined consent. Please note that this is not compliant with IAB standards and may reduce your ad fill rate for demand providers which accept IAB consent signals exclusively.  
>  COPPA - The value passed via setPrivacyFrameworkRequired() will determine whether COPPA is applicable for the user. If it's set to true, AdColony will behave with the understanding COPPA is applicable for the user.  
>  COPPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the COPPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  CCPA - The value passed via setPrivacyFrameworkRequired() will indicate to AdColony whether CCPA is applicable legislation for the user.  
>  If it's set to true, the user is subject to the CCPA. Note that IAB US Privacy String has information embedded into the string to  
>  indicate whether CCPA is applicable. In the event of conflicting signals between the IAB US Privacy String and setPrivacyFrameworkRequired(),  
>  we will interpret as CCPA being applicable.  
>  CCPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the CCPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  AdColony.InitializeBanner("AdColony", "YOUR\_APP\_ID", "YOUR\_ZONE\_ID", False, "1", False, "1", False, "1")  
>  AdColony.RequestBannerAd(AdColony.AD\_BANNER)*- **Invalidate**
> - **Invalidate2** (arg0 As android.graphics.Rect)
> - **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
> - **IsInitialized** As Boolean
> - **RemoveView**
> - **RequestBannerAd** (AdSize As com.adcolony.sdk.AdColonyAdSize)
> *Request banner Ad, onRequestFilled event will fire when request is successful.*- **RequestFocus** As Boolean
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
> - **AdColonyInterstitial**
>
> - **Events:**
>
> - **OnExpiring**
> - **OnOpened**
> - **OnRequestFilled**
> - **OnRequestNotFilled**
>
> - **Functions:**
>
> - **InitializeInterstitial** (EventName As String, AppID As String, ZoneID As String, GDPR As Boolean, GDPRConsent As String, COPPA As Boolean, COPPAConsent As String, CCPA As Boolean, CCPAConsent As String)
> *GDPR - The value passed via setPrivacyFrameworkRequired() will determine the GDPR requirement of the user. If it's set to true, the user is subject to the GDPR laws.  
>  GDPRConsent - A value of "1" implies the user has given consent to store and process personal information and a value of "0" means the user has declined consent. Please note that this is not compliant with IAB standards and may reduce your ad fill rate for demand providers which accept IAB consent signals exclusively.  
>  COPPA - The value passed via setPrivacyFrameworkRequired() will determine whether COPPA is applicable for the user. If it's set to true, AdColony will behave with the understanding COPPA is applicable for the user.  
>  COPPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the COPPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  CCPA - The value passed via setPrivacyFrameworkRequired() will indicate to AdColony whether CCPA is applicable legislation for the user.  
>  If it's set to true, the user is subject to the CCPA. Note that IAB US Privacy String has information embedded into the string to  
>  indicate whether CCPA is applicable. In the event of conflicting signals between the IAB US Privacy String and setPrivacyFrameworkRequired(),  
>  we will interpret as CCPA being applicable.  
>  CCPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the CCPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  AdColony.InitializeInterstitial("AdColony", "YOUR\_APP\_ID", "YOUR\_ZONE\_ID", False, "1", False, "1", False, "1")  
>  AdColony.RequestInterstitial*- **IsInitialized** As Boolean
> - **RequestInterstitial**
> *Request Interstitial Ad, OnRequestFilled event will fire when request is successful.*- **Show**
> *Show Interstitial Ad  
>  DO NOT Show Ad before OnRequestFilled event fire.*
> - **AdColonyRewardedInterstitial**
>
> - **Events:**
>
> - **OnExpiring**
> - **OnOpened**
> - **OnRequestFilled**
> - **OnRequestNotFilled**
> - **OnReward** (Reward As Map)
>
> - **Functions:**
>
> - **InitializeRewarded** (EventName As String, AppID As String, ZoneID As String, GDPR As Boolean, GDPRConsent As String, COPPA As Boolean, COPPAConsent As String, CCPA As Boolean, CCPAConsent As String)
> *GDPR - The value passed via setPrivacyFrameworkRequired() will determine the GDPR requirement of the user. If it's set to true, the user is subject to the GDPR laws.  
>  GDPRConsent - A value of "1" implies the user has given consent to store and process personal information and a value of "0" means the user has declined consent. Please note that this is not compliant with IAB standards and may reduce your ad fill rate for demand providers which accept IAB consent signals exclusively.  
>  COPPA - The value passed via setPrivacyFrameworkRequired() will determine whether COPPA is applicable for the user. If it's set to true, AdColony will behave with the understanding COPPA is applicable for the user.  
>  COPPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the COPPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  CCPA - The value passed via setPrivacyFrameworkRequired() will indicate to AdColony whether CCPA is applicable legislation for the user.  
>  If it's set to true, the user is subject to the CCPA. Note that IAB US Privacy String has information embedded into the string to  
>  indicate whether CCPA is applicable. In the event of conflicting signals between the IAB US Privacy String and setPrivacyFrameworkRequired(),  
>  we will interpret as CCPA being applicable.  
>  CCPAConsent - A value of "1" implies the user has not opted-out to the sale of their data, as defined by the CCPA, and AdColony should continue with our standard processing of user information. A value of "0" means the user has opted-out to the sale of their data.  
>  AdColony.InitializeRewarded("AdColony", "YOUR\_APP\_ID", "YOUR\_ZONE\_ID", False, "1", False, "1", False, "1")  
>  AdColony.RequestRewarded*- **IsInitialized** As Boolean
> - **RequestRewarded**
> *Request Rewarded Ad, OnRequestFilled event will fire when request is successful.*- **Show**
> *Show Rewarded Ad  
>  DO NOT Show Ad before OnRequestFilled event fire.*

  
For Interstitial Ad and for Rewarded Interstitial Ad you need to add this in your manifest:  

```B4X
AddApplicationText(<activity  
            android:name="com.adcolony.sdk.AdColonyInterstitialActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:hardwareAccelerated="true" />  
        <activity  
            android:name="com.adcolony.sdk.AdColonyAdViewActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:hardwareAccelerated="true" />)
```

  
  
  
For GDPR, COPPA and CCPA please read: <https://github.com/AdColony/AdColony-Android-SDK/wiki/Privacy-Laws>  
  
Download library zip file and extract archive to Additional Libraries folder.