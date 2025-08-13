### Physical Activity Recognition Detection by Erel
### 01/09/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/42481/)

**Class updated on May 2023.**  
  
This class allows you to monitor the user / device physical state (walking, running, still, etc.).  
  
The state detection is based on Android location services which use low power sensors to try to detect the current activity. Once you connect your app to these services you will receive notifications even when your app is in the background (similar to static intent filters).  
  
Configuration steps:  
1. Add this line to the main activity:  

```B4X
#AdditionalJar: com.google.android.gms:play-services-location
```

  
2. Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
AddPermission(com.google.android.gms.permission.ACTIVITY_RECOGNITION)  
AddPermission(android.permission.ACTIVITY_RECOGNITION)
```

  
3. Add a receiver named RecognitionReceiver that handles the events.  
See the attached example.  
  
  
**Notes**  
  
- Android may kill the process and then recreate it when a notification is delivered. This means that it is better to run the app in Release mode. Otherwise it will fail when the process is recreated.  
  
**History**  
  
V4.00 - Based on receiver instead of service.  
V3.00 - Released as a class instead of a library. It is based on a new Google API. Not backward compatible.