### B4ActivityManager: detect bots using your app by Alejandro Moyano
### 05/15/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/140569/)

Hi I needed to detect bots to block and found that can be handled by the activity manager using the functions **isRunningInUserTestHarness** and **isUserAMonkey** then I developed a wrapper around.  
  
The following functions are implemented:  
  

- **isRunningInUserTestHarness**: Returns "true" If the device Is running in Test Harness Mode.
- **getLockTaskModeState**: Return the current state of task locking. The three possible outcomes are LOCK\_TASK\_MODE\_NONE, LOCK\_TASK\_MODE\_LOCKED and LOCK\_TASK\_MODE\_PINNED.
- **isInLockTaskMode**: Return true if is locked.
- **isBackgroundRestricted**: Query whether the user has enabled background restrictions For this app. true if user has enforced background restrictions for this app, false otherwise. Emits a log warning and return False in case of sdk < 28.
- **isLowMemoryKillReportSupported**: Whether or not the low memory kill will be reported in. Emits a log warning and return False in case of sdk < 30.
- **isLowRamDevice**: Returns true if this is a low-RAM device. Emits a log warning and return False in case of sdk < 19.
- **isUserAMonkey**: Returns "true" If the user interface Is currently being messed with by a monkey. Emits a log warning and return False in case of sdk < 8.
- **getLargeMemoryClass**: Return the approximate per-Application memory class of the current device when an Application Is running with a large heap. Emits a log warning and return -1 in case of sdk < 11.
- **getLauncherLargeIconDensity**: Get the preferred Density of icons For the launcher. Emits a log warning and return -1 in case of sdk < 11.
- **getLauncherLargeIconSize**: Get the preferred launcher icon size. Emits a log warning and return -1 in case of sdk < 11.
- **getMemoryClassReturn** the approximate per-Application memory class of the current device. Emits a log warning and return in case of sdk < 11.

Testing:  
  
The project contains an app with 2 buttons, one test for robots and another run all methods.  
  
![](https://www.b4x.com/android/forum/attachments/129238)  
  
You can find all the source code on github: <https://github.com/alejivo/B4B4ActivityManager>  
  
To add more code, please fork it and made a pull request to add the features and share the changes.  
  
Greetings!  
Alejandro.