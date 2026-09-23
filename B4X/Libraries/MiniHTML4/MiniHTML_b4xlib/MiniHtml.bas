B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
'MiniHtml
'Version: 4.00
Sub Class_Globals
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
	Private mName As String
	Private mMode As String
	Private mDocType As String
	Private mIndentString As String
	Private mIndents As Int
	Public Const ModeSelf As String = "self" ' <tag />
	Public Const ModeMeta As String = "meta" ' <meta>
	Public Const ModeNoTag As String = ""
	Public Const ModeUniline As String = "uniline" ' <tag></tag>
	Public Const ModeMultiline As String = "multiline" ' <tag> CRLF </tag> (if mFlat = False)
End Sub

Public Sub Initialize (Name As String = ModeNoTag, Mode As String = "default", Flat As Boolean = False, Indents As Int = 0, IndentString As String = "  ")
	mStyles.Initialize
	mClasses.Initialize
	mChildren.Initialize
	mSiblings.Initialize
	mAttributes.Initialize
	mName = Name
	Select mName.ToLowerCase
		'Case "title", "h1", "h2", "h3", "h4", "h5", "h6", "p", "script", "label", "button", "div", "span", "li", "a", "i", "b", "u", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "pre", "small", "textarea"
		'	mMode = ModeUniline
		Case "meta", "link", "img", "br", "input", "path"
			mMode = ModeMeta
		Case "html", "head", "body", "form", "table", "svg"
			mMode = ModeMultiline
		Case "text", ""
			mMode = ModeNoTag
		Case Else
			mMode = ModeUniline
	End Select
	If mName.EndsWith("/") Then 'self closing tag
		mName = mName.Replace("/", "")
		mMode = ModeSelf
	End If
	If Not(Mode.EqualsIgnoreCase("default")) Then
		mMode = Mode
	End If
	Select mName.ToLowerCase
		Case "br", "span", "b", "i", "u", "bold", "italic", "underline", "em", "strong", "del"
			mLineFeed = False
			mIndentation = False
		Case Else
			mLineFeed = True
			mIndentation = True
	End Select
	mFlat = Flat
	mIndents = Indents
	mIndentString = IndentString
	mDocType = "html"
End Sub

' With alignment of second attribute onwards according to tag name length
Sub build (indent As Int = -1) As String
	Dim sIndent As String
	Dim sSpacing As String
	
	Dim sb As StringBuilder
	sb.Initialize
	
	If mName.EqualsIgnoreCase("html") And mDocType <> "" Then
		sb.Append($"<!DOCTYPE ${mDocType}>"$)
	End If
	
	If mParent.IsInitialized And mParent.Indentation = False Then indent = 1
	If mLineFeed Then sb.Append(CRLF)
	
	' Build Left Indent
	Dim sb2 As StringBuilder
	sb2.Initialize
	For n = 0 To indent
		sb2.Append(mIndentString)
	Next
	sIndent = sb2.ToString
	
	If mIndentation Then sb.Append(sIndent) '(experiment)
	
	'handle empty name such as raw text or comment
	If mMode <> "" And mName <> ModeNoTag Then
		sb.Append("<" & mName)
	End If
	
	Dim MoreThanOne As Boolean
	Dim Separator As String = " "
	
	Dim sb3 As StringBuilder
	sb3.Initialize
	For n = 0 To mName.Length + 1
		sb3.Append(Separator)
	Next
	sSpacing = sb3.ToString
	
	For Each key As String In mAttributes.Keys
		'Log(key & "->" & mAttributes.Get(key))
		Dim attribute As String = mAttributes.Get(key)
		
		sb.Append(Separator)
		sb.Append(key)
		If attribute.Length > 0 Then
			sb.Append("=")
			If attribute.StartsWith("'") And attribute.EndsWith("'") Then
				sb.Append(attribute)
			Else
				sb.Append(QUOTE)
				sb.Append(attribute)
				sb.Append(QUOTE)
			End If
		End If
		
		If MoreThanOne = False Then
			If mFlat = False And mFormatAttributes Then
				Separator = CRLF & sIndent & sSpacing
			End If
			MoreThanOne = True
		End If
	Next
	
	'handle empty name such as raw text or comment
	If mName <> ModeNoTag Then
		Select mMode
			Case ModeSelf
				sb.Append("/>")
			Case ModeUniline, ModeMultiline, ModeMeta
				sb.Append(">")
		End Select
	End If

	For Each tagOrString In mChildren
		If tagOrString Is MiniHtml Then
			Dim mCurrent As MiniHtml = tagOrString
			sb.Append(mCurrent.build(indent + 1))
		Else
			sb.Append(tagOrString)
		End If
	Next

	'handle empty name such as raw text or comment
	If mName <> ModeNoTag Then
		Select mMode
			Case ModeUniline
				If mChildren.Size > 0 Then
					If mFlat = False And mMode = ModeMultiline Then
						sb.Append(CRLF)
						sb.Append(sIndent)
					End If
				End If
				sb.Append("</" & mName & ">")
			Case ModeMultiline
				If mLineFeed Then sb.Append(CRLF)
				If mIndentation Then sb.Append(sIndent)
				sb.Append("</" & mName & ">")
		End Select
	End If
	Return sb.ToString
End Sub

Private Sub create (tag As String) As MiniHtml
	Dim h As MiniHtml
	h.Initialize(tag)
	Return h
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
Public Sub attrs (keyvals As Map) As MiniHtml
	For Each key As String In keyvals.Keys
		Dim value As String = keyvals.Get(key)
		mAttributes.Put(key, value)
	Next
	Return Me
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

'Add a no-value attribute if condition is true
Public Sub boolIf (condition As Boolean, key As String) As MiniHtml
	If condition Then Return bool(key)
	Return Me
End Sub

'Set mode to multiline if condition is true
Public Sub multilineIf (condition As Boolean) As MiniHtml
	If condition Then mMode = ModeMultiline
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

'Add a new tag into Children list
'Return parent tag
Public Sub add (childTag As MiniHtml) As MiniHtml
	mChildren.Add(childTag)
	childTag.Parent = Me
	Return Me
End Sub

'Add a new tag into Children list
'Return child tag
Public Sub addChild (childTag As MiniHtml) As MiniHtml
	mChildren.Add(childTag)
	childTag.Parent = Me
	Return childTag
End Sub

'Add current tag into a Parent's Children list
'Return current tag
Public Sub addTo (parentTag As MiniHtml) As MiniHtml
	'Return parentTag.add(Me)
	parentTag.add(Me)
	mParent = parentTag
	Return Me
End Sub

'Add to Parent and return the current (child) tag (alias of addTo)
Public Sub up (parentTag As MiniHtml) As MiniHtml
	Return addTo(parentTag)
End Sub

'Append a Child and return the (child) tag (alias of addChild)
Public Sub down (childTag As MiniHtml) As MiniHtml
	Return addChild(childTag)
End Sub

' alias of ChildByIndex
Public Sub child (value As Int) As MiniHtml
	Return childByIndex(value)
End Sub

' Get child by index
Public Sub childByIndex (value As Int) As MiniHtml
	If value < 0 Or value >= mChildren.Size Then Return Null
	Dim o As Object = mChildren.Get(value)
	Return IIf(o Is MiniHtml, o, Null)
End Sub

' Get child matches id attribute using deep search
Public Sub childById (value As String) As MiniHtml
	For Each childObject In mChildren
		If childObject Is String Then Continue
		If childObject Is MiniHtml Then
			Dim theChild As MiniHtml = childObject
			If theChild.Attributes.ContainsKey("id") Then
				If theChild.Attributes.Get("id") = value Then Return childObject
			End If
		End If
	Next
	Return deepSearchById(value)
End Sub

Private Sub deepSearchById (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each childObject As Object In mChildren
			If childObject Is String Then Continue
			If childObject Is MiniHtml Then
				Dim theChild As MiniHtml = childObject
				Dim result As MiniHtml = theChild.ChildById(value)
				If Initialized(result) Then Return result
			End If
		Next
	End If
	Return Null
End Sub

' Get child matches tag name using deep search
Public Sub childByName (value As String) As MiniHtml
	For Each childObject In mChildren
		If childObject Is String Then Continue
		If childObject Is MiniHtml Then
			Dim theChild As MiniHtml = childObject
			If theChild.Name = value Then Return childObject
		End If
	Next
	Return deepSearchByName(value)
End Sub

Private Sub deepSearchByName (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each childObject In mChildren
			If childObject Is String Then Continue
			If childObject Is MiniHtml Then
				Dim theChild As MiniHtml = childObject
				Dim result As MiniHtml = theChild.ChildByName(value)
				If Initialized(result) Then Return result
			End If
		Next
	End If
	Return Null
End Sub

' Get child containing specified class using deep search
Public Sub childByClass (value As String) As MiniHtml
	For Each childObject In mChildren
		If childObject Is String Then Continue
		If childObject Is MiniHtml Then
			Dim theChild As MiniHtml = childObject
			If theChild.mClasses.IndexOf(value) > -1 Then
				Return childObject
			End If
		End If
	Next
	Return deepSearchByClass(value)
End Sub

Private Sub deepSearchByClass (value As String) As MiniHtml
	If Initialized(mChildren) Then
		For Each childObject In mChildren
			If childObject Is String Then Continue
			If childObject Is MiniHtml Then
				Dim theChild As MiniHtml = childObject
				Dim result As MiniHtml = theChild.ChildByClass(value)
				If Initialized(result) Then
					Return result
				End If
			End If
		Next
	End If
	Return Null
End Sub

'Add a linebreak without indent
Public Sub linebreak As MiniHtml
	text("", True)
	Return Me
End Sub

'Add a comment above or below current tag (must have parent)
Public Sub comment (value As String, position As String = "above") As MiniHtml
	Dim ct As MiniHtml = Me
	Dim ctp As Object = ct.Parent
	If Initialized(ctp) Then
		Dim pt As MiniHtml = ctp
		Dim pos As Int = pt.Children.IndexOf(ct)
		If pos > -1 Then
			Dim nt As MiniHtml = create(ModeNoTag).text($"<!--${value.Replace("--", "")}-->"$)
			If position.EqualsIgnoreCase("below") Then
				pt.Children.InsertAt(pos + 1, nt)
			Else
				pt.Children.InsertAt(pos, nt)
			End If
		End If
	End If
	Return Me
End Sub

'(deprecated) - use MH.Link or MH.Script
'<code>head1.cdn("css", "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css")</code>
Public Sub cdn (format As String, url As String) As MiniHtml
	Select format.ToLowerCase
		Case "script", "js"
			Return addChild(create("script")).attr("src", url)
		Case "style", "css"
			Return addChild(create("link")).attr("rel", "stylesheet").attr("href", url)
	End Select
	Return Me
End Sub

Public Sub rel (value As String = "stylesheet") As MiniHtml
	mAttributes.Put("rel", value)
	Return Me
End Sub

'BS5 <code>.href("https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css")</code>
'Icons <code>.href("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css")</code>
Public Sub href (value As String) As MiniHtml
	mAttributes.Put("href", value)
	Return Me
End Sub

'BS5 <code>.src("https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js")</code>
'HTMX <code>.src("https://cdn.jsdelivr.net/npm/htmx.org@2.0.8/dist/htmx.min.js")</code>
'App.js <code>.src("$SERVER_URL$/assets/js/app.js")</code>
Public Sub src (value As String) As MiniHtml
	mAttributes.Put("src", value)
	Return Me
End Sub

'BS5 <code>.integrity("sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y")</code>
'HTMX <code>.integrity("sha384-/TgkGk7p307TH7EXJDuUlgG3Ce1UVolAOFopFekQkkXihi5u/6OCvVKyz1W+idaz")</code>
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
Public Sub text (value As String, wrap As Boolean = True) As MiniHtml
	mIndentation = wrap
	mChildren.Add(value)
	Return Me
End Sub

' Replace children with a text or object
Public Sub replace (value As Object) As MiniHtml
	mChildren.Clear
	mChildren.Add(value)
	Return Me
End Sub

'Add one or more classes separated by space
Public Sub cls (value As String) As MiniHtml
	Return addClass(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As MiniHtml
	Return addStyle(value)
End Sub

'Add one or more classes separated by space
Public Sub addClass (value As String) As MiniHtml
	Try
		Dim names() As String = Regex.Split(" ", value)
		For Each subname As String In names
			If mClasses.IndexOf(subname) < 0 Then mClasses.Add(subname)
		Next
		updateClassAttribute
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'Remove one or more classes separated by space
Public Sub removeClass (value As String) As MiniHtml
	Try
		Dim names() As String = Regex.Split(" ", value)
		For Each subname As String In names
			If mClasses.IndexOf(subname) > -1 Then mClasses.RemoveAt(mClasses.IndexOf(subname))
		Next
		updateClassAttribute
	Catch
		Log(LastException)
	End Try
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

'Remove one or more styles separated by semicolon
Public Sub removeStyle (value As String) As MiniHtml
	Try
		Dim keys() As String = Regex.Split(";", value)
		For Each key As String In keys
			If mStyles.ContainsKey(key) Then mStyles.Remove(key)
		Next
		updateStyleAttribute
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'Add a class if condition is true
Public Sub clsIf (condition As Boolean, value As String) As MiniHtml
	Return addClassIf(condition, value)
End Sub

'Add class based on condition is true or false
Public Sub clsIIf (condition As Boolean, valueIfTrue As String, valueIfFalse As String) As MiniHtml
	Return addClassIIf(condition, valueIfTrue, valueIfFalse)
End Sub

'Add a class if condition is true
Public Sub addClassIf (condition As Boolean, value As String) As MiniHtml
	If condition Then Return addClass(value)
	Return Me
End Sub

'Add class based on condition is true or false
Public Sub addClassIIf (condition As Boolean, valueIfTrue As String, valueIfFalse As String) As MiniHtml
	If condition Then Return addClass(valueIfTrue)
	Return addClass(valueIfFalse)
End Sub

'Remove class attribute if empty
Private Sub updateClassAttribute
	If mClasses.Size = 0 Then
		mAttributes.Remove("class")
	Else
		mAttributes.Put("class", classesAsString)
	End If
End Sub

'Remove style attribute if empty
Private Sub updateStyleAttribute
	If mStyles.Size = 0 Then
		mAttributes.Remove("style")
	Else
		mAttributes.Put("style", stylesAsString)
	End If
End Sub

'Convert list of classes into one String
Public Sub classesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each item As String In mClasses
		If sb.Length > 0 Then sb.Append(" ")
		sb.Append(item)
	Next
	Return sb.ToString
End Sub

'Convert map of styles into one String
Public Sub stylesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each key As String In mStyles.Keys
		If sb.Length > 0 Then sb.Append(";" & IIf(mFlat, "", " "))
		sb.Append($"${key}:${IIf(mFlat, "", " ")}${mStyles.Get(key)}"$)
	Next
	Return sb.ToString
End Sub

Public Sub convertFromBytes (Buffer() As Byte) As MiniHtml
	Return parse(BytesToString(Buffer, 0, Buffer.Length, "UTF-8"))
End Sub

Public Sub convertToBytes As Byte()
	Return build.GetBytes("UTF8")
End Sub

Public Sub convertToMiniHtml (node1 As HtmlNode) As MiniHtml
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
				parent.bool(att.Key) ' boolean attribute
			Else
				parent.attr(att.Key, att.Value) ' regular attribute
			End If
		End If
	Next
    
	For Each node As HtmlNode In node1.Children
		Dim tag2 As MiniHtml = convertToMiniHtml(node)
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

Public Sub parse (HtmlText As String) As MiniHtml
	Dim parser As MiniHtmlParser
	parser.Initialize
	Dim node1 As HtmlNode = parser.Parse(HtmlText)
	For Each HtmlNode1 As HtmlNode In node1.Children
		If HtmlNode1.Name <> "" Then Return convertToMiniHtml(HtmlNode1)
	Next
	Return create(ModeNoTag)
End Sub

' Parse a JSON string into a MiniHtml tree.
' Shorthand format: {"tagname": {"class": "...", "text": "...", "children": [...]}}
' Or: {"tagname": "inner text"}
' Or an array: [{"div": ...}, {"span": ...}]
Public Sub fromJson (JsonStr As String) As MiniHtml
	Dim obj As Object = IIf(JsonStr.StartsWith("["), JsonStr.As(JSON).ToList, JsonStr.As(JSON).ToMap)
	Return anyToMiniHtml(obj)
End Sub

' Parse a pre-parsed Map into a MiniHtml tree (shorthand format: {"tagname": {properties}})
Public Sub fromMap (m As Map) As MiniHtml
	Return shorthandToMiniHtml(m)
End Sub

' Convert a JSON value (Map or List) to MiniHtml
Private Sub anyToMiniHtml (obj As Object) As MiniHtml
	If obj Is Map Then
		Return ShorthandToMiniHtml(obj)
	Else If obj Is List Then
		Dim list As List = obj
		Dim root As MiniHtml
		root.Initialize("")
		For Each item As Object In list
			If item Is Map Then
				shorthandToMiniHtml(item).up(root)
			End If
		Next
		Return root
	End If
	Dim empty As MiniHtml
	empty.Initialize("")
	Return empty
End Sub

' Convert a shorthand map {"tagname": {properties}} or {"tagname": "text"}
Private Sub shorthandToMiniHtml (m As Map) As MiniHtml
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
							shorthandToMiniHtml(chd).up(el)
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
					el.attr("id", value)
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
Public Sub toMap As Map
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
Public Sub toJson As String
	Dim map1 As Map = toMap
	Dim jg As JSONGenerator
	jg.Initialize(map1)
	Return jg.ToString
End Sub

' Wrap script inside script tags
'output: <code><script>value</script></code>
Public Sub script (value As String) As MiniHtml
	mChildren.Add(create("script").multiline.text(value))
	Return Me
End Sub

Public Sub wrapAttributes As MiniHtml
	mFormatAttributes = True
	Return Me
End Sub

'Set uniline mode
Public Sub uniline As MiniHtml
	mMode = ModeUniline
	Return Me
End Sub

'Set normal mode
Public Sub multiline As MiniHtml
	mMode = ModeMultiline
	Return Me
End Sub

' Adds a key-value pair to the very beginning of an existing Map
Private Sub PrependToMap (OriginalMap As Map, NewKey As Object, NewValue As Object) As Map
	Dim TempMap As Map
	TempMap.Initialize
	TempMap.Put(NewKey, NewValue)
	For Each Key As Object In OriginalMap.Keys
		TempMap.Put(Key, OriginalMap.Get(Key))
	Next
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

'Get tag
Public Sub getName As String
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
Public Sub getParent As MiniHtml
	Return mParent
End Sub
Public Sub setParent (ParentTag As MiniHtml)
	mParent = ParentTag
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
	Dim sb As StringBuilder
	sb.Initialize
	mIndents = Value
	'If mFlat Then Return
	For n = 0 To mIndents - 1
		sb.Append(mIndentString)
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