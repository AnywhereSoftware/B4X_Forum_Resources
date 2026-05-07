###  DrawCircle to SelectedDay in B4XDateTemplate by aeric
### 05/05/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170947/)

My personal view, the rectangle is ugly. 😅  
So I changed it to circle. ;) nice!  
  
[HEADING=2]One line of code![/HEADING]  
  

```B4X
Private Sub DrawBox (c As B4XCanvas, clr As Int, x As Int, y As Int)  
    'Dim r As B4XRect  
    'r.Initialize(x * boxW, y * boxH, x * boxW + boxW,  y * boxH + boxH)  
    'c.DrawRect(r, clr, True, 1dip)  
    c.DrawCircle(x * boxW + 0.5 * boxW, y * boxH + 0.5 * boxH, boxH * 0.5, clr, True, 1dip)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/171396)