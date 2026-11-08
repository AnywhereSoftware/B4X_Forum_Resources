B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#Event: SaveFileRequest(Code As String) as ResumableSub
#Event: LoadFileRequest As ResumableSub
#Event: Loaded

Sub Class_Globals
	Private fx As JFX
	Private XUI As XUI
	Public CodeMirrorWrapper1 As CodeMirrorWrapper

	Private mCallBack As Object
	Private mEventname As String
	Private mBase As B4XView
	
	Private mEditingCode As String
	Private Loaded As Boolean 
	Public btnLoad As B4XView
	Private btnSave As B4XView
	Private btnRevertEdits As B4XView
	Private pnSaveIndicator As B4XView
	Private pmFontSize As B4XPlusMinus
	Private MinFontsize As Int = 6
	Private mFontSize As Int = 12
	Private MaxFontSize As Int = 30
	Private FontUnit As String = "pt"
	Private cbLineNos As CheckBox
	
	Private cbLang As B4XComboBox
	Private cbThemes As B4XComboBox
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object, EventName As String)
	mCallBack = CallBack
	mEventname = EventName
	CMW_Utils.Initialize
	
End Sub

Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Tag = Me
	
	mBase.LoadLayout("codeeditorlayout") 'Load the layout file.
	
	
	pmFontSize.SetNumericRange(MinFontsize,MaxFontSize,1)
	pmFontSize.SelectedValue = mFontSize
	
	'Register a JS call and map it to the required sub
	CodeMirrorWrapper1.RegisterB4XCall("codechanged",Me,"Code_Changed")
	
	CodeMirrorWrapper1.SetCode("")
	Loaded = False
	
	cbLang.SetItems(CMW_Utils.Languages)
	cbLang.SelectedIndex = 1						'b4X
	cbLang_SelectedIndexChanged(1)				'B4xCombobox does not raise the changed event for changes by code.
	
End Sub

'Page has loaded. Do any post load processing
Private Sub CodeMirrorWrapper1_Loaded
	Loaded = True
	'The editor may reformat spaces and layout, so need to update stored version.
	mEditingCode = CodeMirrorWrapper1.GetCode
	'Just check and turn off saverequired indicator if OK
	CheckSaveRequired
	
	If SubExists(mCallBack,mEventname & "_Loaded") Then
		CallSub(mCallBack,mEventname & "_Loaded")
	End If
End Sub

#Region Gui Subs

'Get / Set the Language for this CodeEditor, 
'A full list of available Languages is available by calling <code>CMW_Utls.Languages</code>
'or viewing it's code.
Public Sub setLanguage(Language As String)
	Dim Pos As Int = cbLang.cmbBox.Items.IndexOf(Language)
	If Pos > -1 Then cbLang.SelectedIndex = Pos
	cbLang_SelectedIndexChanged(Pos)
End Sub

Public Sub getLanguage As String
	Return cbLang.SelectedItem
End Sub

Private Sub cbLang_SelectedIndexChanged (Index As Int)
	CodeMirrorWrapper1.Language = cbLang.GetItem(Index)
End Sub

Private Sub cbThemes_SelectedIndexChanged (Index As Int)
	CodeMirrorWrapper1.SetTheme(cbThemes.GetItem(Index))
End Sub

Public Sub setShowLineNos(State As Boolean)
	cbLineNos.Checked = State
End Sub

Public Sub getShowLineNos As Boolean
	Return cbLineNos.Checked
End Sub

Private Sub cbLineNos_CheckedChange(Checked As Boolean)
	If Checked Then
		CodeMirrorWrapper1.ShowLineNos("true")
	Else
		CodeMirrorWrapper1.ShowLineNos("false")
	End If
End Sub

Public Sub setFontSize(Size As Int)
	If Loaded = False Or Size < MinFontsize Or Size > MaxFontSize Then Return
	pmFontSize.SelectedValue = Size
	pmFontSize_ValueChanged (Size)
End Sub

'Set the allowed themes for this codeeditor.
'Get a full list of all defined themes using:
'<code>CMW_Utils.GetThemes</code>
'Themes are all lower cased
Public Sub setAllowedThemes(Themes As List)
	CodeMirrorWrapper1.SetAllowedThemes(Themes)
	cbThemes.SetItems(Themes)
End Sub

'Get / Set a theme for this codeeditor
'Themes are all lowercased and must be in the AllowedThemes List
Public Sub setTheme(Theme As String)
	CodeMirrorWrapper1.Theme = Theme	
End Sub

Public Sub getFontSize As Int
	Return mFontSize
End Sub

Private Sub pmFontSize_ValueChanged (Value As Object)
	If Loaded = False Then Return
	mFontSize = Value
	CodeMirrorWrapper1.SetFontSize(mFontSize,FontUnit)
End Sub

#End Region Gui Subs


'Callback from JS, code has changed
Private Sub Code_Changed(New As Object)
	CheckSaveRequired
End Sub

Private Sub btnSave_Click
	'Callback for save file.
	If SubExists(mCallBack,mEventname & "_SaveFileRequest") Then
		Wait For (CallSub2(mCallBack,mEventname & "_SaveFileRequest",CodeMirrorWrapper1.GetCode)) Complete (Resp As Boolean)
		If Resp Then 
			'Update revert point if you want to
			mEditingCode = CodeMirrorWrapper1.GetCode
		End If
	End If
	CheckSaveRequired
End Sub

Public Sub UpdateRevertPoint
	mEditingCode = CodeMirrorWrapper1.GetCode
	CheckSaveRequired
End Sub

Private Sub btnLoad_Click
	'Callback for load file.
	If SubExists(mCallBack,mEventname & "_LoadFileRequest") Then
		Wait For (CallSub(mCallBack,mEventname & "_LoadFileRequest")) Complete (CodeChanged As Boolean)

		'Disable update to codeeditor until code is loaded
		If CodeChanged Then Loaded = False

	End If
End Sub

Public Sub Base_resize(Width As Double,Height As Double)
'	Log("CM " & CodeMirrorWrapper1.GetBase.Tag)
End Sub


Private Sub btnRevertEdits_Click
	CodeMirrorWrapper1.SetCode(mEditingCode)
End Sub


'Check if data has changed and set the save required indicator
Public Sub CheckSaveRequired As Boolean
	Dim SaveRequired As Boolean = Not(mEditingCode = CodeMirrorWrapper1.GetCode)
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
	Dim Selected As String = CodeMirrorWrapper1.GetSelectedCode
	If Selected = "" Then
		Text = CodeMirrorWrapper1.GetCode
	Else
		Text = Selected
	End If
	fx.Clipboard.SetString(Text)
End Sub



