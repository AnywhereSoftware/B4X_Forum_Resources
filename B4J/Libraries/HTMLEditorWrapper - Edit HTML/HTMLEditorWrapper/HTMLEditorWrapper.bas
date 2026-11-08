B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#DesignerProperty: Key: SingleLineSpace, DisplayName: Single Line Space, FieldType: Boolean, DefaultValue: True, Description: Use single line spacing.
#DesignerProperty: Key: ShowCodeButton, DisplayName: Show Code Button, FieldType: Boolean, DefaultValue: True, Description: Add a code button to the HTMLEditor Toolbar.
#DesignerProperty: Key: ShowTableButton, DisplayName: Show Table Button, FieldType: Boolean, DefaultValue: True, Description: Add a Table button to the htmleditor Toolbar.
#DesignerProperty: Key: ShowLink, DisplayName: Show Link button, FieldType: Boolean, DefaultValue: True, Description: Show the link button.
#DesignerProperty: Key: ShowImage, DisplayName: image button, FieldType: Boolean, DefaultValue: True, Description: Show the add image button.
#DesignerProperty: Key: ShowTableInCode, DisplayName: Show Table button In Code Editor, FieldType: Boolean, DefaultValue: True, Description: Show the table button in the code editor.

#Event: LocationChanged(OldLocation as String, NewLocation as String)
Sub Class_Globals
	
	Public Const NAVIGATE_FORWARD As String = "forward"
	Public Const NAVIGATE_BACK As String = "back"
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public TextArea1 As B4XView
	Private btnCancel As B4XView
	Private btnDone As B4XView
	Public pnCodeBG As B4XView
	Public HTMLEditor1 As HTMLEditor
	
	Private btnCode As B4XView
	Private btnTable As B4XView
	Private btnLink As B4XView
	
	Private SingleLineSpacing As Boolean
	Private btnIndent As B4XView
	Private pmFontSize As B4XPlusMinus
	Private btnTables As B4XView
	Private btnReloadHTML As B4XView
	Private HTMLTables1 As HTMLTables
	Private HTMLTableMini1 As HTMLTableMini
	
	
	Private ScrollPane1 As ScrollPane
	Private Dialog As B4XDialog
	Private PreExtCallHtml As String
	Private btnImg As B4XView
	Private fx As JFX
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	mBase.LoadLayout("hewhtmleditor")
	mBase.LoadLayout("hewcodepane")
	
	HTMLTables1.mBase.RemoveViewFromParent
	ScrollPane1.InnerNode = HTMLTables1.mBase
	ScrollPane1.Visible = False
	
	SingleLineSpacing = Props.GetDefault("SingleLineSpace",True)
	
	pmFontSize.SetNumericRange(6,30,1)
	pmFontSize.SelectedValue = TextArea1.TextSize
	
	Props.Get("Form").As(Form).Stylesheets.Add(File.GetUri(File.DirAssets,"htmltables.css"))

	HTMLEditor1.HtmlText = ""
	Dialog.Initialize(mBase.Parent)
	
	CallSubDelayed2(Me,"Setup",Array As Boolean(Props.GetDefault("ShowCodeButton",True),Props.GetDefault("ShowTableButton",True),Props.GetDefault("ShowTableInCode",True),Props.GetDefault("ShowLink",True),Props.GetDefault("ShowImage",True)))

End Sub
Public Sub getWebView As WebView
	Return HTMLEditor1.As(JavaObject).RunMethod("lookup", Array("WebView"))
End Sub

Private Sub Setup(Args() As Boolean)

	Dim ShowCode As Boolean = Args(0)
	Dim ShowTable As Boolean = Args(1)
	Dim ShowInCode As Boolean = Args(2)
	Dim ShowLink As Boolean = Args(3)
	Dim ShowImage As Boolean = Args(4)

	Dim Editor As JavaObject = HTMLEditor1
	If SingleLineSpacing Then
		Dim WebView As JavaObject = Editor.RunMethod("lookup", Array("WebView"))
		If WebView.IsInitialized Then
			WebView.RunMethodJO("getEngine", Null).RunMethod("setUserStyleSheetLocation", Array($"data:,
p { 
    margin-top: 0em ;  
    margin-bottom: 0em ;
} "$))
		Else
			Log("Webview not found")
		End If
	End If
	
	'Which buttons have we been asked to show?
	Dim L As List
	L.Initialize
	
	If ShowLink Or ShowImage Then
		Dim Sep As JavaObject
		Sep.InitializeNewInstance("javafx.scene.control.Separator",Null)
		L.Add(Sep)
	End If
	
	If ShowLink Then
		btnLink.RemoveViewFromParent
		L.Add(btnLink)
		btnLink.Visible = True
		btnLink.As(Node).StyleClasses.AddAll(Array As String("htmleditor-btn","btn-link"))
		HTMLEW_Utils.SetTooltipTextSize(btnLink,12)
		
		btnReloadHTML.RemoveViewFromParent
		L.Add(btnReloadHTML)
		btnReloadHTML.Visible = True
		btnReloadHTML.As(Node).StyleClasses.AddAll(Array As String("htmleditor-btn","btn-reload"))
		HTMLEW_Utils.SetTooltipTextSize(btnReloadHTML,12)
		btnReloadHTML.Enabled = False
		btnReloadHTML.As(Button).SetAlphaAnimated(0,0.3)
		
		'redirect non file links to browser
		Dim Engine As JavaObject = getWebView.As(JavaObject).RunMethod("getEngine",Null)
'		Dim O As Object = Engine.CreateEventFromUI("javafx.beans.value.ChangeListener","WorkerStateChanged",Null)
'		Engine.RunMethodJO("getLoadWorker",Null).RunMethodJO("stateProperty",Null).RunMethod("addListener",Array(o))
		
		Dim O As Object = Engine.CreateEventFromUI("javafx.beans.value.ChangeListener","WVLocationChanged",Null)
		Engine.RunMethodJO("locationProperty",Null).RunMethod("addListener",Array(O))
	End If
	
	If ShowImage Then
		btnImg.RemoveViewFromParent
		L.Add(btnImg)
		btnImg.Visible = True
		btnImg.As(Node).StyleClasses.AddAll(Array As String("htmleditor-btn","btn-image"))
		HTMLEW_Utils.SetTooltipTextSize(btnImg,12)
	End If
	
	If (ShowTable Or ShowCode) Then
		Dim Sep As JavaObject
		Sep.InitializeNewInstance("javafx.scene.control.Separator",Null)
		L.Add(Sep)
	End If
	
	If ShowTable Then
		btnTable.RemoveViewFromParent
		L.Add(btnTable)
		btnTable.Visible = True
		btnTable.As(Node).StyleClasses.AddAll(Array As String("htmleditor-btn","btn-table"))
		HTMLEW_Utils.SetTooltipTextSize(btnTable,12)
	End If
		
	If ShowCode Then
		btnCode.RemoveViewFromParent
		L.Add(btnCode)
		btnCode.Visible = True
		btnCode.As(Node).StyleClasses.AddAll(Array As String("htmleditor-btn","btn-code"))
		HTMLEW_Utils.SetTooltipTextSize(btnCode,12)
	End If
	
	If ShowInCode Then
		btnTables.Visible = True
	End If
	
	'None?
	If L.Size = 0 Then Return
	
	Dim Buttons() As Object = L.As(JavaObject).RunMethod("toArray",Null)
	
	'Top-Toolbar from the HTMLEditor	
	Dim ToolBar As JavaObject = Editor.RunMethod("lookup",Array(".top-toolbar"))

	If ToolBar.IsInitialized Then

		
		Dim L As List = ToolBar.RunMethodJO("getItems",Null)
		
		Dim Target As JavaObject = L.Get(L.Size - 1)
		Dim Disabled As JavaObject = Target.As(JavaObject).RunMethod("disableProperty",Null)
		Dim o As Object = Disabled.CreateEventFromUI("javafx.beans.value.ChangeListener","DisableChange",Null)
		Disabled.RunMethod("addListener",Array(O))
		ToolBar.RunMethodJO("getItems",Null).RunMethod("addAll",Array(Buttons))
	Else
		Log("Toolbar not found")
	End If

	'Add a key press listener so we can fire the Indent sub from a keypress.	
	Dim O As Object = TextArea1.As(JavaObject).CreateEventFromUI("javafx.event.EventHandler","TaKeypress",Null)
	TextArea1.As(JavaObject).RunMethod("setOnKeyPressed",Array(O))

	
	Sleep(0)
	HERequestFocus
End Sub

'
'No longer needed.  I changed my mind on implementing.
'
'Private Sub WorkerStateChanged_Event (MethodName As String, Args() As Object)
'	Dim HTML As String = HTMLEditor1.HtmlText
'	Dim Engine As JavaObject = getWebView.As(JavaObject).RunMethodJO("getEngine",Null)
'	
'	If Engine.RunMethod("getLocation",Null).As(String).StartsWith("http") Then
'		Engine.RunMethodJO("getLoadWorker",Null).RunMethod("cancel",Null)
'		
'		Sleep(0)
'		HTMLEditor1.HtmlText = HTML
'	End If
'
'
'End Sub
'
Private Sub WVLocationChanged_Event (MethodName As String, Args() As Object)
	Dim OldLoc As String = Args(1)
	Dim NewLoc As String = Args(2)
	If  OldLoc = "" And NewLoc <> "" Then
		PreExtCallHtml =  HTMLEditor1.HtmlText
		btnReloadHTML.Enabled = True
		btnReloadHTML.As(Button).SetAlphaAnimated(0,1)
		If SubExists(mCallBack,mEventName & "_LocationChanged") Then
			CallSubDelayed3(mCallBack,mEventName & "_LocationChanged",OldLoc,NewLoc)
		End If
	End If
End Sub

Private Sub DisableChange_Event (MethodName As String, Args() As Object)
	Dim Enabled As Boolean = Not(Args(0).As(JavaObject).RunMethod("getValue",Null))
	btnCode.Enabled = Enabled
	btnTable.Enabled = Enabled
	btnLink.Enabled = Enabled
	
	If Enabled Then
		btnCode.As(Button).SetAlphaAnimated(0,1)
		btnTable.As(Button).SetAlphaAnimated(0,1)
		btnLink.As(Button).SetAlphaAnimated(0,1)
		btnImg.As(Button).SetAlphaAnimated(0,1)
	Else
		btnCode.As(Button).SetAlphaAnimated(0,0.3)
		btnTable.As(Button).SetAlphaAnimated(0,0.3)
		btnLink.As(Button).SetAlphaAnimated(0,0.3)
		btnImg.As(Button).SetAlphaAnimated(0,0.3)
	End If
End Sub

Private Sub TBMouseClicked_Event (MethodName As String, Args() As Object)
	HTMLEditor1_MouseClicked (Null)
End Sub

Private Sub HTMLEditor1_MouseClicked (EventData As MouseEvent)
	HTMLTableMini1.Hide
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  	HTMLEditor1.As(B4XView).SetLayoutAnimated(0,0,0,Width,Height)
End Sub

Private Sub btnDone_Click
	HTMLEditor1.HtmlText = TextArea1.Text
	pnCodeBG.Visible = False
	TextArea1.Text = ""
	HERequestFocus
End Sub

Private Sub HERequestFocus

	Dim WebV As B4XView = HTMLEditor1.As(JavaObject).RunMethod("lookup",Array("WebView"))
	Sleep(50)
	Dim MEVTS As JavaObject
	MEVTS.InitializeStatic("javafx.scene.input.MouseEvent")
	Dim MEVT As JavaObject
	MEVT.InitializeNewInstance("javafx.scene.input.MouseEvent", Array( _
	MEVTS.GetField("MOUSE_PRESSED"),0.0,0.0,200.0,200.0,"PRIMARY",1,False,False,False,False,True,False,False,True,False,True,Null))
	If WebV.IsInitialized Then WebV.As(JavaObject).RunMethod("fireEvent",Array(MEVT))
	Sleep(50)
	MEVT.InitializeNewInstance("javafx.scene.input.MouseEvent", Array( _
	MEVTS.GetField("MOUSE_RELEASED"),0.0,0.0,200.0,200.0,"PRIMARY",1,False,False,False,False,True,False,False,True,False,True,Null))

	If WebV.IsInitialized Then WebV.As(JavaObject).RunMethod("fireEvent",Array(MEVT))
End Sub

'Requires jFX8Print Library.  Create and pass a PrintJob for the whole of the webview content to be printed.
'See commented out code in the demo main module.
Public Sub PrintToJob(Job As Object) As ResumableSub
	Dim WebV As B4XView = HTMLEditor1.As(JavaObject).RunMethod("lookup",Array("WebView"))
	If WebV.IsInitialized Then
		
		'
		'		May be needed to hide the caret, I've seen it once or twice on prints
		'
		Dim JS As JavaObject
		JS.InitializeStatic("org.jsoup.Jsoup")
		Dim Doc As JavaObject = JS.RunMethod("parse", Array(HTMLEditor1.HtmlText))
		Dim OrigHTML As String = Doc.RunMethod("outerHtml",Null)
		
		Dim Body As JavaObject = Doc.RunMethod("body",Null)
		Dim PropStr As String = Body.RunMethod("attr",Array("style"))

		Body.RunMethod("attr",Array("style","caret-color:transparent;" & PropStr))
		
		HTMLEditor1.HtmlText = Doc.RunMethod("outerHtml",Null)

'		'For Testing
'		TextArea1.Text = HTMLEditor1.HtmlText
		
		Dim WebE As JavaObject = WebV.As(JavaObject).RunMethodJO("getEngine",Null)
		WebE.RunMethod("print",Array(Job))
		Sleep(500)

'
'		Unhide the caret
'
		HTMLEditor1.HtmlText = OrigHTML

'		'For Testing
'		TextArea1.Text = OrigHTML
		
		HERequestFocus
		Return True
	Else
		Return False
	End If
End Sub


'Cancel table editing
Private Sub btnCancel_Click
	HTMLTables1.Hide
	pnCodeBG.Visible = False
	TextArea1.Text = ""
	HERequestFocus
End Sub

'Show the code editor
Private Sub btnCode_Click
	pnCodeBG.Visible = Not(pnCodeBG.Visible)
	If pnCodeBG.Visible Then
		TextArea1.Text = HTMLEditor1.HtmlText
	End If
End Sub

'Mini table editor called from HTMLEditor toolbar
Private Sub btnTable_Click
	HTMLTableMini1.Show(btnTable)
End Sub

'Reload HTML.  Only enabled when a link has taken the HTMLEditor into uncharted territory.
Private Sub btnReloadHTML_Click
	If PreExtCallHtml <> "" Then HTMLEditor1.HtmlText = PreExtCallHtml
	btnReloadHTML.Enabled = False
	PreExtCallHtml = ""
	If SubExists(mCallBack,mEventName & "_LocationChanged") Then
		CallSubDelayed3(mCallBack,mEventName & "_LocationChanged","","editor")
	End If
	HERequestFocus
End Sub

'Insert an image
Private Sub btnImg_Click
	Wait For(ShowImageDialog("Add an Image","","",-1,-1,False)) Complete (bResp As Boolean)
End Sub

Private Sub ShowImageDialog(Title As String,url As String,alt As String,width As Int,height As Int, center As Boolean) As ResumableSub
	Dim TFT As MultiFieldInputTemplate
	TFT.Initialize
	Dialog.Title = Title
	TFT.Label1.Text = "URL"
	TFT.Label2.Text = "Alt"
	TFT.Pane1.Visible = True
	TFT.Label3.Text = "Width"
	TFT.Label4.Text = "Height"

	Dim PM1Click As PlusMinusClick
	Dim PM2Click As PlusMinusClick
	PM1Click.Initialize(TFT.B4XPlusMinus1)
	PM2Click.Initialize(TFT.B4XPlusMinus2)
	TFT.B4XPlusMinus1.SetNumericRange(-1,1000,1)
	TFT.B4XPlusMinus2.SetNumericRange(-1,1000,1)
	TFT.B4XPlusMinus1.SelectedValue = width
	TFT.B4XPlusMinus2.SelectedValue = height
	TFT.cbCenter.Checked = center
	HTMLEW_Utils.RightToLeft(TFT.cbCenter)
	
	TFT.Field1Text = url
	TFT.Field2Text = alt
	
	Wait For (Dialog.ShowTemplate(TFT,"OK","","Cancel")) Complete (resp As Int)
	
	If resp = xui.DialogResponse_Cancel Then Return False
	
	'Build the required HTML
	Dim alt As String = TFT.Field2Text
	If alt = "" Then alt = "image"
	Dim HTML As StringBuilder
	HTML.Initialize
	HTML.Append($"<img src="${TFT.Field1Text}" alt="${alt}""$)
	If TFT.B4XPlusMinus1.SelectedValue > -1 Then
		HTML.Append($" width="${NumberFormat(TFT.B4XPlusMinus1.SelectedValue,1,0)}""$)
	End If
	If TFT.B4XPlusMinus2.SelectedValue > -1 Then
		HTML.Append($" height="${NumberFormat(TFT.B4XPlusMinus2.SelectedValue,1,0)}""$)
	End If
	If TFT.cbCenter.Checked Then
		HTML.Append($" style="display:block;margin:auto;""$)
	End If
	
	HTML.Append(">")
	
	'Try to make sure the HTMLEditor has focus
	HTMLEditor1.RequestFocus
	'Paste the HTML
	HTMLEW_Utils.PasteHTML(TFT.Field2Text,HTML.ToString)
	
	Return True
End Sub

'Insert a link
Private Sub btnLink_Click
	Wait For (ShowLinkDialog("Add a Link", "","")) Complete (bResp As Boolean)

End Sub

Private Sub ShowLinkDialog(Title As String,hRef As String,Text As String) As ResumableSub
	
	Dim TFT As MultiFieldInputTemplate
	TFT.Initialize
	Dialog.Title = Title
	TFT.Label1.Text = "URL"
	TFT.Label2.Text = "Text"
	TFT.Field1Text = hRef
	TFT.Field2Text = Text
	TFT.tf1HintText = "Enter complete url incuding http:// or file:/// etc."
	Wait For (Dialog.ShowTemplate(TFT,"OK","","Cancel")) Complete (resp As Int)
	
	If resp = xui.DialogResponse_Cancel Then Return False
	
	Dim LinkText As String = TFT.Field2Text
	If LinkText = "" Then LinkText = TFT.Field1Text
	
	'Build the required HTML
	Dim HTML As String = $"<a href="${TFT.Field1Text}">${LinkText}</a>"$

	'Try to make sure the HTMLEditor has focus
	HTMLEditor1.RequestFocus


	'Paste it
	HTMLEW_Utils.PasteHTML(LinkText,HTML)
	Return True
End Sub

'This is an optional function, it is not totally without issue.
'The whole link needs to be manually selected by the user and although this is validated, the validation can fail
'if there are two links with the same href, and the text in a second link matches the selected text from the first.
'It shouldn't happen often, but it can screw up the html if/when it does.
Public Sub EditLink As ResumableSub
			
	HTMLEditor1.RequestFocus
	fx.Clipboard.SetString("")
	HTMLEW_Utils.RobotCopy
	Sleep(50)
	Dim Target As String = HTMLEW_Utils.GetHTMLfromClipboard
	Dim SU As StringUtils
	Target = SU.DecodeUrl(Target,"UTF8")
	If Target = "" Then
		Dialog.Title = "Link tag not found"
		Wait For(Dialog.Show("Please select the whole Link text","OK","","")) Complete (resp As Int)
		Return False
	End If
	
	Dim JS As JavaObject
	JS.InitializeStatic("org.jsoup.Jsoup")
	Dim Element As JavaObject = JS.RunMethod("parse", Array(Target))
	If Element.IsInitialized Then
		Dim Link As JavaObject = Element.RunMethod("selectFirst",Array("[href]"))
		
		If Link.IsInitialized = False Then
			Dialog.Title = "Link tag not found"
			Wait For(Dialog.Show("Please select the whole Link text","OK","","")) Complete (resp As Int)
			Return False
		End If
		
		Dim hRef As String = Link.RunMethod("attr",Array("href"))
		Dim Text As String = Element.RunMethod("text",Null)
		
		If hRef = "" Or Text = "" Then Return False
		
		
		'Check that the whole link text has been selected
		'This will not be effective if there are other links with the same href and the selected text.
		Dim Found As Boolean
		Dim Doc As JavaObject = JS.RunMethod("parse", Array(HTMLEditor1.HtmlText))
		'Can't select the hrefs directly as sometimes the retrieved url ends with / and sometimes not.
		Dim Elements As List = Doc.RunMethod("select",Array($"a[href]"$))
		
		Dim href1 As String
		For Each Element As JavaObject In Elements
			Dim Link As JavaObject = Element.RunMethod("selectFirst",Array("[href]"))
			href1 = Link.RunMethod("attr",Array("href")).As(String)
'			Log(href1 & " : " & href)
			'It doesn't seem to matter which way froun the "/\" are and can be either, so just ignore them.
			If  href1.Replace("/","").Replace("\","") = hRef.Replace("/","").Replace("\","") And Element.RunMethod("text",Null) = Text Then
				Found = True
				Exit
			End If
			
		Next
		If Found = False Then
			Dialog.Title = "Link not found"
			Wait For(Dialog.Show("Please select the whole Link text","OK","","")) Complete (resp As Int)
			Return False
		End If
		
		Wait For(ShowLinkDialog("Edit Link",href1,Text)) Complete (BResp As Boolean)
	Else
		Dialog.Title = "Error parsing target"
		Wait For(Dialog.Show("Error parsing target " & Target,"OK","","")) Complete (resp As Int)
		Return False
	End If
	Return True
End Sub

'This is an optional function. More stable that the edit link option, as there is no chance of mis selection of the image.  It's either selected or not.
Public Sub EditImage As ResumableSub
	HTMLEditor1.RequestFocus
	fx.Clipboard.SetString("")
	HTMLEW_Utils.RobotCopy
	Sleep(50)
	Dim Target As String = HTMLEW_Utils.GetHTMLfromClipboard
	Dim SU As StringUtils
	Target = SU.DecodeUrl(Target,"UTF8")
	If Target = "" Then
		Dialog.Title = "Image tag not found"
		Wait For(Dialog.Show("Please select the image","OK","","")) Complete (resp As Int)
		Return False
	End If
	
	Dim JS As JavaObject
	JS.InitializeStatic("org.jsoup.Jsoup")
	Dim Element As JavaObject = JS.RunMethod("parse", Array(Target))
	If Element.IsInitialized Then
		Dim Img As JavaObject = Element.RunMethod("selectFirst",Array("img"))
		
		If Img.IsInitialized = False Then
			Dialog.Title = "Image tag not found"
			Wait For(Dialog.Show("Please select the image","OK","","")) Complete (resp As Int)
			Return False
		End If
		
		Dim src As String = Img.RunMethod("attr",Array("src"))
		Dim alt As String = Img.RunMethod("attr",Array("alt"))
		Dim width As String = Img.RunMethod("attr",Array("width"))
		Dim height As String = Img.RunMethod("attr",Array("height"))
		Dim Center As Boolean = Img.RunMethod("outerHtml",Null).As(String).Replace(" ","").Contains("margin:auto;")
		If width = "" Then width = -1
		If height = "" Then height = -1
		
		Wait For(ShowImageDialog("Edit Image",src,alt,width,height,Center)) Complete (BResp As Boolean)
		
	End If
	Return True
End Sub

Public Sub OpenExternal As ResumableSub
	HTMLEditor1.RequestFocus
	fx.Clipboard.SetString("")
	HTMLEW_Utils.RobotCopy
	Sleep(50)
	Dim Target As String = HTMLEW_Utils.GetHTMLfromClipboard
	Dim SU As StringUtils
	Target = SU.DecodeUrl(Target,"UTF8")
	If Target = "" Then
		Dialog.Title = "Tag not found"
		Wait For(Dialog.Show("Please select an image or link","OK","","")) Complete (resp As Int)
		Return False
	End If
	
	Dim JS As JavaObject
	JS.InitializeStatic("org.jsoup.Jsoup")
	Dim Element As JavaObject = JS.RunMethod("parse", Array(Target))
	If Element.IsInitialized Then
		Dim Img As JavaObject = Element.RunMethod("selectFirst",Array("img"))
		If Img.IsInitialized Then
			Dim src As String = Img.RunMethod("attr",Array("src"))
			
			If src = "" Then Return False
			fx.ShowExternalDocument(src)
		Else
			Dim Link As JavaObject = Element.RunMethod("selectFirst",Array("[href]"))
		
			If Link.IsInitialized Then
					Dim hRef As String = Link.RunMethod("attr",Array("href"))
				If hRef = "" Then Return False
				fx.ShowExternalDocument(hRef)
			Else
				Dialog.Title = "Tag not found"
				Wait For(Dialog.Show("Please select an image or link","OK","","")) Complete (resp As Int)
				Return False
			End If
		End If
	End If
	
	Return True
End Sub


'Navigate the browser Direction should be Forward or Back
Public Sub NavigatePage(Direction As String)
	getWebView.As(JavaObject).RunMethodJO("getEngine", Null).RunMethod("executeScript",Array($"history.${Direction.toLowercase}();"$))
End Sub

'
'Code editor area
'

'Indent the html
Private Sub btnIndent_Click
	Dim Spaces As Int = 4
	Dim JS As JavaObject
	JS.InitializeStatic("org.jsoup.Jsoup")
	Dim Doc As JavaObject = JS.RunMethod("parse", Array(TextArea1.Text))
	'Change the indent size to 4
	Doc.RunMethodJO("outputSettings",Null).RunMethod("indentAmount",Array(Spaces))
	
	'Get the indented HTML from jSoap and pass it to the styles indenter
	TextArea1.Text = IndentStyles(Doc.RunMethod("html",Null),Spaces)
End Sub

Private Sub IndentStyles(HTML As String, Spaces As Int) As String
	Dim LHTML As String = HTML.ToLowerCase
	If LHTML.Contains("<style") = False Then Return HTML
	
	Dim L As List = Regex.Split(CRLF,HTML)
	
	Dim OutStr As StringBuilder
	OutStr.Initialize
	Dim Indent As Int
	Dim InTag As Boolean
	For i = 0 To L.Size - 1
		Dim Line As String = L.Get(i)
		If Line.ToLowerCase.Contains("<style") Then
			Indent = Line.IndexOf("<style") + Spaces - 1
			OutStr.Append(CRLF)
			OutStr.Append(Line)
			i = i + 1
			If i > L.Size - 1 Then Exit
			Line = L.Get(i)
			Do Until Line.ToLowerCase.Contains("</style>")
				If InTag And Line.Trim.EndsWith("}") And Line.Trim.Length = 1 Then
					InTag = False
					Indent = Indent - Spaces
				End If
				OutStr.Append(CRLF)
				For j = 0 To Indent
					OutStr.Append(" ")
				Next
				OutStr.Append(Line.Trim)
				If InTag And Line.Trim.EndsWith("}") And Line.Trim.Length > 1 Then
					InTag = False
					Indent = Indent - Spaces
				End If
				If Line.Contains("{") Then
					If Line.Trim.EndsWith("}") = False Then
						InTag = True
						Indent = Indent + Spaces
					End If
				End If
				
				i = i + 1
				If i > L.Size - 1 Then Exit
				Line = L.Get(i)
			Loop
			If i > L.Size - 1 Then Exit
			OutStr.Append(CRLF)
			Indent = Indent - Spaces
			For j = 0 To Indent
				OutStr.Append(" ")
			Next
			OutStr.Append(Line.trim)
		Else
			OutStr.Append(CRLF)
			OutStr.Append(Line)
		End If
	Next
	Return OutStr.ToString.SubString(1)
End Sub

Private Sub pmFontSize_ValueChanged (Value As Object)
	TextArea1.TextSize = Value
End Sub

'Show the main Table editor
Sub btnTables_Click
	HTMLTables1.Show
	HTMLTables1.ClearUI
	
	If pnCodeBG.Visible Then
		Dim TableStr As String
		
		'If there is an existing selection, does it contain a table?
		If TextArea1.SelectionLength > 0 Then
			TableStr = TextArea1.Text.SubString2(TextArea1.SelectionStart,TextArea1.SelectionStart + TextArea1.SelectionLength)
			If TableStr.Trim.StartsWith("<table") And TableStr.Trim.EndsWith("</table>") Then
				Wait For(HTMLTables1.ParseTable(TableStr)) Complete (Resp As Boolean)
				Return
			End If
		End If
		
		'Try to determine if the caret is within a table
		'Get the start and end position of all tables in the code.
		Dim Pos As Int = 0
		Dim TStarts As List
		TStarts.Initialize
		Do While True
			Pos = TextArea1.Text.IndexOf2("<table",Pos)
			If Pos = -1 Then Exit
			TStarts.Add(Pos)
			Pos = Pos + 1
		Loop
	
		Dim TEnds As List
		TEnds.Initialize
		Pos = 0
		Do While True
			Pos = TextArea1.Text.IndexOf2("</table>",Pos)
			If Pos = -1 Then Exit
			TEnds.Add(Pos + "</table>".Length)
			Pos = Pos + 1
		Loop
		
		'Corrupted HTML tags
		If TStarts.Size <> TEnds.Size Then Return
	
		
		'Check all tables to see if the caret is within one.
		Dim TStart, TEnd As Int
		For i = 0 To TStarts.Size - 1
			TStart = TStarts.Get(i)
			TEnd = TEnds.Get(i)
		
			'Found one, parse the table.
			If TStart <= TextArea1.SelectionStart And TEnd > TextArea1.SelectionStart Then
				TextArea1.SetSelection(TStart,TEnd - TStart)
				TableStr = TextArea1.Text.SubString2(TextArea1.SelectionStart,TextArea1.SelectionStart + TextArea1.SelectionLength)
				Wait For(HTMLTables1.ParseTable(TableStr)) Complete (Resp As Boolean)
			End If
		Next
	End If
End Sub


'A new table has been generated.
Private Sub HTMLTables1_Generated(HTML As String)
	If pnCodeBG.Visible Then
		'Cut any existing selection and insert the generated table
		Dim StartStr As String = TextArea1.Text.SubString2(0,TextArea1.SelectionStart)
		Dim TextEnd As String = TextArea1.Text.SubString(TextArea1.SelectionStart +TextArea1.SelectionLength)
		TextArea1.Text = StartStr & CRLF & HTML & CRLF & TextEnd
	Else
'		Log("Pasting...")
	'this is now redundant as the main editor is only available from the code editor page.
		Dim DataFormat As JavaObject
		DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
		Dim Clipboard As JavaObject
		Clipboard.InitializeStatic("javafx.scene.input.Clipboard")
		Clipboard = Clipboard.RunMethod("getSystemClipboard",Null)
		Dim m As Map
		m.Initialize
		m.Put(DataFormat.GetField("HTML"),HTML)
		m.Put(DataFormat.GetField("PLAIN_TEXT"),"Table")
		
		Clipboard.RunMethod("setContent",Array(M))
		
		Sleep(100)
		HTMLEW_Utils.RobotPaste
		
	End If
End Sub

'Mini table has been generated
Private Sub HTMLTableMini1_Generated(HTML As String)
	'Try to make sure the HTMLEditor has focus
	HTMLEditor1.RequestFocus
	'Paste the table.
	HTMLEW_Utils.PasteHTML("Table",HTML)
End Sub


'Capture keypresses on the text areas
Private Sub TaKeypress_Event (MethodName As String, Args() As Object)
	
	Dim KEvt As JavaObject = Args(0)
	'Looking for Atl + f
	If KEvt.RunMethod("isAltDown",Null) And KEvt.RunMethod("getText",Null) = "f" Then
		KEvt.RunMethod("consume",Null)
		btnIndent_Click
	End If
	
	'Testing only
'	Log(KEvt.RunMethod("getText",Null))
'	If KEvt.RunMethod("isControlDown",Null) And KEvt.RunMethod("getText",Null) = "p" Then
'		Log("Print")
'		KEvt.RunMethod("consume",Null)
'		Main.TestPrint
'	End If
	
End Sub


