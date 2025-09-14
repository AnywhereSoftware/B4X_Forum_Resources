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

'Creates an empty instance of VLineTo.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.VLineTo",Null)
End Sub

'Creates an instance of VLineTo.
Public Sub Create2(Y As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.VLineTo",Array As Object(Y))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the value of the property y.
Public Sub GetY As Double
	Return Tjo.RunMethod("getY",Null)
End Sub
'Gets the value of the property absolute.
Public Sub IsAbsolute As Boolean
	Return Tjo.RunMethod("isAbsolute",Null)
End Sub
'Sets the value of the property absolute.
Public Sub SetAbsolute(Value As Boolean)
	Tjo.RunMethod("setAbsolute",Array As Object(Value))
End Sub
'Sets the value of the property y.
Public Sub SetY(Value As Double)
	Tjo.RunMethod("setY",Array As Object(Value))
End Sub
'Returns a string representation of this VLineTo object.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

