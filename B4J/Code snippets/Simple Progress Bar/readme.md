### Simple Progress Bar by aeric
### 02/10/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138327/)

Long time ago, I created [a very simple progress bar using 2 panels](https://www.b4x.com/android/forum/threads/simple-progress-bar.95324/) for B4A but it seems not working inside CustomListView under B4J.  
I took the code from [AnotherProgressBar (XUI Views)](https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/) and tried to remove the animation.  
Note: I am not sure whether my code is correct or has any performance issue. Use on your own risk.  
  
![](https://www.b4x.com/android/forum/attachments/125310)  
  

```B4X
' Create a static rounded bar  
Sub DrawBar (Pane As B4XView, BackgroundColor As Int, Width As Double, Height As Double, CornerRadius As Int)  
    Try  
        If Width < 1 Or Height < 1 Then Return  
        Dim mIV As B4XView  
        Dim iv As ImageView  
        Dim bc As BitmapCreator  
        iv.Initialize("")  
        mIV = iv  
        Pane.AddView(mIV, 0, 0, Width, Height)  
        bc.Initialize(Width, Height)  
        bc.DrawRectRounded(bc.TargetRect, BackgroundColor, True, 0, CornerRadius)  
        bc.SetBitmapToImageView(bc.Bitmap, mIV)  
    Catch  
        Log(LastException)  
    End Try  
End Sub
```