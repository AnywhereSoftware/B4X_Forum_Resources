B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class module CanvasExt
'Version: 1.1
'Removed unused parameters in fillPolygon: Color As Paint, Filled As Boolean, LineWidth As Double
'Added Transform, Translate, Rotate, Scale, SetTransform, SetPixelColor, GetPixelColor, Clip, Save, Restore
'Added GetTransformationMatrix, InitTransformationMatrix, GetTransformationMatrixTx, GetTransformationMatrixTy
'
'Version: 1.0
'Author: Klaus CHRISTL (klaus)
'Documentation: https://docs.oracle.com/javase/8/javafx/api/javafx/scene/canvas/GraphicsContext.html

Sub Class_Globals
	Private fx As JFX
	Private joCanvas, joGraph, joPixelWriter As JavaObject
	Private mCanvas As Canvas
End Sub

'Initializes the object.
Public Sub Initialize(Canvas As Canvas)
	mCanvas = Canvas
	joCanvas = Canvas
	joGraph = joCanvas.RunMethod("getGraphicsContext2D", Null)
	joPixelWriter = joGraph.RunMethod("getPixelWriter", Null)
End Sub

' Combined functions

'Draws a dashed line
'x = left coordinate of the surrounding rectangle
'Y = top coordinate of the surrounding rectangle
'Width = width coordinate of the surrounding rectangle
'Height = height coordinate of the surrounding rectangle
'Radius = corner radius
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
'Example:
'Private Dashes(4)	As Double
'Dashes = Array As Double(15, 5, 35, 10)
Public Sub DrawDashedLine(x1 As Double, y1 As Double, x2 As Double, y2 As Double, Color As Paint, LineWidth As Double, LineDashes() As Double, LineDashOffset As Double)
	joGraph.RunMethod("setLineDashes", Array As Object(LineDashes))		
	joGraph.RunMethod("setLineDashOffset", Array As Object(LineDashOffset))		
	joGraph.RunMethod("setStroke", Array As Object(Color))	
	joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
	joGraph.RunMethod("strokeLine", Array As Object(x1, y1, x2, y2))
	Private NoDash(1) As Double
	NoDash(0) = 0
	joGraph.RunMethod("setLineDashes", Array As Object(NoDash))		
End Sub

'Draws a Rectangle
'x = left coordinate of the surrounding rectangle
'Y = top coordinate of the surrounding rectangle
'Width = width coordinate of the surrounding rectangle
'Height = height coordinate of the surrounding rectangle
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawRect(x As Double, y As Double, Width As Double, Height As Double, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeRect", Array As Object(x, y, Width, Height))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillRect", Array As Object(x, y, Width, Height))
	End If
End Sub

'Draws a Rectangle
'x1 = left coordinate of the rectangle
'Y1 = top coordinate of the rectangle
'x2 = right coordinate of the rectangle
'y2 = bottom coordinate of the rectangle
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawRect2(x1 As Double, y1 As Double, x2 As Double, y2 As Double, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeRect", Array As Object(x1, y1, x2 - x1, y2 - y1))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillRect", Array As Object(x1, y1, x2 - x1, y2 - y1))
	End If
End Sub

'Draws a rouded Rectangle
'x = left coordinate of the surrounding rectangle
'Y = top coordinate of the surrounding rectangle
'Width = width coordinate of the surrounding rectangle
'Height = height coordinate of the surrounding rectangle
'ArcWidth = corner arc width  for a radius set both Arc values the same
'ArcHeight = corner arc height
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawRectRounded(x As Double, y As Double, Width As Double, Height As Double, ArcWidth As Double, ArcHeight As Double, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeRoundRect", Array As Object(x, y, Width, Height, ArcWidth, ArcHeight))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillRoundRect", Array As Object(x, y, Width, Height, ArcWidth, ArcHeight))
	End If
End Sub

'Draws a rouded Rectangle
'x1 = left coordinate of the rectangle
'Y1 = top coordinate of the rectangle
'x2 = right coordinate of the rectangle
'y2 = bottom coordinate of the rectangle
'ArcWidth = corner arc width		for a radius set both Arc values the same
'ArcHeight = corner arc height
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawRectRounded2(x1 As Double, y1 As Double, x2 As Double, y2 As Double, ArcWidth As Double, ArcHeight As Double, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeRoundRect", Array As Object(x1, y1, x2 - x1, y2 - y1, ArcWidth, ArcHeight))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillRoundRect", Array As Object(x1, y1, x2 - x1, y2 - y1, ArcWidth, ArcHeight))
	End If
End Sub	

'Draws an Oval
'x = left coordinate of the surrounding rectangle
'Y = top coordinate of the surrounding rectangle
'Width = width coordinate of the surrounding rectangle
'Height = height coordinate of the surrounding rectangle
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawOval(x As Double, y As Double, Width As Double, Height As Double, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeOval", Array As Object(x, y, Width, Height))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillOval", Array As Object(x, y, Width, Height))
	End If
End Sub

'Draws an eliptic Arc
'x = left coordinate of the surrounding rectangle
'Y = top coordinate of the surrounding rectangle
'Width = width coordinate of the surrounding rectangle
'Height = height coordinate of the surrounding rectangle
'StartingAngle = starting angle in degrees, 0 = horizontal right
'AngleExtend = angle extend in degrees positve counter clockwise
'ArcType  possible values CHORD, OPEN or ROUND
'  CHORD joins the begin and end points
'  ROUND joins the begin and end points to the center point
'  OPEN  the arc is open, when Filled = True is equivalent to CHORD
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawArc(x As Double, y As Double, Width As Double, Height As Double, StartAngle As Double, AngleExtend As Double, ArcType As String, Color As Paint, Filled As Boolean, LineWidth As Double)
	ArcType = ArcType.ToUpperCase
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeArc", Array As Object(x, y, Width, Height, StartAngle, AngleExtend, ArcType))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillArc", Array As Object(x, y, Width, Height, StartAngle, AngleExtend, ArcType))
	End If
End Sub

'Draws a circular Arc
'CenterX = center X coordinate
'CenterY = center X coordinate
'Radius = radius of the arc
'StartingAngle = starting angle in degrees, 0 = horizontal right
'AngleExtend = angle extend in degrees positve counter clockwise
'ArcType  possible values CHORD, OPEN or ROUND
'  CHORD joins the begin and end points
'  ROUND joins the begin and end points to the center point
'  OPEN  the arc is open, when Filled = True is ie equivalent to CHORD
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawArc2(CenterX As Double, CenterY As Double, Radius As Double, StartAngle As Double, AngleExtend As Double, ArcType As String, Color As Paint, Filled As Boolean, LineWidth As Double)
	Private x, y, Width, Height As Double
	
	x = CenterX - Radius
	y = CenterY - Radius
	Width = 2 * Radius
	Height = 2 * Radius
	ArcType = ArcType.ToUpperCase
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokeArc", Array As Object(x, y, Width, Height, StartAngle, AngleExtend, ArcType))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillArc", Array As Object(x, y, Width, Height, StartAngle, AngleExtend, ArcType))
	End If	
End Sub

'Draws a polygon
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points it can be smaller than the x and y array lenths
'The polygon is automatically closed, no need to set the last point equal to the firrst one
'Color = fx.Colors.Color
'Filled  True Filled, False only the line
'Stroke = line width, has no effect when Filled = True
Public Sub DrawPolygon(x() As Double, y() As Double, NumberPoints As Int, Color As Paint, Filled As Boolean, LineWidth As Double)
	If Filled = False Then
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokePolygon", Array As Object(x, y, NumberPoints))
	Else
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("fillPolygon", Array As Object(x, y, NumberPoints))
	End If
End Sub

'Draws a polyline
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points it can be smaller than the x and y arrays
'Color = fx.Colors.Color
'Stroke = line width, has no effect when Filled = True
Public Sub DrawPolyline(x() As Double, y() As Double, NumberPoints As Int, Color As Paint, LineWidth As Double)
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("strokePolyline", Array As Object(x, y, NumberPoints))
End Sub

'Draws a polyline with LineCap and LineJoin
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points it can be smaller than the x and y arrays
'Color = fx.Colors.Color
'LineWidth = line width, has no effect when Filled = True
'strokeLineCap = line extremities shape, possible values: BUTT, ROUND, or SQUARE
'strokeLineJoin = line join shapes, possible values: MITER, BEVEL or ROUND
Public Sub DrawPolyline2(x() As Double, y() As Double, NumberPoints As Int, Color As Paint, LineWidth As Double, strokeLineCap As String, strokeLineJoin As String)
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))	
		joGraph.RunMethod("setLineCap", Array As Object(strokeLineCap))
		joGraph.RunMethod("setLineJoin", Array As Object(strokeLineJoin))
		joGraph.RunMethod("strokePolyline", Array As Object(x, y, NumberPoints))
End Sub

'Draws a text
'Text = text to draw
'x = x coordinate of the reference point
'y = y coordinate of the reference point
'Font = text font name
'Color =  fx.Colors.Color
'HorizontalAlignment possible values: LEFT, CENTER, RIGHT
'VerticalAlignment	 possible values: TOP, CENTER, BASELINE, or BOTTOM
'Filled 	True for standard text  False for empty text.
Public Sub DrawText3(Text As String, x As Double, y As Double, Font As Font, Color As Paint, HorizontalAlignment As String, VerticalAlignment As String, Filled As Boolean)
	If Filled = False Then
		joGraph.RunMethod("setFont", Array As Object(Font))	
		joGraph.RunMethod("setStroke", Array As Object(Color))	
		joGraph.RunMethod("setTextAlign", Array As Object(HorizontalAlignment))	
		joGraph.RunMethod("setTextBaseline", Array As Object(VerticalAlignment))	
		joGraph.RunMethod("strokeText", Array As Object(Text, x, y))
	Else
		joGraph.RunMethod("setFont", Array As Object(Font))	
		joGraph.RunMethod("setFill", Array As Object(Color))	
		joGraph.RunMethod("setTextAlign", Array As Object(HorizontalAlignment))	
		joGraph.RunMethod("setTextBaseline", Array As Object(VerticalAlignment))	
		joGraph.RunMethod("fillText", Array As Object(Text, x, y))
	End If		
End Sub

'Basic functions

'Strokes (draws) a line with the current stroke properties
Public Sub strokeLine(x1 As Double, y1 As Double, x2 As Double, y2 As Double)
	joGraph.RunMethod("strokeLine", Array As Object(x1, y1, x2, y2))
End Sub	

'Strokes (draws) a polyline with the current stroke properties
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points, it can be smaller than the x and y array lenths
Public Sub strokePolyline(x() As Double, y() As Double, NumberPoints As Int)
	joGraph.RunMethod("strokePolyline", Array As Object(x, y, NumberPoints))
End Sub

'Strokes (draws) a polygon with the current stroke properties
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points it can be smaller than the x and y array lenths
Public Sub strokePolygon(x() As Double, y() As Double, NumberPoints As Int)
	joGraph.RunMethod("strokePolygon", Array As Object(x, y, NumberPoints))
End Sub

'Fills a polygon with the current fill properties
'x() a one dimension array of the x coordinates
'y() a one dimension array of the y coordinates
'NumberPoints = number of points it can be smaller than the x and y array lenths
Public Sub fillPolygon(x() As Double, y() As Double, NumberPoints As Int)
	joGraph.RunMethod("fillPolygon", Array As Object(x, y, NumberPoints))
End Sub

'Begins a new current path
Public Sub beginPath
	joGraph.RunMethod("beginPath", Null)	
End Sub

'Closes the path
Public Sub closePath
	joGraph.RunMethod("closePath", Null)	
End Sub

'Moves to the next point (x, y) in the current path
Public Sub moveTo(x As Double, y As Double)
	joGraph.RunMethod("moveTo", Array As Object(x, y))		
End Sub

'Adds a line to the next point (x, y) in the current path
Public Sub lineTo(x As Double, y As Double)
	joGraph.RunMethod("lineTo", Array As Object(x, y))		
End Sub

'Adds an arc to the arc end point in the current path
'CenterX, CenterY coordinates of the center
'RadiusX and RadiusY X and Y radius
'StartAngle
'Length length of the arc
'Adds path elements to the current path to make an arc that uses Euclidean degrees. 
'This Euclidean orientation sweeps from East to North, then West, then South, then back to East. 
'The coordinates are transformed by the current transform as they are added to the path. 
Public Sub arc(CenterX As Double, CenterY As Double, RadiusX As Double, RadiusY As Double, StartAngle As Double, Lenght As Double)
	joGraph.RunMethod("arc", Array As Object(CenterX, CenterY, RadiusX, RadiusY, StartAngle, Lenght))
End Sub

'Adds an arc to the next point (x2, y2) in the current path
'x1, y1 coordinates of point 1
'x2, y2 coordinates of point 2
'Radius
'For details look here:
'https://docs.oracle.com/javase/8/javafx/api/javafx/scene/canvas/GraphicsContext.html#arc-double-double-double-double-double-double-
Public Sub arcTo(x1 As Double, y1 As Double, x2 As Double, y2 As Double, Radius As Double)
	joGraph.RunMethod("arcTo", Array As Object(x1, y1, x2, y2, Radius))		
End Sub

'Adds a quadratic curve to the next point (x1, y1) in the current path
'Adds segments to the current path to make a quadratic Bezier curve.
'xc, yc coordinates of the control point
'x1, y1 coordinates of the end point
Public Sub quadraticCurveTo(xc As Double, yc As Double, x1 As Double, y1 As Double)
	joGraph.RunMethod("quadraticCurveTo", Array As Object(xc, yc, x1, y1))		
End Sub

'Adds a cubic Bezier curve to the next point (x1, y1) in the current path
'xc1, yc1 coordinates of first Bezier control point
'xc2, yc2 coordinates of second Bezier control point
'x1, y1 coordinates of the end point
Public Sub bezierCurveTo(xc1 As Double, yc1 As Double, xc2 As Double, yc2 As Double, x1 As Double, y1 As Double)
	joGraph.RunMethod("bezierCurveTo", Array As Object(xc1, yc1, xc2, yc2, x1, y1))		
End Sub

'Appends a SVGPath string to the current path
'M = moveTo
'L = lineTo
'H = horizontal lineTo
'V = vertical lineTo
'C = curveto
'S = smooth curveto
'Q = quadratic Bézier curve
'T = smooth quadratic Bézier curveto
'A = elliptical arc
'Z = closePath
'All of the commands above can also be expressed with lower letters. 
'Capital letters means absolutely positioned, lower cases means relatively positioned.
'For more details look here:
'https://www.w3schools.com/graphics/svg_path.asp
Public Sub appendSVGPath(SVGPath As String)
	joGraph.RunMethod("appendSVGPath", Array As Object(SVGPath))			
End Sub

'Strokes (draws) the current path
Public Sub stroke
	joGraph.RunMethod("stroke", Null)	
End Sub

'Fills the current path (fills the area)
Public Sub fill
	joGraph.RunMethod("fill", Null)	
End Sub

'Sets the stroke (line) color
Public Sub SetStroke(Color As Paint)
	joGraph.RunMethod("setStroke", Array As Object(Color))	
End Sub

'Sets the filled color
Public Sub SetFill(Color As Paint)
	joGraph.RunMethod("setFill", Array As Object(Color))	
End Sub

'Sets the line width
Public Sub SetLineWidth(LineWidth As Double)
	joGraph.RunMethod("setLineWidth", Array As Object(LineWidth))		
End Sub

'Sets the line Cap
'possible values are SQUARE, BUTT, ROUND
Public Sub SetLineCap(LineCap As String)
	joGraph.RunMethod("setLineCap", Array As Object(LineCap))		
End Sub

'Sets the line Join
'possible values are MITER, BEVEL, ROUND
Public Sub SetLineJoin(LineJoin As String)
	joGraph.RunMethod("setLineCap", Array As Object(LineJoin))		
End Sub

'Sets the miter Limit
'possible values are MITER, BEVEL, ROUND
Public Sub SetMiterLimit(MiterLimit As Double)
	joGraph.RunMethod("setMiterLimit", Array As Object(MiterLimit))		
End Sub

'Sets the line dashes
'LineDashes() array of doubles of finite non-negative dash lengths
'Example:<code>
'Private Dashes(4)	As Double
'Dashes = Array As Double(15, 5, 35, 10)
'cvsTestExt.DrawDashedLine(0, 10, cvsTest.Width, 10, fx.Colors.Red, 2, Dashes, 0)
'</code>
Public Sub SetLineDashes(LineDashes() As Double)
	joGraph.RunMethod("setLineDashes", Array As Object(LineDashes))		
End Sub

'Sets the line dash offset
Public Sub SetLineDashOffset(LineDashOffset As Double)
	joGraph.RunMethod("setLineDashOffset", Array As Object(LineDashOffset))		
End Sub

'Returns the paint object according to the color string
Public Sub GetPaint(Color As String) As Paint
	Private joPaint As JavaObject
	joPaint = joPaint.InitializeStatic("javafx.scene.paint.Paint")
	Return joPaint.RunMethod("valueOf", Array As Object(Color))
End Sub

'Returns true if the given point is insides the current path
Public Sub isPointInPath(x As Double, y As Double) As Boolean
	Return joGraph.RunMethod("isPointInPath", Array As Object(x, y))
End Sub

'Intersects the current clip with the current path and applies it to subsequent rendering operation as an anti-aliased mask.
Public Sub Clip
	joGraph.RunMethod("clip", Null)
End Sub

'Moves the Canvas horizontally by x pixels
Public Sub SetTranslateX(x As Double)
	joCanvas.RunMethod("setTranslateX", Array As Object(x))
End Sub

'Moves the Canvas vertically by y pixels
Public Sub SetTranslateY(y As Double)
	joCanvas.RunMethod("setTranslateY", Array As Object(y))
End Sub

'Scales the x axis of the entire Canvas
Public Sub SetScaleX(scaleX As Double)
	joCanvas.RunMethod("setScaleX", Array As Object(scaleX))
End Sub

'Scales the y axis of the entire Canvas
Public Sub SetScaleY(ScaleY As Double)
	joCanvas.RunMethod("setScaleY", Array As Object(ScaleY))
End Sub

'Scales the current transform matrix by x, y
'This is cumulative, the current scale is multiplied be this one.
Public Sub Scale(x As Double, y As Double)
	joGraph.RunMethod("scale", Array As Object(x, y))
End Sub

'Sets the color of the pixel at the x and y coordinates
'Uses PixelWriter
Public Sub SetPixelColor(x As Int, y As Int, Color As Paint)
	joPixelWriter.RunMethod("setColor", Array As Object(x, y, Color))
End Sub

'Gets the color of the pixel at the x and y coordinates
'Uses PixelReader
Public Sub GetPixelColor(x As Int, y As Int) As Paint
	Private joImage, joPixelReader As JavaObject
	
	joImage = mCanvas.Snapshot
	joPixelReader = joImage.RunMethod("getPixelReader", Null)
	Return joPixelReader.RunMethod("getColor", Array(x, y))
End Sub

'Sets the Transform matrix
'be aware that the values are column by column
'mxx  mxy  mxt
'myx  myy  myt
Public Sub SetTransform(mxx As Double, myx As Double, mxy As Double, myy As Double, mxt As Double, myt As Double)
	joGraph.RunMethod("setTransform", Array As Object(mxx, myx, mxy, myy, mxt, myt))
End Sub

'Concatenates the input to the current Transform matrix
'be aware that the values are column by column
'mxx  mxy  mxt
'myx  myy  myt
Public Sub Transform(mxx As Double, myx As Double, mxy As Double, myy As Double, mxt As Double, myt As Double)
	joGraph.RunMethod("Transform", Array As Object(mxx, myx, mxy, myy, mxt, myt))
End Sub

'Rotates the future drawings by Angle
'cos(Angle)  -sin(Angle)  0
'sin(Angle)   cos(Angle)  0
Public Sub Rotate(Angle As Double)
	joGraph.RunMethod("rotate", Array(Angle))
End Sub

'Translates the future drawings by x and y
'1  0  x
'0  1  y
Public Sub Translate(x As Double, y As Double)
	joGraph.RunMethod("translate", Array(x, y))
End Sub

'Initializes the Transform matrix to
'1  0  0
'0  1  0
Public Sub InitTransformMatrix
	SetTransform(1, 0, 0, 1, 0, 0)
End Sub

'Returns the 2D Transform matrix in a 2 x 3 Doube Array
'Mxx  Mxy  Tx
'Myx  Myy  Ty 
Public Sub GetTransformMatrix As Double(,)
	Private joAffine As JavaObject
	Private mm(2, 3) As Double
	
	joAffine.InitializeNewInstance("javafx.scene.transform.Affine", Null)
	joGraph.RunMethod("getTransform", Array(joAffine))
	mm(0, 0) = joAffine.RunMethod("getMxx", Null)
	mm(0, 1) = joAffine.RunMethod("getMxy", Null)
	mm(0, 2) = joAffine.RunMethod("getTx", Null)
	mm(1, 0) = joAffine.RunMethod("getMyx", Null)
	mm(1, 1) = joAffine.RunMethod("getMyy", Null)
	mm(1, 2) = joAffine.RunMethod("getTy", Null)
	
	Return mm
End Sub

'Returns Tx, the x Transfer value from the 2D Transform matrix
Public Sub GetTransformMatrixTx As Double
	Private joAffine As JavaObject
	Private Tx As Double
	
	joAffine.InitializeNewInstance("javafx.scene.transform.Affine", Null)
	joGraph.RunMethod("getTransform", Array(joAffine))
	Tx = joAffine.RunMethod("getTx", Null)
	Return Tx
End Sub

'Returns Ty, the y Transfer value from the 2D Transform matrix
Public Sub GetTransformMatrixTy As Double
	Private joAffine As JavaObject
	Private Ty As Double
	
	joAffine.InitializeNewInstance("javafx.scene.transform.Affine", Null)
	joGraph.RunMethod("getTransform", Array(joAffine))
	Ty = joAffine.RunMethod("getTy", Null)
	Return Ty
End Sub

'Saves the following attributes onto a stack.
Public Sub Save
	joGraph.RunMethod("save", Null)
End Sub

'Pops the state off of the stack, setting the following attributes to their value at the time when that state was pushed onto the stack.
Public Sub Restore
	joGraph.RunMethod("restore", Null)

End Sub
