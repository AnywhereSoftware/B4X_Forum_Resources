B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
'create the generic component builder
Sub Class_Globals
	Public ID As String
	Public Tag As String
	Private properties As Map
	Private Contents As List
	Private classes As Map
	Public Styles As Map
	Private LooseAttributes As Map
	Private DontBreak As List
	Private Prefix As String
	Private DoAProperClose As Boolean
	Private Required As Boolean
	Private Enabled As Boolean
	Private Inline As Boolean
	Private ReadOnly As Boolean
	Private CSSRule As Map
	Private SingleQuote As List
	Private ParentID As String
	Private SBAfter As StringBuilder
	Private SBBefore As StringBuilder
	Public IsImportant As Boolean
End Sub

Sub SetSpan(sText As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("<span>").Append(sText).Append("</span>")
	SetText(sb.ToString)
	Return Me
End Sub

'set vertical
Sub SetVertical(b As Boolean) As UOENowHTML
	AddClass("vertical")
	Return Me
End Sub

'set dark
Sub SetDark(b As Boolean) As UOENowHTML
	AddClass("dark")
	Return Me
End Sub

'set box colored
Sub SetBoxColored(b As Boolean) As UOENowHTML
	AddClass("box-colored")
	Return Me
End Sub

'set section
Sub SetSection(b As Boolean) As UOENowHTML
	AddClass("section")
	Return Me
End Sub

'set double padded
Sub SetDoublePadded(b As Boolean) As UOENowHTML
	AddClass("double-padded")
	Return Me
End Sub

'wrap element to
Sub Wrap(wid As String, wrapType As String) As UOENowHTML
	Dim p As UOENowHTML
	p.Initialize(wid, wrapType)
	p.AddContent(HTML)
	Return p 
End Sub

'set row
Sub SetRow(b As Boolean) As UOENowHTML
	AddClass("row")
	Return Me
End Sub

'set responsive padding
Sub SetResponsivePadding(b As Boolean) As UOENowHTML
	AddClass("responsive-padding")
	Return Me
End Sub


'set responsive margin
Sub SetResponsiveMargin(b As Boolean) As UOENowHTML
	AddClass("responsive-margin")
	Return Me
End Sub

'set inverse
Sub SetInverse(b As Boolean) As UOENowHTML
	AddClass("inverse")
	Return Me
End Sub

'set tertiary
Sub SetTertiary(b As Boolean) As UOENowHTML
	AddClass("tertiary")
	Return Me
End Sub

'set secondary
Sub SetSecondary(b As Boolean) As UOENowHTML
	AddClass("secondary")
	Return Me
End Sub

'set primary
Sub SetPrimary(b As Boolean) As UOENowHTML
	AddClass("primary")
	Return Me
End Sub


'set circular
Sub SetCircular(b As Boolean) As UOENowHTML
	AddClass("circular")
	Return Me
End Sub

'set bordered
Sub SetBordered(b As Boolean) As UOENowHTML
	AddClass("bordered")
	Return Me
End Sub

'set shadowed
Sub SetShadowed(b As Boolean) As UOENowHTML
	AddClass("shadowed")
	Return Me
End Sub

'set rounded
Sub SetRounded(b As Boolean) As UOENowHTML
	AddClass("rounded")
	Return Me
End Sub

'set the tooltip
Sub SetToolTip(tt As String) As UOENowHTML
	AddClass("tooltip")
	SetAttr("aria-label", tt)
	Return Me
End Sub

Sub SetAttr(attr As String, val As String) As UOENowHTML
	AddAttribute(attr,val)
	Return Me
End Sub

'set role button
Sub SetRoleButton(b As Boolean) As UOENowHTML
	SetROLE("button")
	Return Me
End Sub

'set disabled
Sub SetDisabled(b As Boolean) As UOENowHTML
	If b Then AddLooseAttribute("disabled")
	Return Me
End Sub

'set small
Sub SetSmall(b As Boolean) As UOENowHTML
	AddClassOnCondition(b, "small")
	Return Me
End Sub

'set large
Sub SetLarge(b As Boolean) As UOENowHTML
	AddClassOnCondition(b, "large")
	Return Me
End Sub


Sub SetImportant(b As Boolean) As UOENowHTML
	IsImportant = b
	Return Me
End Sub

'set style
Sub SetStyle(prop As String, val As String) As UOENowHTML
	AddStyle(prop,val)
	Return Me
End Sub

'set width
Sub SetWidth(w As Object) As UOENowHTML
	AddAttribute("width", w)
	Return Me
End Sub

'set width
Sub SetCSS(w As Object) As UOENowHTML
	AddAttribute("css", w)
	Return Me
End Sub

'set height
Sub SetHeight(h As String) As UOENowHTML
	AddAttribute("height", h)
	Return Me
End Sub

Sub SetPaddingBottom(PaddingBottom As String) As UOENowHTML
	AddStyleAttribute("padding-bottom", MakePx(PaddingBottom))
	Return Me
End Sub

Sub SetPaddingRight(PaddingRight As String) As UOENowHTML
	AddStyleAttribute("padding-right", MakePx(PaddingRight))
	Return Me
End Sub

Sub SetPaddingLeft(PaddingLeft As String) As UOENowHTML
	AddStyleAttribute("padding-left", MakePx(PaddingLeft))
	Return Me
End Sub
	
Sub SetPaddingTop(PaddingTop As String) As UOENowHTML
	AddStyleAttribute("padding-top", MakePx(PaddingTop))
	Return Me
End Sub

Sub SetMarginBottom(MarginBottom As String) As UOENowHTML
	AddStyleAttribute("margin-bottom", MakePx(MarginBottom))
	Return Me
End Sub

Sub SetMarginRight(MarginRight As String) As UOENowHTML
	AddStyleAttribute("margin-right", MakePx(MarginRight))
	Return Me
End Sub

Sub SetMarginLeft(MarginLeft As String) As UOENowHTML
	AddStyleAttribute("margin-left", MakePx(MarginLeft))
	Return Me
End Sub
	
Sub SetMarginTop(MarginTop As String) As UOENowHTML
	AddStyleAttribute("margin-top", MakePx(MarginTop))
	Return Me
End Sub

Sub UseTheme(sPrefix As String, themeName As String) As UOENowHTML
	If themeName = "" Then Return Me
	themeName = themeName.tolowercase
	If sPrefix <> "" And themeName <> "" Then
		AddClass($"${sPrefix}-${themeName}"$)
	End If
	Return Me
End Sub

Sub AddAttributeIfSet(prop As String, value As String) As UOENowHTML
	If value <> "" Then
		AddAttribute(prop,value)
	End If
	Return Me
End Sub

Sub SetPlaceHolder(sPlaceholder As String) As UOENowHTML
	AddAttribute("placeholder",sPlaceholder)
	Return Me
End Sub

Sub SetTITLE(stitle As String) As UOENowHTML
	AddAttribute("title", stitle)
	Return Me
End Sub

Sub SetREL(rel As String) As UOENowHTML
	AddAttribute("rel", rel)
	Return Me
End Sub

'clear contents
Sub Clear As UOENowHTML
	Contents.clear
	Return Me
End Sub

Sub AddPropertyOnCondition(bCondition As Boolean, attr As String, value As String) As UOENowHTML
	If bCondition Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub


Public Sub AddProperty(sKey As String, sValue As String) As UOENowHTML
	AddAttribute(sKey, sValue)
	Return Me
End Sub

Sub SetTARGET(sValue As String) As UOENowHTML
	If sValue.Trim = "" Then Return Me
	AddAttribute("target",sValue)
	Return Me
End Sub

Sub SetTargetBlank(b As Boolean) As UOENowHTML
	SetTARGET("_blank")
	Return Me
End Sub

Sub SetTargetSelf(b As Boolean) As UOENowHTML
	SetTARGET("_self")
	Return Me
End Sub
	
Sub SetTargetParent(b As Boolean) As UOENowHTML
	SetTARGET("_parent")
	Return Me
End Sub
	
Sub SetTargetTop(b As Boolean) As UOENowHTML
	SetTARGET("_top")
	Return Me
End Sub

Sub ApplyStyle(sStyle As String) As UOENowHTML
	'we expect a delimited string with ;
	sStyle = sStyle.trim
	sStyle = RemDelim(sStyle,";")
	Dim pieces As List = StrParse(";",sStyle)
	For Each strPiece As String In pieces
		Dim attr As String = MvField(strPiece,1,":")
		Dim val As String = MvField(strPiece,2,":")
		attr = attr.trim
		val = val.trim
		If attr <> "" Then 
			AddStyleAttribute(attr,val)
		End If
	Next
	Return Me
End Sub

Sub Center As UOENowHTML
	AddClass("center")
	Return Me
End Sub

Sub GetStyleAttribute(attr As String) As String
	attr = attr.ToLowerCase
	attr = RemDelim(attr,":")
	attr = attr.trim
	Dim hasItem As Boolean = Styles.ContainsKey(attr)
	If hasItem Then
		Return Styles.Get(attr)
	Else
		Return ""
	End If
End Sub

'add content to the element
public Sub SetContents(value As String) As UOENowHTML
	Contents.Initialize
	Contents.clear
	If value.Length > 0 Then
		value = FormatText(value)
		Contents.Add(value)
	End If
	Return Me
End Sub


public Sub AddElementLine(el As UOENowHTML) As UOENowHTML
	If el <> Null Then
		Dim scode As String = el.html
		AddContent(scode)
	End If
	Return Me
End Sub


Sub SetROLE(sValue As String) As UOENowHTML
	AddAttribute("role",sValue)
	Return Me
End Sub

Sub SetMETHOD(sValue As String) As UOENowHTML
	AddAttribute("method",sValue)
	Return Me
End Sub

'add content to the element
public Sub AddContentLine(value As String) As UOENowHTML
	If value <> "" Then
		value = value.Replace(CRLF,"")
		value = FormatText(value)
		Contents.Add(value)
	End If
	Return Me
End Sub

Sub SetTypeNumbers() As UOENowHTML
	AddAttribute("type","1")
	Return Me
End Sub

Sub SetTypeUpperCase() As UOENowHTML
	AddAttribute("type","A")
	Return Me
End Sub

Sub SetTypeLowerCase() As UOENowHTML
	AddAttribute("type","a")
	Return Me
End Sub

Sub SetTypeUpperCaseRoman() As UOENowHTML
	AddAttribute("type","I")
	Return Me
End Sub

Sub SetTypeLowerCaseRoman() As UOENowHTML
	AddAttribute("type","i")
	Return Me
End Sub


Sub SetListStyleCircle() As UOENowHTML
	AddStyleAttribute("list-style-type","circle")
	Return Me
End Sub

Sub SetListStyleDisk() As UOENowHTML
	AddStyleAttribute("list-style-type","disk")
	Return Me
End Sub

Sub SetListStyleNone() As UOENowHTML
	AddStyleAttribute("list-style-type","none")
	Return Me
End Sub

Sub SetListStyleSquare() As UOENowHTML
	AddStyleAttribute("list-style-type","square")
	Return Me
End Sub

Sub AddHeading(sSize As Int, sContent As String) As UOENowHTML
	Dim hdr As UOENowHTML
	Dim hKey As String = "h" & sSize
	hdr.Initialize("",hKey)
	hdr.AddContent(sContent)
	AddContent(hdr.HTML)
	Return Me
End Sub

Sub AddParagraph(sContent As String) As UOENowHTML
	Dim p As UOENowHTML
	p.Initialize("","p")
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

Sub AddMark(sContent As String, sclass As String) As UOENowHTML
	Dim p As UOENowHTML
	p.Initialize("","mark").AddClass(sclass)
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttributeOnFalseCondition(bStatus As Boolean, value As String) As UOENowHTML
	If bStatus = False Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'change the element type
Sub SetElementTypeOnCondition(bStatus As Boolean,sElementType As String) As UOENowHTML
	If bStatus Then
		Tag = sElementType
	End If
	Return Me
End Sub


Sub SetZIndex(zindex As String) As UOENowHTML
	AddStyleAttribute("z-index",zindex)
	Return Me
End Sub

Sub AddContentListReverse(lst As List) As UOENowHTML
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = lTot To 0 Step -1
		Dim strContent As String = lst.Get(lCnt)
		AddContent(strContent)
	Next
	Return Me
End Sub


Sub SetFOR(sFor As String) As UOENowHTML
	AddAttribute("for",sFor)
	Return Me
End Sub


Sub SetVALUE(sValue As String) As UOENowHTML
	AddAttribute("value",sValue)
	Return Me
End Sub


Sub SetNAME(sName As String) As UOENowHTML
	AddAttribute("name",sName)
	Return Me
End Sub

Sub SetTYPE(sValue As String) As UOENowHTML
	AddAttribute("type",sValue)
	Return Me
End Sub


Sub UpdateAttribute(name As String, propValue As String) As UOENowHTML
	If properties.ContainsKey(name) Then
		Dim svalue As String = properties.Get(name)
		svalue = svalue & ";" & propValue
		properties.Put(name,svalue)
	Else
		properties.Put(name,propValue)
	End If
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttributeOnCondition(bStatus As Boolean, value As String) As UOENowHTML
	If bStatus = True Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttribute(value As String) As UOENowHTML
	LooseAttributes.Put(value,value)
	Return Me
End Sub

Sub MakePx(sValue As String) As String
	sValue = sValue.trim
	If sValue.EndsWith("%") Then
		Return sValue
	else If sValue.EndsWith("vm") Then
		Return sValue
	else If sValue.EndsWith("px") Then
		Return sValue
	else If sValue.EndsWith("cm") Then
		Return sValue
	else If sValue.EndsWith("mm") Then
		Return sValue
	else If sValue.EndsWith("in") Then
		Return sValue
	else If sValue.EndsWith("pt") Then
		Return sValue
	else If sValue.EndsWith("pc") Then
		Return sValue
	else If sValue.EndsWith("em") Then
		Return sValue
	else If sValue.EndsWith("ex") Then
		Return sValue
	else If sValue.EndsWith("ch") Then
		Return sValue
	else If sValue.EndsWith("rem") Then
		Return sValue
	else If sValue.EndsWith("vw") Then
		Return sValue
	else If sValue.EndsWith("vh") Then
		Return sValue
	else If sValue.EndsWith("vmin") Then
		Return sValue
	else If sValue.EndsWith("vmax") Then
		Return sValue
	else If sValue.EndsWith(";") Then
		Return sValue
	Else
		sValue = sValue.Replace("px","")
		sValue = $"${sValue}px"$
		If sValue = "px" Then sValue = ""
		Return sValue
	End If
End Sub


Sub AddDataAttribute(attribute As String, value As String) As UOENowHTML
	Dim sw As Boolean = attribute.StartsWith("data-")
	If sw Then
		AddAttribute(attribute,value)
	Else
		AddAttribute("data-" & attribute,value)
	End If
	Return Me
End Sub

Sub AddDataAttributeOnCondition(bCondition As Boolean,attribute As String, value As String) As UOENowHTML
	If bCondition = False Then 
		Return Me
	End If
	AddDataAttribute(attribute,value)
	Return Me
End Sub

Sub AddStyleOnCondition(bCondition As Boolean,attribute As String, value As String) As UOENowHTML
	If bCondition = False Then 
		Return Me
	End If
	AddStyle(attribute,value)
	Return Me
End Sub


Sub SetSRC(sValue As String, Static As Boolean) As UOENowHTML
	Dim tmpFile As String = MvField(sValue,1,"?")
	If Static Then
		sValue = tmpFile
	Else
		sValue = tmpFile & "?" & DateTime.now
	End If
	AddAttribute("src",sValue)
	Return Me
End Sub


Sub SetALT(sValue As String) As UOENowHTML
	AddAttribute("alt",sValue)
	Return Me
End Sub

Sub SetWidthPX(Width As String) As UOENowHTML
	If Width <> "" Then
		AddStyleAttribute("width", MakePx(Width))
	End If
	Return Me
End Sub


Sub SetHeightPX(Height As String) As UOENowHTML
	If Height <> "" Then
		AddStyleAttribute("height", MakePx(Height))
	End If
	Return Me
End Sub

Sub AddStyleAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As UOENowHTML
	If bCondition = True Then
		AddStyleAttribute(attr,value)
	End If
	Return Me
End Sub

Sub AddAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As UOENowHTML
	If bCondition = True Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub

Sub GetAttribute(attr As String) As String
	attr = attr.tolowercase
	If properties.ContainsKey(attr) Then
		Return properties.Get(attr)
	Else
		Return ""
	End If
End Sub


Sub ClassExists(value As String) As Boolean
	value = value.trim
	If value.Length > 0 Then
		Return classes.ContainsKey(value)
	End If
	Return False
End Sub


'the html string of the component
public Sub HTML As String
	Dim sOut As String = ToString
	Return sOut
End Sub


Sub Pointer As String
	Return "cursor:pointer"
End Sub

Sub AddCursor As UOENowHTML
	AddStyleAttribute("cursor", "pointer")
	Return Me
End Sub

Sub SetHREF(value As String) As UOENowHTML
	AddAttribute("href",value)
	Return Me
End Sub

Sub AddClassOnValue(iValue As Int, sClass As String) As UOENowHTML
	If iValue > 0 Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnCondition(bCondition As Boolean, sClass As String) As UOENowHTML
	If bCondition  Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnFalseCondition(bCondition As Boolean, sClass As String) As UOENowHTML
	If bCondition = False Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub RemoveClassOnCondition(bCondition As Boolean, sClass As String) As UOENowHTML
	If bCondition Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


Sub RemoveClassOnFalseCondition(bCondition As Boolean, sClass As String) As UOENowHTML
	If bCondition = False Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


'add a list of elements
Sub AddContentList(lst As List) As UOENowHTML
	For Each strContent As String In lst
		AddContent(strContent)
	Next
	Return Me
End Sub

'set the text of the element, in most cases you will use AddContent
Sub SetText(sText As String) As UOENowHTML
	AddContent(sText)
	Return Me
End Sub

Sub SetCode(sText As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("<code>").Append(sText).Append("</code>")
	AddContent(sb.tostring)
	Return Me
End Sub


Sub AddText(txt As String) As UOENowHTML
	AddContent(txt)
	Return Me
End Sub

'set prefix
Sub SetPrefix(sPrefix As String) As UOENowHTML
	Prefix = sPrefix
	Return Me
End Sub

'set id
Sub SetID(sID As String) As UOENowHTML
	sID = sID.tolowercase
	ID = sID
	Return Me
End Sub

'set the tag, this updates the tab
Sub SetTag(sTag As String) As UOENowHTML
	Tag = sTag
	Return Me
End Sub

'set parent id
Sub SetParentID(sParentID As String) As UOENowHTML
	ParentID = sParentID
	Return Me
End Sub

'set read only
Sub SetReadOnly(bReadOnly As Boolean) As UOENowHTML
	ReadOnly = bReadOnly
	Return Me
End Sub

'set max
Sub SetMax(m As Object) As UOENowHTML
	SetAttr("max", m)
	Return Me
End Sub


'set inline
Sub SetInline(bInline As Boolean) As UOENowHTML
	Inline = bInline
	Return Me
End Sub

'set enabled
Sub SetEnabled(bEnabled As Boolean) As UOENowHTML
	Enabled = bEnabled
	Return Me
End Sub

'set required
Sub SetRequired(bRequired As Boolean) As UOENowHTML
	Required = bRequired
	Return Me
End Sub

'Initializes the html builder
Public Sub Initialize(elID As String, eltag As String) As UOENowHTML
	elID = CStr(elID)
	IsImportant = True
	SBBefore.Initialize 
	SBAfter.Initialize 
	ID = elID.ToLowerCase
	properties.Initialize
	properties.clear
	Contents.Initialize
	Contents.clear
	Styles.Initialize
	Styles.clear
	classes.Initialize
	classes.clear
	LooseAttributes.Initialize
	LooseAttributes.clear
	ParentID = ""
	DontBreak.Initialize
	DontBreak.clear
	DontBreak.Add("li")
	DontBreak.Add("a")
	DontBreak.Add("i")
	DontBreak.Add("span")
	DontBreak.Add("img")
	Tag = eltag
	Prefix = ""
	DoAProperClose = True
	Required = False
	Enabled = True
	Inline = False
	ReadOnly = False
	CSSRule.Initialize
	CSSRule.clear
	SingleQuote.Initialize
	SingleQuote.clear
	Return Me
End Sub

Sub SetSublink1(b As Boolean) As UOENowHTML
	AddClass("sublink-1")
	Return Me
End Sub

Sub SetSublink2(b As Boolean) As UOENowHTML
	AddClass("sublink-2")
	Return Me
End Sub

Sub Pop(pElement As UOENowHTML)
	pElement.AddElement(Me)
End Sub

'remove a data attribute
public Sub RemoveAttrData(sData As String) As UOENowHTML
	sData = $"data-${sData}"$
	RemoveAttr(sData)
	Return Me
End Sub

Sub RemoveAttributeOnCondition(bCondition As Boolean, prop As String) As UOENowHTML
	If bCondition Then
		RemoveAttr(prop)
	End If
	Return Me
End Sub

'remove attribute
Sub RemoveAttribute(prop As String) As UOENowHTML
	RemoveAttr(prop)
	Return Me	
End Sub

'remove an attribute from the ones set
public Sub RemoveAttr(sName As String) As UOENowHTML
	sName = sName.ToLowerCase
	sName = sName.Replace(" ",";")
	Dim sItems As List = StrParse(";",sName)
	For Each strStyle As String In sItems
		strStyle = strStyle.trim
		If properties.ContainsKey(strStyle) Then 
			properties.Remove(strStyle)
		End If
	Next
	Return Me
End Sub

'remove an attribute from the ones set 
public Sub RemoveStyle(styleName As String) As UOENowHTML
	styleName = styleName.Trim
	styleName = styleName.tolowercase
	styleName = styleName.Replace(" ",";")
	Dim sItems As List = StrParse(";",styleName)
	For Each strStyle As String In sItems
		strStyle = strStyle.trim
		If Styles.ContainsKey(strStyle) Then 
			Styles.Remove(strStyle)
		End If
	Next
	Return Me
End Sub

'set a loose attribute
Sub SetAttrLoose(value As String) As UOENowHTML
	AddLooseAttribute(value)
	Return Me
End Sub

'generate component builder code
private Sub GetComponentBuilder() As String
	Dim sb As StringBuilder
	sb.Initialize
	If Prefix.Length > 0 Then
		sb.Append(Prefix)
	End If
	sb.Append("<")
	sb.Append(Tag)
	sb.Append(" ")
	If ID.Length > 0 Then
		sb.Append(ToProperty("id",ID))
	End If
	sb.Append(">")
	Select Case Tag.ToLowerCase
		Case "img", "link", "meta", "input", "source"
			DoAProperClose = False
	End Select
	If DoAProperClose = True Then
		sb.Append("</")
		sb.Append(Tag)
		sb.Append(">")
	End If
	Dim sout As String = sb.tostring
	sout = sout.Trim
	Return sout
End Sub

'return a key value string for an attribute
private Sub ToProperty(sName As String, svalue As String) As String
	sName = CStr(sName)
	svalue = CStr(svalue)
	sName = sName.Replace("null","")
	sName = sName.Replace("undefined","")
	svalue = svalue.Replace("null","")
	svalue = svalue.Replace("undefined","")
	sName = sName.Trim
	svalue = svalue.trim
	If sName.Length > 0 Then
		Dim script As String = $"${sName}='${svalue}'"$
		script = script.trim
		Return script
	Else
		Return ""
	End If	
End Sub

'set a data attribute
Sub SetAttrData(prop As String, value As String) As UOENowHTML
	Dim sw As Boolean = prop.StartsWith("data-")
	If sw Then
		AddAttribute(prop,value)
	Else
		AddAttribute("data-" & prop,value)
	End If
	Return Me
End Sub

private Sub CStr(o As Object) As String
	Return "" & o
End Sub


'add content to the element 
public Sub AddContent(value As String) As UOENowHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		Contents.Add(value)
	End If
	Return Me
End Sub

'add content to the element after closure 
public Sub AddContentAfter(value As String) As UOENowHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBAfter.Append(value)
	End If
	Return Me
End Sub

'add content to the element before open 
public Sub AddContentBefore(value As String) As UOENowHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBBefore.Append(value)
	End If
	Return Me
End Sub


'remove a class
public Sub removeClass(className As String) As UOENowHTML
	className = className.Trim
	className = className.replace(" ",";")
	Dim sItems As List = StrParse(";",className)
	For Each strStyle As String In sItems
		strStyle = strStyle.Trim
		If classes.ContainsKey(strStyle) Then 
			classes.Remove(strStyle)
		End If
	Next
	Return Me
End Sub

'add an element
public Sub AddElement(el As UOENowHTML) As UOENowHTML
	If el <> Null Then
		Dim scode As String = el.tostring
		AddContent(scode)
	End If
	Return Me
End Sub

'add elements
Sub AddElements(lst As List) As UOENowHTML
	For Each el As UOENowHTML In lst
		AddElement(el)
	Next
	Return Me
End Sub

'build the class attribute
Sub BuildClass() As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim kTot As Int = classes.Size - 1
	Dim kCnt As Int
	Dim strClass As String  = classes.GetKeyAt(0)
	sb.Append(strClass)
	For kCnt = 1 To kTot
		Dim strClass As String  = classes.GetKeyAt(kCnt)
		sb.Append(" ")
		sb.Append(strClass)
	Next
	Return sb.ToString
End Sub
'
'build the styles
Sub BuildStyle() As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim kCnt As Int
	Dim kTot As Int = Styles.Size - 1
	
	Dim strKey As String = Styles.GetKeyAt(0)
	Dim strValue As String = Styles.Get(strKey)
	Dim strLine As String = ToStyle(strKey,strValue)
	sb.Append(strLine)
	For kCnt = 1 To kTot
		Dim strKey As String = Styles.GetKeyAt(kCnt)
		Dim strValue As String = Styles.Get(strKey)
		Dim strLine As String = ToStyle(strKey,strValue)
		sb.Append(" ")
		sb.Append(strLine)
	Next
	Return sb.tostring
End Sub

'convert such to property
private Sub ToStyle(sName As String, value As String) As String
	If sName.Length > 0 And value.Length > 0 Then
		Dim ew As Boolean = sName.EndsWith(":")
		If ew Then
			sName = MvField(sName,1,":")
		End If
		Dim sout As String = $"${sName}:${value};"$
		If sout = ":;" Then sout = ""
		Return sout
	Else
		Return ""
	End If
End Sub

public Sub MvFieldFrom(sValue As String, iPosition As Int, Delimiter As String) As String
	If sValue.Length = 0 Then Return ""
	Dim mValues As List
	Dim tValues As Int
	Dim ew As Boolean = sValue.EndsWith(Delimiter)
	If ew Then 
		sValue = sValue & " "
	End If
	mValues = StrParse(Delimiter, sValue)
	tValues = mValues.size -1
	If tValues < iPosition Then
		Return mValues.get(tValues)
	End If
	Dim sb As StringBuilder
	sb.Initialize
	Dim startcnt As Int
	sb.Append(mValues.get(iPosition))
	For startcnt = iPosition + 1 To tValues
		sb.Append(Delimiter)
		sb.Append(mValues.get(startcnt))
	Next
	Return sb.tostring
End Sub

'define the opening of the element
private Sub Open() As String
	'update any loose attributes
	If Required = True Then SetAttrLoose("required")
	If Enabled = False Then SetAttrLoose("disabled")
	If Inline = True Then SetAttrLoose("inline")
	If ReadOnly = True Then SetAttrLoose("readonly")
	'build all classes for the element
	Dim thisClass As String = BuildClass
	thisClass = thisClass.trim
	If thisClass.Length > 0 Then 
		AddAttribute("class", thisClass)
	End If
	'build the styles
	Dim thisStyle As String = BuildStyle
	thisStyle = thisStyle.trim
	If thisStyle.Length > 0 Then 
		AddAttribute("style", thisStyle)
	End If
	Dim sb As StringBuilder
	sb.Initialize
	If Prefix.Length > 0 Then
		sb.Append(Prefix)
	End If
	sb.Append("<")
	sb.Append(Tag)
	sb.Append(" ")
	If ID.Length > 0 Then
		sb.Append(ToProperty("id",ID))
		sb.Append(" ")
	End If
	'
	Dim thisAttr As String = BuildAttributes
	thisAttr = thisAttr.Trim
	If thisAttr.Length > 0 Then
		sb.Append(thisAttr)
	End If
	Dim thoseLoose As String = GetKeys(" ",LooseAttributes)
	sb.Append(" ").Append(thoseLoose)
	sb.Append(">")
	Return sb.tostring
End Sub

'get keys of a map
Sub GetKeys(Delim As String, m As Map) As String
	Dim sb As StringBuilder
	sb.Initialize 
	For Each strKey As String In m.Keys
		sb.Append(strKey).Append(Delim) 
	Next
	Dim sout As String = sb.ToString
	sout = RemDelim(sout,Delim)
	Return sout
End Sub

'get values of a map
Sub GetValues(Delim As String, m As Map) As String
	Dim sb As StringBuilder
	sb.Initialize 
	For Each strKey As String In m.values
		sb.Append(strKey).Append(Delim) 
	Next
	Dim sout As String = sb.ToString
	sout = RemDelim(sout,Delim)
	Return sout
End Sub


Sub BuildAttributes As String
	Dim sb As StringBuilder
	sb.Initialize 
	Dim kTot As Int = properties.Size - 1
	Dim kCnt As Int
	Dim strKey As String = properties.GetKeyAt(0)
	Dim strValue As String = properties.Get(strKey)
	If SingleQuote.IndexOf(strKey) = -1 Then
		sb.Append(ToProperty(strKey,strValue))
	Else
		sb.Append(ToSingleQuoteProperty(strKey,strValue))
	End If
	For kCnt = 1 To kTot
		strKey = properties.GetKeyAt(kCnt)
		strValue = properties.Get(strKey)
		sb.Append(" ")
		If SingleQuote.IndexOf(strKey) = -1 Then
			sb.Append(ToProperty(strKey,strValue))
		Else
			sb.Append(ToSingleQuoteProperty(strKey,strValue))
		End If
	Next
	Return sb.tostring
End Sub

'single quote property
private Sub ToSingleQuoteProperty(sName As String, svalue As String) As String
	Dim script As String = $"${sName}='${svalue}'"$
	script = script.Trim
	If script = "=''" Then 
		script = ""
	End If
	Return script
End Sub

'format the text
private Sub FormatText(sText As String) As String
	Dim RM As Map
	RM.Initialize
	RM.clear
	RM.Put("{U}", "<ins>")
	RM.Put("{/U}", "</ins>")
	RM.Put("¢","&cent;")
	RM.put("£","&pound;")
	RM.Put("{SUP}", "<sup>")
	RM.Put("{/SUP}", "</sup>")
	RM.Put("¥","&yen;")
	RM.Put("€","&euro;")
	RM.put("©","&copy;")
	RM.Put("®","&reg;")
	RM.Put("{POUND}","&pound;")
	RM.Put("{/B}", "</b>")
	RM.Put("{I}", "<i>")
	RM.Put("{YEN}","&yen;")
	RM.Put("{EURO}","&euro;")
	RM.Put("{CODE}","<code>")
	RM.Put("{/CODE}","</code>")
	RM.put("{COPYRIGHT}","&copy;")
	RM.Put("{REGISTERED}","&reg;")
	RM.Put("®", "&reg;")
	RM.Put("{B}", "<b>")
	RM.Put("{SMALL}", "<small>")
	RM.Put("{/SMALL}", "</small>")
	RM.Put("{EM}", "<em>")
	RM.Put("{/EM}", "</em>")
	RM.Put("{MARK}", "<mark>")
	RM.Put("{/MARK}", "</mark>")
	RM.Put("{/I}", "</i>")
	RM.Put("{SUB}", "<sub>")
	RM.Put("{/SUB}", "</sub>")
	RM.Put("{BR}", "<br/>")
	RM.Put("{WBR}","<wbr>")
	RM.Put("{STRONG}", "<strong>")
	RM.Put("{/STRONG}", "</strong>")
	RM.Put("{NBSP}", "&nbsp;")
	RM.Put("“","")
	RM.Put("”","")
	RM.Put("’","'")
	Dim kTot As Int = RM.Size - 1
	Dim kCnt As Int
	For kCnt = 0 To kTot
		Dim strValue As String = RM.GetKeyAt(kCnt)
		Dim strRep As String = RM.Get(strValue)
		sText = sText.Replace(strValue, strRep)
	Next
	Return sText
End Sub

'remove the delimiter from stringbuilder
private Sub RemDelim(sValue As String, Delim As String) As String
	Dim sw As Boolean = sValue.EndsWith(Delim)
	If sw Then
		Dim lDelim As Int = Delim.Length
		Dim nValue As String = sValue
		sw = nValue.EndsWith(Delim)
		If sw Then 
			nValue = nValue.SubString2(0, nValue.Length-lDelim)
		End If
		Return nValue
	Else
		Return sValue
	End If
End Sub

'set the style attribute
Sub AddStyle(prop As String, value As String) As UOENowHTML
	AddStyleAttribute(prop,value)
	Return Me
End Sub

'set a style property
Sub AddStyleAttribute(sprop As String, svalue As String) As UOENowHTML
	sprop = sprop.ToLowerCase
	sprop = sprop.Trim
	svalue = svalue.Trim
	'remove any colon
	sprop = RemDelim(sprop,":")
	'remove any semicolon
	svalue = RemDelim(svalue,";")
	sprop = sprop.Trim
	svalue = svalue.Trim
	If svalue.Length > 0 And sprop.Length > 0 Then
		'important has already been provided, dont include it
		If svalue.EndsWith("!important") = False Then
			If IsImportant Then
				svalue = svalue & " !important"
			End If
		End If
		'update the style map
		Styles.Put(sprop, svalue)
	End If
	Return Me
End Sub

'mvfield sub
private Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
	If sValue.Length = 0 Then Return ""
	Dim xPos As Int = sValue.IndexOf(Delimiter)
	If xPos = -1 Then Return sValue
	Dim mValues As List = StrParse(Delimiter,sValue)
	Dim tValues As Int
	tValues = mValues.size -1
	Select Case iPosition
		Case -1
			Return mValues.get(tValues)
		Case -2
			Return mValues.get(tValues - 1)
		Case -3
			Dim sb As StringBuilder
			sb.Initialize
			Dim startcnt As Int
			sb.Append(mValues.Get(1))
			For startcnt = 2 To tValues
				sb.Append(Delimiter)
				sb.Append(mValues.get(startcnt))
			Next
			Return sb.tostring
		Case Else
			iPosition = iPosition - 1
			If iPosition <= -1 Then 
				Return mValues.get(tValues)
			End If
			If iPosition > tValues Then 
				Return ""
			End If
			Return mValues.get(iPosition)
	End Select
End Sub

'add a class to the element
Sub AddClass(value As String) As UOENowHTML
	'add classes delimited by space
	value = value.Replace(" ",";")
	Dim spClasses As List = StrParse(";",value)
	For Each strClass As String In spClasses
		strClass = strClass.Trim
		If strClass.Length > 0 Then 
			classes.Put(strClass,strClass)
		End If
	Next
	Return Me
End Sub

'set attribute
public Sub AddAttribute(skey As String, svalue As String) As UOENowHTML
	skey = CStr(skey)
	svalue = CStr(svalue)
	skey = skey.Replace("undefined","")
	skey = skey.Replace("null","")
	svalue = svalue.Replace("undefined","")
	svalue = svalue.Replace("null","")
	skey = skey.trim
	svalue = svalue.trim
	If skey.Length > 0 And svalue.Length > 0 Then
		properties.Put(skey,svalue)
	Else
		properties.Remove(skey)
	End If
	Return Me
End Sub


' parse a string to a list
private Sub StrParse(Delim As String, InputString As String) As List
	Dim OutList As List
	Dim CommaLoc As Int
	OutList.Initialize
	OutList.clear
	CommaLoc=InputString.IndexOf(Delim)
	Do While CommaLoc >-1
		Dim LeftSide As String
		LeftSide= InputString.SubString2(0,CommaLoc)
		Dim RightSide As String 
		RightSide= InputString.SubString(CommaLoc+1)
		OutList.Add(LeftSide)
		InputString=RightSide
		CommaLoc=InputString.IndexOf(Delim)
	Loop
	OutList.Add(InputString)
	Return OutList
End Sub

'join list to a string
'private Sub Join(delimiter As String, lst As List) As String
'	Dim i As Int
'	Dim sb As StringBuilder
'	sb.Initialize
'	sb.Append(lst.get(0))
'	For i = 1 To lst.size - 1
'		sb.Append(delimiter).Append(lst.get(i))
'	Next
'	Return sb.ToString
'End Sub

'define the closure of the element
private Sub Close() As String
	Dim sb As StringBuilder
	sb.Initialize
	Select Case Tag.ToLowerCase
		Case "img", "link", "meta", "input", "source", "hr", "br"
			DoAProperClose = False
	End Select
	If DoAProperClose = True Then
		sb.Append("</")
		sb.Append(Tag)
		sb.Append(">")
	End If
	Return sb.tostring
End Sub

'get the attribute
Sub GetAttr(attr As String) As String
	attr = attr.tolowercase
	If properties.ContainsKey(attr) Then
		Return properties.Get(attr)
	Else
		Return ""
	End If
End Sub


'turn the element into html
public Sub ToString As String
	If ParentID <> "" Then
		ID = ParentID & ID
	End If
	Select Case Tag
		Case "img", "script"
			'to later check for broken links
			Dim imgURL As String = GetAttr("src")
			If imgURL.Length > 0 Then
				imgURL = imgURL.tolowercase
			End If
		Case "link"
			Dim lnk As String = GetAttr("href")
			If lnk.Length > 0 Then
				lnk = lnk.tolowercase
			End If
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(SBBefore)
	sb.Append(Open)
	For Each strContent As String In Contents
		If strContent.Length > 0 Then
			strContent = strContent.trim
			sb.Append(strContent.trim)
		End If
	Next
	sb.Append(Close)
	Dim sout As String = sb.ToString
	If DontBreak.IndexOf(Tag) <> -1 Then
		sout = sout.Replace(CRLF,"")
	End If
	'add any code To the page
	sout = sout & SBAfter.tostring
	sout = sout.Replace(CRLF,"")
	Return sout
End Sub

'add a hyperlink that sends an email
Sub AddMailTo(emailaddress As String,subject As String,caption As String) As UOENowHTML
	subject = subject.Replace(" ", "%20")
	Dim a As UOENowHTML
	a.Initialize("","a").setHREF($"mailto:${emailaddress}?subject=${subject}"$).AddContent(caption).SetTARGETblank(True)
	AddContent(a.ToString)
	Return Me
End Sub

Sub SetWarning(b As Boolean) As UOENowHTML
	AddClass("warning")
	Return Me
End Sub

Sub SetError(b As Boolean) As UOENowHTML
	AddClass("error")
	Return Me
End Sub

Sub SetMedia(b As Boolean) As UOENowHTML
	AddClass("media")
	Return Me
End Sub


Sub AddDiv(divid As String, divContent As String, divClass As String) As UOENowHTML
	Dim div As UOENowHTML
	div.Initialize(divid,"div").SetText(divContent).addclass(divClass)
	AddContent(div.HTML)
	Return Me
End Sub


'add a bold text
Sub AddBold(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{B}").Append(value).Append("{/B}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add italic text
Sub AddItalic(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{I}").Append(value).Append("{/I}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add underlined text
Sub AddUnderline(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{U}").Append(value).Append("{/U}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add subscript text
Sub AddSubScript(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUB}").Append(value).Append("{/SUB}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add superscript text
Sub AddSuperScript(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUP}").Append(value).Append("{/SUP}")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddSub(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sub>").Append(value).Append("</sub>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddKBD(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<kbd>").Append(value).Append("</kbd>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddCode(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<code>").Append(value).Append("</code>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddPre(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<pre>").Append(value).Append("</pre>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddSup(value As String) As UOENowHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sup>").Append(value).Append("</sup>")
	AddContent(sb.ToString)
	Return Me
End Sub


'add a break
Sub AddBreak(b As Boolean) As UOENowHTML
	AddContent("{BR}")
	Return Me
End Sub

'add a hyperlink that opens to blank
Sub AddLink(href As String,caption As String,Target As String) As UOENowHTML
	Dim a As UOENowHTML
	a.Initialize("","a").SetHREF(href).AddContent(caption).SetTARGET(Target)
	AddElement(a)
	Return Me
End Sub

Sub AddAnchor(href As String,caption As String,Target As String) As UOENowHTML
	AddLink(href,caption,Target)
	Return Me
End Sub


Sub AddH1(paraText As String) As UOENowHTML
	AddContent($"<h1>${paraText}</h1>"$)
	Return Me
End Sub

Sub AddH2(paraText As String) As UOENowHTML
	AddContent($"<h2>${paraText}</h2>"$)
	Return Me
End Sub

Sub AddH3(paraText As String) As UOENowHTML
	AddContent($"<h3>${paraText}</h3>"$)
	Return Me
End Sub

Sub AddH4(paraText As String) As UOENowHTML
	AddContent($"<h4>${paraText}</h4>"$)
	Return Me
End Sub

Sub AddStrong(paraText As String) As UOENowHTML
	AddContent($"<strong>${paraText}</strong>"$)
	Return Me
End Sub

Sub AddSmall(paraText As String) As UOENowHTML
	AddContent($"<small>${paraText}</small>"$)
	Return Me
End Sub

Sub AddEM(paraText As String) As UOENowHTML
	AddContent($"<em>${paraText}</em>"$)
	Return Me
End Sub


Sub AddH5(paraText As String) As UOENowHTML
	AddContent($"<h5>${paraText}</h5>"$)
	Return Me
End Sub

Sub AddH6(paraText As String) As UOENowHTML
	AddContent($"<h6>${paraText}</h6>"$)
	Return Me
End Sub