### Prevent the display from turning off by Cadenzo
### 10/31/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/163875/)

This is the B4i solution for [this thread](https://www.b4x.com/android/forum/threads/prevent-the-display-from-turning-off.163874/). In an [OS specific class](https://www.b4x.com/android/forum/threads/using-os-specific-code-in-global-classes-cross-platform.163867/) for B4i you define this method.  

```B4X
Sub KeepScreenAlive(active As Boolean)  
    Main.App.IdleTimerDisabled = active  
End Sub
```