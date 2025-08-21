### ShapeDrawable - Clipped rounded rectangle and circle shape by Biswajit
### 05/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/117635/)

**ShapeDrawable  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1  

- **ShapeDrawable**
*A drawable that draws shapes. You can draw Arc, Oval, Rectangle, Rounded Rectangle, even a Custom Shape (using Path).  
The content of the view will be clipped **only for rectangle, circle, and rounded rectangle shapes***

- **Functions:**

- **GetAlpha** As Int
*Get or Set the alpha level for this drawable [0..255].*- **GetDrawable** As Object
*Get shape drawable*- **GetShape** As Shape
*Get or Set the shape of this ShapeDrawable*- **Initialize** As ShapeDrawable
*Initializes the object.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SetAlpha** (alpha As Int) As ShapeDrawable
*Get or Set the alpha level for this drawable [0..255].*- **SetColor** (color As Int) As ShapeDrawable
*Set shape color*- **SetShape** (drawable As Shape) As ShapeDrawable
*Get or Set the shape of this ShapeDrawable*- **SetViewBackground** (v As View)
*Set it to view's background*
- **Shape**
*A shape that can be used as a ShapeDrawable or for drawing purpose.*

- **Functions:**

- **canClip** As Boolean
*Returns whether the shape will clip the View.  
 Currently, only a rectangle, circle, or round rect support clipping.*- **CreateArcShape** (startAngle As Float, sweepAngle As Float)
*startAngle: the angle (in degrees) where the arc begins  
 sweepAngle: the sweep angle (in degrees). Anything equal to or greater than 360 results in a complete circle/oval.*- **CreateOvalShape**
*View will be clipped if it is a perfect square*- **CreatePathShape** (path As Path, width As Float, height As Float)
*path: a Path that defines the geometric paths for this shape This value must never be null.  
width: the standard width For the shape.  
 height: the standard height for the shape.*- **CreateRectShape**
- **CreateRoundRectShape** (top\_left\_radius As Int, top\_right\_radius As Int, bottom\_right\_radius As Int, bottom\_left\_radius As Int)
*View will be clipped if it is a perfect rounded rectangle (same corner radius)*- **GetObject** As Object
*Get Shape object (android.graphics.drawable.shapes)*- **Initialize** As Shape
*Initializes the object.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
Though the functions are self-explanatory, here is a simple usage example:  

```B4X
Dim s As Shape  
s.Initialize.CreateOvalShape  
  
Dim sd As ShapeDrawable  
sd.Initialize.SetShape(s).SetAlpha(100).SetColor(Colors.Blue).SetViewBackground(p)
```