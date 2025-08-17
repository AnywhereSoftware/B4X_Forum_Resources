### See whether (and where) circles intersect by jkhazraji
### 10/17/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163611/)

Using B4XCanvas and DrawCircle, and geometry laws, we can test whether two given circles intersect or not.  
If they intersect the points of intersections are returned.  
[HEADING=2]Circle Equations[/HEADING]  
Assuming two circles with:  
![](https://www.b4x.com/android/forum/attachments/157770)  
The intersection points (if they exist) can be calculated as follows:  
  

1. **Calculate Distance Between Circle Centers**:
![](https://www.b4x.com/android/forum/attachments/157766)2. **Check for Intersection**:

- ![](https://www.b4x.com/android/forum/attachments/157769)

3. **Calculate Intersection Points**:

- Calculate a and h, which determine the position of the intersection points.
- ![](https://www.b4x.com/android/forum/attachments/157767)
- Determine the points P2 as the base point on the line between the centers of the circles:
- ![](https://www.b4x.com/android/forum/attachments/157772)
- Find the offset points to get the intersection points:
- ![](https://www.b4x.com/android/forum/attachments/157773)

Translate this into b4j:  

```B4X
Sub FindIntersectionPoints(x1 As Double, y1 As Double, r1 As Double, x2 As Double, y2 As Double, r2 As Double) As List  
    Dim result As List  
    result.Initialize  
   
    Dim d As Double = Sqrt(Power(x2 - x1, 2) + Power(y2 - y1, 2))  
   
    ' Check if circles intersect  
    If d > r1 + r2 Or d < Abs(r1 - r2) Then  
        Log("No intersection points.")  
        Return result  
    End If  
  
    ' Calculate a and h  
    Dim a As Double = (Power(r1, 2) - Power(r2, 2) + Power(d, 2)) / (2 * d)  
    Dim h As Double = Sqrt(Power(r1, 2) - Power(a, 2))  
   
    ' Calculate the base point on the line between the circles' centers  
    Dim x3 As Double = x1 + a * (x2 - x1) / d  
    Dim y3 As Double = y1 + a * (y2 - y1) / d  
   
    ' Calculate the two intersection points  
    Dim x4_1 As Double = x3 + h * (y2 - y1) / d  
    Dim y4_1 As Double = y3 - h * (x2 - x1) / d  
   
    Dim x4_2 As Double = x3 - h * (y2 - y1) / d  
    Dim y4_2 As Double = y3 + h * (x2 - x1) / d  
   
    ' Add the points to the result list  
    result.Add(CreateMap("x" : x4_1, "y" : y4_1))  
    result.Add(CreateMap("x" : x4_2, "y" : y4_2))  
   
    Return result  
End Sub
```

  
  
You can call this function and then draw the intersection points on the canvas:  
  

```B4X
Sub DrawIntersections  
    Dim x1 As Double = 100, y1 As Double = 100, r1 As Double = 75  
    Dim x2 As Double = 150, y2 As Double = 100, r2 As Double = 75  
    Dim intersections As List = FindIntersectionPoints(x1, y1, r1, x2, y2, r2)  
   
    Dim cvs As B4XCanvas  
    cvs.Initialize(mainForm.rootPane)  
    cvs.DrawCircle(x1, y1, r1, xui.Color_Blue, False, 2dip)  
    cvs.DrawCircle(x2, y2, r2, xui.Color_Red, False, 2dip)  
   
    For Each p As Map In intersections  
        Dim px As Double = p.Get("x")  
        Dim py As Double = p.Get("y")  
        cvs.DrawCircle(px, py, 5dip, xui.Color_Green, True, 1dip)  
    Next  
   
    cvs.Refresh  
End Sub
```