### Permission Dialog Won't Display by Buncher60
### 09/25/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/134570/)

A tip for small players in Permissions Dialogs, which until today and after hours searching for an answer yesterday, I was one, I hope the following will be useful.  
  
From my perspective nonsensically, from Android 11, if a User rejects any Permission request from within an application, that dialog is never shown again - ever.  
  
If the User then decides that they want to access a feature for which a Permission needs to be set within an application, they need to know (somehow) or remember that they have to go into the Device's Settings and change the required Permission for the app that they're using.  
  
Importantly for the Developer, if a function or routine is called for which a required Permission was rejected, the application will either crash or the function or routine will be simply bypassed and like me, will spend hours on a fruitless search trying to work out what's wrong.   
  
Android's reasoning for this change - "This behavior(sic) change in Android 11 discourages repeated requests for permissions that users have chosen to deny"  
  
You can read about it here: <https://developer.android.com/about/versions/11/privacy/permissions>