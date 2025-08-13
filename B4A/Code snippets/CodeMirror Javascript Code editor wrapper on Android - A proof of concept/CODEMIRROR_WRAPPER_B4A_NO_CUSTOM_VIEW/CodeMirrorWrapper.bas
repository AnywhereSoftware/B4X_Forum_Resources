B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@

#Event: Ready
#Event: CodeChanged(Change As Object)

'V1.1 (B4J Versions from stevel01)
'	Added change font size
'	Added hide line numbes
'	Fixed issue in CodeMirror library where it was not possible to select text with the mouse.
'		'CodeMirror Library patched as per - https://github.com/codemirror/CodeMirror/issues/5733
'
'V1.2
'	changed HTML template For better loading and consistency.
'	Implemented encodebase64 For text transfer
'	now a proper wrapper, all required calls are in the CodeEditorWrapper
'	improved syntax highlighting
'
'V1.3
'	Added most of the available languages
'	Added b4x.js to the proper structure within CodeMirror mode folder and Meta.js
'	Added new code module to Map App Names to mime types
'	Added and implemented autoLoad addon to select language by MimeType
'	Changes to the CodeMirror library - requires downloading new version
'
'V1.4
'	Added doc.clearHistory to setCode to stop undo removing the new code
'	Added #javacompilerpath to ide parameter words.
'	requires download of codemirrorlib
'	Moved the InitializeFiles sub to the WebCodeEditor class where it belongs.

'V1.5
'	Separated from the CodeEditor module for easier minimal implementation.
'	Added ReadOnly option
'	Added Themes
'		Requires an allowedthemes List to be passed so they can be validataed against the defined themes.
'		you can pass a subset of the defined themes so only your preferred themes are available.

'V.1.51
'Small process changes to enable minimal implementation
'	Please download library / Project from the dropbox link
'	Added minimal implementation example.

'V1.52
'	Fixed readOnly bug
'	Added LineWrapping
'	Added Autofocus
'	Removed dependency on JScriptEngine
'	Added highlighting for B4s

'V1.53
'  Don't works on SDK 29+
'	Completely rearranged and ported to B4A by max123
'  Removed the version check
'  Temporally removed the designer custom view
'  Added a small configuration setup for startup. See 'Start' command.
'	Added Code Folding
'	Added Lints (Automatic error recognition for JavaScript, HTML, CSS, JSON and other languages)
'	Added Hints for autocomple. Autocomplete use specific language settings and/or recognize any word we type in the editor.  Currently there are some issues with keyboard shortcuts to call the autocomplete dialog.
'  Added automatic close brackets
'  Added automatic pairing detection for brackets, quotes, tags etc. The paired will be marked on the editor.
'  Added automatic close tags
'  Added current line selection
'  Added html mixed mode. Multiple syntax highlight inside the same HTML document, for HTML, CSS, JSON, JavaScript. Note, autocomplete only works on HTML for now.
'  Added Line Markers (like breakpoints), for now just to mark lines to better find when scrolling. In future breakpoints can be implemented, I think it just returns a list of all lines with marker actived.
'  Added SearchBox with search, replace, replaceAll in the current document. (Currently commented and unused) (same problems with keyboard shortcuts)
'  Currently there are some issues to solve

'V1.54
'  Now it worhs on SDK 33

'''''''''''''''''''''''''''''''''''''''''''''''''

Private Sub Class_Globals
	
	Private XUI As XUI
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
'	Private mBase As B4XView
	Private mParent As Panel
	
   Private mWebView As WebView
''''''''	Public WebE As WebEngine
	Private wve As WebViewExtras
'	Public JSInterface As UltimateJavascriptInterface
	
'	Type B4xCallsType(module As Object, EventName As String)
'	Private B4xCalls As Map

	'Wrapper variables
	Private MimeType, mCurrentTheme, mCurrentLanguage, ByFileType As String
	
	Private mAllowedThemes As List
	
	Private mCodeMirrorPath As String
	Private mFontSize As Int = 12
	Private mFontUnit As String = "pt"
	Private mShowLineNumbers As String = "true"
	Private mLineWrapping As String = "false"
	Private mReadOnly As String = "false"
	Private mFixedGutter As String = "true"
	Private mAutofocus As String = "false"
	Private mFullHTML As StringBuilder 'String = ""
	Private Loaded As Boolean
	Private mWidth As Int
	Private mHeight As Int
'	Private Code As String
	Public Tag As Object
	
	Type CodeMirrorFontSize (FontSize As Int, FontUnit As String)
	
	Public FilesFolder As String
	
	Public LINT_TYPE_NONE As Int = -1
	Public LINT_TYPE_HTML As Int = 0
	Public LINT_TYPE_JS As Int = 1
	Public LINT_TYPE_CSS As Int = 2
	Public LINT_TYPE_JSON As Int = 3
	Private mLintType As Int = -1 ' Default
	
	Public HINT_TYPE_NONE As Int = -1
	Public HINT_TYPE_HTML As Int = 0
	Public HINT_TYPE_JS As Int = 1
	Public HINT_TYPE_CSS As Int = 2
	Public HINT_TYPE_SQL As Int = 3
	Public HINT_TYPE_XML As Int = 4
	Public HINT_TYPE_ANYWORD As Int = 5
	Private mHintType As Int = -1 ' Default
		
	Private mCodeFolding As Boolean = False  ' Default
	Private mCloseBrackets As Boolean = False  ' Default
	Private mActiveLine As Boolean = False  ' Default
	
	Private mProgress As Int = 0
End Sub

'Initializes the CodeMirrorWrapper object.
'
'After initialization you should call Start command to start the code editor. Call it by passing the initial configuration parameters.
'
'Parent:    Panel or Activity where place the code editor  (Remember to initialize and resize it before initialize this)
'Callback:  Module that receive events (most of cases are Me)
'EventName: The callback event name
Public Sub Initialize (Parent As Panel, Callback As Object, EventName As String)
	Log(" ") : Log("INITIALIZE CodeMirrorWrapper")
		
	mParent = Parent
	mCallBack = Callback
	mEventName = EventName
	
	mFullHTML.Initialize
	
	mWebView.Initialize("mWebView")
	mWebView.JavaScriptEnabled = True
	
	' Setup the javascript interface
	wve.addWebChromeClient(mWebView, "wve")
	wve.addJavascriptInterface(mWebView, "B4A")
	
	Dim wws As WebViewSettings
	wws.setAllowFileAccess(mWebView, True)
	
'	mWebView.Color = Colors.Red
	mParent.AddView(mWebView, 0, 0, 100%x, 100%y)
'	mWebView.Color = Colors.Black
'	mWebView.Invalidate

	mWidth = mWebView.Width
	mHeight = mWebView.Height

'	XUI.SetDataFolder("CodeEditor") ' B4J Only	
	FilesFolder = File.DirInternal  'XUI.DefaultFolder
	Log("FilesFolder: " & FilesFolder)
	
	CMW_Utils.Initialize	' Initialize helper lookup maps	
	
	mAllowedThemes.Initialize
	setAllowedThemes(CMW_Utils.Themes)
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
	mLintType = LintType
	mHintType = HintType
	mCodeFolding = CodeFolding
	mCloseBrackets = CloseBrackets
	mActiveLine = ActiveLine
	
	mCodeMirrorPath = InitializeFiles
	Log("Codemirror path: " & mCodeMirrorPath)
End Sub

' These setters can only be applied changing the actual html code of the page, because need to import some codemirror JS classes

''Set / Get current auto error recognition lint type.
''Note that this only works on certain languages.
''
''By default LINT_TYPE_NONE
''
''Can be one of follows costants:
''
''LINT_TYPE_NONE
''LINT_TYPE_HTML
''LINT_TYPE_JAVASCRIPT
''LINT_TYPE_CSS 
''LINT_TYPE_JSON
'Public Sub setLintType (LintType As Int)
'	mLintType = LintType
'End Sub
Public Sub getLintType () As Int
	Return mLintType
End Sub

''Set / Get current hint type.
''Note that this only works on certain languages.
''
''By default HINT_TYPE_NONE
''
''Can be one of follows costants:
''
'' HINT_TYPE_NONE As Int = -1
'' HINT_TYPE_HTML As Int = 0
'' HINT_TYPE_JS As Int = 1
'' HINT_TYPE_CSS As Int = 2
'' HINT_TYPE_SQL As Int = 3
'' HINT_TYPE_XML As Int = 4
'' HINT_TYPE_ANYWORD As Int = 5
'Public Sub setHintType (HintType As Int)
'	mHintType = HintType
'End Sub
Public Sub getHintType () As Int
	Return mHintType
End Sub

'Set / Get current code folding. By default false.
'Public Sub setCodeFolding (CodeFolding As Boolean)
'	mCodeFolding = CodeFolding
'End Sub
Public Sub getCodeFolding () As Boolean
	Return mCodeFolding
End Sub

'Set / Get current auto closing brackets. By default False.
'Public Sub setCloseBrackets (CloseBrackets As Boolean)
'	mCloseBrackets = CloseBrackets
'End Sub
Public Sub getCloseBrackets () As Boolean
	Return mCloseBrackets
End Sub

'Set / Get current active selected line. By default False.
'Public Sub setActiveLine (ActiveLine As Boolean)
'	mActiveLine = ActiveLine
'End Sub
Public Sub getActiveLine () As Boolean
	Return mActiveLine
End Sub

''''''''''''''''''''''''

'Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
'
'	mBase = Base
'	Tag = mBase.Tag
'	
'	'Initial Values
'	mWidth = mBase.Width
'	mHeight = mBase.Height
'	
'	Log("Loading 'codemirrorwrapper' layout")
'	Sleep(0)
'	mBase.LoadLayout("codemirrorwrapper")
'	
'	mBase.Tag = Me
'	
'	''''''''''''''''''''''''''''' SETUP JS (B4J) '''''''''''''''''''''''''''''''
'''''''''''''	WebE = WebEngine_Static.New(mWebView)
'	
'''''''''''''	WebE.SetOnAlert(Me,"JSAlert")
'''''''''''''	WebE.SetOnError(Me,"JSError")
'	
''''''''	B4xCalls.Initialize
''''''''	RegisterB4XCall("JsLog",Me,"Js_Log")
''''''''	RegisterB4XCall("codechanged",mCallBack,mEventName & "_CodeChanged")
'	
'''''''''''	WebE.AddWorkerListener(Me,"LoadProgress")
'	''''''''''''''''''''''''''''''''''''
'
''''''	UltimateWebView1.Initialize(Me, "UltimateWebView1")
'''''''	UltimateWebView1.SetWebViewClient(True) 'Sets WebViewClient and its Events.
''''''	UltimateWebView1.SetWebChromeClient(True) 'Sets WebChromeClient and its Events.
''''''	
''''''	'Other UltimateWebViewSettings
''''''	UltimateWebView1.Settings.JavaScriptEnabled = True
''''''	UltimateWebView1.Settings.JavaScriptCanOpenWindowsAutomatically = True
''''''	UltimateWebView1.Settings.DisplayZoomControls = False
''''''	
'''''''	UltimateWebView1.Settings.AllowContentAccess = True
'''''''	UltimateWebView1.Settings.AllowFileAccess = True
'''''''	UltimateWebView1.Settings.AppCacheEnabled = True
'''''''	UltimateWebView1.Settings.CacheMode = UltimateWebView1.Settings.Constants.CACHEMODE_LOAD_DEFAULT
'''''''	UltimateWebView1.Settings.DomStorageEnabled = True
'''''''	UltimateWebView1.Settings.MediaPlaybackRequiresUserGesture = False
'''''''	UltimateWebView1.Settings.AllowFileAccessFromFileURLs = True
'''''''	UltimateWebView1.Settings.AllowUniversalAccessFromFileURLs = True
'''''''	UltimateWebView1.SetDownloadListener 'Sets and start DownloadListener'
''''''	
''''''	Log("InitMe=" & Me)
''''''	
''''''	InitJS
''''''	'"B4A" is name of javascriptinterface. You can use different name if you want.
''''''	UltimateWebView1.AddJavascriptInterface(JSInterface, "B4A")
'
'	wve.addWebChromeClient(mWebView, "wve")
'	wve.addJavascriptInterface(mWebView, "B4A")
'End Sub
	
'Private Sub Base_Resize (Width As Double, Height As Double)
'	SetSize(Width,Height)
'End Sub

'Private Sub Resize (Width As Double, Height As Double)
'	SetSize(Width,Height)
'End Sub

'Public Sub GetBase As B4XView
'	Return mBase
'End Sub
	
Public Sub getPanel As Panel 'B4XView
	Return mParent
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'''''Sub UltimateWebView1_PageFinished (Url As String) 'Works from API level 1 and above. WebViewClient required.
Private Sub mWebView_PageFinished (Url As String)	
	Log("CodeMirrorWrapper: PAGE LOADED: " & Url)      ' HERE MY B4J NEVER RETURN SUCCEEDED, ONLY SCHEDULED, RUNNING, CANCELLED, IT WORKS ON ANDROID
	
'	Sleep(0)  ' NEED THIS ???
	Loaded = True
	
'	Dim Su As StringUtils
'	ExecuteScript($"setCode("${Su.EncodeBase64(Code.GetBytes("UTF8"))}");"$)
	
	If ByFileType <> "" Then
		ExecuteScript($"changeType("${ByFileType}")"$)
	Else If MimeType <> "" Then
		ExecuteScript($"changeType("${MimeType}")"$)
	End If
	
	If mCurrentTheme <> "" Then ExecuteScript($"editor.setOption("theme", "${mCurrentTheme}");"$)
	If mReadOnly <> "false" Then ExecuteScript($"editor.setOption("readOnly", ${mReadOnly});"$)
	If mLineWrapping <> "false" Then ExecuteScript($"editor.setOption("lineWrapping", ${mLineWrapping});"$)
	If mAutofocus <> "false" Then ExecuteScript($"editor.setOption("autofocus", ${mAutofocus});"$)
	
	ExecuteScript($"editor.setOption("fixedGutter", ${mFixedGutter});"$) ' ADDED THIS TO MAKE GUTTER FIXED ON THE LEFT
'	ExecuteScript($"editor.setOption("autoCloseBrackets", true);"$)
	
	SetSize(mWidth, mHeight)	
	
	If mProgress = 100 Then
		CallSub(mCallBack, mEventName & "_Ready")  ' Callback
	End If
	
End Sub

'''''Sub UltimateWebView1_PageLoadingProgressChanged(Progress As Int)
''''' 	Log("Progress: " & Progress)
'''''End Sub

Private Sub wve_ProgressChanged(NewProgress As Int)
	Log("[" & DateTime.Now & "] CodeMirrorWrapper: Progress: " & NewProgress)
	mProgress = NewProgress
End Sub

'Private Sub LoadProgress_Event (NewState As String)
'	Log("State: " & NewState)
'	
'	If NewState  = "SUCCEEDED" Then  ' <<<<<< NEVER RETURN SUCCEEDED, ONLY SCHEDULED, RUNNING, CANCELLED
'		Log("Page LOADED")
'		' Setup the javascript interface
'''''''''		Set_Bridge
'		Sleep(0)
'		Loaded = True
'		Dim Su As StringUtils
'		ExecuteScript($"setCode("${Su.EncodeBase64(Code.GetBytes("UTF8"))}");"$)
'		If mByFileType <> "" Then
'			ExecuteScript($"changeType("${mByFileType}")"$)
'		Else If MimeType <> "" Then
'			ExecuteScript($"changeType("${MimeType}")"$)
'		End If
'		If CurrentTheme <> "" Then ExecuteScript($"editor.setOption("theme", "${CurrentTheme}");"$)
'		If mReadOnly <> "false" Then ExecuteScript($"editor.setOption("readOnly", ${mReadOnly});"$)
'		If mLineWrapping <> "false" Then ExecuteScript($"editor.setOption("lineWrapping", ${mLineWrapping});"$)
'		If mAutofocus <> "false" Then ExecuteScript($"editor.setOption("autofocus", ${mAutofocus});"$)
'		SetSize(mWidth + 10, mHeight + 10)
'		CallSub(mCallBack,mEventName & "_Loaded")
'	End If
'End Sub

'###############################################################################
#Region JS interface subs
'###############################################################################


''Private Sub JSError_Event(Args() As Object) ' SOSTITUITA
''	Dim Msg As String
''	If GetType(Args(0)) = "javafx.scene.web.WebErrorEvent" Then
''		Msg = ASJO(Args(0)).RunMethod("getMessage",Null)
''	Else
''		Msg = ASJO(Args(0)).RunMethod("getData",Null)
''	End If
''	Log("JSError : **************************************************************")
''	Log("JSError : " & Msg)
''	Log("JSError : **************************************************************")
''End Sub

'Receiving calls from JS console.log
Private Sub Js_Log(text As Object)
	Log("JS console.log: " & text)
End Sub

''Call java code to setup the JS Bridge
'Private Sub Set_Bridge
'	Dim MeJo As JavaObject = Me
'	MeJo.RunMethod("setBridge",Array(WebE.GetObject))
'End Sub

#End Region JS Interface subs


#Region Wrapper Subs

Private Sub InitializeFiles As String
	Dim CodemirrorPath As String = ""
	Dim FileExists As Boolean = False
	Dim FilesFolderPath As String = File.Combine(FilesFolder, "")
	
	Dim files As List = File.ListFiles(FilesFolderPath)
	
	For i = 0 To files.Size-1
		Dim entry As String = files.Get(i)
'		Log("[" & (i+1) & "] " & entry)
		If File.IsDirectory(FilesFolderPath, entry) Then
			If entry.StartsWith("codemirror") Then FileExists = True
		End If
	Next
	
'	If File.Exists(FilesFolder, "codemirror.zip") = False Then
	If FileExists = False Then
		Log("Copy codemirror.zip from Assets")
		File.Copy(File.DirAssets, "codemirror.zip", FilesFolder, "codemirror.zip")
		
		Log("Unzipping file codemirror.zip")
		Dim Arc As Archiver
		Dim Count As Int = Arc.UnZip(FilesFolder, "codemirror.zip", FilesFolder, "")
		' Arc.AsyncUnZip(FilesFolder, "codemirror.zip", FilesFolder, "")
		Log(Count & " Files unzipped on " & FilesFolder)
				
		Log("Delete file codemirror.zip")
		File.Delete(FilesFolder,"codemirror.zip") ' Remove the zip after unzipped
		Log("Deleted")
	Else
		Log("CodeMirror distribution already exists")
	End If
	
	' I don't know if really this is required
	If File.Exists(FilesFolder, "wrapper.js") = False Then
		Log("Copying wrapper.js from Assets")
		File.Copy(File.DirAssets, "wrapper.js", FilesFolder, "wrapper.js")
	Else
		Log("wrapper.js already exists")
	End If
	
	' Currently empty, but required when changing highlight colours. Users may change this.
	If File.Exists(FilesFolder, "wrapper.css") = False Then
		Log("Copying wrapper.css from Assets")
		File.Copy(File.DirAssets, "wrapper.css", FilesFolder, "wrapper.css")
	Else
		Log("wrapper.css already exists")
	End If
	
	files = File.ListFiles(FilesFolderPath)
	For i = 0 To files.Size-1
		Dim entry As String = files.Get(i)
'		Log("[" & (i+1) & "] " & entry)
		If File.IsDirectory(FilesFolderPath, entry) Then
			If entry.StartsWith("codemirror") Then
				CodemirrorPath = entry
				Exit
			End If
'		Else
'			Log("FILE: " & entry)
		End If
	Next
		
'	For Each x As String In files
'	If File.IsDirectory(File.Combine(FilesFolder, mCodeMirrorPath), x) Then
'		Log("[" & i & "] " & files.Get(i).As(FileVersionManager))

	Return CodemirrorPath
End Sub
	
'------------------------ CALLBACKS ------------------------

Private Sub CodeChanged(New As Object)  'Ignore
	If SubExists(mCallBack, mEventName & "_CodeChanged") Then
		CallSub2(mCallBack, mEventName & "_CodeChanged", New)
'	Else
'		Log("CodeMirrorWrapper: Calling module Sub " & mEventName & "_CodeChanged do not exists")
	End If
End Sub

''''''''''''''''''' PUBLIC FUNCTIONS ''''''''''''''''''''

'Get the current instance of WebView where CodeEditor is initialized.
Public Sub GetWebView As WebView
	Return mWebView
End Sub

'Set / Get the current text on this CodeEditor.
Public Sub setCode(NewCode As String)
'	mCode = NewCode
	
	''	'Delete the HTML for the last style used.
'	If File.Exists(FilesFolder, "codemirrorwrapper.html") Then
'		Log(" ") : Log(File.Combine(FilesFolder, "codemirrorwrapper.html") & " already exists, now we delete and recreate it ...")
'		File.Delete(FilesFolder, "codemirrorwrapper.html")
'	Else
'		Log(" ") : Log(File.Combine(FilesFolder, "codemirrorwrapper.html") & " do not exists, create it ...")
'	End If	
'	UpdatePage
	
	NewCode = NewCode.Replace(TAB, "   ") ' Need to set here the Tab size from the editor option 'tabSize'. Here we set by default 3 spaces. 
	
	Dim Su As StringUtils
	ExecuteScript($"setCode("${Su.EncodeBase64(NewCode.GetBytes("UTF8"))}");"$)
End Sub

Public Sub getCode As String
'Public Sub getCode As ResumableSub
	Return ExecuteScript("editor.getValue();")
	
'	Dim o As Object = ExecuteScript("editor.getValue();")
''	Dim s As String = o
'	Return o
	
'	Wait For (ExecuteScript("editor.getValue();")) Complete(o As Object)
'	Return o
End Sub

'Get current selection text on this CodeEditor.
Public Sub getSelectedCode As String
	Return ExecuteScript("editor.getSelection();")
	
'	Dim o As Object = ExecuteScript("editor.getSelection();")
''	Dim s As String = o
'	Return o
End Sub

'Get the number of lines in the editor.
Public Sub getLineCount() As Int
	Return ExecuteScript("editor.lineCount();")

'	Dim o As Object = ExecuteScript("editor.lineCount();")
''	Dim i As Int = o
'	Return o
End Sub

'Return true if any text is selected.
Public Sub getSomethingSelected() As String
	Return ExecuteScript("editor.somethingSelected();")
	
'	Dim o As Object = ExecuteScript("editor.somethingSelected();")
''	Dim i As Int = o
'	Return o
End Sub

' Set / Get editor options after initialization
Public Sub setOption (Option As String, Value As String)
	ExecuteScript($"editor.setOption("${Option}", "${Value}");"$)
End Sub
Public Sub getOption (Option As String) As String
	Return ExecuteScript($"editor.getOption("${Option}");"$)
	
'	Dim o As Object = ExecuteScript($"editor.getOption("${Option}");"$)
''	Dim s As String = o
'	Return o
End Sub

'''''''''''''''

'Set current size for this CodeEditor.
Public Sub SetSize(Width As Double, Height As Double)
	Log($"CodeMirrorWrapper: SetSize(${Width}, ${Height})"$)
	mWidth = Width   ' Check this
	mHeight = Height - 150   ' Check this I WANT TO KNOW BECAUSE THIS IS NEEDED TO GET RIGHT HEIGHT. IF YOU KNOW THIS PLEASE FEEL FREE TO COMMENT IN THE FORUM
	Log($"CodeMirrorWrapper: Final Size(${mWidth}, ${mHeight})"$)
	ExecuteScript($"editor.setSize(${mWidth},${mHeight})"$)
	Refresh ' Force refresh after resize
End Sub

'Set Zoom control settings for this CodeEditor.
Public Sub SetZoomControls(ZoomEnabled As Boolean, DisplayZoomControl As Boolean)
	Dim r As Reflector
	r.Target = mWebView
	r.Target = r.RunMethod("getSettings")
	r.RunMethod2("setBuiltInZoomControls", ZoomEnabled, "java.lang.boolean")
	r.RunMethod2("setDisplayZoomControls", DisplayZoomControl, "java.lang.boolean")
End Sub

'Set read only state on this CodeEditor.
'
'This enables / disables editing of the editor content by the user. 
'If read only State is True and ShowCursor is False, focusing of
'the editor is also disallowed.
Public Sub SetReadOnly(State As Boolean, ShowCursor As Boolean)  ' Getters only support one value	
	If State = False Then
		mReadOnly = $"false"$
	Else
		If ShowCursor Then
			mReadOnly = $"true"$
		Else
'			mReadOnly = $""nocursor""$  ' Typing error ???
			mReadOnly = $"nocursor"$
		End If
	End If
		
	If Loaded Then
		Log("ReadOnly: " & mReadOnly)
		ExecuteScript($"editor.setOption("readOnly", ${mReadOnly});"$)
	Else
		ExecuteScript($"editor.setOption("readOnly", ${mReadOnly});"$)  ' Just to show error log
	End If
End Sub

'Get read only state on this CodeEditor.
Public Sub GetReadOnly As Boolean
'	If mReadOnly = $"false"$ Then  ' "false"
'		Return False
'	Else
'		Return True  ' "true", "nocursor"
'	End If
	Return (mReadOnly = "true" Or mReadOnly = "nocursor")
End Sub

'Set / Get whether the gutter scrolls along with the content
'horizontally (False) or whether it stays fixed during 
'horizontal scrolling (True, the default).
Public Sub setFixedGutter(State As Boolean)	
	mFixedGutter = "false"
	If State Then mFixedGutter = "true"	
	Log("FixedGutter: " & mFixedGutter)
	ExecuteScript($"editor.setOption("fixedGutter", ${mFixedGutter});"$)
End Sub
Public Sub getFixedGutter As Boolean
	Return mFixedGutter = "true"
End Sub

'Set a font size for this CodeEditor.
'Public Sub setFontSize(FontSize As Int, FontUnit As String)
Public Sub setFontSize(fs As CodeMirrorFontSize)
	Log($"CodeMirrorWrapper: SetFontSize(${fs.FontSize}, ${fs.FontUnit})"$)
	mFontSize = fs.FontSize
	mFontUnit = fs.FontUnit
	ExecuteScript($"editor.getWrapperElement().style["font-size"] = ${mFontSize}+"${mFontUnit}";editor.refresh();"$)
End Sub

'Get the current font size for this CodeEditor as CodeMirrorFontSize custom type as follow:
'- FontSize As Int      specifies a font size (as units)
'- FontUnit As String   specifies a font unit "pt", "px", "em" ...
Public Sub getFontSize As CodeMirrorFontSize  ' Getter only support primitive types
	Dim f As CodeMirrorFontSize
	f.Initialize
	f.FontSize = mFontSize
	f.FontUnit = mFontUnit
	Return f
End Sub

'If your code does something to change the size of the editor element
'(window resizes are already listened for), or unhides it, you should
'probably follow up by calling this method to ensure CodeMirror is
'still looking as intended. By default autorefresh is enabled but you
'can use this command to manually force refresh.
'
' It call javascript editor.refresh(); to refresch codemirror instance.
'NOTE: It's automatically called on SetSize method
Public Sub Refresh
	ExecuteScript("editor.refresh();")
End Sub

'Set the line numbers visibility for this CodeEditor.
Public Sub setShowLineNums(ShowLineNumbers As Boolean)
	Log($"CodeMirrorWrapper: ShowLineNums(${ShowLineNumbers})"$)
	Dim Show As String = "false"
	If ShowLineNumbers Then Show = "true"
	mShowLineNumbers = ShowLineNumbers
	ExecuteScript($"editor.setOption("lineNumbers", ${Show});"$)	
	If SubExists(mCallBack, mEventName & "_SetCheckLineNums") Then
		CallSubDelayed2(mCallBack, mEventName & "_SetCheckLineNums", ShowLineNumbers)
	End If
End Sub
Public Sub getShowLineNums As Boolean
	Return mShowLineNumbers
End Sub

'Get / Set the Language for this codemirror. 
'
'A full list of available Languages is available by calling <code>CMW_Utls.Languages</code> or viewing it's code.
'
'Note that all languages names are case sensitive, so eg. if you
'pass javascript instead of 'JavaScript' you have an error.
'
'For convenience here is a full list of supported languages with respective MimeTypes:
'<code>
'	"APL" -> "text/apl"
'	"B4X" -> "text/b4x"
'	"B4S" -> "text/b4s"
'	"PGP" -> "application/pgp"
'	"PGP Encrypted" -> "application/pgp-encrypted"
'	"PGP Keys" ->  "application/pgp-keys"
'	"PGP Signature" ->  "application/pgp-signature"
'	"ASN.1" -> "text/x-ttcn-asn"
'	"Asterisk" -> "text/x-asterisk"
'	"Brainfuck" -> "text/x-brainfuck"
'	"C" -> "text/x-csrc"
'	"C++" -> "text/x-c++src"
'	"Cobol" -> "text/x-cobol"
'	"C#" -> "text/x-csharp"
'	"Clojure" -> "text/x-clojure"
'	"ClojureScript" -> "text/x-clojurescript"
'	"Closure Stylesheets (GSS)" -> "text/x-gss"
'	"CMake" -> "text/x-cmake"
'	"CoffeeScript" -> "application/vnd.coffeescript" 
'	"Common Lisp" -> "text/x-common-lisp"
'	"Cypher" -> "application/x-cypher-query"
'	"Cython" -> "text/x-cython"
'	"Crystal" -> "text/x-crystal"
'	"CSS" -> "text/css"
'	"CQL" -> "text/x-cassandra"
'	"D" -> "text/x-d"
'	"Dart" ->  "application/dart" 
'	"diff" -> "text/x-diff"
'	"Django" -> "text/x-django"
'	"Dockerfile" -> "text/x-dockerfile"
'	"DTD" -> "application/xml-dtd"
'	"Dylan" -> "text/x-dylan"
'	"EBNF" -> "text/x-ebnf"
'	"ECL" -> "text/x-ecl"
'	"edn" -> "application/edn"
'	"Eiffel" -> "text/x-eiffel"
'	"Elm" -> "text/x-elm"
'	"Embedded Javascript" -> "application/x-ejs"
'	"Embedded Ruby" -> "application/x-erb"
'	"Erlang" -> "text/x-erlang"
'	"Esper" -> "text/x-esper"
'	"Factor" -> "text/x-factor"
'	"FCL" -> "text/x-fcl"
'	"Forth" -> "text/x-forth"
'	"Fortran" -> "text/x-fortran"
'	"F#" -> "text/x-fsharp"
'	"Gas" -> "text/x-gas"
'	"Gherkin" -> "text/x-feature"
'	"GitHub Flavored Markdown" -> "text/x-gfm"
'	"Go" -> "text/x-go"
'	"Groovy" -> "text/x-groovy"
'	"HAML" -> "text/x-haml"
'	"Haskell" -> "text/x-haskell"
'	"Haskell (Literate)" -> "text/x-literate-haskell"
'	"Haxe" -> "text/x-haxe"
'	"HXML" -> "text/x-hxml"
'	"ASP.NET" -> "application/x-aspx"
'	"HTML" -> "text/html"
'	"HTTP" -> "message/http"
'	"IDL" -> "text/x-idl"
'	"Pug" -> "text/x-pug"
'	"Java" -> "text/x-java"
'	"Java Server Pages" -> "application/x-jsp"
'	"JavaScript" -> "application/javascript" 
'	"JSON" ->  "application/json" 
'	"JSON-LD" -> "application/ld+json"
'	"JSX" -> "text/jsx"
'	"Jinja2" -> "text/jinja2"
'	"Julia" -> "text/x-julia"
'	"Kotlin" -> "text/x-kotlin"
'	"LESS" -> "text/x-less"
'	"LiveScript" -> "text/x-livescript"
'	"Lua" -> "text/x-lua"
'	"Markdown" -> "text/x-markdown"
'	"mIRC" -> "text/mirc"
'	"MariaDB SQL" -> "text/x-mariadb"
'	"Mathematica" -> "text/x-mathematica"
'	"Modelica" -> "text/x-modelica"
'	"MUMPS" -> "text/x-mumps"
'	"MS SQL" -> "text/x-mssql"
'	"mbox" -> "application/mbox"
'	"MySQL" -> "text/x-mysql"
'	"Nginx" -> "text/x-nginx-conf"
'	"NSIS" -> "text/x-nsis"
'	"NTriples" -> "application/n-triples"
'	"Objective-C" -> "text/x-objectivec"
'	"Objective-C++" -> "text/x-objectivec++"
'	"OCaml" -> "text/x-ocaml"
'	"Octave" -> "text/x-octave"
'	"Oz" -> "text/x-oz"
'	"Pascal" -> "text/x-pascal"
'	"PEG.js" -> "null"
'	"Perl" -> "text/x-perl"
'	"PHP" ->  "text/x-php"
'	"Pig" -> "text/x-pig"
'	"Plain Text" -> "text/plain"
'	"PLSQL" -> "text/x-plsql"
'	"PostgreSQL" -> "text/x-pgsql"
'	"PowerShell" -> "application/x-powershell"
'	"Properties files" -> "text/x-properties"
'	"ProtoBuf" -> "text/x-protobuf"
'	"Python" -> "text/x-python"
'	"Puppet" -> "text/x-puppet"
'	"Q" -> "text/x-q"
'	"R" -> "text/x-rsrc"
'	"reStructuredText" -> "text/x-rst"
'	"RPM Changes" -> "text/x-rpm-changes"
'	"RPM Spec" -> "text/x-rpm-spec"
'	"Ruby" -> "text/x-ruby"
'	"Rust" -> "text/x-rustsrc"
'	"SAS" -> "text/x-sas"
'	"Sass" -> "text/x-sass"
'	"Scala" -> "text/x-scala"
'	"Scheme" -> "text/x-scheme"
'	"SCSS" -> "text/x-scss"
'	"Shell" ->  "text/x-sh"
'	"Sieve" -> "application/sieve"
'	"Slim" ->  "text/x-slim",  _
'	"Smalltalk" -> "text/x-stsrc"
'	"Smarty" -> "text/x-smarty"
'	"Solr" -> "text/x-solr"
'	"SML" -> "text/x-sml"
'	"Soy" -> "text/x-soy"
'	"SPARQL" -> "application/sparql-query"
'	"Spreadsheet" -> "text/x-spreadsheet"
'	"SQL" -> "text/x-sql"
'	"SQLite" -> "text/x-sqlite"
'	"Squirrel" -> "text/x-squirrel"
'	"Stylus" -> "text/x-styl"
'	"Swift" -> "text/x-swift"
'	"sTeX" -> "text/x-stex"
'	"LaTeX" -> "text/x-latex"
'	"SystemVerilog" -> "text/x-systemverilog"
'	"Tcl" -> "text/x-tcl"
'	"Textile" -> "text/x-textile"
'	"TiddlyWiki" -> "text/x-tiddlywiki"
'	"Tiki wiki" -> "text/tiki"
'	"TOML" -> "text/x-toml"
'	"Tornado" -> "text/x-tornado"
'	"troff" -> "text/troff"
'	"TTCN" -> "text/x-ttcn"
'	"TTCN_CFG" -> "text/x-ttcn-cfg"
'	"Turtle" -> "text/turtle"
'	"TypeScript" -> "application/typescript"
'	"TypeScript-JSX" -> "text/typescript-jsx"
'	"Twig" -> "text/x-twig"
'	"Web IDL" -> "text/x-webidl"
'	"VB.NET" -> "text/x-vb"
'	"VBScript" -> "text/vbscript"
'	"Velocity" -> "text/velocity"
'	"Verilog" -> "text/x-verilog"
'	"VHDL" -> "text/x-vhdl"
'	"Vue.js Component" ->  "script/x-vue" 
'	"XML" -> "application/xml" 
'	"XQuery" -> "application/xquery"
'	"Yacas" -> "text/x-yacas"
'	"YAML" -> "text/x-yaml" 
'	"Z80" -> "text/x-z80"
'	"mscgen" -> "text/x-mscgen"
'	"xu" -> "text/x-xu"
'	"msgenny" -> "text/x-msgenny"
'	"WebAssembly" -> "text/webassembly"
'</code>
Public Sub setLanguage(Language As String)
	Dim MT As String = CMW_Utils.MimeType(Language)
	
	If MT = "" Then
		Dim TH As Throwables
		TH.Initialize
		TH.Throw(Throwables_Static.NewIllegalArgumentException($"CodeMirrorWrapper: Language '${Language}' is not a valid Language.  Languages are case sensitive"$))
		Return
	End If
	
	MimeType = MT
	ByFileType = ""
	mCurrentLanguage = Language
	
	ToastMessageShow("Set Language: " & Language, False)
	ExecuteScript($"changeType("${MimeType}")"$)
	
	If SubExists(mCallBack, mEventName & "_SetSpinnerLanguage") Then
		CallSubDelayed2(mCallBack, mEventName & "_SetSpinnerLanguage", Language)
	End If
End Sub
Public Sub getLanguage As String
	Return mCurrentLanguage
End Sub

'Set a language by file name. See changeType method on CodeMirror.
Public Sub LanguageByFileType(FileName As String)
	Log($"CodeMirrorWrapper: SetLanguageByFileType(${FileName})"$)
	ByFileType = FileName
	
''''''	NO YET IMPLEMENTED
	
	ExecuteScript($"changeType("${ByFileType}")"$)
End Sub

' Return a list of allowed languages.
Public Sub AllowedLanguages() As List
	Return CMW_Utils.Languages
End Sub

''''''''''''''''''''''''''' 

'Set the allowed themes for this codemirror.
'Themes are all lower cased.
Public Sub setAllowedThemes(Themes As List)
	For Each s As String In Themes
		If CMW_Utils.Themes.IndexOf(s) = -1 Then
			Dim TH As Throwables
			TH.Initialize
			TH.Throw(Throwables_Static.NewIllegalArgumentException($"CodeMirrorWrapper: AllowedTheme '${s}' is not a valid theme.  Themes are case sensitive"$))
			Return
		End If
	Next
	
	mAllowedThemes.AddAll(Themes)
End Sub

Public Sub getAllowedThemes As List
	Return mAllowedThemes
End Sub

'Get / Set the Theme for this codemirror.
'Themes are all lowercased and must be in the AllowedThemes List.
'
'For convenience here is a full list of supported themes:
'<code>
'  "default"
'  "3024-day"
'  "3024-night"
'  "abcdef"
'  "ambiance"
'  "ayu-dark"
'  "ayu-mirage"
'  "base16-dark"
'  "base16-light"
'  "bespin"
'  "blackboard"
'  "cobalt"
'  "colorforth"
'  "darcula"
'  "dracula"
'  "duotone-dark"
'  "duotone-light"
'  "eclipse"
'  "elegant"
'  "erlang-dark"
'  "gruvbox-dark"
'  "hopscotch"
'  "icecoder"
'  "idea"
'  "isotope"
'  "lesser-dark"
'  "liquibyte"
'  "lucario"
'  "material"
'  "material-darker"
'  "material-palenight"
'  "material-ocean"
'  "mbo"
'  "mdn-like"
'  "midnight"
'  "monokai"
'  "moxer"
'  "neat"
'  "neo"
'  "night"
'  "nord"
'  "oceanic-next"
'  "panda-syntax"
'  "paraiso-dark"
'  "paraiso-light"
'  "pastel-on-dark"
'  "railscasts"
'  "rubyblue"
'  "seti"
'  "shadowfox"
'  "solarizeddark"
'  "solarizedlight"
'  "the-matrix"
'  "tomorrow-night-bright"
'  "tomorrow-night-eighties"
'  "ttcn"
'  "twilight"
'  "vibrant-ink"
'  "xq-dark"
'  "xq-light"
'  "yeti"
'  "yonce"
'  "zenburn"
'</code>
Public Sub setTheme(Theme As String)	
	If mAllowedThemes.IndexOf(Theme) = -1 Then
		Dim TH As Throwables
		TH.Initialize
		TH.Throw(Throwables_Static.NewIllegalArgumentException($"CodeMirrorWrapper: Theme '${Theme}' is not a valid theme"$))
		Return
	End If
	
	mCurrentTheme = Theme
	
	ToastMessageShow("Set Theme: [" & mCurrentTheme & "]", False)
	ExecuteScript($"editor.setOption("theme", "${mCurrentTheme}");"$)
	
	If SubExists(mCallBack, mEventName & "_SetSpinnerTheme") Then  ' Set the spinner if theme is set up by code
		CallSubDelayed2(mCallBack, mEventName & "_SetSpinnerTheme", Theme)
	End If
End Sub
Public Sub getTheme As String
	Return mCurrentTheme
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'Return a full HTML string of current loaded code editor.
'Return a void string if the code editor is not loaded.
Public Sub HTMLString As String
	If Loaded = False Then Return ""
	Return mFullHTML.ToString
End Sub

'Return the current codemirror library version.
'Return a void string if the code editor is not loaded.
Public Sub Version As String
	If Loaded = False Then Return ""
	Return mCodeMirrorPath
End Sub

Public Sub setLineWrapping(State As Boolean)
	If State Then
		mLineWrapping = "true"
	Else
		mLineWrapping = "false"
	End If
	ExecuteScript($"editor.setOption("lineWrapping", ${mLineWrapping});"$)
End Sub

Public Sub setAutoFocus(State As Boolean)
	If State Then
		mAutofocus = "true"
	Else
		mAutofocus = "false"
	End If
	ExecuteScript($"editor.setOption("autofocus", ${mAutofocus});"$)
End Sub


Public Sub UpdateHTMLPage

	CreateHTMLFile

	''''''''''''	LoadHTMLPage(File.GetUri(FilesFolder, "codemirrorwrapper.html")) ' B4J

	'''	Dim URI As String = FileURI(FilesFolder, "codemirrorwrapper.html") ' ORIGINAL
	'''	Log("CodeMirrorWrapper: UpdatePage: URI: " & URI)
	'''	LoadHTMLPage(URI)
	
	Dim URI As String = XUI.FileUri(FilesFolder, "codemirrorwrapper.html")  ' XUI
	Log("CodeMirrorWrapper: UpdatePage: URI: " & URI)
	
	Loaded = False
	'''	WebE.Load(URL)
	'''	UltimateWebView1.LoadUrl(URL)
	
'	Log("WebView is initialized here ? " & mWebView.IsInitialized)
	
	Log("CodeMirrorWrapper: LOADING PAGE: " & URI)
	mWebView.LoadUrl(URI)
	
End Sub

#Region URLUtils

''Returns a file URI. This can be used with WebView to access local resources.
''The URI depends on the compilation mode.
''The FileName parameter will be URL encoded.
''
''Note that this is the same as XUI.FileUri. You can use this if you do not plain to use XUI in your project.
''
''Example: <code>
''WebView1.LoadHtml($"<img src="${FileURI(File.DirAssets, "smiley.png")}" />"$)
'''or:
''WebView1.LoadUrl($"${FileURI(File.DirAssets, "smiley.png")}"$)
''</code>
'Public Sub FileURI(Dir As String, FileName As String) As String
'	If Not(Dir = "AssetsDir") Then  ' AssetsDir = File.DirAssets
'		Return "file://" & File.Combine(Dir, EncodeUrl(FileName, "UTF8"))
'	End If
' 
'	Dim jo As JavaObject
'	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
'		
'	If jo.GetField("virtualAssetsFolder") = Null Then
'		Return "file:///android_asset/" & EncodeUrl(FileName.ToLowerCase, "UTF8")
'	Else
'		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
'			EncodeUrl(jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)), "UTF8"))
'	End If
'End Sub

''Returns a file URL. This can be used with WebView to access local resources.
''The URL depends on the compilation mode.
''The FileName parameter need to be URL encoded if you pass it to a WebView.
''
''Example: <code>
''WebView1.LoadHtml($"<img src="${FileURL(File.DirAssets, "smiley.png")}" />"$)
'''or:
''WebView1.LoadUrl($"${FileURL(File.DirAssets, "smiley.png")}"$)
''</code>
'Public Sub FileURL(Dir As String, FileName As String) As String
'	If Not(Dir = "AssetsDir") Then  ' AssetsDir = File.DirAssets
'		Return "file://" & File.Combine(Dir, FileName)
'	End If
' 
'	Dim jo As JavaObject
'	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
'		
'	If jo.GetField("virtualAssetsFolder") = Null Then
'		Return "file:///android_asset/" & FileName.ToLowerCase
'	Else
'		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
'			jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))
'	End If
'End Sub

''Creates the URI of an asset file (The URI depends on the compilation mode).
''This can be used with WebView to access local resources, in this case FileName need to be URL encoded.
''
''Example:
''<code>Dim URI As String = $"<img src="${AssetFileURI("smiley.png")}"/>"$</code>
'Public Sub AssetFileURI (FileName As String) As String
'	Dim jo As JavaObject
'	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
'	If jo.GetField("virtualAssetsFolder") = Null Then
'		Return "file:///android_asset/" & EncodeUrl(FileName.ToLowerCase, "UTF8")
'	Else
'		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
'  			EncodeUrl(jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)), "UTF8"))
'	End If
'End Sub
'
''Creates the URL of an asset file (The URL depends on the compilation mode).
''This can be used with WebView to access local resources.
''
''Example:
''<code>Dim URL As String = $"<img src="${AssetFileURL("smiley.png")}"/>"$</code>
''
''This is code by Erel here: <link>link | https://www.b4x.com/android/forum/threads/printing-and-pdf-creation.76712/#content</link>
'Public Sub AssetFileURL (FileName As String) As String 'Ignor
'	Dim jo As JavaObject
'	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
'	If jo.GetField("virtualAssetsFolder") = Null Then
'		Return "file:///android_asset/" & FileName.ToLowerCase
'	Else
'		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
'  			jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))
'	End If
'End Sub

'Sub EncodeUrl(Url As String, CharSet As String) As String
'	Dim su As StringUtils
'	su.EncodeUrl(Url, CharSet)
'	Return su.EncodeUrl(Url, CharSet).Replace("+", "%20")
'End Sub

#End Region URLUtils

''Replace the {code} Tag with the actual Code we want to edit.
'Public Sub applyEditingTemplate(tCode As String) As String
'	Return mFullHTML.Replace("{code}",tCode) & CRLF
'End Sub

Private Sub ShowContextMenu  'Ignore

	Dim ActionMode As JavaObject = mWebView
	Dim menu As JavaObject = ActionMode.RunMethod("getMenu", Null)
	menu.RunMethod("show", Null)
	
'	Dim event As Object = menu.CreateEvent("android.view.MenuItem.OnMenuItemClickListener", "ContextMenuClick", True)
'	For Each s As String In Array("Set As Title", "Delete") 'menu items here
'		menu.RunMethodJO("add", Array(s)).RunMethod("setOnMenuItemClickListener", Array(event))
'	Next
End Sub

'Write the template to the application folder (easier than writing to temp while debugging).
Private Sub CreateHTMLFile
	Dim s As StringBuilder = CreateHTMLString
	Log("Save HTML Template file: " & File.Combine(FilesFolder, "codemirrorwrapper.html"))
	File.WriteString(FilesFolder, "codemirrorwrapper.html", s.ToString) 
	
	Log("Saved HTML File  -  Size: " & s.Length & " Bytes")
End Sub

Private Sub AddLink (SB As StringBuilder, Dir As String, Path As String) As StringBuilder
	Return SB.Append($"		<link rel="stylesheet" href="${Dir}${Path}">"$).Append(CRLF)
End Sub

Private Sub AddScript (SB As StringBuilder, Dir As String, Path As String) As StringBuilder
	Return SB.Append($"		<script src="${Dir}${Path}"></script>"$).Append(CRLF)
End Sub

'Create an HTML file from the template with the links to the specified language mode.
Private Sub CreateHTMLString As StringBuilder  'String
	Log("Creating HTML string ...")
	
	Dim now As Long = DateTime.Now
	
	' Create imports
	
	Dim Imports As StringBuilder
	Imports.Initialize
      	
'	<link rel="stylesheet" href="wrapper.css"> eventualmente da mettere dopo <link rel="stylesheet" href="${CodeMirrorCss}">
'	<script src="wrapper.js"></script> eventualmente da mettere dopo <script src="${MetaJs}"></script>

	Imports.Append(CRLF)
	AddLink(Imports, mCodeMirrorPath, "/lib/codemirror.css")   '.ToString
	AddScript(Imports, mCodeMirrorPath, "/lib/codemirror.js")
	AddScript(Imports, mCodeMirrorPath, "/mode/meta.js")
	AddScript(Imports, mCodeMirrorPath, "/addon/mode/loadmode.js")
	AddScript(Imports, mCodeMirrorPath, "/addon/edit/matchbrackets.js")
	
	If mCloseBrackets Then
		AddScript(Imports, mCodeMirrorPath, "/addon/edit/closebrackets.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/edit/closetag.js")
	End If
	
'	If mMatchTags Then
	AddScript(Imports, mCodeMirrorPath, "/addon/edit/matchtags.js")
'	End If
	
	If mActiveLine Then
		AddScript(Imports, mCodeMirrorPath, "/addon/selection/active-line.js")
	End If
	
	If mCodeFolding Then	
		Imports.Append(CRLF)	
		AddLink(Imports, mCodeMirrorPath, "/addon/fold/foldgutter.css")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/foldcode.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/foldgutter.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/brace-fold.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/xml-fold.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/indent-fold.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/comment-fold.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/fold/markdown-fold.js")
	End If
	
	' Lints
	If mLintType <> LINT_TYPE_NONE Then		
		Imports.Append(CRLF)
		AddLink(Imports, mCodeMirrorPath, "/addon/lint/lint.css")
		AddScript(Imports, mCodeMirrorPath, "/mode/css/css.js")
		AddScript(Imports, mCodeMirrorPath, "/addon/lint/lint.js")
		
		AddScript(Imports, mCodeMirrorPath, "/addon/lint/coffeescript-lint.js") ' Addon
		AddScript(Imports, mCodeMirrorPath, "/addon/lint/yaml-lint.js") ' Addon
		
		Select (mLintType)
			Case LINT_TYPE_HTML:
			
				ToastMessageShow("USE [HTML] LINT (Error checking)", False)
				Log("USE [HTML] LINT (Error checking)")
			
				If Not(File.Exists(FilesFolder, "HTMLHint.js")) Then	' HTMLHint.js required for HTML Lints
					Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " do not exists (Copy from Asset)")
					File.Copy(File.DirAssets, "HTMLHint.js", FilesFolder, "HTMLHint.js")
					Log("Done")
				Else
					Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " already exists.")
				End If
					
'				If Not(File.Exists(FilesFolder, "jshint.js")) Then  ' jshint.js required for Javascript Lints
'					Log("File " & File.Combine(FilesFolder, "jshint.js") & " do not exists (Copy from Asset)")
'					File.Copy(File.DirAssets, "jshint.js", FilesFolder, "jshint.js")
'					Log("Done")
'				Else
'					Log("File " & File.Combine(FilesFolder, "jshint.js") & " already exists.")
'				End If
			
				' Delete others if exists
				If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
				If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
				If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
				
				Imports.Append(CRLF)
				AddScript(Imports, FilesFolder, "/HTMLHint.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/lint/html-lint.js")
		
			Case LINT_TYPE_JS
			
'				ToastMessageShow("USE [HTML] LINT (Error checking)", False)
'				Log("USE [HTML] LINT (Error checking)")
'			
'				If Not(File.Exists(FilesFolder, "HTMLHint.js")) Then	' HTMLHint.js required for HTML Lints
'					Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " do not exists (Copy from Asset)")
'					File.Copy(File.DirAssets, "HTMLHint.js", FilesFolder, "HTMLHint.js")
'					Log("Done")
'				Else
'					Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " already exists.")
'				End If
							
				ToastMessageShow("USE [JAVASCRIPT] LINT (Error checking)", False)
				Log("USE [JAVASCRIPT] LINT (Error checking)")
			
				If Not(File.Exists(FilesFolder, "jshint.js")) Then  ' jshint.js required for Javascript Lints
					Log("File " & File.Combine(FilesFolder, "jshint.js") & " do not exists (Copy from Asset)")
					File.Copy(File.DirAssets, "jshint.js", FilesFolder, "jshint.js")
					Log("Done")
				Else
					Log("File " & File.Combine(FilesFolder, "jshint.js") & " already exists.")
				End If
			
				' Delete others if exists
				If File.Exists(FilesFolder, "HTMLHint.js") Then File.Delete(FilesFolder, "HTMLHint.js")
				If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
				If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
					
				Imports.Append(CRLF)
				AddScript(Imports, FilesFolder, "/jshint.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/lint/javascript-lint.js")
				AddScript(Imports, FilesFolder, "/HTMLHint.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/lint/html-lint.js")
				
			Case LINT_TYPE_CSS
			
				ToastMessageShow("USE [CSS] LINT (Error checking)", False)
				Log("USE [CSS] LINT (Error checking)")
			
				If Not(File.Exists(FilesFolder, "csslint.js")) Then	' csslint.js required for CSS Lints
					Log("File " & File.Combine(FilesFolder, "csslint.js") & " do not exists (Copy from Asset)")
					File.Copy(File.DirAssets, "csslint.js", FilesFolder, "csslint.js")
					Log("Done")
				Else
					Log("File " & File.Combine(FilesFolder, "csslint.js") & " already exists.")
				End If
			
				' Delete others if exists
				If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
				If File.Exists(FilesFolder, "HTMLHint.jss") Then File.Delete(FilesFolder, "HTMLHint.js")
				If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
				
				Imports.Append(CRLF)
				AddScript(Imports, FilesFolder, "/csslint.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/lint/css-lint.js")

			Case LINT_TYPE_JSON
			
				ToastMessageShow("USE [JSON] LINT (Error checking)", False)
				Log("USE [JSON] LINT (Error checking)")
			
				If Not(File.Exists(FilesFolder, "jsonlint.min.js")) Then	 ' jsonlint.js or jsonlint.min,js required for CSS Lints
					Log("File " & File.Combine(FilesFolder, "jsonlint.min.js") & " do not exists (Copy from Asset)")
					File.Copy(File.DirAssets, "jsonlint.min.js", FilesFolder, "csslint.js")
					Log("Done")
				Else
					Log("File " & File.Combine(FilesFolder, "jsonlint.min.js") & " already exists.")
				End If
			
				' Delete others if exists
				If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
				If File.Exists(FilesFolder, "HTMLHint.jss") Then File.Delete(FilesFolder, "HTMLHint.js")
				If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
				
				Imports.Append(CRLF)
				AddScript(Imports, FilesFolder, "/jsonlint.min.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/lint/json-lint.js")

			Case Else
				ToastMessageShow("LINT (Error checking) DISABLED", False)
				Log("LINT (Error checking) DISABLED")
			
				' Delete others if exists
				If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
				If File.Exists(FilesFolder, "HTMLHint.jss") Then File.Delete(FilesFolder, "HTMLHint.js")
				If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
				If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
		End Select
	End If
	
	' Hints
	If(mHintType <> HINT_TYPE_NONE) Then
		
		Imports.Append(CRLF)
		AddLink(Imports, mCodeMirrorPath, "/addon/hint/show-hint.css")
		AddScript(Imports, mCodeMirrorPath, "/addon/hint/show-hint.js")
		
		Select (mHintType)
			Case HINT_TYPE_HTML
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/html-hint.js")
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/javascript-hint.js")
			Case HINT_TYPE_JS
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/javascript-hint.js")
			Case HINT_TYPE_CSS
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/css-hint.js")
			Case HINT_TYPE_SQL
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/sql-hint.js")
			Case HINT_TYPE_XML
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/xml-hint.js")
			Case HINT_TYPE_ANYWORD
				AddScript(Imports, mCodeMirrorPath, "/addon/hint/anyword-hint.js")
		End Select
	End If
	
	' Search box
'	SB.Append(CRLF)
'	AddLink(SB, mCodeMirrorPath, "/addon/dialog/dialog.css")
'	AddScript(SB, mCodeMirrorPath, "/addon/dialog/dialog.js")	
'	AddScript(SB, mCodeMirrorPath, "/addon/search/search.js")
'	AddScript(SB, mCodeMirrorPath, "/addon/search/searchcursor.js")	
'	AddScript(SB, mCodeMirrorPath, "/addon/search/jump-to-line.js")
'	
'	AddScript(SB, mCodeMirrorPath, "/addon/scroll/annotatescrollbar.js")
'	AddScript(SB, mCodeMirrorPath, "/addon/search/matchesonscrollbar.js")
	
	''''''''''''''
	
	Dim SBThemes As StringBuilder
	SBThemes.Initialize
	SBThemes.Append(CRLF)
	
	' Add links to themes
	For Each theme As String In mAllowedThemes
		If theme = "default" Then Continue
		AddLink(SBThemes, mCodeMirrorPath, $"/theme/${theme}.css"$)
	Next

	'Log("THEMES: " & SBThemes.ToString)
	'''''	SB.Append(SBThemes.ToString)
	Imports.Append(SBThemes)
	
	Dim Gutters As String
	If mCodeFolding Then
		If mLintType <> LINT_TYPE_NONE Then
			Gutters = $"extraKeys: {"Ctrl-Q": function(cm){ cm.foldCode(cm.getCursor()); }},
				foldGutter: true,
				gutters: ["breakpoints", "CodeMirror-lint-markers", "CodeMirror-linenumbers", "CodeMirror-foldgutter"]"$
		Else
			Gutters = $"extraKeys: {"Ctrl-Q": function(cm){ cm.foldCode(cm.getCursor()); }},
				foldGutter: true,
				gutters: ["breakpoints", "CodeMirror-linenumbers", "CodeMirror-foldgutter"]"$
		End If
	Else
		If mLintType <> LINT_TYPE_NONE Then
			Gutters = $"	gutters: ["breakpoints", "CodeMirror-lint-markers"]"$
		Else
			Gutters = $"	"breakpoints""$
		End If
	End If
	
	'Log("GUTTER STRING: " & Gutters)

	mFullHTML.Remove(0, mFullHTML.Length+1)
	Log("HTML File Size dopo la rimozione: " & mFullHTML.Length & " Bytes")

	mFullHTML.Append($"
<!doctype HTML>
<HTML>
	<head>
		<meta charset="UTF-8">
	  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	  	${Imports.ToString}		
		<style>
			//body{
			//	overflow: hidden;
			//}
			.CodeMirror{
			   width: ${mWidth}px;
			   height: ${mHeight}px;
				// height: auto;
			/* width: 120%;
            height: auto; */
				font-size: ${mFontSize}${mFontUnit};
				border: 1px solid red;
			}
			 .CodeMirror-scroll {
			  overflow-y: hidden;
			  overflow-x: auto;
			} 
			
			.breakpoints {width: 1.6em; background-color: rgb(50,50,50);}
         .breakpoint {color: #822;} 
			.breakpoint-marker{padding-left: .6em;} 
			
         .editor-head {color: black;} 	 
		</style>
	</head> 
 	<body style="margin: 0; background-color: black;">
		<script>
			var doc;
			CodeMirror.modeURL = "${mCodeMirrorPath}/mode/%N/%N.js";

			var editor = CodeMirror(document.body, { // See 
				lineNumbers: ${mShowLineNumbers},
				matchBrackets: true,
				matchClosing: true, 
				autoCloseBrackets: true,
				autoCloseTags: true,
				indentUnit: 3,
				tabSize: 3,
				width: 'auto',
				height: 'auto',
				htmlMode: true, 
				addModeClass: true,
				pollInterval: 50,
				workTime: 100,
				workDelay: 150,
				viewportMargin: 50,  // Infinity,  
	         indentWithTabs: true,
				smartIndent: false,
				lint: true,		
				lint: {esversion: 6},  // lint: {options: {esversion: 2021}},  // Selection of Python 2/3 is also possible with setOption command.
				styleActiveLine: true,
				${Gutters},
				fixedGutter: true,
				foldGutter: true, 
				coverGutterNextToScrollbar: true,
				matchTags: {bothTags: true},
	         extraKeys: {"Alt-A": "autocomplete", "/": "toMatchingTag",  Tab: betterTab, Backspace: betterBackspace, 'Shift-Tab': (cm) => cm.execCommand('indentLess') }  // Need to be adapted for Android. By default on desktop it use a combination CTRL + SPACE or can be set here.
	         //extraKeys: {"Alt-F": "findPersistent"}
		   });
			
			function betterTab(cm) {  // TO BE TESTED
		      //alert("betterTab"); 
			   if (cm.somethingSelected()) {
		         cm.indentSelection("add");
		      } else {
		         cm.replaceSelection(cm.getOption("indentWithTabs")? "\t":
		         Array(cm.getOption("indentUnit") + 1).join(" "), "end", "+input");
		      }
		   }

			function betterBackspace(cm) {  // TO BE TESTED
				//alert("betterBackspace"); 
				if (!cm.somethingSelected()) {
					let cursorsPos = cm.listSelections().map((selection) => selection.anchor);
					let indentUnit = cm.options.indentUnit;
					let shouldDelChar = false;
					for (let cursorIndex in cursorsPos) {
						let cursorPos = cursorsPos[cursorIndex];
						let indentation = cm.getStateAfter(cursorPos.line).indented;
						if (!(indentation !== 0 &&
							cursorPos.ch <= indentation &&
							cursorPos.ch % indentUnit === 0)) {
							shouldDelChar = true;
						}
					}
					if (!shouldDelChar) {
						cm.execCommand('indentLess');
					} else {
						cm.execCommand('delCharBefore');
					}
				} else {
					cm.execCommand('delCharBefore');
				}
			}
			
			editor.on("gutterClick", function(cm, n) {
	        var info = cm.lineInfo(n);
	        cm.setGutterMarker(n, "breakpoints", info.gutterMarkers ? null : makeMarker());
	      });

	      function makeMarker() {
	        var marker = document.createElement("div");       
	        // alert("makeMarker");      
	        marker.className = 'breakpoint-marker';
		     marker.style.color = '#d00';
			  marker.innerHTML = '●';       
	        return marker;
	      }
			
			// Set event for callback to B4A when the code changes
			editor.on('change', function(cm, change){
				// console.log("codechanged");
				//B4A.CallSub2('CodeChanged', true, document.documentElement.innerText);
				B4A.CallSub('CodeChanged', true, change.text);
			});

			function setCode(Code){
				editor.setValue(atob(Code));
				doc = editor.getDoc();
				doc.clearHistory();
			}
		  
			function changeType(val) {
				var mode, spec, m;
				if (m = /.+\.([^.]+)$/.exec(val)) {
			    	var info = CodeMirror.findModeByExtension(m[1]);
			    	if (info) {
			      	mode = info.mode;
			      	spec = info.mime;
			    	}
				} else if (/\//.test(val)) {
			 		var info = CodeMirror.findModeByMIME(val);
			 		if (info) {
			   		mode = info.mode;
			   		spec = val;
			 	   }
			  	} else {
			    	mode = spec = val;
				}
				if (mode) {
					//console.log("Setting editor mode to [" + val + "]     ");
					//alert("Setting editor mode to [" + val + "]");
					editor.setOption("mode", spec);
					CodeMirror.autoLoadMode(editor, mode);
				} else {
					console.log("Could not find a mode corresponding to " + val);
				}
			}				
		</script>	
	</body>
</html>"$)
	
	now = DateTime.Now - now
	Log($"Edit HTML Template required ${now} milliseconds to complete"$)
	
	Return mFullHTML

	'   ' TEST CODEMIRROR DEMOS
'	For Each s As String In File.ListFiles(File.Combine(FilesFolder, $"${mCodeMirrorPath}/demo"$))
'		Log("File: " & s)
'	Next	
'	Return File.ReadString(File.Combine(FilesFolder, $"${mCodeMirrorPath}/demo"$), "folding.html")
End Sub

'Private Sub GetLintcode(LintType As Int, LintPath1 As String, LintPath2 As String) As String
'	Select (LintType)
'		Case LINT_TYPE_HTML:
'			Return $"
'	<script src="${HtmlLint}"></script>
'	<script src="${HtmlLintJs}"></script>
'		 "$)
'		Case LINT_TYPE_JAVASCRIPT
'			SB.Append($"
'	<script src="${JsLint}"></script>	
'	<script src="${JavascriptLintJs}"></script>
'		 "$)
'		Case LINT_TYPE_CSS
'			SB.Append($"
'	<script src="${CssLint}"></script>	
'	<script src="${CssLintJs}"></script>
'		 "$)
'		Case LINT_TYPE_JSON
'			SB.Append($"
'	<script src="${JsonLint}"></script>
'	<script src="${JsonLintJs}"></script>
'		 "$)
'	End Select
'End Sub

'Private Sub GetLintPath (LintType As Int) As String
'	
'	' Lints (Code Error Checking).
'	' Supported languages HTML, Javascript, CSS, JSON, CoffeScript (not used here), Yaml (not used here)
'	
'	Dim strLint As String = ""
'	
'	Select(LintType)
'		Case LINT_TYPE_JS:
'			strLint = $"${FilesFolder}/jshint.js"$
'			
'			ToastMessageShow("USE [JAVASCRIPT] LINT (Error checking)", False)
'			Log("USE [JAVASCRIPT] LINT (Error checking)")
'			
'			If Not(File.Exists(FilesFolder, "jshint.js")) Then  ' jshint.js required for Javascript Lints
'				Log("File " & File.Combine(FilesFolder, "jshint.js") & " do not exists (Copy from Asset)")
'				File.Copy(File.DirAssets, "jshint.js", FilesFolder, "jshint.js")
'				Log("Done")
'			Else
'				Log("File " & File.Combine(FilesFolder, "jshint.js") & " already exists.")
'			End If
'			
'			' Delete others if exists
'			If File.Exists(FilesFolder, "HTMLHint.js") Then File.Delete(FilesFolder, "HTMLHint.js")
'			If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
'			If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
'			
'		Case LINT_TYPE_HTML:
'			strLint = $"${FilesFolder}/HTMLHint.js"$
'			
'			ToastMessageShow("USE [HTML] LINT (Error checking)", False)
'			Log("USE [HTML] LINT (Error checking)")
'			
'			If Not(File.Exists(FilesFolder, "HTMLHint.js")) Then	' HTMLHint.js required for HTML Lints
'				Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " do not exists (Copy from Asset)")
'				File.Copy(File.DirAssets, "HTMLHint.js", FilesFolder, "HTMLHint.js")
'				Log("Done")
'			Else
'				Log("File " & File.Combine(FilesFolder, "HTMLHint.js") & " already exists.")
'			End If
'			
'			strLint = strLint & CRLF &  $"${FilesFolder}/jshint.js"$
'			
'			If Not(File.Exists(FilesFolder, "jshint.js")) Then  ' jshint.js required for Javascript Lints
'				Log("File " & File.Combine(FilesFolder, "jshint.js") & " do not exists (Copy from Asset)")
'				File.Copy(File.DirAssets, "jshint.js", FilesFolder, "jshint.js")
'				Log("Done")
'			Else
'				Log("File " & File.Combine(FilesFolder, "jshint.js") & " already exists.")
'			End If
'			
'			' Delete others if exists
''			If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
''			If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
'			If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
'			
'		Case LINT_TYPE_CSS:
'
'		Case LINT_TYPE_JSON:
'			strLint = $"${FilesFolder}/"jsonlint.min.js""$
'			
'			ToastMessageShow("USE [JSON] LINT (Error checking)", False)
'			Log("USE [JSON] LINT (Error checking)")
'			
'			If Not(File.Exists(FilesFolder, "jsonlint.min.js")) Then	 ' jsonlint.js or jsonlint.min,js required for CSS Lints
'				Log("File " & File.Combine(FilesFolder, "jsonlint.min.js") & " do not exists (Copy from Asset)")
'				File.Copy(File.DirAssets, "jsonlint.min.js", FilesFolder, "csslint.js")
'				Log("Done")
'			Else
'				Log("File " & File.Combine(FilesFolder, "jsonlint.min.js") & " already exists.")
'			End If
'			
'			' Delete others if exists
'			If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
'			If File.Exists(FilesFolder, "HTMLHint.jss") Then File.Delete(FilesFolder, "HTMLHint.js")
'			If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
'			
'		Case Else
'			ToastMessageShow("LINT (Error checking) DISABLED", False)
'			Log("LINT (Error checking) DISABLED")
'			
'			' Delete others if exists
'			If File.Exists(FilesFolder, "jshint.js") Then File.Delete(FilesFolder, "jshint.js")
'			If File.Exists(FilesFolder, "HTMLHint.jss") Then File.Delete(FilesFolder, "HTMLHint.js")
'			If File.Exists(FilesFolder, "csslint.js") Then File.Delete(FilesFolder, "csslint.js")
'			If File.Exists(FilesFolder, "jsonlint.min.js") Then File.Delete(FilesFolder, "jsonlint.min.js")
'	End Select
'	
'	Return strLint
'End Sub

#End Region Wrapper Subs

#Region JS Functions
'###############################################################################

'Inject Javascript code directly on the CodeEditor instance.
'This can be used to add new functionalities.
'Note that the CodeMirrorWrapper already do large use of this to iteract with a
'WebView where CodeMirror editor is initialized.
'
'If you for example do this:
'<code>ExecuteScript("alert('Hello World')")</code> 
'the WebView will show you an Alert message.
'
'The same way you can iteract with the CodeEditor using a variable 'editor', so eg. 
'<code>ExecuteScript($"editor.setSize(${Width},${Height})"$)</code> 
'will set the CodeEditor size.
'
'This code:
'<code>Dim text As String = ExecuteScript("editor.getSelection();")</code>
'will return the current text selection.
Public Sub ExecuteScript(Script As String) 'As Object '////////// HERE NEED TO RETURN A VALUE FROM JAVASCRIPT, WebViewExtras do not do it ...
	If Loaded = False Then
		Log("Cannot execute this JS script, editor is not loaded: " & Script)
		Return
	End If
	
	'''''''	Return WebE.ExecuteScript(Script)  ' <<< B4J original implementation return an object
	''	Return UltimateWebView1.ExecuteJavaScript(Script)
	wve.executeJavascript(mWebView, Script)
End Sub


''''''Public Sub ExecuteScript (Script As String) As ResumableSub
''''''	If Loaded = False Then
''''''		Log("Cannot execute this JS script, editor in not loaded: " & Script)
''''''		Return Null
''''''	End If
''''''	
''''''	 #if B4A
''''''	wve.executeJavascript(mWebView, $"B4A.CallSub('Process_HTML', true, ${Script})"$)
''''''	Wait For Process_Html(html As String)
''''''	Return html
''''''    #Else If B4J
''''''    Return WebView1.As(JavaObject).RunMethodJO("getEngine", Null).RunMethod("executeScript", Array(js))
''''''    #Else If B4i
''''''    Dim sf As Object = WebView1.EvaluateJavaScript(js)
''''''    Wait For (sf) WebView1_JSComplete (Success As Boolean, Result As String)
''''''    Return Result
''''''    #end if
''''''End Sub


'###############################################################################
'
''Run a javascript command and wait reply.
''
''Example code:
''<code>
''Dim Javascript As String
''Javascript = $"document.getElementById('para1').value"$
''Wait For (RunJavaScript(Javascript)) Complete(Html As String)
''Log(Html)
'''or
''Dim Parameters() As String = Array As String("para1", "para2", "para3")
''For Each Parameter As String In Parameters
''  Dim Javascript As String = $"document.getElementById('${Parameter}').value"$
''  Wait For (RunJavaScript(Javascript)) Complete(Html As String)
''  Log($"${Html} - ${Parameter}"$)
''Next</code>
'Private Sub RunJavaScript (js As String) As ResumableSub
'    #if B4A
'		wve.executeJavascript(mWebView, $"B4A.CallSub('Process_HTML', true, ${js})"$)
'		Wait For Process_Html(html As String)
'		Return html
'    #Else If B4J
'      Return WebView1.As(JavaObject).RunMethodJO("getEngine", Null).RunMethod("executeScript", Array(js))
'    #Else If B4i
'      Dim sf As Object = WebView1.EvaluateJavaScript(js)
'      Wait For (sf) WebView1_JSComplete (Success As Boolean, Result As String)
'      Return Result
'    #end if
'End Sub

'###############################################################################
#End Region JS Functions

'--------------------- COMMANDS -----------------

#Region Commands

'Select the whole content of the editor.
Public Sub SelectAll
	ExecuteScript("editor.selectAll();")
'	ExecuteScript("editor.refresh();")
End Sub

'Deletes the whole line under the cursor, including newline at the end.
Public Sub DeleteLine
	ExecuteScript("editor.deleteLine();")
End Sub

'Undo the last change.
' 
'Note that, because browsers still don't make it possible for scripts
'to react to or customize the context menu, selecting undo (or redo) 
'from the context menu in a CodeMirror instance does not work.
Public Sub Undo
	ExecuteScript("editor.undo();")
End Sub

'Redo the last undone change.
Public Sub Redo
	ExecuteScript("editor.redo();")
End Sub

'Undo the last change to the selection, or if there are no selection-only
'changes at the top of the history, undo the last change.
Public Sub UndoSelection
	ExecuteScript("editor.undoSelection();")
End Sub

'Redo the last change to the selection, or the 
'last text change if no selection changes remain.
Public Sub RedoSelection
	ExecuteScript("editor.redoSelection();")
End Sub

'Move the cursor to the start of the document.
Public Sub GoDocStart
	ExecuteScript("editor.goDocStart();")
End Sub

'Move the cursor to the end of the document.
Public Sub GoDocEnd
	ExecuteScript("editor.goDocEnd();")
End Sub

'Move the cursor to the start of the line.
Public Sub GoLineStart
	ExecuteScript("editor.goLineStart();")
End Sub

'Move the cursor to the end of the line.
Public Sub GoLineEnd
	ExecuteScript("editor.goLineEnd();")
End Sub

'Move to the start of the text on the line, or if we are already
'there, to the actual start of the line (including whitespace).
Public Sub GoLineStartSmart
	ExecuteScript("editor.goLineStartSmart();")
End Sub

'Move the cursor to the right side of the visual line it is on.
Public Sub GoLineRight
	ExecuteScript("editor.goLineRight();")
End Sub

'Move the cursor to the left side of the visual line it is on.
'If this line is wrapped, that may not be the start of the line.
Public Sub GoLineLeft
	ExecuteScript("editor.goLineLeft();")
End Sub

'Move the cursor to the left side of the visual line it is on.
'If that takes it to the start of the line, behave like GoLineStartSmart.
Public Sub GoLineLeftSmart
	ExecuteScript("editor.goLineLeftSmart();")
End Sub

'Move the cursor up one line.
Public Sub GoLineUp
	ExecuteScript("editor.goLineUp();")
End Sub

'Move the cursor down one line.
Public Sub GoLineDown
	ExecuteScript("editor.goLineDown();")
End Sub

'Move the cursor up one screen, and scroll up by the same distance.
Public Sub GoPageUp
	ExecuteScript("editor.goPageUp();")
End Sub

'Move the cursor down one screen, and scroll down by the same distance.
Public Sub GoPageDown
	ExecuteScript("editor.goPageDown();")
End Sub

'Move the cursor one character left, going to the
'previous line when hitting the start of line.
Public Sub GoCharLeft
	ExecuteScript("editor.goCharLeft();")
End Sub

'Move the cursor one character right, going to
'the next line when hitting the end of line.
Public Sub GoCharDown
	ExecuteScript("editor.goCharDown();")
End Sub

'Move the cursor one character left, but don't cross line boundaries.
Public Sub GoColumnLeft
	ExecuteScript("editor.goColumnLeft();")
End Sub

'Move the cursor one character right, don't cross line boundaries.
Public Sub GoColumnRight
	ExecuteScript("editor.goColumnRight();")
End Sub

'Move the cursor to the start of the previous word.
Public Sub GoWordLeft
	ExecuteScript("editor.goWordLeft();")
End Sub

'Move the cursor to the end of the next word.
Public Sub GoWordRight
	ExecuteScript("editor.goWordRight();")
End Sub

'Move to the left of the group before the cursor.
'
'A group is a stretch of word characters, a stretch of punctuation
'characters, a newline, or a stretch of more than one whitespace character.
Public Sub GoGroupLeft
	ExecuteScript("editor.goGroupLeft();")
End Sub

'Move to the right of the group after the cursor.
Public Sub GoGroupRight
	ExecuteScript("editor.goGroupRight();")
End Sub

'Delete the character before the cursor.
Public Sub DeleteCharBefore
	ExecuteScript("editor.delCharBefore();")
End Sub

'Delete the character after the cursor.
Public Sub DeleteCharAfter
	ExecuteScript("editor.delCharAfter();")
End Sub

'Delete up to the start of the word before the cursor.
Public Sub DeleteWordBefore
	ExecuteScript("editor.delWordBefore();")
End Sub

'Delete up to the end of the word after the cursor.
Public Sub DeleteWordAfter
	ExecuteScript("editor.delWordAfter();")
End Sub

'Delete to the left of the group before the cursor.
Public Sub DeleteGroupBefore
	ExecuteScript("editor.delGroupBefore();")
End Sub

'Delete to the left of the group after the cursor.
Public Sub DeleteGroupAfter
	ExecuteScript("editor.delGroupAfter();")
End Sub

'Auto-indent the current line or selection.
Public Sub IndentAuto
	ExecuteScript("editor.indentAuto();")
End Sub

'Indent the current line or selection by one indent unit.
'
'Indent unit is how many spaces a block (whatever that means in the edited language) should be indented.
'The default is 3.
Public Sub IndentMore
	ExecuteScript("editor.indentMore();")
End Sub

'Deindent the current line or selection by one indent unit.
'
'Indent unit is how many spaces a block (whatever that means in the edited language) should be indented.
'The default is 3.
Public Sub IndentLess
	ExecuteScript("editor.indentLess();")
End Sub

'Insert a tab character at the cursor.
Public Sub InsertTab
	ExecuteScript("editor.insertTab();")
End Sub

'Insert the amount of spaces that match the width a TAB at the cursor position would have.
Public Sub InsertSoftTab
	ExecuteScript("editor.insertSoftTab();")
End Sub

'If something is selected, indent it by one indent unit.
'If nothing is selected, insert a TAB character.
Public Sub DefaultTab
	ExecuteScript("editor.defaultTab();")
End Sub

'Swap the characters before and after the cursor.
Public Sub TransposeChars
	ExecuteScript("editor.transposeChars();")
End Sub

'Insert a newline and auto-indent the new line.
Public Sub NewlineAndIndent
	ExecuteScript("editor.newlineAndIndent();")
End Sub

''Not defined by the core library, but defined in the search addon (or custom client addons).
Public Sub Find
	ExecuteScript("editor.find();")
End Sub
Public Sub FindNext
	ExecuteScript("editor.findNext();")
End Sub
Public Sub FindPrev
	ExecuteScript("editor.findPrev();")
End Sub
Public Sub Replace
	ExecuteScript("editor.replace();")
End Sub
Public Sub ReplaceAll
	ExecuteScript("editor.replaceAll();")
End Sub

#End Region Commands




'FROM B4J
'
'#Region java

''Java
'#if java
'import netscape.javascript.JSObject;
'import javafx.scene.web.WebEngine;
'import anywheresoftware.b4a.BA.RaisesSynchronousEvents;
'
'//Needs to be a global variable otherwise it appears to be garbage collected.
'Bridge b;
'
'public class Bridge{
'    public Object callB4j(String sub,String funct) { // for call with no parameters
'		return ba.raiseEvent2(this, false,sub.toLowerCase(),true, funct);
'	}
'    public Object callB4j2(String sub,String funct, Object arg) { // for call with  1 param
'		return ba.raiseEvent2(this, false, sub.toLowerCase() , true, funct, arg);
'	}
'	public Object callB4j3(String sub, String funct,Object arg1, Object arg2) { // for call with  2 params
'		return ba.raiseEvent2(this, false,sub.toLowerCase() ,true, funct,arg1 ,arg2);
'	}
'}
'public void setBridge(WebEngine we) {
'	
'	JSObject jsobj = (JSObject) we.executeScript("window");
'	b = new Bridge();
'	jsobj.setMember("b4j", b);
'	
'	}
'#end if

'#End Region java
