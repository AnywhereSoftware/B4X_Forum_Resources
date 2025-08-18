###  Change the view's alpha level - transparency by Erel
### 03/24/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/123209/)

```B4X
'Level between 0 (transparent) to 1 (opaque)  
Public Sub SetAlpha (View As B4XView, Level As Float)  
    #if B4A  
    Dim jo As JavaObject = View  
    Dim alpha As Float = Level  
    jo.RunMethod("setAlpha", Array(alpha))  
    #Else If B4J  
    Dim n As Node = View  
    n.Alpha = Level  
    #else if B4i  
    Dim v As View = View  
    v.Alpha = Level  
    #End If  
End Sub
```

  
  
This method is included in XUI Views (XUIViewsUtils.SetAlpha).