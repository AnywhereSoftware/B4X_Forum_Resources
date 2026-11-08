B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mPJ As PrinterJob
	Private mPF As PageFormat
	Private mPaper1 As Paper
	Private mService As PrintService
	Private mPD As PageDimensions
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
	
'To print to the system default pinter add a printername attribute to the PrintServiceAttributeSet with the name "default"
Public Sub FindService (mPrintServiceAttSet As PrintServiceAttributeSet, mPrintRequestAttSet As PrintRequestAttributeSet, PD As PageDimensions) As String
	mPD = PD
	mPJ = PrinterJob_Static.GetPrinterJob


	If mPrintServiceAttSet.IsInitialized And mPrintServiceAttSet.ContainsKey(Attribute_Classes.PrinterName) Then

		If mPrintServiceAttSet.Get(Attribute_Classes.PrinterName).GetValue.As(String).ToLowerCase = "default" Then
			mPF = mPJ.DefaultPage
			
			If mPrintRequestAttSet.IsInitialized And mPrintRequestAttSet.ContainsKey(Attribute_Classes.Media) Then
				Dim MediaSizeName As Attribute = mPrintRequestAttSet.Get(Attribute_Classes.Media)
				Dim Size() As Float = Attributes.GetMediaSizeForName(MediaSizeName,Attributes.SIZE2DSYNTAX_MM)
				mPD.Width = JavaxPrint_Utils.MMToPPI(Size(0))
				mPD.Height = JavaxPrint_Utils.MMToPPI(Size(1))
				mPrintRequestAttSet.Remove(MediaSizeName)
			End If
			
			
			mPaper1 = NewInstanceJavax.Paper
			mPaper1.SetSize(mPD.Width,mPD.Height)
			mService = mPJ.GetPrintService
			
			mPrintServiceAttSet.Remove2(Attribute_Classes.PrinterName)
		Else
	
			Dim L As List = PrintServiceLookup.LookupPrintServices(Null,mPrintServiceAttSet)
			If L.Size = 0 Then
				Return "Printer not found"
			Else
				mService = L.Get(0)
			End If
	
			mPJ.SetPrintService(mService)
			mPF = mPJ.DefaultPage

			If mPrintRequestAttSet.IsInitialized And mPrintRequestAttSet.ContainsKey(Attribute_Classes.Media) Then
				Dim MediaSizeName As Attribute = mPrintRequestAttSet.Get(Attribute_Classes.Media)
				Dim Size() As Float = Attributes.GetMediaSizeForName(MediaSizeName,Attributes.SIZE2DSYNTAX_MM)
				mPD.Width = JavaxPrint_Utils.MMToPPI(Size(0))
				mPD.Height = JavaxPrint_Utils.MMToPPI(Size(1))
				mPrintRequestAttSet.Remove(MediaSizeName)
			End If
		
			mPaper1 = NewInstanceJavax.Paper
			mPaper1.SetSize(mPD.Width,mPD.Height)
	
		End If
	Else
		If mPJ.PrintDialog = False Then 
			Return "User Cancelled"
		End If
		mPF = mPJ.DefaultPage
		mPaper1 = mPF.GetPaper
		
		mPD.Width = mPF.GetPaper.GetWidth
		mPD.Height = mPF.GetPaper.GetHeight
		
		mService = mPJ.GetPrintService
	End If
	
	If mService.IsInitialized = False Then
		Return "No printer selected"
	End If
	
	Return ""
End Sub

Public Sub getPJ As PrinterJob
	Return mPJ
End Sub

Public Sub getPF As PageFormat
	Return mPF
End Sub

Public Sub getPaper1 As Paper
	Return mPaper1
End Sub

Public Sub getService As PrintService
	Return mService
End Sub

Public Sub getPageDimensions As PageDimensions
	Return mPD
End Sub

