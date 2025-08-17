### Bouncing a single ray inside an equilateral triangle (100 simultaneous rays in Post #2) by Johan Schoeman
### 03/02/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159627/)

A bit more tricky than what I thought but then my math is a bit rusted. First challenge is to figure out if the moving point has breached the perimeter of the triangle (from inside to outside) and then correct for it and then bounce/reflect it correctly.  
  
For the attached project the start angle is 135 degrees from the centre point of the triangle. It is moving 1 vector length at a time.  
  

```B4X
    Dim startAngle As Double = 135
```

  
  
Making use of Barycentric coordinates to determine if the moving point is inside or outside the triangle.  
  
First 10 bounces  
  
![](https://www.b4x.com/android/forum/attachments/151366)  
  
Many bounces later.  
![](https://www.b4x.com/android/forum/attachments/151367)  
  
Change the "Sleep" at the end of "Sub draw" to Sleep(0) to speed up the drawing.  

```B4X
Sleep (0)
```

  
  
The code can in all probability be massively improved but this is what my small brain came up with for now.