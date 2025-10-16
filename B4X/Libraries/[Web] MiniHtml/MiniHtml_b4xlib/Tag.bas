B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=4.5
@EndOfDesignText@
' Credit to: EnriqueGonzalez
' Enhanced by: Aeric
Sub Class_Globals
	Private mName As String
	Private mMode As String
	Private innerTags As List
	Private mAttributes As Map
	Private mClasses As List
	Private mStyles As Map
	Private mParent As Tag
	Private mFlat As Boolean
	Public Const mUniline 	As String = "uniline" 	' <tag></tag>
	Public Const mNormal 	As String = "normal"	' <tag></tag> (multiline)
	Public Const mLink 		As String = "link"		' <tag />
	Public Const mMeta 		As String = "meta"		' <meta>
	Public Const mNoTag 	As String = ""
End Sub

Public Sub Initialize (tagName As String) As Tag
	innerTags.Initialize
	mAttributes.Initialize
	mClasses.Initialize
	mStyles.Initialize
	mName = tagName
	Select mName.ToLowerCase
		Case "head"
			mMode = mNormal
		Case "meta", "input"
			mMode = mMeta
		Case "title", "h1", "h2", "h3", "h4", "h5", "script", "label", "button", "span", "li", "option", "bold", "italic", "underline", "strong", "em", "del", "th", "td", "small"
			mMode = mUniline
		Case "img", "link", "br"
			mMode = mLink
		Case "text", ""
			mMode = mNoTag
		Case Else
			mMode = mNormal
	End Select
	Return Me
End Sub

Public Sub build As String
	Return build2(-1)
End Sub

Public Sub build2 (indent As Int) As String
	Dim htmlText As StringBuilder
	htmlText.Initialize
	
	htmlText.Append(CRLF)
	For n = 0 To indent
		htmlText.Append(TAB)
	Next
	
	If Not(mMode = "") Then
		htmlText.Append("<" & mName)
	End If
	
	For Each key As String In mAttributes.Keys
		'Log(key & "->" & mAttributes.Get(key))
		Dim attrs As String = mAttributes.Get(key)
		If attrs.Length > 0 Then
			htmlText.Append($" ${key}=${QUOTE}"$)
			htmlText.Append(attrs)
			htmlText.Append(QUOTE)
		Else
			htmlText.Append($" ${key}"$)
		End If
	Next

	Select mMode
		Case mLink
			'If mFlat = False Then htmlText.Append(" ")
			htmlText.Append("/>")
		Case mUniline, mNormal, mMeta
			htmlText.Append(">")
	End Select

	For Each tagOrString In innerTags
		If tagOrString Is Tag Then
			htmlText.Append(tagOrString.As(Tag).build2(indent + 1))
		Else
			htmlText.Append(tagOrString.As(String))
		End If
	Next
	
	Select mMode
		Case mNormal
			htmlText.Append(CRLF)
			For n = 0 To indent
				htmlText.Append("	")
			Next
			htmlText.Append("</" & mName & ">")
		Case mUniline
			htmlText.Append("</" & mName & ">")
	End Select
	Return htmlText.ToString
End Sub

' set to true for no tabs and CRLF
Public Sub setFlat (Value As Boolean)
	mFlat = Value
End Sub

Public Sub getName As String
	Return mName
End Sub

Public Sub setName (tagName As String) As Tag
	mName = tagName
	Return Me
End Sub

Public Sub innerTag (index As Int) As Tag
	Return innerTags.Get(index)
End Sub

Public Sub innerTagById (Id As String) As Tag
	For i = 0 To innerTags.Size - 1
		If innerTag(i).mAttributes.Get("id") = Id Then
			Return innerTag(i)
		End If
	Next
	Return Null
End Sub

Public Sub PrintInnerTags
	For Each item As Tag In innerTags
		If item.IsInitialized Then
			Log(item.Name)
		End If
		item.PrintInnerTags
	Next
End Sub

Public Sub comment (value As String) As Tag
	innerTags.Add(Html.create(mNoTag))
	innerTags.Add($"<!--${value}-->"$)
	Return Me
End Sub
Public Sub comment2 (value As String) As Tag
	innerTags.Add($"<!--${value}-->"$)
	Return Me
End Sub

Public Sub addMeta (key As String, value As String)
	innerTags.Add(Html.create("meta").attribute(key, value))
End Sub

Public Sub addMeta2 (keyvals As Map)
	innerTags.Add(Html.create("meta").attribute2(keyvals))
End Sub

Public Sub meta_preset As Tag
	addMeta("charset", "UTF-8")
	addMeta2(CreateMap("name": "viewport", "content": "width=device-width, initial-scale=1"))
	'addMeta2(CreateMap("http-equiv": "X-UA-Compatible", "content": "IE=edge"))
	Return Me
End Sub

Public Sub link (keyvals As Map) As Tag
	innerTags.Add(Html.create("link").attribute2(keyvals))
	Return Me
End Sub

Public Sub linkCss (href As String) As Tag
	innerTags.Add(Html.create("link").attribute2(CreateMap("href": href, "rel": "stylesheet")))
	Return Me
End Sub

Public Sub cdnScript (src As String, integrity As String) As Tag
	Return cdnScript2(src, integrity, "anonymous")
End Sub

Public Sub cdnScript2 (src As String, integrity As String, crossorigin As String) As Tag
	innerTags.Add(Html.create("script").attribute2(CreateMap("src": src, "integrity": integrity, "crossorigin": crossorigin)))
	Return Me
End Sub

Public Sub cdnStyle (href As String, integrity As String) As Tag
	Return cdnStyle2(href, integrity, "anonymous")
End Sub

Public Sub cdnStyle2 (href As String, integrity As String, crossorigin As String) As Tag
	innerTags.Add(Html.create("link").attribute2(CreateMap("href": href, "rel": "stylesheet", "integrity": integrity, "crossorigin": crossorigin)))
	Return Me
End Sub

' raw with CRLF
Public Sub TextNextLine (value As String) As Tag
	innerTags.Add(Html.create(mNoTag))
	innerTags.Add(value)
	Return Me
End Sub

Public Sub TextInline (value As String)
	innerTags.Add(value)
End Sub

Public Sub Text (value As String) As Tag
	innerTags.Add(value)
	Return Me
End Sub

Public Sub script (value As String) As Tag
	innerTags.Add(Html.create("script").attribute("src", value))
	Return Me
End Sub

Public Sub script2 (value As String, keyvals As Map) As Tag
	innerTags.Add(Html.create("script").attribute("src", value).attribute2(keyvals))
	Return Me
End Sub

Public Sub style (value As String) As Tag
	innerTags.Add(Html.create("style").Text(value))
	Return Me
End Sub

Public Sub newline
	TextNextLine("")
End Sub

Public Sub title (value As String) As Tag
	innerTags.Add(Html.create("title").Text(value))
	Return Me
End Sub

Public Sub innerText As String
	If innerTags.Size > 0 Then
		If innerTags.Get(0).As(String).StartsWith("[") = False Then
			Return innerTags.Get(0)
		End If
	End If
	Return ""
End Sub

Public Sub Tags As List
	Return innerTags
End Sub

Public Sub setParent (Parent As Tag)
	mParent = Parent
End Sub

Public Sub getParent As Tag
	Return mParent
End Sub

' Add a Child and return parent tag
Public Sub add (Child As Tag) As Tag
	innerTags.Add(Child)
	Return Me
End Sub

' Add a Child without returning parent tag
Public Sub add2 (Child As Tag)
	innerTags.Add(Child)
End Sub

' Add to Parent and return parent tag
Public Sub addTo (Parent As Tag) As Tag
	Parent.add(Me)
	mParent = Parent
	Return Me
End Sub

' Add to Parent without returning parent tag
Public Sub addTo2 (Parent As Tag)
	Parent.add(Me)
	mParent = Parent
End Sub

' same as addTo
Public Sub up (Parent As Tag) As Tag
	Return addTo(Parent)
End Sub

' same as addTo2
Public Sub up2 (Parent As Tag)
	addTo2(Parent)
End Sub

' Same as add
Public Sub down (Child As Tag) As Tag
	Return add(Child)
End Sub

' Same as add2
Public Sub down2 (Child As Tag)
	add2(Child)
End Sub

' Add an attribute
Public Sub attribute (key As String, value As String) As Tag
	mAttributes.Put(key, value)
	Return Me
End Sub

' Add multiple attributes
Public Sub attribute2 (keyvals As Map) As Tag
	For Each key As String In keyvals.Keys
		Dim value As String = keyvals.Get(key)
		mAttributes.Put(key, value)
	Next
	Return Me
End Sub

' Add single attribute without value
Public Sub attribute3 (name As String) As Tag
	mAttributes.Put(name, "")
	Return Me
End Sub

' Add attributes by passing a json object
Public Sub attr (json As String) As Tag
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

' Return maps of attributes
Public Sub getAttributes As Map
	Return mAttributes
End Sub

Public Sub addId (value As String) As Tag
	mAttributes.Put("id", value)
	Return Me
End Sub

Public Sub addName (value As String) As Tag
	mAttributes.Put("name", value)
	Return Me
End Sub

Public Sub addClass (name As String) As Tag
	Try
		Dim names() As String = Regex.Split(" ", name)
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

Public Sub removeClass (name As String) As Tag
	If mClasses.IndexOf(name) > -1 Then mClasses.RemoveAt(mClasses.IndexOf(name))
	updateClassAttribute
	Return Me
End Sub

Public Sub addStyle (name As String) As Tag
	Try
		Dim pairs() As String = Regex.Split(";", name)
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

Public Sub removeStyle (name As String) As Tag
	If mStyles.ContainsKey(name) Then mStyles.Remove(name)
	updateStyleAttribute
	Return Me
End Sub

Private Sub updateClassAttribute
	If mClasses.Size = 0 Then
		mAttributes.Remove("class")
	Else
		mAttributes.Put("class", ClassesAsString)
	End If
End Sub

Private Sub updateStyleAttribute
	If mStyles.Size = 0 Then
		mAttributes.Remove("style")
	Else
		mAttributes.Put("style", StylesAsString)
	End If
End Sub

Public Sub ClassesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each item As String In mClasses
		If sb.Length > 0 Then sb.Append(" ")
		sb.Append(item)
	Next
	Return sb.ToString
End Sub

Public Sub StylesAsString As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each key As String In mStyles.Keys
		If sb.Length > 0 Then sb.Append(";" & IIf(mFlat, "", " "))
		sb.Append($"${key}:${IIf(mFlat, "", " ")}${mStyles.Get(key)}"$)
	Next
	Return sb.ToString
End Sub

Public Sub setMode (TagMode As String)
	mMode = TagMode.ToLowerCase
End Sub

Public Sub getMode As String
	Return mMode
End Sub

Public Sub uniline As Tag
	mMode = mUniline
	Return Me
End Sub

Public Sub multiline As Tag
	mMode = mNormal
	Return Me
End Sub

Public Sub required As Tag
	If mName = "input" Then
		mAttributes.Put("required", "")
	End If
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

Public Sub hxSwap (name As String) As Tag
	mAttributes.Put("hx-swap", name)
	Return Me
End Sub

Public Sub hxTarget (name As String) As Tag
	mAttributes.Put("hx-target", name)
	Return Me
End Sub

Public Sub hxTrigger (eventname As String) As Tag
	mAttributes.Put("hx-trigger", eventname)
	Return Me
End Sub

Public Sub hxIndicator (name As String) As Tag
	mAttributes.Put("hx-indicator", name)
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

Public Sub hxExt (name As String) As Tag
	mAttributes.Put("hx-ext", name)
	Return Me
End Sub

Public Sub hxSync (name As String) As Tag
	mAttributes.Put("hx-sync", name)
	Return Me
End Sub

Public Sub hxSwapOob (value As String) As Tag
	mAttributes.Put("hx-swap-oob", value)
	Return Me
End Sub