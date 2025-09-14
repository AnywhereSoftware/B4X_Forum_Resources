B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Creates an empty instance of CubicCurveTo.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.CubicCurveTo",Null)
End Sub

'Creates a new instance of CubicCurveTo.
Public Sub Create2(ControlX1 As Double, ControlY1 As Double, ControlX2 As Double, ControlY2 As Double, X As Double, Y As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.CubicCurveTo",Array As Object(ControlX1, ControlY1, ControlX2, ControlY2, X, Y))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Gets the value of the property controlX1.
Public Sub GetControlX1 As Double
	Return Tjo.RunMethod("getControlX1",Null)
End Sub
'Gets the value of the property controlX2.
Public Sub GetControlX2 As Double
	Return Tjo.RunMethod("getControlX2",Null)
End Sub
'Gets the value of the property controlY1.
Public Sub GetControlY1 As Double
	Return Tjo.RunMethod("getControlY1",Null)
End Sub
'Gets the value of the property controlY2.
Public Sub GetControlY2 As Double
	Return Tjo.RunMethod("getControlY2",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the value of the property x.
Public Sub GetX As Double
	Return Tjo.RunMethod("getX",Null)
End Sub
'Gets the value of the property y.
Public Sub GetY As Double
	Return Tjo.RunMethod("getY",Null)
End Sub
'Sets the value of the property controlX1.
Public Sub SetControlX1(Value As Double)
	Tjo.RunMethod("setControlX1",Array As Object(Value))
End Sub
'Sets the value of the property controlX2.
Public Sub SetControlX2(Value As Double)
	Tjo.RunMethod("setControlX2",Array As Object(Value))
End Sub
'Sets the value of the property controlY1.
Public Sub SetControlY1(Value As Double)
	Tjo.RunMethod("setControlY1",Array As Object(Value))
End Sub
'Sets the value of the property controlY2.
Public Sub SetControlY2(Value As Double)
	Tjo.RunMethod("setControlY2",Array As Object(Value))
End Sub
'Sets the value of the property x.
Public Sub SetX(Value As Double)
	Tjo.RunMethod("setX",Array As Object(Value))
End Sub
'Sets the value of the property y.
Public Sub SetY(Value As Double)
	Tjo.RunMethod("setY",Array As Object(Value))
End Sub
'Returns a string representation of this CubicCurveTo object.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

