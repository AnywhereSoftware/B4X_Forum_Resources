### [BANano] How to detect if your device browser is in Dark / Light Theme Mode by Mashiane
### 03/01/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159609/)

Hi Fam  
  
I want to detect if my device browser is in dark/ light mode and apply some settings on my app.  
  
So here we go, we have 2 methods, one to fire each time the web browser mode is changed, and another to return the mode.  
  
1. Detect Dark / Light Theme changes.  

```B4X
Dim cbTheme As Object = Banano.CallBack(mCallBack, "DarkTheme", Null)  
        Dim matchMedia As BANanoObject = Banano.Window.RunMethod("matchMedia", "(prefers-color-scheme: dark)")  
        matchMedia.AddEventListener("change", cbTheme, True)        'ignore
```

  
  
So this calls the DarkTheme callback each time the website dark theme is toggled.  
  
2. Return true if dark mode is true.  
  

```B4X
'return if the browser is in dark mode  
Sub IsDarkMode As Boolean  
    Dim matchMedia As BANanoObject = Banano.Window.RunMethod("matchMedia", "(prefers-color-scheme: dark)")  
    Dim res As Boolean = matchMedia.GetField("matches").result  
    Return res  
End Sub
```

  
  
Enjoy!