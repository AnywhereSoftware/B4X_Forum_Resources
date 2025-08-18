B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.19
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private CodeArea1 As CodeArea
	Private LastLine As Int = -1
	Private NextPageCount As Int = 0
	Private Pages As List
	Private MaxHeight As Int
	Private Font1 As Font
	Private mPJ As PrinterJob
	Private T1 As Timer
	
	Type TextMetric (Width As Int,Height As Int)
End Sub

'Print text with Formatting.  Requires fontsize (as pt)
Public Sub Print(Text As String,FontSize As Double)
	
	mPJ = PrinterJob_Static.CreatePrinterJob
    mPJ.ShowPageSetupDialog(Null)
	
	Pages.Initialize
	Pages.Add("")
	
	Dim JS As JobSettings = mPJ.GetJobSettings
	Dim PL As PageLayout = JS.GetPageLayout
	Dim Width As Int = PL.GetPrintableWidth
	Dim Height As Int = PL.GetPrintableHeight
	
	CodeArea1.Initialize(Null,"")
	CodeArea1.Setup(Null,Null,	0,0,Width,Height)
	CodeArea1.WrapText = True
	
	MaxHeight = PL.GetPrintableHeight - PL.GetTopMargin - PL.GetBottomMargin
	
	CSSUtils.SetStyleProperty(CodeArea1.GetObject,"-fx-font-size",$"${FontSize}px"$)
	
	Font1 = fx.CreateFont("monospace",FontSize,False,False)
	 
	 T1.Initialize("T1",500)
	
	Parse(Text,Width)
End Sub

Private Sub Parse(Text As String,Width As Int)
	Dim Lines() As String = Regex.Split(CRLF,Text)
	Dim TestText As String
	LastLine = -1
	Dim i As Int = 0
	
	Do While i < Lines.Length
		TestText = ""
		For i = LastLine + 1 To Lines.Length - 1
			If MeasureText(TestText & Lines(i),Width).Height + 100 > MaxHeight Then Exit
			If Main.cbLineNos.Checked Then TestText = TestText  & NumberFormat(LastLine + 2,3,0) & " "
			TestText = TestText & Lines(i)
			If i < Lines.Length - 1 Then TestText = TestText & CRLF
			LastLine = i
		Next
		Pages.Add(TestText)
	Loop
	
	CallSubDelayed(Null,"Page_Ready")
	
End Sub

Private Sub PageAvailable As Boolean
	Return NextPageCount < Pages.Size
End Sub

Private  Sub SendNextPage
	Dim NextPage As String = Pages.Get(NextPageCount)
	CodeArea1.ReplaceText(0,CodeArea1.Length,NextPage)
	NextPageCount = NextPageCount + 1
	T1.Enabled = True
End Sub

Private Sub T1_Tick
	T1.Enabled = False
	CodeArea1.Tag = NextPageCount - 1
	CallSubDelayed(Null,"Next_Page")
End Sub

Private Sub Page_Ready
	
	If mPJ.ShowPrintDialog(Null) And PageAvailable Then SendNextPage
		
End Sub

Private Sub Next_Page
	mPJ.PrintPage(CodeArea1.GetObject)
	If PageAvailable Then 
		SendNextPage
		Return
	Else
		mPJ.EndJob
		NextPageCount = 0
	End If
End Sub

Private  Sub MeasureText(Text As String,Width As Double) As TextMetric
    Dim TB,Bounds As JavaObject
    Dim TM As TextMetric

    TB.InitializeStatic("javafx.scene.text.TextBuilder")
    Bounds = TB.RunMethodJO("create",Null).RunMethodJO("text",Array(Text)).RunMethodJO("wrappingWidth",Array(Width)).RunMethodJO("font",Array(Font1)).RunMethodJO("build",Null).RunMethodJO("getLayoutBounds",Null)

    TM.Width = Bounds.RunMethod("getWidth",Null)
    TM.Height = Bounds.RunMethod("getHeight",Null)
    Return TM
End Sub
