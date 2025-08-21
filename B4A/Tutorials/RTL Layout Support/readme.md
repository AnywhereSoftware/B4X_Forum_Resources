### RTL Layout Support by mshafiee110
### 05/13/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/117693/)

1.Declare in your app manifest that your app supports RTL mirroring.  
Specifically, add below code in your manifest.  

```B4X
SetApplicationAttribute (android:supportsRtl, true)
```

  
  
2. Copy the code you need from below and call it in Activity\_Create or any sub you want to use it.  
  

```B4X
Sub ForceRtlSupported4View(View As View)  
    Dim jA,jos As JavaObject  
    jos.InitializeStatic  ("android.view.View")  
    If jA.InitializeStatic  ("android.os.Build$VERSION").GetField ("SDK_INT") > 16 Then  
        jA = View  
        jA.RunMethod ("setLayoutDirection",Array(jos.GetField ("LAYOUT_DIRECTION_RTL")))  
    End If  
End Sub  
  
Sub ForceLtrSupported4View(View As View)  
    Dim jA,jos As JavaObject  
    jos.InitializeStatic  ("android.view.View")  
    If jA.InitializeStatic  ("android.os.Build$VERSION").GetField ("SDK_INT") > 16 Then  
        jA = View  
        jA.RunMethod ("setLayoutDirection",Array(jos.GetField ("LAYOUT_DIRECTION_LTR")))  
    End If  
End Sub  
  
Sub ForceRtlSupported  
    Dim j,jo As JavaObject  
    jo.InitializeStatic  ("android.view.View")  
    If j.InitializeStatic  ("android.os.Build$VERSION").GetField ("SDK_INT") > 16 Then  
        j.InitializeContext.RunMethodJO("getWindow",Null).RunMethodJO("getDecorView",Null) _  
.RunMethod ("setLayoutDirection",Array(jo.GetField ("LAYOUT_DIRECTION_RTL")))  
    End If  
End Sub  
  
Sub ForceLtrSupported  
    Dim j,jo As JavaObject  
    jo.InitializeStatic  ("android.view.View")  
    If j.InitializeStatic  ("android.os.Build$VERSION").GetField ("SDK_INT") > 16 Then  
        j.InitializeContext.RunMethodJO("getWindow",Null).RunMethodJO("getDecorView",Null) _  
.RunMethod ("setLayoutDirection",Array(jo.GetField ("LAYOUT_DIRECTION_LTR")))  
    End If  
End Sub
```

  
  

```B4X
 android:minSdkVersion="17"
```

  
  
<https://developer.android.com/about/versions/android-4.2#RTL>