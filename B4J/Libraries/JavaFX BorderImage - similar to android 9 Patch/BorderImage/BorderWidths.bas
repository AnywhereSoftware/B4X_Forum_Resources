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

'Creates a new BorderWidths with the specified widths for top, right, bottom, and left.
Public Sub Create(Top As Double, Right As Double, Bottom As Double, Left As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.layout.BorderWidths",Array As Object(Top, Right, Bottom, Left))
End Sub

'*
Public Sub Create2(Top As Double, Right As Double, Bottom As Double, Left As Double, TopAsPercentage As Boolean, RightAsPercentage As Boolean, BottomAsPercentage As Boolean, LeftAsPercentage As Boolean)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.layout.BorderWidths",Array As Object(Top, Right, Bottom, Left, TopAsPercentage, RightAsPercentage, BottomAsPercentage, LeftAsPercentage))
End Sub

'Creates a new BorderWidths using the given width for all four borders, and treating this width as a literal value, and not a percentage.
Public Sub Create3(Width As Double)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javafx.scene.layout.BorderWidths",Array As Object(Width))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Indicates whether some other object is "equal to" this one.
Public Sub Equals(O As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(O))
End Sub
'The non-negative value (with the exception of AUTO) indicating the border thickness on the bottom of the border.
Public Sub GetBottom As Double
	Return Tjo.RunMethod("getBottom",Null)
End Sub
'The non-negative value (with the exception of AUTO) indicating the border thickness on the left of the border.
Public Sub GetLeft As Double
	Return Tjo.RunMethod("getLeft",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'The non-negative value (with the exception of AUTO) indicating the border thickness on the right of the border.
Public Sub GetRight As Double
	Return Tjo.RunMethod("getRight",Null)
End Sub
'A non-negative value (with the exception of AUTO) indicating the border thickness on the top of the border.
Public Sub GetTop As Double
	Return Tjo.RunMethod("getTop",Null)
End Sub
'Returns a hash code value for the object.
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Specifies whether the bottom property should be interpreted as a percentage (true) of the region height or not (false).
Public Sub IsBottomAsPercentage As Boolean
	Return Tjo.RunMethod("isBottomAsPercentage",Null)
End Sub
'Specifies whether the left property should be interpreted as a percentage (true) of the region width or not (false).
Public Sub IsLeftAsPercentage As Boolean
	Return Tjo.RunMethod("isLeftAsPercentage",Null)
End Sub
'Specifies whether the right property should be interpreted as a percentage (true) of the region width or not (false).
Public Sub IsRightAsPercentage As Boolean
	Return Tjo.RunMethod("isRightAsPercentage",Null)
End Sub
'Specifies whether the top property should be interpreted as a percentage (true) of the region height or not (false).
Public Sub IsTopAsPercentage As Boolean
	Return Tjo.RunMethod("isTopAsPercentage",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

