B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' MiniHtml2
' Version: 2.00-alpha
Sub Class_Globals
	'Private Const tagname As String = "html"
	'Private mId As String
	Private mName As String
	Private mMode As String
	'Private mTagName As String
	Private mIndentString As String
	Private mFlat As Boolean
	Private mLineFeed As Boolean
	Private mFormatAttributes As Boolean
	Private mParent As MiniHtml
	Private mChildren As List
	Private mSiblings As List
	Private mAttributes As Map
	Private mStyles As Map
	Private mClasses As List
	Private Const mNoTag     As String = ""
	Private Const mMeta      As String = "meta"		' <meta>
	Private Const mSelf      As String = "self"		' <tag />
	Private Const mUniline   As String = "uniline" 	' <tag></tag>
	Private Const mMultiline As String = "multiline"' <tag> CRLF </tag>	
End Sub

' Initial with tag name
Public Sub Initialize (Name As String)
	mChildren.Initialize
	mSiblings.Initialize
	mAttributes.Initialize
	mStyles.Initialize
	mClasses.Initialize
	mFlat = False
	mLineFeed = True
	'mId = ""
	mName = Name
	'mTagName = tagName
	Select mName.ToLowerCase
		Case "head", "form", "table"
			mMode = mMultiline
		Case "meta", "input", "link"
			mMode = mMeta
		Case "title", "h1", "h2", "h3", "h4", "h5", "p", "script", "label", "button", "span", "li", "a", "i", "b", "u", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "small", "textarea"
			mMode = mUniline
			'mLineFeed = False
		Case "img", "br"', "link"
			mMode = mSelf ' self closing tag
		Case "text", ""
			mMode = mNoTag
		Case Else
			mMode = mMultiline
	End Select
	mIndentString = "  "
	'Return Me
End Sub

' No indent
' No CRLF
' No align attributes
Public Sub build As String
	Return buildImpl(-1, False)
End Sub

' Custom indent
' With CRLF on first line
' No align attributes
Public Sub build2 (indent As Int) As String
	Return buildImpl(indent, False)
End Sub

' Custom indent
' With CRLF on first line
' With alignment of second attribute onwards according to tag name length
Public Sub buildImpl (indent As Int, AlignAttribute2 As Boolean) As String
	Dim SB As StringBuilder
	SB.Initialize
	Dim sIndent As String
	Dim sSpacing As String
	Dim SpecialTags As List = Array As String("html", "head", "body", mNoTag)
	'Log("mTagName=" & mTagName & ", LF=" & mLineFeed)' & ", Line1CRLF=" & Line1CRLF)

	If mLineFeed Then
		SB.Append(CRLF)
	Else
		indent = -1
	End If
	
	' Build Left Indent
	Dim SB2 As StringBuilder
	SB2.Initialize
	For n = 0 To indent
		SB2.Append(mIndentString)
	Next
	sIndent = SB2.ToString
	
	If SpecialTags.IndexOf(mName) < 0 Then
		SB.Append(sIndent)
	End If
	
	If mMode <> "" Then
		SB.Append("<" & mName)
	End If
	
	Dim MoreThanOne As Boolean
	Dim Separator As String = " "
	
	Dim SB3 As StringBuilder
	SB3.Initialize
	For n = 0 To mName.Length + 1
		SB3.Append(Separator)
	Next
	sSpacing = SB3.ToString
	
	For Each key As String In mAttributes.Keys
		'Log(key & "->" & mAttributes.Get(key))
		Dim attrs As String = mAttributes.Get(key)
		
		SB.Append(Separator)
		SB.Append(key)
		If attrs.Length > 0 Then
			SB.Append("=")
			SB.Append(QUOTE)
			SB.Append(attrs)
			SB.Append(QUOTE)
		End If
		
		If MoreThanOne = False Then
			If mFlat = False And mFormatAttributes Then
				Separator = CRLF & sIndent & sSpacing
				'Log(mTagName & sIndent & "[" & sSpacing & "]newtag")
			End If
			MoreThanOne = True
		End If
	Next
	
	Select mMode
		Case mSelf
			'If mFlat = False Then SB.Append(" ")
			SB.Append("/>")
		Case mUniline, mMultiline, mMeta
			SB.Append(">")
	End Select

	For Each tagOrString In mChildren
		If tagOrString Is MiniHtml Then
			Dim mCurrent As MiniHtml = tagOrString
			SB.Append(mCurrent.BuildImpl(indent + 1, False))
		Else
			SB.Append(tagOrString)
		End If
	Next
	
	Select mMode
		Case mUniline
			If mChildren.Size > 1 Then
				SB.Append(CRLF)
				If SpecialTags.IndexOf(mName) < 0 Then
					SB.Append(sIndent)
				End If
			End If
			SB.Append("</" & mName & ">")
		Case mMultiline
			SB.Append(CRLF)
			If SpecialTags.IndexOf(mName) < 0 Then
				SB.Append(sIndent)
			End If
			SB.Append("</" & mName & ">")
	End Select
	Return SB.ToString
End Sub

'Get name attribute
Public Sub getName As String
	Return mName
End Sub

Private Sub Create (Name As String) As MiniHtml
	Dim NewTag As MiniHtml
	NewTag.Initialize(Name)
	Return NewTag
End Sub

'code: <code>html1.lang("en")</code>
Public Sub lang (value As String) As MiniHtml
	Return attr("lang", value)
End Sub

'Set an attribute with a key and value
Public Sub attr (key As String, value As String) As MiniHtml
	mAttributes.Put(key, value)
	Return Me
End Sub

'Insert more attributes from map
Public Sub attr2 (keyvals As Map) As MiniHtml
	For Each key As String In keyvals.Keys
		Dim value As String = keyvals.Get(key)
		mAttributes.Put(key, value)
	Next
	Return Me
End Sub

'Add a no-value attribute
Public Sub attr3 (key As String) As MiniHtml
	mAttributes.Put(key, "")
	Return Me
End Sub

'same as addTo (child)
Public Sub up (ParentTag As MiniHtml) As MiniHtml
	Return addTo(ParentTag)
End Sub

'Add to Parent and return current tag (child)
Public Sub addTo (ParentTag As MiniHtml) As MiniHtml
	ParentTag.add(Me)
	mParent = ParentTag
	Return Me
End Sub

'Add a Child and return the added tag (child)
Public Sub add (ChildTag As MiniHtml) As MiniHtml
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
	Return ChildTag
End Sub

'Return the Parent tag
Public Sub getParent As MiniHtml
	Return mParent
End Sub
Public Sub setParent (ParentTag As MiniHtml)
	mParent = ParentTag
End Sub

'Add a linebreak without indent
Public Sub linebreak
	mChildren.Add(Create(mNoTag))
End Sub

'Add a comment without indent
Public Sub comment (value As String, newline As Boolean)
	If newline Then linebreak
	text($"<!--${value}-->"$)
End Sub

Public Sub cdn (format As String, url As String, integrity As String) As MiniHtml
	Return cdn2(format, url, integrity, "anonymous")
End Sub

Public Sub cdn2 (format As String, url As String, integrity As String, crossorigin As String) As MiniHtml
	Select format.ToLowerCase
		Case "script"
			Dim map1 As Map = CreateMap("src": url)
			If integrity <> "" Then map1.Put("integrity", integrity)
			If crossorigin <> "" Then map1.Put("crossorigin", crossorigin)
			mChildren.Add(Create("script").attr2(map1))
		Case "style"
			Dim map2 As Map = CreateMap("href": url)
			If integrity <> "" Then map2.Put("integrity", integrity)
			If crossorigin <> "" Then map2.Put("crossorigin", crossorigin)
			map2.Put("rel", "stylesheet")
			mChildren.Add(Create("link").attr2(map2))
	End Select
	Return Me
End Sub

' Add inner text
Public Sub text (value As String) As MiniHtml
	mChildren.Add(value)
	Return Me
End Sub

' Remove all children and overwrite inner text
Public Sub text2 (value As String) As MiniHtml
	mChildren.Clear
	mChildren.Add(value)
	Return Me
End Sub

' Add text wrapped in between multiline tags
Public Sub textWrap (value As String) As MiniHtml
	mChildren.Add(Create(mNoTag))
	mChildren.Add(value)
	Return Me
End Sub

'Add a class
Public Sub cls (value As String) As MiniHtml
	Return addClass(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As MiniHtml
	Return addStyle(value)
End Sub

'Add a class
Public Sub addClass (value As String) As MiniHtml
	Try
		Dim names() As String = Regex.Split(" ", value)
		For Each subname As String In names
			If mClasses.IndexOf(subname) < 0 Then mClasses.Add(subname)
		Next
		'mClasses.Sort(True)
		updateClassAttribute
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'Remove a class
Public Sub removeClass (value As String) As MiniHtml
	If mClasses.IndexOf(value) > -1 Then mClasses.RemoveAt(mClasses.IndexOf(value))
	updateClassAttribute
	Return Me
End Sub

'Add one or more styles separated by semicolon
Public Sub addStyle (value As String) As MiniHtml
	Try
		Dim pairs() As String = Regex.Split(";", value)
		For Each pair As String In pairs
			Dim keyvals() As String = Regex.Split(":", pair.Trim)
			mStyles.Put(keyvals(0).Trim, keyvals(1).Trim)
		Next
		updateStyleAttribute
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'Remove a style by key
Public Sub removeStyle (key As String) As MiniHtml
	If mStyles.ContainsKey(key) Then mStyles.Remove(key)
	updateStyleAttribute
	Return Me
End Sub

'Remove class attribute if empty
Private Sub updateClassAttribute
	If mClasses.Size = 0 Then
		mAttributes.Remove("class")
	Else
		mAttributes.Put("class", ClassesAsString)
	End If
End Sub

'Remove style attribute if empty
Private Sub updateStyleAttribute
	If mStyles.Size = 0 Then
		mAttributes.Remove("style")
	Else
		mAttributes.Put("style", StylesAsString)
	End If
End Sub

'Convert list of classes into one String
Public Sub ClassesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each item As String In mClasses
		If sb.Length > 0 Then sb.Append(" ")
		sb.Append(item)
	Next
	Return sb.ToString
End Sub

'Convert map of styles into one String
Public Sub StylesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each key As String In mStyles.Keys
		If sb.Length > 0 Then sb.Append(";" & IIf(mFlat, "", " "))
		sb.Append($"${key}:${IIf(mFlat, "", " ")}${mStyles.Get(key)}"$)
	Next
	Return sb.ToString
End Sub

'Set mode
Public Sub setMode (TagMode As String)
	mMode = TagMode.ToLowerCase
End Sub
Public Sub getMode As String
	Return mMode
End Sub

'Set LineFeed
Public Sub setLineFeed (Value As Boolean)
	mLineFeed = Value
End Sub
Public Sub getLineFeed As Boolean
	Return mLineFeed
End Sub

' Set FormatAttributes
Public Sub setFormatAttributes (Value As Boolean)
	mFormatAttributes = Value
End Sub
Public Sub getFormatAttributes As Boolean
	Return mFormatAttributes
End Sub

'Set uniline mode
Public Sub uniline As MiniHtml
	mMode = mUniline
	Return Me
End Sub

'Set normal mode
Public Sub multiline As MiniHtml
	mMode = mMultiline
	Return Me
End Sub

Public Sub required As MiniHtml
	mAttributes.Put("required", "")
	Return Me
End Sub

Public Sub disabled As MiniHtml
	mAttributes.Put("disabled", "")
	Return Me
End Sub

Public Sub checked As MiniHtml
	mAttributes.Put("checked", "")
	Return Me
End Sub

Public Sub selected As MiniHtml
	mAttributes.Put("selected", "")
	Return Me
End Sub

Public Sub hidden As MiniHtml
	mAttributes.Put("hidden", "")
	Return Me
End Sub

Public Sub readonly As MiniHtml
	mAttributes.Put("readonly", "")
	Return Me
End Sub