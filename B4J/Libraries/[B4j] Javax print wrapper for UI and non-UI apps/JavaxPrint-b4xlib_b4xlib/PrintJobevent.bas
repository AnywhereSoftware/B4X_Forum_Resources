B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	

	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
End Sub

'The job is not necessarily printed yet, but the data has been transferred successfully from the client to the print service.
Public Sub DATA_TRANSFER_COMPLETE As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrintJobEvent")
	Return Tjo1.GetField("DATA_TRANSFER_COMPLETE")
End Sub

'The job was canceled by the PrintService.
Public Sub JOB_CANCELED As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrinTjo1bEvent")
	Return Tjo1.GetField("JOB_CANCELED")
End Sub

'The document cis completely printed.
Public Sub JOB_COMPLETE As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrinTjo1bEvent")
	Return Tjo1.GetField("JOB_COMPLETE")
End Sub

'The print service reports that the job cannot be completed.
Public Sub JOB_FAILED As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrinTjo1bEvent")
	Return Tjo1.GetField("JOB_FAILED")
End Sub

'Not all print services may be capable of delivering interesting events, or even telling when a job is complete.
Public Sub NO_MORE_EVENTS As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrinTjo1bEvent")
	Return Tjo1.GetField("NO_MORE_EVENTS")
End Sub

'The print service indicates that a - possibly transient - problem may require external intervention before the print service can continue.
Public Sub REQUIRES_ATTENTION As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.event.PrinTjo1bEvent")
	Return Tjo1.GetField("REQUIRES_ATTENTION")
End Sub

'Constructs a PrintJobEvent object.
Public Sub Create(Source As DocPrintJob, Reason As Int)
	
	Tjo.InitializeNewInstance("javax.print.event.PrintJobEvent",Array As Object(Source.GetObject, Reason))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the reason for this event.
Public Sub GetPrintEventType As Int
	Return Tjo.RunMethod("getPrintEventType",Null)
End Sub
'Determines the DocPrintJob to which this print job event pertains.
Public Sub GetPrintJob As DocPrintJob
	Dim Wrapper As DocPrintJob
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getPrintJob",Null))
	Return Wrapper
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

