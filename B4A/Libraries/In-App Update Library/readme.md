### In-App Update Library by ArminKh1993
### 03/24/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126305/)

![](https://developer.android.com/images/app-bundle/flexible_flow.png)  
  
Keeping your app up-to-date on your users’ devices enables them to try new features, as well as benefit from performance improvements and bug fixes. Although some users enable background updates when their device is connected to an unmetered connection, other users may need to be reminded to update. In-app updates is a Play Core library feature that introduces a new request flow to prompt active users to update your app.  
  
This is a B4A wrapper for **Google In-App Update**. <https://developer.android.com/guide/playcore/in-app-updates>  
Before you begin, please read google documentation. You can also read from CapTech <https://www.captechconsulting.com/blogs/upgrading-your-app-with-in-app-updates> and Medium article.  
[MEDIA=medium]57f1aee011cb[/MEDIA]  
  
  
**Requirements:**  

- In-app updates works only with devices running Android 5.0 (API level 21) or higher, and requires you to [use Play Core library](https://developer.android.com/guide/playcore/play-feature-delivery#include_playcore) 1.5.0 or higher. To install Play Core library start SDK Manager and in search field type: **com.google.android.play:core** and install it.
- In-app updates are available only to user accounts that own the app. So, make sure the account you’re using has downloaded your app from Google Play at least once before using the account to test in-app updates.
- Make sure that the app that you are testing in-app updates with has the same application ID(Package Name) and is signed with the same signing key as the one available from Google Play.
- Because Google Play can only update an app to a higher version code, make sure the app you are testing as a lower version code than the update version code.
- When testing, make sure the Google Play cache is up to date by closing the Play Store App and then going back to the My Apps & Games tab before testing updates.

  
**HowToUse:**  
Note: This is an example of **ImmediateUpdate** which handle all tasks by itself.  
  
If you want to use this library with B4XPages then follow instructions here(<https://www.b4x.com/android/forum/threads/in-app-update-library.126305/post-809707>)  
  
- Add this line to your manifest.  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)
```

  
  
- Add this line in Project Attributes of your Main activity.  

```B4X
#AdditionalJar: com.google.android.gms:play-services-base
```

  
  
- Define a variable as InAppUpdate library.  

```B4X
Private Sub Globals  
  Private InAppUpdate As InAppUpdate  
End Sub
```

  
  
- Copy this codes to your main activity without change.  

```B4X
Private Sub CheckUpdate  
    InAppUpdate.initialize(False)  
    InAppUpdate.GetAppUpdateInfo  
  
    #IF JAVA  
      public void _onactivityresult(int requestCode,int resultCode){  
        com.khaan.iau.InAppUpdate.onActivityResult(activityBA,requestCode,resultCode);  
      }  
    #END IF  
End Sub  
  
Private Sub InAppUpdate_onAppUpdateInfoReceived(success As Boolean, inAppUpdateInfo As InAppUpdateInfo)  
    Log($"InAppUpdate_onAppUpdateInfoReceived, Success: ${success}"$)  
  
    If success Then  
      If inAppUpdateInfo.updateAvailability = inAppUpdateInfo.UPDATE_AVAILABILITY_DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS Or inAppUpdateInfo.updateAvailability = inAppUpdateInfo.UPDATE_AVAILABILITY_AVAILABLE Then  
        InAppUpdate.startImmediateUpdateFlow  
      End If  
    End If  
End Sub
```

  
  
- And finaly call CheckUpdate everywhere you want. for example in Activity\_Resume  

```B4X
Private Sub Activity_Resume  
    CheckUpdate  
End Sub
```

  
  
  
If you want to use **FlexibleUpdate** then you should implement methods and handle events and states manually.  
When you start a flexible update, a dialog first appears to the user to request consent. If the user consents, the download starts in the background and you can Show your custom progressbar to user when update is downloading, and the user may continue to interact with the app.  
After the update is downloaded, show a notification and request user confirmation to install update and restart the app.  
  
for more information please read documents.  
  
  
  
  
**InAppUpdate  
Version:** 1.1  

- **InAppUpdate**
Events:

- **InAppUpdate\_onAppUpdateInfoReceived** (success As Boolean, inAppUpdateInfo As InAppUpdateInfo)
- **InAppUpdate\_onUserAcceptUpdate** (accepted As Boolean)
- **InAppUpdate\_onStateUpdate** (installStatus As Int, arg1 As Long, arg2 As Long)

- **Fields:**

- **INSTALL\_STATUS\_REQUIRES\_UI\_INTENT As int**
- **INSTALL\_STATUS\_CANCELED As int**
- **INSTALL\_STATUS\_PENDING As int**
- **INSTALL\_STATUS\_DOWNLOADED As int**
- **INSTALL\_STATUS\_INSTALLING As int**
- **INSTALL\_STATUS\_DOWNLOADING As int**
- **INSTALL\_STATUS\_FAILED As int**
- **INSTALL\_STATUS\_INSTALLED As int**
- **INSTALL\_STATUS\_UNKNOWN As int**

- **Methods:**

- **fake\_UserRejectsUpdate As void**
*Simulates that a user has declined an update from the update confirmation dialog.  
 This method call works only if isConfirmationDialogVisible() or isImmediateFlowVisible() is true.*- **fake\_UpdateDownloaded As void**
*Simulates that update downloaded.*- **isTestMode As java.lang.Boolean**
*Retuen whether test mode is enabled or not.*- **fake\_UpdateDownloading As void**
*Simulates that update downloading.*- **StartImmediateUpdateFlow As void**
*Trigger the immediate update flow.*- **fake\_UserCancelsDownload As void**
*Simulates the user canceling the download via the Play UI.  
 This method call works only if the download of an update is pending or downloading.*- **installFlexibleUpdate As void**
*Once we detect that the InstallStatus represents the DOWNLOADED state,   
We are required to restart the app so that the update can be installed.   
Whilst the immediate update method handles this for you, in the case of the flexible update   
We need to manually trigger this. In order to manually trigger this update we need to make use of the installFlexibleUpdate method.   
When this is called, a full-screen UI will be displayed from the play core library and the app will be restarted in the background so that the update can be installed.   
 The app will then be restarted with the update applied.*- **Initialize** (ba As anywheresoftware.b4a.BA, testMode As boolean) **As com.khaan.iau.InAppUpdate**
*Initializes the In-App update.*- **fake\_UserAcceptsUpdate As void**
*Simulates that a user has accepted an flexible update from the update confirmation dialog.  
 The download is enqueued in PENDING status.*- **StartFlexibleUpdateFlow As void**
*Trigger the flexible update flow.*- **fake\_CustomState** (status As int) **As void**
*Simulates custom state.*- **fake\_UpdateFailed As void**
*Simulates that update is failed.*- **GetAppUpdateInfo As void**
*Checking whether there is an update that is available from the play store.*
- **InAppUpdateInfo**
Fields:

- **UPDATE\_AVAILABILITY\_DEVELOPER\_TRIGGERED\_UPDATE\_IN\_PROGRESS As int**
- **UPDATE\_AVAILABILITY\_AVAILABLE As int**
- **UPDATE\_AVAILABILITY\_UNKNOWN As int**
- **UPDATE\_AVAILABILITY\_NOT\_AVAILABLE As int**

- **Methods:**

- **totalBytesToDownload As long**
- **updateAvailability As int**
- **isImmediateUpdateAllowed As boolean**
- **bytesDownloaded As long**
- **clientVersionStalenessDays As java.lang.Integer**
- **installStatus As int**
- **updatePriority As int**
- **availableVersionCode As int**
- **isFlexibleUpdateAllowed As boolean**