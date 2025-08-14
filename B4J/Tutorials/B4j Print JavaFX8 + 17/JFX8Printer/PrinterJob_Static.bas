B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Type PageRange(StartPage As Int,EndPage As Int)
	Type PrintResolution(CrossFeedResolution As Int,FeedResolution As Int)

End Sub
'Factory method to create a job.
Public Sub CreatePrinterJob As PrinterJob
	Dim PJO As JavaObject
	PJO.InitializeStatic("javafx.print.PrinterJob")
	Dim PJ As PrinterJob
	PJ.Initialize
	PJ.SetObject(PJO.RunMethod("createPrinterJob",Null))
	Return PJ
End Sub
'Factory method to create a job for a specified printer.
Public Sub CreatePrinterJob2(TPrinter As Printer) As PrinterJob
	Dim PJO As JavaObject
	PJO.InitializeStatic("javafx.print.PrinterJob")
	Dim PJ As PrinterJob
	PJ.Initialize
	PJ.SetObject(PJO.RunMethod("createPrinterJob",Array As Object(TPrinter.GetObject)))
	Return PJ
End Sub