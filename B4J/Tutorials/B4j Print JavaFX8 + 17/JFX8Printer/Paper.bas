B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.8
@EndOfDesignText@
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required for B4j only
	Private PaperJO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	PaperJO.InitializeStatic("javafx.print.Paper")
	
End Sub

'Test for equality
Public Sub Equals(O As Object) As Boolean
	Return PaperJO.RunMethod("equals",Array As Object(O))
End Sub
'Get the height of the paper in points (1/72 inch)
Public Sub GetHeight As Double
	Return PaperJO.RunMethod("getHeight",Null)
End Sub
'Get the paper name.
Public Sub GetName As String
	Return PaperJO.RunMethod("getName",Null)
End Sub
'Get the width of the paper in points (1/72 inch)
Public Sub GetWidth As Double
	Return PaperJO.RunMethod("getWidth",Null)
End Sub
'Returns String Representation of the object
Public Sub ToString As String
	Return PaperJO.RunMethod("toString",Null)
End Sub
Public Sub GetObject As JavaObject
	Return PaperJO
End Sub
Public Sub SetObject (Obj As Object)
	PaperJO = Obj
End Sub