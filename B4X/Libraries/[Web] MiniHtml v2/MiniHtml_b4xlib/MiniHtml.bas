B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' MiniHtml
' Version: 2.00
Sub Class_Globals
	Private mIndents As Int
	Private mIndentString As String
	Private mMode As String
	Private mName As String
	Private mFlat As Boolean
	Private mLineFeed As Boolean
	Private mIndentation As Boolean
	Private mFormatAttributes As Boolean
	Private mParent As MiniHtml
	Private mChildren As List
	Private mSiblings As List
	Private mClasses As List
	Private mStyles As Map
	Private mAttributes As Map
	Private mBuilder As StringBuilder
	Private Const mNoTag As String = ""
	Private Const mMeta As String = "meta" ' <meta>
	Private Const mSelf As String = "self" ' <tag />
	Private Const mUniline As String = "uniline" ' <tag></tag>
	Private Const mMultiline As String = "multiline" ' <tag> CRLF </tag>	
End Sub

' Initial with tag name
Public Sub Initialize (Name As String)
	mChildren.Initialize
	mSiblings.Initialize
	mAttributes.Initialize
	mStyles.Initialize
	mClasses.Initialize
	mBuilder.Initialize
	mFlat = False
	mLineFeed = True
	mIndentation = False
	mName = Name
	Select mName.ToLowerCase
		Case "head", "form", "table"
			mMode = mMultiline
		Case "meta", "input", "link"
			mMode = mMeta
		Case "title", "h1", "h2", "h3", "h4", "h5", "p", "script", "label", "button", "span", "li", "a", "i", "b", "u", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "small", "textarea"
			mMode = mUniline
		Case "img", "br"', "link"
			mMode = mSelf ' self closing tag
		Case "text", ""
			mMode = mNoTag
		Case Else
			mMode = mMultiline
	End Select
	mIndentString = "  "
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
	Dim SpecialTags As List = Array As String("html", "head", "body", "")

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
	Else
		If mIndentation Then SB.Append(sIndent)
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
			If attrs.StartsWith("'") And attrs.EndsWith("'") Then
				'SB.Append("'")
				SB.Append(attrs)
				'SB.Append("'")
			Else
				SB.Append(QUOTE)
				SB.Append(attrs)
				SB.Append(QUOTE)
			End If
		End If
		
		If MoreThanOne = False Then
			If mFlat = False And mFormatAttributes Then
				Separator = CRLF & sIndent & sSpacing
			End If
			MoreThanOne = True
		End If
	Next
	
	Select mMode
		Case mSelf
			'SB.Append("/>")
			SB.Append(">")
		Case mUniline, mMultiline, mMeta
			SB.Append(">")
	End Select

	For Each tagOrString In mChildren
		If tagOrString Is MiniHtml Then
			Dim mCurrent As MiniHtml = tagOrString
			'If mMode = mUniline Then mCurrent.Mode = mUniline ' (experiment)
			SB.Append(mCurrent.BuildImpl(indent + 1, False))
		Else
			SB.Append(tagOrString)
		End If
	Next
	
	Select mMode
		Case mUniline
			' Commented (experiment)
			'If mChildren.Size > 0 Then
			'SB.Append(CRLF)
			'If SpecialTags.IndexOf(mName) < 0 Then
			'	SB.Append(sIndent)
			'End If
			'End If
			SB.Append("</" & mName & ">")
		Case mMultiline
			If mChildren.Size > 0 Then
				SB.Append(CRLF)
				If SpecialTags.IndexOf(mName) < 0 Then
					SB.Append(sIndent)
				End If
			End If
			SB.Append("</" & mName & ">")
	End Select
	Return SB.ToString
End Sub

'Get tag name
Public Sub getName As String
	Return mName
End Sub

'code: <code>html1.lang("en")</code>
Public Sub lang (value As String) As MiniHtml
	Return attr("lang", value)
End Sub

Private Sub Create (Name As String) As MiniHtml
	Dim NewTag As MiniHtml
	NewTag.Initialize(Name)
	Return NewTag
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

'Return the Children list
Public Sub getChildren As List
	Return mChildren
End Sub
Public Sub setChildren (Children As List)
	mChildren = Children
End Sub

'Return the Parent tag
Public Sub getParent As MiniHtml
	Return mParent
End Sub
Public Sub setParent (ParentTag As MiniHtml)
	mParent = ParentTag
End Sub

' Get child by index
Public Sub Child (tagIndex As Int) As MiniHtml
	Return mChildren.Get(tagIndex)
End Sub

' Get child matches id attribute
Public Sub ChildById (value As String) As MiniHtml
	For i = 0 To mChildren.Size - 1
		If Child(i).mAttributes.Get("id") = value Then
			Return Child(i)
		End If
	Next
	Return Null
End Sub

' Get first child matches Tag Name
Public Sub ChildByName (value As String) As MiniHtml
	For i = 0 To mChildren.Size - 1
		If Child(i).Name = value Then
			Return Child(i)
		End If
	Next
	Return Null
End Sub

'Add a linebreak without indent
Public Sub linebreak
	mChildren.Add(Create(mNoTag))
End Sub

'Add a comment as child (Indent)
Public Sub comment (value As String)
	Dim child1 As MiniHtml = Create(mNoTag)
	child1.Indentation = True
	child1.text($"<!--${value}-->"$)
	mChildren.Add(child1)
End Sub

'Add a comment with no indent
Public Sub comment2 (value As String, newline As Boolean)
	If newline Then linebreak
	text($"<!--${value}-->"$)
End Sub

'<code>body1.cdn("script", "/assets/js/cdn.min.js")</code>
Public Sub cdn (format As String, url As String) As MiniHtml
	Return cdn2(format, url, "", "")
End Sub

'<code>body1.cdn2("script", "/assets/js/cdn.min.js", "", "")</code>
Public Sub cdn2 (format As String, url As String, integrity As String, crossorigin As String) As MiniHtml
	Select format.ToLowerCase
		Case "script", "js"
			Dim map1 As Map = CreateMap("src": url)
			If integrity <> "" Then map1.Put("integrity", integrity)
			If crossorigin <> "" Then map1.Put("crossorigin", crossorigin)
			mChildren.Add(Create("script").attr2(map1))
		Case "style", "css"
			Dim map2 As Map = CreateMap("rel": "stylesheet", "href": url)
			If integrity <> "" Then map2.Put("integrity", integrity)
			If crossorigin <> "" Then map2.Put("crossorigin", crossorigin)
			mChildren.Add(Create("link").attr2(map2))
	End Select
	Return Me
End Sub

'<code>body1.cdn3("script", "/assets/js/cdn.min.js", CreateMap("defer": ""))</code>
Public Sub cdn3 (format As String, url As String, keyvals As Map) As MiniHtml
	Select format.ToLowerCase
		Case "script", "js"
			keyvals.Put("src", url)
			mChildren.Add(Create("script").attr2(keyvals))
		Case "style", "css"
			keyvals.Put("href", url)
			mChildren.Add(Create("link").attr2(keyvals))
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
	Dim child1 As MiniHtml = Create(mNoTag)
	child1.Indentation = True
	child1.text(value)
	mChildren.Add(child1)
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

Public Sub ConvertFromBytes (Buffer() As Byte) As MiniHtml
	Return Parse(BytesToString(Buffer, 0, Buffer.Length, "UTF-8"))
End Sub

Public Sub ConvertToBytes As Byte()
	Return build.GetBytes("UTF8")
End Sub

Public Sub ConvertToMiniHtml (node1 As HtmlNode) As MiniHtml
    Dim parent As MiniHtml
    parent.Initialize(node1.Name)
    
    ' Handle class and style attributes first
	Dim parser As MiniHtmlParser
	parser.Initialize
    Dim class1 As String = parser.GetAttributeValue(node1, "class", "")
    Dim style1 As String = parser.GetAttributeValue(node1, "style", "")
    If class1 <> "" Then parent.addClass(class1)
    If style1 <> "" Then parent.addStyle(style1)

    For Each att As HtmlAttribute In node1.Attributes
        ' Skip class and style as we already handled them
        If att.Key = "class" Or att.Key = "style" Then Continue
        If att.Key = "value" And att.Value.Trim.Length > 0 Then
            If node1.Name = "input" Or node1.Name = "option" Then
                parent.attr(att.Key, att.Value.Trim)
            Else
                If att.Value.Trim.Length > 0 Then
                    parent.Text(att.Value.Trim)
                End If
            End If
        Else
            ' Handle boolean attributes (where key = value)
            If att.Key = att.Value And att.Key <> "name" Then
                parent.attr3(att.Key) ' boolean attribute
            Else
                parent.attr(att.Key, att.Value) ' regular attribute
            End If
        End If
    Next
    
    For Each node As HtmlNode In node1.Children
        Dim tag2 As MiniHtml = ConvertToMiniHtml(node)
        If tag2.Name = "text" Then
            If tag2.Attributes.ContainsKey("value") Then
                ' ignore text nodes with "value" attribute
            Else
                parent.add(tag2)
            End If
        Else
            parent.add(tag2)
        End If
    Next
    Return parent
End Sub

Public Sub Parse (HtmlText As String) As MiniHtml
	Dim parser As MiniHtmlParser
	parser.Initialize
	Dim node1 As HtmlNode = parser.Parse(HtmlText)
	For Each HtmlNode1 As HtmlNode In node1.Children
		If HtmlNode1.Name.EqualsIgnoreCase("text") = False Then Return ConvertToMiniHtml(HtmlNode1)
	Next
	Return Create(mNoTag)
End Sub

' Wrap script inside script tags
'output: <code><script>value</script></code>
Public Sub script (value As String) As MiniHtml
	mChildren.Add(Create("script").multiline.text(value))
	Return Me
End Sub

'Set mode
Public Sub setMode (TagMode As String)
	mMode = TagMode.ToLowerCase
End Sub
Public Sub getMode As String
	Return mMode
End Sub

'Set flat
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub
Public Sub getFlat As Boolean
	Return mFlat
End Sub

' Set amount of Indent
Public Sub setIndents (Value As Int)
	mIndents = Value
	'If mFlat Then Return
	For n = 0 To mIndents - 1
		mBuilder.Append(mIndentString)
	Next
End Sub
Public Sub getIndents As Int
	Return mIndents
End Sub

'Set Indent
Public Sub setIndentation (Value As Boolean)
	mIndentation = Value
End Sub
Public Sub getIndentation As Boolean
	Return mIndentation
End Sub

'Set LineFeed
Public Sub setLineFeed (Value As Boolean)
	mLineFeed = Value
End Sub
Public Sub getLineFeed As Boolean
	Return mLineFeed
End Sub

'Replace/return maps of attributes
Public Sub getAttributes As Map
	Return mAttributes
End Sub
'Replace/return maps of attributes
Public Sub setAttributes (keyvals As Map)
	mAttributes = keyvals
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

' Set Indent String
' Default = "  " (2 whitespaes)
Public Sub setIndentString (Value As String)
	mIndentString = Value
End Sub

' Add text value to Builder
Public Sub Write (Value As String)
	mBuilder.Append(Value)
End Sub

Public Sub ToString As String
	Return mBuilder.ToString
End Sub