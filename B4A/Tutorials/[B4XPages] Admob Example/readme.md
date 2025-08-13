### [B4XPages] Admob Example by asales
### 09/25/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/113586/)

**Check this other [excellent example](https://www.b4x.com/android/forum/threads/adshelper-extension-for-traditional-b4a-apps-more.131798/#content) from [USER=10835]@Jack Cole[/USER].**  
  
To help the new members to make money with B4A, I tried to compile all the relevant Admob code (except mediation) of the forum in this example and put comments and links.  
This is a work in progress.  
Any code and sample to improve this example are welcome.  
  
Follow these instructions to start:  
1. Integrating Firebase Services  
- <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
2. FirebaseAdMob - Admob ads integrated with Firebase backend  
- <https://www.b4x.com/android/forum/threads/firebaseadmob-admob-ads-integrated-with-firebase-backend.67710/#content>  
3. FirebaseAdMob v1.6  
- <https://www.b4x.com/android/forum/threads/firebaseadmob-v1-6.108552/>  
4. B4A 9.90 and SDK Manager up to date.  
  
Update **6.0:**  
- Adaptive banner with customlistview  
  
Update **5.0**:  
- Rewarded Video and Rewarded Interstitial Ads  
- AdsHelper updated with [code from Jack Cole](https://www.b4x.com/android/forum/threads/adshelper-extension-for-traditional-b4a-apps-more.131798/#content). Thanks!  
  
Update **4.0**:  
- removed transitions code to fix [this error](https://www.b4x.com/android/forum/threads/solved-error-in-interstitial-ad-button-in-b4xpages-admob-example.146662/)  
- example code to adjust volume level  

```B4X
Dim volume As Float = 0.5  
jo.RunMethod("setAppVolume", Array(volume))
```

  
  
Update **3.0**:  
The example was updated with some changes made with the FirebaseAdmob2 lib.  
- new lib: FirebaseAdmob2  
- change SIZE\_SMART\_BANNER format to Adaptive Banner  
- AdsHelper Class  
- Rewarded video ad removed  
- App Open Ad included  
  
Updated **2.0** (B4XPages\_Admob\_Example):  
- B4XPages  
- [Transition](https://www.b4x.com/android/forum/threads/custom-transitions-between-activities.15065/#content) in Interstitial ad (requires Reflection library)  
- Code to mute the ad sound  
- Banner in a panel  
  
This is not a (almost) definitive example anymore, like the old title said.  
  
![](https://www.b4x.com/android/forum/attachments/144248)