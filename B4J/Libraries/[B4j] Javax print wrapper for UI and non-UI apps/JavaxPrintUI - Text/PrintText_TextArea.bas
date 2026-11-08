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
	Private mFont As AWTFont
	Private BreakOnWord As Boolean = True
	Private PJS As PrinterJobServiceSelection
	Private PD As PageDimensions
	Private mRequireFormFeed As Boolean
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	TopPageMargin = JavaxPrint_Utils.CMToPPI(1)
	LeftPageMargin = JavaxPrint_Utils.CMToPPI(1)
	RightPageMargin = JavaxPrint_Utils.CMToPPI(1)
	BottomPageMargin = JavaxPrint_Utils.CMToPPI(1)
	
	TextColor = AWTColors.BLACK
	
	PD.Initialize(JavaxPrint_Utils.CMToPPI(21.0),JavaxPrint_Utils.CMToPPI(29.7))
	
	
	mFont = NewInstanceJavax.Font(AWTFont_Styles.SANS_SERIF,AWTFont_Styles.PLAIN,10)
	
	DisplayLines.Initialize
	
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

Public Sub SetPrintServiceAttributeSet(PSAS As PrintServiceAttributeSet)
	mPrintServiceAttSet = PSAS
End Sub


Public Sub SetPrintRequestAttributeSet(PRAS As PrintRequestAttributeSet)
	mPrintRequestAttSet = PRAS
End Sub

Public Sub GetPrintJob As PrinterJob
	Return PJS.PJ
End Sub

Public Sub RequireFormFeed(Require As Boolean)
	mRequireFormFeed = Require
End Sub


'Start the print run.
Public Sub Print As ResumableSub
	
	'Find a printer capable of printing in line with the passed attributes and document size.
	Dim Message As String = PJS.FindService(mPrintServiceAttSet, mPrintRequestAttSet, PD)
	If Message <> "" Then Return Message
	
	Log("Dump Text Printer " & PJS.Service.GetName)
	Log("Page Size (PPI) :" & PD.Width & " x " & PD.Height)
	
	'
	'Set the page margins as requested and check valid
	'
	PJS.Paper1.SetImageableArea(LeftPageMargin,TopPageMargin,PJS.Paper1.GetWidth - LeftPageMargin - RightPageMargin, PJS.Paper1.GetHeight - TopPageMargin - BottomPageMargin)
	Dim Before As String = DumpPaper(PJS.Paper1)
	PJS.PF.SetPaper(PJS.Paper1)
	Dim After As String = DumpPageFormat(PJS.PJ.ValidatePage(PJS.PF))
	If  After <> Before Then
		Log("Page format may require attention")
	End If
	
	'
	'Set up a Swing jTextArea to handle the page formatting
	'
	Dim TextArea As jTextArea = NewInstanceJavax.JTextArea
	TextArea.SetFont(mFont)
	TextArea.SetBackground(AWTColors.WHITE)
	TextArea.SetForeground(TextColor)
	TextArea.SetLineWrap(True)
	If BreakOnWord Then TextArea.SetWrapStyleWord(True)
	
	PJS.PJ.SetPrintable(TextArea.GetPrintable)
	
	'
	'Get the text to print
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
	TextArea.SetText(Text)
	
		
	Dim PRAS As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet
	If mPrintRequestAttSet.IsInitialized Then PRAS = mPrintRequestAttSet
	
	'
	'Print
	'
	If PRAS.ContainsKey(Attribute_Classes.MediaPrintableArea) = False Then
		Dim X As Double = JavaxPrint_Utils.PPItoMM(PJS.Paper1.GetImageableX)
		Dim Y As Double = JavaxPrint_Utils.PPItoMM(PJS.Paper1.GetImageableY)
		Dim Width As Double = JavaxPrint_Utils.PPIToMM(PJS.Paper1.GetImageableWidth)
		Dim Height As Double = JavaxPrint_Utils.PPIToMM(PJS.Paper1.GetImageableHeight)
		PRAS.Add(Attributes.MEDIAPRINTABLEAREA(X,Y,Width,Height,Attributes.MEDIAPRINTABLEAREA_MM))
	End If
	
	Dim Result,FFResult As String
	
	#If Debug
	If PRAS.IsEmpty Then
		Result = PJS.PJ.Print_NoThread2(Null)
	Else
		Result = PJS.PJ.Print_NoThread2(PRAS)
	End If
	
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		FFResult = FF.Print_NoThread(PJS.Service)
		
		Result = Result & " " & FFResult
	End If
	#Else
	If PRAS.IsEmpty Then
		Wait For (PJS.PJ.Print2(Null)) Complete (Result As String)
	Else
		Wait For(PJS.PJ.Print2(PRAS)) Complete (Result As String)
	End If
	
	If Result = "OK" And mRequireFormFeed Then
		Dim FF As Print_FF
		FF.Initialize
		Wait For(FF.Print(PJS.Service)) Complete (FFResult As String)
		
		Result = Result & " " & FFResult
	End If
#end If

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

