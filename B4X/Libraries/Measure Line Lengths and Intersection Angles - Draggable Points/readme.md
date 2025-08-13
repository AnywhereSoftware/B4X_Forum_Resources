###  Measure Line Lengths and Intersection Angles - Draggable Points by William Lancee
### 10/09/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/163499/)

![](https://www.b4x.com/android/forum/attachments/157587)  
  
This post is partly in response to  
<https://www.b4x.com/android/forum/threads/application-capable-of-measuring-angles-and-distances.163351/>  
  
The attached project is a very short demo (300 lines of B4X code) of drawing sequences of lines and computing lengths and intersecting angles.  
The units in the grid are abstract and can be any real world units.  
  
I call it measure2X, since I learned early in my woodworking hobby to measure twice and cut once.  
The various techniques in the code could be used anywhere you need them.  
  
The code as a whole could also be useful in other situations.  
For example given three sides of any triangle, what are the internal angles?  
Or, given an angle between two line of a given length, how far apart are the bases of the lines?  
  
It could also be the foundation of robotic movements - if line length constraints are applied when dragging points (not done).  
I used crossplatform code, tested in B4J and B4A.  
  
INSTRUCTIONS:  
1. Click anywhere on outer panel to add a point - more than one point will result in a line with its length in units (center of line)  
2. The X and Y of the point will be shown in blue - X is units from left of the grid, and Y is units from bottom of grid  
3. When two or more lines are visible the smallest angle between (in degrees) will be shown in red below the intersection  
4. Drag any point to see the changing numbers  
5. The "X" above the grid clears the trail and starts with an empty grid  
6. Mouse down and up without significant movement removes a point from the trail - confirmation asked - redo not implemented  
  
Note: My desktop screen is fairly large - you may need to change the values below in Main  
#Region Project Attributes  
 #MainFormWidth: 1600  
 #MainFormHeight: 1200  
#End Region