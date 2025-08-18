### Google App Open Ads by Biswajit
### 12/29/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/125994/)

This is a wrapper of Google AppOpen Ads library for B4A. I made this for [USER=10835]@Jack Cole[/USER] and he gave me permission to post this in forum to help other users.  
  
B4i wrapper is [available here](https://www.b4x.com/android/forum/threads/google-app-open-ads.125993/).  
  
**GADAppOpenAd  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1  

- **GADAppOpenAd**
*Google AppOpenAd.*

- **Events:**

- **AppOpenAd\_Event** (event As String)

- **Functions:**

- **Initialize** (callback As Object)
*Initializes the object on Activity\_Create.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RequestAppOpenAd** (adID As String)
*Request an ad for later use.  
 Like you can call this after the user dismisses the first ad.*- **TryToPresentAppOpenAd** (adID As String)
*Call this method on Application\_Resume event.  
 If there is no ad loaded then it will first load the ad then present the ad.*
**Installation:** Copy the attached JAR and XML files to B4A additional library folder.