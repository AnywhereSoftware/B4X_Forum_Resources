### list from a list by 67biscuits
### 05/28/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171141/)

```B4X
Private Sub spnSection_ItemClick (Position As Int, Value As Object)  
    '(frame, elect, eng, brakes, FACI,suspension, wheels, custom)  
Log(Position & Value)  
    Dim lst As List = allSections.Get(Position)  
    Log(lst)  
    spnSubSection.AddAll(lst)  
  
End Sub
```

  
  
why does this fail when it hits the spnSubSection.addall line?  
if I run it from B4XPage\_Created using a static value (eg; frame, elect, eng…etc) then it's fine.  
  
Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.  
\*\* Activity (main) Resume \*\*  
3Brakes  
(List) (ArrayList) [Controls, Cables/Lines, Pads/Shoes, Resevoir]  
\*\* Activity (main) Pause event (activity is not paused). \*\*  
\*\*\* Service (starter) Create \*\*\*  
\*\* Service (starter) Start \*\*  
\*\* Activity (main) Create (first time) \*\*  
Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.  
\*\* Activity (main) Resume \*\*  
3Brakes  
(List) (ArrayList) [Controls, Cables/Lines, Pads/Shoes, Resevoir]  
Error occurred on line: 106 (B4XMainPage)  
java.lang.ClassCastException: anywheresoftware.b4a.objects.collections.List cannot be cast to java.util.Collection  
 at anywheresoftware.b4a.objects.SpinnerWrapper.AddAll(SpinnerWrapper.java:121)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at anywheresoftware.b4a.shell.Shell.runVoidMethod(Shell.java:777)  
 at anywheresoftware.b4a.shell.Shell.raiseEventImpl(Shell.java:354)  
 at anywheresoftware.b4a.shell.Shell.raiseEvent(Shell.java:255)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at anywheresoftware.b4a.ShellBA.raiseEvent2(ShellBA.java:157)  
 at anywheresoftware.b4a.BA$1.run(BA.java:360)  
 at android.os.Handler.handleCallback(Handler.java:958)  
 at android.os.Handler.dispatchMessage(Handler.java:99)  
 at android.os.Looper.loopOnce(Looper.java:205)  
 at android.os.Looper.loop(Looper.java:294)  
 at android.app.ActivityThread.main(ActivityThread.java:8261)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:622)  
 at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:977)