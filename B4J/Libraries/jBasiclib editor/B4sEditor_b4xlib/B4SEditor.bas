B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
'#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#Event: TestScript(STT as ScriptTestType)
#Event: CloseForm
Sub Class_Globals
	
	Private fx As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public CodeEditor1 As CodeEditor
	Private pnControls As Pane
	Private Dialog As B4XDialog
	Private taTestText As B4XView
	Private taResults As B4XView
	Private mFileDir,mFileName As String
	Private cbCaptureClipBd As CheckBox
	
	Public SplitPane1 As SplitPane
	Private lblTestTextComments As B4XView
	Private btnSEDone As Button
	Private cbRequireArg As CheckBox
	Private MenuBar1 As MenuBar
	Private RecentFiles As RecentFilesManager
	Private mForm As Form
	Private Loaded As Boolean
	Private Version As String = "V1.10"
	Private spTop As SplitPane
	Private spbottom As SplitPane
	Private bbcLog As BBCodeView
	Private bbcerror As BBCodeView
	Private TextEngine1 As BCTextEngine

	Private bcErrorBg As B4XView
	Private bbcLogBg As B4XView
	
	Private LogText, ErrorText As String
	
	Private Blib As jBasicLib
	Private SBLog As StringBuilder
	Private lblArg As B4XView
	Public AppName As String
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	If File.IsDirectory(xui.DefaultFolder,"UserScripts") = False Then
		File.MakeDir(xui.DefaultFolder,"UserScripts")
	End If
	If File.Exists(xui.DefaultFolder,"b4script.chm") = False Then
		File.Copy(File.DirAssets,"b4script.chm",xui.DefaultFolder,"b4script.chm")
	End If

	Blib.Initialize("Blib")

End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	mBase.LoadLayout("b4seditor")
	
	SplitPane1.LoadLayout("splitpanetop")
	SplitPane1.LoadLayout("splitpanebottom")
	
	spTop.LoadLayout("b4seditorpane1")
	spTop.LoadLayout("b4seditorpane2")
	spTop.LoadLayout("b4seditorpane3")
	
	spbottom.LoadLayout("b4seditorpane4")
	spbottom.LoadLayout("b4seditorpane5")
	
	
	TextEngine1.Initialize (bbcLogBg)
	bbcerror.TextEngine = TextEngine1
	
	CreateMenu
	
	Dialog.Initialize(mBase)
	
	CodeEditor1.btnLoad.Visible = False
	CodeEditor1.pnThemes.Visible = False
	CodeEditor1.pnLanguage.Visible = False
	CodeEditor1.CodeMirrorWrapper1.Language = "B4S"
	mForm = Props.Get("Form")
	AppName = mForm.Title
'	Log(CodeEditor1.GetBase.GetView(3).Tag)
	CodeEditor1.GetBase.GetView(3).As(Node).StyleClasses.Add("b4xplusminus")
	
	SetlblArgBG
	
End Sub
Public Sub setAllowedThemes(Themes As List)
	CodeEditor1.AllowedThemes = Themes
End Sub
Public Sub setTheme(Theme As String)
	CodeEditor1.Theme = Theme
End Sub

Public Sub setCode(Code As String)
	CodeEditor1.CodeMirrorWrapper1.SetCode(Code)
End Sub

Public Sub getCode As String
	Return CodeEditor1.CodeMirrorWrapper1.GetCode
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Private Sub cbRequireArg_CheckedChange(Checked As Boolean)
	SetlblArgBG
End Sub

Private Sub cbCaptureClipBd_CheckedChange(Checked As Boolean)
	SetlblArgBG
End Sub

Private Sub SetlblArgBG
	CSSUtils.SetStyleProperty(lblArg,"border-width",0)
	If cbRequireArg.Checked Then
		cbCaptureClipBd.Enabled = True
		If cbCaptureClipBd.Checked = False Then
			CSSUtils.SetStyleProperty(lblArg,"border-width",2)
		End If
	Else
		cbCaptureClipBd.Checked = False
		cbCaptureClipBd.Enabled = False
	End If
End Sub

Private Sub CreateMenu
	MenuBar1.Menus.Clear

	Dim M As Menu
	M.Initialize("File","")
	Dim MI As MenuItem
	MI.Initialize("New","Menu")
	B4sEditor_Static.SetShortCutKey(MI,Array As String("Ctrl","N"))
	M.MenuItems.Add(MI)
	Dim MI As MenuItem
	MI.Initialize("New From Template","Menu")
	B4sEditor_Static.SetShortCutKey(MI,Array As String("Ctrl","T"))
	M.MenuItems.Add(MI)
	Dim MI As MenuItem
	MI.Initialize("Open","Menu")
	B4sEditor_Static.SetShortCutKey(MI,Array As String("Ctrl","O"))
	M.MenuItems.Add(MI)
	Dim MI As MenuItem
	MI.Initialize("Save","Menu")
	B4sEditor_Static.SetShortCutKey(MI,Array As String("Ctrl","S"))
	M.MenuItems.Add(MI)
	
	M.MenuItems.AddAll(Array(NewMenuItem("Menu","Save As",True),MenuSeparatorItem))
	
	Dim RF As Menu
	RF.Initialize("Recent Files","Menu")
	M.MenuItems.Add(RF)
	
	MenuBar1.Menus.Add(M)
	RecentFiles.Initialize(Me,"RecentFiles",RF)
	
	M.MenuItems.AddAll(Array(MenuSeparatorItem,NewMenuItem("Menu","Close",True)))
	
	Dim M As Menu
	M.Initialize("Run","")
	Dim MI As MenuItem
	MI.Initialize("Run","Menu")
	B4sEditor_Static.SetShortCutKey(MI,Array As String("F5"))
	M.MenuItems.Add(MI)
	
	MenuBar1.Menus.Add(M)

	Dim M As Menu
	M.Initialize("Help","")
	M.MenuItems.Add(NewMenuItem("Menu","B4Script Help",True))
	M.MenuItems.Add(MenuSeparatorItem)
	M.MenuItems.Add(NewMenuItem("Menu","About",True))
	
	MenuBar1.Menus.Add(M)
End Sub

Public Sub MenuSeparatorItem As JavaObject
	Dim TJO As JavaObject
	TJO.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem",Null)
	Return TJO
End Sub
Public Sub NewMenuItem(EventName As String,Text As String, Enabled As Boolean) As MenuItem
	Dim Mi As MenuItem
	Mi.Initialize(Text,EventName)
	Mi.Enabled = Enabled
	Return Mi
End Sub



Public Sub RecentFiles_Click (RecentFile As String)
	If File.Exists(File.GetFileParent(RecentFile),File.GetName(RecentFile)) = False Then
		Dialog.Title = "Load File"
		Wait For (Dialog.Show($"File ${File.GetName(RecentFile)} has been moved or deleted, remove from list?"$ ,"OK","","Cancel")) Complete (Resp As Int)
		If Resp = xui.DialogResponse_Positive Then
			RecentFiles.RemoveFile(RecentFile)
		End If
		Return
	End If
	
	SetFile(File.GetFileParent(RecentFile),File.GetName(RecentFile))

End Sub

Private Sub SetDividerPositions
	
	Dim Div0 As Double = B4sEditor_Static.Opts.GetDefault("SPTopDiv0",0.5)
	Dim Div1 As Double = B4sEditor_Static.Opts.GetDefault("SPTopDiv1",0.75)
	Dim SPJO As JavaObject = spTop
	Dim Delay As Int = 50

	SPJO.RunMethod("setDividerPosition",Array(1,1.0))
	Sleep(Delay)
	SPJO.RunMethod("setDividerPosition",Array(0,1.0))
	Sleep(Delay)
	spTop.DividerPositions = Array As Double(Div0,Div1)
	Sleep(Delay)
	SplitPane1.DividerPositions = Array As Double(B4sEditor_Static.Opts.GetDefault("SPDiv0",0.75))
End Sub

Private Sub SaveDividerPositions
	B4sEditor_Static.Opts.Put("SPDiv0",SplitPane1.DividerPositions(0))
	B4sEditor_Static.Opts.Put("SPTopDiv0",spTop.DividerPositions(0))
	B4sEditor_Static.Opts.Put("SPTopDiv1",spTop.DividerPositions(1))
End Sub

'Load the saved Options.
'If you want to save the options yourself then use
'SetOptions and GetOptions
Public Sub LoadOptions
	If File.Exists(xui.DefaultFolder,"Opts.dat") = False Then
		B4sEditor_Static.Opts = CreateMap()
	Else
		Dim RAf As RandomAccessFile
		RAf.Initialize(xui.DefaultFolder,"Opts.dat",True)
		B4sEditor_Static.Opts = RAf.ReadB4XObject(0)
		RAf.Close
	End If
	B4sEditor_Static.SetFormMetrics(mForm,"")
	SetDividerPositions
End Sub

Public Sub SetOptions(Opts As Map)
	B4sEditor_Static.Opts = Opts
	B4sEditor_Static.SetFormMetrics(mForm,"")
	SetDividerPositions
End Sub

'Saved the current Options.
'If you want to save the options yourself then use
'SetOptions and GetOptions
Public Sub SaveOptions
	B4sEditor_Static.SaveFormMetrics(mForm,"")
	SaveDividerPositions
	Dim RAf As RandomAccessFile
	RAf.Initialize(xui.DefaultFolder,"Opts.dat",False)
	RAf.WriteB4XObject(B4sEditor_Static.Opts,0)
	RAf.Close
End Sub

Public Sub GetOptions As Map
	Return B4sEditor_Static.Opts
End Sub

Private Sub Menu_Action
	
	Dim MI As MenuItem = Sender
	Select MI.Text
		Case "New"
			NewFile
		Case "New From Template"
			NewFromTemplate
		Case "Open"
			LoadFile
			
		Case "Save"
			If mFileName = "" Then
				SaveFile(CodeEditor1.CodeMirrorWrapper1.GetCode,False)
			Else
				CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)
			End If
			CodeEditor1.UpdateRevertPoint
			CodeEditor1.CheckSaveRequired
		Case "Save As"
			SaveFile(CodeEditor1.CodeMirrorWrapper1.GetCode,False)
		Case "B4Script Help"
			fx.ShowExternalDocument(File.GetUri(xui.DefaultFolder,"B4Script.chm"))
		Case "About"
			Dialog.Title = ""
			Dim P As B4XView = xui.CreatePanel("")
			P.LoadLayout("About")
			P.SetLayoutAnimated(0,0,0,400,300)
			P.GetView(0).GetView(0).Text = Version
			Dim C As Int = Dialog.BackgroundColor
			Dialog.BackgroundColor = 0xFF0081E4
			Wait For(Dialog.ShowCustom(P,"OK","","")) Complete (Result As Int)
			Dialog.BackgroundColor = C
			
		Case "Close"
			CloseForm
			
		Case "Run"
			btnTestScript_Click
	End Select
	
End Sub

Private Sub NewFile
	If Loaded And CodeEditor1.CheckSaveRequired Then
		Dialog.Title = "Unsaved changes"
		Wait For(Dialog.Show("Save Changes","Save","Load","Cancel")) Complete (Resp As Int)
		
		If Resp = xui.DialogResponse_Cancel Then Return
		If Resp = xui.DialogResponse_Positive Then
			CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)
		End If
	End If
	If SaveFile("",False) Then
		CodeEditor1.CodeMirrorWrapper1.SetCode("")
	End If
End Sub

Private Sub NewFromTemplate
	If Loaded And CodeEditor1.CheckSaveRequired Then
		Dialog.Title = "Unsaved changes"
		Wait For(Dialog.Show("Save Changes","Save","Load","Cancel")) Complete (Resp As Int)
		
		If Resp = xui.DialogResponse_Cancel Then Return
		If Resp = xui.DialogResponse_Positive Then
			CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)
		End If
	End If
	
	
	Dim Code As String = File.ReadString(File.DirAssets,"template.b4s")
'	Code = Code.Replace("XXPathToLibScriptsXX",File.Combine(File.Combine(xui.DefaultFolder,"Scripts"),"cmmlibrary.vbs"))
	
	If SaveFile(Code,False) Then
		CodeEditor1.CodeMirrorWrapper1.SetCode(Code)
	End If
End Sub

Public Sub CheckSaveRequired As Boolean
	Return CodeEditor1.CheckSaveRequired
End Sub

Public Sub SetFile(FileDir As String, FileName As String)
	
	If Loaded And CodeEditor1.CheckSaveRequired Then
		Dialog.Title = "Unsaved changes"
		Wait For(Dialog.Show("Save Changes","Save","Load","Cancel")) Complete (Resp As Int)
		
		If Resp = xui.DialogResponse_Cancel Then Return
		If Resp = xui.DialogResponse_Positive Then
			CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)
		End If
	End If
	
	Loaded = False
	
	mFileDir = FileDir
	mFileName = FileName
	
	B4sEditor_Static.Opts.Put("FileDir",mFileDir)
	B4sEditor_Static.Opts.Put("FileName",mFileName)
	
	If File.Exists(FileDir,FileName) Then
		CodeEditor1.CodeMirrorWrapper1.SetCode(File.ReadString(FileDir,FileName))
	Else
		File.Copy(File.DirAssets,"template.b4s",FileDir,FileName)
		Dim Code As String = File.ReadString(FileDir,FileName)
'		Code = Code.Replace("XXPathToLibScriptsXX",File.Combine(File.Combine(xui.DefaultFolder,"Scripts"),"cmmlibrary.vbs"))
		CodeEditor1.CodeMirrorWrapper1.SetCode(Code)
	End If
	Dim FilePath As String = File.Combine(FileDir,FileName)
	mForm.Title = AppName & " - " & FilePath
	RecentFiles.AddFile(FilePath)
End Sub

Public Sub setTestText(Text As String)
	taTestText.Text = Text
End Sub

Public Sub setTestTextComments(Text As String)
	lblTestTextComments.Text = Text
End Sub

Public Sub setResult(Text As String)
	taResults.Text = Text
End Sub

Private Sub SaveFile(Code As String,SetInitial As Boolean) As Boolean
	
	Dim FC As FileChooser
	FC.Initialize
	FC.InitialDirectory = B4sEditor_Static.Opts.GetDefault("FileDir",xui.DefaultFolder)
	If SetInitial Then FC.InitialFileName = mFileName
	FC.SetExtensionFilter("B4 script file",Array("*.b4s"))
	
	Dim FileName As String = FC.ShowSave(mForm)
	
	If FileName = "" Then Return False
	
	mFileDir = File.GetFileParent(FileName)
	mFileName = File.GetName(FileName)
	
	B4sEditor_Static.Opts.Put("FileDir",mFileDir)
	B4sEditor_Static.Opts.Put("FileName",mFileName)
	
	CodeEditor1_SaveFileRequest(Code)
	mForm.Title = AppName & " - " & FileName
	RecentFiles.AddFile(FileName)
	
	Return True
End Sub

Public Sub LoadFile
	
	Dim FC As FileChooser
	FC.Initialize
	FC.InitialDirectory = B4sEditor_Static.Opts.GetDefault("FileDir",xui.DefaultFolder)
	FC.SetExtensionFilter("B4 script file",Array("*.b4s"))
	
	Dim FileName As String = FC.ShowOpen(mForm)
	
	If FileName = "" Then Return
	
	SetFile(File.GetFileParent(FileName),File.GetName(FileName))
	
End Sub

Private Sub CodeEditor1_SaveFileRequest(Code As String) As ResumableSub
	If mFileName = "" Then
		If SaveFile(Code,True) = False Then Return False
	Else
		File.WriteString(mFileDir,mFileName,Code)
	End If
	Return True
End Sub

Private Sub CodeEditor1_Loaded
	Loaded = True
End Sub

Private Sub btnTestScript_Click
	If cbRequireArg.Checked And  cbCaptureClipBd.Checked = False And  taTestText.Text = "" Then
		Dialog.Title = "Test Script"
		Wait For(Dialog.Show("No Arg Set","OK","","")) Complete (Resp As Int)
		Return
	End If
	setTestTextComments("")
	taResults.Text = ""
	If mFileName = "" Then
		'Save the code
		Wait For (CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)) Complete (Bresp As Boolean)
		If Bresp = False Then Return
		CodeEditor1.UpdateRevertPoint
	End If
	RunScript(taTestText.Text)
End Sub

Private Sub btnSEDone_Click
	If CodeEditor1.CheckSaveRequired Then
		Dialog.Title = "Unsaved changes"
		Wait For(Dialog.Show("Save Changes","Save","Exit","Cancel")) Complete (Resp As Int)
		
		If Resp = xui.DialogResponse_Cancel Then Return
		If Resp = xui.DialogResponse_Positive Then
			CodeEditor1_SaveFileRequest(CodeEditor1.CodeMirrorWrapper1.GetCode)
		End If
	End If
	
	
	CloseForm
End Sub

Public Sub CloseForm
	RecentFiles.SaveList
	SaveOptions
	mForm.Close
End Sub

Private Sub RunScript(Text As String)
	
	SBLog.Initialize
		
	ConsoleLogColor("Parsing Code", xui.Color_Gray)
	
	Dim Code As String = CodeEditor1.CodeMirrorWrapper1.GetCode
'	Dim ParseResult As String =  ParseCode(Code)
'	If ParseResult <> "" Then
'		ErrorLog(ParseResult)
'		ConsoleLogColor("Parse failed", xui.Color_Gray)
'		Return
'	End If
		
	ConsoleLogColor("Running Code", xui.Color_Gray)
		
	Dim PassString As String
	
	If cbRequireArg.Checked Then
		If cbCaptureClipBd.Checked Then
			If fx.Clipboard.HasString Then
				PassString = fx.Clipboard.getString
				Sleep(100)
			End If
			If fx.Clipboard.HasString = False Or PassString = "" Then
				Dialog.Title = "RunScript"
				Wait For(Dialog.Show("No String on Clipboard or clipboard has an empty string","","","OK")) Complete (Resp As Int)
				Return
			End If
			If fx.Clipboard.HasString And PassString.Trim = "" Then
				lblTestTextComments.Text  = "Clipboard has white space: Length of " & PassString.Length
			End If
		

			taTestText.Text = PassString
		Else If Text <> "" Then
			PassString = Text
		End If
	End If
	LogText = ""
	ErrorText = ""
	
	bbcLog.Text = ""
	bbcerror.Text = ""
	Dim Args() As String = Array As String(PassString)
	

	If Blib.LoadCodeAsString(Code) = False Then
		bbcerror.Text = Blib.ErrorString
		ConsoleLogColor("Run Failed",xui.Color_Red)
		Return
	End If
'	Log(Blib.Program.As(List))
	

	Blib.Run(Args)

	Sleep(0)
	
	If Blib.ErrorString <> "" Then
		bbcerror.Text =  "Line " & Blib.LineNumber & " : " &  Blib.ErrorString
		ConsoleLogColor("Run Failed",xui.Color_Red)
		Return
	End If
	
	ConsoleLogColor("Run OK",xui.Color_Gray)
	taResults.Text = Args(0)
End Sub

Private Sub blib_Message(message As String, subject As String) 'Raised by Msgbox or Print

	If subject = "Print" Then
		
		If message.ToLowerCase.StartsWith("logc") Then
			Dim MArr() As String = Regex.split(" ",message)
			If MArr.Length < 3 Then
				ConsoleLog(MArr(1))
				Return
			Else
				Dim SB As StringBuilder
				SB.Initialize
				For i = 1 To MArr.Length - 2
					SB.Append(MArr(i))
					SB.Append(" ")
				Next
				ConsoleLogColor(SB.ToString.trim,MArr(MArr.Length - 1))
			End If
		Else If message.ToLowerCase.StartsWith("log") Then
			Dim MArr() As String = Regex.split(" ",message)
			Dim SB As StringBuilder
			SB.Initialize
			For i = 1 To MArr.Length - 1
				SB.Append(MArr(i))
				SB.Append(" ")
			Next
			ConsoleLog(SB.ToString)
			Return
			
		End If
	Else 
		Wait For (xui.MsgboxAsync(message, subject)) Msgbox_Result (Result As Int)
	End If
End Sub

Public Sub ConsoleLog(Text As String)
	SBLog.append(Text)
	SBLog.append(CRLF)
	bbcLog.Text = SBLog.ToString
End Sub

Public Sub ErrorLog(Text As String)
	bbcerror.Text = Text
End Sub

Public Sub ConsoleLogColor(Text As String, Clr As String)
	If Clr = "" Or IsNumber(Clr) = False Then
		ConsoleLog(Text)
		Return
	End If
	Dim Bc As ByteConverter
	Dim ClrStr As String = "#" & Bc.HexFromBytes(Bc.IntsToBytes(Array As Int(Bit.And(Clr,0xFFFFFF))))
	
	SBLog.append($"[color=${ClrStr}]${Text}[/color]"$)
	SBLog.append(CRLF)
	bbcLog.Text = SBLog.ToString
End Sub

Private Sub RunScript_StdOut (Buffer() As Byte, Length As Int)
	Dim Msg As String = BytesToString(Buffer,0,Length,"UTF8")
	CallSubDelayed2(Me,"Process_StdOut",Msg)
End Sub

Private Sub Process_StdOut(Msg As String)
	
	Dim L As List = Regex.Split(CRLF,Msg)
	For i = 1 To L.Size - 1
		LogText = LogText & L.Get(i) & CRLF
	Next
	bbcLog.Text = LogText
End Sub

Private Sub RunScript_StdErr (Buffer() As Byte, Length As Int)
	Dim msg As String = BytesToString(Buffer,0,Length,"UTf8")
	CallSubDelayed2(Me,"Process_Err",msg)
End Sub

Private Sub Process_Err(Msg As String)
	If Msg.CharAt(0) = CRLF Then
		Dim L As List = Regex.Split(CRLF,Msg)
		For i = 1 To L.Size - 1
		ErrorText = ErrorText & $"[Color=#FF0000]${L.Get(i)}[/Color]${CRLF}"$
		Next
	Else
		ErrorText = ErrorText  & $"[Color=#FF0000]${Msg}[/Color]${CRLF}"$
	End If
	
	bbcerror.Text = ErrorText
End Sub

Public Sub SetDialogstylePreShow(D As B4XDialog)
	D.TitleBarColor = -16743496
	D.ButtonsColor = -11184811
	D.ButtonsTextColor = -7744001
	D.BackgroundColor = 0xdddddddd
	D.BodyTextColor = -1
	D.TitleBarTextColor = -1
End Sub

Private Sub btnResult2Clip_Click
	fx.Clipboard.SetString(taResults.Text)
End Sub