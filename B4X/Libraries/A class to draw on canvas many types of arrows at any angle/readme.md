###  A class to draw on canvas many types of arrows at any angle. by William Lancee
### 08/25/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/142539/)

Once again I found myself writing code to draw arrows on canvas.  
[USER=904]@klaus[/USER] has provided a basic technique that I also use: define the set of points on the arrow as a path and then draw the path.  
<https://www.b4x.com/android/forum/threads/draw-broken-line-arrow-head.43450/post-264259>  
  
I finally decided to write a more general class to do this job. It is a cross-platform design.  
It is small, about 120 lines of code. It's compactness is achieved by the use of a point object type.  
Points have x and y coordinates and a set of public utility functions (Add, Subtract, Distance, Midpoint, etc.)  
  
Arrows can be drawn by three methods.  
-draw. Specified by the two points, start and end  
-draw2. The most general specification: a portion of a vector  
-draw3. Specified as a start point plus length and angle  
  
The style of the arrow is specified through a Map object, keys: Color, Filled, Tip width, and Tip height  
There are 4 optional parameters: DashColor, Inside Text, Font, and FontColor  
(if omitted: undashed, no text, default font(18), black)  
  
Please use the class in any way you like and modify it to meet your needs.  
Let me know if I missed an edge case.  
  
Note: if you need the arrow as an image, you can get the bitmap from the canvas.  
  
![](https://www.b4x.com/android/forum/attachments/132973)