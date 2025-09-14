B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	
	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Constructs a new Insets instance with four different offsets.
Public Sub Create(Top As Double, Right As Double, Bottom As Double, Left As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.geometry.Insets",Array As Object(Top, Right, Bottom, Left))
End Sub

'Constructs a new Insets instance with same value for all four offsets.
Public Sub Create2(TopRightBottomLeft As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.geometry.Insets",Array As Object(TopRightBottomLeft))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'The inset on the bottom side
Public Sub GetBottom As Double
	Return Tjo.RunMethod("getBottom",Null)
End Sub
'The inset on the left side
Public Sub GetLeft As Double
	Return Tjo.RunMethod("getLeft",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'The inset on the right side
Public Sub GetRight As Double
	Return Tjo.RunMethod("getRight",Null)
End Sub
'The inset on the top side
Public Sub GetTop As Double
	Return Tjo.RunMethod("getTop",Null)
End Sub
'Returns a hash code value for the insets.
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Returns a string representation for the insets.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

