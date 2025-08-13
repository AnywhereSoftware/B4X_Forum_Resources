### I have been tested this app but it is not working properly by Alhootti
### 08/09/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/162461/)

[Temprature API](https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-b4x-xui-b4xpages-using-b4a-gps-to-create-a-basic-weather-app-newer-developers.127431/#content)  
  

```B4X
*** Service (starter) Create ***  
** Service (starter) Start **  
** Activity (main) Create (first time) **  
b4ximageview_updateclip (java line: 291)  
java.lang.RuntimeException: Method: setClipToOutline not found in: anywheresoftware.b4a.BALayout  
    at anywheresoftware.b4j.object.JavaObject$MethodCache.getMethod(JavaObject.java:363)  
    at anywheresoftware.b4j.object.JavaObject.RunMethod(JavaObject.java:120)  
    at b4a.example.b4ximageview._updateclip(b4ximageview.java:291)  
    at b4a.example.b4ximageview._update(b4ximageview.java:217)  
    at b4a.example.b4ximageview._setbitmap(b4ximageview.java:170)  
    at b4a.example.b4xmainpage._setimages(b4xmainpage.java:353)  
    at b4a.example.b4xmainpage._b4xpage_created(b4xmainpage.java:72)  
    at b4a.example.b4xmainpage.callSub(b4xmainpage.java:380)  
    at anywheresoftware.b4a.keywords.Common.CallSub4(Common.java:1098)  
    at anywheresoftware.b4a.keywords.Common.CallSubNew2(Common.java:1069)  
    at b4a.example.b4xpagesmanager._createpageifneeded(b4xpagesmanager.java:531)  
    at b4a.example.b4xpagesmanager._showpage(b4xpagesmanager.java:868)  
    at b4a.example.b4xpagesmanager._addpage(b4xpagesmanager.java:202)  
    at b4a.example.b4xpagesmanager._addpageandcreate(b4xpagesmanager.java:209)  
    at b4a.example.b4xpagesmanager._initialize(b4xpagesmanager.java:719)  
    at b4a.example.main._activity_create(main.java:370)  
    at java.lang.reflect.Method.invokeNative(Native Method)  
    at java.lang.reflect.Method.invoke(Method.java:515)  
    at anywheresoftware.b4a.BA.raiseEvent2(BA.java:221)  
    at b4a.example.main.afterFirstLayout(main.java:105)  
    at b4a.example.main.access$000(main.java:17)  
    at b4a.example.main$WaitForLayout.run(main.java:83)  
    at android.os.Handler.handleCallback(Handler.java:733)  
    at android.os.Handler.dispatchMessage(Handler.java:95)  
    at android.os.Looper.loop(Looper.java:136)  
    at android.app.ActivityThread.main(ActivityThread.java:5001)  
    at java.lang.reflect.Method.invokeNative(Native Method)  
    at java.lang.reflect.Method.invoke(Method.java:515)  
    at com.android.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:785)  
    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:601)  
    at dalvik.system.NativeStart.main(Native Method)
```