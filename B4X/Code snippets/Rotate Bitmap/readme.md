###  Rotate Bitmap by LucaMs
### 12/28/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/125957/)

**[SIZE=5]Author: Erel[/SIZE]**  
  

```B4X
Sub RotateBitmap (bmp As B4XBitmap, Degrees As Float) As B4XBitmap  
   Dim cvs As B4XCanvas  
   Dim panel As B4XView = xui.CreatePanel("")  
   panel.SetLayoutAnimated(0, 0, 0, bmp.Width, bmp.Height)  
   cvs.Initialize(panel)  
   cvs.DrawBitmapRotated(bmp, cvs.TargetRect, Degrees)  
   cvs.Invalidate  
   Dim b As B4XBitmap = cvs.CreateBitmap  
   cvs.Release  
   Return b  
End Sub
```