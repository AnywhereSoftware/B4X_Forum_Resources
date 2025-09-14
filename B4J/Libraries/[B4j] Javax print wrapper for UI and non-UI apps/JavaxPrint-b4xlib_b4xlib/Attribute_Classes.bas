B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
'Used to check if an atrribute exists in an Attribute set and retrieve the Attribute from a set.
Sub Process_Globals
	
End Sub

'Print Service
Public Sub ColorSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.ColorSupported")))
	Return Wrapper
End Sub
Public Sub PagesPerMinute As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PagesPerMinute")))
	Return Wrapper
End Sub
Public Sub PagesPerMinuteColor As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PagesPerMinuteColor")))
	Return Wrapper
End Sub
Public Sub PDLOverrideSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PDLOverrideSupported")))
	Return Wrapper
End Sub
Public Sub PrinterInfo As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterInfo")))
	Return Wrapper
End Sub
Public Sub PrinterIsAcceptingJobs As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterIsAcceptingJobs")))
	Return Wrapper
End Sub
Public Sub PrinterLocation As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterLocation")))
	Return Wrapper
End Sub
Public Sub PrinterMakeAndModel As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterMakeAndModel")))
	Return Wrapper
End Sub
Public Sub PrinterMessageFromOperator As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterMessageFromOperator")))
	Return Wrapper
End Sub
Public Sub PrinterMoreInfo As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterMoreInfo")))
	Return Wrapper
End Sub
Public Sub PrinterMoreInfoManufacturer As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterMoreInfoManufacturer")))
	Return Wrapper
End Sub
Public Sub PrinterName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterName")))
	Return Wrapper
End Sub
Public Sub PrinterState As Object
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterState")))
	Return Wrapper
End Sub
Public Sub PrinterStateReason As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterStateReason")))
	Return Wrapper
End Sub
Public Sub PrinterStateReasons As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterStateReasons")))
	Return Wrapper
End Sub
Public Sub PrinterURI As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterURI")))
	Return Wrapper
End Sub
Public Sub QueuedJobCount As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.QueuedJobCount")))
	Return Wrapper
End Sub

Public Sub JobImpressions As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobImpressions")))
	Return Wrapper
End Sub

Public Sub PrinterResolution As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrinterResolution")))
	Return Wrapper
End Sub

Public Sub JobPriority As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobPriority")))
	Return Wrapper
End Sub

Public Sub JobOriginatingUserName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobOriginatingUserName")))
	Return Wrapper
End Sub

Public Sub ReferenceUriSchemesSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.ReferenceUriSchemesSupported")))
	Return Wrapper
End Sub

Public Sub RequestingUserName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.RequestingUserName")))
	Return Wrapper
End Sub


Public Sub JobName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobName")))
	Return Wrapper
End Sub

Public Sub JobMessageFromOperator As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobMessageFromOperator")))
	Return Wrapper
End Sub

Public Sub JobMediaSheetsCompleted As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobMediaSheetsCompleted")))
	Return Wrapper
End Sub

Public Sub JobMediaSheetsSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobMediaSheetsSupported")))
	Return Wrapper
End Sub

Public Sub JobMediaSheets As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobMediaSheets")))
	Return Wrapper
End Sub

Public Sub JobKOctetsProcessed As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobKOctetsProcessed")))
	Return Wrapper
End Sub

Public Sub JobKOctetsSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobKOctetsSupported")))
	Return Wrapper
End Sub

Public Sub JobKOctets As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobKOctets")))
	Return Wrapper
End Sub

Public Sub JobImpressionsCompleted As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobImpressionsCompleted")))
	Return Wrapper
End Sub

Public Sub JobImpressionsSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobImpressionsSupported")))
	Return Wrapper
End Sub

Public Sub JobHoldUntil As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobHoldUntil")))
	Return Wrapper
End Sub

Public Sub Destination As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Destination")))
	Return Wrapper
End Sub

Public Sub DateTimeAtProcessing As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.DateTimeAtProcessing")))
	Return Wrapper
End Sub


Public Sub DateTimeAtCreation As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.DateTimeAtCreation")))
	Return Wrapper
End Sub

Public Sub DateTimeAtCompleted As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.DateTimeAtCompleted")))
	Return Wrapper
End Sub

Public Sub PageRanges As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PageRanges")))
	Return Wrapper
End Sub

Public Sub NumberOfDocuments As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.NumberOfDocuments")))
	Return Wrapper
End Sub

Public Sub NumberOfInterveningJobs As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.NumberOfInterveningJobs")))
	Return Wrapper
End Sub

Public Sub NumberUp As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.NumberUp")))
	Return Wrapper
End Sub

Public Sub NumberUpSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.NumberUpSupported")))
	Return Wrapper
End Sub

Public Sub DocumentName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.DocumentName")))
	Return Wrapper
End Sub

Public Sub DialogTypeSelection As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.DialogTypeSelection")))
	Return Wrapper
End Sub


Public Sub Copies As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Copies")))
	Return Wrapper
End Sub

Public Sub CopiesSupported As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.CopiesSupported")))
	Return Wrapper
End Sub


Public Sub Chromaticity As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Chromaticity")))
	Return Wrapper
End Sub

Public Sub Compression As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Compression")))
	Return Wrapper
End Sub

Public Sub Fidelity As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Fidelity")))
	Return Wrapper
End Sub

Public Sub Finishings As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Finishings")))
	Return Wrapper
End Sub

Public Sub JobSheets As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobSheets")))
	Return Wrapper
End Sub


Public Sub JobState As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobState")))
	Return Wrapper
End Sub

Public Sub JobStateReason As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobStateReason")))
	Return Wrapper
End Sub

Public Sub JobStateReasons As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.JobStateReasons")))
	Return Wrapper
End Sub

Public Sub Media As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Media")))
	Return Wrapper
End Sub

Public Sub MediaName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MediaName")))
	Return Wrapper
End Sub

Public Sub MediaSize As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MediaSize")))
	Return Wrapper
End Sub

Public Sub MediaTray As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MediaTray")))
	Return Wrapper
End Sub

Public Sub MediaSizeName As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MediaSizeName")))
	Return Wrapper
End Sub

Public Sub MultipleDocumentHandling As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MultipleDocumentHandling")))
	Return Wrapper
End Sub

Public Sub OrientationRequested As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.OrientationRequested")))
	Return Wrapper
End Sub


Public Sub OutputDeviceAssigned As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.OutputDeviceAssigned")))
	Return Wrapper
End Sub


Public Sub PresentationDirection As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PresentationDirection")))
	Return Wrapper
End Sub

Public Sub PrintQuality As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.PrintQuality")))
	Return Wrapper
End Sub

Public Sub ResolutionSyntax As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.ResolutionSyntax")))
	Return Wrapper
End Sub

Public Sub Severity As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Severity")))
	Return Wrapper
End Sub


Public Sub SheetCollate As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.SheetCollate")))
	Return Wrapper
End Sub

Public Sub Sides As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.Sides")))
	Return Wrapper
End Sub

Public Sub MediaPrintableArea As Class_Wrapper
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject( Tjo.RunMethod("forName",Array As Object("javax.print.attribute.standard.MediaPrintableArea")))
	Return Wrapper
End Sub

