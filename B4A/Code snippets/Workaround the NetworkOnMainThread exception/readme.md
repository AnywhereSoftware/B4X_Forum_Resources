### Workaround the NetworkOnMainThread exception by Erel
### 04/10/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/44760/)

Android 4+ doesn't allow applications to make network calls on the main thread. There is a good reason for this restriction as such calls cause the UI to freeze and after 5 second Android will show the "Application not responding" dialog.  
  
Proper libraries take care of handling network calls with background threads. If you encounter a library that doesn't do it then you have two options:  
  
1. Use the Threading library to start a background thread and make the calls from this thread.  
2. Disable this check.  
  
The code posted here disables this check (it only calls public APIs and is safe to use):  

```B4X
Sub DisableStrictMode  
   Dim jo As JavaObject  
   jo.InitializeStatic("android.os.Build.VERSION")  
   If jo.GetField("SDK_INT") > 9 Then  
     Dim policy As JavaObject  
     policy = policy.InitializeNewInstance("android.os.StrictMode.ThreadPolicy.Builder", Null)  
     policy = policy.RunMethodJO("permitAll", Null).RunMethodJO("build", Null)  
     Dim sm As JavaObject  
     sm.InitializeStatic("android.os.StrictMode").RunMethod("setThreadPolicy", Array(policy))  
   End If  
End Sub
```

  
  
Tags: NetworkOnMainThreadException, strict mode