B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.51
@EndOfDesignText@
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required for B4j only

	Private TJO As JavaObject
	Private mTag As Object
End Sub

Public Sub Initialize()

End Sub
'Construct an empty shape
Public Sub Create
	TJO.InitializeNewInstance("javafx.scene.shape.Shape",Null)
End Sub
'Gets the value of the property fill.
Public Sub getFill As Object
	Return TJO.RunMethod("getFill",Null)
End Sub
'Gets the value of the property stroke.
Public Sub getStroke As JavaObject
	Return TJO.RunMethod("getStroke",Null)
End Sub
'Defines the array representing the lengths of the dash segments.
Public Sub getStrokeDashArray As JavaObject
	Return TJO.RunMethod("getStrokeDashArray",Null)
End Sub
'Gets the value of the property strokeDashOffset.
Public Sub getStrokeDashOffset As Double
	Return TJO.RunMethod("getStrokeDashOffset",Null)
End Sub
'Gets the value of the property strokeLineCap.
Public Sub getStrokeLineCap As String
	Return TJO.RunMethodJO("getStrokeLineCap",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property strokeLineJoin.
Public Sub getStrokeLineJoin As String
	Return TJO.RunMethodJO("getStrokeLineJoin",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property strokeMiterLimit.
Public Sub getStrokeMiterLimit As Double
	Return TJO.RunMethod("getStrokeMiterLimit",Null)
End Sub
'Gets the value of the property strokeType.
Public Sub getStrokeType As String
	Return TJO.RunMethodJO("getStrokeType",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property strokeWidth.
Public Sub getStrokeWidth As Double
	Return TJO.RunMethod("getStrokeWidth",Null)
End Sub
'Returns a new Shape which is created as an intersection of the specified input shapes.
Public Sub Intersect(Shape1 As Object, Shape2 As Object) As GLShape
	
	Dim S1 As GLShape = CastShape(Shape1)
	Dim S2 As GLShape = CastShape(Shape2)
	
	Dim S As GLShape
	Dim SJO As JavaObject
	SJO.InitializeStatic("javafx.scene.shape.Shape")
	S.SetObject(SJO.RunMethod("intersect",Array As Object(S1.GetObject, S2.GetObject)))
	Return S
	
End Sub
'Gets the value of the property smooth.
Public Sub IsSmooth As Boolean
	Return TJO.RunMethod("isSmooth",Null)
End Sub
'Sets the value of the property fill.
Public Sub setFill(Value As Object)
	TJO.RunMethod("setFill",Array As Object(Value))
End Sub
'Sets the value of the property smooth.
Public Sub setSmooth(Value As Boolean)
	TJO.RunMethod("setSmooth",Array As Object(Value))
End Sub
'Sets the value of the property stroke.
Public Sub setStroke(Value As JavaObject)
	TJO.RunMethod("setStroke",Array As Object(Value))
End Sub
'Sets the value of the property strokeDashOffset.
Public Sub setStrokeDashOffset(Value As Double)
	TJO.RunMethod("setStrokeDashOffset",Array As Object(Value))
End Sub
'Sets the value of the property strokeLineCap.
Public Sub setStrokeLineCap(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.shape.StrokeLineCap")
	TJO.RunMethod("setStrokeLineCap",Array(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property strokeLineJoin.
Public Sub setStrokeLineJoin(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.shape.StrokeLineJoin")
	TJO.RunMethod("setStrokeLineJoin",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property strokeMiterLimit.
Public Sub setStrokeMiterLimit(Value As Double)
	TJO.RunMethod("setStrokeMiterLimit",Array As Object(Value))
End Sub
'Sets the value of the property strokeType.
Public Sub setStrokeType(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.shape.StrokeType")
	TJO.RunMethod("setStrokeType",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property strokeWidth.
Public Sub setStrokeWidth(Value As Double)
	TJO.RunMethod("setStrokeWidth",Array As Object(Value))
End Sub
'Returns a new Shape which is created by subtracting the specified second shape from the first shape.
Public Sub Subtract(Shape1 As Object, Shape2 As Object) As GLShape
	
	Dim S1 As GLShape = CastShape(Shape1)
	Dim S2 As GLShape = CastShape(Shape2)
	
	Dim S As GLShape
	Dim SJO As JavaObject
	SJO.InitializeStatic("javafx.scene.shape.Shape")
	S.SetObject(SJO.RunMethod("subtract",Array As Object(S1.GetObject, S2.GetObject)))
	Return S
End Sub
'Returns a new Shape which is created as a union of the specified input shapes.
Public Sub Union(Shape1 As Object, Shape2 As Object) As GLShape
	
	Dim S1 As GLShape = CastShape(Shape1)
	Dim S2 As GLShape = CastShape(Shape2)
	
	Dim S As GLShape
	Dim SJO As JavaObject
	SJO.InitializeStatic("javafx.scene.shape.Shape")
	S.SetObject(SJO.RunMethod("union",Array As Object(S1.GetObject, S2.GetObject)))
	Return S
End Sub
'Returns the GLArc, GlRect etc. as a GLShape object
Sub CastShape(Shape As Object) As GLShape

	Select True
		Case Shape Is GLArc
			Dim A As GLArc = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(A.GetObject)
		
		Case Shape Is GLArc
			Dim C As GLCircle = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(C.GetObject)
		
		Case Shape Is GLCubicCurve
			Dim CC As GLCubicCurve = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(CC.GetObject)
			
		Case Shape Is GLEllipse
			Dim E As GLEllipse = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(E.GetObject)
			
		Case Shape Is GLLine
			Dim L As GLLine = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(L.GetObject)
			
		Case Shape Is GLPath
			Dim P As GLPath = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(P.GetObject)
			
		Case Shape Is GLPolygon
			Dim PO As GLPolygon = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(PO.GetObject)
			
		Case Shape Is GLQuadCurve
			Dim Q As GLQuadCurve = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(Q.GetObject)
			
		Case Shape Is GLRectangle
			Dim R As GLRectangle = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(R.GetObject)
			
		Case Shape Is GLSVGPath
			Dim V As GLSVGPath = Shape
			Dim S As GLShape
			S.Initialize
			S.SetObject(V.GetObject)
		
		Case Shape Is GLText
			Dim T As GLText = Shape
			Dim S As GLShape
			Dim S As GLShape
			S.Initialize
			S.SetObject(T.GetObject)
			
	End Select
	
	Return S
End Sub
Public Sub getPrefWidth As Int
	Dim H As Double = -1
	Return TJO.RunMethod("prefWidth",Array(H))
End Sub
Public Sub getPrefHeight As Int
	Dim H As Double = -1
	Return TJO.RunMethod("prefHeight",Array(H))
End Sub
Public Sub getMinWidth As Int
	Dim H As Double = -1
	Return TJO.RunMethod("prefWidth",Array(H))
End Sub
Public Sub getMinHeight As Int
	Dim H As Double = -1
	Return TJO.RunMethod("prefHeight",Array(H))
End Sub
Public Sub GetObject As Object
	Return TJO
End Sub
Public Sub SetObject(Obj As JavaObject)
	TJO = Obj
End Sub
Public Sub AsNode As Node
	Return TJO
End Sub
Public Sub AsB4xView As B4XView
	Return TJO
End Sub
Public Sub getJavaObject As JavaObject
	Return TJO
End Sub
Sub setID(ID As String)
	TJO.RunMethod("setId",Array(ID))
End Sub
Sub getID As String
	Return TJO.RunMethod("getId",Null)
End Sub
Sub setTag(Tag As Object)
	mTag = Tag
End Sub
Sub getTag As Object
	Return mTag
End Sub
Public Sub BringToFront
	TJO.RunMethod("toFront",Null)
End Sub