B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private XUI As XUI
	Private FX As JFX

	'Page Variables
	Private LinesPerPage As Int
	Private DisplayPages As List
	Private TopPageMargin, LeftPageMargin, RightPageMargin, BottomPageMargin As Double
	Private LineHeight As Double
	Private mLineSpacing As Double = 0
	
	'Label Variables
	Private mTextColor As Int
	Private mAuditLineColor As Int
	Private TextFile, mTextContent As String

	'Output variables
	Private mFont As Font
	Private mBreakOnWord As Boolean = True
	Private mOrientation As String
	Private mCopies As Int = 1
	Private mAuditColumnWidths() As Int
	Private mTotalAuditColWidth As Int = 0
	Private mUnderlineDashStyle() As Double
	Private mRemoveDoubleLineSpacing As Boolean
	Private ShowAlternateLinecolor As Boolean
	Private mAlternateLinecolor As Int
	Private ShowUnderlineColor As Boolean
	Private mUnderlineColor As Int
	Private mPaper As Paper
	Private mFileDestination As String

	'Printer variables	
	Private PJ As PrinterJob
	Private Ptr As Printer
	Private mPrinterName As String
	
	'Utility
	Private MeasureTxtNode As MeasureTextNode
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	TopPageMargin = PTF_Utils.CMToPPI(1)
	LeftPageMargin = PTF_Utils.CMToPPI(1)
	RightPageMargin = PTF_Utils.CMToPPI(1)
	BottomPageMargin = PTF_Utils.CMToPPI(1)
	
	mTextColor = XUI.Color_Black
	mAuditLineColor = XUI.Color_Black
	
	mFont = FX.CreateFont("Sans Serif",12,False,False)
	
	DisplayPages.Initialize
	
	mOrientation = "PORTRAIT"
	mPaper = Paper_static.A4
	
End Sub

'Set the required paper
'Only relevant if PrinterName is specified
Public Sub setPaper(tPaper As Paper)
	mPaper = tPaper
End Sub

'Set number of copies
'Only relevant if PrinterName is specified
Public Sub setCopies(Copies As Int)
	mCopies = Copies
End Sub

'Set required Page Orientation
'One of LANDSCAPE, PORTRAIT, REVERSE_LANDSCAPE, REVERSE_PORTRAIT
'Only relevant if PrinterName is specified
Public Sub setPageOrientation(Orientation As String)
	mOrientation = Orientation.ToUpperCase
End Sub

'Will try to break long lins at a word boundary
'Default value = True
Public Sub setBreakOnWord(Break As Boolean)
	mBreakOnWord = Break
End Sub

'Set page margins in PPI
'<code>PTF.SetPageMargins(PTF_Utils.CMToPPI(1),PTF_Utils.CMToPPI(1),PTF_Utils.CMToPPI(1),PTF_Utils.CMToPPI(1))</code>
'Default Values PTF_Utils.CMToPPI(1),PTF_Utils.CMToPPI(1).PTF_Utils.CMToPPI(1),PTF_Utils.CMToPPI(1)
Public Sub SetPageMargins(Left As Double, Top As Double, Right As Double, Bottom As Double)
	LeftPageMargin = Left
	TopPageMargin = Top
	RightPageMargin = Right
	BottomPageMargin = Bottom
End Sub

'Set a new font for the labels
'Default = FX.CreateFont("Sans Serif",12,False,False)
Public Sub setFont(tFont As Font)
	mFont = tFont
End Sub

'Defines the vertical space in pixels between lines
Public Sub setLineSpacing(Spacing As Int)
	mLineSpacing = Spacing
End Sub

'Set the text color
Public Sub setTextColor(Color As Int)
	mTextColor = Color
End Sub

Public Sub setAlternateLineColor(color As Int)
	ShowAlternateLinecolor = True
	mAlternateLinecolor = color
End Sub

Public Sub setUnderlineColor(color As Int)
	mUnderlineColor = color
	ShowUnderlineColor = True
End Sub

'Set a dashed style for the underline
'See <link>JavaDoc|https://docs.oracle.com/javase/8/javafx/api/javafx/scene/shape/Shape.html#getStrokeDashArray-- </link>
'<code>Array As Double(10,10)</code>
Public Sub setUnderlineDashStyle(Style() As Double)
	mUnderlineDashStyle = Style
End Sub

'Set the path to a text file to print.
Public Sub setTextFile(FilePath As String)
	TextFile = FilePath
End Sub

'Set the text to print
Public Sub setTextContent(Text As String)
	mTextContent = Text
End Sub

Public Sub GetPrintJob As PrinterJob
	Return PJ
End Sub

'Enter the required printer name or "default" for the system default printer
Public Sub setPrinterName(PrinterName As String)
	mPrinterName = PrinterName
End Sub

'Set the width of any required Audit columns
Public Sub setAuditColumns(ColumnsWidths() As Int)
	mAuditColumnWidths = ColumnsWidths
End Sub

Public Sub setAuditLineColor(Color As Int)
	mAuditLineColor = Color	
End Sub

Public Sub setRemoveDoubleLineSpacing(Remove As Boolean)
	mRemoveDoubleLineSpacing = Remove
End Sub

'Set the file destination for the print.
'Does not work with all virtual printers, "Microsoft Print to PDF" is one I have tested.
'Bullzip does not work
Public Sub SetFileDestination(FilePath As String, FileName As String)
	mFileDestination = File.Combine(FilePath,FileName)
End Sub

'Start the print run.
Public Sub Print As ResumableSub
	
	Dim Result As String = ""
	Dim PL As PageLayout
	Dim JS As JobSettings
	
	If mPrinterName <> "" Then
		
		If mPrinterName.ToLowerCase = "default" Then
			Ptr = Printer_Static.GetDefaultPrinter
			PJ = PrinterJob_Static.CreatePrinterJob2(Ptr)
			JS = PJ.GetJobSettings
			PL = Ptr.CreatePageLayout(mPaper,mOrientation,LeftPageMargin,RightPageMargin,TopPageMargin,BottomPageMargin)
			JS.SetPageLayout(PL)
		Else
			Dim AllPrinters As List = Printer_Static.GetAllPrinters
			For Each P As Printer In AllPrinters
				If P.GetName.ToLowerCase = mPrinterName.ToLowerCase Then
					Ptr = P
					Exit
				End If
			Next
			If Ptr.IsInitialized Then
				PJ = PrinterJob_Static.CreatePrinterJob2(Ptr)
				JS = PJ.GetJobSettings
				PL = Ptr.CreatePageLayout(mPaper,mOrientation,LeftPageMargin,RightPageMargin,TopPageMargin,BottomPageMargin)
				JS.SetPageLayout(PL)
			
			Else
				Return "Printer " & mPrinterName & " not found"
			End If
		End If
	Else
	
		PJ = PrinterJob_Static.CreatePrinterJob
		If PJ.ShowPrintDialog(Null) = False Then Return "User cancelled print dialog"
		If PJ.ShowPageSetupDialog(Null) = False Then Return "User cancelled page dialog"
		JS = PJ.GetJobSettings
		PL = JS.GetPageLayout
		Ptr = PJ.GetPrinter
	End If
	

	Log("Printing on " & Ptr.GetName)
	
	If mFileDestination <> "" Then
		'From https://stackoverflow.com/questions/52684422/javafx-set-programmatically-the-destination-path-to-print-directly-a-node-to-p
		Dim Refl As Reflector
		Refl.Target = PJ.GetObject
		Refl.Target = Refl.GetField("jobImpl")
		Dim AttSet As JavaObject = Refl.GetField("printReqAttrSet")
		Dim URI As JavaObject
		URI.InitializeNewInstance("java.net.URI",Array(File.GetUri("",mFileDestination)))
		Dim Dest As JavaObject
		Dest.InitializeNewInstance("javax.print.attribute.standard.Destination",Array(URI))
		AttSet.RunMethod("add",Array(Dest))
		Log("Attempt printing to file " & mFileDestination)
	End If
	
	
	JS.SetCopies(mCopies)
	
	MeasureTxtNode.Initialize(PL)
	LineHeight = MeasureTxtNode.Measure(" ",mFont).Height
'	Log("LineHeight " & LineHeight)
	
	Result = CreatePages
	
	If Result <> "" Then Return Result
	

	Dim Printed As Boolean
	For i = 0 To DisplayPages.Size - 1
		Dim Page As List = DisplayPages.Get(i)
		
		Dim Pn As B4XView = XUI.CreatePanel("")
		Pn.SetLayoutAnimated(0,0,0,PL.GetPrintableWidth,PL.GetPrintableHeight)
		
		Dim TF As TextFlowClass = NewInstance_TextFlow.TextFlow
		Pn.AddView(TF.GetObject,0,0,PL.GetPrintableWidth,PL.GetPrintableHeight)
		
		TF.SetLineSpacing(mLineSpacing)
		TF.GetObject.As(B4XView).SetLayoutAnimated(0,0,0, PL.GetPrintableWidth, PL.GetPrintableHeight)
		
		Dim LineWidth As Double = PL.GetPrintableWidth
		If mTotalAuditColWidth > 0 Then	LineWidth = LineWidth - mTotalAuditColWidth - 2
		
		For j = 0 To Page.Size - 1
			Dim TC As TextClass = Page.Get(j)
			
			If ShowAlternateLinecolor And  j Mod 2 = 1 Then
				Dim R As JavaObject
				R.InitializeNewInstance("javafx.scene.shape.Rectangle",Array(0.0,0.0,LineWidth, LineHeight))
				R.RunMethod("setFill",Array(FX.Colors.From32Bit(mAlternateLinecolor)))
				Pn.AddView(R,0,j * (LineHeight + mLineSpacing) + 1,LineWidth, LineHeight)
				R.As(B4XView).SendToBack
			End If
			
			TF.AddNode(TC)

			If ShowUnderlineColor Then
				Dim LN As JavaObject
				LN.InitializeNewInstance("javafx.scene.shape.Line",Array(0.0,0.0,LineWidth,0.0))
				LN.RunMethod("setStroke",Array(FX.Colors.From32Bit(mUnderlineColor)))
				If mUnderlineDashStyle.Length > 0 Then LN.RunMethod("getStrokeDashArray",Null).As(List).AddAll(mUnderlineDashStyle)
				Pn.AddView(LN,0,j * (LineHeight + mLineSpacing) + LineHeight,LineWidth,1)
			End If
			
			If mTotalAuditColWidth > 0 Then
				Dim LN As JavaObject
				LN.InitializeNewInstance("javafx.scene.shape.Line",Array(0.0,0.0,PL.GetPrintableWidth - mTotalAuditColWidth,0.0))
				LN.RunMethod("setStroke",Array(FX.Colors.From32Bit(mAuditLineColor)))
				Pn.AddView(LN,PL.GetPrintableWidth - mTotalAuditColWidth - 1, j * (LineHeight + mLineSpacing) + LineHeight,mTotalAuditColWidth,1)
		
			End If
			
		Next
		If mTotalAuditColWidth > 0 Then
			Dim X As Double = PL.GetPrintableWidth - mTotalAuditColWidth - 2
			
			Dim LN As JavaObject
			LN.InitializeNewInstance("javafx.scene.shape.Line",Array(X,0.0,PL.GetPrintableWidth,0.0))
			LN.RunMethod("setStroke",Array(FX.Colors.From32Bit(mAuditLineColor)))
			Pn.AddView(LN, X, 0, mTotalAuditColWidth, 1)
			
			Dim LN As JavaObject
			LN.InitializeNewInstance("javafx.scene.shape.Line",Array(x,0.0,x,Page.Size * (LineHeight + mLineSpacing)))
			LN.RunMethod("setStroke",Array(FX.Colors.From32Bit(mAuditLineColor)))
			Pn.AddView(LN,X,0,1,Page.Size * (LineHeight + mLineSpacing))
			
			For Each Width As Int In mAuditColumnWidths
				X = X + Width
				Dim LN As JavaObject
				LN.InitializeNewInstance("javafx.scene.shape.Line",Array(x,0.0,x,Page.Size * (LineHeight + mLineSpacing)))
				LN.RunMethod("setStroke",Array(FX.Colors.From32Bit(mAuditLineColor)))
				Pn.AddView(LN,X,0,1,Page.Size * (LineHeight + mLineSpacing))

			Next
		End If
		
		TF.GetObject.As(B4XView).BringToFront
		Printed = PJ.PrintPage(Pn)
		If Printed = False Then Exit
	Next
	
	If Printed Then
		PJ.EndJob
	Else
		PJ.CancelJob
	End If

	Return IIf(Printed,"OK","Failed")
End Sub

Private Sub CreatePages As String
	'Ignore margins when setting up the labelsas by using G.Translate(PF.GetImageableX,PF.GetImageableY) in the Print_Event sub
	'it handles the margins for us
	
	Dim MaxHeight As Double = PJ.GetJobSettings.GetPageLayout.GetPrintableHeight
	Dim MaxWidth As Double = PJ.GetJobSettings.GetPageLayout.GetPrintableWidth

	
	If mAuditColumnWidths.Length > 0 Then
		mTotalAuditColWidth = 0
		For Each i As Int In mAuditColumnWidths
			mTotalAuditColWidth = mTotalAuditColWidth + i
		Next
		MaxWidth = MaxWidth - mTotalAuditColWidth - 2	'a little margin on the right
	End If
	
	LinesPerPage = Floor(MaxHeight / (LineHeight + mLineSpacing))
	
'	Log("Lines Per Page " & LinesPerPage)
	
	Dim Lines As List
	Lines.Initialize
	If TextFile <> "" Then
		If TextFile.StartsWith("AssetsDir") Then
			Lines.AddAll(File.ReadList(File.DirAssets,File.GetName(TextFile)))
		Else
			Lines.AddAll(File.ReadList("",TextFile))
		End If
	End If
	If mTextContent <> "" Then
		Lines.AddAll(Regex.Split($"\r\n|\r|\n"$,mTextContent))
	End If

	If Lines.Size = 0 Then
		Return "No records found"
	End If
	
	If mRemoveDoubleLineSpacing Then
		Dim LastEmpty As Boolean
		For i = Lines.Size - 1 To 0 Step -1
			Dim Line As String = Lines.Get(i).As(String).Trim
			If Line.Length = 0 Then
				If LastEmpty Or i = Lines.Size - 1 Then
					Lines.RemoveAt(i)
				Else
					LastEmpty = True
				End If
			Else
				LastEmpty = False
			End If
		Next
	End If
	
'	Log("Lines Size " & Lines.Size)
	
	Dim DisplayLines As List
	DisplayLines.Initialize

	For i = 0 To Lines.Size - 1

		
		Dim NewDisplayLines As List = GetDisplayLines(MaxWidth,Lines.Get(i))
		
		For Each Line As String In NewDisplayLines
			DisplayLines.Add(Line)
		Next
		
	Next
	
	Dim NoPages As Int = Ceil(DisplayLines.Size / LinesPerPage)
'	Log("NP " & NoPages)
	
	
	For i = 0 To NoPages - 1
		Dim Page As List
		Page.Initialize
		Dim EndLine As Int = Min(LinesPerPage, DisplayLines.Size - (i * LinesPerPage))
'		Log("EL " & EndLine)
		For j = 0 To EndLine - 1
			Dim T As TextClass = NewInstance_TextFlow.Text.SetText(DisplayLines.Get(i * LinesPerPage + j) & CRLF)
			T.SetFont(mFont).SetFill(FX.Colors.From32Bit(mTextColor))

			Page.Add(T)
		Next
		DisplayPages.Add(Page)
	Next
	
	Return ""
End Sub

Private Sub GetDisplayLines(MaxWidth As Double, Line As String) As List
	Dim L As List
	L.Initialize
	Dim OrigLine As String = Line
	Dim SBLine As StringBuilder
	SBLine.Initialize
	SBLine.Append(Line)
	Dim R As B4XRect = MeasureTxtNode.Measure(SBLine.ToString,mFont)
	
	If R.Width > MaxWidth Then
		Dim SBTest As StringBuilder
		SBTest.Initialize
		SBTest.Append(SBRemoveCharAt(SBLine,0))
		R = MeasureTxtNode.Measure(SBTest.ToString,mFont)
		Do While R.Width < MaxWidth
			SBTest.Append(SBRemoveCharAt(SBLine,0))
			R = MeasureTxtNode.Measure(SBTest.ToString,mFont)
		Loop
		If mBreakOnWord Then
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
			Dim i As Int = 0
			Do While OrigLine.CharAt(i) = " " Or OrigLine.CharAt(i) = TAB
				If OrigLine.CharAt(i) = " " Then SBLine.Insert(i," ")
				If OrigLine.CharAt(i) = TAB Then SBLine.Insert(i,TAB)
				i = i + 1
			Loop

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


