### Google Analytics by Erel
### 01/25/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/63580/)

**Edit: use iFirebaseAnalytics instead.**  
  
B4i v2.50 includes a wrapper for Google Analytics SDK (iAnalytics).  
  
![](https://www.b4x.com/basic4android/images/SS-2016-02-08_15.56.47.png)  
  
Using this library is simple.  
  
You need to initialize the AnalyticsTracker with the tracking id (it looks like UA-xxxxx-y).  
You should then call tracker.SendScreenView in the Page\_Appear of each page.  
  
The ScreenName is an identifier that you will later use to identify the page.  
  
The last method is TrackEvent which allows you to manually send a GA event.  
  
By using this library you agree to Google terms and privacy policy:  
<http://www.google.com/analytics/tos.html>  
<https://developers.google.com/analytics/devguides/collection/protocol/policy>  
  
If you are using a local builder then you should download the SDK: <https://developers.google.com/analytics/devguides/collection/ios/v3/sdk-download> and copy libGoogleAnalyticsServices.a to the Libs folder.