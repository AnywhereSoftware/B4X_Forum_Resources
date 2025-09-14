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

End Sub

'Creates a new instance of RadialGradient.
Public Sub Create(FocusAngle As Double, FocusDistance As Double, CenterX As Double, CenterY As Double, Radius As Double, Proportional As Boolean, CycleMethod As String, Stops As List)
	Dim StopsList As List
	StopsList.Initialize
	For Each S As GLStop In Stops
		StopsList.Add(S.GetObject)
	Next
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.paint.CycleMethod")
	TJO.InitializeNewInstance("javafx.scene.paint.RadialGradient",Array As Object(FocusAngle, FocusDistance, CenterX, CenterY, Radius, Proportional,  JO.RunMethod("valueOf",Array(CycleMethod)), StopsList))
End Sub

'Defines the X coordinate of the center point of the circle defining the gradient.
Public Sub getCenterX As Double
	Return TJO.RunMethod("getCenterX",Null)
End Sub
'Defines the X coordinate of the center point of the circle defining the gradient.
Public Sub getCenterY As Double
	Return TJO.RunMethod("getCenterY",Null)
End Sub
'Defines which of the follwing cycle method is applied to the LinearGradient: CycleMethod.NO_CYCLE, CycleMethod.REFLECT, or CycleMethod.REPEAT.
Public Sub getCycleMethod As String
	Return TJO.RunMethodJO("getCycleMethod",Null).RunMethod("toString",Null)
End Sub
'Defines the angle in degrees from the center of the gradient to the focus point to which the first color is mapped.
Public Sub getFocusAngle As Double
	Return TJO.RunMethod("getFocusAngle",Null)
End Sub
'Defines the distance from the center of the gradient to the focus point to which the first color is mapped.
Public Sub getFocusDistance As Double
	Return TJO.RunMethod("getFocusDistance",Null)
End Sub
'Specifies the radius of the circle defining the extents of the color gradient.
Public Sub getRadius As Double
	Return TJO.RunMethod("getRadius",Null)
End Sub
'A List of 2 or more GLStop values specifying how to distribute the colors along the gradient.
Public Sub getStops As List
	Dim L As List = TJO.RunMethod("getStops",Null)
	Dim RL As List
	RL.Initialize
	For Each S As JavaObject In L
		Dim ST As GLStop
		ST.Initialize
		ST.SetObject(S)
		RL.Add(ST)
	Next
	Return RL
End Sub
'Indicates whether the center and radius values are proportional or absolute.
Public Sub IsProportional As Boolean
	Return TJO.RunMethod("isProportional",Null)
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
Public Sub getJavaObject As JavaObject
	Return TJO
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