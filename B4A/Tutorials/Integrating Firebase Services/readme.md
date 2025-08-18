### Integrating Firebase Services by Erel
### 09/14/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/67692/)

Google has acquired a company named Firebase and is now offering many backend services under the Firebase umbrella. Most of them are free.  
  
Integrating the services is relatively simple.  
  
1. Use B4A Sdk Manager tool to install all recommended items.  
  
2. Register with Firebase and create a new project: <https://console.firebase.google.com/>  
Make sure that the package name matches your app's package name.  
  
3. Download google-services.json and put it in the projects folder (folder of the b4a file).  
  
4. Add the manifest snippets to the manifest editor based on the services that you need.  
  
5. Follow the instructions of the specific libraries.  
  
Note that a recent version of Google Play Services should be installed on the device.  
The minimum version of most features is 4.0 (API 14).  
You can test whether Google Play Services is available with FirebaseAnalytics.IsGooglePlayServicesAvailable or with: <https://www.b4x.com/android/forum/threads/check-and-install-google-play-services.84813>  
  
**Google Play Services Base** - Always required when using Google Play Services or Firebase:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
**Firebase** - Always required when using Firebase  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.Firebase)
```

  
**Firebase Notifications / Push messages**  

```B4X
CreateResourceFromFile(Macro, FirebaseNotifications.FirebaseNotifications)
```

  
**Firebase Analytics**  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.FirebaseAnalytics)
```

  
**Firebase Ads**  

```B4X
CreateResourceFromFile(Macro, FirebaseAdMob.FirebaseAds)
```

  
**Firebase Auth**  

```B4X
CreateResourceFromFile(Macro, FirebaseAuth.FirebaseAuth)
```