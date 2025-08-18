B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	Public joswing As JavaObject
	Public jofile As JavaObject
	Public joPDDocument As JavaObject
	Public jopdfdoc As JavaObject
	Public jorenderer As JavaObject
	Public joscreen As JavaObject
	Private sppdf As ScrollPane
	Public pnpdf As Pane
	Private sppagepdf As ScrollPane
	Public pnpagepdf As Pane
	Public pdffile As String
	Public dpi As Float
	Private img As Object
	Private pagenumber As Int
	Private zoom As Float
	Public ivpdf As ImageView
	Private btnnext As Button
	Private btnprev As Button
	Private lblnumpages As Label
	Private numpages As Int
	Private ftfpagenum As B4XFloatTextField
	Private btnopen As Button
	Private fchoose As FileChooser
	Private btnend As Button
	Private btnstart As Button
	Private swscrolling As B4XSwitch
	Public allpages_available As Boolean
End Sub
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"PDFBox test")
	fchoose.Initialize
	pdffile = ""
	If pdffile <> "" Then
		initpage
		swscrolling.Value = False
		reset_UI
		swscrolling.Value = False
		allpages_available = False
		renderpage(pagenumber)
	Else
		xui.MsgboxAsync("Please load a PDF file first!","Load PDF file")
		swscrolling.Value = True
		reset_UI
		Return
	End If
End Sub
Private Sub initpage
	joswing.InitializeStatic("javafx.embed.swing.SwingFXUtils")
	jofile.InitializeNewInstance("java.io.File",Array(pdffile))
	joPDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
	jopdfdoc = joPDDocument.RunMethod("load",Array(jofile))
	jorenderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(jopdfdoc))
	dpi = joscreen.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)
	numpages = jopdfdoc.RunMethod("getNumberOfPages",Array())
	lblnumpages.Text = " Total pages: " & numpages
	pagenumber = 1
	zoom = 0.8
	ivpdf.Initialize("")
	pnpdf.Initialize("")
	pnpagepdf.Initialize("")
	ftfpagenum.Text = pagenumber	
End Sub
Private Sub renderpage(pnum As Int)
	img = jorenderer.RunMethod("renderImageWithDPI",Array(pnum-1,dpi*zoom))
	ivpdf.SetImage(joswing.RunMethodjo("toFXImage",Array(img,Null)))
	pnpagepdf.RemoveAllNodes
	pnpagepdf.AddNode(ivpdf,0,0,ivpdf.Width,ivpdf.Height)
	sppagepdf.InnerNode = pnpagepdf
	sppagepdf.InnerNode.PrefHeight = 1185dip * zoom
	sppagepdf.VPosition = 0
End Sub
Private Sub renderallpages
	If allpages_available = True Then
		Return
	End If
	pnpdf.RemoveAllNodes
	Dim toppos As Int = 0
	For i = 0 To numpages - 1
		img = jorenderer.RunMethod("renderImageWithDPI",Array(i,dpi*zoom))
		Dim iv As ImageView
		iv.Initialize("")
		iv.SetImage(joswing.RunMethodjo("toFXImage",Array(img,Null)))
		pnpdf.AddNode(iv,0,toppos,iv.Width,iv.Height)
		toppos = toppos + (1185dip * zoom)
	Next
	sppdf.InnerNode = pnpdf
	sppdf.InnerNode.PrefHeight = 1185dip * zoom * numpages
	sppdf.VPosition = 0
	allpages_available = True
	Sleep(0)
End Sub
Private Sub ftfpagenum_EnterPressed
	If ftfpagenum.text <> ""  And IsNumber(ftfpagenum.Text)  Then
		pagenumber = ftfpagenum.Text
		If (pagenumber < 1 Or pagenumber > numpages) Then
			xui.MsgboxAsync("Pick a number between 1 and " & numpages,"Page number")
		Else
			If swscrolling.Value = True Then
				Dim ph As Int = (1185 * zoom)
				Dim totph As Int = ((1185 * zoom) * numpages) - sppdf.PrefHeight
				Dim vpos As Double = ph * (ftfpagenum.Text -1) / totph
				'Log(vpos)
				sppdf.VPosition = vpos
			Else
				renderpage(pagenumber)
			End If
			renderpage(pagenumber)
		End If
	End If
End Sub
Private Sub btnprev_Click
	If pagenumber <= 1 Then
		pagenumber = 1
	Else
		pagenumber = pagenumber - 1
	End If
	ftfpagenum.Text = pagenumber
	renderpage(pagenumber)
End Sub
Private Sub btnnext_Click
	If pagenumber >= numpages Then
		pagenumber = numpages
	Else
		pagenumber = pagenumber + 1
	End If
	ftfpagenum.Text = pagenumber
	renderpage(pagenumber)
End Sub
Private Sub btnstart_Click
	pagenumber = 1
	ftfpagenum.Text = pagenumber
	renderpage(pagenumber)
End Sub
Private Sub btnend_Click
	pagenumber = numpages
	ftfpagenum.Text = pagenumber
	renderpage(pagenumber)
End Sub
Private Sub btnopen_Click
	pdffile = fchoose.ShowOpen(B4XPages.GetNativeParent(B4XPages.MainPage))
	If pdffile.EndsWith(".pdf") Then
		If jopdfdoc.IsInitialized Then
			jopdfdoc.RunMethod("close",Null)
		End If
		swscrolling.Value = False
		reset_UI
		allpages_available = False
		If pnpdf.IsInitialized Then
			pnpdf.RemoveAllNodes
		End If
		initpage
		renderpage(pagenumber)
		Return
	Else
		pdffile = ""
		xui.MsgboxAsync("No PDF file selected","Open file")
		Return
	End If
End Sub
Private Sub reset_UI
	If swscrolling.Value = True Then
		sppdf.Visible = True
		sppagepdf.Visible = False
		btnstart.Enabled = False
		btnprev.Enabled = False
		btnnext.Enabled = False
		btnend.Enabled = False
		buttons_colors_disabled
	Else
		sppdf.Visible = False
		sppagepdf.Visible = True
		btnstart.Enabled = True
		btnprev.Enabled = True
		btnnext.Enabled = True
		btnend.Enabled = True
		buttons_colors_enabled
	End If
End Sub
Private Sub buttons_colors_disabled
	CSSUtils.SetBackgroundColor(btnstart,fx.Colors.From32Bit(0xFFF7C8C4))
	CSSUtils.SetBackgroundColor(btnprev,fx.Colors.From32Bit(0xFFF7C8C4))
	CSSUtils.SetBackgroundColor(btnnext,fx.Colors.From32Bit(0xFFF7C8C4))
	CSSUtils.SetBackgroundColor(btnend,fx.Colors.From32Bit(0xFFF7C8C4))
End Sub
Private Sub buttons_colors_enabled
	CSSUtils.SetBackgroundColor(btnstart,fx.Colors.From32Bit(0xFFA2FF91))
	CSSUtils.SetBackgroundColor(btnprev,fx.Colors.From32Bit(0xFFA2FF91))
	CSSUtils.SetBackgroundColor(btnnext,fx.Colors.From32Bit(0xFFA2FF91))
	CSSUtils.SetBackgroundColor(btnend,fx.Colors.From32Bit(0xFFA2FF91))
End Sub
Private Sub swscrolling_ValueChanged (Value As Boolean)
	If pdffile = "" Then
		Return
	End If
	If Value = True Then
		reset_UI
		CSSUtils.SetBackgroundColor(lblnumpages,fx.Colors.From32Bit(0xFFF99898))
		lblnumpages.Text = "Loading ..."
		Sleep(200)
		renderallpages
		CSSUtils.SetBackgroundColor(lblnumpages,fx.Colors.From32Bit(0xFF7CFF80))
		lblnumpages.Text = " Total pages: " & numpages
		pagenumber = 1
		ftfpagenum.Text = pagenumber
		sppdf.VPosition = 0
	Else
		reset_UI
		pagenumber = 1
		ftfpagenum.Text = pagenumber
		renderpage(pagenumber)
	End If
End Sub