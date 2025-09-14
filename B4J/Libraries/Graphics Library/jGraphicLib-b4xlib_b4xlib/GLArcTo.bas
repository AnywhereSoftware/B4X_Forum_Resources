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

'Creates an empty instance of ArcTo.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.ArcTo",Null)
End Sub

'Creates a new instance of ArcTo.
Public Sub Create2(RadiusX As Double, RadiusY As Double, XAxisRotation As Double, X As Double, Y As Double, LargeArcFlag As Boolean, SweepFlag As Boolean)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.ArcTo",Array As Object(RadiusX, RadiusY, XAxisRotation, X, Y, LargeArcFlag, SweepFlag))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the value of the property radiusX.
Public Sub GetRadiusX As Double
	Return Tjo.RunMethod("getRadiusX",Null)
End Sub
'Gets the value of the property radiusY.
Public Sub GetRadiusY As Double
	Return Tjo.RunMethod("getRadiusY",Null)
End Sub
'Gets the value of the property x.
Public Sub GetX As Double
	Return Tjo.RunMethod("getX",Null)
End Sub
'Gets the x-axis rotation in degrees.
Public Sub GetXAxisRotation As Double
	Return Tjo.RunMethod("getXAxisRotation",Null)
End Sub
'Gets the value of the property y.
Public Sub GetY As Double
	Return Tjo.RunMethod("getY",Null)
End Sub
'Gets the value of the property absolute.
Public Sub IsAbsolute As Boolean
	Return Tjo.RunMethod("isAbsolute",Null)
End Sub
'Gets the value of the property largeArcFlag.
Public Sub IsLargeArcFlag As Boolean
	Return Tjo.RunMethod("isLargeArcFlag",Null)
End Sub
'Gets the value of the property sweepFlag.
Public Sub IsSweepFlag As Boolean
	Return Tjo.RunMethod("isSweepFlag",Null)
End Sub
'The large arc flag.
'Sets the value of the property absolute.
Public Sub SetAbsolute(Value As Boolean)
	Tjo.RunMethod("setAbsolute",Array As Object(Value))
End Sub
'Sets the value of the property largeArcFlag.
Public Sub SetLargeArcFlag(Value As Boolean)
	Tjo.RunMethod("setLargeArcFlag",Array As Object(Value))
End Sub
'Sets the value of the property radiusX.
Public Sub SetRadiusX(Value As Double)
	Tjo.RunMethod("setRadiusX",Array As Object(Value))
End Sub
'Sets the value of the property radiusY.
Public Sub SetRadiusY(Value As Double)
	Tjo.RunMethod("setRadiusY",Array As Object(Value))
End Sub
'Sets the value of the property sweepFlag.
Public Sub SetSweepFlag(Value As Boolean)
	Tjo.RunMethod("setSweepFlag",Array As Object(Value))
End Sub
'Sets the value of the property x.
Public Sub SetX(Value As Double)
	Tjo.RunMethod("setX",Array As Object(Value))
End Sub
'Sets the x-axis rotation in degrees.
Public Sub SetXAxisRotation(Value As Double)
	Tjo.RunMethod("setXAxisRotation",Array As Object(Value))
End Sub
'Sets the value of the property y.
Public Sub SetY(Value As Double)
	Tjo.RunMethod("setY",Array As Object(Value))
End Sub
'Returns a string representation of this ArcTo object.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

