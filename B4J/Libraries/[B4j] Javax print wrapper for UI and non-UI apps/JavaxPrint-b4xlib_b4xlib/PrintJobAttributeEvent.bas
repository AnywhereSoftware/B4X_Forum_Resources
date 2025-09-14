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

'Constructs a PrintJobAttributeEvent object.
Public Sub Create(Source As DocPrintJob, Atts As PrintJobAttributeSet)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javax.print.event.PrintJobAttributeEvent",Array As Object(Source.GetObject, Atts.GetObject))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Determine the printing attributes that changed and their new values.
Public Sub GetAttributes As PrintJobAttributeSet
	Dim O As Object = Tjo.RunMethod("getAttributes",Null)
	Dim Wrapper As PrintJobAttributeSet
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Determine the PrintJob to which this print job event pertains.
Public Sub GetPrintJob As DocPrintJob
	Dim O As Object = Tjo.RunMethod("getPrintJob",Null)
	Dim Wrapper As DocPrintJob
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns a string representation of this PrintEvent.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub
