### Reflection of a single ray inside a circle by Johan Schoeman
### 02/10/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/159170/)

The circle - 0 degrees is measured from the positive x-axis  
In the attached sample project the first point (pih\_0) is at 324.2 degrees. The second point (phi\_1) is at 144.7 degrees  
We draw a line from point 1 to point 2 and then reflect the "ray" from there indefinitely using different "HSB" colors (approach angle to the circle boundary = depart angle from the circle boundary relative to the tangent of phi\_1)  
  
Once running, change phi\_0 and phi\_1 with the B4XPlusMinus custom views (click on arrow left/right to change the values of phi\_0 and phi\_1)  
Change the radius with the slider  
  
Drawing is real time.  
  
If phi\_0 and phi\_1 are 180 degrees apart it will only draw a single line (obviously)  
if phi\_0 and phi\_1 are the same then it will draw "nothing"  
  
It uses the JavaObject library to handle the HSB colors. Every bounce/reflection from the border of the circle changes the color of the ray.  
  
![](https://www.b4x.com/android/forum/attachments/150648)  
  
![](https://www.b4x.com/android/forum/attachments/150647)  
  
![](https://www.b4x.com/android/forum/attachments/150649)  
  
![](https://www.b4x.com/android/forum/attachments/150650)  
  
![](https://www.b4x.com/android/forum/attachments/150651)  
  
![](https://www.b4x.com/android/forum/attachments/150652)  
  
![](https://www.b4x.com/android/forum/attachments/150658)  
  
  
Enjoy!