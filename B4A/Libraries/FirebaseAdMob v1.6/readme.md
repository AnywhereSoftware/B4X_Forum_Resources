### FirebaseAdMob v1.6 by Erel
### 06/21/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/108552/)

Google has added a few new requirements to AdMob implementation. You must make these changes if you are using the latest versions of Android SDK libraries (firebase-ads 18.1.1+).  
  
Instructions:  
2. Find your AdMob app id and add it to the manifest editor:  

```B4X
'This is a sample AdMob app id. You need to change it to your id.  
AddReplacement($ADMOB_APP_ID$, ca-app-pub-3940256099942544~3347511713)
```

  
How to find the id: <https://support.google.com/admob/answer/7356431?hl=en>  
  
3. Initialize MobileAds in Service\_Create of the starter service:  

```B4X
Dim MobileAds As MobileAds  
MobileAds.Initialize
```

  
4. Open Tools - B4A Sdk Manager and update all the recommended items.  
  
If the app immediately crashes then it is likely that the app id is wrong. Start with the sample app id and then change it to your app id.  
  
**Library is included as an internal library.**