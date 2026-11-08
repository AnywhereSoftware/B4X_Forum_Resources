B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mDocAttSet As DocAttributeSet
	Private PJ As DocPrintJob
	Private mPrintRequestAttSet As PrintRequestAttributeSet
	Private mPrintServiceAttSet As PrintServiceAttributeSet
	Private mImageFileName As String
	Private TopPageMargin, LeftPageMargin, RightPageMargin, BottomPageMargin As Double
	Private DSS As DocPrintJobServiceSelection
	Private mRequireFormFeed As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	TopPageMargin = 25.4
	LeftPageMargin = 25.4
	RightPageMargin = 25.4
	BottomPageMargin = 25.4
	DSS.Initialize
End Sub

	
Public Sub SetPrintRequestAttributeSet(PrintRequestAttSet As PrintRequestAttributeSet)
	mPrintRequestAttSet = PrintRequestAttSet
End Sub

Public Sub SetDocAttributeSet(DocAttSet As DocAttributeSet)
	mDocAttSet = DocAttSet
End Sub

Public Sub SetPrintServiceAttributeSet(PrintServiceAttSet As PrintServiceAttributeSet)
	mPrintServiceAttSet = PrintServiceAttSet
End Sub

Public Sub SetImageFileName(FullFileName As String)
	mImageFileName = FullFileName
End Sub


Public Sub GetPrintJob As DocPrintJob
	Return PJ
End Sub

Public Sub RequireFormFeed(Require As Boolean)
	mRequireFormFeed = Require
End Sub



'Set page margins in MM
'<code>PL.SetPageMargins(10,15,10,15)</code>
'Default Values 25.4,25.4.25.4,25.4
Public Sub SetPageMargins(Left As Double, Top As Double, Right As Double, Bottom As Double)
	LeftPageMargin = Left
	TopPageMargin = Top
	RightPageMargin = Right
	BottomPageMargin = Bottom
End Sub

Public Sub Print As ResumableSub
	'
	'Get the correct print flavor for the file to print.
	'
	Dim Flavor As DocFlavor_INPUT_STREAM
	If mImageFileName.Length = 0 Or mImageFileName.LastIndexOf(".") = -1 Then Return "Invalid Image Filename"
	Dim Extn As String = mImageFileName.ToLowerCase.SubString(mImageFileName.LastIndexOf(".") + 1)
	Select Extn
		Case "jpg","jpeg"
			Flavor = DocFlavor_INPUT_STREAM_Fields.JPEG
		Case "png"
			Flavor = DocFlavor_INPUT_STREAM_Fields.PNG
		Case "gif"
			Flavor = DocFlavor_INPUT_STREAM_Fields.GIF
		Case Else
			Return "Image File Extension Not Supported"
	End Select

	'
	'Find a printer capable of printing in line with the passed attributes and flavor.
	'
	Dim Message As String
	#If Debug
	Message = DSS.FindService_NoThread(mPrintServiceAttSet,mPrintRequestAttSet,Flavor)
	#else
	Wait For (DSS.FindService(mPrintServiceAttSet,mPrintRequestAttSet,Flavor)) Complete (Message As String)
	#End If

	If Message <> "" Then Return Message
	
	Log("Print Image Printer " &  DSS.Service.GetName)

	'################################
	
	'
	'Prepare Data
	'
	Dim IStream As InputStream
	If mImageFileName.StartsWith("AssetsDir") Then
		IStream = File.OpenInput(File.DirAssets,File.GetName(mImageFileName))
	Else
		IStream = File.OpenInput("",mImageFileName)
	End If
	
	'
	' Create A SimpleDoc
	'
	Dim Doc As SimpleDoc
	If mDocAttSet.IsInitialized = False Then mDocAttSet = NewInstanceJavax.DocAttributeSet
	If mDocAttSet.ContainsKey(Attribute_Classes.Media) = False Then
		mDocAttSet.Add(Attributes.MEDIASIZENAME_ISO_A4)
	End If
	
	'
	'Set requested page margins
	'
	Dim MediaSizeName As Attribute = mDocAttSet.Get(Attribute_Classes.Media)
	Dim Size() As Float = Attributes.GetMediaSizeForName(MediaSizeName,Attributes.SIZE2DSYNTAX_MM)
	mDocAttSet.Add(Attributes.MEDIAPRINTABLEAREA(LeftPageMargin,TopPageMargin,Size(0) - LeftPageMargin - RightPageMargin,Size(1) - TopPageMargin - BottomPageMargin,Attributes.MEDIAPRINTABLEAREA_MM))

	If mDocAttSet.IsInitialized And mDocAttSet.IsEmpty = False Then
		Doc = NewInstanceJavax.SimpleDoc(IStream,Flavor,mDocAttSet)
	Else
		Doc = NewInstanceJavax.SimpleDoc(IStream,Flavor,Null)
	End If
	
	'
	'Get a DocPrintJob
	'
	PJ = DSS.Service.CreatePrintJob
	
	'This allows detection of print failure due to the requested document being open in another process for Virtual Printers
	'only required for DocPrinJob Jobs
	If Print_Utils.IsVirtualPrinter(DSS.Service) = False Then PJ.AddPrintJobListener(Me,"PrintJob")
	
	'
	'Print
	'
	Dim Result,FFResult As String
	
	#If Debug
	If mPrintRequestAttSet.IsInitialized And mPrintRequestAttSet.IsEmpty = False Then
		Result = PJ.Print_NoThread(Doc,mPrintRequestAttSet)
	Else
		Result = PJ.Print_NoThread(Doc,Null)
	End If
	IStream.Close
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		FFResult = FF.Print_NoThread(DSS.Service)
		
		Result = Result & " " & FFResult
	End If
	#Else
	If mPrintRequestAttSet.IsInitialized And mPrintRequestAttSet.IsEmpty = False Then
		PJ.Print(Me,Doc,mPrintRequestAttSet)
	Else
		PJ.Print(Me,Doc,Null)
	End If
	Wait For Print_Complete(Result As String)
	
	IStream.Close
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		Wait For(FF.Print(DSS.Service)) Complete (FFResult As String)
		
		Result = Result & " " & FFResult
	End If
	#End If
	
	Return Result
	
End Sub
