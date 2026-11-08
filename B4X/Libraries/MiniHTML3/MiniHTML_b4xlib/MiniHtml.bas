B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'MiniHtml
'Version: 3.31
Sub Class_Globals
	Private mIndents As Int
	Private mDocType As String
	Private mIndentString As String
	Private mId As String
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
	Private Const mMultiline As String = "multiline" ' <tag> CRLF </tag> (if mFlat = False)
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
	mLineFeed = Not(mFlat)
	mIndentation = Not(mFlat)
	mDocType = "html"
	mName = Name
	Select mName.ToLowerCase
		Case "head", "form", "table"
			mMode = mMultiline
		Case "meta", "input", "link"
			mMode = mMeta
		Case "title", "h1", "h2", "h3", "h4", "h5", "p", "script", "label", "button", "div", "span", "li", "a", "i", "b", "u", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "small", "textarea"
			mMode = mUniline
		Case "img", "br", "path"
			mMode = mMeta
		Case "text", ""
			mMode = mNoTag
		Case Else
			mMode = mMultiline
	End Select
	If mName.EndsWith("/") Then 'self closing tag
		mName = mName.Replace("/", "")
		mMode = mSelf
	End If
	mIndents = 0
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
	
	If mName.EqualsIgnoreCase("html") And mDocType <> "" Then
		SB.Append($"<!DOCTYPE ${mDocType}>"$)
	End If
	
	If mParent.IsInitialized And mParent.Indentation = False Then indent = 1
	If mLineFeed Then SB.Append(CRLF)
	
	' Build Left Indent
	Dim SB2 As StringBuilder
	SB2.Initialize
	For n = 0 To indent
		SB2.Append(mIndentString)
	Next
	sIndent = SB2.ToString
	
	If mIndentation Then SB.Append(sIndent) '(experiment)
	
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
		Dim attribute As String = mAttributes.Get(key)
		
		SB.Append(Separator)
		SB.Append(key)
		If attribute.Length > 0 Then
			SB.Append("=")
			If attribute.StartsWith("'") And attribute.EndsWith("'") Then
				'SB.Append("'")
				SB.Append(attribute)
				'SB.Append("'")
			Else
				SB.Append(QUOTE)
				SB.Append(attribute)
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
			SB.Append("/>")
		Case mUniline, mMultiline, mMeta
			SB.Append(">")
	End Select

	For Each tagOrString In mChildren
		If tagOrString Is MiniHtml Then
			Dim mCurrent As MiniHtml = tagOrString
			SB.Append(mCurrent.buildImpl(indent + 1, False))
		Else
			SB.Append(tagOrString)
		End If
	Next

	Select mMode
		Case mUniline
			If mChildren.Size > 0 Then
				If mFlat = False And mMode = mMultiline Then
					SB.Append(CRLF) '(experiment)
					SB.Append(sIndent) '(experiment)
				End If
			End If
			SB.Append("</" & mName & ">")
		Case mMultiline
			If mLineFeed Then SB.Append(CRLF) '(experiment)
			If mIndentation Then SB.Append(sIndent) '(experiment)
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
Public Sub attrs (keyvals As Map) As MiniHtml
	For Each key As String In keyvals.Keys
		Dim value As String = keyvals.Get(key)
		mAttributes.Put(key, value)
	Next
	Return Me
End Sub

'(deprecated)
'Insert more attributes from map
Public Sub attr2 (keyvals As Map) As MiniHtml
	Return attrs(keyvals)
End Sub

'(deprecated)
'Add a no-value attribute
Public Sub attr3 (key As String) As MiniHtml
	'mAttributes.Put(key, "")
	'Return Me
	Return bool(key)
End Sub

'Add a boolean attribute (no value)
Public Sub bool (key As String) As MiniHtml
	mAttributes.Put(key, "")
	Return Me
End Sub

'Set an attribute with a key and value if value is non zero length string
Public Sub attrIf (condition As Boolean, key As String, value As String) As MiniHtml
	If condition Then Return attr(key, value)
	Return Me
End Sub

'Set an attribute with a key and value if value is non zero length string
Public Sub attrIfValue (key As String, value As String) As MiniHtml
	'Return IIf(value.Length > 0, attr(key, value), Me)
	Return attrIf(value.Length > 0, key, value)
End Sub

'Insert more attributes from map if each keyconditions by key is true
Public Sub attrsIfConditions (keyconditions As Map, keyvals As Map) As MiniHtml
	For Each key As String In keyvals.Keys
		attrIf(keyconditions.Get(key), key, keyvals.Get(key))
	Next
	Return Me
End Sub

'Insert more attributes from map if each value is non zero length string
Public Sub attrsIfValues (keyvals As Map) As MiniHtml
	For Each key As String In keyvals.Keys
		attrIfValue(key, keyvals.Get(key))
	Next
	Return Me
End Sub

'(deprecated)
'Add a no-value attribute if condition is true
Public Sub attr3If (condition As Boolean, key As String) As MiniHtml
	Return boolIf(condition, key)
End Sub

'Add a no-value attribute if condition is true
Public Sub boolIf (condition As Boolean, key As String) As MiniHtml
	If condition Then Return bool(key)
	Return Me
End Sub

'Set text attribute if condition is true
Public Sub textIf (condition As Boolean, value As String) As MiniHtml
	If condition Then Return text(value)
	Return Me
End Sub

'Set text attribute if value is non zero length string
Public Sub textIfValue (value As String) As MiniHtml
	Return textIf(value <> "", value)
End Sub

'Add to Parent and return the current (child) tag (alias of addTo)
Public Sub up (ParentTag As MiniHtml) As MiniHtml
	Return addTo(ParentTag)
End Sub

'Add to Parent and return the current (child) tag
Public Sub addTo (ParentTag As MiniHtml) As MiniHtml
	ParentTag.add(Me)
	mParent = ParentTag
	Return Me
End Sub

'Append a Child but return the (parent) tag - breaking! previously return child
Public Sub add (ChildTag As MiniHtml) As MiniHtml
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
	Return Me
End Sub

'Append a Child and return the (child) tag
Public Sub add2 (ChildTag As MiniHtml) As MiniHtml
	mChildren.Add(ChildTag)
	ChildTag.Parent = Me
	Return ChildTag
End Sub

'Append a Child and return the (child) tag (alias of add2)
Public Sub down (ChildTag As MiniHtml) As MiniHtml
	Return add2(ChildTag)
End Sub

'Append a Child and return the (Parent) tag if condition is true
'Public Sub add2If (condition As Boolean, ChildTag As MiniHtml) As MiniHtml
'	If condition = False Then Return Me
'	mChildren.Add(ChildTag)
'	ChildTag.Parent = Me
'	Return Me 'ChildTag
'End Sub

'Append a Child and return the (Parent) tag if condition is true (alias of add2If)
'Public Sub downIf (condition As Boolean, ChildTag As MiniHtml) As MiniHtml
'	Return add2If(condition, ChildTag)
'End Sub

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

'Return the Parent tag if condition is true
'Public Sub ParentIf (condition As Boolean) As MiniHtml
'	If condition Then Return mParent
'	 Return Me
'End Sub

'(deprecated)
' alias of ChildByIndex
Public Sub child (tagIndex As Int) As MiniHtml
	Return ChildByIndex(tagIndex)
End Sub

' Get child by index
Public Sub ChildByIndex (tagIndex As Int) As MiniHtml
	If mChildren.Get(tagIndex) Is MiniHtml Then
		Return mChildren.Get(tagIndex)
	End If
	Return Null
End Sub

' Get child matches id attribute using deep search
Public Sub ChildById (value As String) As MiniHtml
	For Each ChildObject In mChildren
		If ChildObject Is String Then Continue
		If ChildObject Is MiniHtml Then
			Dim TheChild As MiniHtml = ChildObject
			If TheChild.mAttributes.ContainsKey("id") Then
				'Log($"searching ${value} in ${TheChild.Name} ${TheChild.mAttributes.Get("class")} tag"$)
				If TheChild.Id = value Then Return ChildObject
			End If
		End If
	Next
	Return DeepSearchById(value)
End Sub

Private Sub DeepSearchById (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each ChildObject As Object In mChildren
			If ChildObject Is String Then Continue
			If ChildObject Is MiniHtml Then
				Dim TheChild As MiniHtml = ChildObject
				Dim result As MiniHtml = TheChild.ChildById(value)
				If Initialized(result) Then Return result
			End If
		Next
	End If
	Return Null
End Sub

' Get child matches tag name using deep search
Public Sub ChildByName (value As String) As MiniHtml
	For Each ChildObject In mChildren
		If ChildObject Is String Then Continue
		If ChildObject Is MiniHtml Then
			Dim TheChild As MiniHtml = ChildObject
			'Log($"searching ${value} in ${TheChild.Name} ${TheChild.mAttributes.Get("class")} tag"$)
			If TheChild.Name = value Then Return ChildObject
		End If
	Next
	Return DeepSearchByName(value)
End Sub

Private Sub DeepSearchByName (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each ChildObject In mChildren
			If ChildObject Is String Then Continue
			If ChildObject Is MiniHtml Then
				Dim TheChild As MiniHtml = ChildObject
				Dim result As MiniHtml = TheChild.ChildByName(value)
				If Initialized(result) Then Return result
			End If
		Next
	End If
	Return Null
End Sub

' Get child containing specified class using deep search
Public Sub ChildByClass (value As String) As MiniHtml
	For Each ChildObject In mChildren
		If ChildObject Is String Then Continue
		If ChildObject Is MiniHtml Then
			Dim TheChild As MiniHtml = ChildObject
			If TheChild.mClasses.IndexOf(value) > -1 Then
				'Log($"${value} hit ${TheChild.mClasses}"$)
				Return ChildObject
			End If
		End If
	Next
	Return DeepSearchByClass(value)
End Sub

Private Sub DeepSearchByClass (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each ChildObject In mChildren
			If ChildObject Is String Then Continue
			If ChildObject Is MiniHtml Then
				Dim TheChild As MiniHtml = ChildObject
				Dim result As MiniHtml = TheChild.ChildByClass(value)
				If Initialized(result) Then
					Return result
				End If
			End If
		Next
	End If
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
	child1.text($"<!--${value.Replace("--", "")}-->"$)
	mChildren.Add(child1)
End Sub

'Add a comment with no indent
Public Sub comment2 (value As String, newline As Boolean)
	If newline Then linebreak
	text($"<!--${value.Replace("--", "")}-->"$)
End Sub

'(deprecated)
'<code>head1.cdn("css", "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css")</code>
Public Sub cdn (format As String, url As String) As MiniHtml
	Select format.ToLowerCase
		Case "script", "js"
			Return add2(Create("script")).attr("src", url)
		Case "style", "css"
			Return add2(Create("link")).attr("rel", "stylesheet").attr("href", url)
	End Select
	Return Me
End Sub

'(deprecated)
'<code>body1.cdn2("script", "https://cdn.jsdelivr.net/npm/htmx.org@2.0.8/dist/htmx.min.js", "sha384-hashes", "anonymous")</code>
Public Sub cdn2 (format As String, url As String, hash As String, credentials As String) As MiniHtml
	Return cdn(format, url).attrIfValue("integrity", hash).attrIfValue("crossorigin", credentials)
End Sub

'(deprecated)
'<code>body1.cdn3("script", "https://cdn.jsdelivr.net/npm/htmx.org@2.0.8/dist/htmx.min.js", CreateMap("integrity": "sha384-hashes", "crossorigin": "anonymous"))</code>
Public Sub cdn3 (format As String, url As String, keyvals As Map) As MiniHtml
	Return cdn(format, url).attrs(keyvals)
End Sub

'<code>MH.Script.up(body1).attr("src", "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js") _
'.integrity("sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y").crossorigin("anonymous")</code>
'<code>MH.Script.up(body1).attr("src", "https://cdn.jsdelivr.net/npm/htmx.org@2.0.8/dist/htmx.min.js") _
'.integrity("sha384-/TgkGk7p307TH7EXJDuUlgG3Ce1UVolAOFopFekQkkXihi5u/6OCvVKyz1W+idaz").crossorigin("anonymous")</code>
Public Sub integrity (hash As String) As MiniHtml
	mAttributes.Put("integrity", hash)
	Return Me
End Sub

'<code>.crossorigin("anonymous")</code>
Public Sub crossorigin (credentials As String) As MiniHtml
	mAttributes.Put("crossorigin", credentials)
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
			Dim kv As String = pair.Trim
			If kv = "" Then Continue
			Dim keyvals() As String = Regex.Split(":", kv)
			If keyvals.Length < 2 Then Continue
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

'Add a class if condition is true
Public Sub addClassIf (condition As Boolean, value As String) As MiniHtml
	If condition Then Return addClass(value)
	Return Me
End Sub

'Add a class if condition is true
Public Sub clsIf (condition As Boolean, value As String) As MiniHtml
	Return addClassIf(condition, value)
End Sub

'Add class based on condition is true or false
Public Sub addClassIIf (condition As Boolean, valueIfTrue As String, valueIfFalse As String) As MiniHtml
	If condition Then Return addClass(valueIfTrue)
	Return addClass(valueIfFalse)
End Sub

'Add class based on condition is true or false
Public Sub clsIIf (condition As Boolean, valueIfTrue As String, valueIfFalse As String) As MiniHtml
	Return addClassIIf(condition, valueIfTrue, valueIfFalse)
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
			att.Value = att.Value.Trim
			If node1.Name = "input" Or node1.Name = "option" Then
				parent.attr(att.Key, att.Value)
			Else
				parent.Text(att.Value)
			End If
		Else If att.Key = "action" Then
			parent.attr(att.Key, att.Value) '(experiment) allow empty value
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
		If tag2.Name = "" Then ' If tag2.Name = "text" Then '(experiment)
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
		If HtmlNode1.Name <> "" Then Return ConvertToMiniHtml(HtmlNode1)
	Next
	Return Create(mNoTag)
End Sub

' Parse a JSON string into a MiniHtml tree.
' Shorthand format: {"tagname": {"class": "...", "text": "...", "children": [...]}}
' Or: {"tagname": "inner text"}
' Or an array: [{"div": ...}, {"span": ...}]
Public Sub FromJson (JsonStr As String) As MiniHtml
	Dim obj As Object = IIf(JsonStr.StartsWith("["), JsonStr.As(JSON).ToList, JsonStr.As(JSON).ToMap)
	'Log(GetType(obj))
	Return AnyToMiniHtml(obj)
End Sub

' Parse a pre-parsed Map into a MiniHtml tree (shorthand format: {"tagname": {properties}})
Public Sub FromMap (m As Map) As MiniHtml
	Return ShorthandToMiniHtml(m)
End Sub

' Convert a JSON value (Map or List) to MiniHtml
Private Sub AnyToMiniHtml (obj As Object) As MiniHtml
	If obj Is Map Then
		Return ShorthandToMiniHtml(obj)
	Else If obj Is List Then
		Dim list As List = obj
		Dim root As MiniHtml
		root.Initialize("")
		For Each item As Object In list
			If item Is Map Then
				ShorthandToMiniHtml(item).up(root)
			End If
		Next
		Return root
	End If
	Dim empty As MiniHtml
	empty.Initialize("")
	Return empty
End Sub

' Convert a shorthand map {"tagname": {properties}} or {"tagname": "text"}
Private Sub ShorthandToMiniHtml (m As Map) As MiniHtml
	Dim tagName As String = ""
	Dim props As Object = Null
	For Each key As String In m.Keys
		tagName = key
		props = m.Get(key)
		Exit
	Next
	Dim el As MiniHtml
	el.Initialize(tagName)
	If props Is Map Then
		Dim propMap As Map = props
		For Each key As String In propMap.Keys
			Dim value As Object = propMap.Get(key)
			Select key.ToLowerCase
				Case "class"
					el.cls(value)
				Case "style"
					el.sty(value)
				Case "text"
					el.text(value)
				Case "attrs"
					Dim attributes As Map = value
					el.attrs(attributes)
				Case "children"
					Dim cl As List = value
					For Each chd As Object In cl
						If chd Is Map Then
							ShorthandToMiniHtml(chd).up(el)
						Else If chd Is String Then
							el.text(chd)
						End If
					Next
				Case "mode"
					el.setMode(value)
				Case "flat"
					el.setFlat(value)
				Case "indentation"
					el.setIndentation(value)
				Case "formatattributes"
					el.setFormatAttributes(value)
				Case "id"
					el.setId(value)
				Case "defer"
					If value = True Then el.defer
				Case "required"
					If value = True Then el.required
				Case "disabled"
					If value = True Then el.disabled
				Case "checked"
					If value = True Then el.checked
				Case "selected"
					If value = True Then el.selected
				Case "hidden"
					If value = True Then el.hidden
				Case "readonly"
					If value = True Then el.readonly
				Case Else
					el.attr(key, value)
			End Select
		Next
	Else If props Is String Then
		el.text(props)
	End If
	Return el
End Sub

' Convert this MiniHtml tree to a Map in shorthand format {"tagname": {properties}}
Public Sub ToMap As Map
	Dim props As Map
	props.Initialize
	
	If mClasses.Size > 0 Then props.Put("class", ClassesAsString)
	If mStyles.Size > 0 Then props.Put("style", StylesAsString)
	
	If mFlat Then props.Put("flat", True)
	If mIndentation Then props.Put("indentation", True)
	If mFormatAttributes Then props.Put("formatattributes", True)
	
	Dim boolAttrs As List = Array As String("defer", "required", "disabled", "checked", "selected", "hidden", "readonly")
	Dim rest As Map
	rest.Initialize
	For Each key As String In mAttributes.Keys
		If key = "class" Or key = "style" Then Continue
		If key = "id" Then
			props.Put("id", mAttributes.Get(key))
			Continue
		End If
		If boolAttrs.IndexOf(key) >= 0 Then
			props.Put(key, True)
			Continue
		End If
		rest.Put(key, mAttributes.Get(key))
	Next
	If rest.Size > 0 Then props.Put("attrs", rest)
	
	Dim cl As List
	cl.Initialize
	Dim textCount As Int = 0
	Dim tagCount As Int = 0
	
	For Each chd As Object In mChildren
		If chd Is MiniHtml Then
			tagCount = tagCount + 1
		Else If chd Is String Then
			textCount = textCount + 1
		End If
	Next
	
	If textCount = 1 And tagCount = 0 Then
		For Each chd As Object In mChildren
			If chd Is String Then
				props.Put("text", chd)
				Exit
			End If
		Next
	Else If textCount > 0 Or tagCount > 0 Then
		For Each chd As Object In mChildren
			If chd Is MiniHtml Then
				Dim childMap As MiniHtml = chd
				cl.Add(childMap.ToMap)
			Else If chd Is String Then
				cl.Add(chd)
			End If
		Next
		props.Put("children", cl)
	End If
	
	Dim result As Map
	result.Initialize
	result.Put(mName, props)
	Return result
End Sub

' Convert this MiniHtml tree to a JSON string
Public Sub ToJson As String
	Dim map1 As Map = ToMap
	Dim jg As JSONGenerator
	jg.Initialize(map1)
	Return jg.ToString
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
	mLineFeed = Not(mFlat) '(experiment)
	mIndentation = Not(mFlat) '(experiment)
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

' Disable indentation for head or body
' ignored by Parse function
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

'Set or return id attribute
Public Sub getId As String
	mId = mAttributes.Get("id")
	Return mId
End Sub
Public Sub setId (Value As String)
	mId = Value
	mAttributes.Put("id", mId)
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
	'mFlat = False
	Return Me
End Sub

' Adds a key-value pair to the very beginning of an existing Map
Private Sub PrependToMap (OriginalMap As Map, NewKey As Object, NewValue As Object) As Map
	Dim TempMap As Map
	TempMap.Initialize
    
	' 1. Insert the new key and value first
	TempMap.Put(NewKey, NewValue)
    
	' 2. Append all the original keys and values
	For Each Key As Object In OriginalMap.Keys
		TempMap.Put(Key, OriginalMap.Get(Key))
	Next
    
	' 3. Clear the original map and copy the reordered data back
	OriginalMap.Clear
	For Each Key As Object In TempMap.Keys
		OriginalMap.Put(Key, TempMap.Get(Key))
	Next
    
	Return OriginalMap
End Sub

'Prepend defer to script tag
'<code>body1.cdn("script", "/assets/js/cdn.min.js").defer</code>
Public Sub defer As MiniHtml
	PrependToMap(mAttributes, "defer", "")
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

Public Sub selectedIf (condition As Boolean) As MiniHtml
	If condition Then mAttributes.Put("selected", "")
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

' Set doctype
' Default = html
Public Sub setDocType (Value As String)
	mDocType = Value
End Sub
Public Sub getDocType As String
	Return mDocType
End Sub

' Set Indent String
' Default = "  " (2 whitespaes)
Public Sub setIndentString (Value As String)
	mIndentString = Value
End Sub
Public Sub getIndentString As String
	Return mIndentString
End Sub

'(deprecated)
' Add text value to Builder
Public Sub Append (Value As String)
	mBuilder.Append(Value)
End Sub

'(deprecated) Use Append
'Public Sub Write (Value As String)
'	mBuilder.Append(Value)
'End Sub

'(deprecated)
' Return String added by Append
Public Sub ToString As String
	Return mBuilder.ToString
End Sub