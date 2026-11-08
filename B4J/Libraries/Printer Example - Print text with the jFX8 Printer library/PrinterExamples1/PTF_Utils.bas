B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

'Inches to PPI
Public Sub INToPPI(Inches As Double) As Double
	Return Inches * 72
End Sub

'CM to PPI
Public Sub CMToPPI(Cm As Double) As Double
	Return INToPPI(Cm * 0.3937007874015748)
End Sub

'MM to PPI
Public Sub MMToPPI(mm As Double) As Double
	Return INToPPI(mm * 0.03937007874015748)
End Sub

Public Sub PPItoMM(PPI As Double) As Double
	Return PPI * 0.3527777777777778
End Sub

Public Sub LogAllPrinters
	Log("#### Printer Names ####")
	Dim L As List = Printer_Static.GetAllPrinters
	For Each P As Printer In L
		Log(P.GetName)
	Next
	Log("#######################")
End Sub

Public Sub LogSupportedPapersPPI(Ptr As Printer)
	Log("#### Supported Papers (PPI) ####")
	Dim L As List = Ptr.GetPrinterAttributes.GetSupportedPapers
	For Each P As Paper In L
		Log(P.GetName & " " & P.GetWidth & " x " & P.GetHeight)
	Next
	Log("##########################")
End Sub

Public Sub LogSupportedPapersMM(Ptr As Printer)
	Log("#### Supported Papers (MM) ####")
	Dim L As List = Ptr.GetPrinterAttributes.GetSupportedPapers
	For Each P As Paper In L
		Log(P.GetName & " " & Round(PPItoMM(P.GetWidth)) & " x " & Round(PPItoMM(P.GetHeight)))
	Next
	Log("###############################")
End Sub

Public Sub LogSuppotedResolutions(Ptr As Printer)
	Log("#### Supported PrintResolutions (PPI) ####")
	Dim L As List = Ptr.GetPrinterAttributes.GetSupportedPrintResolutions2
	For Each P As PrintResolution In L
		Log(P.FeedResolution & " x " & P.CrossFeedResolution)
	Next
	Log("##########################################")
End Sub

Public Sub GetPageLayoutInfo(PL As PageLayout) As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.append(PL.GetPaper.GetWidth).append(" x ").append(PL.GetPaper.GetHeight)	.append(" / ") _
	.append(PL.GetLeftMargin).append(" & ").append(PL.GetTopMargin).append(" & ").Append(PL.GetRightMargin).Append(" & ").Append(PL.GetBottomMargin).Append(" / ") _
	.append(PL.GetPrintableWidth).append(" x ").append(PL.GetPrintableHeight)
	Return SB.toString()
End Sub

Public Sub ScaleOutput(P As Printer,N As Node) As Node
	Dim PL As PageLayout = P.GetDefaultPageLayout
	Dim ScaleX,ScaleY As Double
	Dim NJO As JavaObject = N
	Dim JO As JavaObject = N
	ScaleX = PL.GetPrintableWidth / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getWidth",Null)
	ScaleY = PL.GetPrintableHeight / JO.RunMethodJO("getBoundsInParent",Null).RunMethod("getHeight",Null)
	Dim SJO As JavaObject
	SJO.InitializeNewInstance("javafx.scene.transform.Scale",Array(ScaleX,ScaleY))
	NJO.RunMethodJO("getTransforms",Null).RunMethod("add",Array(SJO))
	Return NJO
End Sub
