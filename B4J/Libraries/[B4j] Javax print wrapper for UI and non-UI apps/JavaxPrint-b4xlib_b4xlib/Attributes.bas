B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
'MediaSize is not yet used to specify media. Its current role is as a mapping for named media (see MediaSizeName). 
'Clients can use the mapping method MediaSize.getMediaSizeForName(MediaSizeName) to find the physical dimensions of the 
'MediaSizeName instances enumerated in this API. This is useful for clients which need this information to format and paginate printing.
Sub Process_Globals

End Sub

'Color printing.
Public Sub CHROMATICITY_COLOR As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Chromaticity")
	Wrapper.SetObject(JO.GetField("COLOR"))
	Return Wrapper
End Sub

'Monochrome printing.
Public Sub CHROMATICITY_MONOCHROME As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Chromaticity")
	Wrapper.SetObject(JO.GetField("MONOCHROME"))
	Return Wrapper
End Sub

'UNIX compression technology.
Public Sub COMPRESSION_COMPRESS As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Compression")
	Wrapper.SetObject(JO.GetField("COMPRESS"))
	Return Wrapper
End Sub

'ZIP public domain inflate/deflate compression technology.
Public Sub COMPRESSION_DEFLATE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Compression")
	Wrapper.SetObject(JO.GetField("DEFLATE"))
	Return Wrapper
End Sub

'GNU zip compression technology described in RFC 1952.
Public Sub COMPRESSION_GZIP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Compression")
	Wrapper.SetObject(JO.GetField("GZIP"))
	Return Wrapper
End Sub

'No compression is used.
Public Sub COMPRESSION_NONE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Compression")
	Wrapper.SetObject(JO.GetField("NONE"))
	Return Wrapper
End Sub

'The printer should make reasonable attempts to print the job, even if it cannot print it exactly as specified.
Public Sub FIDELITY_FIDELITY_FALSE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Fidelity")
	Wrapper.SetObject(JO.GetField("FIDELITY_FALSE"))
	Return Wrapper
End Sub
'The job must be printed exactly as specified. or else rejected.
Public Sub FIDELITY_FIDELITY_TRUE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Fidelity")
	Wrapper.SetObject(JO.GetField("FIDELITY_TRUE"))
	Return Wrapper
End Sub

'This value indicates that a binding is to be applied to the document; the type and placement of the binding is site-defined.
Public Sub FINISHINGS_BIND As Attribute
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Return Tjo.GetField("BIND")
End Sub

'This value is specified when it is desired to select a non-printed (or pre-printed) cover for the document.
Public Sub FINISHINGS_COVER As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("COVER"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along one edge.
Public Sub FINISHINGS_EDGE_STITCH As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("EDGE_STITCH"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along the bottom edge.
Public Sub FINISHINGS_EDGE_STITCH_BOTTOM As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("EDGE_STITCH_BOTTOM"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along the left edge.
Public Sub FINISHINGS_EDGE_STITCH_LEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("EDGE_STITCH_LEFT"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along the right edge.
Public Sub FINISHINGS_EDGE_STITCH_RIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("EDGE_STITCH_RIGHT"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along the top edge.
Public Sub FINISHINGS_EDGE_STITCH_TOP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("EDGE_STITCH_TOP"))
	Return Wrapper
End Sub

'Perform no binding.
Public Sub FINISHINGS_NONE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("NONE"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples (wire stitches) along the middle fold.
Public Sub FINISHINGS_SADDLE_STITCH As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("SADDLE_STITCH"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples.
Public Sub FINISHINGS_STAPLE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples in the bottom left corner.
Public Sub FINISHINGS_STAPLE_BOTTOM_LEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_BOTTOM_LEFT"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples in the bottom right corner.
Public Sub FINISHINGS_STAPLE_BOTTOM_RIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_BOTTOM_RIGHT"))
	Return Wrapper
End Sub

'Bind the document(s) with two staples (wire stitches) along the bottom edge assuming a portrait document (see above).
Public Sub FINISHINGS_STAPLE_DUAL_BOTTOM As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_DUAL_BOTTOM"))
	Return Wrapper
End Sub

'Bind the document(s) with two staples (wire stitches) along the left edge assuming a portrait document (see above).
Public Sub FINISHINGS_STAPLE_DUAL_LEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_DUAL_LEFT"))
	Return Wrapper
End Sub

'Bind the document(s) with two staples (wire stitches) along the right edge assuming a portrait document (see above).
Public Sub FINISHINGS_STAPLE_DUAL_RIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_DUAL_RIGHT"))
	Return Wrapper
End Sub

'Bind the document(s) with two staples (wire stitches) along the top edge assuming a portrait document (see above).
Public Sub FINISHINGS_STAPLE_DUAL_TOP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_DUAL_TOP"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples in the top left corner.
Public Sub FINISHINGS_STAPLE_TOP_LEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_TOP_LEFT"))
	Return Wrapper
End Sub

'Bind the document(s) with one or more staples in the top right corner.
Public Sub FINISHINGS_STAPLE_TOP_RIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.attribute.standard.Finishings")
	Wrapper.SetObject(Tjo.GetField("STAPLE_TOP_RIGHT"))
	Return Wrapper
End Sub

'No job sheets are printed.
Public Sub JOBSHEETS_NONE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobSheets")
	Wrapper.SetObject(JO.GetField("NONE"))
	Return Wrapper
End Sub
'One or more site specific standard job sheets are printed. e.g. a single start sheet is printed, or both start and end sheets are printed.
Public Sub JOBSHEETS_STANDARD As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobSheets")
	Wrapper.SetObject(JO.GetField("STANDARD"))
	Return Wrapper
End Sub

'The job has been aborted by the system (usually while the job was in the PROCESSING or PROCESSING_STOPPED state), the printer has completed aborting the job, and all job status attributes have reached their final values for the job.
Public Sub JOBSTATE_ABORTED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("ABORTED"))
	Return Wrapper
End Sub
'The job has been canceled by some human agency, the printer has completed canceling the job, and all job status attributes have reached their final values for the job.
Public Sub JOBSTATE_CANCELED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("CANCELED"))
	Return Wrapper
End Sub
'The job has completed successfully or with warnings or errors after processing, all of the job media sheets have been successfully stacked in the appropriate output bin(s), and all job status attributes have reached their final values for the job.
Public Sub JOBSTATE_COMPLETED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("COMPLETED"))
	Return Wrapper
End Sub
'The job is a candidate to start processing, but is not yet processing.
Public Sub JOBSTATE_PENDING As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("PENDING"))
	Return Wrapper
End Sub
'The job is not a candidate for processing for any number of reasons but will Wrapper.SetObject to the PENDING state as soon as the reasons are no longer present.
Public Sub JOBSTATE_PENDING_HELD As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("PENDING_HELD"))
	Return Wrapper
End Sub
'The job is processing.
Public Sub JOBSTATE_PROCESSING As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("PROCESSING"))
	Return Wrapper
End Sub
'The job has stopped while processing for any number of reasons and will Wrapper.SetObject to the PROCESSING state as soon as the reasons are no longer present.
Public Sub JOBSTATE_PROCESSING_STOPPED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("PROCESSING_STOPPED"))
	Return Wrapper
End Sub
'The job state is unknown.
Public Sub JOBSTATE_UNKNOWN As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.JobState")
	Wrapper.SetObject(JO.GetField("UNKNOWN"))
	Return Wrapper
End Sub

'A4 transparency.
Public Sub MEDIANAME_ISO_A4_TRANSPARENT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaName")
	Wrapper.SetObject(JO.GetField("ISO_A4_TRANSPARENT"))
	Return Wrapper
End Sub
'white A4 paper.
Public Sub MEDIANAME_ISO_A4_WHITE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaName")
	Wrapper.SetObject(JO.GetField("ISO_A4_WHITE"))
	Return Wrapper
End Sub
'letter transparency.
Public Sub MEDIANAME_NA_LETTER_TRANSPARENT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaName")
	Wrapper.SetObject(JO.GetField("NA_LETTER_TRANSPARENT"))
	Return Wrapper
End Sub
'white letter paper.
Public Sub MEDIANAME_NA_LETTER_WHITE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaName")
	Wrapper.SetObject(JO.GetField("NA_LETTER_WHITE"))
	Return Wrapper
End Sub

'The bottom input tray in the printer.
Public Sub MEDIATRAY_BOTTOM As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("BOTTOM"))
	Return Wrapper
End Sub
'The envelope input tray in the printer.
Public Sub MEDIATRAY_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("ENVELOPE"))
	Return Wrapper
End Sub
'The large capacity input tray in the printer.
Public Sub MEDIATRAY_LARGE_CAPACITY As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("LARGE_CAPACITY"))
	Return Wrapper
End Sub
'The main input tray in the printer.
Public Sub MEDIATRAY_MAIN As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("MAIN"))
	Return Wrapper
End Sub
'The manual feed input tray in the printer.
Public Sub MEDIATRAY_MANUAL As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("MANUAL"))
	Return Wrapper
End Sub
'The middle input tray in the printer.
Public Sub MEDIATRAY_MIDDLE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("MIDDLE"))
	Return Wrapper
End Sub
'The side input tray.
Public Sub MEDIATRAY_SIDE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("SIDE"))
	Return Wrapper
End Sub
'The top input tray in the printer.
Public Sub MEDIATRAY_TOP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaTray")
	Wrapper.SetObject(JO.GetField("TOP"))
	Return Wrapper
End Sub

'Separate documents collated copies -- see above for further information.
Public Sub MULTIPLEDOCUMENTHANDLING_SEPARATE_DOCUMENTS_COLLATED_COPIES As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MultipleDocumentHandling")
	Wrapper.SetObject(JO.GetField("SEPARATE_DOCUMENTS_COLLATED_COPIES"))
	Return Wrapper
End Sub
'Separate documents uncollated copies -- see above for further information.
Public Sub MULTIPLEDOCUMENTHANDLING_SEPARATE_DOCUMENTS_UNCOLLATED_COPIES As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MultipleDocumentHandling")
	Wrapper.SetObject(JO.GetField("SEPARATE_DOCUMENTS_UNCOLLATED_COPIES"))
	Return Wrapper
End Sub
'Single document -- see above for further information.
Public Sub MULTIPLEDOCUMENTHANDLING_SINGLE_DOCUMENT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MultipleDocumentHandling")
	Wrapper.SetObject(JO.GetField("SINGLE_DOCUMENT"))
	Return Wrapper
End Sub
'Single document new sheet -- see above for further information.
Public Sub MULTIPLEDOCUMENTHANDLING_SINGLE_DOCUMENT_NEW_SHEET As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MultipleDocumentHandling")
	Wrapper.SetObject(JO.GetField("SINGLE_DOCUMENT_NEW_SHEET"))
	Return Wrapper
End Sub

'The content will be imaged across the long edge of the medium.
Public Sub ORIENTATIONREQUESTED_LANDSCAPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.OrientationRequested")
	Wrapper.SetObject(JO.GetField("LANDSCAPE"))
	Return Wrapper
End Sub
'The content will be imaged across the short edge of the medium.
Public Sub ORIENTATIONREQUESTED_PORTRAIT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.OrientationRequested")
	Wrapper.SetObject(JO.GetField("PORTRAIT"))
	Return Wrapper
End Sub
'The content will be imaged across the long edge of the medium, but in the opposite manner from landscape.
Public Sub ORIENTATIONREQUESTED_REVERSE_LANDSCAPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.OrientationRequested")
	Wrapper.SetObject(JO.GetField("REVERSE_LANDSCAPE"))
	Return Wrapper
End Sub
'The content will be imaged across the short edge of the medium, but in the opposite manner from portrait.
Public Sub ORIENTATIONREQUESTED_REVERSE_PORTRAIT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.OrientationRequested")
	Wrapper.SetObject(JO.GetField("REVERSE_PORTRAIT"))
	Return Wrapper
End Sub

'Pages are laid out in columns starting at the top right, proceeding towards the bottom & left.
Public Sub PRESENTATIONDIRECTION_TOBOTTOM_TOLEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOBOTTOM_TOLEFT"))
	Return Wrapper
End Sub
'Pages are laid out in columns starting at the top left, proceeding towards the bottom & right.
Public Sub PRESENTATIONDIRECTION_TOBOTTOM_TORIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOBOTTOM_TORIGHT"))
	Return Wrapper
End Sub
'Pages are laid out in rows starting at the top right, proceeding towards the left & bottom.
Public Sub PRESENTATIONDIRECTION_TOLEFT_TOBOTTOM As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOLEFT_TOBOTTOM"))
	Return Wrapper
End Sub
'Pages are laid out in rows starting at the bottom right, proceeding towards the left & top.
Public Sub PRESENTATIONDIRECTION_TOLEFT_TOTOP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOLEFT_TOTOP"))
	Return Wrapper
End Sub
'Pages are laid out in rows starting at the top left, proceeding towards the right & bottom.
Public Sub PRESENTATIONDIRECTION_TORIGHT_TOBOTTOM As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TORIGHT_TOBOTTOM"))
	Return Wrapper
End Sub
'Pages are laid out in rows starting at the bottom left, proceeding towards the right & top.
Public Sub PRESENTATIONDIRECTION_TORIGHT_TOTOP As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TORIGHT_TOTOP"))
	Return Wrapper
End Sub
'Pages are laid out in columns starting at the bottom right, proceeding towards the top & left.
Public Sub PRESENTATIONDIRECTION_TOTOP_TOLEFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOTOP_TOLEFT"))
	Return Wrapper
End Sub
'Pages are laid out in columns starting at the bottom left, proceeding towards the top & right.
Public Sub PRESENTATIONDIRECTION_TOTOP_TORIGHT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PresentationDirection")
	Wrapper.SetObject(JO.GetField("TOTOP_TORIGHT"))
	Return Wrapper
End Sub

'Lowest quality available on the printer.
Public Sub PRINTQUALITY_DRAFT As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PrintQuality")
	Wrapper.SetObject(JO.GetField("DRAFT"))
	Return Wrapper
End Sub
'Highest quality available on the printer.
Public Sub PRINTQUALITY_HIGH As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PrintQuality")
	Wrapper.SetObject(JO.GetField("HIGH"))
	Return Wrapper
End Sub
'Normal or intermediate quality on the printer.
Public Sub PRINTQUALITY_NORMAL As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.PrintQuality")
	Wrapper.SetObject(JO.GetField("NORMAL"))
	Return Wrapper
End Sub

'Value to indicate units of dots per centimeter (dpcm).
Public Sub RESOLUTIONSYNTAX_DPCM As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.ResolutionSyntax")
	Return JO.GetField("DPCM")
End Sub
'Value to indicate units of dots per inch (dpi).
Public Sub RESOLUTIONSYNTAX_DPI As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.ResolutionSyntax")
	Return JO.GetField("DPI")
End Sub

'Sheets within a document appear in collated order when multiple copies are printed.
Public Sub SHEETCOLLATE_COLLATED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.SheetCollate")
	Wrapper.SetObject(JO.GetField("COLLATED"))
	Return Wrapper
End Sub
'Sheets within a document appear in uncollated order when multiple copies are printed.
Public Sub SHEETCOLLATE_UNCOLLATED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.SheetCollate")
	Wrapper.SetObject(JO.GetField("UNCOLLATED"))
	Return Wrapper
End Sub

'An alias for "two sided long edge" (see TWO_SIDED_LONG_EDGE).
Public Sub SIDES_DUPLEX As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Sides")
	Wrapper.SetObject(JO.GetField("DUPLEX"))
	Return Wrapper
End Sub
'Imposes each consecutive print-stream page upon the same side of consecutive media sheets.
Public Sub SIDES_ONE_SIDED As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Sides")
	Wrapper.SetObject(JO.GetField("ONE_SIDED"))
	Return Wrapper
End Sub
'An alias for "two sided short edge" (see TWO_SIDED_SHORT_EDGE).
Public Sub SIDES_TUMBLE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Sides")
	Wrapper.SetObject(JO.GetField("TUMBLE"))
	Return Wrapper
End Sub
'Imposes each consecutive pair of print-stream pages upon front and back sides of consecutive media sheets, such that the orientation of each pair of print-stream pages on the medium would be correct for the reader as if for binding on the long edge.
Public Sub SIDES_TWO_SIDED_LONG_EDGE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Sides")
	Wrapper.SetObject(JO.GetField("TWO_SIDED_LONG_EDGE"))
	Return Wrapper
End Sub
'Imposes each consecutive pair of print-stream pages upon front and back sides of consecutive media sheets, such that the orientation of each pair of print-stream pages on the medium would be correct for the reader as if for binding on the short edge.
Public Sub SIDES_TWO_SIDED_SHORT_EDGE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.Sides")
	Wrapper.SetObject(JO.GetField("TWO_SIDED_SHORT_EDGE"))
	Return Wrapper
End Sub
'Value to indicate units of inches (in).
Public Sub MEDIAPRINTABLEAREA_INCH As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaPrintableArea")
	Return JO.GetField("INCH")
End Sub
'Value to indicate units of millimeters (mm).
Public Sub MEDIAPRINTABLEAREA_MM As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaPrintableArea")
	Return JO.GetField("MM")
End Sub

Public Sub SIZE2DSYNTAX_INCH As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.Size2DSyntax")
	Return JO.GetField("INCH")
End Sub

Public Sub SIZE2DSYNTAX_MM As Int
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.Size2DSyntax")
	Return JO.GetField("MM")
End Sub

'Attributes with parameters

'Copies - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/Copies.html#%3Cinit%3E(int)</link>
'    <code>Attributes.Copies(4)</code>
Public Sub Copies(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.Copies",Array As Object(Value)))
	Return Wrapper
End Sub

'Constructs a new document name attribute with the given document name and locale.
Public Sub DocumentName(DoctName As String, Locale As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeNewInstance("javax.print.attribute.standard.DocumentName",Array As Object(DoctName, Locale))
	Wrapper.SetObject(Tjo)
	Return Wrapper
End Sub

'Class NumberUp is an integer valued printing attribute class that specifies the number of print-stream pages 
'to impose upon a single side of an instance of a selected medium. That is, if the NumberUp value is n, the printer 
'must place n print-stream pages on a single side of an instance of the selected medium. To accomplish this, the printer may add some sort of translation, scaling, or rotation. This attribute primarily controls the translation, scaling and rotation of print-stream pages.
Public Sub NumberUp(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeNewInstance("javax.print.attribute.standard.NumberUp",Array As Object(Value))
	Wrapper.SetObject(Tjo)
	Return Wrapper
End Sub

'PageRanges - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/PageRanges.html#%3Cinit%3E(int)</link>
'    <code>Attributes.PageRanges("1-3")</code>
Public Sub PageRanges(Pages As String) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeNewInstance("javax.print.attribute.standard.PageRanges",Array As Object(Pages))
	Wrapper.SetObject(Tjo)
	Return Wrapper
End Sub

'DateTimeAtCompleted - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/DateTimeAtCompleted.html#%3Cinit%3E(int)</link>
'    <code>DateTime.DateFormat = "dd/MM/yyyy" 'You only need to set DateFormat once for the app
'    Dim LongDate As Long = DateTime.DateParse("30/09/2022")</code>
Public Sub DateTimeAtCompleted(LongDate As Long) As Attribute
	
	Dim Date As JavaObject
	Date.InitializeNewInstance("java.util.Date",Array(LongDate))
	
	Dim Attr As Attribute
	Attr.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.DateTimeAtCompleted",Array As Object(Date))
	Attr.SetObject(JO)
	Return Attr
End Sub

'DateTimeAtCompleted - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/DateTimeAtCompleted.html#%3Cinit%3E(int)</link>
'    <code>DateTime.DateFormat = "dd/MM/yyyy" 'You only need to set DateFormat once for the app
'    Dim LongDate As Long = DateTime.DateParse("30/09/2022")</code>
Public Sub DateTimeAtCreation(LongDate As Long) As Attribute
	
	Dim Date As JavaObject
	Date.InitializeNewInstance("java.util.Date",Array(LongDate))
	
	Dim Attr As Attribute
	Attr.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.DateTimeCompletedAt",Array As Object(Date))
	Attr.SetObject(JO)
	Return Attr
End Sub

'DateTimeAtProcessing - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/DateTimeAtProcessing.html#%3Cinit%3E(int)</link>
'   <code>DateTime.DateFormat = "dd/MM/yyyy" 'You only need to set DateFormat once for the app
'   Dim Date As Long = DateTime.DateParse("30/09/2022")
'	Attributes.DateTimeAtProcessing(Date)</code>
Public Sub DateTimeAtProcessing(LongDate As Long) As Attribute
	
	Dim Date As JavaObject
	Date.InitializeNewInstance("java.util.Date",Array(LongDate))
	
	Dim Attr As Attribute
	Attr.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.DateTimeAtProcessing",Array As Object(Date))
	Attr.SetObject(JO)
	Return Attr
End Sub

'Destination - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/Destination.html#%3Cinit%3E(int)</link>
'    Class Destination is a printing attribute class, a URI, that is used to indicate an alternate destination for the spooled printer
'    formatted data. Many PrintServices will not support the notion of a destination other than the printer device, 
'    and so will not support this attribute.
'    <code>Attributes.Destination(File.GetUri("D:\","file.txt"))</code>
Public Sub Destination(Path As String) As Attribute
	Dim URI As JavaObject
	URI.InitializeNewInstance("java.net.URI",Array(Path))
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeNewInstance("javax.print.attribute.standard.Destination",Array As Object(URI))
	Wrapper.SetObject(Tjo)
	Return Wrapper
End Sub

'Destination_File - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/Destination.html#%3Cinit%3E(int)</link>
'Convienience Method to set a file as the destination. Replacement for
'    <code>Attributes.Destination("D:\file.txt")</code>
Public Sub Destination_File(FilePath As String,FileName As String) As Attribute
	Dim URI As JavaObject
	URI.InitializeNewInstance("java.net.URI",Array(File.GetUri("",File.Combine(FilePath,FileName))))
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeNewInstance("javax.print.attribute.standard.Destination",Array As Object(URI))
	Wrapper.SetObject(Tjo)
	Return Wrapper
End Sub

'JobHoldUntil - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobHoldUntil.html#%3Cinit%3E(int)</link>
'    <code>DateTime.DateFormat = "dd/MM/yyyy" 'You only need to set DateFormat once for the app
'    Dim Date As Long = DateTime.DateTimeParse("28/09/2022","15:00:00")
'    Attributes.JobHoldUntil​(Date)</code>
Public Sub JobHoldUntil(LongDate As Long) As Attribute
	
	Dim Date As JavaObject
	Date.InitializeNewInstance("java.util.Date",Array(LongDate))
	
	Dim Attr As Attribute
	Attr.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.JobHoldUntil",Array As Object(Date))
	Attr.SetObject(JO)
	Return Attr
End Sub

'JobImpressions - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobImpressions.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobImpressions​(3)</code>
Public Sub JobImpressions(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobImpressions",Array As Object(Value)))
	Return Wrapper
End Sub

'JobImpressionsCompleted - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobImpressionsCompleted.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobImpressionsCompleted​(3)</code>
Public Sub JobImpressionsCompleted(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobImpressionsCompleted",Array As Object(Value)))
	Return Wrapper
End Sub

'JobKOctets - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobKOctets.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobKOctets​(1024)</code>
Public Sub JobKOctets(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobKOctets",Array As Object(Value)))
	Return Wrapper
End Sub

'JobKOctetsProcessed - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobKOctetsProcessed.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobKOctetsProcessed​(1024)</code>
Public Sub JobKOctetsProcessed(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobKOctetsProcessed",Array As Object(Value)))
	Return Wrapper
End Sub

'JobMediaSheets - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobMediaSheets.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobMediaSheets​(1024)</code>
Public Sub JobMediaSheets(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobMediaSheets",Array As Object(Value)))
	Return Wrapper
End Sub

'JobMediaSheetsCompleted - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobMediaSheetsCompleted.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobMediaSheets​Completed(1024)</code>
Public Sub JobMediaSheetsCompleted(Value As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobMediaSheetsCompleted",Array As Object(Value)))
	Return Wrapper
End Sub

'JobMessageFromOperator - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobMessageFromOperator.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobMessageFromOperator("Msg from Operator",Null)</code> '2nd argument Locale can be Null or JavaxPrint_Utils.GetCurrentLocale
Public Sub JobMessageFromOperator(Msg As String, Locale As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobMessageFromOperator",Array As Object(Msg,Locale)))
	Return Wrapper
End Sub

'JobName - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobName.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobName("jPrintTest",JavaxPrint_Utils.GetCurrentLocale)</code> '2nd argument Locale can be Null
Public Sub JobName(Name As String, Locale As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobName",Array As Object(Name, Locale)))
	Return Wrapper
End Sub

'PrinterName - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/PrinterName.html#%3Cinit%3E(int)</link>
'     <code>Attributes.PrinterName("Microsoft Print to PDF",JavaxPrint_Utils.GetCurrentLocale)</code> '2nd argument Locale can be Null
Public Sub PrinterName(Name As String,Locale As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.PrinterName",Array As Object(Name, Locale)))
	Return Wrapper
End Sub

'RequestingUserName - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/RequestingUserName.html%3E(int)</link>
'<code>Attributes.RequestingUserName("Stevel05",JavaxPrint_Utils.GetCurrentLocale)</code> '2nd argument Locale can be Null
Public Sub RequestingUserName(Name As String,Locale As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.RequestingUserName",Array As Object(Name, Locale)))
	Return Wrapper
End Sub

'JobOriginatingUserName - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobOriginatingUserName.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobOriginatingUserName("Stevel05",Null)</code> '2nd argument Locale can be Null
Public Sub JobOriginatingUserName(Name As String) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobOriginatingUserName",Array As Object(Name)))
	Return Wrapper
End Sub

'JobPriority - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/JobPriority.html#%3Cinit%3E(int)</link>
'     <code>Attributes.JobPriority(50)</code> Valid Values 1 - 100</code>
Public Sub JobPriority(Priority As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.JobPriority",Array As Object(Priority)))
	Return Wrapper
End Sub

'PrinterResolution - <link>JavaDoc|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/standard/PrinterResolution.html#%3Cinit%3E(int)</link>
'    <code>Attributes.PrinterResolution(300,300,Attributes.RESOLUTIONSYNTAX_DPI)</code>
Public Sub PrinterResolution(CrossFeedResolution As Int, FeedResolution As Int, Units As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim TJO As JavaObject
	Wrapper.SetObject(TJO.InitializeNewInstance("javax.print.attribute.standard.PrinterResolution",Array As Object(CrossFeedResolution,FeedResolution,Units )))
	Return Wrapper
End Sub

'Constructed without any arguments it will request that a print or page setup dialog be configured as if the application directly was to specify java.awt.Window.setAlwaysOnTop(true), subject to permission checks.
'    <code>Attributes.DialogOwner")</code>
Public Sub DIALOGOWNER As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.DialogOwner",Null)
	Wrapper.SetObject(JO)
	Return Wrapper
End Sub
Public Sub DialogOwner2(Owner As Object) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.DialogOwner",Array(Owner))
	Wrapper.SetObject(JO)
	Return Wrapper
End Sub



'Class DialogTypeSelection is a printing attribute class, an enumeration, that indicates the user dialog type 
'to be used for specifying printing options. If NATIVE is specified, then where available, 
'a native platform dialog is displayed. If COMMON is specified, a cross-platform print dialog is displayed.
Public Sub DIALOGTYPESELECTION_COMMON As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.DialogTypeSelection")
	Wrapper.SetObject(JO.GetField("COMMON"))
	Return Wrapper
End Sub

'Class DialogTypeSelection is a printing attribute class, an enumeration, that indicates the user dialog type 
'to be used for specifying printing options. If NATIVE is specified, then where available, 
'a native platform dialog is displayed. If COMMON is specified, a cross-platform print dialog is displayed.
Public Sub DIALOGTYPESELECTION_NATIVE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.DialogTypeSelection")
	Wrapper.SetObject(JO.GetField("NATIVE"))
	Return Wrapper
End Sub

'Class MediaPrintableArea is a printing attribute used to distinguish the printable and non-printable areas of media.
'	<code>Attributes.MediaPrintableArea(10,10,200,300,Attributes.MEDIAPRINTABLEAREA_MM</code>
Public Sub MediaPrintableArea(X As Float, Y As Float, W  As Float, H As Float, Units As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeNewInstance("javax.print.attribute.standard.MediaPrintableArea",Array(X,Y,W,H,Units))
	Wrapper.SetObject(JO)
	Return Wrapper
End Sub

'ReadOnlyAttributes

'PrintServiceAttribute
Public Sub COLORSUPPORTED_NOT_SUPPORTED As Int
	Dim Jo As JavaObject
	Jo.InitializeStatic("javax.print.attribute.standard.ColorSupported")
	Return Jo.GetField("NOT_SUPPORTED")
End Sub

'PrintServiceAttribute
Public Sub COLORSUPPORTED_SUPPORTED As Int
	Dim Jo As JavaObject
	Jo.InitializeStatic("javax.print.attribute.standard.ColorSupported")
	Return Jo.GetField("SUPPORTED")
End Sub

'PrintServiceAttribute
Public Sub PDLOVERRIDESUPPORTED_ATTEMPTED As Int
	Dim Jo As JavaObject
	Jo.InitializeStatic("javax.print.attribute.standard.ColorSupported")
	Return Jo.GetField("ATTEMPTED")
End Sub

'PrintServiceAttribute
Public Sub PDLOVERRIDESUPPORTED_NOT_ATTEMPTED As Int
	Dim Jo As JavaObject
	Jo.InitializeStatic("javax.print.attribute.standard.ColorSupported")
	Return Jo.GetField("NOT_ATTEMPTED")
End Sub


'Utility subs

'Gets the value of an attribute.  The attribute must support a value field.
'Useful for querying attributes returnd from querying the printer info.
Public Sub GetAttributeValue(Attr As Object) As Object
	If JavaxPrint_Utils.IsPackageObject(Attr)Then	Attr = CallSub(Attr,"GetObject")
	Return Attr.As(JavaObject).RunMethod("getValue",Null)
End Sub

'Returns a string value corresponding to this enumeration value.
Public Sub AttributeToString(Attr As Object) As String
	If JavaxPrint_Utils.IsPackageObject(Attr)Then	Attr = CallSub(Attr,"GetObject")
	Return Attr.As(JavaObject).RunMethod("tostring",Null)
End Sub


'The specified dimensions are used to locate a matching MediaSize instance from amongst all the standard MediaSize instances. 
'If there is no exact match, the closest match is used.
'<code>MediaSize_Static.FindMediaSizeName(210,297,Attributes.SIZE2DSYNTAX_MM)</code>
Public Sub FindMediaSizeName(X As Float, Y As Float, Units As Int) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSize")
	Wrapper.SetObject(JO.RunMethod("findMedia",Array(X,Y,Units)))
	Return Wrapper
End Sub

'<code>MediaSize_Static.GetMediaSizeForName(MediaSizeName,Attributes.SIZE2DSYNTAX_MM)</code>
Public Sub GetMediaSizeForName(MediaSizeName As Attribute, Units As Int) As Float()
	Dim MediaSizeClass As JavaObject
	MediaSizeClass.InitializeStatic("javax.print.attribute.standard.MediaSize")
	Return MediaSizeClass.RunMethodJO("getMediaSizeForName",Array(MediaSizeName.GetObject)).RunMethod("getSize",Array(Units))
End Sub


'MEDIASIZENAME

'A size .
Public Sub MEDIASIZENAME_A As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("A"))
	Return Wrapper
End Sub
'B size .
Public Sub MEDIASIZENAME_B As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("B"))
	Return Wrapper
End Sub
'C size .
Public Sub MEDIASIZENAME_C As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("C"))
	Return Wrapper
End Sub
'D size .
Public Sub MEDIASIZENAME_D As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("D"))
	Return Wrapper
End Sub
'E size .
Public Sub MEDIASIZENAME_E As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("E"))
	Return Wrapper
End Sub
'executive size .
Public Sub MEDIASIZENAME_EXECUTIVE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("EXECUTIVE"))
	Return Wrapper
End Sub
'folio size .
Public Sub MEDIASIZENAME_FOLIO As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("FOLIO"))
	Return Wrapper
End Sub
'invoice size .
Public Sub MEDIASIZENAME_INVOICE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("INVOICE"))
	Return Wrapper
End Sub
'A0 size.
Public Sub MEDIASIZENAME_ISO_A0 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A0"))
	Return Wrapper
End Sub
'A1 size.
Public Sub MEDIASIZENAME_ISO_A1 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A1"))
	Return Wrapper
End Sub
'A10 size.
Public Sub MEDIASIZENAME_ISO_A10 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A10"))
	Return Wrapper
End Sub
'A2 size.
Public Sub MEDIASIZENAME_ISO_A2 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A2"))
	Return Wrapper
End Sub
'A3 size.
Public Sub MEDIASIZENAME_ISO_A3 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A3"))
	Return Wrapper
End Sub
'A4 size.
Public Sub MEDIASIZENAME_ISO_A4 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A4"))
	Return Wrapper
End Sub
'A5 size.
Public Sub MEDIASIZENAME_ISO_A5 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A5"))
	Return Wrapper
End Sub
'A6 size.
Public Sub MEDIASIZENAME_ISO_A6 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A6"))
	Return Wrapper
End Sub
'A7 size.
Public Sub MEDIASIZENAME_ISO_A7 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A7"))
	Return Wrapper
End Sub
'A8 size.
Public Sub MEDIASIZENAME_ISO_A8 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A8"))
	Return Wrapper
End Sub
'A9 size.
Public Sub MEDIASIZENAME_ISO_A9 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_A9"))
	Return Wrapper
End Sub
'ISO B0 size.
Public Sub MEDIASIZENAME_ISO_B0 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B0"))
	Return Wrapper
End Sub
'ISO B1 size.
Public Sub MEDIASIZENAME_ISO_B1 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B1"))
	Return Wrapper
End Sub
'ISO B10 size.
Public Sub MEDIASIZENAME_ISO_B10 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B10"))
	Return Wrapper
End Sub
'ISO B2 size.
Public Sub MEDIASIZENAME_ISO_B2 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B2"))
	Return Wrapper
End Sub
'ISO B3 size.
Public Sub MEDIASIZENAME_ISO_B3 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B3"))
	Return Wrapper
End Sub
'ISO B4 size.
Public Sub MEDIASIZENAME_ISO_B4 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B4"))
	Return Wrapper
End Sub
'ISO B5 size.
Public Sub MEDIASIZENAME_ISO_B5 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B5"))
	Return Wrapper
End Sub
'ISO B6 size.
Public Sub MEDIASIZENAME_ISO_B6 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B6"))
	Return Wrapper
End Sub
'ISO B7 size.
Public Sub MEDIASIZENAME_ISO_B7 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B7"))
	Return Wrapper
End Sub
'ISO B8 size.
Public Sub MEDIASIZENAME_ISO_B8 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B8"))
	Return Wrapper
End Sub
'ISO B9 size.
Public Sub MEDIASIZENAME_ISO_B9 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_B9"))
	Return Wrapper
End Sub
'ISO C0 size.
Public Sub MEDIASIZENAME_ISO_C0 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C0"))
	Return Wrapper
End Sub
'ISO C1 size.
Public Sub MEDIASIZENAME_ISO_C1 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C1"))
	Return Wrapper
End Sub
'ISO C2 size.
Public Sub MEDIASIZENAME_ISO_C2 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C2"))
	Return Wrapper
End Sub
'ISO C3 size.
Public Sub MEDIASIZENAME_ISO_C3 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C3"))
	Return Wrapper
End Sub
'ISO C4 size.
Public Sub MEDIASIZENAME_ISO_C4 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C4"))
	Return Wrapper
End Sub
'ISO C5 size.
Public Sub MEDIASIZENAME_ISO_C5 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C5"))
	Return Wrapper
End Sub
'letter size.
Public Sub MEDIASIZENAME_ISO_C6 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_C6"))
	Return Wrapper
End Sub
'ISO designated long size .
Public Sub MEDIASIZENAME_ISO_DESIGNATED_LONG As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ISO_DESIGNATED_LONG"))
	Return Wrapper
End Sub
'Italy envelope size .
Public Sub MEDIASIZENAME_ITALY_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("ITALY_ENVELOPE"))
	Return Wrapper
End Sub
'Japanese Double Postcard size.
Public Sub MEDIASIZENAME_JAPANESE_DOUBLE_POSTCARD As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JAPANESE_DOUBLE_POSTCARD"))
	Return Wrapper
End Sub
'Japanese Postcard size.
Public Sub MEDIASIZENAME_JAPANESE_POSTCARD As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JAPANESE_POSTCARD"))
	Return Wrapper
End Sub
'JIS B0 size.
Public Sub MEDIASIZENAME_JIS_B0 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B0"))
	Return Wrapper
End Sub
'JIS B1 size.
Public Sub MEDIASIZENAME_JIS_B1 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B1"))
	Return Wrapper
End Sub
'JIS B10 size.
Public Sub MEDIASIZENAME_JIS_B10 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B10"))
	Return Wrapper
End Sub
'JIS B2 size.
Public Sub MEDIASIZENAME_JIS_B2 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B2"))
	Return Wrapper
End Sub
'JIS B3 size.
Public Sub MEDIASIZENAME_JIS_B3 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B3"))
	Return Wrapper
End Sub
'JIS B4 size.
Public Sub MEDIASIZENAME_JIS_B4 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B4"))
	Return Wrapper
End Sub
'JIS B5 size.
Public Sub MEDIASIZENAME_JIS_B5 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B5"))
	Return Wrapper
End Sub
'JIS B6 size.
Public Sub MEDIASIZENAME_JIS_B6 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B6"))
	Return Wrapper
End Sub
'JIS B7 size.
Public Sub MEDIASIZENAME_JIS_B7 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B7"))
	Return Wrapper
End Sub
'JIS B8 size.
Public Sub MEDIASIZENAME_JIS_B8 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B8"))
	Return Wrapper
End Sub
'JIS B9 size.
Public Sub MEDIASIZENAME_JIS_B9 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("JIS_B9"))
	Return Wrapper
End Sub
'ledger size .
Public Sub MEDIASIZENAME_LEDGER As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("LEDGER"))
	Return Wrapper
End Sub
'monarch envelope size .
Public Sub MEDIASIZENAME_MONARCH_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("MONARCH_ENVELOPE"))
	Return Wrapper
End Sub
'10x13 North American envelope size .
Public Sub MEDIASIZENAME_NA_10X13_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_10X13_ENVELOPE"))
	Return Wrapper
End Sub
'10x14North American envelope size .
Public Sub MEDIASIZENAME_NA_10X14_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_10X14_ENVELOPE"))
	Return Wrapper
End Sub
'10x15 North American envelope size.
Public Sub MEDIASIZENAME_NA_10X15_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_10X15_ENVELOPE"))
	Return Wrapper
End Sub
'5x7 North American paper.
Public Sub MEDIASIZENAME_NA_5X7 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_5X7"))
	Return Wrapper
End Sub
'6x9 North American envelope size.
Public Sub MEDIASIZENAME_NA_6X9_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_6X9_ENVELOPE"))
	Return Wrapper
End Sub
'7x9 North American envelope size.
Public Sub MEDIASIZENAME_NA_7X9_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_7X9_ENVELOPE"))
	Return Wrapper
End Sub
'8x10 North American paper.
Public Sub MEDIASIZENAME_NA_8X10 As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_8X10"))
	Return Wrapper
End Sub
'9x11 North American envelope size.
Public Sub MEDIASIZENAME_NA_9X11_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_9X11_ENVELOPE"))
	Return Wrapper
End Sub
'9x12 North American envelope size.
Public Sub MEDIASIZENAME_NA_9X12_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_9X12_ENVELOPE"))
	Return Wrapper
End Sub
'legal size .
Public Sub MEDIASIZENAME_NA_LEGAL As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_LEGAL"))
	Return Wrapper
End Sub
'letter size.
Public Sub MEDIASIZENAME_NA_LETTER As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_LETTER"))
	Return Wrapper
End Sub
'number 10 envelope size .
Public Sub MEDIASIZENAME_NA_NUMBER_10_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_NUMBER_10_ENVELOPE"))
	Return Wrapper
End Sub
'number 11 envelope size .
Public Sub MEDIASIZENAME_NA_NUMBER_11_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_NUMBER_11_ENVELOPE"))
	Return Wrapper
End Sub
'number 12 envelope size .
Public Sub MEDIASIZENAME_NA_NUMBER_12_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_NUMBER_12_ENVELOPE"))
	Return Wrapper
End Sub
'number 14 envelope size .
Public Sub MEDIASIZENAME_NA_NUMBER_14_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_NUMBER_14_ENVELOPE"))
	Return Wrapper
End Sub
'number 9 envelope size .
Public Sub MEDIASIZENAME_NA_NUMBER_9_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("NA_NUMBER_9_ENVELOPE"))
	Return Wrapper
End Sub
'personal envelope size .
Public Sub MEDIASIZENAME_PERSONAL_ENVELOPE As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("PERSONAL_ENVELOPE"))
	Return Wrapper
End Sub
'quarto size .
Public Sub MEDIASIZENAME_QUARTO As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("QUARTO"))
	Return Wrapper
End Sub
'tabloid size .
Public Sub MEDIASIZENAME_TABLOID As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javax.print.attribute.standard.MediaSizeName")
	Wrapper.SetObject(JO.GetField("TABLOID"))
	Return Wrapper
End Sub

