###  [B4XCanvas] Fill a panel with diagonally drawn lines by Alexander Stolte
### 04/05/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/139662/)

![](https://www.b4x.com/android/forum/attachments/127529)  

```B4X
FillWithDiagonallyDrawnLines(xpnl_Main,15dip,20dip,xui.Color_ARGB(255,49, 138, 123))
```

  

```B4X
Private Sub FillWithDiagonallyDrawnLines(Target As B4XView,Thickness As Float,GapBetween As Float,Color As Int)  
    
    Dim Width As Float = Target.Width  
    Dim Height As Float = Target.Height  
    
    Dim xcv As B4XCanvas  
    xcv.Initialize(Target)  
    
    Dim p As Float = -(IIf(Width > Height,Width,Height))-Thickness  
  
    Do While p <= Width  
        
        xcv.DrawLine(p,0 - (Thickness/2),Width + p,Height + (Thickness/2),Color,Thickness)   
        p = p + GapBetween + Thickness  
        
    Loop  
    
    xcv.Invalidate  
    
End Sub
```

  
<https://stackoverflow.com/questions/35750554/fill-a-uiview-with-diagonally-drawn-lines/51875037#51875037>