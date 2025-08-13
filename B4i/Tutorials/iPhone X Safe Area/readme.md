### iPhone X Safe Area by Erel
### 02/15/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/88095/)

![](https://www.b4x.com/basic4android/images/SS-2018-01-09_10.41.31.png)  
  
As you can see in the above image, the screen area near the top and bottom are considered unsafe. Meaning that you shouldn't put anything important on these areas as they are less accessible or partially hidden.  
  
You can use the new Page.SafeAreaInsets property to find the four required offsets and adjust the content layout.  
  
Page.SafeAreaInsets returns a Rect object. Don't treat it as a rectangle. Treat it as a set of four offsets:  

```B4X
Sub Page1_Resize (Width As Float, Height As Float)  
   Dim r As Rect = Page1.SafeAreaInsets  
   pnlRoot.SetLayoutAnimated(0, 1, r.Left, r.Top, Width - r.Right - r.Left, Height - r.Bottom - r.Top)  
End Sub
```

  
  
The four values will be 0 for devices other than iPhone X.  
  
A simple way to handle it is with a "main" layout that includes a panel named pnlRoot. This panel will be resized with this code.  
The actual content layout is loaded to this panel.  
  
The result is:  
![](https://www.b4x.com/basic4android/images/SS-2018-01-09_10.51.06.png)  
  
The pink background is set in the main layout.  
  
As the offsets returned are 0 for other devices, the panel will cover the whole available area.