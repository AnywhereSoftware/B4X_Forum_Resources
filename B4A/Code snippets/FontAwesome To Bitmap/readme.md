### FontAwesome To Bitmap by Erel
### 06/02/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/95155/)

Unlike an older "TextToBitmap" sub that you can find in the forum, this code vertically centers the icon.  
It can also be used in B4J and B4i (only need to change the font line).  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
  'usage example  
   Activity.AddMenuItem3("Android", "Test", FontAwesomeToBitmap(Chr(0xF17B), 28), True)  
   Activity.AddMenuItem3("Eye", "Test", FontAwesomeToBitmap(Chr(0xF06E), 28), True)  
End Sub  
  
Sub FontAwesomeToBitmap (Text As String, FontSize As Float) As B4XBitmap  
   Dim xui As XUI  
   Dim p As Panel = xui.CreatePanel("")  
   p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)  
   Dim cvs1 As B4XCanvas  
   cvs1.Initialize(p)  
   Dim fnt As B4XFont = xui.CreateFontAwesome(FontSize)  
   Dim r As B4XRect = cvs1.MeasureText(Text, fnt)  
   Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top  
   cvs1.DrawText(Text, cvs1.TargetRect.CenterX, BaseLine, fnt, xui.Color_White, "CENTER")  
   Dim b As B4XBitmap = cvs1.CreateBitmap  
   cvs1.Release  
   Return b  
End Sub
```

  
Depends on: XUI  
  
![](https://www.b4x.com/basic4android/images/SS-2018-07-16_15.00.12.png)