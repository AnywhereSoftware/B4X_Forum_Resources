### Google Authorization with AuthorizationClient by Erel
### 10/29/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169164/)

The oauth2 approach implemented here: <https://www.b4x.com/android/forum/threads/class-b4x-google-oauth2.79426/#content> is no longer supported by Android. Google instead provides a new API for allowing the user to securely authorize access to their account data.  
  
Start by following Google's instructions about the configuration required in Google developer console: <https://developer.android.com/identity/authorization#maintain-access>  
  
The B4A code is quite simple. There are two steps:  
1. Checking whether the user has already granted access.  

```B4X
Wait For (ga.AuthorizeMaybeAutomatic(scopes)) Complete (Result As AuthorizationResult)
```

  
No UI will be displayed at this point.  
Result.ResolutionNeeded tells us whether the authorization flow should be started.  
  
2. If ResultionNeeded is true:  

```B4X
Wait For (ga.AuthorizeRequestAccess(Result)) Complete (Result As AuthorizationResult)
```

  
At this point the user will be asked to grant access for your app.  
  
Once we have the token we can use it to make requests as demonstrated in the attached example. You will not be able to run the example without making the required configuration.  
  
There is a ClearToken method that clears a cached token. It should be used when a request made with the token fails. Another usage for this is for testing. On the browser, log into your Google account and find the list of connected apps. Remove the app from the list and then call ClearToken to test the full flow again. Note that this method depends on [plain]com.google.android.gms:play-services-auth[/plain] v21.4.0 which isn't installed by default.  
  
Notes:  
Manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
  
And main module:  

```B4X
#AdditionalJar: com.google.android.gms:play-services-auth
```