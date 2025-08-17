### jCanvasExt  Extends Canvas methods by klaus
### 08/27/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/86407/)

This library, with the Class source code, extends the Canvas functionalities.  
Some time ago I was playing with B4J Canvas with methods not exposed directly to B4J.  
There was a question in the forum for a routine to draw rectangles with round corners.  
So, I think it may be useful for others.  
  
![](https://www.b4x.com/android/forum/attachments/61967) ![](https://www.b4x.com/android/forum/attachments/145244)  
Screenshot of the demo program. Screenshot of the Transform demo program in the ClassDemoTransform.zip file  
  
EDIT: 2023.08.27  
Removed unused parameters in fillPolygon: Color As Paint, Filled As Boolean, LineWidth As Double  
Added Transform, Translate, Rotate, Scale, SetTransform, SetPixelColor, GetPixelColor, Clip, Save, Restore  
Added GetTransformationMatrix, InitTransformationMatrix, GetTransformationMatrixTx, GetTransformationMatrixTy  
  
**jCanvasExt  
  
Author:** Klaus CHRISTL (klaus)  
**Version:** 1.1  

- **CanvasExt**

- **Functions:**

- **appendSVGPath** (SVGPath As String) As String
*Appends a SVGPath string to the current path  
 M = moveTo  
 L = lineTo  
 H = horizontal lineTo  
 V = vertical lineTo  
 C = curveto  
 S = smooth curveto  
 Q = quadratic Bézier curve  
 T = smooth quadratic Bézier curveto  
 A = elliptical arc  
 Z = closePath  
 All of the commands above can also be expressed with lower letters.  
 Capital letters means absolutely positioned, lower cases means relatively positioned.  
 For more details look here:  
<https://www.w3schools.com/graphics/svg_path.asp>*- **arc** (CenterX As Double, CenterY As Double, RadiusX As Double, RadiusY As Double, StartAngle As Double, Lenght As Double) As String
*Adds an arc to the arc end point in the current path  
 CenterX, CenterY coordinates of the center  
 RadiusX and RadiusY X and Y radius  
 StartAngle  
 Length length of the arc  
 Adds path elements to the current path to make an arc that uses Euclidean degrees.  
 This Euclidean orientation sweeps from East to North, then West, then South, then back to East.  
 The coordinates are transformed by the current transform as they are added to the path.*- **arcTo** (x1 As Double, y1 As Double, x2 As Double, y2 As Double, Radius As Double) As String
*Adds an arc to the next point (x2, y2) in the current path  
 x1, y1 coordinates of point 1  
 x2, y2 coordinates of point 2  
 Radius  
 For details look here:  
<https://docs.oracle.com/javase/8/javafx/api/javafx/scene/canvas/GraphicsContext.html#arc-double-double-double-double-double-double->*- **beginPath** As String
*Begins a new current path*- **bezierCurveTo** (xc1 As Double, yc1 As Double, xc2 As Double, yc2 As Double, x1 As Double, y1 As Double) As String
*Adds a cubic Bezier curve to the next point (x1, y1) in the current path  
 xc1, yc1 coordinates of first Bezier control point  
 xc2, yc2 coordinates of second Bezier control point  
 x1, y1 coordinates of the end point*- **Class\_Globals** As String
- **Clip**
*Intersects the current clip with the current path and applies it to subsequent rendering operation as an anti-aliased mask.*- **closePath** As String
*Closes the path*- **DrawArc** (x As Double, y As Double, Width As Double, Height As Double, StartAngle As Double, AngleExtend As Double, ArcType As String, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws an eliptic Arc  
 x = left coordinate of the surrounding rectangle  
 Y = top coordinate of the surrounding rectangle  
 Width = width coordinate of the surrounding rectangle  
 Height = height coordinate of the surrounding rectangle  
 StartingAngle = starting angle in degrees, 0 = horizontal right  
 AngleExtend = angle extend in degrees positve counter clockwise  
 ArcType possible values CHORD, OPEN or ROUND  
 CHORD joins the begin and end points  
 ROUND joins the begin and end points to the center point  
 OPEN the arc is open, when Filled = True is equivalent to CHORD  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawArc2** (CenterX As Double, CenterY As Double, Radius As Double, StartAngle As Double, AngleExtend As Double, ArcType As String, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a circular Arc  
 CenterX = center X coordinate  
 CenterY = center X coordinate  
 Radius = radius of the arc  
 StartingAngle = starting angle in degrees, 0 = horizontal right  
 AngleExtend = angle extend in degrees positve counter clockwise  
 ArcType possible values CHORD, OPEN or ROUND  
 CHORD joins the begin and end points  
 ROUND joins the begin and end points to the center point  
 OPEN the arc is open, when Filled = True is ie equivalent to CHORD  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawDashedLine** (x1 As Double, y1 As Double, x2 As Double, y2 As Double, Color As Paint, LineWidth As Double, LineDashes As Double(), LineDashOffset As Double) As String
*Draws a dashed line  
 x = left coordinate of the surrounding rectangle  
 Y = top coordinate of the surrounding rectangle  
 Width = width coordinate of the surrounding rectangle  
 Height = height coordinate of the surrounding rectangle  
 Radius = corner radius  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True  
 Example:  
 Private Dashes(4) As Double  
 Dashes = Array As Double(15, 5, 35, 10)*- **DrawOval** (x As Double, y As Double, Width As Double, Height As Double, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws an Oval  
 x = left coordinate of the surrounding rectangle  
 Y = top coordinate of the surrounding rectangle  
 Width = width coordinate of the surrounding rectangle  
 Height = height coordinate of the surrounding rectangle  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawPolygon** (x As Double(), y As Double(), NumberPoints As Int, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a polygon  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points it can be smaller than the x and y array lenths  
 The polygon is automatically closed, no need to set the last point equal to the firrst one  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawPolyline** (x As Double(), y As Double(), NumberPoints As Int, Color As Paint, LineWidth As Double) As String
*Draws a polyline  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points it can be smaller than the x and y arrays  
 Color = fx.Colors.Color  
 Stroke = line width, has no effect when Filled = True*- **DrawPolyline2** (x As Double(), y As Double(), NumberPoints As Int, Color As Paint, LineWidth As Double, strokeLineCap As String, strokeLineJoin As String) As String
*Draws a polyline with LineCap and LineJoin  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points it can be smaller than the x and y arrays  
 Color = fx.Colors.Color  
 LineWidth = line width, has no effect when Filled = True  
 strokeLineCap = line extremities shape, possible values: BUTT, ROUND, or SQUARE  
 strokeLineJoin = line join shapes, possible values: MITER, BEVEL or ROUND*- **DrawRect** (x As Double, y As Double, Width As Double, Height As Double, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a Rectangle  
 x = left coordinate of the surrounding rectangle  
 Y = top coordinate of the surrounding rectangle  
 Width = width coordinate of the surrounding rectangle  
 Height = height coordinate of the surrounding rectangle  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawRect2** (x1 As Double, y1 As Double, x2 As Double, y2 As Double, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a Rectangle  
 x1 = left coordinate of the rectangle  
 Y1 = top coordinate of the rectangle  
 x2 = right coordinate of the rectangle  
 y2 = bottom coordinate of the rectangle  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawRectRounded** (x As Double, y As Double, Width As Double, Height As Double, ArcWidth As Double, ArcHeight As Double, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a rouded Rectangle  
 x = left coordinate of the surrounding rectangle  
 Y = top coordinate of the surrounding rectangle  
 Width = width coordinate of the surrounding rectangle  
 Height = height coordinate of the surrounding rectangle  
 ArcWidth = corner arc width for a radius set both Arc values the same  
 ArcHeight = corner arc height  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawRectRounded2** (x1 As Double, y1 As Double, x2 As Double, y2 As Double, ArcWidth As Double, ArcHeight As Double, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Draws a rouded Rectangle  
 x1 = left coordinate of the rectangle  
 Y1 = top coordinate of the rectangle  
 x2 = right coordinate of the rectangle  
 y2 = bottom coordinate of the rectangle  
 ArcWidth = corner arc width for a radius set both Arc values the same  
 ArcHeight = corner arc height  
 Color = fx.Colors.Color  
 Filled True Filled, False only the line  
 Stroke = line width, has no effect when Filled = True*- **DrawText3** (Text As String, x As Double, y As Double, Font As Font, Color As Paint, HorizontalAlignment As String, VerticalAlignment As String, Filled As Boolean) As String
*Draws a text  
 Text = text to draw  
 x = x coordinate of the reference point  
 y = y coordinate of the reference point  
 Font = text font name  
 Color = fx.Colors.Color  
 HorizontalAlignment possible values: LEFT, CENTER, RIGHT  
 VerticalAlignment possible values: TOP, CENTER, BASELINE, or BOTTOM  
 Filled True for standard text False for empty text.*- **fill** As String
*Fills the current path (fills the area)*- **fillPolygon** (x As Double(), y As Double(), NumberPoints As Int, Color As Paint, Filled As Boolean, LineWidth As Double) As String
*Fills a polygon with the current fill properties  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points it can be smaller than the x and y array lenths*- **GetPaint** (Color As String) As Paint
*Returns the paint object according to the color string*- **GetPixelColor** *(x* As Int, y As Int)
*Gets the color of the pixel at the x and y coordinates****.***
*Uses PixelReader.*- **GetTransformationMatrix**
*Returns the 2D Transform matrix in a 2 x 3 Doube Array  
 Mxx Mxy Tx  
 Myx Myy Ty*- **GetTransformationMatrixTx**
*Returns Tx, the x Transfer value from the 2D Transform matrix.*- **GetTransformationMatrixTy**
*Returns Ty, the x Transfer value from the 2D Transform matrix.*- **Initialize** (Canvas As Canvas) As String
*Initializes the object.*- **InitTransformationMatrix**
*Initializes the Transform matrix to  
 1 0 0  
 0 1 0*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isPointInPath** (x As Double, y As Double) As Boolean
*Returns true if the given point is insides the current path*- **lineTo** (x As Double, y As Double) As String
*Adds a line to the next point (x, y) in the current path*- **moveTo** (x As Double, y As Double) As String
*Moves to the next point (x, y) in the current path*- **quadraticCurveTo** (xc As Double, yc As Double, x1 As Double, y1 As Double) As String
*Adds a quadratic curve to the next point (x1, y1) in the current path  
 Adds segments to the current path to make a quadratic Bezier curve.  
 xc, yc coordinates of the control point  
 x1, y1 coordinates of the end point*- **Restore**
*Pops the state off of the stack, setting the following attributes to their value at the time when that state was pushed onto the stack.*- **Rotate** (Angle As Double)
*Rotates the future drawings by Angle.  
 cos(Angle) -sin(Angle) 0  
 sin(Angle) cos(Angle) 0*- **Save**
*Saves the following attributes onto a stack.*- **Scale** (x As Double, y As Double)
*Scales the current transform matrix by x, y.  
 This is cumulative, the current scale is multiplied be this one.*- **SetFill** (Color As Paint) As String
*Sets the filled color*- **SetLineCap** (LineCap As String) As String
*Sets the line Cap  
 possible values are SQUARE, BUTT, ROUND*- **SetLineDashes** (LineDashes As Double()) As String
*Sets the line dashes  
 LineDashes() array of doubles of finite non-negative dash lengths  
 Example:<code>  
 Private Dashes(4) As Double  
 Dashes = Array As Double(15, 5, 35, 10)  
 cvsTestExt.DrawDashedLine(0, 10, cvsTest.Width, 10, fx.Colors.Red, 2, Dashes, 0)  
 </code>*- **SetLineDashOffset** (LineDashOffset As Double) As String
*Sets the line dash offset*- **SetLineJoin** (LineJoin As String) As String
*Sets the line Join  
 possible values are MITER, BEVEL, ROUND*- **SetLineWidth** (LineWidth As Double) As String
*Sets the line width*- **SetMiterLimit** (MiterLimit As Double) As String
*Sets the miter Limit  
 possible values are MITER, BEVEL, ROUND*- **SetPixelColor** (x As Double, y As Double, Color As PaintWrapper)
*Sets the color of the pixel at the x and y coordinates.  
 Uses PixelWriter.*- **SetScaleX** (scaleX As Double)
*Scales the x axis of the entire Canvas.*- **SetScaleY** (scaleY As Double)
*Scales the y axis of the entire Canvas.*- **SetStroke** (Color As Paint) As String
*Sets the stroke (line) color*- **SetTransform** (mxx As Double, myx As Double, mxy As Double, myy As Double, mxt As Double, myt As Double)
*Sets the Transform matrix.  
 be aware that the values are column by column  
 mxx mxy mxt  
 myx myy myt*- **SetTranslateX** (x As Double) As String
*Moves the Canvas horizontally by x pixels*- **SetTranslateY** (y As Double) As String
*Moves the Canvas vertically by y pixels*- **stroke** As String
*Strokes (draws) the current path*- **strokeLine** (x1 As Double, y1 As Double, x2 As Double, y2 As Double) As String
*Strokes (draws) a line with the current stroke properties*- **strokePolygon** (x As Double(), y As Double(), NumberPoints As Int) As String
*Strokes (draws) a polygon with the current stroke properties  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points it can be smaller than the x and y array lenths*- **strokePolyline** (x As Double(), y As Double(), NumberPoints As Int) As String
*Strokes (draws) a polyline with the current stroke properties  
 x() a one dimension array of the x coordinates  
 y() a one dimension array of the y coordinates  
 NumberPoints = number of points, it can be smaller than the x and y array lenths*- **Transform** (mxx As Double, myx As Double, mxy As Double, myy As Double, mxt As Double, myt As Double)
Concatenates the input to the current Transform matrix
be aware that the values are column by column
mxx mxy mxt
myx myy myt- **Translate** (x As Double, y As Double)
*Translates the future drawings by x and y  
 1 0 x  
 0 1 y*