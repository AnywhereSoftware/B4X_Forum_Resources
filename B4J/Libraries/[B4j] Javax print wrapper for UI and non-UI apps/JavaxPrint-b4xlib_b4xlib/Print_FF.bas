B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
End Sub


Public Sub Initialize

End Sub

Public Sub Print_NoThread(Service As PrintService) As String

	Dim FF() As Byte = "\f".GetBytes("UTF-8")
	Dim IStream As InputStream
	IStream.InitializeFromBytesArray(FF,0,FF.Length)
	
	Dim PJ As DocPrintJob = Service.CreatePrintJob
	PJ.AddPrintJobListener(Me,"PrintJob")
	
	Dim Flavor As DocFlavor_INPUT_STREAM = DocFlavor_INPUT_STREAM_Fields.AUTOSENSE
	Dim Doc As SimpleDoc = NewInstanceJavax.SimpleDoc(IStream,Flavor,Null)
	
	Dim Result As String
	Try
		Result = PJ.Print_NoThread(Doc,Null)
	Catch
		IStream.Close
		Return "Failed"
	End Try
	
	IStream.Close
	Return "OK"
End Sub

Public Sub Print(Service As PrintService) As ResumableSub

	Dim FF() As Byte = "\f".GetBytes("UTF-8")
	Dim IStream As InputStream
	IStream.InitializeFromBytesArray(FF,0,FF.Length)
	
	Dim PJ As DocPrintJob = Service.CreatePrintJob
	PJ.AddPrintJobListener(Me,"PrintJob")
	
	Dim Flavor As DocFlavor_INPUT_STREAM = DocFlavor_INPUT_STREAM_Fields.AUTOSENSE
	Dim Doc As SimpleDoc = NewInstanceJavax.SimpleDoc(IStream,Flavor,Null)
	
	Try
		PJ.Print(Me,Doc,Null)
	Catch
		IStream.Close
		Return LastException
	End Try
	
	Wait For Print_Complete(Result As String)
	IStream.Close
	
	Return Result
	
End Sub

Public Sub PrintJob_PrintJobEvent (MethodName As String, Event As PrintJobEvent)
	
	Select MethodName
		Case "printDataTransferCompleted"
			CallSub2(Me,"Print_Complete","FF OK")
		Case "printJobCanceled"
			CallSub2(Me,"Print_Complete","FF Cancelled")
			
		Case "printJobCompleted"
			CallSub2(Me,"Print_Complete","FF OK")
			
		Case "printJobFailed"
			CallSub2(Me,"Print_Complete","FF Failed")
			
		Case "printJobNoMoreEvents"
			CallSub2(Me,"Print_Complete","FF OK")
		Case "printJobRequiresAttention"
			Log(MethodName)
	End Select
	'#end if
End Sub