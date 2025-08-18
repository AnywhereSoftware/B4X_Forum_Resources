###  Text Along Any Curve by William Lancee
### 02/21/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/138639/)

The example here uses a Bezier curve which is one of a lot of possible curves.  
But the text drawing routine works on any list of points.  
The attached .zip has all the code (140 lines).  
  
![](https://www.b4x.com/android/forum/attachments/125885)  
  

```B4X
Sub Class_Globals  
    Type myPoint (x As Float, y As Float)  
    Type bezierSpec (p0 As myPoint, p1 As myPoint, p2 As myPoint, p3 As myPoint)  
    Private fx As JFX  
    Private Root As B4XView  
    Private xui As XUI  
    Private cv As B4XCanvas  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Dim w As Float = 300dip  
    Dim h As Float = 400dip  
    Dim basePanel As B4XView = xui.CreatePanel("")  
    basePanel.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Black, 10dip)  
    Root.AddView(basePanel, Root.Width / 2 - w /2, Root.Height / 2 - h / 2, w, h)  
    cv.Initialize(basePanel)  
      
    Dim aw As Float = .5  
    Dim ah As Float = -.7  
    Dim p0 As myPoint = setP(0, 0)  
    Dim p1 As myPoint = setP(aw * w, .05 * h)  
    Dim p2 As myPoint = setP(ah * w, .95 * h)  
    Dim p3 As myPoint = setP(w, h)  
    Dim bz As bezierSpec = setSpec(p0, p1, p2, p3)  
      
    Dim points As List = BuildBezierCurve(bz)  
    TextOnCurve("The Time Has Come, the Walrus Said; to Speak of Many Things",    xui.CreateDefaultFont(16), 23dip, points)  
    cv.Invalidate  
      
'EXPLANATION  
    'Bezier curves have two end points and two intermediate control points  
    'To show control points of bezier curve make sure width and height >= 1000 (in example, p2 is not in the panel)  
    'Also see how easy it would be to animate the curve and text by varying the control points in small increments  
    'and redrawing the text  
    Dim cv2 As B4XCanvas  
    cv2.Initialize(Root)  
      
    cv2.DrawCircle(basePanel.Left + p0.x, basePanel.top + p0.y, 5dip, xui.Color_Red, True, 0)  
    cv2.DrawCircle(basePanel.Left + p1.x, basePanel.top + p1.y, 5dip, xui.Color_Red, True, 0)  
    cv2.DrawCircle(basePanel.Left + p2.x, basePanel.top + p2.y, 5dip, xui.Color_Red, True, 0)  
    cv2.DrawCircle(basePanel.Left + p3.x, basePanel.top + p3.y, 5dip, xui.Color_Red, True, 0)  
  
    cv2.DrawText("p0", basePanel.Left + p0.x + 5dip, basePanel.top + p0.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")  
    cv2.DrawText("p1", basePanel.Left + p1.x + 5dip, basePanel.top + p1.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")  
    cv2.DrawText("p2", basePanel.Left + p2.x + 5dip, basePanel.top + p2.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")  
    cv2.DrawText("p3", basePanel.Left + p3.x + 5dip, basePanel.top + p3.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")  
  
    cv2.Invalidate  
End Sub
```