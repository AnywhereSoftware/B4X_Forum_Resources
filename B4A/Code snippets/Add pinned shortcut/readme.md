### Add pinned shortcut by Erel
### 01/03/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/108752/)

This code shows a dialog that lets the user add a shortcut on the home screen. You can modify the intent and add extra keys and values which can later be used by your app.  
Activity\_Resume will be called when the shortcut is clicked. You can get the intent with Activity.GetStartingIntent.  

```B4X
#AdditionalJar: androidx.core:core  
  
Sub RequestPinShortcut (id As String, icon As Bitmap, ShortLabel As Object, Update As Boolean)  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim ShortcutManagerCompat As JavaObject  
    ShortcutManagerCompat.InitializeStatic("androidx.core.content.pm.ShortcutManagerCompat")  
    Dim supported As Boolean = ShortcutManagerCompat.RunMethod("isRequestPinShortcutSupported", Array(ctxt))  
    If supported Then  
        Dim builder As JavaObject  
        builder.InitializeNewInstance("androidx.core.content.pm.ShortcutInfoCompat.Builder", Array(ctxt, id))  
        builder.RunMethod("setShortLabel", Array(ShortLabel))  
        builder.RunMethod("setIcon", Array(CreateIconFromBitmap(icon)))  
        Dim in As Intent  
        in.Initialize(in.ACTION_MAIN, "")  
        in.SetComponent(Application.PackageName & "/.main") 'lower case  
        builder.RunMethod("setIntent", Array(in))  
        Dim info As JavaObject = builder.RunMethod("build", Null)  
        If Update Then  
            Dim infos As List = Array(info)  
            Log("Update successfully? " & ShortcutManagerCompat.RunMethod("updateShortcuts", Array(ctxt, infos)))  
        Else  
            ShortcutManagerCompat.RunMethod("requestPinShortcut", Array(ctxt, info, Null))  
        End If  
    End If  
End Sub  
  
Private Sub CreateIconFromBitmap(bmp As Bitmap) As Object  
    Dim ic As JavaObject  
    Return ic.InitializeStatic("androidx.core.graphics.drawable.IconCompat").RunMethod("createWithBitmap", Array(bmp))  
End Sub
```

  
Depends on JavaObject.