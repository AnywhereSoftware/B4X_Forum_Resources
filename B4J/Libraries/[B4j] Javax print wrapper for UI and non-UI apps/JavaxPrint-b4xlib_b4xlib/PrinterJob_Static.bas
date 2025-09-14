B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
End Sub

'Creates and returns a PrinterJob which is initially associated with the default printer.
Public Sub GetPrinterJob As PrinterJob
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.print.PrinterJob")
	Dim Wrapper As PrinterJob
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("getPrinterJob",Null))
	Return Wrapper
End Sub

'A convenience method which looks up 2D print services.
Public Sub LookupPrintServices As List
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.print.PrinterJob")
	Dim Temp() As Object = Tjo1.RunMethod("lookupPrintServices",Null)
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As PrintService
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub
'A convenience method which locates factories for stream print services which can image 2D graphics.
Public Sub LookupStreamPrintServices(MimeType As String) As List
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.print.PrinterJob")
	Dim Temp() As Object = Tjo1.RunMethod("lookupStreamPrintServices",Array As Object(MimeType))
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As StreamPrintServiceFactory
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub