B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=4.5
@EndOfDesignText@
' Created by: Aeric
' Credit to:  EnriqueGonzalez
' Version: 0.40
Sub Class_Globals
	Private mId As String
	Private mName As String
	Private mMode As String
	Private mTagName As String
	Private mIndentString As String
	Private mFlat As Boolean
	Private mParent As Tag
	Private mChildren As List
	Private mSiblings As List
	Private mAttributes As Map
	Private mStyles As Map
	Private mClasses As List
	Private Const mNoTag     As String = ""
	Private Const mMeta      As String = "meta"		' <meta>
	Private Const mLink      As String = "link"		' <tag />
	Private Const mUniline   As String = "uniline" 	' <tag></tag>
	Private Const mMultiline As String = "multiline"	' <tag> CRLF </tag>
End Sub

' Initialize tag with tagName
Public Sub Initialize (tagName As String) As Tag
	mParent = Null
	mChildren.Initialize
	mSiblings.Initialize
	mAttributes.Initialize
	mStyles.Initialize
	mClasses.Initialize
	mFlat = False
	mId = ""
	mName = ""
	mTagName = tagName
	Select mTagName.ToLowerCase
		Case "head", "form", "table"
			mMode = mMultiline
		Case "meta", "input"
			mMode = mMeta
		Case "title", "h1", "h2", "h3", "h4", "h5", "p", "script", "label", "button", "span", "li", "a", "i", "b", "u", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "small", "textarea"
			mMode = mUniline
		Case "img", "link", "br"
			mMode = mLink
		Case "text", ""
			mMode = mNoTag
		Case Else
			mMode = mMultiline
	End Select
	mIndentString = "  "
	Return Me
End Sub

' No indent no CRLF
Public Sub Build As String
	Return Build3(-1, False)
End Sub

' No indent with CRLF
Public Sub Build2 As String
	Return Build3(-1, True)
End Sub

' Indent with CRLF
Public Sub Build4 (indent As Int) As String
	Return Build3(indent, True)
End Sub

' Indent and first CRLF optional
Public Sub Build3 (indent As Int, Line1CRLF As Boolean) As String
	Dim SB As StringBuilder
	SB.Initialize
	If Line1CRLF Then
		SB.Append(CRLF)
	End If
	For n = 0 To indent
		SB.Append(mIndentString)
	Next
	If Not(mMode = "") Then
		SB.Append("<" & mTagName)
	End If
	For Each key As String In mAttributes.Keys
		'Log(key & "->" & mAttributes.Get(key))
		Dim attrs As String = mAttributes.Get(key)
		If attrs.Length > 0 Then
			SB.Append($" ${key}=${QUOTE}"$)
			SB.Append(attrs)
			SB.Append(QUOTE)
		Else
			SB.Append($" ${key}"$)
		End If
	Next
	Select mMode
		Case mLink
			'If mFlat = False Then SB.Append(" ")
			SB.Append("/>")
		Case mUniline, mMultiline, mMeta
			SB.Append(">")
	End Select
	For Each tagOrString In mChildren
		If tagOrString Is Tag Then
			Dim mCurrent As Tag = tagOrString
			Select mCurrent.TagName
				Case "span", "strong", "small", "em", "b", "u", "textarea"
					SB.Append(mCurrent.build) ' stay on same line
				Case Else
					If mTagName = "textarea" Then
						SB.Append(mCurrent.build)
					Else
						SB.Append(mCurrent.build3(indent + 1, True))
					End If
			End Select
		Else
			SB.Append(tagOrString)
		End If
	Next
	Select mMode
		Case mUniline
			SB.Append("</" & mTagName & ">")
		Case mMultiline
			SB.Append(CRLF)
			For n = 0 To indent
				SB.Append(mIndentString)
			Next
			SB.Append("</" & mTagName & ">")
	End Select
	Return SB.ToString
End Sub

' set to true for no indents and CRLF
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub

Public Sub getTagName As String
	Return mTagName
End Sub

Public Sub setTagName (tagName As String) As Tag
	mTagName = tagName
	Return Me
End Sub

' Get child by index
Public Sub Child (tagIndex As Int) As Tag
	Return mChildren.Get(tagIndex)
End Sub

' Get child matches id attribute
Public Sub ChildById (value As String) As Tag
	For i = 0 To mChildren.Size - 1
		If Child(i).mAttributes.Get("id") = value Then
			Return Child(i)
		End If
	Next
	Return Null
End Sub

' Get first child matches Tag Name
Public Sub ChildByTagName (value As String) As Tag
	For i = 0 To mChildren.Size - 1
		If Child(i).TagName = value Then
			Return Child(i)
		End If
	Next
	Return Null
End Sub

Public Sub PrintMe
	Log(Me.As(Tag).build)
End Sub

Public Sub PrintChildren
	Dim indent As String
	For Each item As Tag In mChildren
		indent = indent & "  "
		If item.IsInitialized Then
			Log($"${indent}${item.TagName}"$)
		End If
		item.PrintChildren
	Next
End Sub

' Add comment on new line
Public Sub comment (value As String) As Tag
	mChildren.Add(Html.create(mNoTag))
	mChildren.Add($"<!--${value}-->"$)
	Return Me
End Sub

' Add comment on same line
Public Sub comment2 (value As String) As Tag
	mChildren.Add($"<!--${value}-->"$)
	Return Me
End Sub

Public Sub title (value As String) As Tag
	mChildren.Add(Html.create("title").Text(value))
	Return Me
End Sub

Public Sub addMeta (key As String, value As String)
	mChildren.Add(Html.create("meta").attr(key, value))
End Sub

Public Sub addMeta2 (keyvals As Map)
	mChildren.Add(Html.create("meta").attr2(keyvals))
End Sub

' Deprecated. Use responsive.
Public Sub meta_preset As Tag
	addMeta("charset", "UTF-8")
	addMeta2(CreateMap("name": "viewport", "content": "width=device-width, initial-scale=1"))
	'addMeta2(CreateMap("http-equiv": "X-UA-Compatible", "content": "IE=edge"))
	Return Me
End Sub

'Add metas for UTF8 charset and mobile viewport 
Public Sub responsive As Tag
	addMeta("charset", "UTF-8")
	addMeta2(CreateMap("name": "viewport", "content": "width=device-width, initial-scale=1"))
	Return Me
End Sub

Public Sub cdnScript (src As String, integrity As String) As Tag
	Return cdnScript2(src, integrity, "anonymous")
End Sub

Public Sub cdnScript2 (src As String, integrity As String, crossorigin As String) As Tag
	mChildren.Add(Html.create("script").attr2(CreateMap("src": src, "integrity": integrity, "crossorigin": crossorigin)))
	Return Me
End Sub

Public Sub cdnStyle (href As String, integrity As String) As Tag
	Return cdnStyle2(href, integrity, "anonymous")
End Sub

Public Sub cdnStyle2 (href As String, integrity As String, crossorigin As String) As Tag
	mChildren.Add(Html.create("link").attr2(CreateMap("href": href, "rel": "stylesheet", "integrity": integrity, "crossorigin": crossorigin)))
	Return Me
End Sub

'Add inner text
Public Sub text (value As String) As Tag
	mChildren.Add(value)
	Return Me
End Sub

' Seem unused, set to Private before remove
Private Sub TextNextLine (value As String) As Tag 'ignore
	mChildren.Add(Html.create(mNoTag))
	mChildren.Add(value)
	Return Me
End Sub

' Seem unused, set to Private before remove
Private Sub TextInline (value As String) 'ignore
	mChildren.Add(value)
End Sub

' Seem unused, set to Private before remove
Private Sub innerText As String 'ignore
	If mChildren.Size > 0 Then
		If mChildren.Get(0).As(String).StartsWith("[") = False Then
			Return mChildren.Get(0)
		End If
	End If
	Return ""
End Sub

'code: <code>script("js/bootstrap.js")</code>
'output: <code><script src="js/bootstrap.js"></script></code>
Public Sub script (value As String) As Tag
	Return script2(CreateMap("src": value))
End Sub

'code: <code>script2(CreateMap("src": "js/bootstrap.js"))</code>
Public Sub script2 (keyvals As Map) As Tag
	mChildren.Add(Html.create("script").attr2(keyvals))
	Return Me
End Sub

'code: <code>script3("$cdn$/dist/htmx.min.js", "sha384...", "anonymous")</code>
Public Sub script3 (src As String, integrity As String, crossorigin As String) As Tag
	Dim keyvals As Map
	keyvals.Initialize
	keyvals.Put("src", src)
	If integrity <> "" Then keyvals.Put("integrity", integrity)
	If crossorigin <> "" Then keyvals.Put("crossorigin", crossorigin)
	Return script2(keyvals)
End Sub

' Wrap script inside script tags
'output: <code><script>value</script></code>
Public Sub script4 (value As String) As Tag
	mChildren.Add(Html.create("script").multiline.text(value))
	Return Me
End Sub

'Public Sub style (value As String) As Tag
'	mChildren.Add(Html.create("style").Text(value))
'	Return Me
'End Sub

Public Sub newline
	TextNextLine("")
End Sub

'Return id attribute
Public Sub getid As String
	Return mId
End Sub

'Set name attribute
Public Sub getname As String
	Return mName
End Sub

'Return the Children list
Public Sub getChildren As List
	Return mChildren
End Sub
Public Sub setChildren (Children As List)
	mChildren = Children
End Sub

'Return the Parent tag
Public Sub getParent As Tag
	Return mParent
End Sub
Public Sub setParent (ParentTag As Tag)
	mParent = ParentTag
End Sub

'Return the Siblings list
Public Sub getSiblings As List
	Return mSiblings
End Sub
Public Sub setSiblings (SiblingsTag As List)
	mSiblings = SiblingsTag
End Sub

'Add a Child and return the added tag (child)
Public Sub add (ChildTag As Tag) As Tag
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
	Return ChildTag
End Sub

'Add a Child and return current tag (parent)
Public Sub add2 (ChildTag As Tag) As Tag
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
	Return Me
End Sub

'Add a Child only (no tag)
Public Sub add3 (ChildTag As Tag)
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
End Sub

'Add to Parent and return current tag (child)
Public Sub addTo (ParentTag As Tag) As Tag
	ParentTag.add(Me)
	mParent = ParentTag
	Return Me
End Sub

'Add to Parent and return the parent tag (parent)
Public Sub addTo2 (ParentTag As Tag) As Tag
	ParentTag.add(Me)
	mParent = ParentTag
	Return ParentTag
End Sub

'Add to Parent only (no tag)
Public Sub addTo3 (ParentTag As Tag)
	ParentTag.add(Me)
	mParent = ParentTag
End Sub

'Add a Sibling and return the sibling tag (sibling)
Public Sub addSibling (siblingTag As Tag) As Tag
	mSiblings.Add(siblingTag)
	mParent.Add(siblingTag)
	siblingTag.Parent = mParent
	Return siblingTag
End Sub

'Add a Sibling and return parent tag (parent)
Public Sub addSibling2 (siblingTag As Tag) As Tag
	mSiblings.Add(siblingTag)
	mParent.Add(siblingTag)
	siblingTag.Parent = mParent
	Return mParent
End Sub

'Add a Sibling only (no tag)
Public Sub addSibling3 (siblingTag As Tag)
	mSiblings.Add(siblingTag)
	mParent.Add(siblingTag)
	siblingTag.Parent = mParent
End Sub

'Add a Sibling and return the current tag (current)
Public Sub addSibling4 (siblingTag As Tag) As Tag
	mSiblings.Add(siblingTag)
	mParent.Add(siblingTag)
	Return Me
End Sub

'Same as add (child)
Public Sub down (ChildTag As Tag) As Tag
	Return add(ChildTag)
End Sub

'Same as add2 (parent)
Public Sub down2 (ChildTag As Tag)
	add2(ChildTag)
End Sub

'Same as add3
Public Sub down3 (ChildTag As Tag)
	add3(ChildTag)
End Sub

'same as addTo (child)
Public Sub up (ParentTag As Tag) As Tag
	Return addTo(ParentTag)
End Sub

'same as addTo2 (parent)
Public Sub up2 (ParentTag As Tag) As Tag
	Return addTo2(ParentTag)
End Sub

'same as addTo3 (no tag)
Public Sub up3 (ParentTag As Tag)
	addTo3(ParentTag)
End Sub

'Add a Sibling and return the sibling tag (sibling)
Public Sub sib (siblingTag As Tag) As Tag
	Return addSibling(siblingTag)
End Sub

'Add a Sibling and return parent tag (parent)
Public Sub sib2 (siblingTag As Tag) As Tag
	Return addSibling2(siblingTag)
End Sub

'Add a Sibling only (no tag)
Public Sub sib3 (siblingTag As Tag)
	addSibling3(siblingTag)
End Sub

'Add a Sibling and return the current tag (current)
Public Sub sib4 (siblingTag As Tag) As Tag
	Return addSibling4(siblingTag)
End Sub

'Replace/return maps of attributes
Public Sub getAttributes As Map
	Return mAttributes
End Sub
'Replace/return maps of attributes
Public Sub setAttributes (keyvals As Map)
	mAttributes = keyvals
End Sub

'Replace/return maps of attributes
'Public Sub Get As Map
'	Return getAttributes
'End Sub

'Set an attribute with a key and value
Public Sub attr (key As String, value As String) As Tag
	mAttributes.Put(key, value)
	Return Me
End Sub

'Insert more attributes from map
Public Sub attr2 (keyvals As Map) As Tag
	For Each key As String In keyvals.Keys
		Dim value As String = keyvals.Get(key)
		mAttributes.Put(key, value)
	Next
	Return Me
End Sub

'Add a no-value attribute
Public Sub attr3 (key As String) As Tag
	mAttributes.Put(key, "")
	Return Me
End Sub

'Add attributes by passing a json object
Public Sub attr4 (json As String) As Tag
	Try
		Dim keyvals As Map = json.As(JSON).ToMap
		For Each key As String In keyvals.Keys
			Dim value As String = keyvals.Get(key)
			mAttributes.Put(key, value)
		Next
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'Add attributes by passing a json object
'Public Sub setAttributesFromJson (json As String) As Tag
'	Try
'		Dim keyvals As Map = json.As(JSON).ToMap
'		For Each key As String In keyvals.Keys
'			Dim value As String = keyvals.Get(key)
'			mAttributes.Put(key, value)
'		Next
'	Catch
'		Log(LastException)
'	End Try
'	Return Me
'End Sub

'Add id attribute
Public Sub addId (value As String) As Tag
	mAttributes.Put("id", value)
	Return Me
End Sub

'Add name attribute
Public Sub addName (value As String) As Tag
	mAttributes.Put("name", value)
	Return Me
End Sub

'Add action attribute
Public Sub addAction (value As String) As Tag
	mAttributes.Put("action", value)
	Return Me
End Sub

'Add link tag with only href
Public Sub addLink (href As String, rel As String, integrity As String, crossorigin As String) As Tag
	Return addLink3(href, rel, integrity, crossorigin, "", "", "")
End Sub

Public Sub addLink2 (keyvals As Map) As Tag
	mChildren.Add(Html.create("link").attr2(keyvals))
	Return Me
End Sub

Public Sub addLink3 (href As String, rel As String, integrity As String, crossorigin As String, titleText As String, typeText As String, asText As String) As Tag
	Dim Map1 As Map
	Map1.Initialize
	If href <> "" Then Map1.Put("href", href)
	If rel <> "" Then Map1.Put("rel", rel)
	If integrity <> "" Then Map1.Put("integrity", integrity)
	If crossorigin <> "" Then Map1.Put("crossorigin", crossorigin)
	If titleText <> "" Then Map1.Put("title", titleText)
	If typeText <> "" Then Map1.Put("type", typeText)
	If asText <> "" Then Map1.Put("as", asText)
	Return addLink2(Map1)
End Sub

'Add a class
Public Sub addClass (value As String) As Tag
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
Public Sub removeClass (value As String) As Tag
	If mClasses.IndexOf(value) > -1 Then mClasses.RemoveAt(mClasses.IndexOf(value))
	updateClassAttribute
	Return Me
End Sub

'Add one or more styles separated by semicolon
Public Sub addStyle (value As String) As Tag
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
Public Sub removeStyle (key As String) As Tag
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

'Set id attribute
Public Sub id (value As String) As Tag
	mId = value
	mAttributes.Put("id", mId)
	Return Me
End Sub

'Set name attribute
Public Sub name (value As String) As Tag
	mName = value
	mAttributes.Put("name", mName)
	Return Me
End Sub

'Set data- attribute
Public Sub data (key As String, value As Object) As Tag
	mAttributes.Put("data-" & key, value)
	Return Me
End Sub

'Set aria- attribute
Public Sub aria (key As String, value As Object) As Tag
	mAttributes.Put("aria-" & key, value)
	Return Me
End Sub

'Set action attribute
Public Sub action (value As String) As Tag
	mAttributes.Put("action", value)
	Return Me
End Sub

'Set value attribute
Public Sub valueOf (value As String) As Tag
	mAttributes.Put("value", value)
	Return Me	
End Sub

'Set type attribute
Public Sub typeOf (value As String) As Tag
	mAttributes.Put("type", value)
	Return Me
End Sub

'Set form attribute
Public Sub formOf (value As String) As Tag
	mAttributes.Put("form", value)
	Return Me
End Sub

'Set href attribute
Public Sub hrefOf (value As String) As Tag
	mAttributes.Put("href", value)
	Return Me
End Sub

'Set src attribute
Public Sub srcOf (value As String) As Tag
	mAttributes.Put("src", value)
	Return Me
End Sub

'Set target attribute
Public Sub targetOf (value As String) As Tag
	mAttributes.Put("target", value)
	Return Me	
End Sub

'Set width attribute
Public Sub width (value As String) As Tag
	mAttributes.Put("width", value)
	Return Me
End Sub

'Set height attribute
Public Sub height (value As String) As Tag
	mAttributes.Put("height", value)
	Return Me
End Sub

'Add link tag with only href
Public Sub link (href As String) As Tag
	Return addLink(href, "", "", "")
End Sub

'Add link tag with href and rel
Public Sub link2 (href As String, rel As String) As Tag
	Return addLink(href, rel, "", "")
End Sub

'Add link with rel="stylesheet"
Public Sub linkCss (href As String) As Tag
	Return addLink(href, "stylesheet", "", "")
End Sub

'Add link with rel="icon"
Public Sub linkIcon (linktype As String, href As String) As Tag
	Dim keyvals As Map = CreateMap("rel": "icon", "href": href)
	If linktype <> "" Then keyvals.Put("type", linktype)
	Return addLink2(keyvals)
End Sub

'Add a class
Public Sub cls (value As String) As Tag
	Return addClass(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As Tag
	Return addStyle(value)
End Sub

'Set mode
Public Sub setMode (TagMode As String)
	mMode = TagMode.ToLowerCase
End Sub
Public Sub getMode As String
	Return mMode
End Sub

'Set uniline mode
Public Sub uniline As Tag
	mMode = mUniline
	Return Me
End Sub

'Set normal mode
Public Sub multiline As Tag
	mMode = mMultiline
	Return Me
End Sub

Public Sub required As Tag
	mAttributes.Put("required", "")
	Return Me
End Sub

Public Sub hxGet (url As String) As Tag
	mAttributes.Put("hx-get", url)
	Return Me
End Sub

Public Sub hxPost (url As String) As Tag
	mAttributes.Put("hx-post", url)
	Return Me
End Sub

Public Sub hxPut (url As String) As Tag
	mAttributes.Put("hx-put", url)
	Return Me
End Sub

Public Sub hxPatch (url As String) As Tag
	mAttributes.Put("hx-patch", url)
	Return Me
End Sub

Public Sub hxDelete (url As String) As Tag
	mAttributes.Put("hx-delete", url)
	Return Me
End Sub

Public Sub hxSwap (swap As String) As Tag
	mAttributes.Put("hx-swap", swap)
	Return Me
End Sub

Public Sub hxTarget (target As String) As Tag
	mAttributes.Put("hx-target", target)
	Return Me
End Sub

Public Sub hxTrigger (trigger As String) As Tag
	mAttributes.Put("hx-trigger", trigger)
	Return Me
End Sub

Public Sub hxIndicator (indicator As String) As Tag
	mAttributes.Put("hx-indicator", indicator)
	Return Me
End Sub

Public Sub hxConfirm (value As String) As Tag
	mAttributes.Put("hx-confirm", value)
	Return Me
End Sub

Public Sub hxDisable As Tag
	mAttributes.Put("hx-disable", "")
	Return Me
End Sub

Public Sub hxHistory (value As String) As Tag
	mAttributes.Put("hx-history", value)
	Return Me
End Sub

Public Sub hxBoost (value As String) As Tag
	mAttributes.Put("hx-boost", value)
	Return Me
End Sub

Public Sub hxPushUrl (value As String) As Tag
	mAttributes.Put("hx-push-url", value)
	Return Me
End Sub

Public Sub hxExt (ext As String) As Tag
	mAttributes.Put("hx-ext", ext)
	Return Me
End Sub

Public Sub hxSync (sync As String) As Tag
	mAttributes.Put("hx-sync", sync)
	Return Me
End Sub

Public Sub hxSwapOob (value As String) As Tag
	mAttributes.Put("hx-swap-oob", value)
	Return Me
End Sub

'e.g <code>hxOn("click", "alert('You clicked me!')")</code>
'output <code>hx-on:click="alert('You clicked me!')"</code>
'e.g <code>hxOn(":after-request", "if(event.detail.successful) this.reset()")</code>
'output <code>hx-on::after-request="if(event.detail.successful) this.reset()"</code>
Public Sub hxOn (event As String, value As String) As Tag
	mAttributes.Put("hx-on:" & event, value)
	Return Me
End Sub