### Firebase Crashlytics by Biswajit
### 10/15/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/117616/)

This is a wrapper of Firebase Crashlytics library for B4i. I made this for [USER=10835]@Jack Cole[/USER] and he gave me permission to post this in forum to help other users.  
  
**iFirebaseCrashlytics  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 2  

- **Crashlytics**

- **Events:**

- **HasUnsentReports**

- **Functions:**

- **checkForUnsentReports**
*Check for unsent reports  
You must set setCrashlyticsCollectionEnabled to false in order to use hasUnsentReports  
 If there is any unsent report the EventName\_HasUnsentReports event will be raised*- **deleteUnsentReports**
*Delete unsent reports*- **didCrashDuringPreviousExecution** As Boolean
*Detect when a crash happens during your app's last run.*- **Initialize** (EventName As String)
*Turn off automatic collection by adding a new key to your project  
#PlistExtra: <key>FirebaseCrashlyticsCollectionEnabled</key><false/>  
Initializes the library inside the Application\_Start function.  
 You should initialize FirebaseAnalytics before initializing this library.*- **isCrashlyticsCollectionEnabled** As Boolean
*Check if automatically report collection is enabled or not*- **Log** (msg As String)
*Add custom log messages  
 NOTE: To avoid slowing down your app, Crashlytics limits logs to 64kB and deletes older log entries when a session's logs go over that limit.*- **sendUnsentReports**
*Send unsent reports*- **setCrashlyticsCollectionEnabled** (enable As Boolean)
*Enable collection for select users by calling the Crashlytics data collection override at runtime. The override value persists across launches of your app so Crashlytics can automatically collect reports. To opt out of automatic crash reporting, pass false as the override value. When set to false, the new value does not apply until the next run of the app*- **SetUserID** (ID As String)
*Set user identifiers*- **TestCrash**
*Cause a Test Crash*
  
**Installation:**  

1. Download the latest libraries from [here](https://www.b4x.com/android/forum/threads/firebase-2-50-april-2020.116278/).
2. Download the attached Zip file.
3. Copy the **.a and .h** file to the local build server's **Libs** folder.
4. Then copy the **XML** file to the B4i **library** folder.
5. Copy the **upload-symbols** file to **FirebaseCrashlytics.framework** folder of your local build server.

**Usage:**  

1. Follow firebase integration tutorial from [here](https://www.b4x.com/android/forum/threads/firebase-integration.68623/),
2. After initializing the firebase analytic library initialize this crashlytics library.
3. You have to build the project in **Release Mode**. Otherwise, the builder will not generate the **dSYM** which is needed for the library to work.

**Enable opt-in reporting**  

```B4X
#PlistExtra: <key>FirebaseCrashlyticsCollectionEnabled</key><false/>
```

  
  
**After building the project (Not possible from hosted builder):**  

1. Don't run the app after building. Open **Terminal** App.
2. Type, **cd /path/to/your/project/directory**
In my case, it is **/Volumes/ExtendedSSD/B4iBuildServer/UploadedProjects/a888heh**3. Paste this following code to upload **dSYM** file to google server and hit enter,
**../../Libs/FirebaseCrashlytics.framework/upload-symbols -gsp ./GoogleService-Info.plist -p ios ./Payload**4. Now run the app.
5. For testing the crash call **FirebaseCrashlytics.TestCrash.**
6. It may take few minutes to reflect on the firebase dashboard

**Update 1.01:** Added simulator support.  
**Update 2.0:**   

1. Based on the new SDK.
2. Added option to check if any crash happens during the last run.
3. Added option to check if there are any unsent crash reports.
4. Added option to manually send unsent crash reports.
5. Added option to delete unsent crash reports.
6. Added option to check if automatic report collection is enabled or not
7. Added option to toggle automatic report collection
8. Added option to send custom log to crashlytics