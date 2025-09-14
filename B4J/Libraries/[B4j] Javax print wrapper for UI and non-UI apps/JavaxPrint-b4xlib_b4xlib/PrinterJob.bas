B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Print_Event
#Event: Event (MethodName As String, Args() As Object) As Int

'Class Module
Sub Class_Globals
	Private Tjo As JavaObject
	Private Th As Thread		'ignore
	Private ExceptionMessage As String
End Sub

'A PrinterJob object should be created using the static getPrinterJob method.
Public Sub Initialize
	Th.Initialise("TH")
'	Tjo.InitializeNewInstance("java.awt.print.PrinterJob",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Cancels a print job that is in progress.
Public Sub Cancel
	Tjo.RunMethod("cancel",Null)
End Sub
'Creates a new PageFormat instance and sets it to a default size and orientation.
Public Sub DefaultPage As PageFormat
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("defaultPage",Null))
	Return Wrapper
End Sub
'Clones the PageFormat argument and alters the clone to describe a default page size and orientation.
Public Sub DefaultPage2(Page As PageFormat) As PageFormat
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("defaultPage",Array As Object(Page.GetObject)))
	Return Wrapper
End Sub
'Gets the number of copies to be printed.
Public Sub GetCopies As Int
	Return Tjo.RunMethod("getCopies",Null)
End Sub
'Gets the name of the document to be printed.
Public Sub GetJobName As String
	Return Tjo.RunMethod("getJobName",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Calculates a PageFormat with values consistent with those supported by the current PrintService for this job (ie the value returned by getPrintService()) and media, printable area and orientation contained in attributes.
Public Sub GetPageFormat(Atts As Object) As PageFormat
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getPageFormat",Array As Object(Atts)))
	Return Wrapper
End Sub

'Returns the service (printer) for this printer job.
Public Sub GetPrintService As PrintService
	Dim Wrapper As PrintService
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getPrintService",Null))
	Return Wrapper
End Sub
'Gets the name of the printing user.
Public Sub GetUserName As String
	Return Tjo.RunMethod("getUserName",Null)
End Sub
'Returns true if a print job is in progress, but is going to be cancelled at the next opportunity; otherwise returns false.
Public Sub IsCancelled As Boolean
	Return Tjo.RunMethod("isCancelled",Null)
End Sub

'Displays a dialog that allows modification of a PageFormat instance.
Public Sub PageDialog(Page As PageFormat) As PageFormat
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("pageDialog",Array As Object(Page.GetObject)))
	Return Wrapper
End Sub
'A convenience method which displays a cross-platform page setup dialog.
Public Sub PageDialog2(Atts As JavaObject) As PageFormat
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("pageDialog",Array As Object(Atts)))
	Return Wrapper
End Sub

'Prints a set of pages and sets the Printable interface as {EventName}_EventMethodName As String, Args() As Object) As Int
'Where the page drawing is done.
'Pass Null For attributes if not required
Public Sub Print_NoThread(CallBack As Object, EventName As String,PageFormat1 As PageFormat,Atts As Object) As String
	SetPrintable2(NewInstanceJavax.Printable(CallBack,EventName),PageFormat1)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Try
		Tjo.RunMethod("print",Array(Atts))
		Return "OK"
	Catch
		Return "Failed"
	End Try
End Sub

'Prints a set of pages using a printable derived from a view and the passed Attributes
'Pass Null For attributes if not required
Public Sub Print_NoThread2(Atts As Object)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Tjo.RunMethod("print",Array(Atts))
End Sub



'Prints a set of pages and sets the Printable interface as {EventName}_EventMethodName As String, Args() As Object) As Int
'Where the page drawing is done.
'Pass Null For attributes if not required
Public Sub Print(CallBack As Object, EventName As String,PageFormat1 As PageFormat,Atts As Object) As ResumableSub
	#If Debug
	Dim Tw As Throwables
	Tw.Initialize
	Tw.Throw(Tw.NewIllegalStateException("Printable and Threading cannot be used in debug mode"))
	#End If
	
	ExceptionMessage = ""
	Th.Start(Me,"Print_Do",Array(CallBack,EventName,PageFormat1,Atts))
	
	Wait For Print_Complete(result As String)
	Return IIf(result = "" ,"OK" ,result)
End Sub

Private Sub Print_Do(CallBack As Object, EventName As String, PageFormat1 As PageFormat,Atts As Object)
	SetPrintable2(NewInstanceJavax.Printable(CallBack,EventName),PageFormat1)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Try
		Tjo.RunMethod("print",Array(Atts))
	Catch
		ExceptionMessage = LastException.Message
	End Try
End Sub

Private Sub TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
	CallSub2(Me,"Print_Complete",ExceptionMessage)
End Sub

'Prints a set of pages using a printable derived from a view and the passed Attributes
'Pass Null For attributes if not required
Public Sub Print2(Atts As Object) As ResumableSub
	#If Debug
	Dim Tw As Throwables
	Tw.Initialize
	Tw.Throw(Tw.NewIllegalStateException("Printable and Threading cannot be used in debug mode"))
	#End If
	
	ExceptionMessage = ""
	
	Th.Start(Me,"Print_Do2",Array(Atts))
	Wait For Print_Complete(Result As String)
	Return IIf(Result = "" ,"OK" ,Result)
End Sub

Private Sub Print_Do2(Atts As Object)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Try
		Tjo.RunMethod("print",Array(Atts))
	Catch
		ExceptionMessage = LastException.Message
	End Try
End Sub

''Prints a set of pages.
'Public Sub PrintBook_NoThread(tBook As Book)
'
'	Dim M As Map
'	M.Initialize
'	
'	For Each PT As PainterType In tBook.GetPainterList
'		If M.ContainsKey(PT.EventName) Then
'			tBook.AsJavaObject.RunMethod("append",Array As Object(M.Get(PT.EventName), PT.PF.GetObject))
'		Else
'			Dim O As Object = NewInstanceJavax.Printable(PT.CallBack,PT.EventName)
'			M.Put(PT.EventName,O)
'			tBook.AsJavaObject.RunMethod("append",Array(O, PT.PF.GetObject))
'		End If
'	Next
'	
'	Try
'		Tjo.RunMethod("print",Null)
'	Catch
'		ExceptionMessage = LastException.Message
'	End Try
'End Sub

'Prints a set of pages.
Public Sub PrintBook_NoThread(tBook As Book,Atts As Object)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")

	Dim M As Map
	M.Initialize
	
	For Each PT As PainterType In tBook.GetPainterList
		If M.ContainsKey(PT.EventName) Then
			tBook.AsJavaObject.RunMethod("append",Array As Object(M.Get(PT.EventName), PT.PF.GetObject))
		Else
			Dim O As Object = NewInstanceJavax.Printable(PT.CallBack,PT.EventName)
			M.Put(PT.EventName,O)
			tBook.AsJavaObject.RunMethod("append",Array(O, PT.PF.GetObject))
		End If
	Next
	
	Try
		Tjo.RunMethod("print",Array(Atts))
	Catch
		ExceptionMessage = LastException.Message
	End Try
End Sub

'Prints a set of pages.
'Pass Null For attributes if not required
Public Sub PrintBook(tBook As Book, Atts As Object) As ResumableSub
	#If Debug
	Dim Tw As Throwables
	Tw.Initialize
	Tw.Throw(Tw.NewIllegalStateException("Printable and Threading cannot be used in debug mode"))
	#End If
	
	Th.Start(Me,"PrintBook_Do",Array(tBook,Atts))

	Wait For Print_Complete(Result As String)
	Return IIf(Result = "" ,"OK" ,Result)
End Sub

''Prints a set of pages using the passed Attributes
'Public Sub PrintBook2(tBook As Book,Atts As PrintRequestAttributeSet) As ResumableSub
'	#If Debug
'	Dim Tw As Throwables
'	Tw.Initialize
'	Tw.Throw(Tw.NewIllegalStateException("Printable and Threading cannot be used in debug mode"))
'	#End If
'	
'	Th.Start(Me,"PrintBook_Do",Array(tBook,Atts))
'	
'	Wait For Print_Complete(Result As String)
'	Return IIf(Result = "" ,"OK" ,Result)
'End Sub

Private Sub PrintBook_Do(tBook As Book,Atts As Object)
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")

	Dim M As Map
	M.Initialize
	
	For Each PT As PainterType In tBook.GetPainterList
		If M.ContainsKey(PT.EventName) Then
			tBook.AsJavaObject.RunMethod("append",Array As Object(M.Get(PT.EventName), PT.PF.GetObject))
		Else
			Dim O As Object = NewInstanceJavax.Printable(PT.CallBack,PT.EventName)
			M.Put(PT.EventName,O)
			tBook.AsJavaObject.RunMethod("append",Array(O, PT.PF.GetObject))
		End If
	Next
	
	Try
		Tjo.RunMethod("print",Array(Atts))
	Catch
		ExceptionMessage = LastException.Message
	End Try
End Sub

'Presents a dialog to the user for changing the properties of the print job.
Public Sub PrintDialog As Boolean
	Return Tjo.RunMethod("printDialog",Null)
End Sub
'A convenience method which displays a cross-platform print dialog for all services which are capable of printing 2D graphics using the Pageable interface.
Public Sub PrintDialog2(Atts As JavaObject) As Boolean
	Return Tjo.RunMethod("printDialog",Array As Object(Atts))
End Sub
'Sets the number of copies to be printed.
Public Sub SetCopies(tCopies As Int)
	Tjo.RunMethod("setCopies",Array As Object(tCopies))
End Sub
'Sets the name of the document to be printed.
Public Sub SetJobName(JobName As String)
	Tjo.RunMethod("setJobName",Array As Object(JobName))
End Sub
'Queries document for the number of pages and the PageFormat and Printable for each page held in the Pageable instance, document.
Public Sub SetPageable(Document As Object)
	If JavaxPrint_Utils.IsPackageObject(Document) Then Document = CallSub(Document,"GetObject")
	Tjo.RunMethod("setPageable",Array As Object(Document))
End Sub
'Calls painter to render the pages.
Public Sub SetPrintable(Painter As Object)
	Tjo.RunMethod("setPrintable",Array As Object(Painter))
End Sub
'Calls painter to render the pages in the specified format.
Public Sub SetPrintable2(Painter As Object, Format As PageFormat)
	Tjo.RunMethod("setPrintable",Array As Object(Painter, Format.GetObject))
End Sub
'Associate this PrinterJob with a new PrintService.
Public Sub SetPrintService(Service As PrintService)
	Tjo.RunMethod("setPrintService",Array As Object(Service.GetObject))
End Sub
'Returns the clone of page with its settings adjusted to be compatible with the current printer of this PrinterJob.
Public Sub ValidatePage(Page As PageFormat) As PageFormat
	Dim Wrapper As PageFormat
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("validatePage",Array As Object(Page.GetObject)))
	Return Wrapper
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

