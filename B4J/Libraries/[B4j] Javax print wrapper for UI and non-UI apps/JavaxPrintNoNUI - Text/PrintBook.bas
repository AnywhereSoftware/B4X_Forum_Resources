B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private DisplayLines As List
	Private TopPageMargin, LeftPageMargin, RightPageMargin, BottomPageMargin As Double
	Private TextColor As AWTColor
	Private TextFile, TextContent As String
	Private mPrintRequestAttSet As PrintRequestAttributeSet
	Private mPrintServiceAttSet As PrintServiceAttributeSet
	Private Const NO_SUCH_PAGE As Int = 1			'ignore Both of these flags are ignored when printing a book, probably because you have told the process
	Private Const PAGE_EXISTS As Int = 0			'how many pages there are in advance.
	Private mFont As AWTFont
	Private BreakOnWord As Boolean = True
	Private mRequireFormFeed As Boolean
	Private bImg As Object
	Private tBook As Book
	Private PJS As PrinterJobServiceSelection
	Private PD As PageDimensions
		
End Sub

Public Sub Initialize
	
	TopPageMargin = JavaxPrint_Utils.CMToPPI(1)
	LeftPageMargin = JavaxPrint_Utils.CMToPPI(1)
	RightPageMargin = JavaxPrint_Utils.CMToPPI(1)
	BottomPageMargin = JavaxPrint_Utils.CMToPPI(1)
	
	TextColor = AWTColors.BLACK
	
	mFont = NewInstanceJavax.Font(AWTFont_Styles.SANS_SERIF,AWTFont_Styles.PLAIN,10)
	
	DisplayLines.Initialize
	
	bImg = JavaxPrint_Utils.LoadBufferedImage("",File.Combine(File.DirAssets,"BookFront.jpg"))
	
	PD.Initialize(JavaxPrint_Utils.CMToPPI(21.0),JavaxPrint_Utils.CMToPPI(29.7))
	
	PJS.Initialize
End Sub

'Set page margins in PPI
'<code>PL.SetPageSize(JavaxPrint_Utils.CMToPPI(29.7),JavaxPrint_Utils.CMToPPI(42.0))</code>
'Default Values JavaxPrint_Utils.CMToPPI(21.0),JavaxPrint_Utils.CMToPPI(29.7) - A4
Public Sub SetPageSize(Width As Double, Height As Double)
	PD.Width = Width
	PD.Height = Height
End Sub

Public Sub SetBreakOnWord(Break As Boolean)
	BreakOnWord = Break
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

'Set a new font for the print
'Default = AWTFont_Static.SANS_SERIF,AWTFont_Static.PLAIN,10
Public Sub SetFont(Font As AWTFont)
	mFont = Font
End Sub

'Set the text color.
'Default = AWTColors.BLACK
Public Sub SetTextColor(Color As AWTColor)
	TextColor = Color
End Sub

'Set the path to a text file to print.
Public Sub SetTextFile(FilePath As String)
	TextFile = FilePath
End Sub

'Set the text to print.
Public Sub SetTextContent(Text As String)
	TextContent = Text
End Sub

'Set the PrintServiceAttributeSet to be used
Public Sub SetPrintServiceAttributeSet(PSAS As PrintServiceAttributeSet)
	mPrintServiceAttSet = PSAS
End Sub

'Set the PrintRequestAttributeSet to be used
Public Sub SetPrintRequestAttributeSet(PRAS As PrintRequestAttributeSet)
	mPrintRequestAttSet = PRAS
End Sub

'Set form feed to be printed after the document if required.
Public Sub RequireFormFeed(Require As Boolean)
	mRequireFormFeed = Require
End Sub

'Get the PrinterJob
Public Sub GetPrintJob As PrinterJob
	Return PJS.PJ
End Sub

'Get The Book Object
Public Sub getBook As Book
	Return tBook
End Sub

'Start the print run.
Public Sub Print As ResumableSub
	
	'
	'Find a printer capable of printing in line with the passed attributes and document size.
	'
	Dim Message As String = PJS.FindService(mPrintServiceAttSet, mPrintRequestAttSet,PD)
	If Message <> "" Then Return Message
	
	Log("Dump Text Printer " & PJS.Service.GetName)
	Log("Page Size (PPI) :" & PD.Width & " x " & PD.Height)
	Log("Page Size (MM) :" & JavaxPrint_Utils.PPItoMM(PD.Width) & " x " & JavaxPrint_Utils.PPItoMM(PD.Height))
	
	'
	'Set the page margins as requested
	'
	PJS.Paper1.SetImageableArea(LeftPageMargin,TopPageMargin,PJS.Paper1.GetWidth - LeftPageMargin - RightPageMargin, PJS.Paper1.GetHeight - TopPageMargin - BottomPageMargin)
	
	'
	'Check that the requested page size and margins are valid
	'
	Dim Before As String = DumpPaper(PJS.Paper1)
	PJS.PF.SetPaper(PJS.Paper1)
	Dim After As String = DumpPageFormat(PJS.PJ.ValidatePage(PJS.PF))
	If  After <> Before Then
		Log("Page format may require attention")
	End If
	
	'
	'Load the text as appropriate
	'
	Dim Text As String
	If TextFile <> "" Then
		If TextFile.StartsWith("AssetsDir") Then
			Text = File.ReadString(File.DirAssets,File.GetName(TextFile))
		Else
			Text = File.ReadString("",TextFile)
		End If
	Else If TextContent <> "" Then
		Text = TextContent
	End If
	
	If Text = "" Then Return "No text Content submitted"
	
	'Get a new pageformat for the title and back pages. Full page print if available
	Dim atts As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet
	atts.Add(Attributes.MEDIAPRINTABLEAREA(0,0, Round(JavaxPrint_Utils.PPItoMM(PD.Width)), Round(JavaxPrint_Utils.PPItoMM(PD.Height)),Attributes.MEDIAPRINTABLEAREA_MM))
	Dim Pf1 As PageFormat = PJS.PJ.GetPageFormat(atts)

	'
	'Create the book
	'
	tBook.Initialize
	
	'
	'PrintBook requires a callback for each page where you format the print as you want it.
	'You can add multiple pages with the same callback at the same time.
	'
	tBook.Append(Me,"Title",Pf1)
	tBook.Append2(Me,"Content",PJS.PF,10)
	tBook.Append(Me,"TextArea",PJS.Pf)
	tBook.Append(Me,"Back",Pf1)
	'Change some pages in the range with a different format
	tBook.SetPage(6,Me,"ContentAdj",PJS.PF)
	tBook.SetPage(7,Me,"ContentAdj",PJS.PF)
	PJS.PJ.SetPageable(tBook)

	Dim Result,FFResult As String
		
	Dim PRB As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet

	If mPrintRequestAttSet.IsInitialized Then PRB = mPrintRequestAttSet

	#If Debug
	If PRB.IsEmpty Then
		Result = PJS.PJ.PrintBook_NoThread(tBook,Null)
	Else
		Result = PJS.PJ.PrintBook_NoThread(tBook,PRB)
	End If
		
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		FFResult = FF.Print_NoThread(PJS.Service)
		
		Result = Result & " " & FFResult
	End If
	#else
		If PRB.IsEmpty Then
			Wait For (PJS.PJ.PrintBook(tBook,Null)) Complete (Result As String)
		Else
			Wait For (PJS.PJ.PrintBook(tBook,PRB)) Complete (Result As String)
		End If
		
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		Wait For(FF.Print(PJS.Service)) Complete (FFResult As String)
		
		Result = Result & " " & FFResult
	End If
#End If
	Return Result
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

'Callback for the title page
Private Sub Title_Event (MethodName As String, Args() As Object) As Int
	
	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)

	Log("Front " & PageIndex)
'	If PageIndex > 0  Then Return NO_SUCH_PAGE
	
	
	G.Translate(0,0)
	G.SetFont(mFont)
	G.SetColor(TextColor)
	
	

	G.DrawImage3(bImg,0,0,AWTColors.BLACK,Null)

	Return PAGE_EXISTS
End Sub

'Callback for the content pages
Private Sub Content_Event (MethodName As String, Args() As Object) As Int

	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)

	Log("Content " & PageIndex)
'	If PageIndex > tBook.GetNumberOfPages -1  Then Return NO_SUCH_PAGE
	
	G.Translate(PF.GetImageableX,PF.GetImageableY)
	G.SetFont(mFont)
	G.SetColor(TextColor)
	
	
	G.DrawString("Content " & PageIndex,0,25)


	Return PAGE_EXISTS
End Sub

'Callback for adjusted content pages
Private Sub ContentAdj_Event (MethodName As String, Args() As Object) As Int

	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)

	Log("ContentAdt " & PageIndex)
'	If PageIndex > tBook.GetNumberOfPages -1  Then Return NO_SUCH_PAGE
	
	G.Translate(PF.GetImageableX,PF.GetImageableY)
	G.SetFont(mFont)
	G.SetColor(TextColor)
	
	
	G.DrawString("ContentAdj " & PageIndex,0,25)


	Return PAGE_EXISTS
End Sub

'Callback for TextArea content pages
Private Sub TextArea_Event (MethodName As String, Args() As Object) As Int

	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)
	
	Dim TextArea As jTextArea = NewInstanceJavax.JTextArea
	TextArea.SetFont(mFont)
	TextArea.SetBackground(AWTColors.WHITE)
	TextArea.SetForeground(TextColor)
	TextArea.SetLineWrap(True)
	If BreakOnWord Then TextArea.SetWrapStyleWord(True)
	
	TextArea.SetText("test of textarea in book")

	Log("ContentAdj " & PageIndex)

	G.Translate(PF.GetImageableX,PF.GetImageableY)

	TextArea.GetObject.As(JavaObject).RunMethod("paint",Array(G.GetObject))


	Return PAGE_EXISTS
End Sub


'Callback for the back page
Private Sub Back_Event (MethodName As String, Args() As Object) As Int

	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)						'ignore
	Dim PageIndex As Int = Args(2)

	Log("Back " & PageIndex)

	G.SetFont(mFont)
	G.SetColor(AWTColors.BLACK)
	G.FillRect(0,0,PF.GetWidth,PF.GetHeight)

	G.SetColor(NewInstanceJavax.AWTColor(0xFFC3A04D))
	G.DrawString("Stevel05",(PF.GetWidth - JavaxPrint_Utils.GetStringWidth(mFont,"Stevel05")) / 2,PF.GetHeight - 30)

	Return PAGE_EXISTS
End Sub