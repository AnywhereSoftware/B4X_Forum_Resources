B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@


'My links
'File Revision Manager ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=D:\NoInstApps\B4j\FileRevisionManager\FileRevisionManager.jar&Args=%PROJECT%

Sub Class_Globals
	Private fx As JFX
	Private XUI As XUI
	Private CodeEditorWrapper1 As CodeEditorWrapper
	Private MainForm As Form
	
	Private mEditingCode As String
	Private Loaded As Boolean 
	Private btnSave As B4XView
	Private btnRevertEdits As B4XView
	Private pnSaveIndicator As B4XView
	Private pmFontSize As B4XPlusMinus
	Private FontSize As Int = 12
	Private FontUnit As String = "pt"
	Private cbLineNos As CheckBox
	Private B4XComboBox1 As B4XComboBox
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(F As Form)
	XUI.SetDataFolder("CodeEditorWrapper")
	CEW_Utils.Initialize
	
	MainForm = F
	MainForm.RootPane.LoadLayout("Layout1") 'Load the layout file.
	MainForm.Title = "CodeEditorWrapper"
	
	CodeEditorWrapper1.CodeMirrorPath = InitializeFiles
	
	pmFontSize.SetNumericRange(6,30,1)
	pmFontSize.SelectedValue = FontSize
	
	'Register a JS call and map it to the required sub
	CodeEditorWrapper1.RegisterB4XCall("codechanged",Me,"Code_Changed")
	
	CodeEditorWrapper1.SetCode(File.ReadString(File.DirAssets,"code.txt"))
	Loaded = False
	
	B4XComboBox1.SetItems(CEW_Utils.Keys)
	B4XComboBox1.SelectedIndex = 1						'b4X
	B4XComboBox1_SelectedIndexChanged(1)				'B4xCombobox does not raise the changed event for changes by code.
	
	
End Sub

'Page has loaded. Do any post load processing
Private Sub CodeEditorWrapper1_Loaded
	Loaded = True
	'The editor may reformat spaces and layout, so need to update stored version.
	mEditingCode = CodeEditorWrapper1.GetCode
	'Just check and turn off saverequired indicator if OK
	CheckSaveRequired
End Sub

#Region Gui Subs

Sub cbLineNos_CheckedChange(Checked As Boolean)
	If Checked Then
		CodeEditorWrapper1.ShowLineNos("true")
	Else
		CodeEditorWrapper1.ShowLineNos("false")
	End If
End Sub

Private Sub pmFontSize_ValueChanged (Value As Object)
	If Loaded = False Then Return
	FontSize = Value
	CodeEditorWrapper1.SetFontSize(FontSize,FontUnit)
End Sub

#End Region Gui Subs



'Callback from JS, code has changed
Private Sub Code_Changed(New As Object)
	CheckSaveRequired
End Sub

Private Sub btnSave_Click
	'Save the file however you want to.
	Log("SaveFile")
	'Update revert point if you want to
	mEditingCode = CodeEditorWrapper1.GetCode
	'Check and turn off save indicator
	CheckSaveRequired
End Sub


Private Sub btnRevertEdits_Click
	CodeEditorWrapper1.SetCode(mEditingCode)
End Sub


'Check if data has changed and set the save required indicator
Private Sub CheckSaveRequired As Boolean
	Dim SaveRequired As Boolean = Not(mEditingCode = CodeEditorWrapper1.GetCode)
	Dim Color As Int
	If SaveRequired Then 
		Color = XUI.Color_Red
	Else
		Color = XUI.Color_Transparent
	End If
		pnSaveIndicator.SetColorAndBorder(Color,1,Color,0)
	Return SaveRequired
End Sub



Sub btnCopy_Click
	Dim Text As String
	Dim Selected As String = CodeEditorWrapper1.GetSelectedCode
	If Selected = "" Then
		Text = CodeEditorWrapper1.GetCode
	Else
		Text = Selected
	End If
	fx.Clipboard.SetString(Text)
End Sub

Sub B4XComboBox1_SelectedIndexChanged (Index As Int)
	CodeEditorWrapper1.Setstyle(B4XComboBox1.GetItem(Index))
End Sub

Public Sub InitializeFiles As String
	
	Dim PreviousVer As Map
	If File.Exists(XUI.DefaultFolder,"version.txt") Then
		Dim PrevJSONStr As String = File.ReadString(XUI.DefaultFolder,"version.txt")
		Dim J As JSONParser
		J.Initialize(PrevJSONStr)
		PreviousVer = J.NextObject
	Else
		PreviousVer = CreateMap()
	End If
		
	Dim CurrentVer As Map
	Try
		Dim CurrJSONStr As String = File.ReadString(File.DirAssets,"version.txt")
		Dim J As JSONParser
		J.Initialize(CurrJSONStr)
		CurrentVer = J.NextObject
	Catch
		CurrentVer = CreateMap()
		Log(LastException)
	End Try

	Dim Key As String = "codemirror"
	Dim Prev As VersionType = ReadMap(PreviousVer,Key,-1)
	Dim Curr As VersionType = ReadMap(CurrentVer,Key,0)
	
	If  Prev.RelPath <> Curr.RelPath Or  Prev.Version < Curr.Version Then
		File.Copy(File.DirAssets,"codemirror.zip",XUI.DefaultFolder,"codemirror.zip")
		Dim Arc As Archiver
		Log("Updating codemirror library")
		Log(Arc.UnZip(XUI.DefaultFolder,"codemirror.zip",XUI.DefaultFolder,"") & " Files unzipped")
		File.Delete(XUI.DefaultFolder,"codemirror.zip")
	End If
	
	'Copy all these files during development
	'Required for JS interface functions
	File.Copy(File.DirAssets,"wrapper.js",XUI.DefaultFolder,"wrapper.js")
	'Currently empty, but required when changing highlight colours
	File.Copy(File.DirAssets,"wrapper.css",XUI.DefaultFolder,"wrapper.css")
	'File versioning
	File.WriteString(XUI.DefaultFolder,"version.txt",CurrJSONStr)
	
	Return Curr.RelPath
End Sub

Private Sub ReadMap(M As Map,Key As String,VersionDefault As Double) As VersionType
	Dim VT As VersionType
	VT.Initialize
	Dim M1 As Map = M.GetDefault(Key,CreateMap())
	VT.RelPath = M1.GetDefault("RelPath","")
	VT.Version = M1.GetDefault("Version",VersionDefault)
	Return VT
End Sub