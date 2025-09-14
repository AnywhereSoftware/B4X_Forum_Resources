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

	TJO.InitializeNewInstance("javafx.scene.text.Text",Null)
End Sub

'Creates an empty instance of Text.
Public Sub Create()
	TJO.InitializeNewInstance("javafx.scene.text.Text",Null)
End Sub

'Creates an instance of Text on the given coordinates containing the given string.
Public Sub Create2(X As Double, Y As Double, Text As String)	
	TJO.InitializeNewInstance("javafx.scene.text.Text",Array As Object(X, Y, Text))
End Sub

'Creates an instance of Text containing the given string.
Public Sub Create3(Text As String)
	TJO.InitializeNewInstance("javafx.scene.text.Text",Array As Object(Text))
End Sub

'Gets the value of the property baselineOffset.
Public Sub getBaselineOffset As Double
	Return TJO.RunMethod("getBaselineOffset",Null)
End Sub
'Gets the value of the property boundsType.
Public Sub getBoundsType As String										
	Return TJO.RunMethodJO("getBoundsType",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property font.
Public Sub getFont As Font
	Return TJO.RunMethod("getFont",Null)
End Sub
'Gets the value of the property fontSmoothingType.
Public Sub getFontSmoothingType As String
	Return TJO.RunMethodJO("getFontSmoothingType",Null).RunMethod("toString",Null)
End Sub
Sub getStyle As String
	Return TJO.RunMethod("getStyle",Null)
End Sub
'Gets the value of the property text.
Public Sub getText As String
	Return TJO.RunMethod("getText",Null)
End Sub
'Gets the value of the property textAlignment.
Public Sub getTextAlignment As String									
	Return TJO.RunMethodJO("getTextAlignment",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property textOrigin.
Public Sub getTextOrigin As String										
	Return TJO.RunMethodJO("getTextOrigin",Null).RunMethod("toString",Null)
End Sub
'Gets the value of the property wrappingWidth.
Public Sub getWrappingWidth As Double
	Return TJO.RunMethod("getWrappingWidth",Null)
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
'Gets the value of the property strikethrough.
Public Sub IsStrikethrough As Boolean
	Return TJO.RunMethod("isStrikethrough",Null)
End Sub
'Gets the value of the property underline.
Public Sub IsUnderline As Boolean
	Return TJO.RunMethod("isUnderline",Null)
End Sub
'Sets the value of the property boundsType.
Public Sub setBoundsType(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.text.TextBoundsType")
	TJO.RunMethod("setBoundsType",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property font.
Public Sub setFont(Value As Font)
	TJO.RunMethod("setFont",Array As Object(Value))
End Sub
'Sets the value of the property fontSmoothingType.
Public Sub setFontSmoothingType(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.text.FontSmoothingType")
	TJO.RunMethod("setFontSmoothingType",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property strikethrough.
Public Sub setStrikethrough(Value As Boolean)
	TJO.RunMethod("setStrikethrough",Array As Object(Value))
End Sub
Sub setStyle(Style As String)
	TJO.RunMethod("setStyle",Array(Style))
End Sub
'Sets the value of the property text.
Public Sub setText(Value As String)
	TJO.RunMethod("setText",Array As Object(Value))
End Sub
'Sets the value of the property textAlignment.
Public Sub setTextAlignment(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.text.TextAlignment")
	TJO.RunMethod("setTextAlignment",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property textOrigin.
Public Sub setTextOrigin(Value As String)
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.geometry.VPos")
	TJO.RunMethod("setTextOrigin",Array As Object(JO.RunMethod("valueOf",Array(Value))))
End Sub
'Sets the value of the property underline.
Public Sub setUnderline(Value As Boolean)
	TJO.RunMethod("setUnderline",Array As Object(Value))
End Sub
'Sets the value of the property wrappingWidth.
Public Sub setWrappingWidth(Value As Double)
	TJO.RunMethod("setWrappingWidth",Array As Object(Value))
End Sub
'Sets the value of the property x.
Public Sub setX(Value As Double)
	TJO.RunMethod("setLayoutX",Array As Object(Value))
End Sub
'Sets the value of the property y.
Public Sub setY(Value As Double)
	TJO.RunMethod("setLayoutY",Array As Object(Value))
End Sub
Public Sub GetObject As Object
	Return TJO
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
Public Sub SetObject(Obj As Object)
	TJO = Obj
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
	Dim S As GLShape 
	S.Initialize
	S.SetObject(TJO)
	S.setStrokeLineCap(Value)
End Sub
'Sets the value of the property strokeLineJoin.
Public Sub setStrokeLineJoin(Value As String)
	Dim S As GLShape 
	S.Initialize
	S.SetObject(TJO)
	S.setStrokeLineJoin(Value)
End Sub
'Sets the value of the property strokeMiterLimit.
Public Sub setStrokeMiterLimit(Value As Double)
	TJO.RunMethod("setStrokeMiterLimit",Array As Object(Value))
End Sub
'Sets the value of the property strokeType.
Public Sub setStrokeType(Value As String)
	Dim S As GLShape 
	S.Initialize
	S.SetObject(TJO)
	S.setStrokeType(Value)
End Sub
'Sets the value of the property strokeWidth.
Public Sub setStrokeWidth(Value As Double)
	TJO.RunMethod("setStrokeWidth",Array As Object(Value))
End Sub
'Returns a new Shape which is created by subtracting the specified second shape from the first shape.
Public Sub Subtract(Shape1 As GLText, Shape2 As GLText) As GLShape
	Dim S As GLShape
	S.Initialize
	Return S.Subtract(Shape1,Shape2)
End Sub
'Returns a new Shape which is created as a union of the specified input shapes.
Public Sub Union(Shape1 As GLText, Shape2 As GLText) As GLShape
	Dim S As GLShape
	S.Initialize
	Return S.Union(Shape1,Shape2)
End Sub
'Returns a new Shape which is created as an intersection of the specified input shapes.
Public Sub Intersect(Shape1 As GLText, Shape2 As GLText) As GLShape
	Dim S As GLShape
	S.Initialize
	Return S.Intersect(Shape1,Shape2)
End Sub

Public Sub getPrefWidth As Double
	Dim H As Double = -1
	Return TJO.RunMethod("prefWidth",Array(H))
End Sub
Public Sub getPrefHeight As Double
	Dim H As Double = -1
	Return TJO.RunMethod("prefHeight",Array(H))
End Sub
Public Sub getMinWidth As Double
	Dim H As Double = -1
	Return TJO.RunMethod("prefWidth",Array(H))
End Sub
Public Sub getMinHeight As Double
	Dim H As Double = -1
	Return TJO.RunMethod("prefHeight",Array(H))
End Sub
Public Sub BringToFront
	TJO.RunMethod("toFront",Null)
End Sub