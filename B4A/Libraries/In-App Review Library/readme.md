### In-App Review Library by Pendrush
### 01/15/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120968/)

**Before you begin, please read [THIS](https://android-developers.googleblog.com/2020/08/in-app-review-api.html) and [THIS](https://developer.android.com/guide/playcore/in-app-review).** You can also read Medium article [Demystifying the new Play In-App Review API](https://medium.com/googleplaydev/demystifying-the-new-play-in-app-review-api-1a78e351db7a) (thanks [USER=14167]@fredo[/USER]).  
  
Requirements:  

1. Android devices (phones and tablets) running Android 5.0 (API level 21) or higher that have the Google Play Store installed.
2. App minSdkVersion="21"
3. Please check **manifest** in app example.
4. After implementation, app must be uploaded to Play Store and downloaded from Play Store (beta test should work). If app is not downloaded from Play Store dialog will not work, OnComplete event will fire immediately.

  
> **InAppReview  
>   
> Author:** Author: Google - B4a Wrapper: Pendrush  
> **Version:** 2.01  
>
> - **InAppReview**
>
> - **Events:**
>
> - **OnComplete**
> - **OnError** (Error As String)
>
> - **Functions:**
>
> - **Initialize** (EventName As String, UseFakeReviewManager As Boolean)
> *Initialize InAppReview  
>  UseFakeReviewManager = True - This should only be used for unit or integration tests to verify the behaviour of the app once the review is completed.  
>  Note: FakeReviewManager does not simulate the UI (no pop-up will be shown). It only fakes the API method result by always providing a fake ReviewInfo object and returning a success status when the in-app review flow is launched.  
>  UseFakeReviewManager = False - Use it for production app.   
>  InAppReview.Initialize("InAppReview", False)*- **LaunchReview**
> *Launch review process. Pop-up window will show only for app downloaded from Play Store (Production app).  
>  OnComplete event will fire immediately if you initialize with UseFakeReviewManager = True  
>  Emulator will rise OnError event.*

  
  
Use SDK Manager and install:  

```B4X
com.google.android.play:review  
com.google.android.gms:play-services-tasks  
com.google.android.play:core-common
```

  
  
  
Example app is attached to this post.  
OnComplete event will fire immediately after you click on button in example app. This behavior is normal for example app, but app in production (app downloaded from Play Store) should show dialog like this:  
![](https://www.b4x.com/android/forum/attachments/98170)  
OnComplete event will fire after dialog is closed.  
  
You need to set minSdkVersion="21" and to add this in your manifest:  

```B4X
AddApplicationText(<activity  
            android:name="com.google.android.play.core.common.PlayCoreDialogWrapperActivity"  
            android:exported="false"  
            android:stateNotNeeded="true"  
            android:theme="@style/Theme.PlayCore.Transparent" />)
```

  
  
Download library zip file and extract archive to Additional Libraries folder.  
Example app will trigger OnError event in emulator.  
  
Thanks to: [USER=36583]@ronnhdf[/USER] and [USER=10835]@Jack Cole[/USER] for testing.  
  
  
v2.01:  

- Library update to use **com.google.android.play:review** as InAppReview will be removed from com.google.android.play:core. The Google Play Core Java and Kotlin library have been split into multiple separate libraries, one for each feature.
- Manifest update.
- Example app update (only manifest).
- Some permissions removed.
- Library dependencies has changed.