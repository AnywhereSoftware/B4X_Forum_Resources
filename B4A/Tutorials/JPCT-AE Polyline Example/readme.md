### JPCT-AE Polyline Example by sn_nn
### 05/26/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/131070/)

Polyline in JPCT-AE is unable for using by standart methods. But, by Ricardossy1, in his post: [Ricardossy1 post](https://www.b4x.com/android/forum/goto/post?id=818068), was described way for solving problem.  
I was needed for Polylines in my project and jpst-ae wrapper and xml-file was edited in Eclipse from alhowiriny's sources.  
Was added some next methods to Polyline Class of wrapper:  

1. **Essai** - creating array of JSimpleVector
2. **setTransparencyMode** - by default=0 (invisible)
3. **setWidth** - change Width of line
4. **setColor** - change Color of Polyline
5. **setParent** - for linking Polyline to some Object3D in World

example of code:  
**Sub Clobals**  

```B4X
Dim Pl_Line As JpctPolyline  
Dim Pl_obj() As Object  
Dim Pl_point(3) As JpctSimpleVector
```

  
  
**Sub JPCT\_SurfaceChanged**   

```B4X
Dim i As Int  
Dim LineColor As JpctRGBColor  
    LineColor.Initialize2(50,100,250)  
  
Pl_obj=Pl_Line.essai(Pl_point.Length) 'Create Array of JSimpleVector  
  
'Filling array of Vectors (Points)  
   Pl_point(0).Initialize2(0,125,0)  
Pl_obj(0)=Pl_point(0)  
  
   Pl_point(1).Initialize2(0,0,0)  
Pl_obj(1)=Pl_point(1)  
  
   Pl_point(2).Initialize2(125,0,0)  
Pl_obj(2)=Pl_point(2)  
  
Pl_Line.Initialize(Pl_obj,LineColor) 'Initializing Polyline  
Pl_Line.setColor(LineColor)          'SetColor for Polylines  
Pl_Line.setPercentage(1)             'Show 100% of Polylines Long  
Pl_Line.setVisible(True)             'Set Polyline visible'  
Pl_Line.setWidth(3)                  'Set Width of polyline=3  
  
  
Pl_Line.setTransparencyMode(-1)      'Not Transparent Polyline  
World.addPolyline(Pl_Line)           'Add Polyline to World  
Pl_Line.setParent(curBody)           'Link Polyline to some Object3D  
  
'Logs for controlling Points-Data in Polyline  
Log(Pl_Line.Length)  
For i=0 To 2  
Log(i)  
Log("x=" & Pl_point(i).x)  
Log("y=" & Pl_point(i).y)  
Log("z=" & Pl_point(i).z)  
Log("obj(" & i & ")=" & Pl_obj(i))  
Next 'i
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/113990) ![](https://www.b4x.com/android/forum/attachments/113991)  
  
Polyline will be enable only with last version of JPCT-AE library! (23/03/2021)