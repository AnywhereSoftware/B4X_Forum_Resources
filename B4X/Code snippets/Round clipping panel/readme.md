###  Round clipping panel by Erel
### 08/06/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/120961/)

![](https://www.b4x.com/android/forum/attachments/98156)  
  
Purpose is to create a panel that clips its child views to a circle or rounded rect.  
  
1. Set the round corners with the visual designer.  
2. Use this code:  

```B4X
Public Sub SetCircleClip (pnl As B4XView)  
#if B4J  
    Dim circle As JavaObject  
    Dim radius As Double = Max(pnl.Width / 2, pnl.Height / 2)  
    Dim cx As Double = pnl.Width / 2  
    Dim cy As Double = pnl.Height / 2  
    circle.InitializeNewInstance("javafx.scene.shape.Circle", Array(cx, cy, radius))  
    Dim jo As JavaObject = pnl  
    jo.RunMethod("setClip", Array(circle))  
#else if B4A  
    Dim jo As JavaObject = pnl  
    jo.RunMethod("setClipToOutline", Array(True))  
#end if  
End Sub
```

  
  
Tips:  
1. The code doesn't do anything in B4i as panels clip the child views, based on their shape, by default.  
2. In B4A the shape is based on the set background (as in B4i). We only need to call setClipToOuline. **Note that it is available in Android 5+ (minSdkVersion=21).**  
3. In B4J the shape is created programmatically. You will need to do some work if you want to make it a rounded rect.