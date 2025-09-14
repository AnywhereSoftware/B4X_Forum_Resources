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

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'TJO.InitializeNewInstance("javafx.scene.shape.Rectangle",Null)
End Sub

'Creates an empty instance of Rectangle.
Public Sub Create()
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.shape.Rectangle",Null)
End Sub
'Creates a new instance of Rectangle with the given size.
Public Sub Create2(Width As Double, Height As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.shape.Rectangle",Array As Object(Width, Height))
End Sub

'Creates a new instance of Rectangle with the given position and size.
Public Sub Create3(X As Double, Y As Double, Width As Double, Height As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.shape.Rectangle",Array As Object(X, Y, Width, Height))
End Sub

'Creates a new instance of Rectangle with the given size and fill.
Public Sub Create4(Width As Double, Height As Double, Fill As Object)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.shape.Rectangle",Array As Object(Width, Height, Fill))
End Sub
'Gets the value of the property arcHeight.
Public Sub getArcHeight As Double
	Return TJO.RunMethod("getArcHeight",Null)
End Sub
'Gets the value of the property arcWidth.
Public Sub getArcWidth As Double
	Return TJO.RunMethod("getArcWidth",Null)
End Sub
'Gets the value of the property height.
Public Sub getHeight As Double
	Return TJO.RunMethod("getHeight",Null)
End Sub
'Gets the value of the property width.
Public Sub getWidth As Double
	Return TJO.RunMethod("getWidth",Null)
End Sub
'Gets the value of the property height.
Public Sub setHeight(Height As Double)
	TJO.RunMethod("setHeight",Array(Height))
End Sub
'Gets the value of the property width.
Public Sub setWidth(Width As Double)
	TJO.RunMethod("setWidth",Array(Width))
End Sub

Public Sub getParent As Node
	Return TJO.RunMethod("getParent",Null)
End Sub
'Gets the value of the property x.
Public Sub getX As Double
	Return TJO.RunMethod("getX",Null)
End Sub
'Gets the value of the property y.
Public Sub getY As Double
	Return TJO.RunMethod("getY",Null)
End Sub
'Gets the value of the property layoutX.
Public Sub getLayoutX As Double
	Return TJO.RunMethod("getLayoutX",Null)
End Sub
'Gets the value of the property layoutY.
Public Sub getLayoutY As Double
	Return TJO.RunMethod("getLayoutY",Null)
End Sub
'Sets the value of the property arcHeight.
Public Sub setArcHeight(Value As Double)
	TJO.RunMethod("setArcHeight",Array As Object(Value))
End Sub
'Sets the value of the property arcWidth.
Public Sub setArcWidth(Value As Double)
	TJO.RunMethod("setArcWidth",Array As Object(Value))
End Sub
'Sets the value of the property x.
Public Sub setX(Value As Double)
	TJO.RunMethod("setX",Array As Object(Value))
End Sub
'Sets the value of the property y.
Public Sub setY(Value As Double)
	TJO.RunMethod("setY",Array As Object(Value))
End Sub
Public Sub getJavaObject As JavaObject
	Return TJO
End Sub
Public Sub GetObject As Object
	Return TJO
End Sub
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub
Public Sub AsNode As Node
	Return TJO
End Sub
Public Sub AsB4xView As B4XView
	Return TJO
End Sub
'Inherited Methods

'Gets the value of the property fill.
Public Sub getFill As Object
	Return TJO.RunMethod("getFill",Null)
End Sub
'Gets the value of the property stroke.
Public Sub getStroke As Object
	Return TJO.RunMethod("getStroke",Null)
End Sub
'Defines the array representing the lengths of the dash segments.
Public Sub getStrokeDashArray As List
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
'Gets the value of the property smooth.
Public Sub IsSmooth As Boolean
	Return TJO.RunMethod("isSmooth",Null)
End Sub
'Sets the value of the property fill.
Public Sub setFill(Value As Object)
	TJO.RunMethod("setFill",Array As Object(Value))
End Sub
Public Sub setLayoutX(X As Double)
	TJO.RunMethod("setLayoutX",Array(X))
End Sub
Public Sub setLayoutY(Y As Double)
	TJO.RunMethod("setLayoutY",Array(Y))
End Sub
'Sets the value of the property smooth.
Public Sub setSmooth(Value As Boolean)
	TJO.RunMethod("setSmooth",Array As Object(Value))
End Sub
'Sets the value of the property stroke.
Public Sub setStroke(Value As Object)
	TJO.RunMethod("setStroke",Array As Object(Value))
End Sub
'Sets the value of the property strokeDashOffset.
Public Sub setStrokeDashOffset(Value As Double)
	TJO.RunMethod("setStrokeDashOffset",Array As Object(Value))
End Sub
'Sets the value of the property strokeLineCap.
Public Sub setStrokeLineCap(Value As String)
	Dim s As GLShape 
	s.Initialize
	s.SetObject(TJO)
	s.setStrokeLineCap(Value)
End Sub
'Sets the value of the property strokeLineJoin.
Public Sub setStrokeLineJoin(Value As String)
	Dim s As GLShape 
	s.Initialize
	s.SetObject(TJO)
	s.setStrokeLineJoin(Value)
End Sub
'Sets the value of the property strokeMiterLimit.
Public Sub setStrokeMiterLimit(Value As Double)
	TJO.RunMethod("setStrokeMiterLimit",Array As Object(Value))
End Sub
'Sets the value of the property strokeType.
Public Sub setStrokeType(Value As String)
	Dim s As GLShape 
	s.Initialize
	s.SetObject(TJO)
	s.setStrokeType(Value)
End Sub
'Sets the value of the property strokeWidth.
Public Sub setStrokeWidth(Value As Double)
	TJO.RunMethod("setStrokeWidth",Array As Object(Value))
End Sub
'Returns a new Shape which is created by subtracting the specified second shape from the first shape.
Public Sub Subtract(Shape1 As GLRectangle, Shape2 As GLRectangle) As GLShape
	Dim s As GLShape
	s.Initialize
	Return s.Subtract(Shape1,Shape2)
End Sub
'Returns a new Shape which is created as a union of the specified input shapes.
Public Sub Union(Shape1 As GLRectangle, Shape2 As GLRectangle) As GLShape
	Dim s As GLShape
	s.Initialize
	Return s.Union(Shape1,Shape2)
End Sub
'Returns a new Shape which is created as an intersection of the specified input shapes.
Public Sub Intersect(Shape1 As GLRectangle, Shape2 As GLRectangle) As GLShape
	Dim s As GLShape
	s.Initialize
	Return s.Intersect(Shape1,Shape2)
End Sub

Public Sub Intersects(X As Double,Y As Double,Width As Double,Height As Double) As Boolean
	Return TJO.RunMethod("intersects",Array(X,Y,Width,Height))
End Sub

Public Sub intersects2(localBounds As JavaObject) As Boolean
	Return TJO.RunMethod("intersects",Array(localBounds))
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
Public Sub BringToFront
	TJO.RunMethod("toFront",Null)
End Sub