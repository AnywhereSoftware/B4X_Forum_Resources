B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Type LabelsType(XOffset As Double, YOffset As Double, Content() As Object)
	Type LineType(XOffset As Double ,YOffset As Double, Text As String)
	Private CONST NO_SUCH_PAGE As Int = 1
	Private CONST PAGE_EXISTS As Int = 0
	Private LinesPerPage As Int
	Private DisplayLines As List
	Private TopPageMargin, LeftPageMargin, RightPageMargin, BottomPageMargin As Double
	Private LineHeight As Double
	Private LineSpacing As Double
	Private Ascent As Double
	
	'Margins internal to the label
	Private DocumentMarginX As Double
	Private DocumentMarginY As Double
	
	Private TextColor As AWTColor
	Private AlternateLinecolor As AWTColor
	Private UnderlineColor As AWTColor
	Private TextFile, TextContent As String
	Private mPrintRequestAttSet As PrintRequestAttributeSet
	Private mPrintServiceAttSet As PrintServiceAttributeSet
	Private mFont As AWTFont
	Private BreakOnWord As Boolean = True
	Private mRequireFormFeed As Boolean
	Private PJS As PrinterJobServiceSelection
	Private PD As PageDimensions
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	TopPageMargin = JavaxPrint_Utils.CMToPPI(1)
	LeftPageMargin = JavaxPrint_Utils.CMToPPI(1)
	RightPageMargin = JavaxPrint_Utils.CMToPPI(1)
	BottomPageMargin = JavaxPrint_Utils.CMToPPI(1)
	
	LineSpacing = 1
	
	'Margins internal to the label
	DocumentMarginX = JavaxPrint_Utils.CMToPPI(0.3)
	DocumentMarginY = JavaxPrint_Utils.CMToPPI(0.3)
	
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

'Set a new font for the labels
'Default = AWTFont_Static.SANS_SERIF,AWTFont_Static.PLAIN,10
Public Sub SetFont(Font As AWTFont)
	mFont = Font
End Sub

'Set Margins internal to the Document in PPI
'<code>PL.SetDocumentMargins(JavaxPrint_Utils.CMToPPI(0.3),JavaxPrint_Utils.CMToPPI(0.3))</code>
'Default Values JavaxPrint_Utils.CMToPPI(0.3),JavaxPrint_Utils.CMToPPI(0.3)
Public Sub SetDocumentMargins(Left As Double,Top As Double)
	DocumentMarginX = Left
	DocumentMarginY = Top
End Sub

'Set Linespacing as a percentage float value - min spacing = 0.1
Public Sub SetLineSpacing(Spacing As Float)
	LineSpacing = Max(Spacing,0.1)
End Sub

'Set the text color
Public Sub SetTextColor(Color As AWTColor)
	TextColor = Color
End Sub

Public Sub SetAlternateLineColor(color As AWTColor)
	AlternateLinecolor = color
End Sub

Public Sub SetUnderlineColor(color As AWTColor)
	UnderlineColor = color
End Sub

'Set the path to a text file to print.
Public Sub SetTextFile(FilePath As String)
	TextFile = FilePath
End Sub

'Set the text to print
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
	
	Log("Print text formatted Printer " & PJS.Service.GetName)
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
	
	LineHeight = JavaxPrint_Utils.GetLineHeight(mFont)
	Ascent = JavaxPrint_Utils.GetAscent(mFont)
	
	'
	'Create lines to be printed
	'	
	Dim Result,FFResult As String
	
	If mPrintRequestAttSet.IsInitialized Then
		Dim Orientation As String = mPrintRequestAttSet.Get(Attribute_Classes.OrientationRequested).As(String) 'ignore
		Result = CreateLines(PJS.Paper1,Orientation)
	Else
		Result = CreateLines(PJS.Paper1,"portrait")
	End If
	
	If Result <> "" Then Return Result
	
	Log("DisplayLines " & DisplayLines.Size)
	
	
	#If Debug
	'
	'Not Threaded printing
	'
	
		Dim PRB As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet
		If mPrintRequestAttSet.IsInitialized Then PRB = mPrintRequestAttSet
	
		'Not Threaded
		If PRB.IsEmpty Then
			Log("Printing1 ...")
		Result = PJS.PJ.Print_NoThread(Me,"Print",PJS.PF,Null)
		Else
			Log("Printing2 ...")
		Result = PJS.PJ.Print_NoThread(Me,"Print",PJS.PF,PRB)
			Result = "OK"
		End If
		
		Log("Printing Done")
		
	Try
		If Result = "OK" And mRequireFormFeed Then
			Dim FF As Print_FF
			FF.Initialize
			FFResult = FF.Print_NoThread(PJS.Service)
		End If
	Catch
		Result = Result & " " & FFResult
	End Try
#else
	'
	'Threaded printing
	'

	Dim PRB As PrintRequestAttributeSet = NewInstanceJavax.PrintRequestAttributeSet
	If mPrintRequestAttSet.IsInitialized Then PRB = mPrintRequestAttSet
	

	If PRB.IsEmpty Then
		Wait For (PJS.PJ.Print(Me,"Print",PJS.PF,Null)) Complete (Result As String)
	Else
		Wait For (PJS.PJ.Print(Me,"Print",PJS.PF,PRB)) Complete (Result As String)
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


Private Sub Print_Event (MethodName As String, Args() As Object) As Int
	Dim G As Graphics2d = Args(0)
	Dim PF As PageFormat = Args(1)
	Dim PageIndex As Int = Args(2)
	
	Dim FirstLine As Int = PageIndex * LinesPerPage
	Dim LastLine As Int = Min(DisplayLines.size - 1,FirstLine + LinesPerPage - 1)

	If FirstLine >= DisplayLines.Size Then Return NO_SUCH_PAGE
	
	G.Translate(PF.GetImageableX,PF.GetImageableY)
	G.SetFont(mFont)
	G.SetColor(TextColor)
	
	For i = FirstLine To LastLine
		Dim LineT As LineType = DisplayLines.Get(i)
		If AlternateLinecolor.IsInitialized And (i - FirstLine) Mod 2 = 0 Then
			G.SetColor(AlternateLinecolor)
			G.FillRect(0, LineT.YOffset ,PF.GetImageableWidth,LineHeight * LineSpacing)
			G.SetColor(TextColor)
		End If
		G.DrawString(LineT.Text, LineT.XOffset, LineT.YOffset + Ascent)
		If UnderlineColor.IsInitialized Then
			G.SetColor(UnderlineColor)
			G.DrawLine(0,LineT.YOffset + LineHeight,PF.GetImageableWidth,LineT.YOffset + LineHeight)
			G.SetColor(TextColor)
		End If
	Next
	Return PAGE_EXISTS
	
End Sub

Private Sub CreateLines(Paper1 As Paper, Orientation As String) As String
	'Ignore margins when setting up the labelsas by using G.Translate(PF.GetImageableX,PF.GetImageableY) in the Print_Event sub
	'it handles the margins for us
	
	Dim MaxHeight As Double
	Dim MaxWidth As Double
	If Orientation.Contains("landscape") Then
		MaxHeight = Paper1.GetImageableWidth
		MaxWidth = Paper1.GetImageableHeight
	Else
		MaxHeight = Paper1.GetImageableHeight
		MaxWidth = Paper1.GetImageableWidth
	End If
	
	LinesPerPage = Floor((MaxHeight - DocumentMarginY) / (LineHeight * LineSpacing))
	
	Log("Lines Per Page " & LinesPerPage)
	
	Dim Lines As List
	Lines.Initialize
	If TextFile <> "" Then
		If TextFile.StartsWith("AssetsDir") Then
			Lines = Regex.Split($"\r\n|\r|\n"$,File.ReadString(File.DirAssets,File.GetName(TextFile)))
		Else
			Lines = Regex.Split($"\r\n|\r|\n"$,File.ReadString("",TextFile))
		End If
	End If
	If TextContent <> "" Then
		Lines = Regex.Split($"\r\n|\r|\n"$,TextContent)
	End If

	If Lines.Size = 0 Then
		Return "No records found"
	End If
	
	Log("Lines Size " & Lines.Size)
	
	Dim LineX As Double = DocumentMarginX
	Dim LineY As Double = DocumentMarginY

	For i = 0 To Lines.Size - 1
		
		Dim NewDisplayLines As List = GetDisplayLines(MaxWidth,Lines.Get(i))
		
		For Each Line As String In NewDisplayLines
			If LineY + LineHeight * LineSpacing > MaxHeight Then
				LineY = DocumentMarginY
			End If
			
			Dim LineT As LineType = CreateLineType(LineX,LineY,Line)
			DisplayLines.Add(LineT)
			
			LineY = LineY + LineHeight * LineSpacing
		Next
		
		
	Next
	Return ""
End Sub

Private Sub GetDisplayLines(MaxWidth As Double, Line As String) As List
	Dim L As List
	L.Initialize
	Dim SBLine As StringBuilder
	SBLine.Initialize
	SBLine.Append(Line)
	
	If JavaxPrint_Utils.GetStringWidth(mFont,SBLine.ToString) > MaxWidth Then
		Dim SBTest As StringBuilder
		SBTest.Initialize
		SBTest.Append(SBRemoveCharAt(SBLine,0))
		Do While JavaxPrint_Utils.GetStringWidth(mFont,SBTest.ToString) < MaxWidth
			SBTest.Append(SBRemoveCharAt(SBLine,0))
		Loop
		If BreakOnWord Then
			If SBCharAt(SBTest,SBTest.Length - 1) = " " Then
				SBRemoveCharAt(SBTest,SBTest.Length - 1)
			Else
				Dim Index As Int = SBLastIndexOf(SBTest," ")
				If Index > -1 Then
					SBLine.Insert(0,SBSubString(SBTest,Index + 1))
					SBReplace(SBTest,Index,SBTest.Length,"")
				End If
			End If
			L.Add(SBTest.ToString)
		Else
			SBLine.Insert(0,SBRemoveCharAt(SBTest,SBTest.Length - 1))
			L.Add(SBTest.ToString)
		End If
		
		If SBLine.Length > 0 Then
			L.AddAll(GetDisplayLines(MaxWidth,SBLine.ToString))
		End If
	Else
		L.Add(SBLine.ToString)
	End If
	
	Return L
End Sub

'
'StringBuilder Wrapper
'
Private Sub SBCharAt(SB As StringBuilder,Index As Int) As String
	Return SB.As(JavaObject).RunMethod("charAt",Array(Index))
End Sub
Private Sub SBRemoveCharAt(SB As StringBuilder,Index As Int) As String
	Dim S As String = SB.As(JavaObject).RunMethod("charAt",Array(Index))
	SB.Remove(Index,Index + 1)
	Return S
End Sub
Private Sub SBLastIndexOf(SB As StringBuilder,Str As String) As Int
	Return SB.As(JavaObject).RunMethod("lastIndexOf",Array(Str))
End Sub
Private Sub SBSubString(SB As StringBuilder,StartIndex As Int) As String
	Return SB.As(JavaObject).RunMethod("substring",Array(StartIndex))
End Sub
Private Sub SBReplace(SB As StringBuilder,StartIndex As Int, EndIndex As Int,Str As String)
	SB.As(JavaObject).RunMethod("replace",Array(StartIndex,EndIndex,Str))
End Sub
'
' End of StringBuilder Wrapper
'

Private Sub CreateLineType (XOffset As Double, YOffset As Double, Text As String) As LineType
	Dim t1 As LineType
	t1.Initialize
	t1.XOffset = XOffset
	t1.YOffset = YOffset
	t1.Text = Text
	Return t1
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

