### detecting screen orientation - current vs. new by Dave O
### 05/05/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130450/)

When my app's activity paused, I needed to find out if it was just a orientation change (as opposed to exiting the app or powering off the display).  
  
My traditional code to detect current orientation had been:  
  

```B4X
Sub getCurrentOrientation As Int  
    If Activity.width < Activity.height Then  
        Log("getCurrentOrientation = portrait")  
        Return ORIENTATION_PORTRAIT  
    Else  
        Log("getCurrentOrientation = landscape")  
        Return ORIENTATION_LANDSCAPE  
    End If  
End Sub
```

  
  
…but when I called it from activity\_pause, that just gave me the current (pre-pause) orientation. I wanted to know the "new" orientation (if any).  
  
I found [Pete Simpson's orientation code](https://www.b4x.com/android/forum/threads/catching-screen-rotation-orientation.19061/#content), and noticed that it used GetDeviceLayoutValues instead of activity values. It turns out that GetDeviceLayoutValues reports the "live" values (after the orientation change), so this code can tell me about the new orientation that will be in effect after Pause/Resume:  
  

```B4X
Sub getNewOrientation As Int  
    If GetDeviceLayoutValues.Width < GetDeviceLayoutValues.height Then  
        Log("getNewOrientation = portrait")  
        Return ORIENTATION_PORTRAIT  
    Else  
        Log("getNewOrientation = landscape")  
        Return ORIENTATION_LANDSCAPE  
    End If  
End Sub
```

  
  
Hope this helps!