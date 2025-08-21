B4J=true
Group=BANano
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
	Private Classes As Map
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
	Private SBAfter As StringBuilder
	Private SBBefore As StringBuilder
	Public IsImportant As Boolean
	Private BANano As BANano   'ignore
	Private ParentID As String
End Sub


'add a list of classes to the element
Sub SetClasses(clsList As List) As BANanoHTML
	For Each c As String In clsList
		AddClass(c)
	Next
	Return Me
End Sub

'add a list of classes to the element
Sub AddClasses(clsList As List) As BANanoHTML
	For Each c As String In clsList
		AddClass(c)
	Next
	Return Me
End Sub

'set attributes from a map
Sub SetAttributes(m As Map) As BANanoHTML
	For Each k As String In m.Keys
		Dim v As String = m.Get(k)
		SetAttr(k,v)
	Next
	Return Me
End Sub

'set styles from a map
Sub SetStyles(m As Map) As BANanoHTML
	For Each k As String In m.Keys
		Dim v As String = m.Get(k)
		SetStyle(k,v)
	Next
	Return Me
End Sub

'add a span element
Sub SetSpan(sText As String) As BANanoHTML
	Dim s As BANanoHTML
	s = CreateSpan("").SetText(sText)
	AddElement(s)
	Return Me
End Sub


'set class
Sub SetClass(c As Object) As BANanoHTML   'ignore
	AddClass(c)
	Return Me
End Sub

'set section class
Sub SetClassSection(b As Boolean) As BANanoHTML   'ignore
	AddClass("section")
	Return Me
End Sub

'wrap element to
Sub Wrap(wid As String, wrapType As String) As BANanoHTML
	Dim p As BANanoHTML
	p.Initialize(wrapType).SetID(wid)
	p.AddContent(HTML)
	Return p 
End Sub

'set row
Sub SetClassRow(b As Boolean) As BANanoHTML   'ignore
	AddClass("row")
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As String, val As String) As BANanoHTML
	AddAttribute(attr,val)
	Return Me
End Sub

'set role button
Sub SetAttrRoleButton(b As Boolean) As BANanoHTML   'ignore
	SetAttrROLE("button")
	Return Me
End Sub

Sub SetStyleFontFamily(f As Object) As BANanoHTML   'ignore
	SetStyle("font-family", f)
	Return Me
End Sub


Sub SetStyleFontWeight(f As Object) As BANanoHTML   'ignore
	SetStyle("font-weight", f)
	Return Me
End Sub


Sub SetStyleFontWeightBold(f As Boolean) As BANanoHTML   'ignore
	SetStyle("font-weight", "bold")
	Return Me
End Sub

Sub SetStyleFontVariant(f As Object) As BANanoHTML   'ignore
	SetStyle("font-variant", f)
	Return Me
End Sub

Sub SetStyleFontWeightNormal(f As Boolean) As BANanoHTML   'ignore
	SetStyle("font-weight", "normal")
	Return Me
End Sub


Sub SetStyleFontStyle(f As Object) As BANanoHTML   'ignore
	SetStyle("font-style", f)
	Return Me
End Sub

Sub SetStyleFontSize(f As Object) As BANanoHTML   'ignore
	SetStyle("font-size", MakePx(f))
	Return Me
End Sub


Sub SetStyleTextAlignCenter(f As Boolean) As BANanoHTML   'ignore
	SetStyle("text-align", "center")
	Return Me
End Sub


Sub SetStyleTextIndent(f As Object) As BANanoHTML   'ignore
	SetStyle("text-indent", MakePx(f))
	Return Me
End Sub

Sub SetStyleTextTransform(f As Object) As BANanoHTML   'ignore
	SetStyle("text-transform", f)
	Return Me
End Sub

Sub SetStyleLetterSpacing(f As Object) As BANanoHTML   'ignore
	SetStyle("letter-spacing", MakePx(f))
	Return Me
End Sub

Sub SetStyleTextDecoration(f As Object) As BANanoHTML   'ignore
	SetStyle("text-decoration", f)
	Return Me
End Sub

Sub SetStyleTextShadow(f As Object) As BANanoHTML   'ignore
	SetStyle("text-shadow", f)
	Return Me
End Sub

Sub SetStyleLineHeight(f As Object) As BANanoHTML   'ignore
	SetStyle("line-height", f)
	Return Me
End Sub


Sub SetStyleWhiteSpace(f As Object) As BANanoHTML   'ignore
	SetStyle("white-space", f)
	Return Me
End Sub

Sub SetStyleVerticalAlign(f As Object) As BANanoHTML   'ignore
	SetStyle("vertical-align", f)
	Return Me
End Sub

Sub SetStyleDirection(f As Object) As BANanoHTML   'ignore
	SetStyle("direction", f)
	Return Me
End Sub

Sub SetStyleWordSpacing(f As Object) As BANanoHTML   'ignore
	SetStyle("word-spacing", MakePx(f))
	Return Me
End Sub


'set disabled
Sub SetAttrDisabled(b As Boolean) As BANanoHTML
	If b Then AddLooseAttribute("disabled")
	Return Me
End Sub

'set background color
Sub SetStyleBackgroundColor(c As Object) As BANanoHTML
	SetStyle("background-color",c)
	Return Me
End Sub


'set background color
Sub SetStyleBackgroundClip(c As Object) As BANanoHTML
	SetStyle("background-clip",c)
	Return Me
End Sub


'set background color
Sub SetStyleBackgroundOrigin(c As Object) As BANanoHTML
	SetStyle("background-origin",c)
	Return Me
End Sub

'set the border radius
Sub SetStyleBorderRadius(topLeft As String, topRight As String, bottomLeft As String, bottomRight As String) As BANanoHTML
	Dim br As List
	br.Initialize
	br.Add(MakePx(topLeft))
	br.Add(MakePx(topRight))
	br.Add(MakePx(bottomLeft))
	br.Add(MakePx(bottomRight))
	'
	Dim sbr As String = Join(" ", br)
	SetStyle("border-radius", sbr)
	Return Me
End Sub

'set border top left radius
Sub SetStyleBorderTopLeftRadius(topLeft As String) As BANanoHTML
	topLeft = MakePx(topLeft)
	SetStyle("border-top-left-radius", topLeft)
	Return Me
End Sub

Sub SetStyleBorderTopRightRadius(topRight As String) As BANanoHTML
	topRight = MakePx(topRight)
	SetStyle("border-top-right-radius", topRight)
	Return Me
End Sub

Sub SetStyleBorderBottomLeftRadius(bottomLeft As String) As BANanoHTML
	bottomLeft = MakePx(bottomLeft)
	SetStyle("border-bottom-left-radius", bottomLeft)
	Return Me
End Sub

Sub SetStyleBorderBottomRightRadius(bottomRight As String) As BANanoHTML
	bottomRight = MakePx(bottomRight)
	SetStyle("border-bottom-right-radius", bottomRight)
	Return Me
End Sub

Sub SetStyleColor(c As Object) As BANanoHTML
	SetStyle("color",c)
	Return Me
End Sub

Sub SetStyleOutline(c As Object) As BANanoHTML
	SetStyle("outline",c)
	Return Me
End Sub

Sub SetStyleOutlineStyle(bs As Object) As BANanoHTML
	SetStyle("outline-style",bs)
	Return Me
End Sub


Sub SetStyleOutlineColor(bs As Object) As BANanoHTML
	SetStyle("outline-color",bs)
	Return Me
End Sub

Sub SetStyleOutlineWidth(bs As Object) As BANanoHTML
	SetStyle("outline-width",MakePx(bs))
	Return Me
End Sub


Sub SetStyleBorderStyle(bs As Object) As BANanoHTML
	SetStyle("border-style",bs)
	Return Me
End Sub

Sub SetStyleBorderStyleDotted(b As Boolean) As BANanoHTML
	SetStyle("border-style","dotted")
	Return Me
End Sub

Sub SetStyleBorderStyleDashed(b As Boolean) As BANanoHTML
	SetStyle("border-style","dashed")
	Return Me
End Sub

Sub SetStyleBorderStyleSolid(b As Boolean) As BANanoHTML
	SetStyle("border-style","solid")
	Return Me
End Sub

Sub SetStyleBorderStyleDouble(b As Boolean) As BANanoHTML
	SetStyle("border-style","double")
	Return Me
End Sub

Sub SetStyleBorderWidth(b As String) As BANanoHTML
	SetStyle("border-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderLeftWidth(b As String) As BANanoHTML
	SetStyle("border-left-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderRightWidth(b As String) As BANanoHTML
	SetStyle("border-right-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderBottomWidth(b As String) As BANanoHTML
	SetStyle("border-bottom-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderTopWidth(b As String) As BANanoHTML
	SetStyle("border-top-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderColor(c As String) As BANanoHTML
	SetStyle("border-color",c)
	Return Me
End Sub

Sub SetStyleBorderLeftColor(c As String) As BANanoHTML
	SetStyle("border-left-color",c)
	Return Me
End Sub


Sub SetStyleBorderRightColor(c As String) As BANanoHTML
	SetStyle("border-right-color",c)
	Return Me
End Sub

Sub SetStyleBorderTopColor(c As String) As BANanoHTML
	SetStyle("border-top-color",c)
	Return Me
End Sub


Sub SetStyleBorderBottomColor(c As String) As BANanoHTML
	SetStyle("border-bottom-color",c)
	Return Me
End Sub

Sub SetStyleBorderLeftStyle(c As String) As BANanoHTML
	SetStyle("border-left-style",c)
	Return Me
End Sub

Sub SetStyleBorderRightStyle(c As String) As BANanoHTML
	SetStyle("border-right-style",c)
	Return Me
End Sub

Sub SetStyleBorderBottomStyle(c As String) As BANanoHTML
	SetStyle("border-bottom-style",c)
	Return Me
End Sub

Sub SetStyleBorderTopStyle(c As String) As BANanoHTML
	SetStyle("border-top-style",c)
	Return Me
End Sub

Sub SetStyleBorderStyleGroove(b As Boolean) As BANanoHTML
	SetStyle("border-style","groove")
	Return Me
End Sub

Sub SetStyleBorderStyleRidge(b As Boolean) As BANanoHTML
	SetStyle("border-style","ridge")
	Return Me
End Sub

Sub SetStyleBorderStyleInset(b As Boolean) As BANanoHTML
	SetStyle("border-style","inset")
	Return Me
End Sub

Sub SetStyleBorderStyleOutset(b As Boolean) As BANanoHTML
	SetStyle("border-style","outset")
	Return Me
End Sub

Sub SetStyleBorderStyleNone(b As Boolean) As BANanoHTML
	SetStyle("border-style","none")
	Return Me
End Sub

Sub SetStyleBorderStyleHidden(b As Boolean) As BANanoHTML
	SetStyle("border-style","hidden")
	Return Me
End Sub

Sub SetStyleImportant(b As Boolean) As BANanoHTML
	IsImportant = b
	Return Me
End Sub

'set style
Sub SetStyle(prop As String, val As String) As BANanoHTML
	AddStyleAttribute(prop,val)
	Return Me
End Sub

'set width
Sub SetAttrWidth(w As Object) As BANanoHTML
	AddAttribute("width", w)
	Return Me
End Sub

'set width
Sub SetAttrCSS(w As Object) As BANanoHTML
	AddAttribute("css", w)
	Return Me
End Sub

'set height
Sub SetAttrHeight(h As String) As BANanoHTML
	AddAttribute("height", h)
	Return Me
End Sub

'set the padding style
Sub SetStylePadding(PaddingBottom As String) As BANanoHTML
	SetStyle("padding", MakePx(PaddingBottom))
	Return Me
End Sub

'set the padding bottom style
Sub SetStylePaddingBottom(PaddingBottom As String) As BANanoHTML
	SetStyle("padding-bottom", MakePx(PaddingBottom))
	Return Me
End Sub

'set the padding right style
Sub SetStylePaddingRight(PaddingRight As String) As BANanoHTML
	SetStyle("padding-right", MakePx(PaddingRight))
	Return Me
End Sub

'set the padding left style
Sub SetStylePaddingLeft(PaddingLeft As String) As BANanoHTML
	SetStyle("padding-left", MakePx(PaddingLeft))
	Return Me
End Sub

'set the padding top style	
Sub SetStylePaddingTop(PaddingTop As String) As BANanoHTML
	SetStyle("padding-top", MakePx(PaddingTop))
	Return Me
End Sub

'set the background image style
Sub SetStyleBackgroundImage(imgURL As String) As BANanoHTML
	SetStyle("background-image", $"url('${imgURL}')"$)
	Return Me
End Sub

'set the background repeat style
Sub SetStyleBackgroundRepeat(r As String) As BANanoHTML
	SetStyle("background-repeat", r)
	Return Me
End Sub

'set the background size style
Sub SetStyleBackgroundSize(r As String) As BANanoHTML
	SetStyle("background-size", r)
	Return Me
End Sub


'set the background attachment style
Sub SetStyleBackgroundAttachment(r As String) As BANanoHTML
	SetStyle("background-attachment", r)
	Return Me
End Sub


'set the background position style
Sub SetStyleBackgroundPosition(r As String) As BANanoHTML
	SetStyle("background-position", r)
	Return Me
End Sub


'set the margin style
Sub SetStyleMargin(MarginBottom As String) As BANanoHTML
	SetStyle("margin", MakePx(MarginBottom))
	Return Me
End Sub

'set margin bottom style
Sub SetStyleMarginBottom(MarginBottom As String) As BANanoHTML
	SetStyle("margin-bottom", MakePx(MarginBottom))
	Return Me
End Sub

'set the margin right style
Sub SetStyleMarginRight(MarginRight As String) As BANanoHTML
	SetStyle("margin-right", MakePx(MarginRight))
	Return Me
End Sub

'set margin left style
Sub SetStyleMarginLeft(MarginLeft As String) As BANanoHTML
	SetStyle("margin-left", MakePx(MarginLeft))
	Return Me
End Sub

'set margin top style	
Sub SetStyleMarginTop(MarginTop As String) As BANanoHTML
	SetStyle("margin-top", MakePx(MarginTop))
	Return Me
End Sub

Sub UseTheme(sPrefix As String, themeName As String) As BANanoHTML
	If themeName = "" Then Return Me
	themeName = themeName.tolowercase
	If sPrefix <> "" And themeName <> "" Then
		AddClass($"${sPrefix}-${themeName}"$)
	End If
	Return Me
End Sub

'set attribute
Sub AddAttributeIfSet(prop As String, value As String) As BANanoHTML
	If value <> "" Then
		AddAttribute(prop,value)
	End If
	Return Me
End Sub

'set placeholder attribute
Sub SetAttrPlaceHolder(sPlaceholder As String) As BANanoHTML
	AddAttribute("placeholder",sPlaceholder)
	Return Me
End Sub

'set title attribute
Sub SetAttrTITLE(stitle As String) As BANanoHTML
	AddAttribute("title", stitle)
	Return Me
End Sub

'set action attribute
Sub SetAttrACTION(stitle As String) As BANanoHTML
	AddAttribute("action", stitle)
	Return Me
End Sub

'set autocomplete attribute
Sub SetAttrAUTOCOMPLETE(b As Boolean) As BANanoHTML
	If b Then
		AddAttribute("autocomplete", "on")
	End If
	Return Me
End Sub

'set autofocus attribute
Sub SetAttrAUTOFOCUS(b As Boolean) As BANanoHTML
	If b Then AddLooseAttribute("autofocus")
	Return Me
End Sub


'set rel attribute
Sub SetAttrREL(rel As String) As BANanoHTML
	AddAttribute("rel", rel)
	Return Me
End Sub

'clear text contents
Sub Clear As BANanoHTML
	Contents.clear
	Return Me
End Sub

'set attr on condition
Sub AddPropertyOnCondition(bCondition As Boolean, attr As String, value As String) As BANanoHTML
	If bCondition Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub

'set attribute
Public Sub AddProperty(sKey As String, sValue As String) As BANanoHTML
	AddAttribute(sKey, sValue)
	Return Me
End Sub

'set target attribute
Sub SetAttrTARGET(sValue As String) As BANanoHTML
	If sValue.Trim = "" Then Return Me
	AddAttribute("target",sValue)
	Return Me
End Sub

Sub SetAttrTargetBlank(b As Boolean) As BANanoHTML   'ignore
	SetAttrTARGET("_blank")
	Return Me
End Sub

Sub SetAttrTargetSelf(b As Boolean) As BANanoHTML    'ignore
	SetAttrTARGET("_self")
	Return Me
End Sub
	
Sub SetAttrTargetParent(b As Boolean) As BANanoHTML   'ignore
	SetAttrTARGET("_parent")
	Return Me
End Sub
	
Sub SetAttrTargetTop(b As Boolean) As BANanoHTML    'ignore
	SetAttrTARGET("_top")
	Return Me
End Sub

Sub ApplyStyle(sStyle As String) As BANanoHTML
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
			SetStyle(attr,val)
		End If
	Next
	Return Me
End Sub

Sub SetClassCenter As BANanoHTML
	AddClass("center")
	Return Me
End Sub

Sub GetStyleAttr(attr As String) As String
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
public Sub SetContents(value As String) As BANanoHTML
	Contents.Initialize
	Contents.clear
	If value.Length > 0 Then
		AddContent(value)
	End If
	Return Me
End Sub

public Sub AddElementLine(el As BANanoHTML) As BANanoHTML
	If el <> Null Then
		Dim scode As String = el.html
		AddContent(scode)
	End If
	Return Me
End Sub


Sub SetAttrROLE(sValue As String) As BANanoHTML
	AddAttribute("role",sValue)
	Return Me
End Sub

Sub SetAttrMETHOD(sValue As String) As BANanoHTML
	AddAttribute("method",sValue)
	Return Me
End Sub

'add content to the element
public Sub AddContentLine(value As String) As BANanoHTML
	If value <> "" Then
		value = value.Replace(CRLF,"")
		AddContent(value)
	End If
	Return Me
End Sub

Sub SetAttrTypeNumbers() As BANanoHTML
	AddAttribute("type","1")
	Return Me
End Sub

Sub SetAttrTypeUpperCase() As BANanoHTML
	AddAttribute("type","A")
	Return Me
End Sub

Sub SetAttrTypeLowerCase() As BANanoHTML
	AddAttribute("type","a")
	Return Me
End Sub

Sub SetAttrTypeUpperCaseRoman() As BANanoHTML
	AddAttribute("type","I")
	Return Me
End Sub

Sub SetAttrTypeLowerCaseRoman() As BANanoHTML
	AddAttribute("type","i")
	Return Me
End Sub


Sub SetStyleListStyleCircle() As BANanoHTML
	SetStyle("list-style-type","circle")
	Return Me
End Sub

Sub SetStyleListStyleDisk() As BANanoHTML
	SetStyle("list-style-type","disk")
	Return Me
End Sub

Sub SetStyleListStyleNone() As BANanoHTML
	SetStyle("list-style-type","none")
	Return Me
End Sub

Sub SetStyleListStyleSquare() As BANanoHTML
	SetStyle("list-style-type","square")
	Return Me
End Sub

Sub AddHeading(sSize As Int, sContent As String) As BANanoHTML
	Dim hdr As BANanoHTML
	Dim hKey As String = "h" & sSize
	hdr.Initialize(hKey)
	hdr.AddContent(sContent)
	AddContent(hdr.HTML)
	Return Me
End Sub

Sub AppendParagraph(sContent As String) As BANanoHTML
	Dim p As BANanoHTML
	p.Initialize("p")
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

Sub AddMark(sContent As String, sclass As String) As BANanoHTML
	Dim p As BANanoHTML
	p.Initialize("mark").AddClass(sclass)
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttributeOnFalseCondition(bStatus As Boolean, value As String) As BANanoHTML
	If bStatus = False Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'change the element type
Sub SetElementTypeOnCondition(bStatus As Boolean,sElementType As String) As BANanoHTML
	If bStatus Then
		Tag = sElementType
	End If
	Return Me
End Sub


Sub SetStyleZIndex(zindex As String) As BANanoHTML
	SetStyle("z-index",zindex)
	Return Me
End Sub

Sub AddContentListReverse(lst As List) As BANanoHTML
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = lTot To 0 Step -1
		Dim strContent As String = lst.Get(lCnt)
		AddContent(strContent)
	Next
	Return Me
End Sub


Sub SetAttrFOR(sFor As String) As BANanoHTML
	AddAttribute("for",sFor)
	Return Me
End Sub


Sub SetAttrVALUE(sValue As String) As BANanoHTML
	AddAttribute("value",sValue)
	Return Me
End Sub


Sub SetAttrNAME(sName As String) As BANanoHTML
	AddAttribute("name",sName)
	Return Me
End Sub

Sub SetAttrSUMMARY(sName As String) As BANanoHTML
	AddAttribute("summary",sName)
	Return Me
End Sub


Sub SetCOLSPAN(sName As String) As BANanoHTML
	AddAttribute("colspan",sName)
	Return Me
End Sub


Sub SetAttrLabel(l As String) As BANanoHTML
	AddAttribute("label",l)
	Return Me
End Sub


Sub SetAttrRows(l As String) As BANanoHTML
	AddAttribute("rows",l)
	Return Me
End Sub


Sub SetAttrCols(l As String) As BANanoHTML
	AddAttribute("cols",l)
	Return Me
End Sub


Sub SetAttrROWSPAN(sName As String) As BANanoHTML
	AddAttribute("rowspan",sName)
	Return Me
End Sub

Sub SetAttrTYPE(sValue As String) As BANanoHTML
	AddAttribute("type",sValue)
	Return Me
End Sub


Sub UpdateAttribute(name As String, propValue As String) As BANanoHTML
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
Sub AddLooseAttributeOnCondition(bStatus As Boolean, value As String) As BANanoHTML
	If bStatus = True Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttribute(value As String) As BANanoHTML
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


Sub AddDataAttribute(attribute As String, value As String) As BANanoHTML
	Dim sw As Boolean = attribute.StartsWith("data-")
	If sw Then
		AddAttribute(attribute,value)
	Else
		AddAttribute("data-" & attribute,value)
	End If
	Return Me
End Sub

Sub AddDataAttributeOnCondition(bCondition As Boolean,attribute As String, value As String) As BANanoHTML
	If bCondition = False Then 
		Return Me
	End If
	AddDataAttribute(attribute,value)
	Return Me
End Sub

Sub AddStyleOnCondition(bCondition As Boolean,attribute As String, value As String) As BANanoHTML
	If bCondition = False Then 
		Return Me
	End If
	AddStyle(attribute,value)
	Return Me
End Sub


Sub SetAttrSRC(sValue As String, Static As Boolean) As BANanoHTML
	Dim tmpFile As String = MvField(sValue,1,"?")
	If Static Then
		sValue = tmpFile
	Else
		sValue = tmpFile & "?" & DateTime.now
	End If
	AddAttribute("src",sValue)
	Return Me
End Sub


Sub SetAttrALT(sValue As String) As BANanoHTML
	AddAttribute("alt",sValue)
	Return Me
End Sub

Sub SetStyleWidth(Width As String) As BANanoHTML
	If Width <> "" Then
		SetStyle("width", MakePx(Width))
	End If
	Return Me
End Sub


Sub SetStyleHeight(Height As String) As BANanoHTML
	If Height <> "" Then
		SetStyle("height", MakePx(Height))
	End If
	Return Me
End Sub

Sub AddStyleAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As BANanoHTML
	If bCondition = True Then
		SetStyle(attr,value)
	End If
	Return Me
End Sub

Sub AddAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As BANanoHTML
	If bCondition = True Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub

Sub GetAttr(attr As String) As String
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
		Return Classes.ContainsKey(value)
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

Sub AddCursor As BANanoHTML
	SetStyle("cursor", "pointer")
	Return Me
End Sub

Sub SetAttrHREF(value As String) As BANanoHTML
	AddAttribute("href",value)
	Return Me
End Sub

Sub AddClassOnValue(iValue As Int, sClass As String) As BANanoHTML
	If iValue > 0 Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnCondition(bCondition As Boolean, sClass As String) As BANanoHTML
	If bCondition  Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnFalseCondition(bCondition As Boolean, sClass As String) As BANanoHTML
	If bCondition = False Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub RemoveClassOnCondition(bCondition As Boolean, sClass As String) As BANanoHTML
	If bCondition Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


Sub RemoveClassOnFalseCondition(bCondition As Boolean, sClass As String) As BANanoHTML
	If bCondition = False Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


'add a list of elements
Sub AddContentList(lst As List) As BANanoHTML
	For Each strContent As String In lst
		AddContent(strContent)
	Next
	Return Me
End Sub

'set the text of the element, in most cases you will use AddContent
Sub SetText(sText As String) As BANanoHTML
	AddContent(sText)
	Return Me
End Sub

Sub SetCode(sText As String) As BANanoHTML
	Dim s As BANanoHTML
	s = CreateCode("").SetText(sText)
	AddElement(s)
	Return Me
End Sub


Sub AddText(txt As String) As BANanoHTML
	AddContent(txt)
	Return Me
End Sub

'set prefix
Sub SetPrefix(sPrefix As String) As BANanoHTML
	Prefix = sPrefix
	Return Me
End Sub

'set id
Sub SetID(sID As String) As BANanoHTML
	sID = sID.tolowercase
	ID = sID
	Return Me
End Sub

'set the tag, this updates the tab
Sub SetTag(sTag As String) As BANanoHTML
	Tag = sTag
	Return Me
End Sub

'set read only
Sub SetReadOnly(bReadOnly As Boolean) As BANanoHTML
	ReadOnly = bReadOnly
	Return Me
End Sub

'set max
Sub SetAttrMax(m As Object) As BANanoHTML
	SetAttr("max", m)
	Return Me
End Sub


'set min
Sub SetAttrMin(m As Object) As BANanoHTML
	SetAttr("min", MakePx(m))
	Return Me
End Sub


'set min width
Sub SetAttrMinWidth(m As Object) As BANanoHTML
	SetAttr("min-width", MakePx(m))
	Return Me
End Sub


'set min height
Sub SetAttrMinHeight(m As Object) As BANanoHTML
	SetAttr("min-height", MakePx(m))
	Return Me
End Sub


'set max width
Sub SetAttrMaxWidth(m As Object) As BANanoHTML
	SetAttr("max-width", MakePx(m))
	Return Me
End Sub


'set max height
Sub SetAttrMaxHeight(m As Object) As BANanoHTML
	SetAttr("mnax-height", MakePx(m))
	Return Me
End Sub


'set inline
Sub SetInline(bInline As Boolean) As BANanoHTML
	Inline = bInline
	Return Me
End Sub

'set enabled
Sub SetEnabled(bEnabled As Boolean) As BANanoHTML
	Enabled = bEnabled
	Return Me
End Sub

'set required
Sub SetRequired(bRequired As Boolean) As BANanoHTML
	Required = bRequired
	Return Me
End Sub

'Initializes the html builder
Public Sub Initialize(elID As String) As BANanoHTML
	ParentID = ""
	ID = ""
	IsImportant = True
	SBBefore.Initialize 
	SBAfter.Initialize 
	properties.Initialize
	properties.clear
	Contents.Initialize
	Contents.clear
	Styles.Initialize
	Styles.clear
	Classes.Initialize
	Classes.clear
	LooseAttributes.Initialize
	LooseAttributes.clear
	DontBreak.Initialize
	DontBreak.clear
	DontBreak.Add("li")
	DontBreak.Add("a")
	DontBreak.Add("i")
	DontBreak.Add("span")
	DontBreak.Add("img")
	Tag = elID
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
	If elID = "pre" Then
		AddClass("code-line")
	End If
	Return Me
End Sub

'add as a child element
Sub Pop(pElement As BANanoHTML)
	pElement.AddElement(Me)
End Sub

'remove a data attribute
public Sub RemoveAttrData(sData As String) As BANanoHTML
	sData = $"data-${sData}"$
	RemoveAttr(sData)
	Return Me
End Sub

Sub RemoveAttributeOnCondition(bCondition As Boolean, prop As String) As BANanoHTML
	If bCondition Then
		RemoveAttr(prop)
	End If
	Return Me
End Sub

'remove attribute
Sub RemoveAttribute(prop As String) As BANanoHTML
	RemoveAttr(prop)
	Return Me	
End Sub

'remove an attribute from the ones set
public Sub RemoveAttr(sName As String) As BANanoHTML
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
public Sub RemoveStyle(styleName As String) As BANanoHTML
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
Sub SetAttrLoose(value As String) As BANanoHTML
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
Sub SetAttrData(prop As String, value As String) As BANanoHTML
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
public Sub AddContent(value As String) As BANanoHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		Contents.Add(value)
	End If
	Return Me
End Sub

'add content to the element after closure 
public Sub AddContentAfter(value As String) As BANanoHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBAfter.Append(value)
	End If
	Return Me
End Sub

'add content to the element before open 
public Sub AddContentBefore(value As String) As BANanoHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBBefore.Append(value)
	End If
	Return Me
End Sub


'remove a class
public Sub removeClass(className As String) As BANanoHTML
	className = className.Trim
	className = className.replace(" ",";")
	Dim sItems As List = StrParse(";",className)
	For Each strStyle As String In sItems
		strStyle = strStyle.Trim
		If Classes.ContainsKey(strStyle) Then 
			Classes.Remove(strStyle)
		End If
	Next
	Return Me
End Sub

'add an element
public Sub AddElement(el As BANanoHTML) As BANanoHTML
	If el <> Null Then
		Dim scode As String = el.tostring
		AddContent(scode)
	End If
	Return Me
End Sub

'add elements
Sub AddElements(lst As List) As BANanoHTML
	For Each el As BANanoHTML In lst
		AddElement(el)
	Next
	Return Me
End Sub

'build the class attribute
Sub BuildClass() As String
	Dim sb As StringBuilder
	sb.Initialize
	Dim kTot As Int = Classes.Size - 1
	Dim kCnt As Int
	Dim strClass As String  = Classes.GetKeyAt(0)
	sb.Append(strClass)
	For kCnt = 1 To kTot
		Dim strClass As String  = Classes.GetKeyAt(kCnt)
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
Sub AddStyle(prop As String, value As String) As BANanoHTML
	AddStyleAttribute(prop,value)
	Return Me
End Sub

'set a style property
Sub AddStyleAttribute(sprop As String, svalue As String) As BANanoHTML
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
Sub AddClass(value As String) As BANanoHTML
	'add classes delimited by space
	value = value.Replace(" ",";")
	Dim spClasses As List = StrParse(";",value)
	For Each strClass As String In spClasses
		strClass = strClass.Trim
		If strClass.Length > 0 Then 
			Classes.Put(strClass,strClass)
		End If
	Next
	Return Me
End Sub

'set attribute
public Sub AddAttribute(skey As String, svalue As String) As BANanoHTML
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
private Sub Join(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(lst.get(0))
	For i = 1 To lst.size - 1
		sb.Append(delimiter).Append(lst.get(i))
	Next
	Return sb.ToString
End Sub

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

'set parent id
Sub SetParentID(sParentID As String) As BANanoHTML
	ParentID = sParentID
	Return Me
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
Sub AddMailTo(emailaddress As String,subject As String,caption As String) As BANanoHTML
	subject = subject.Replace(" ", "%20")
	Dim a As BANanoHTML
	a.Initialize("a").setAttrHREF($"mailto:${emailaddress}?subject=${subject}"$).AddContent(caption).SetAttrTARGETblank(True)
	AddContent(a.ToString)
	Return Me
End Sub

Sub AddDiv(divid As String, divContent As String, divClass As String) As BANanoHTML
	Dim div As BANanoHTML
	div.Initialize("div").SetID(divid).SetText(divContent).addclass(divClass)
	AddContent(div.HTML)
	Return Me
End Sub


'add a bold text
Sub AddBold(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{B}").Append(value).Append("{/B}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add italic text
Sub AddItalic(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{I}").Append(value).Append("{/I}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add underlined text
Sub AddUnderline(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{U}").Append(value).Append("{/U}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add subscript text
Sub AddSubScript(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUB}").Append(value).Append("{/SUB}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add superscript text
Sub AddSuperScript(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUP}").Append(value).Append("{/SUP}")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddSub(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sub>").Append(value).Append("</sub>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddKBD(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<kbd>").Append(value).Append("</kbd>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddCode(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<code>").Append(value).Append("</code>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddPre(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<pre>").Append(value).Append("</pre>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddSup(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sup>").Append(value).Append("</sup>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddCite(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<cite>").Append(value).Append("</cite>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddEM(value As String) As BANanoHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<em>").Append(value).Append("</em>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddStrong(value As String) As BANanoHTML
	Dim s As BANanoHTML
	s = CreateStrong("").SetText(value)
	AddElement(s)
	Return Me
End Sub


'add a break
Sub AddBreak(b As Boolean) As BANanoHTML  'ignore
	AddContent("{BR}")
	Return Me
End Sub

'add a hyperlink that opens to blank
Sub AddLink(href As String,caption As String,Target As String) As BANanoHTML
	Dim a As BANanoHTML
	a.Initialize("a").SetAttrHREF(href).AddContent(caption).SetAttrTARGET(Target)
	AddElement(a)
	Return Me
End Sub

Sub AddAnchor(href As String,caption As String,Target As String) As BANanoHTML
	AddLink(href,caption,Target)
	Return Me
End Sub


Sub AppendH1(paraText As String) As BANanoHTML
	AddContent($"<h1>${paraText}</h1>"$)
	Return Me
End Sub

Sub AppendH2(paraText As String) As BANanoHTML
	AddContent($"<h2>${paraText}</h2>"$)
	Return Me
End Sub

Sub AppendH3(paraText As String) As BANanoHTML
	AddContent($"<h3>${paraText}</h3>"$)
	Return Me
End Sub

Sub AppendH4(paraText As String) As BANanoHTML
	AddContent($"<h4>${paraText}</h4>"$)
	Return Me
End Sub

Sub AppendSmall(paraText As String) As BANanoHTML
	AddContent($"<small>${paraText}</small>"$)
	Return Me
End Sub

Sub AppendH5(paraText As String) As BANanoHTML
	AddContent($"<h5>${paraText}</h5>"$)
	Return Me
End Sub

Sub AppendH6(paraText As String) As BANanoHTML
	AddContent($"<h6>${paraText}</h6>"$)
	Return Me
End Sub

'create input search
Sub CreateInputSearch(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("input").SetAttrTYPE("search").SetID(sid)
	Return s
End Sub

'create input range
Sub CreateInputRange(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("input").SetAttrTYPE("range").SetID(sid)
	Return s
End Sub


'create main
Sub CreateMain(mainid As String) As BANanoHTML
	Dim m As BANanoHTML
	m.Initialize("main").SetID(mainid)
	Return m
End Sub


'create progress bar
Sub CreateProgressBar(pbid As String) As BANanoHTML
	Dim pb As BANanoHTML
	pb.Initialize("progress").SetID(pbid)
	Return pb
End Sub


'create footer
Sub CreateFooter(fid As String) As BANanoHTML
	Dim f As BANanoHTML
	f.Initialize("footer").SetID(fid)
	Return f
End Sub

'create nav
Sub CreateNav(nid As String) As BANanoHTML
	Dim n As BANanoHTML
	n.Initialize("nav").SetID(nid)
	Return n
End Sub

'create datalist
Sub CreateDataList(nid As String) As BANanoHTML
	Dim n As BANanoHTML
	n.Initialize("datalist").SetID(nid)
	Return n
End Sub

'create header
Sub CreateHeader(hid As String) As BANanoHTML
	Dim h As BANanoHTML
	h.Initialize("header").SetID(hid)
	Return h
End Sub

'create section
Sub CreateSection(sid As String) As BANanoHTML
	Dim s As BANanoHTML = CreateDIV(sid)
	s.AddClass("section")
	Return s
End Sub


'create a div
Sub CreateDIV(did As String) As BANanoHTML
	Dim div As BANanoHTML
	div.Initialize("div").SetID(did)
	Return div
End Sub

'create block quote
Sub CreateBlockQuote(bqid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("blockquote").SetID(bqid)
	Return ul
End Sub

Sub SetCite(c As Object) As BANanoHTML
	AddAttribute("cite", c)
	Return Me
End Sub

'create pre
Sub CreatePRE(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("pre").AddClass("code-line").SetID(preid)
	Return ul
End Sub

Sub CreateMARK(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("mark").SetID(preid)
	Return ul
End Sub


Sub CreateTIME(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("time").SetID(preid)
	Return ul
End Sub


Sub CreateDL(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("dl").SetID(preid)
	Return ul
End Sub

Sub CreateDT(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("dt").SetID(preid)
	Return ul
End Sub

Sub CreateDD(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("dd").SetID(preid)
	Return ul
End Sub

Sub CreateOL(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("ol").SetID(preid)
	Return ul
End Sub

Sub CreateUL(preid As String) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("ul").SetID(preid)
	Return ul
End Sub


'create OL
Sub CreateOL1(ulid As String, items As List) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("ol").SetID(ulid)
	For Each opt As Map In items
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		Dim thisoption As BANanoHTML = CreateLI("")
		optid = CStr(optid)
		optval = CStr(optval)
		thisoption.SetText(optval)
		thisoption.SetAttrVALUE(optid)
		ul.AddElement(thisoption)
	Next
	Return ul
End Sub

'create UL
Sub CreateUL1(ulid As String, items As List) As BANanoHTML
	Dim ul As BANanoHTML
	ul.Initialize("ul").SetID(ulid)
	For Each opt As Map In items
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		optid = CStr(optid)
		optval = CStr(optval)
		Dim thisoption As BANanoHTML = CreateLI(optid)
		thisoption.SetText(optval)
		ul.AddElement(thisoption)
	Next
	Return ul
End Sub

'create li
Sub CreateLI(liid As String) As BANanoHTML
	Dim li As BANanoHTML
	li.Initialize("li").SetID(liid)
	Return li
End Sub

'create image
Sub CreateIMG(imgid As String) As BANanoHTML
	Dim img As BANanoHTML
	img.Initialize("img").SetID(imgid)
	Return img
End Sub

'create figcaption
Sub CreateFigCaption(fid As String) As BANanoHTML
	Dim f As BANanoHTML
	f.Initialize("figcaption").SetID(fid)
	Return f
End Sub


'create figure
Sub CreateFigure(fid As String) As BANanoHTML
	Dim f As BANanoHTML
	f.Initialize("figure").SetID(fid)
	Return f
End Sub

'create h
Sub CreateH(hid As String, size As Int) As BANanoHTML
	Dim hkey As String = "h" & CStr(size)
	Dim h As BANanoHTML
	h.Initialize(hkey).SetID(hid)
	Return h
End Sub


'create h1
Sub CreateH1(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,1)
	Return hdr
End Sub

'create h2
Sub CreateH2(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,2)
	Return hdr
End Sub

'create h3
Sub CreateH3(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,3)
	Return hdr
End Sub

'create h4
Sub CreateH4(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,4)
	Return hdr
End Sub

'create h5
Sub CreateH5(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,5)
	Return hdr
End Sub

'create h6
Sub CreateH6(hid As String) As BANanoHTML
	Dim hdr As BANanoHTML = CreateH(hid,6)
	Return hdr
End Sub


'create horizontal rule
Sub CreateHR(b As Boolean) As BANanoHTML
	Dim hr As BANanoHTML
	hr.Initialize("hr")
	Return hr
End Sub

'create sub
Sub CreateSub(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("sub").SetID(sid)
	Return s
End Sub

Sub CreateStrong(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("strong").SetID(sid)
	Return s
End Sub

'create em
Sub CreateEM(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("em").SetID(sid)
	Return s
End Sub


'create small
Sub CreateSmall(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("small").SetID(sid)
	Return s
End Sub

'create a span
Sub CreateSpan(sid As String) As BANanoHTML
	Dim s As BANanoHTML
	s.Initialize("span").SetID(sid)
	Return s
End Sub

'create an anchor
Sub CreateAnchor(aid As String) As BANanoHTML
	Dim a As BANanoHTML
	a.Initialize("a").SetID(aid)
	Return a
End Sub

'create an article
Sub CreateArticle(aid As String) As BANanoHTML
	Dim a As BANanoHTML
	a.Initialize("article").SetID(aid)
	Return a
End Sub

'create an aside
Sub CreateAside(aid As String) As BANanoHTML
	Dim a As BANanoHTML
	a.Initialize("aside").SetID(aid)
	Return a
End Sub


'create paragraph
Sub CreateParagraph(pid As String) As BANanoHTML
	Dim p As BANanoHTML
	p.Initialize("p").SetID(pid)
	Return p
End Sub

'create form
Sub CreateForm(fID As String) As BANanoHTML
	Dim frm As BANanoHTML
	frm.Initialize("form").SetID(fID)
	Return frm
End Sub

'create legend
Sub CreateLegend(fID As String, sCaption As String) As BANanoHTML
	Dim fs As BANanoHTML
	fs.Initialize("legend").AddContent(sCaption).SetID(fID)
	Return fs
End Sub

'create fieldset
Sub CreateFieldSet(fID As String, sCaption As String) As BANanoHTML
	Dim fs As BANanoHTML
	fs.Initialize("fieldset").SetID(fID)
	Dim lgnd As BANanoHTML = CreateLegend("", sCaption)
	fs.AddElement(lgnd)
	Return fs
End Sub

'create container
Sub CreateContainer(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("div").AddClass("container").SetID(cid)
	Return div
End Sub

'create container
Sub CreateCANVAS(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("canvas").SetID(cid)
	Return div
End Sub

'create audio
Sub CreateAUDIO(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("audio").SetID(cid)
	Return div
End Sub

'create video
Sub CreateVIDEO(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("video").SetID(cid)
	Return div
End Sub

'create table
Sub CreateTABLE(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("table").SetID(cid)
	Return div
End Sub


'create source
Sub CreateSOURCE(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("source").SetID(cid)
	Return div
End Sub


'create tr
Sub CreateTR(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("tr").SetID(cid)
	Return div
End Sub

Sub CreateTHEAD(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("thead").SetID(cid)
	Return div
End Sub


Sub CreateTBODY(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("tbody").SetID(cid)
	Return div
End Sub


Sub CreateCAPTION(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("caption").SetID(cid)
	Return div
End Sub


'create td
Sub CreateTD(cid As String) As BANanoHTML
	cid = cid.tolowercase
	Dim div As BANanoHTML
	div.Initialize("td").SetID(cid)
	Return div
End Sub


'create label
Sub CreateLabel(lid As String) As BANanoHTML
	lid = lid.tolowercase
	Dim lbl As BANanoHTML
	lbl.Initialize("label").SetID(lid)
	Return lbl
End Sub

'add to parent
Sub PopToParent(sParentID As String)
	Dim sout As String = ToString
	sParentID = sParentID.tolowercase
	Dim pEL As BANanoElement
	pEL = BANano.GetElement($"#${sParentID}"$)
	pEL.Append(sout)
End Sub

'create input
Sub CreateInput(tid As String) As BANanoHTML
	tid = tid.tolowercase
	Dim input As BANanoHTML
	input.Initialize("input").SetID(tid)
	Return input
End Sub

'create text area
Sub CreateTextArea(tid As String) As BANanoHTML
	Dim ta As BANanoHTML
	ta.Initialize("textarea").SetID(tid)
	Return ta
End Sub

'create an option
Sub CreateOption(oid As String) As BANanoHTML
	Dim o As BANanoHTML
	o.Initialize("option").SetID(oid)
	Return o
End Sub


'create an option group
Sub CreateOptGroup(oid As String) As BANanoHTML
	Dim o As BANanoHTML
	o.Initialize("optgroup").SetID(oid)
	Return o
End Sub


'create select
Sub CreateSelect(oid As String) As BANanoHTML
	Dim o As BANanoHTML
	o.Initialize("select").SetID(oid)
	Return o
End Sub

'create code
Sub CreateCode(oid As String) As BANanoHTML
	Dim o As BANanoHTML
	o.Initialize("code").SetID(oid)
	Return o
End Sub

'create select
Sub CreateSelect1(tid As String, options As List) As BANanoHTML
	Dim ta As BANanoHTML
	ta.Initialize("select").SetID(tid)
	For Each opt As Map In options
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		Dim thisoption As BANanoHTML = CreateOption("").SetText(optval)
		thisoption.SetParentID(tid).SetAttrVALUE(optid)
		ta.AddElement(thisoption)
	Next
	Return ta
End Sub

'create input text
Sub CreateInputText(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetAttrTYPE("text")
	Return input
End Sub

'create button
Sub CreateButton(btnID As String) As BANanoHTML
	Dim b As BANanoHTML
	b.Initialize("button").SetID(btnID)
	Return b
End Sub

'create input button
Sub CreateInputButton(tid As String, tValue As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetAttrTYPE("button").setattrvalue(tValue)
	Return input
End Sub

'create input reset
Sub CreateInputReset(tid As String, tValue As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetAttrTYPE("reset").setattrvalue(tValue)
	Return input
End Sub

'create input submit
Sub CreateInputSubmit(tid As String, tValue As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("submit").setattrvalue(tValue)
	Return input
End Sub

'create input file
Sub CreateInputFile(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("file")
	Return input
End Sub

'create input date
Sub CreateInputDate(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("date")
	Return input
End Sub

'create input color
Sub CreateInputColor(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("color")
	Return input
End Sub


'create input email
Sub CreateInputEmail(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("email")
	Return input
End Sub

'create input password
Sub CreateInputPassword(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("password")
	Return input
End Sub

'create input checkbox
Sub CreateInputCheckBox(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("checkbox").SetAttr("tabindex","0")
	input.AddAttribute("autocomplete", "off")
	Return input
End Sub

Sub SetAttrAutoCompleteOFF(b As Boolean) As BANanoHTML
	SetAttr("autocomplete", "off")
	Return Me
End Sub

Sub SetAttrTabIndex(tbi As String) As BANanoHTML
	SetAttr("tabindex", tbi)
	Return Me	
End Sub


'create input radio
Sub CreateInputRadio(tid As String, tname As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("radio").SetAttrtabindex("0").SetattrNAME(tname)
	input.SetAttrautocomplete("off")
	Return input
End Sub

'create input tel
Sub CreateInputTel(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("tel")
	Return input
End Sub

'create input tel
Sub CreateInputUrl(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("url")
	Return input
End Sub


'create input number
Sub CreateInputNumber(tid As String) As BANanoHTML
	Dim input As BANanoHTML = CreateInput(tid).SetattrTYPE("number")
	Return input
End Sub

'create iframe
Sub CreateIFrame(ifid As String) As BANanoHTML
	Dim i As BANanoHTML
	i.Initialize("iframe").SetID(ifid)
	Return i
End Sub

