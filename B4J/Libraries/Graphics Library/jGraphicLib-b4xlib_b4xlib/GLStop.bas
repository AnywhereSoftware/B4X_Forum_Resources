B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.51
@EndOfDesignText@
'Class Module
Sub Class_Globals
	Private fx As JFX ' Uncomment if required for B4j only

	Private TJO As JavaObject
	Private mTag As Object
End Sub

'Initialize the object
Public Sub Initialize
End Sub
'Creates a new instance of Stop.
Public Sub Create(Offset As Double, Color As Paint)
	Dim ColorJO As JavaObject = Color
	Dim PColor As JavaObject
	PColor.InitializeStatic("javafx.scene.paint.Color")
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.paint.Stop",Array As Object(Offset, PColor.RunMethod("valueOf",Array(ColorJO.RunMethod("toString",Null)))))
End Sub
'Gets the color of the gradient at this offset.
Public Sub getColor As Object
	Return TJO.RunMethod("getColor",Null)
End Sub
'Gets a number ranging from 0 to 1 that indicates where this gradient stop is placed.
Public Sub getOffset As Double
	Return TJO.RunMethod("getOffset",Null)
End Sub
Public Sub GetObject As Object
	Return TJO
End Sub
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub
Public Sub getJavaObject As JavaObject
	Return TJO
End Sub
Sub setTag(Tag As Object)
	mTag = Tag
End Sub
Sub getTag As Object
	Return mTag
End Sub

