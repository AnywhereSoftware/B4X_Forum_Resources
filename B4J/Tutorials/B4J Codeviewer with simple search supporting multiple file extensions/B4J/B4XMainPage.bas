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
	Private btnopen As Button
	Private lblfilename As Label
	Private wvcode As WebView
	Private hclass As htmlclass
	Private fchoose As FileChooser
	Private codefile As String
	Private pnsave As Pane
	Private cbxfiles As B4XComboBox
	Public codefilesfolder As String
	Private pndelete As Pane
	Private tacode As TextArea
	Private tfsearch As TextField
	Private btnsearch As Button
	Private btnnextsearch As Button
	Private strtxt As String
	Private searchcnt As Int
	Private occ As List
	Private btnprevsearch As Button
	Private lblsearchcount As Label
	Private cbxcss As B4XComboBox
	Private currentcss As String
	Private cbxlanguage As B4XComboBox
	Private currentlang As String
	Private langlst As List
	Private selectedindex As Int
	Private btnreset As Button
	Private extension As String
	Private htmlshow As Boolean
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"Codeviewer")
	' folders
	xui.SetDataFolder("Codeviewer")
	File.MakeDir(xui.DefaultFolder,"Codefiles")
	codefilesfolder = File.DirData("Codeviewer") & "\Codefiles\"
	If File.Exists(codefilesfolder,"0_app_description.html") = False Then
		File.Copy(File.DirAssets,"0_app_description.html",codefilesfolder,"0_app_description.html")
	End If
	hclass.Initialize
	fchoose.Initialize
	occ.Initialize
	langlst.Initialize
	CSSUtils.SetStyleProperty(tacode, "-fx-text-fill",CSSUtils.ColorToHex(fx.Colors.ARGB(255,65,89,255)))
End Sub

Private Sub B4XPage_Appear
	reset_UI
	fill_cbxlanguage
	fill_cbxcss
	fill_cbxfiles
End Sub

Private Sub reset_UI
	tacode.Visible = False
	tfsearch.Text = ""
	wvcode.LoadHtml("")
	lblfilename.Text = ""
	lblsearchcount.Text = ""
	htmlshow = False
End Sub

Private Sub btnopen_Click
	codefile = fchoose.ShowOpen(B4XPages.GetNativeParent(B4XPages.MainPage))
	lblfilename.Text = codefile
	If is_supported_file(codefile) Then
		Dim path As String = codefile.SubString2(0,codefile.LastIndexOf("\")+1)
		Dim fname As String = codefile.SubString(codefile.LastIndexOf("\")+1)
		show_file_content(path,fname)
		Return
	Else
		codefile = ""
		xui.MsgboxAsync("This file extension is not supported","Open file")
		B4XPage_Appear
		Return
	End If
End Sub

Private Sub is_supported_file(fn As String) As Boolean
	Dim file_ext As List = Array As String(".bas",".b4a",".b4j",".b4i",".txt", _
										   ".php",".html",".htm",".xml",".css",".js", _
										   ".json",".sql","java",".tpl",".var")
										   ' .tpl and .var are assigned extensions
	For i = 0 To file_ext.Size - 1
		fn = fn.ToLowerCase
		If fn.EndsWith(file_ext.Get(i)) Then
			Return True
		End If
	Next
	Return False
End Sub
Private Sub show_file_content(path As String,fname As String)
	reset_UI
	lblfilename.Text = path & fname
	Dim strtxt As String = File.ReadString(path,fname)
	extension = fname.SubString(fname.LastIndexOf("."))
	Select extension
		Case ".bas",".b4a",".b4j",".b4i"
			currentlang = "b4x"
			selectedindex = 0
		Case ".php"
			currentlang = "php"
			selectedindex = 1
		Case ".html",".htm"
			currentlang = "markup"
			selectedindex = 3
		Case ".xml"
			currentlang = "markup"
			selectedindex = 3
		Case ".css"
			currentlang = "css"
			selectedindex = 4
		Case ".js"
			currentlang = "js"
			selectedindex = 5
		Case ".json"
			currentlang = "json"
			selectedindex = 6
		Case ".sql"
			currentlang = "sql"
			selectedindex = 7
		Case ".java"
			currentlang = "java"
			selectedindex = 8
		Case Else
			currentlang = "markup"
			selectedindex = 3
	End Select
	If lblfilename.Text.Contains("0_app_description.html") Then
		cbxcss.SelectedIndex = 1
		cbxlanguage.SelectedIndex = 2
		Dim htmlstring As String = hclass.set_htmlpage(strtxt,cbxlanguage.SelectedItem,cbxcss.SelectedItem,extension)
		wvcode.LoadHtml(htmlstring)
	Else
		Dim htmlstring As String = hclass.set_htmlpage(strtxt,currentlang,currentcss,extension)
		cbxlanguage.SelectedIndex = selectedindex
		cbxcss.SelectedIndex = 0
		wvcode.LoadHtml(htmlstring)
	End If
End Sub

Sub codebuttons_MouseClicked (EventData As MouseEvent)
	Dim pn As Pane = Sender
	Dim tag As String = pn.Tag
	code_action(tag)
End Sub
Sub code_action(tag As String)
	Select tag
		Case "view"
			tacode.Visible = False
			tfsearch.Text = ""
			lblsearchcount.Text = ""
			If cbxcss.SelectedItem = "w3css" And cbxlanguage.SelectedItem = "html" Then
				If ((extension = ".html") = False) And ((extension = ".htm") = False) Then
					If htmlshow = False Then
						strtxt = show_words_in_html(occ)
						Dim htmlstring As String = hclass.set_htmlpage(strtxt,"html","w3css",extension)
						wvcode.LoadHtml(htmlstring)
						htmlshow = True	
					End If
				End If
			End If
		Case "delete"
			delete_file
		Case "save"
			save_file
		Case "exit"
			ExitApplication
	End Select
End Sub

Private Sub fill_cbxfiles
	Private lstfiles As List = File.ListFiles(codefilesfolder)
	If lstfiles.Size > 0 Then
		cbxfiles.SetItems(lstfiles)
		Dim fname As String = cbxfiles.GetItem(0)
		Dim path As String = codefilesfolder
		If is_supported_file(fname) Then
			show_file_content(path,fname)
		Else
			reset_UI			
		End If
	End If
End Sub
Private Sub cbxfiles_SelectedIndexChanged (Index As Int)
	Log("selectedIndexChanged:" & Index)
	Dim fname As String = cbxfiles.GetItem(Index)
	Dim path As String = codefilesfolder
	If is_supported_file(fname) Then
		currentcss = cbxcss.GetItem(0)
		cbxcss.SelectedIndex = 0
		show_file_content(path,fname)
	Else
		reset_UI
	End If
End Sub

Private Sub save_file
	If lblfilename.Text = "" Then
		Return
	End If
	Dim fname As String = lblfilename.text
	Dim path As String = fname.SubString2(0,fname.LastIndexOf("\")+1)
	Dim fname As String = fname.SubString(fname.LastIndexOf("\")+1)
	Log(path)
	Log(codefilesfolder)
	If path <> codefilesfolder Then
		File.Copy(path,fname,codefilesfolder,fname)
		Log(lblfilename.Text)
		fill_cbxfiles
	Else
		'xui.MsgboxAsync("The file already exists in the folder: " & codefilesfolder,"File exists")
		If tacode.Text <> "" Then
			Dim conf As Object = xui.Msgbox2Async("Replace existing file?","Replace","Yes","Cancel","No",Null)
			Wait For (conf) Msgbox_Result (Result As Int)
			If Result = xui.DialogResponse_Positive Then
				File.WriteString(codefilesfolder,fname,tacode.text)
				strtxt = tacode.Text
				show_file_content(path,fname)
			End If
		End If
	End If
End Sub
Private Sub delete_file
	If lblfilename.Text = "" Then
		Return
	End If
	Dim name As String = lblfilename.Text
	Dim path As String = name.SubString2(0,name.LastIndexOf("\")+1)
	Dim fname As String = name.SubString(name.LastIndexOf("\")+1)
	If path <> codefilesfolder Then
		xui.MsgboxAsync("Only files from the folder " & codefilesfolder & CRLF & "can be deleted!","Delete file")
		reset_UI
		Return
	End If
	Dim conf As Object = xui.Msgbox2Async("Delete file: " & lblfilename.Text,"Delete","Yes","Cancel","No",Null)
	Wait For (conf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		If lblfilename.Text <> "" Then
			File.Delete(path,fname)
			reset_UI
			fill_cbxfiles
		End If
	End If
End Sub

Private Sub btnsearch_Click
	If tfsearch.Text = "" Then
		xui.MsgboxAsync("The search field is empty!","Search")
		Return
	End If
	Dim fname As String = lblfilename.text
	Dim path As String = fname.SubString2(0,fname.LastIndexOf("\")+1)
	Dim fname As String = fname.SubString(fname.LastIndexOf("\")+1)
	strtxt = File.ReadString(path,fname)
	If strtxt.Contains(Chr(13)&Chr(10)) Then strtxt = strtxt.Replace(Chr(13)&Chr(10),Chr(10))
	occ = set_occurences_list
	'Log(occ)
	If occ.Size = 0 Then
		xui.MsgboxAsync("The word was not found!","Search")
		Return
	End If
	searchcnt = 0
	tacode.Visible = True
	tacode.Text = strtxt
	tacode.SetSelection(occ.Get(searchcnt).As(List).Get(0),occ.Get(searchcnt).As(List).Get(1))
	lblsearchcount.Text = (searchcnt+1) & " / " & occ.Size
End Sub
Private Sub btnprevsearch_Click
	If searchcnt <= occ.Size -1 And searchcnt >= 1 Then
		searchcnt = searchcnt - 1
		tacode.SetSelection(occ.Get(searchcnt).As(List).Get(0),occ.Get(searchcnt).As(List).Get(1))
		lblsearchcount.Text = (searchcnt+1) & " / " & occ.Size
	End If
End Sub
Private Sub btnnextsearch_Click
	If searchcnt < occ.Size -1 Then
		searchcnt = searchcnt + 1
		tacode.SetSelection(occ.Get(searchcnt).As(List).Get(0),occ.Get(searchcnt).As(List).Get(1))
		lblsearchcount.Text = (searchcnt+1) & " / " & occ.Size
	End If
End Sub
Private Sub set_occurences_list As List
	Dim occlst As List
	occlst.Initialize
	Dim lst As List
	lst.Initialize
	Dim fname As String = lblfilename.text
	Dim path As String = fname.SubString2(0,fname.LastIndexOf("\")+1)
	Dim fname As String = fname.SubString(fname.LastIndexOf("\")+1)
	strtxt = File.ReadString(path,fname)
	If strtxt <> "" Then
		If strtxt.Contains(Chr(13)&Chr(10)) Then strtxt = strtxt.Replace(Chr(13)&Chr(10),Chr(10))
		Dim sword As String = tfsearch.Text
		Dim startpos As Int = strtxt.IndexOf(sword)
		If startpos <> -1 Then
			Dim endpos As Int = strtxt.IndexOf(sword)+sword.Length
			Dim lst As List
			lst.Initialize
			lst.Add(startpos)
			lst.Add(endpos)
			occlst.Add(lst)
			startpos = endpos
			Do While startpos <> -1
				startpos = strtxt.IndexOf2(sword,startpos)
				If startpos <> -1 Then
					endpos = strtxt.IndexOf2(sword,startpos)+sword.Length
					Dim lst As List
					lst.Initialize
					lst.Add(startpos)
					lst.Add(endpos)
					occlst.Add(lst)
					startpos = endpos
				End If
			Loop
			Return occlst
		Else
			Return Array()
		End If
	Else
		Return Array()
	End If
End Sub

Private Sub fill_cbxcss
	Dim csslst As List = Array As String("prism","w3css")
	cbxcss.SetItems(csslst)
	cbxcss.SelectedIndex = 0
	currentcss = cbxcss.GetItem(0)
End Sub
Private Sub cbxcss_SelectedIndexChanged (Index As Int)
	currentcss = cbxcss.GetItem(Index)
	Dim htmlstring As String = hclass.set_htmlpage(strtxt,currentlang,currentcss,extension)
	wvcode.LoadHtml(htmlstring)
End Sub
Private Sub fill_cbxlanguage
	langlst = Array As String("b4x","php","html","markup","css","js","json","sql","java")
	cbxlanguage.SetItems(langlst)
	cbxlanguage.SelectedIndex = selectedindex
	currentlang = cbxlanguage.GetItem(0)
End Sub
Private Sub cbxlanguage_SelectedIndexChanged (Index As Int)
	currentlang = cbxlanguage.GetItem(Index)
	selectedindex = Index
	Dim htmlstring As String = hclass.set_htmlpage(strtxt,currentlang,currentcss,extension)
	wvcode.LoadHtml(htmlstring)
End Sub

Private Sub btnreset_Click
	B4XPage_Appear
End Sub

Private Sub show_words_in_html(occlst As List) As String
	If occlst.Size > 0 Then
		Dim newtxt As String = strtxt
		Dim sel As String
		Dim startpos As Int
		Dim endpos As Int
		startpos = occlst.Get(0).As(List).Get(0)
		endpos = occlst.Get(0).As(List).Get(1)
		sel = newtxt.SubString2(startpos,endpos)
		newtxt = newtxt.Replace(sel,"<span class='w3-red'>" & sel & "</span>")
		'Log(sel)
		'Log(newtxt)
		Return newtxt
	Else
		Return ""
	End If
End Sub