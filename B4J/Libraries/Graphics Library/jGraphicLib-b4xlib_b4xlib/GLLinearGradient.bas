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
End Sub

'Initialize the object and Creates a new instance of LinearGradient. Stops is a list of GLStops
Public Sub Initialize
End Sub
Public Sub Create(StartX As Double, StartY As Double, EndX As Double, EndY As Double, Proportional As Boolean, CycleMethod As String, Stops As List)
	Dim StopsList As List
	StopsList.Initialize
	For Each S As GLStop In Stops
		StopsList.Add(S.GetObject)
	Next
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.scene.paint.CycleMethod")
	TJO.InitializeNewInstance("javafx.scene.paint.LinearGradient",Array As Object(StartX, StartY, EndX, EndY, Proportional, JO.RunMethod("valueOf",Array(CycleMethod)), StopsList))
End Sub

'Defines which of the following cycle method is applied to the LinearGradient: CycleMethod.NO_CYCLE, CycleMethod.REFLECT, or CycleMethod.REPEAT.
Public Sub getCycleMethod As String
	Return TJO.RunMethodJO("getCycleMethod",Null).RunMethod("toString",Null)
End Sub
'Defines the X coordinate of the gradient axis end point.
Public Sub getEndX As Double
	Return TJO.RunMethod("getEndX",Null)
End Sub
'Defines the Y coordinate of the gradient axis end point.
Public Sub getEndY As Double
	Return TJO.RunMethod("getEndY",Null)
End Sub
'Defines the X coordinate of the gradient axis start point.
Public Sub getStartX As Double
	Return TJO.RunMethod("getStartX",Null)
End Sub
'Defines the Y coordinate of the gradient axis start point.
Public Sub getStartY As Double
	Return TJO.RunMethod("getStartY",Null)
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
'Indicates whether start and end locations are proportional or absolute.
Public Sub IsProportional As Boolean
	Return TJO.RunMethod("isProportional",Null)
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
