###  [XUI] Accurate Text Measurement and Drawing by Erel
### 12/12/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/92810/)

(It took me 7 years to get this one right.)  
  
![](https://www.b4x.com/android/forum/attachments/67684)  
  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-09_13.04.52.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-09_13.05.38.png)  
  
XUI v1.60 includes a new method named B4XCanvas.MeasureText. This method accurately measures single line strings.  
It returns a B4XRect object with the width and height of the measured string. The Top field returns the highest point relative to the baseline.  
  
With these values it is possible to accurately vertically center the text with this code (works in all three platforms):  

```B4X
Dim r As B4XRect = cvs1.MeasureText(Text, Fnt)  
Dim BaseLine As Int = CenterY - r.Height / 2 - r.Top  
cvs1.DrawText(Text, CenterX, BaseLine, Fnt, Clr, "CENTER")
```

  
  
Sub that also draws the border and the baseline:  

```B4X
Sub DrawTextWithBorder (cvs1 As B4XCanvas, Text As String, Fnt As B4XFont, Clr As Int, CenterX As Int, CenterY As Int)  
   Dim r As B4XRect = cvs1.MeasureText(Text, Fnt)  
   Dim BaseLine As Double = CenterY - r.Height / 2 - r.Top  
   cvs1.DrawText(Text, CenterX, BaseLine, Fnt, Clr, "CENTER")  
   cvs1.DrawCircle(CenterX, CenterY, 3dip, xui.Color_Blue, True, 0)  
   r.Initialize(CenterX - r.Width / 2, CenterY - r.Height / 2, CenterX + r.Width / 2, CenterY + r.Height / 2)  
   cvs1.DrawLine(r.Left, BaseLine, r.Right, BaseLine, xui.Color_Gray, 1dip)  
   cvs1.DrawRect(r, xui.Color_Gray, False, 2dip)  
End Sub
```

  
  
Note that in B4i there was a small change in the way the offsets are set internally in B4XCanvas.DrawText.  
  
The XUI libraries are internal libraries. iXUI v1.60 and jXUI v1.60 will be included in the next versions of B4i and B4J. B4A XUI 1.60: <https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/#post-587118>