### Prevent the display from turning off by Cadenzo
### 10/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163874/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects.  
  
Sometimes you don't want the display to turn off, even if there is no user action for a while. Handling this is possible for Android and iOS, but in different ways. That's why the [OS specific class](https://www.b4x.com/android/forum/threads/using-os-specific-code-in-global-classes-cross-platform.163867/) is the best place for this method. See B4i solution [here](https://www.b4x.com/android/forum/threads/prevent-the-display-from-turning-off.163875/).  
  

```B4X
Sub Class_Globals  
    Private wkup As PhoneWakeState 'Phone' Lib  
End Sub  
  
Sub KeepScreenAlive(active As Boolean)  
    If active Then  
        wkup.KeepAlive(True)  
    Else  
        wkup.ReleaseKeepAlive  
    End If  
End Sub
```

  
  

```B4X
Sub B4XPage_Appear  
    Main.cG.OSSpec.KeepScreenAlive(True)  
End Sub  
  
Sub B4XPage_Disappear  
    Main.cG.OSSpec.KeepScreenAlive(False)  
End Sub
```