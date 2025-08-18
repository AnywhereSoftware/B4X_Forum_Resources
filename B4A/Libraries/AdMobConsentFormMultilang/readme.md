### AdMobConsentFormMultilang by Ivan Aldaz
### 01/09/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126337/)

Hi  
  
This class shows the consent form required for ads in EEC countries and UK in several languages (see Consts in Class\_Globals). It's almost a clone of the Google Consent form.  
  
Code is B4X, written for B4A. For the moment I don't use B4J or B4I, but I guess it's not much effort to adapt this class for the three plattforms. Perhaps some work with B4XCanvas or stringUtils.MeasureMultilineTextHeight…  
  
Translations are taken (tedious work) from the HTML files contained in the attached consentform.zip file, obtained from [this page](https://github.com/googleads/googleads-consent-sdk-ios/issues/19). Will someone ? ever run into direct form creation based on these HTML files? I've tried by WebView, and almost got it, but had no luck on catching the clicked button on the opened HTML, and that's why I created this class.  
As each developer may choose his ads providers, **each developer has to download his own file** "ad\_technology\_provider\_privacy\_urls.csv" from his [AdMob console](https://apps.admob.com/v2/pubcontrols/eu-user-consent) ![](https://www.b4x.com/android/forum/attachments/105775). This information is provided by AdMob in ConsentManager (FirebaseAdMob library) through consent.RequestInfoUpdate, but I haven't found the way to extract it from there.  
  
Class module is included in the example attached file.  
  
I know that there will not be many Chinese, Japanese or Korean here in Europe who install the application but, who knows…? :)  
  
Please, feel free to change, improve and/or distribute free of charge