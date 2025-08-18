### Google App Open Ads by Biswajit
### 12/30/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/125993/)

This is a wrapper of Google AppOpen Ads library for B4i. I made this for [USER=10835]@Jack Cole[/USER] and he gave me permission to post this in forum to help other users.  
  
B4A wrapper is [available here](https://www.b4x.com/android/forum/threads/google-app-open-ads.125994/).  
  
**iGADAppOpenAd  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1  

- **iGADAppOpenAd**
*Google AppOpenAd.*

- **Events:**

- **AppOpenAd\_Event** (event As String)

- **Functions:**

- **Initialize** (callback As Object)
*Initializes the object on Application\_Start.*- **IsInitialized** As BOOL
*Tests whether the object has been initialized.*- **RequestAppOpenAd** (adID As String)
*Request an ad for later use.  
 Like you can call this after the user dismisses the first ad.*- **SetTestDevices** (ID As String)
*NOT NEEDED FOR SIMULATORS  
If you are testing the ad integrtion then call this after initializing.  
 ID that is displayed in the logs*- **TryToPresentAppOpenAd** (adID As String)
*Call this method on Application\_Active event.  
 If there is no ad loaded then it will first load the ad then present the ad.*
**Installation:**  

1. Download the latest libraries from [here](https://www.b4x.com/android/forum/threads/firebase-2-50-april-2020.116278/).
2. Download the attached library zip.
3. Copy the **.a** and **.h** to the local build server **Libs** folder on your **mac**.
4. Copy the **xml** file to the B4i additional library folder on **windows**.
5. Download the GoogleMobileAds frameworks from: [www.b4x.com/b4i/files/GoogleMobileAds-v7.69.0.zip](https://www.b4x.com/b4i/files/GoogleMobileAds-v7.69.0.zip)
6. Copy all the frameworks to the local build server **Libs** folder on your **mac**