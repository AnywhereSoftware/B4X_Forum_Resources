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

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.shape.ClosePath",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the value of the property absolute.
Public Sub IsAbsolute As Boolean
	Return Tjo.RunMethod("isAbsolute",Null)
End Sub
'Sets the value of the property absolute.
Public Sub SetAbsolute(Value As Boolean)
	Tjo.RunMethod("setAbsolute",Array As Object(Value))
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

