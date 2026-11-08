B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=4.5
@EndOfDesignText@
' Created by: Aeric
' Credits to: EnriqueGonzalez, Magma
' Version: 0.90
Sub Class_Globals
	Private mId As String
	Private mName As String
	Private mMode As String
	Private mTagName As String
	Private mIndentString As String
	Private mFlat As Boolean
	Private mLineFeed As Boolean
	Private mFormatAttributes As Boolean
	Private mParent As Tag
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

' Initialize tag with tagName
Public Sub Initialize (tagName As String) As Tag
	'mParent = Null
	mChildren.Initialize
	mSiblings.Initialize
	mAttributes.Initialize
	mStyles.Initialize
	mClasses.Initialize
	mFlat = False
	mLineFeed = True
	mId = ""
	mName = ""
	mTagName = tagName
	Select mTagName.ToLowerCase
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
	Return Me
End Sub

' No indent
' No CRLF
' No align attributes
Public Sub Build As String
	Return BuildImpl(-1, False)
End Sub

' No indent with CRLF
'Public Sub Build2 (Line1CRLF As Boolean) As String
'	Return BuildImpl(-1, Line1CRLF, False)
'End Sub

' Custom indent
' With CRLF on first line
' No align attributes
Public Sub Build2 (indent As Int) As String
	Return BuildImpl(indent, False)
End Sub

' Custom indent
' With CRLF on first line
' With alignment of second attribute onwards according to tag name length
Public Sub BuildImpl (indent As Int, AlignAttribute2 As Boolean) As String
	Dim SB As StringBuilder
	SB.Initialize
	Dim sIndent As String
	Dim sSpacing As String
	Dim SpecialTags As List = Array As String("html", "head", "body")
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
	
	If SpecialTags.IndexOf(mTagName) < 0 Then
		SB.Append(sIndent)
	End If
	
	If mMode <> "" Then
		SB.Append("<" & mTagName)
	End If
	
	Dim MoreThanOne As Boolean
	Dim Separator As String = " "
	
	Dim SB3 As StringBuilder
	SB3.Initialize
	For n = 0 To mTagName.Length + 1
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
		If tagOrString Is Tag Then
			Dim mCurrent As Tag = tagOrString
			SB.Append(mCurrent.BuildImpl(indent + 1, False))
		Else
			SB.Append(tagOrString)
		End If
	Next
	
	Select mMode
		Case mUniline
			If mChildren.Size > 1 Then
				SB.Append(CRLF)
				If SpecialTags.IndexOf(mTagName) < 0 Then
					SB.Append(sIndent)
				End If
			End If
			SB.Append("</" & mTagName & ">")
		Case mMultiline
			SB.Append(CRLF)
			If SpecialTags.IndexOf(mTagName) < 0 Then
				SB.Append(sIndent)
			End If
			SB.Append("</" & mTagName & ">")
	End Select
	Return SB.ToString
End Sub

Public Sub Clone As Tag
	Dim twin As Tag
	twin.Initialize(mTagName)
	'twin.Parent = mParent
	
	Dim childrentwins As CopyOnWriteList
	childrentwins.Initialize(mChildren)
	twin.Children = childrentwins.GetList

	Dim attributestwins As CopyOnWriteMap
	attributestwins.Initialize(mAttributes)
	twin.Attributes = attributestwins.GetMap
		
	'twin.Siblings = mSiblings
	'twin.Attributes = mAttributes
	
	twin.Flat = mFlat
	twin.mId = mId
	twin.mName = mName
	twin.Mode = mMode
	twin.mIndentString = mIndentString
	Return twin
End Sub

' set to true for no indents and CRLF
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub
Public Sub getFlat As Boolean
	Return mFlat
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
	For Each item As Tag In mChildren
		Log(item.build)
	Next
End Sub

' Add comment on same line
Public Sub comment2 (value As String) As Tag
	mChildren.Add($"<!--${value}-->"$)
	Return Me
End Sub

' Add comment on new line
Public Sub comment (value As String) As Tag
	mChildren.Add(Html.create(mNoTag))
	mChildren.Add($"<!--${value}-->"$)
	Return Me
End Sub

Public Sub title (value As String) As Tag
	mChildren.Add(Html.create("title").text(value))
	Return Me
End Sub

Public Sub titleWrap (value As String) As Tag
	Dim title1 As Tag = Html.create("title")
	title1.add(Html.create("").text(value))
	mChildren.Add(title1.multiline)
	Return Me
End Sub

Public Sub addMeta (key As String, value As String)
	mChildren.Add(Html.create("meta").attr(key, value))
End Sub

Public Sub addMeta2 (keyvals As Map)
	mChildren.Add(Html.create("meta").attr2(keyvals))
End Sub

' Deprecated. Use responsive.
'Public Sub meta_preset As Tag
'	addMeta("charset", "UTF-8")
'	addMeta2(CreateMap("name": "viewport", "content": "width=device-width, initial-scale=1"))
'	'addMeta2(CreateMap("http-equiv": "X-UA-Compatible", "content": "IE=edge"))
'	Return Me
'End Sub

'Add metas for UTF8 charset and mobile viewport 
Public Sub responsive As Tag
	addMeta("charset", "UTF-8")
	addMeta2(CreateMap("name": "viewport", "content": "width=device-width, initial-scale=1"))
	Return Me
End Sub

'Add metas for http-equiv='X-UA-Compatible' and content='IE=edge'
Public Sub compatible As Tag
	addMeta2(CreateMap("http-equiv": "X-UA-Compatible", "content": "IE=edge"))
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

' Add inner text
Public Sub text (value As String) As Tag
	mChildren.Add(value)
	Return Me
End Sub

' Remove all children and overwrite inner text
Public Sub text2 (value As String) As Tag
	mChildren.Clear
	mChildren.Add(value)
	Return Me
End Sub

' Add text wrapped in between multiline tags
Public Sub textWrap (value As String) As Tag
	mChildren.Add(Html.create(mNoTag))
	mChildren.Add(value)
	Return Me
End Sub

' Seem unused, set to Private before remove
Private Sub TextInline (value As String) 'ignore
	mChildren.Add(value)
End Sub

' Seem unused, set to Private before remove
Public Sub innerText As String 'ignore
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

Public Sub newline
	textWrap("")
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
Public Sub addLink (rel As String, href As String, integrity As String, crossorigin As String) As Tag
	Return addLink3(rel, href, integrity, crossorigin, "", "", "")
End Sub

'Add link tag (child)
Public Sub addLink2 (keyvals As Map) As Tag
	Dim newtag As Tag = Html.create("link").attr2(keyvals)
	mChildren.Add(newtag)
	Return newtag
End Sub

Public Sub addLink3 (rel As String, href As String, integrity As String, crossorigin As String, titleText As String, typeText As String, asText As String) As Tag
	Dim Map1 As Map
	Map1.Initialize
	If rel <> "" Then Map1.Put("rel", rel)
	If href <> "" Then Map1.Put("href", href)
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

'Set data-key attribute
Public Sub data (key As String, value As Object) As Tag
	mAttributes.Put("data-" & key, value)
	Return Me
End Sub

'Set data-bs-key attribute
Public Sub databs (key As String, value As Object) As Tag
	Return data("bs-" & key, value)
End Sub

'Set x-key attribute
Public Sub x (key As String, value As Object) As Tag
	mAttributes.Put("x-" & key, value)
	Return Me
End Sub

'Set x-init attribute
Public Sub xinit (value As Object) As Tag
	Return x("init", value)
End Sub

'Set x-bind:key attribute
Public Sub xbind (key As String, value As Object) As Tag
	'If key <> "" Then key = ":" & key
	Return x("bind:" & key, value)
End Sub

'Set :key attribute, shorthand for xbind
'e.g :class, :style
Public Sub bind (key As String, value As Object) As Tag
	Return attr(":" & key, value)
End Sub

'Set x-on:event attribute
'e.g x-on:click, x-on:keyup.enter
Public Sub xon (key As String, value As Object) As Tag
	Return x(":" & key, value)
End Sub

'Set @event attribute, shorthand for xon
'e.g @click, @click.outside, @keyup.enter
Public Sub on (key As String, value As Object) As Tag
	Return attr("@" & key, value)
End Sub

'Set x-data attribute
Public Sub xdata (value As Object) As Tag
	Return x("data", value)
End Sub

'Set x-model attribute
Public Sub xmodel (value As Object) As Tag
	Return x("model", value)
End Sub

'Set x-show attribute
Public Sub xshow (value As Object) As Tag
	Return x("show", value)
End Sub

'Set x-text attribute
Public Sub xtext (value As Object) As Tag
	Return x("text", value)
End Sub

'Set aria-key attribute
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

'Set alt attribute
Public Sub altOf (value As String) As Tag
	mAttributes.Put("alt", value)
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

'Set svg viewBox attribute
'Public Sub viewBox (value As String) As Tag
'	mAttributes.Put("viewBox", value)
'	Return Me
'End Sub

'Set svg path d attribute
Public Sub d (value As String) As Tag
	mAttributes.Put("d", value)
	Return Me
End Sub

'Set svg path strokes attributes
'<code>path1.strokes("", "1.5", "round", "round")</code>
Public Sub strokes (stroke As String, stroke_width As String, stroke_linecap As String, stroke_linejoin As String) As Tag
	If stroke <> "" Then mAttributes.Put("stroke", stroke)
	If stroke_width <> "" Then mAttributes.Put("stroke-width", stroke_width)
	If stroke_linecap <> "" Then mAttributes.Put("stroke-linecap", stroke_linecap)
	If stroke_linejoin <> "" Then mAttributes.Put("stroke-linejoin", stroke_linejoin)
	Return Me
End Sub

'Set svg fill attribute
Public Sub fill (value As String) As Tag
	mAttributes.Put("fill", value)
	Return Me
End Sub

'Set svg fill-rule and clip-rule attributes
'<code>path1.rules("evenodd", "evenodd")</code>
Public Sub rules (fill_rule As String, clip_rule As String) As Tag
	If fill_rule <> "" Then mAttributes.Put("fill-rule", fill_rule)
	If clip_rule <> "" Then mAttributes.Put("clip-rule", clip_rule)
	Return Me
End Sub

'Set svg attributes
Public Sub viewBox2 (value1 As String, value2 As String, value3 As String) As Tag
	If value1 <> "" Then mAttributes.Put("viewBox", value1)
	If value2 <> "" Then mAttributes.Put("fill", value2)
	If value3 <> "" Then mAttributes.Put("xmlns", value3)
	Return Me
End Sub

'Set svg viewBox 
'Add attributes for fill="none" and xmlns="http://www.w3.org/2000/svg"
Public Sub viewBox (value As String) As Tag
	Return viewBox2(value, "none", "http://www.w3.org/2000/svg")
End Sub

'Add link tag with only href
Public Sub link (href As String) As Tag
	Return addLink("", href, "", "")
End Sub

'Add link tag with rel and href
Public Sub link2 (rel As String, href As String) As Tag
	Return addLink(rel, href, "", "")
End Sub

'Add link with rel="stylesheet"
Public Sub linkCss (href As String) As Tag
	Return addLink("stylesheet", href, "", "")
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

Public Sub disabled As Tag
	mAttributes.Put("disabled", "")
	Return Me
End Sub

Public Sub checked As Tag
	mAttributes.Put("checked", "")
	Return Me
End Sub

Public Sub selected As Tag
	mAttributes.Put("selected", "")
	Return Me
End Sub

Public Sub hidden As Tag
	mAttributes.Put("hidden", "")
	Return Me
End Sub

Public Sub readonly As Tag
	mAttributes.Put("readonly", "")
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

' Added by Georgios Kantzas (gkantzas/Magma)
Public Sub DeepCloneTag (originalTag As Tag) As Tag
	Dim newTag As Tag
	newTag.Initialize(originalTag.TagName)
	
	' copy attributes
	Dim originalAttributes As Map = originalTag.Attributes
	For Each key As String In originalAttributes.Keys
		Dim value As String = originalAttributes.Get(key)
		newTag.Attributes.Put(key, value)
	Next
	
	' copy styles
	Dim styleString As String = originalTag.StylesAsString
	If styleString.Length > 0 Then
		newTag.addStyle(styleString)
	End If
	
	' copy classes
	Dim classString As String = originalTag.ClassesAsString
	If classString.Length > 0 Then
		newTag.addClass(classString)
	End If
	
	' copy mode, flat, indentString
	newTag.Mode = originalTag.Mode
	newTag.Flat = originalTag.Flat
	
	' Deep clone all children ?
	Dim originalChildren As List = originalTag.Children
	For i = 0 To originalChildren.Size - 1
		Dim Child1 As Object = originalChildren.Get(i)
		If Child1 Is Tag Then
			' if tag: recursive deep clone
			Dim clonedChild As Tag = DeepCloneTag(Child1)
			newTag.add(clonedChild)
		Else
			' if string just add..
			newTag.Children.Add(Child1)
		End If
	Next
	
	Return newTag
End Sub