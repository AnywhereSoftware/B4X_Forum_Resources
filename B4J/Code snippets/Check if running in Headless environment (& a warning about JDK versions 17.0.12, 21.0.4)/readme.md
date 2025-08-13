### Check if running in Headless environment (& a warning about JDK versions 17.0.12, 21.0.4) by Chris2
### 10/17/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/163608/)

**Short version**:  
You can check if your app is running in a headless environment (i.e. without a display etc) using JavaObject:  

```B4X
'True if environment is headless, i.e. it has no display, etc  
'False otherwise  
Public Sub HWIsHeadless As Boolean  
  
    Dim jo As JavaObject  
    jo.InitializeStatic("java.awt.GraphicsEnvironment")  
    Return jo.RunMethod("isHeadless", Null)  
  
End Sub
```

  
  
**Longer version and a warning/'heads up' (pun intended)**  
For a while I've had a UI app that I have set via a Task Scheduler task to run on a Windows machine at startup, before any user log in.  
This has worked fine until I started using it with JDK 17.0.12, at which point I started getting an error when the app was started by the Task Scheduler task:  

```B4X
java.awt.HeadlessException:  
The application does not have desktop access,  
but this program performed an operation which requires it.  
    at java.desktop/java.awt.TrayIcon.<init>(Unknown Source)  
    at java.desktop/java.awt.TrayIcon.<init>(Unknown Source)  
    at b4j/anywheresoftware.b4j.objects.SystemTrayWrapper$TrayIconWrapper.Initialize(Unknown Source)
```

  
This error came from to the code that sets up the system tray icon for my app (using jSystemTray).  
  
I found [this](https://bugs.openjdk.org/browse/JDK-8185862) that details a fix in JDK 17.0.12 that makes java.awt.GraphicsEnvironment.isHeadless() come back true if no monitor is detected, where as in previous JDK versions it came back false.  
  
So my warning to everyone is that it seems that parts of jSystem tray (and possibly other things in a UI app) will fail if running in a headless environment from JDK17.0.12 onwards where previously they worked OK.  
  
You can use the code above to check for a headless environment and only setup the UI bits if HWIsHeadless=false.