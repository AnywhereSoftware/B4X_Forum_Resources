### [B4XPages] Lock screen orientation based on how device is held when App is started. by William Lancee
### 10/02/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/134764/)

I have an App that can handle both orientations, so I wanted the user's preference to be reflected in how the App was oriented.  
I searched the Forum, but I couldn't find what I needed.  
  
In "Main" Activity prior to initializing page manager do this.  

```B4X
    'set…     #SupportedOrientations: unspecified  
  
Sub Activity_Create(FirstTime As Boolean)  
    'set…     #SupportedOrientations: unspecified  
    Dim ph As Phone  
    If Activity.width < Activity.Height Then ph.SetScreenOrientation(7) Else ph.SetScreenOrientation(6)  
  
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
End Sub
```