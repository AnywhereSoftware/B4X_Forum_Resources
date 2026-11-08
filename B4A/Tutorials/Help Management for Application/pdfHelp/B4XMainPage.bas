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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore

	Private pdf As PDFRenderer
	Private DLGHelp As B4XDialog
	Private IndexValues As Map
	Private HelpFileName As String
	
	' ignore underline
	Private btnOpenPDF As Button
	Private btnPrev As Button
	Private btnNext As Button
	Private lblPages As Label
	Private lblPage As Label
	Private Panel1 As Panel
	Private ZoomImageView1 As ZoomImageView
	Private clvIndex As CustomListView
	Private edtPageNo As EditText
	Private edtTitle As EditText
	Private edtGoPage As EditText
	Private TabHost1 As TabHost
End Sub

Public Sub Initialize As Object
	IndexValues.Initialize
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root1.LoadLayout("B4XMain")
	
	'Initialize Help Dialog
	DLGHelp.Initialize(Root)
	
	' setup helpindex key= page no, value= title
	IndexValues.Put(1,"Index")
	IndexValues.Put(2,"Chapter 1 ...")
	' setup HelpFileName
	HelpFileName="pdfHelp.pdf"
	' set dialog properties
	DLGHelp.Title = "Help AppName"
	DLGHelp.TitleBarColor=Colors.Blue
	DLGHelp.TitleBarTextColor=Colors.White
	DLGHelp.BorderColor=Colors.Blue
	DLGHelp.BorderWidth=2dip
	DLGHelp.BorderCornersRadius=5dip
	DLGHelp.ButtonsColor=Colors.Blue
	DLGHelp.ButtonsTextColor=Colors.white
	DLGHelp.BackgroundColor=Colors.white
End Sub

#region ---- button click , enter pressed---

' This button opens the help dialog
Private Sub BtshowHelp_Click
	' create dialog
	' set dialog panel
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 100%x, 90%y)
	p.LoadLayout("pdfHelp")
	p.SetColorAndBorder(Colors.White,0dip,Colors.Blue,0dip)
	Dim rs1 As ResumableSub = DLGHelp.Showcustom( p,"close","","")
	' set start Values for dialog layout views
	File.Copy(File.DirAssets,HelpFileName,xui.DefaultFolder,HelpFileName)
	' initialize pdf
	pdf.Initialize("",xui.DefaultFolder,"acr1255u.pdf")
	' setup tab0
	TabHost1.AddTab("Help","pdfHelpTab0")
	' set start values
	lblPages.Text = pdf.PageCount
	lblPages.Tag = pdf.PageCount
	lblPage.Text = 1
	lblPage.Tag = 1
	'pdf.InitialRender(bmp)
	ZoomImageView1.mBase.Width=Root.width
	ZoomImageView1.setBitmap(pdf.renderPageforDisplay(1))
	'setup tab1
	TabHost1.AddTab("Index","pdfHelpTab1")
	' set start Values for dialog layout views
	' set table header
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Width = clvIndex.GetBase.Width
	pnl.Height=45dip
	pnl.Color = Colors.Gray
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Width = pnl.Width * 0.15 ' 15%
	lbl.Height=30dip
	lbl.Gravity = Gravity.center
	lbl.Text = "Page"
	lbl.TextColor=Colors.white
	lbl.TextSize=16
	lbl.Typeface=Typeface.DEFAULT_BOLD
	Dim lbl1 As Label
	lbl1.Initialize("")
	lbl1.Width = pnl.Width - lbl.Width - 15dip
	lbl1.Height=30dip
	lbl1.Gravity = Gravity.center
	lbl1.Text = "Title  (click to goto)"
	lbl1.textsize=16
	lbl1.TextColor=Colors.white
	lbl1.Typeface=Typeface.DEFAULT_BOLD
	pnl.AddView(lbl,0,0,lbl.Width,30dip)
	pnl.AddView(lbl1,lbl.Width+10dip,0,lbl1.Width,30dip)
	clvIndex.Add(pnl,0)
	clvIndex.DefaultTextColor=Colors.black
	' set table rows
	For Each k In IndexValues.Keys
		Dim pnl As B4XView = xui.CreatePanel("GoPage")
		pnl.Width = clvIndex.GetBase.Width
		pnl.Height=30dip
		pnl.Color = Colors.White
		Dim lbl As Label
		lbl.Initialize("")
		lbl.Width = pnl.Width * 0.15 ' 25%
		lbl.Height=30dip
		lbl.Gravity = Gravity.right
		lbl.Text = k
		lbl.TextColor=Colors.black
		Dim lbl1 As Label
		lbl1.Initialize("")
		lbl1.Width = pnl.Width - lbl.Width - 15dip
		lbl1.Height=40dip
		lbl1.Gravity = Gravity.left
		lbl1.Text = IndexValues.Get(k)
		lbl1.TextColor=Colors.black
		pnl.AddView(lbl,5dip,0,lbl.Width,40dip)
		pnl.AddView(lbl1,5dip+lbl.Width+5dip,0,lbl1.Width,40dip)
		' add pnl to clv
		clvIndex.Add(pnl,clvIndex.size)
	Next
	
	DLGHelp.Base.Top=5dip
	
	' wait for dialog to close
	Wait For (rs1) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' do nothing
	End If
End Sub

' Goto first Help Page
Private Sub Btfirst_Click
	lblPage.Text = 1
	lblPage.Tag = 1
	ZoomImageView1.setbitmap(pdf.renderPageforDisplay(1))
End Sub

' Goto previous Help Page
Private Sub BtPrev_Click
	Dim p As Int = lblPage.Tag
	If p > 1 Then
		p = p-1
		lblPage.Text = p
		lblPage.Tag = p
		ZoomImageView1.setBitmap(pdf.renderPageforDisplay(p))
	End If
End Sub

' Goto next Help Page
Private Sub BtNext_Click
	Log($"Active Page: ${lblPage.Tag}"$)
	Dim p As Int = lblPage.Tag
	Dim p2 As Int = lblPages.Tag
	Log($"Active Page: ${p} of ${p2}"$)
	If p < p2 Then
		p = p +1
		lblPage.Text = p
		lblPage.Tag = p
		ZoomImageView1.setbitmap(pdf.renderPageforDisplay(p))
	End If
End Sub

' Goto last Help Page
Private Sub BtLast_Click
	lblPage.Text = pdf.PageCount
	lblPage.Tag = pdf.PageCount
	ZoomImageView1.setbitmap(pdf.renderPageforDisplay(pdf.PageCount))
End Sub

' Goto page selected by index
Private Sub clvIndex_ItemClick (Index As Int, Value As Object)
	lblPage.Text = Index
	lblPage.Tag = Index
	ZoomImageView1.setbitmap(pdf.renderPageforDisplay(Index))
	TabHost1.CurrentTab=0
End Sub

' Goto page manually entered
Private Sub edtGoPage_EnterPressed
	If edtGoPage.Text <> "" Then
		If edtGoPage.Text >= 1 And edtGoPage.Text <= pdf.PageCount Then	
			lblPage.Text = edtGoPage.Text
			lblPage.Tag = edtGoPage.Text
			ZoomImageView1.setBitmap(pdf.renderPageforDisplay(edtGoPage.Text ))
		Else
			xui.Msgbox2Async("Page not found!","Goto Page","OK","","",Null)
		End If
		' close keyboard
		Dim im As IME
		im.Initialize("")
		im.HideKeyboard
		' goto tab 1
		TabHost1.CurrentTab=0
	End If
End Sub
#end region

