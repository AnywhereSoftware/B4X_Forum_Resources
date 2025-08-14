### Starter service and the missing foreground service type crash by Erel
### 07/30/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167999/)

I recommend adding these two snippets to avoid crashes that happen when the app is somehow started while the screen is turned off:  
  
Add to manifest editor:  

```B4X
SetServiceAttribute(Starter, android:foregroundServiceType, shortService)
```

  
  
Add to starter service:  

```B4X
Private Sub Service_Timeout(Params As Map)  
    Service.StopForeground(51042) 'this is the id of the automatic foreground notification  
End Sub
```

  
  
It will probably be added to the templates in the future.