B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.8
@EndOfDesignText@
'Class Module
#RaisesSynchronousEvents: ShowPageSetupDialog
#RaisesSynchronousEvents: ShowPrintDialog
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required for B4j only
	Private PJ As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
		
End Sub

'Cancel the underlying print job at the earliest opportunity.
Public Sub CancelJob
	PJ.RunMethod("cancelJob",Null)
End Sub
'If the job can be successfully spooled to the printer queue this will return true.
Public Sub EndJob As Boolean
	Return PJ.RunMethod("endJob",Null)
End Sub
'The JobSettings encapsulates all the API supported job configuration options such as number of copies, collation option, duplex option, etc.
Public Sub GetJobSettings As JobSettings
	Dim JS As JobSettings
	JS.Initialize
	JS.SetObject(PJ.RunMethod("getJobSettings",Null))
	Return JS
End Sub
'Obtain the current status of the job.
'One of: NOT_STARTED, PRINTING, CANCELLED, DONE, ERROR
Public Sub GetJobStatus As String
	Return PJ.RunMethodJO("getJobStatus",Null).RunMethod("toString",Null)
End Sub
'Gets the printer currently associated with this job.
Public Sub GetPrinter As Printer
	Return Printer_Static.MappedPrinter(PJ.RunMethod("getPrinter",Null)) 

End Sub
'Print the specified node.
Public Sub PrintPage(Node As Node) As Boolean
	Return PJ.RunMethod("printPage",Array As Object(Node))
End Sub
'Print the specified node using the specified page layout.
Public Sub PrintPage2(PLayout As PageLayout, Node As Node) As Boolean
	Return PJ.RunMethod("printPage",Array As Object(PLayout.GetObject, Node))
End Sub
'Change the printer for this job.
Public Sub SetPrinter(Printer1 As Printer)
	PJ.RunMethod("setPrinter",Array As Object(Printer1.GetObject))
End Sub
'Displays a Page Setup dialog.
Public Sub ShowPageSetupDialog(Form As Form) As Boolean
	Dim Window As Object = GetWindow(Form)
	Return PJ.RunMethod("showPageSetupDialog",Array As Object(Window))
End Sub
'Displays a Page Setup dialog.
Public Sub ShowPageSetupDialog2(N As Node) As Boolean
	Dim Window As Object = GetWindow2(N)
	Return PJ.RunMethod("showPageSetupDialog",Array As Object(Window))
End Sub
'Displays a Print Dialog.
Public Sub ShowPrintDialog(Form As Form) As Boolean
	Dim Window As Object = GetWindow(Form)
	Return PJ.RunMethod("showPrintDialog",Array(Window))
End Sub
'Displays a Print Dialog.
Public Sub ShowPrintDialog2(N As Node) As Boolean
	Dim Window As Object = GetWindow2(N)
	Return PJ.RunMethod("showPrintDialog",Array(Window))
End Sub
'Display As String
Public Sub ToString As String
	Return PJ.RunMethod("toString",Null)
End Sub
Public Sub GetObject As Object
	Return PJ
End Sub
Public Sub SetObject(Obj As Object)
	PJ = Obj
End Sub
Private Sub GetWindow(Form As Form) As Object
	If Form = Null Then Return Form
	Dim Jo As JavaObject = Form.RootPane
	Jo = Jo.RunMethodJO("getScene",Null).RunMethod("getWindow",Null)
	Return Jo
End Sub
Private Sub GetWindow2(N As Node) As Object
	If N.IsInitialized = False Then Return Null
	Dim Jo As JavaObject = N
	Jo = Jo.RunMethodJO("getScene",Null).RunMethod("getWindow",Null)
	Return Jo
	
End Sub