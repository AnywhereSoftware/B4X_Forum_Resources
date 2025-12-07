### Disable screenshot & screen recording by Mehrzad238
### 12/01/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/169508/)

This method works in Android 3 to 15  
  
For Activity this way:  

```B4X
Sub DisableScreenCapture  
  Dim r As Reflector  
  Dim act As Object = r.GetActivity  
  Dim jo As JavaObject = act  
  Dim window As JavaObject = jo.RunMethod("getWindow", Null)  
  window.RunMethod("setFlags", Array(0x00002000, 0x00002000))  
End Sub  
  
Sub EnableScreenCapture  
  Dim r As Reflector  
  Dim act As Object = r.GetActivity  
  Dim jo As JavaObject = act  
  Dim window As JavaObject = jo.RunMethod("getWindow", Null)  
  window.RunMethod("clearFlags", Array(0x00002000))  
End Sub
```

  
  
and for B4XPages:  

```B4X
Sub DisableScreenCapture  
    Dim act As JavaObject = B4XPages.GetNativeParent(Me)  
    Dim window As JavaObject = act.RunMethod("getWindow", Null)  
    window.RunMethod("setFlags", Array(0x00002000, 0x00002000))  
End Sub  
  
Sub EnableScreenCapture  
    Dim act As JavaObject = B4XPages.GetNativeParent(Me)  
    Dim window As JavaObject = act.RunMethod("getWindow", Null)  
    window.RunMethod("clearFlags", Array(0x00002000))  
End Sub
```

  
  
[HEADING=2]✔ Recommended usage inside a Page[/HEADING]  

```B4X
Sub B4XPage_Appear  
    DisableScreenCapture  
End Sub  
  
Sub B4XPage_Disappear  
    EnableScreenCapture  
End Sub
```

  
  
[HEADING=2]⭐ Notes[/HEADING]  

- Works in all B4XPages projects
- Protects screenshots, screen recording, and Recents preview
- Tested on real devices, including Xiaomi HyperOS

Feel free to use or modify this code in your projects.