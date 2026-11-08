B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals

	Private PD As PageDimensions
	Private PJS As PrinterJobServiceSelection
	Private bImg As Object
	Private CONST NO_SUCH_PAGE As Int = 1
	Private CONST PAGE_EXISTS As Int = 0
	Private mPrintRequestAttSet As PrintRequestAttributeSet
	Private mPrintServiceAttSet As PrintServiceAttributeSet
	Private mImageFileName As String
	Private TopPageMargin, LeftPageMargin, RightPageMargin, BottomPageMargin As Double
	Private mRequireFormFeed As Boolean = False 
	Private mMaintainAspect As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	PD.Initialize(JavaxPrint_Utils.CMToPPI(21.0),JavaxPrint_Utils.CMToPPI(29.7))
	
	TopPageMargin = 25.4
	LeftPageMargin = 25.4
	RightPageMargin = 25.4
	BottomPageMargin = 25.4
	
	PJS.Initialize
End Sub

	
Public Sub SetPrintRequestAttributeSet(PrintRequestAttSet As PrintRequestAttributeSet)
	mPrintRequestAttSet = PrintRequestAttSet
End Sub

Public Sub SetPrintServiceAttributeSet(PrintServiceAttSet As PrintServiceAttributeSet)
	mPrintServiceAttSet = PrintServiceAttSet
End Sub

Public Sub SetImageFileName(FullFileName As String)
	mImageFileName = FullFileName
	bImg = JavaxPrint_Utils.LoadBufferedImage(File.DirAssets,mImageFileName)
End Sub

Public Sub GetPrintJob As PrinterJob
	Return PJS.pj
End Sub

Public Sub RequireFormFeed(Require As Boolean)
	mRequireFormFeed = Require
End Sub

Public Sub SetMaintainAspectRatio(Maintain As Boolean)
	mMaintainAspect = Maintain
End Sub


'Set page margins in PPI
'<code>PL.SetPageMargins(JavaxPrint_Utils.CMToPPI(1),JavaxPrint_Utils.CMToPPI(1),JavaxPrint_Utils.CMToPPI(1),JavaxPrint_Utils.CMToPPI(1))</code>
'Default Values JavaxPrint_Utils.CMToPPI(1),JavaxPrint_Utils.CMToPPI(1).JavaxPrint_Utils.CMToPPI(1),JavaxPrint_Utils.CMToPPI(1)
Public Sub SetPageMargins(Left As Double, Top As Double, Right As Double, Bottom As Double)
	LeftPageMargin = Left
	TopPageMargin = Top
	RightPageMargin = Right
	BottomPageMargin = Bottom
End Sub

Public Sub Print As ResumableSub
	
	'Find a printer capable of printing in line with the passed attributes and document size.
	Dim Message As String = PJS.FindService(mPrintServiceAttSet, mPrintRequestAttSet, PD)
	If Message <> "" Then Return Message
	
	'
	'Set the page margins as requested and check valid
	'
	PJS.Paper1.SetImageableArea(LeftPageMargin,TopPageMargin,PJS.Paper1.GetWidth - LeftPageMargin - RightPageMargin, PJS.Paper1.GetHeight - TopPageMargin - BottomPageMargin)
	Dim Before As String = DumpPaper(PJS.Paper1)
	PJS.PF.SetPaper(PJS.Paper1)
	Dim After As String = DumpPageFormat(PJS.PJ.ValidatePage(PJS.PF))
	If  After <> Before Then
		Log(Before)
		Log(After)
		Log("Page format may require attention")
	End If
	
	
	Dim Result,FFResult As String
		
	Dim PRAS As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet
	If mPrintRequestAttSet.IsInitialized Then PRAS = mPrintRequestAttSet

#If Debug
	'
	'Not Threaded printing
	'
	If PRAS.IsEmpty Then
		'			PJS.PJ.SetPrintable(NewInstanceJavax.Printable(Me,"Print"))
		Result = PJS.PJ.Print_NoThread(Me,"Print",PJS.PF,Null)
	Else
'			PJS.PJ.SetPrintable(NewInstanceJavax.Printable(Me,"Print"))
		Result = PJS.PJ.Print_NoThread(Me,"Print",PJS.PF,PRAS)
	End If
		
	
	Try
		If Result = "OK" And mRequireFormFeed Then
			Dim FF As Print_FF
			FF.Initialize
			FFResult = FF.Print_NoThread(PJS.Service)
		End If
	Catch
		Result = Result & " " & FFResult
	End Try
#Else
	'
	' Threaded Printing
	'
	If PRAS.IsEmpty Then
		Wait For (PJS.PJ.Print(Me,"Print",PJS.PF,Null)) Complete (Result As String)
	Else
		Wait For (PJS.PJ.Print(Me,"Print",PJS.PF,PRAS)) Complete (Result As String)
	End If
	
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		Wait For(FF.Print(PJS.Service)) Complete (FFResult As String)
		
		Result = Result & " " & FFResult
	End If
#End iF

	Return Result
End Sub

Private Sub Print_Event (MethodName As String, Args() As Object) As Int
	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)

	If PageIndex > 0  Then Return NO_SUCH_PAGE
	
	'Using Translate means that we are only printing on the pages Printable area, so we can ignore margins.
	G.Translate(PF.GetImageableX,PF.GetImageableY)
	
	If mMaintainAspect Then
		Dim Resize() As Double = MaintainAspectRatio(bImg,PF.GetImageableWidth,PF.GetImageableHeight)
		G.DrawImage6(bImg,Resize(0),Resize(1),Resize(2),Resize(3),Null)
	Else
		G.DrawImage6(bImg,0,0,PF.GetImageableWidth,PF.GetImageableHeight,Null)
	End If
	
	Return PAGE_EXISTS
End Sub

Private Sub DumpPaper(P As Paper) As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.append(p.getWidth).append(" x ").append(p.getHeight) _
	.append(" / ").append(p.getImageableX).append(" x ") _
	.append(p.getImageableY).append(" - ") _
	.append(p.getImageableWidth).append(" x ").append(p.getImageableHeight)
	Return SB.toString()
End Sub

Private Sub DumpPageFormat(Pf As PageFormat) As String
	Return DumpPaper(Pf.GetPaper)
End Sub

Private Sub MaintainAspectRatio(img As Object,BoundsWidth As Double,BoundsHeight As Double) As Double()
	Dim ImgWidth As Double =  img.As(JavaObject).RunMethod("getWidth",Null)
	Dim ImgHeight As Double = img.As(JavaObject).RunMethod("getHeight",Null)
	Log(ImgWidth & TAB & BoundsWidth)
	BoundsWidth = NumberFormat(BoundsWidth,0,2)
	BoundsHeight = NumberFormat(BoundsHeight,0,2)
	Dim NewHeight As Double
	Dim NewWidth As Double
	
	If ImgWidth > BoundsWidth Then
		NewWidth = BoundsWidth
		NewHeight = ImgHeight * (NewWidth / ImgWidth)
	End If
	If NewHeight > BoundsHeight Then
		NewHeight = BoundsHeight
		NewWidth = ImgWidth * (NewHeight / ImgHeight)
	End If
	Return Array As Double((BoundsWidth - NewWidth) / 2,(BoundsHeight - NewHeight) / 2,NewWidth,NewHeight)
End Sub