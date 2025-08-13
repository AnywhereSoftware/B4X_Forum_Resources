B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@

#Event: SaveFileRequest(Code As String) as ResumableSub
#Event: LoadFileRequest As ResumableSub
#Event: Loaded

'#IgnoreWarnings: 

Private Sub Class_Globals

'	Private XUI As XUI
	Private CodeMirrorWrapper1 As CodeMirrorWrapper

	Private mCallBack As Object
	Private mEventname As String
'	Private mBase As B4XView
	Private mParent As Panel
	Private pnlWebView As Panel
	
	Private mEditingCode As String
	Private Loaded As Boolean
	Private btnLoad As Button 'B4XView
	Private btnSave As Button  'B4XView
	Private btnRevertEdits As Button 'B4XView
	Private pnlSaveIndicator As Panel 'B4XView
	Private MinFontsize As Int = 4
	Private mFontSize As Int = 10
	Private MaxFontSize As Int = 30
	Private FontUnit As String = "pt"
	Private cbLineNums As CheckBox
	
	Private spLang As Spinner   'B4XComboBox
	Private spThemes As Spinner   'B4XComboBox

	Private btnCopy As Button
	
	Dim mTop, mBottom, mHeight As Int 
	
	Private IME As IME
	
	' Placed here for convenience. 
	' Just refers to CodeMirrorWrapper costants.
	Public LINT_TYPE_NONE As Int = -1
	Public LINT_TYPE_HTML As Int = 0
	Public LINT_TYPE_JS As Int = 1
	Public LINT_TYPE_CSS As Int = 2
	Public LINT_TYPE_JSON As Int = 3
	
	Public HINT_TYPE_NONE As Int = -1
	Public HINT_TYPE_HTML As Int = 0
	Public HINT_TYPE_JS As Int = 1
	Public HINT_TYPE_CSS As Int = 2
	Public HINT_TYPE_SQL As Int = 3
	Public HINT_TYPE_XML As Int = 4
	Public HINT_TYPE_ANYWORD As Int = 5
End Sub

'Initializes the code editor object. 
'
'Note, the code editor refer to the CodeMirrorWrapper itself. 
'It just add a GUI layout with languages, themes selection, the SAVE and LOAD button and so on.
'On subsequents calling you can refer to CodeMirrorWrapper instance of this code editor, eg. CodeEditor1.CodeMirrorWrapper.your_command.
'
'After initialization tou should call Start command to start the code editor. Call it by passing the initial configuration parameters.
'
'Parent:    Panel or Activity where place the code editor  (Remember to initialize and resize it before initialize this)
'Callback:  Module that receive events (most of cases are Me)
'EventName: The callback event name
Public Sub Initialize(Parent As Panel, CallBack As Object, EventName As String)
	Log(" ") : Log("INITIALIZE CodeEditor")
	
	mParent = Parent
	mCallBack = CallBack
	mEventname = EventName '.ToLowerCase
	
	Log("Loading code editor layout ...")
	
	mParent.Visible = False ' Make the parent invisible to avoid some flikerings
	
	
	mParent.LoadLayout("CodeMirrorLayout1") ' Load the layout file.
'	mParent.Color = Colors.RGB(20,24.,24)
	Loaded = False
	
	'--------------- SET LAYOUT ---------------
	
'	Dim sHeight As Int = 40dip ' Spinners height
	Dim bHeight As Int = 40dip ' Buttons height
	
'	spLang.SetLayout(0, 0, 50%x, sHeight)
'	spThemes.SetLayout(50%x, 0, 50%x, sHeight)
	
	pnlSaveIndicator.SetLayoutAnimated(0,  0, 100%y-10dip-bHeight-10dip, 100%x, 10dip+bHeight+10dip)
	pnlSaveIndicator.SendToBack
	
	'	pnlSaveIndicator.SetColorAndBorder(Colors.Yellow, 2dip, Colors.Red, 10dip)
	pnlSaveIndicator.Color = Colors.RGB(30, 30, 30)
	
	btnRevertEdits.SetLayoutAnimated(0,  0, 100%y-10dip-bHeight, 40%x, bHeight)
	btnLoad.SetLayoutAnimated(0,  40%x, 100%y-10dip-bHeight, 30%x, bHeight)
	btnSave.SetLayoutAnimated(0,  70%x, 100%y-10dip-bHeight, 30%x, bHeight)
	
	cbLineNums.SetLayout(30dip, spLang.Top + spLang.Height, 40%x, bHeight)
	btnCopy.SetLayout(70%x, spLang.Top + spLang.Height, 30%x, bHeight)
		
	mTop = cbLineNums.Top + cbLineNums.Height + 3dip
	mBottom = pnlSaveIndicator.Top
	mHeight = mBottom - mTop  '- pnlSaveIndicator.Height
	
'	Log("Top: " & Top)
'	Log("Bottom: " & Bottom)
'	Log("Height: " & Height)	
'	Log($"pnlSaveIndicator layout: Left: ${pnlSaveIndicator.Left}  Top: ${pnlSaveIndicator.Top}  Right: ${pnlSaveIndicator.left + pnlSaveIndicator.Width}  Bottom: ${pnlSaveIndicator.Top + pnlSaveIndicator.Height}"$)
'	Log("pnlSaveIndicator height: " & pnlSaveIndicator.Height)
	
'   ' Just for test to see a webview position
'	Dim cd1 As ColorDrawable
'	cd1.Initialize2(Colors.Magenta, 10dip, 2dip, Colors.Green)
'	pnlWebView.Background = cd1
	
	pnlWebView.SetLayout(0, mTop, 100%x, mHeight)
'	pnlWebView.SetLayout(0, mTop, 2000dip, mHeight)
'	pnlWebView.Color = Colors.Yellow '

'	Log($"WebView panel layout: Left: ${pnlWebView.Left}  Top: ${pnlWebView.Top}  Right: ${pnlWebView.Width}  Bottom: ${pnlWebView.Height}"$)
				
	CodeMirrorWrapper1.Initialize(pnlWebView, Me, "CodeMirrorWrapper1") 
'	CodeMirrorWrapper1.SetZoomControls(True, False) 

	spLang.AddAll(CodeMirrorWrapper1.AllowedLanguages)
	spThemes.AddAll(CodeMirrorWrapper1.AllowedThemes)  ' We add here as default, next we can change it with command CodeEditor1.AllowedThemes = NewListOfThemes
	' This will clear the spinner and just add allowed themes
	
'	Resize (pnlWebView.Width , 10000) ' <---- THIS LINE MAY IS NO GOOD
'	Resize (pnlWebView.Width , pnlWebView.Height)
	
	mParent.Visible = True ' Make the parent back to visible after setting some layout properties
		
	IME.Initialize("IME")
	IME.AddHeightChangedEvent
'	IME_HeightChanged(100%y, 0) 'manually call this method to set the layout of EditText1 and btnHideKeyboard
End Sub

'Start the CodeMirrorWrapper object with request configuration parameters.
'Call this only after the Initialize command.
'
'LintType: Specifies if Lint (Automatic Code Error Check) is applied. Lints only works on follow languages: HTML, Javascript, CSS, JSON.
'          Allowed values are: LINT_TYPE_NONE (Not applied), LINT_TYPE_HTML, LINT_TYPE_JAVASCRIPT, LINT_TYPE_CSS, LINT_TYPE_JSON. 
'HintType: Specifies if Hint (Automatic Code Recognition) is applied. Hints only works on follow languages: HTML, Javascript, CSS, SQL, XML 
'          or if ANYWORD is selected, then code editor add to a completion any word you type on it. 
'          Allowed values are: HINT_TYPE_NONE, HINT_TYPE_HTML, HINT_TYPE_JS, HINT_TYPE_CSS, HINT_TYPE_SQL, HINT_TYPE_XML, HINT_TYPE_ANYWORD
'CodeFolding: If True the code folding is applied, if False it is not applied. (Only works on some languages)
'CloseBrackets: If True the auto CloseBrackets or CloseTag is applied, if False it is not applied. (Only works on some languages)
'ActiveLine: If True the editor mark the current line, if False it do not mark.
'
'Ready Event will be raised when the editor is ready and fully loaded.
Public Sub Start(LintType As Int, HintType As Int, CodeFolding As Boolean, CloseBrackets As Boolean, ActiveLine As Boolean)	
	CodeMirrorWrapper1.Start(LintType, HintType, CodeFolding, CloseBrackets, ActiveLine)
	CodeMirrorWrapper1.UpdateHTMLPage  ' Load the editor html page
End Sub

''''''''''''''''''

'Resize the editor view.
Public Sub Resize (Width As Int, Height As Int)
'	Log("CodeEditor Resize: " & CodeMirrorWrapper1.Panel.Tag)
	CodeMirrorWrapper1.SetSize(Width, Height)
End Sub

'Force reload and update the editor page. 
Public Sub Reload
	CodeMirrorWrapper1.UpdateHTMLPage
End Sub

'Get the editor height without the keyboard (To Resize the editor while the keyboard appear/disappear)
Private Sub IME_HeightChanged(NewHeight As Int, OldHeight As Int)
	Resize (pnlWebView.Width , NewHeight)
End Sub

Private Sub HideKeyboard 'Ignore
	IME.HideKeyboard
End Sub

' Removed temporally the designer layout feature. Can be added next.
'Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map) 'Ignore
'	mBase = Base
'	mBase.Tag = Me
'	
'	'////// STEVE, IMPORTANT NOTE HERE, WHEN LAYOUT IS CALLED, THE EventName of CodeMirrorWrapper
'	'////// changes from what we have set on line 40 with line CodeMirrorWrapper1.Initialize(Me, "CMW")
'	'////// IT FORCED TO BE THE SAME NAME OF CUSTOMVIEW CONTROL, ALL LOWERCASE, IN THIS CASE
'	'////// IT CHANGE TO codemirrorwrapper1. This is a problem !!! On this code anyway on line
'	'////// 40 I've set the same name of visual designer to match it, if I change it do not work
'	'////// and events like CodeChanged will not be fired.
'	
'	'#########################################################################################
'	'#	On andriod you always need a sleep(0) command before loading a layout in a custom view.
'	'#########################################################################################
'	Log("Loading 'codeeditorlayout' layout")
'	Sleep(0)
'	mBase.LoadLayout("codeeditorlayout") 'Load the layout file.
'			
''	CodeMirrorWrapper1.SetCode("")
'	
'	Loaded = False
'	Sleep(0)
'	spLang.AddAll(CMW_Utils.Languages)
'	
'	' THE LANGUAGE IS ALREADY SET IN THE MAIN
''	spLang.SelectedIndex = 1						'b4X
'	''	spLang_SelectedIndexChanged(1)			'B4xCombobox does not raise the changed event for changes by code.
''	spLang_ItemClick (1, spLang.GetItem(1))   
'	
''	'CUSTOM
''	Dim Pos As Int = spLang.IndexOf("JavaScript")  B4X, Java, C++ etc ...
''	If Pos >= 0 Then
''		spLang.SelectedIndex = Pos
''		spLang_ItemClick (spLang.SelectedIndex, spLang.GetItem(spLang.SelectedIndex))
''	Else
''		Log("Cannot found selected language: position: " & Pos)
''		
''		For i = 0 To CMW_Utils.Languages.Size - 1
''			Log("[" & i & "] Allowed Language: " & CMW_Utils.Languages.Get(i))
''		Next
''	End If
'End Sub

'Public Sub Base_resize(Width As Double,Height As Double)
'	Log("CodeEditor Resize: " & CodeMirrorWrapper1.GetBase.Tag)
'End Sub

'------------------ CODEMIRROR WRAPPER CALLBACKS ------------------

#Region Callbacks

' Page has loaded. Do any post load processing
Private Sub CodeMirrorWrapper1_Ready
'	Log("CodeEditor: PAGE READY")
	
	Loaded = True
	
'	Resize (pnlWebView.Width , pnlWebView.Height)
	
	' The editor may reformat spaces and layout, so need to update stored version.
	mEditingCode = CodeMirrorWrapper1.Code
	
	'Just check and turn off save required indicator if OK
'	CheckSaveRequired
	UpdateRevertPoint
	
	If SubExists(mCallBack, mEventname & "_Ready") Then
		CallSub(mCallBack, mEventname & "_Ready")
	End If
End Sub

' Callback from JS, code has changed
Private Sub CodeMirrorWrapper1_CodeChanged(New As Object)
'	Log("CodeEditor: CodeChanged")
	CheckSaveRequired
	UpdateRevertPoint
End Sub

#End Region

'-------------- CONTROL EVENTS --------------

#Region Gui Subs

Private Sub CodeMirrorWrapper1_SetSpinnerTheme (Theme As String)
	Dim Pos As Int = spThemes.IndexOf(Theme)
	If Pos > -1 Then spThemes.SelectedIndex = Pos
'	spThemes_ItemClick (Pos, spThemes.GetItem(Pos))
End Sub

Private Sub CodeMirrorWrapper1_SetSpinnerLanguage (Language As String)
	Dim Pos As Int = spLang.IndexOf(Language)
	If Pos > -1 Then spLang.SelectedIndex = Pos
'	spLang_ItemClick (Pos, spLang.GetItem(Pos))
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Sub CodeMirrorWrapper1_SetCheckLineNums (Value As Boolean)
	cbLineNums.Checked = Value
End Sub

Private Sub spLang_ItemClick (Position As Int, Value As Object)
'	setLanguage(Value)
	CodeMirrorWrapper1.Language = Value
End Sub

Private Sub spThemes_ItemClick (Position As Int, Value As Object)
	''setTheme(Value)
	CodeMirrorWrapper1.Theme = Value
End Sub

Private Sub cbLineNums_CheckedChange(Checked As Boolean)
	CodeMirrorWrapper1.ShowLineNums = Checked
End Sub

Private Sub btnSave_Click
	'Callback for save file.
	If SubExists(mCallBack, mEventname & "_SaveFileRequest") Then   ' Callback
		Wait For (CallSub2(mCallBack, mEventname & "_SaveFileRequest", CodeMirrorWrapper1.GetCode)) Complete (Reply As Boolean)
		If Reply Then mEditingCode = CodeMirrorWrapper1.GetCode	' Update revert point if you want to
	End If
	CheckSaveRequired
	UpdateRevertPoint
End Sub

Private Sub btnLoad_Click
	'Callback for load file.
	If SubExists(mCallBack, mEventname & "_LoadFileRequest") Then   ' Callback
		Wait For (CallSub(mCallBack, mEventname & "_LoadFileRequest")) Complete (changed As Boolean)
		If changed Then Loaded = False ' Disable update to CodeEditor until code is loaded
	End If
End Sub

Private Sub btnRevertEdits_Click
	CodeMirrorWrapper1.SetCode(mEditingCode)
End Sub

Private Sub btnCopy_Click
	Dim Text As String
	Dim Selected As String = CodeMirrorWrapper1.GetSelectedCode
	If Selected = "" Then
		Text = CodeMirrorWrapper1.GetCode
	Else
		Text = Selected
	End If
	
	Log("Copy to clipboard the selected text:")
	Log(Text)
	
  '	fx.Clipboard.SetString(Text)
	If ClipboardHasText And Text.Length > 0 Then 
		ToastMessageShow("Copy text to clipboard: " & CRLF & "[" & Text & "]", False)
	Else
		ToastMessageShow("Clipboars have no text.", False)	
	End If
	ClipboardSetText(Text)
End Sub

'Private Sub B4XPlusMinus1_ValueChanged (Value As Object)
'	If Loaded = False Then Return
'	mFontSize = Value
'	Log("New font size: " & mFontSize & FontUnit)
'	CodeMirrorWrapper1.SetFontSize(mFontSize, FontUnit)
'End Sub

#End Region Gui Subs

'Return a list with supported languages.
Public Sub getLanguages As List
	Return CodeMirrorWrapper1.AllowedLanguages
End Sub

'Return a list with supported themes.
Public Sub getThemes As List
	Return CodeMirrorWrapper1.AllowedThemes
End Sub

'If your code does something to change the size of the editor element
'(window resizes are already listened for), or unhides it, you should
'probably follow up by calling this method to ensure CodeMirror is
'still looking as intended. By default autorefresh is enabled but you
'can use this command to manually force refresh.
'
'NOTE: It's automatically called on SetSize method
Public Sub Refresh
	CodeMirrorWrapper1.Refresh
End Sub

'Set / Get the line numbers visualization for this CodeEditor.
Public Sub getShowLineNums As Boolean
	Return cbLineNums.Checked
End Sub
Public Sub setShowLineNums(State As Boolean)
	cbLineNums.Checked = State
End Sub

'Set / Get the font size for this CodeEditor.
Public Sub getFontSize As Int
	Return mFontSize
End Sub
Public Sub setFontSize(Size As Int)
'	Log("Loaded: " & Loaded)
	Log($"Font size in a range [${MinFontsize}-${MaxFontSize}]: ${Size}${FontUnit}"$)
	If Loaded = False Or Size < MinFontsize Or Size > MaxFontSize Then Return
'	B4XPlusMinus1.SelectedValue = Size
'	B4XPlusMinus1_ValueChanged (Size)
	mFontSize = Size
	Log("New font size: " & mFontSize & FontUnit)
'	CodeMirrorWrapper1.SetFontSize(mFontSize, FontUnit)
	
	Dim fs As CodeMirrorFontSize
	fs.Initialize
	fs.FontSize = mFontSize
	fs.FontUnit = FontUnit
	CodeMirrorWrapper1.FontSize = fs
End Sub


'Return an istance of CodeMirrorWrapper with all its methods, 
'these methods can be extended in future to add more functionalities.
Public Sub getCodeMirrorWrapper As CodeMirrorWrapper
	Return CodeMirrorWrapper1
End Sub

'Update revert point, after this on any code change the saved state 
'will be updated and can be checked from CheckSaveRequired method.
Public Sub UpdateRevertPoint
	mEditingCode = CodeMirrorWrapper1.GetCode
	CheckSaveRequired
End Sub

'Check if data has changed and set the save required indicator
Public Sub CheckSaveRequired As Boolean
	Dim SaveRequired As Boolean = Not(mEditingCode = CodeMirrorWrapper1.GetCode)
	'Log("CheckSaveRequired: SaveRequired: " & SaveRequired)
	
	Dim Color As Int
	If SaveRequired Then
		Color = Colors.Red
	Else
		Color = Colors.RGB(30, 30, 30)  'Colors.Transparent
	End If
'	pnlSaveIndicator.SetColorAndBorder(Color,1dip,Color,0)

	Dim cd As ColorDrawable
	cd.Initialize2(Color, 0, 1dip, Colors.Black)
	pnlSaveIndicator.Background = cd
	
	Return SaveRequired
End Sub


'----------------------- CLIPBOARD -------------------------

Public Sub ClipboardGetText As String
	Dim r As Reflector
	Dim jo As JavaObject
	jo = Me
	Dim sOk As String
	sOk = jo.RunMethod("GetTextFromClipboard", Array As Object(r.GetContext))
	Return sOk
End Sub

Public Sub ClipboardSetText(txt As String) As Boolean
	Dim r As Reflector
	Dim jo As JavaObject
	jo = Me
	Dim bOk As Boolean
	bOk = jo.RunMethod("SetTextToClipboard", Array As Object(txt, r.GetContext))
	Return bOk
End Sub

Public Sub ClipboardHasText As Boolean
	Dim jo As JavaObject
	Dim r As Reflector
	jo = Me
	Dim bOk As Boolean
	bOk = jo.RunMethod("HasTextCopied", Array As Object(r.GetContext))
	Return bOk
End Sub

#IF JAVA

import android.content.ClipboardManager;
import android.content.ClipData;
import android.content.ClipDescription;
import android.content.Context;

public Boolean SetTextToClipboard(Object objtxt, Object mObjContext) {
    try{
        String txt = (String) objtxt;
        Context mContext = (Context) mObjContext;
        ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard");
        ClipData myClip;
        myClip = ClipData.newPlainText("text", txt);
        myClipboard.setPrimaryClip(myClip);
        return true;
    }  
    catch(Exception ex){
        return false;
    }
};

public String GetTextFromClipboard(Object mObjContext) {
    Context mContext = (Context) mObjContext;
    ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard");
    ClipData myClip = myClipboard.getPrimaryClip();
    ClipData.Item item = myClip.getItemAt(0);
    String txt = item.getText().toString();
    return txt;
};

public Boolean HasTextCopied(Object mObjContext) {
	Context mContext = (Context) mObjContext;
	ClipboardManager myClipboard = (ClipboardManager) mContext.getSystemService("clipboard");
	if (!(myClipboard.hasPrimaryClip())) {
	    return false;
	} else if (!(myClipboard.getPrimaryClipDescription().hasMimeType("text/plain"))) {
	    return false;
	} else {
	    return true;
	}
};

#End If



