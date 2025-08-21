B4J=true
Group=Default Group\Library
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12,9
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
	Private CSSRule As Map
	Private SingleQuote As List
	Private SBAfter As StringBuilder
	Private SBBefore As StringBuilder
	Public IsImportant As Boolean
	Private BANano As BANano   'ignore
	Private ParentID As String
	Private ds As String
	Private hasContent As Boolean
End Sub

'remove border
Sub RemoveBorder(b As Boolean) As VueHTML
	SetStyle("border","none none double none")
	Return Me
End Sub

'set pointer
Sub SetPointer(b As Boolean) As VueHTML
	SetStyle("cursor","pointer")
	Return Me
End Sub

'center items
Sub CenterItems(b As Boolean) As VueHTML
	SetStyle("justify-content", "center")
	Return Me
End Sub

'center the text in the item
Sub CenterText(b As Boolean) As VueHTML
	SetStyle("text-align", "center")
	Return Me
End Sub

'set url
Sub SetURL(u As Object) As VueHTML
	SetAttr("url", u)
	Return Me
End Sub

'set to
Sub SetTo(t As Object) As VueHTML
	SetAttr("to", t)
	Return Me
End Sub

'set color
Sub SetColor(c As Object) As VueHTML
	SetAttr("color", c)
	Return Me
End Sub

'set padding
Sub SetPadding(p As Object) As VueHTML
	SetStyleMulti(CreateMap("padding":p))
	Return Me
End Sub


'set padding
Sub SetBackgroundColor(p As Object) As VueHTML
	SetStyleMulti(CreateMap("background-color":p))
	Return Me
End Sub

'set template
Sub SetTemplate(tmp As Object) As VueHTML
	Clear
	SetText(tmp)
	Return Me
End Sub

'set src bind
Sub SetSrc(bind As String) As VueHTML
	SetAttr(":src", bind)
	Return Me
End Sub

Sub SetAlt(a As String) As VueHTML
	SetAttr("alt", a)
	Return Me
End Sub

'set ref
Sub SetRef(r As Object) As VueHTML
	SetAttr("ref", r)
	Return Me
End Sub

'set the data source for the list
Sub SetData(dsx As Object) As VueHTML
	ds = dsx
	SetVFor("row", dsx)
	SetKey("id")
	SetValue("value")
	Return Me
End Sub

'set value
private Sub SetValue(l As Object) As VueHTML
	If ds = "" Then
		Log("VueHTML.SetValue, you need to run VueHTML.SetData first before you set value!")
		Return Me
	End If
	Dim valueName As String = $"row.${l}"$
	Dim txt As String = $"{{ ${valueName} }}"$
	SetText(txt)
	SetAttr("v-bind:name", valueName)
	Return Me
End Sub

'set for
Sub SetVFor(item As Object, dataSource As String) As VueHTML
	If ds = "" Then
		Log("VueHTML.SetValue, you need to run VueHTML.SetData first before you set for!")
		Return Me
	End If
	Dim sline As String = $"${item} in ${dataSource}"$
	SetAttr("v-for", sline)
	Return Me
End Sub

Sub SetKey(k As String) As VueHTML
	SetAttr(":key", k)
	Return Me
End Sub

'add break
Sub AddBR
	SetText("<br>")
End Sub

'add hr
Sub AddHR
	SetText("<hr>")
End Sub


Sub SetVIf(vif As Object) As VueHTML
	SetAttr("v-if", vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As VueHTML
	SetAttr("v-show", vif)
	Return Me
End Sub

Sub SetStyleHeight(h As Object) As VueHTML
	SetStyleMulti(CreateMap("height":h))
	Return Me
End Sub

Sub SetVHtml(h As Object) As VueHTML
	SetAttr("v-html", h)
	Return Me
End Sub

Sub SetStyleWidth(h As Object) As VueHTML
	SetStyleMulti(CreateMap("width":h))
	Return Me
End Sub



'mvfield sub
Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
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


'Returns a random list value from a LIST 
Sub RandListValue(ListX As List) As Object
	ShuffleList(ListX)
	Return ListX.Get(Rnd(0, ListX.Size -1))
End Sub

'remove from list
Sub RamoveFromList(listX As List, item As String)
	Dim li As Int = listX.IndexOf(item)
	If li >= 0 Then listX.RemoveAt(li)
End Sub

Sub ShuffleList(pl As List) As List
	For i = pl.Size - 1 To 0 Step -1
		Dim j As Int
		Dim k As Object
		j = Rnd(0, i + 1)
		k = pl.Get(j)
		pl.Set(j,pl.Get(i))
		pl.Set(i,k)
	Next
	Return pl
End Sub

Sub SetInline(b As Boolean) As VueHTML
	SetStyleMulti(CreateMap("display":"inline-flex","margin-right":"10px"))
	Return Me
End Sub

'add a list of classes to the element
Sub SetClasses(clsList As List) As VueHTML
	For Each c As String In clsList
		AddClass(c)
	Next
	Return Me
End Sub

'add a list of classes to the element
Sub AddClasses(clsList As List) As VueHTML
	For Each c As String In clsList
		AddClass(c)
	Next
	Return Me
End Sub

'set attributes from a map
Sub SetAttributes(m As Map) As VueHTML
	For Each k As String In m.Keys
		Dim v As String = m.Get(k)
		SetAttr(k,v)
	Next
	Return Me
End Sub

'set styles from a map
Sub SetStyles(m As Map) As VueHTML
	For Each k As String In m.Keys
		Dim v As String = m.Get(k)
		SetStyle(k,v)
	Next
	Return Me
End Sub

'add a span element
Sub SetSpan(sText As String) As VueHTML
	Dim s As VueHTML
	s = CreateSpan("").SetText(sText)
	AddElement(s)
	Return Me
End Sub


'set slot
Sub SetSlot(s As Object) As VueHTML
	SetAttr("slot", s)
	Return Me
End Sub

Sub SetStateOnClick(ns As Object) As VueHTML
	SetAttr("v-on:click", ns)
	Return Me
End Sub

'set v lazy
Sub SetVLazy(varLazyLoad As Object) As VueHTML
	SetAttr("v-lazy", varLazyLoad)
	Return Me
End Sub

'set class
Sub SetClass(c As Object) As VueHTML   'ignore
	AddClass(c)
	Return Me
End Sub

'set section class
Sub SetClassSection(b As Boolean) As VueHTML   'ignore
	AddClass("section")
	Return Me
End Sub

'wrap element to
Sub Wrap(wid As String, wrapType As String) As VueHTML
	Dim p As VueHTML
	p.Initialize(wid,wrapType)
	p.AddContent(HTML)
	Return p 
End Sub

'set row
Sub SetClassRow(b As Boolean) As VueHTML   'ignore
	AddClass("row")
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As String, val As String) As VueHTML
	AddAttribute(attr,val)
	Return Me
End Sub

'set role button
Sub SetAttrRoleButton(b As Boolean) As VueHTML   'ignore
	SetAttrROLE("button")
	Return Me
End Sub

Sub SetStyleFontFamily(f As Object) As VueHTML   'ignore
	SetStyle("font-family", f)
	Return Me
End Sub


Sub SetStyleFontWeight(f As Object) As VueHTML   'ignore
	SetStyle("font-weight", f)
	Return Me
End Sub


Sub SetStyleFontWeightBold(f As Boolean) As VueHTML   'ignore
	SetStyle("font-weight", "bold")
	Return Me
End Sub

Sub SetStyleFontVariant(f As Object) As VueHTML   'ignore
	SetStyle("font-variant", f)
	Return Me
End Sub

Sub SetStyleFontWeightNormal(f As Boolean) As VueHTML   'ignore
	SetStyle("font-weight", "normal")
	Return Me
End Sub


Sub SetStyleFontStyle(f As Object) As VueHTML   'ignore
	SetStyle("font-style", f)
	Return Me
End Sub

Sub SetStyleFontSize(f As Object) As VueHTML   'ignore
	SetStyle("font-size", MakePx(f))
	Return Me
End Sub


Sub SetStyleTextAlignCenter(f As Boolean) As VueHTML   'ignore
	SetStyle("text-align", "center")
	Return Me
End Sub


Sub SetStyleTextIndent(f As Object) As VueHTML   'ignore
	SetStyle("text-indent", MakePx(f))
	Return Me
End Sub

Sub SetStyleTextTransform(f As Object) As VueHTML   'ignore
	SetStyle("text-transform", f)
	Return Me
End Sub

Sub SetStyleLetterSpacing(f As Object) As VueHTML   'ignore
	SetStyle("letter-spacing", MakePx(f))
	Return Me
End Sub

Sub SetStyleTextDecoration(f As Object) As VueHTML   'ignore
	SetStyle("text-decoration", f)
	Return Me
End Sub

Sub SetStyleTextShadow(f As Object) As VueHTML   'ignore
	SetStyle("text-shadow", f)
	Return Me
End Sub

Sub SetStyleLineHeight(f As Object) As VueHTML   'ignore
	SetStyle("line-height", f)
	Return Me
End Sub


Sub SetStyleWhiteSpace(f As Object) As VueHTML   'ignore
	SetStyle("white-space", f)
	Return Me
End Sub

Sub SetStyleVerticalAlign(f As Object) As VueHTML   'ignore
	SetStyle("vertical-align", f)
	Return Me
End Sub

Sub SetStyleDirection(f As Object) As VueHTML   'ignore
	SetStyle("direction", f)
	Return Me
End Sub

Sub SetStyleWordSpacing(f As Object) As VueHTML   'ignore
	SetStyle("word-spacing", MakePx(f))
	Return Me
End Sub


'set disabled
Sub SetAttrDisabled(b As Boolean) As VueHTML
	If b Then AddLooseAttribute("disabled")
	Return Me
End Sub

'set background color
Sub SetStyleBackgroundColor(c As Object) As VueHTML
	SetStyle("background-color",c)
	Return Me
End Sub


'set background color
Sub SetStyleBackgroundClip(c As Object) As VueHTML
	SetStyle("background-clip",c)
	Return Me
End Sub


'set background color
Sub SetStyleBackgroundOrigin(c As Object) As VueHTML
	SetStyle("background-origin",c)
	Return Me
End Sub

'set the border radius
Sub SetStyleBorderRadius(topLeft As String, topRight As String, bottomLeft As String, bottomRight As String) As VueHTML
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
Sub SetStyleBorderTopLeftRadius(topLeft As String) As VueHTML
	topLeft = MakePx(topLeft)
	SetStyle("border-top-left-radius", topLeft)
	Return Me
End Sub

Sub SetStyleBorderTopRightRadius(topRight As String) As VueHTML
	topRight = MakePx(topRight)
	SetStyle("border-top-right-radius", topRight)
	Return Me
End Sub

Sub SetStyleBorderBottomLeftRadius(bottomLeft As String) As VueHTML
	bottomLeft = MakePx(bottomLeft)
	SetStyle("border-bottom-left-radius", bottomLeft)
	Return Me
End Sub

Sub SetStyleBorderBottomRightRadius(bottomRight As String) As VueHTML
	bottomRight = MakePx(bottomRight)
	SetStyle("border-bottom-right-radius", bottomRight)
	Return Me
End Sub

Sub SetStyleColor(c As Object) As VueHTML
	SetStyle("color",c)
	Return Me
End Sub

Sub SetStyleOutline(c As Object) As VueHTML
	SetStyle("outline",c)
	Return Me
End Sub

Sub SetStyleOutlineStyle(bs As Object) As VueHTML
	SetStyle("outline-style",bs)
	Return Me
End Sub


Sub SetStyleOutlineColor(bs As Object) As VueHTML
	SetStyle("outline-color",bs)
	Return Me
End Sub

Sub SetStyleOutlineWidth(bs As Object) As VueHTML
	SetStyle("outline-width",MakePx(bs))
	Return Me
End Sub


Sub SetStyleBorderStyle(bs As Object) As VueHTML
	SetStyle("border-style",bs)
	Return Me
End Sub

Sub SetStyleBorderStyleDotted(b As Boolean) As VueHTML
	SetStyle("border-style","dotted")
	Return Me
End Sub

Sub SetStyleBorderStyleDashed(b As Boolean) As VueHTML
	SetStyle("border-style","dashed")
	Return Me
End Sub

Sub SetStyleBorderStyleSolid(b As Boolean) As VueHTML
	SetStyle("border-style","solid")
	Return Me
End Sub

Sub SetStyleBorderStyleDouble(b As Boolean) As VueHTML
	SetStyle("border-style","double")
	Return Me
End Sub

Sub SetStyleBorderWidth(b As String) As VueHTML
	SetStyle("border-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderLeftWidth(b As String) As VueHTML
	SetStyle("border-left-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderRightWidth(b As String) As VueHTML
	SetStyle("border-right-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderBottomWidth(b As String) As VueHTML
	SetStyle("border-bottom-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderTopWidth(b As String) As VueHTML
	SetStyle("border-top-width",MakePx(b))
	Return Me
End Sub

Sub SetStyleBorderColor(c As String) As VueHTML
	SetStyle("border-color",c)
	Return Me
End Sub

Sub SetStyleBorderLeftColor(c As String) As VueHTML
	SetStyle("border-left-color",c)
	Return Me
End Sub


Sub SetStyleBorderRightColor(c As String) As VueHTML
	SetStyle("border-right-color",c)
	Return Me
End Sub

Sub SetStyleBorderTopColor(c As String) As VueHTML
	SetStyle("border-top-color",c)
	Return Me
End Sub


Sub SetStyleBorderBottomColor(c As String) As VueHTML
	SetStyle("border-bottom-color",c)
	Return Me
End Sub

Sub SetStyleBorderLeftStyle(c As String) As VueHTML
	SetStyle("border-left-style",c)
	Return Me
End Sub

Sub SetStyleBorderRightStyle(c As String) As VueHTML
	SetStyle("border-right-style",c)
	Return Me
End Sub

Sub SetStyleBorderBottomStyle(c As String) As VueHTML
	SetStyle("border-bottom-style",c)
	Return Me
End Sub

Sub SetStyleBorderTopStyle(c As String) As VueHTML
	SetStyle("border-top-style",c)
	Return Me
End Sub

Sub SetStyleBorderStyleGroove(b As Boolean) As VueHTML
	SetStyle("border-style","groove")
	Return Me
End Sub

Sub SetStyleBorderStyleRidge(b As Boolean) As VueHTML
	SetStyle("border-style","ridge")
	Return Me
End Sub

Sub SetStyleBorderStyleInset(b As Boolean) As VueHTML
	SetStyle("border-style","inset")
	Return Me
End Sub

Sub SetStyleBorderStyleOutset(b As Boolean) As VueHTML
	SetStyle("border-style","outset")
	Return Me
End Sub

Sub SetStyleBorderStyleNone(b As Boolean) As VueHTML
	SetStyle("border-style","none")
	Return Me
End Sub

Sub SetStyleBorderStyleHidden(b As Boolean) As VueHTML
	SetStyle("border-style","hidden")
	Return Me
End Sub

Sub SetStyleImportant(b As Boolean) As VueHTML
	IsImportant = b
	Return Me
End Sub


'set style
Sub SetStyleMulti(m As Map) As VueHTML
	For Each k As String In m.Keys
		Dim v As Object = m.Get(k)
		SetStyle(k,v)
	Next
	Return Me
End Sub

'set style
Sub SetStyle(prop As String, val As String) As VueHTML
	AddStyleAttribute(prop,val)
	Return Me
End Sub

'set width
Sub SetAttrWidth(w As Object) As VueHTML
	AddAttribute("width", w)
	Return Me
End Sub

'set width
Sub SetAttrCSS(w As Object) As VueHTML
	AddAttribute("css", w)
	Return Me
End Sub

'set height
Sub SetAttrHeight(h As String) As VueHTML
	AddAttribute("height", h)
	Return Me
End Sub

'set the padding style
Sub SetStylePadding(PaddingBottom As String) As VueHTML
	SetStyle("padding", MakePx(PaddingBottom))
	Return Me
End Sub

'set the padding bottom style
Sub SetStylePaddingBottom(PaddingBottom As String) As VueHTML
	SetStyle("padding-bottom", MakePx(PaddingBottom))
	Return Me
End Sub

'set the padding right style
Sub SetStylePaddingRight(PaddingRight As String) As VueHTML
	SetStyle("padding-right", MakePx(PaddingRight))
	Return Me
End Sub

'set the padding left style
Sub SetStylePaddingLeft(PaddingLeft As String) As VueHTML
	SetStyle("padding-left", MakePx(PaddingLeft))
	Return Me
End Sub

'set the padding top style	
Sub SetStylePaddingTop(PaddingTop As String) As VueHTML
	SetStyle("padding-top", MakePx(PaddingTop))
	Return Me
End Sub

'set the background image style
Sub SetStyleBackgroundImage(imgURL As String) As VueHTML
	SetStyle("background-image", $"url('${imgURL}')"$)
	Return Me
End Sub

'set the background repeat style
Sub SetStyleBackgroundRepeat(r As String) As VueHTML
	SetStyle("background-repeat", r)
	Return Me
End Sub

'set the background size style
Sub SetStyleBackgroundSize(r As String) As VueHTML
	SetStyle("background-size", r)
	Return Me
End Sub


'set the background attachment style
Sub SetStyleBackgroundAttachment(r As String) As VueHTML
	SetStyle("background-attachment", r)
	Return Me
End Sub


'set the background position style
Sub SetStyleBackgroundPosition(r As String) As VueHTML
	SetStyle("background-position", r)
	Return Me
End Sub


'set the margin style
Sub SetStyleMargin(MarginBottom As String) As VueHTML
	SetStyle("margin", MakePx(MarginBottom))
	Return Me
End Sub

'set margin bottom style
Sub SetStyleMarginBottom(MarginBottom As String) As VueHTML
	SetStyle("margin-bottom", MakePx(MarginBottom))
	Return Me
End Sub

'set the margin right style
Sub SetStyleMarginRight(MarginRight As String) As VueHTML
	SetStyle("margin-right", MakePx(MarginRight))
	Return Me
End Sub

'set margin left style
Sub SetStyleMarginLeft(MarginLeft As String) As VueHTML
	SetStyle("margin-left", MakePx(MarginLeft))
	Return Me
End Sub

'set margin top style	
Sub SetStyleMarginTop(MarginTop As String) As VueHTML
	SetStyle("margin-top", MakePx(MarginTop))
	Return Me
End Sub

Sub UseTheme(sPrefix As String, themeName As String) As VueHTML
	If themeName = "" Then Return Me
	themeName = themeName.tolowercase
	If sPrefix <> "" And themeName <> "" Then
		AddClass($"${sPrefix}-${themeName}"$)
	End If
	Return Me
End Sub

'set attribute
Sub AddAttributeIfSet(prop As String, value As String) As VueHTML
	If value <> "" Then
		AddAttribute(prop,value)
	End If
	Return Me
End Sub

'set placeholder attribute
Sub SetAttrPlaceHolder(sPlaceholder As String) As VueHTML
	AddAttribute("placeholder",sPlaceholder)
	Return Me
End Sub

'set title attribute
Sub SetAttrTITLE(stitle As String) As VueHTML
	AddAttribute("title", stitle)
	Return Me
End Sub

'set action attribute
Sub SetAttrACTION(stitle As String) As VueHTML
	AddAttribute("action", stitle)
	Return Me
End Sub

'set autocomplete attribute
Sub SetAttrAUTOCOMPLETE(b As Boolean) As VueHTML
	If b Then
		AddAttribute("autocomplete", "on")
	End If
	Return Me
End Sub

'set autofocus attribute
Sub SetAttrAUTOFOCUS(b As Boolean) As VueHTML
	If b Then AddLooseAttribute("autofocus")
	Return Me
End Sub


'set rel attribute
Sub SetAttrREL(rel As String) As VueHTML
	AddAttribute("rel", rel)
	Return Me
End Sub

'clear text contents
Sub Clear As VueHTML
	Contents.clear
	Return Me
End Sub

'set attr on condition
Sub AddPropertyOnCondition(bCondition As Boolean, attr As String, value As String) As VueHTML
	If bCondition Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub

'set attribute
Public Sub AddProperty(sKey As String, sValue As String) As VueHTML
	AddAttribute(sKey, sValue)
	Return Me
End Sub

'set target attribute
Sub SetAttrTARGET(sValue As String) As VueHTML
	If sValue.Trim = "" Then Return Me
	AddAttribute("target",sValue)
	Return Me
End Sub

Sub SetAttrTargetBlank(b As Boolean) As VueHTML   'ignore
	SetAttrTARGET("_blank")
	Return Me
End Sub

Sub SetAttrTargetSelf(b As Boolean) As VueHTML    'ignore
	SetAttrTARGET("_self")
	Return Me
End Sub
	
Sub SetAttrTargetParent(b As Boolean) As VueHTML   'ignore
	SetAttrTARGET("_parent")
	Return Me
End Sub
	
Sub SetAttrTargetTop(b As Boolean) As VueHTML    'ignore
	SetAttrTARGET("_top")
	Return Me
End Sub

Sub ApplyStyle(sStyle As String) As VueHTML
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

Sub SetClassCenter As VueHTML
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
public Sub SetContents(value As String) As VueHTML
	Contents.Initialize
	Contents.clear
	If value.Length > 0 Then
		AddContent(value)
	End If
	Return Me
End Sub

public Sub AddElementLine(el As VueHTML) As VueHTML
	If el <> Null Then
		Dim scode As String = el.html
		AddContent(scode)
	End If
	Return Me
End Sub


Sub SetAttrROLE(sValue As String) As VueHTML
	AddAttribute("role",sValue)
	Return Me
End Sub

Sub SetAttrMETHOD(sValue As String) As VueHTML
	AddAttribute("method",sValue)
	Return Me
End Sub

'add content to the element
public Sub AddContentLine(value As String) As VueHTML
	If value <> "" Then
		value = value.Replace(CRLF,"")
		AddContent(value)
	End If
	Return Me
End Sub

Sub SetAttrTypeNumbers() As VueHTML
	AddAttribute("type","1")
	Return Me
End Sub

Sub SetAttrTypeUpperCase() As VueHTML
	AddAttribute("type","A")
	Return Me
End Sub

Sub SetAttrTypeLowerCase() As VueHTML
	AddAttribute("type","a")
	Return Me
End Sub

Sub SetAttrTypeUpperCaseRoman() As VueHTML
	AddAttribute("type","I")
	Return Me
End Sub

Sub SetAttrTypeLowerCaseRoman() As VueHTML
	AddAttribute("type","i")
	Return Me
End Sub


Sub SetStyleListStyleCircle() As VueHTML
	SetStyle("list-style-type","circle")
	Return Me
End Sub

Sub SetStyleListStyleDisk() As VueHTML
	SetStyle("list-style-type","disk")
	Return Me
End Sub

Sub SetStyleListStyleNone() As VueHTML
	SetStyle("list-style-type","none")
	Return Me
End Sub

Sub SetStyleListStyleSquare() As VueHTML
	SetStyle("list-style-type","square")
	Return Me
End Sub

Sub AddHeading(sSize As Int, sContent As String) As VueHTML
	Dim hdr As VueHTML
	Dim hKey As String = "h" & sSize
	hdr.Initialize("",hKey)
	hdr.AddContent(sContent)
	AddContent(hdr.HTML)
	Return Me
End Sub

Sub AppendParagraph(sContent As String) As VueHTML
	Dim p As VueHTML
	p.Initialize("","p")
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

Sub AddMark(sContent As String, sclass As String) As VueHTML
	Dim p As VueHTML
	p.Initialize("","mark").AddClass(sclass)
	p.AddContent(sContent)
	AddContent(p.HTML)
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttributeOnFalseCondition(bStatus As Boolean, value As String) As VueHTML
	If bStatus = False Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'change the element type
Sub SetElementTypeOnCondition(bStatus As Boolean,sElementType As String) As VueHTML
	If bStatus Then
		Tag = sElementType
	End If
	Return Me
End Sub


Sub SetStyleZIndex(zindex As String) As VueHTML
	SetStyle("z-index",zindex)
	Return Me
End Sub

Sub AddContentListReverse(lst As List) As VueHTML
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = lTot To 0 Step -1
		Dim strContent As String = lst.Get(lCnt)
		AddContent(strContent)
	Next
	Return Me
End Sub


Sub SetAttrFOR(sFor As String) As VueHTML
	AddAttribute("for",sFor)
	Return Me
End Sub


Sub SetAttrVALUE(sValue As String) As VueHTML
	AddAttribute("value",sValue)
	Return Me
End Sub


Sub SetAttrNAME(sName As String) As VueHTML
	AddAttribute("name",sName)
	Return Me
End Sub

Sub SetAttrSUMMARY(sName As String) As VueHTML
	AddAttribute("summary",sName)
	Return Me
End Sub


Sub SetCOLSPAN(sName As String) As VueHTML
	AddAttribute("colspan",sName)
	Return Me
End Sub


Sub SetAttrLabel(l As String) As VueHTML
	AddAttribute("label",l)
	Return Me
End Sub


Sub SetAttrRows(l As String) As VueHTML
	AddAttribute("rows",l)
	Return Me
End Sub


Sub SetAttrCols(l As String) As VueHTML
	AddAttribute("cols",l)
	Return Me
End Sub


Sub SetAttrROWSPAN(sName As String) As VueHTML
	AddAttribute("rowspan",sName)
	Return Me
End Sub

Sub SetAttrTYPE(sValue As String) As VueHTML
	AddAttribute("type",sValue)
	Return Me
End Sub


Sub UpdateAttribute(name As String, propValue As Object) As VueHTML
	If properties.ContainsKey(name) Then
		Dim svalue As Object = properties.Get(name)
		svalue = svalue & ";" & propValue
		properties.Put(name,svalue)
	Else
		properties.Put(name,propValue)
	End If
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttributeOnCondition(bStatus As Boolean, value As String) As VueHTML
	If bStatus = True Then
		AddLooseAttribute(value)
	End If
	Return Me
End Sub

'add a class to the element
Sub AddLooseAttribute(value As String) As VueHTML
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


Sub AddDataAttribute(attribute As String, value As String) As VueHTML
	Dim sw As Boolean = attribute.StartsWith("data-")
	If sw Then
		AddAttribute(attribute,value)
	Else
		AddAttribute("data-" & attribute,value)
	End If
	Return Me
End Sub

Sub AddDataAttributeOnCondition(bCondition As Boolean,attribute As String, value As String) As VueHTML
	If bCondition = False Then 
		Return Me
	End If
	AddDataAttribute(attribute,value)
	Return Me
End Sub

Sub AddStyleOnCondition(bCondition As Boolean,attribute As String, value As String) As VueHTML
	If bCondition = False Then 
		Return Me
	End If
	AddStyle(attribute,value)
	Return Me
End Sub


Sub SetAttrSRC(sValue As String, Static As Boolean) As VueHTML
	Dim tmpFile As String = MvField(sValue,1,"?")
	If Static Then
		sValue = tmpFile
	Else
		sValue = tmpFile & "?" & DateTime.now
	End If
	AddAttribute("src",sValue)
	Return Me
End Sub


Sub SetAttrALT(sValue As String) As VueHTML
	AddAttribute("alt",sValue)
	Return Me
End Sub

Sub AddStyleAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As VueHTML
	If bCondition = True Then
		SetStyle(attr,value)
	End If
	Return Me
End Sub

Sub AddAttributeOnCondition(bCondition As Boolean, attr As String, value As String) As VueHTML
	If bCondition = True Then
		AddAttribute(attr,value)
	End If
	Return Me
End Sub

Sub GetAttr(attr As String) As Object
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

Sub AddCursor As VueHTML
	SetStyle("cursor", "pointer")
	Return Me
End Sub

Sub SetAttrHREF(value As String) As VueHTML
	AddAttribute("href",value)
	Return Me
End Sub

Sub AddClassOnValue(iValue As Int, sClass As String) As VueHTML
	If iValue > 0 Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnCondition(bCondition As Boolean, sClass As String) As VueHTML
	If bCondition  Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub AddClassOnFalseCondition(bCondition As Boolean, sClass As String) As VueHTML
	If bCondition = False Then
		AddClass(sClass)
	End If
	Return Me
End Sub

Sub RemoveClassOnCondition(bCondition As Boolean, sClass As String) As VueHTML
	If bCondition Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


Sub RemoveClassOnFalseCondition(bCondition As Boolean, sClass As String) As VueHTML
	If bCondition = False Then 
		removeClass(sClass)
	End If
	Return Me
End Sub


'add a list of elements
Sub AddContentList(lst As List) As VueHTML
	For Each strContent As String In lst
		AddContent(strContent)
	Next
	Return Me
End Sub

Sub SetType(t As String) As VueHTML
	SetAttr("type", t)
	Return Me
End Sub

'set the text of the element, in most cases you will use AddContent
Sub SetText(sText As String) As VueHTML
	AddContent(sText)
	hasContent = True
	Return Me
End Sub

Sub SetCode(sText As String) As VueHTML
	Dim s As VueHTML
	s = CreateCode("").SetText(sText)
	AddElement(s)
	Return Me
End Sub


Sub AddText(txt As String) As VueHTML
	AddContent(txt)
	Return Me
End Sub

'set prefix
Sub SetPrefix(sPrefix As String) As VueHTML
	Prefix = sPrefix
	Return Me
End Sub

'set the tag, this updates the tab
Sub SetTag(sTag As String) As VueHTML
	Tag = sTag.tolowercase
	If Tag = "pre" Then
		AddClass("code-line")
	End If
	Return Me
End Sub

'set max
Sub SetAttrMax(m As Object) As VueHTML
	SetAttr("max", m)
	Return Me
End Sub


'set min
Sub SetAttrMin(m As Object) As VueHTML
	SetAttr("min", MakePx(m))
	Return Me
End Sub


'set min width
Sub SetAttrMinWidth(m As Object) As VueHTML
	SetAttr("min-width", MakePx(m))
	Return Me
End Sub


'set min height
Sub SetAttrMinHeight(m As Object) As VueHTML
	SetAttr("min-height", MakePx(m))
	Return Me
End Sub


'set max width
Sub SetAttrMaxWidth(m As Object) As VueHTML
	SetAttr("max-width", MakePx(m))
	Return Me
End Sub


'set max height
Sub SetAttrMaxHeight(m As Object) As VueHTML
	SetAttr("mnax-height", MakePx(m))
	Return Me
End Sub

'Initializes the html builder
Public Sub Initialize(elID As String, stag As String) As VueHTML
	ds = ""
	hasContent = False
	ParentID = ""
	ID = elID.tolowercase
	IsImportant = False
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
	Tag = stag.tolowercase
	Prefix = ""
	DoAProperClose = True
	CSSRule.Initialize
	CSSRule.clear
	SingleQuote.Initialize
	SingleQuote.clear
	Return Me
End Sub

'add as a child element
Sub Pop(pElement As VueHTML)
	pElement.AddElement(Me)
End Sub

'remove a data attribute
public Sub RemoveAttrData(sData As String) As VueHTML
	sData = $"data-${sData}"$
	RemoveAttr(sData)
	Return Me
End Sub

Sub RemoveAttributeOnCondition(bCondition As Boolean, prop As String) As VueHTML
	If bCondition Then
		RemoveAttr(prop)
	End If
	Return Me
End Sub

'remove attribute
Sub RemoveAttribute(prop As String) As VueHTML
	RemoveAttr(prop)
	Return Me	
End Sub

'remove an attribute from the ones set
public Sub RemoveAttr(sName As String) As VueHTML
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
public Sub RemoveStyle(styleName As String) As VueHTML
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
Sub SetAttrLoose(value As String) As VueHTML
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
private Sub ToProperty(sName As String, svalue As Object) As String
	sName = CStr(sName)
	sName = sName.Trim
	Dim script As String = ""
	If sName.Length > 0 Then
		script = $"${sName}="${svalue}""$
		script = script.trim
		Return script
	Else
		Return ""
	End If	
End Sub

'set a data attribute
Sub SetAttrData(prop As String, value As String) As VueHTML
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
public Sub AddContent(value As String) As VueHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		Contents.Add(value)
		hasContent = True
	End If
	Return Me
End Sub

'add content to the element after closure 
public Sub AddContentAfter(value As String) As VueHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBAfter.Append(value)
		hasContent = True
	End If
	Return Me
End Sub

'add content to the element before open 
public Sub AddContentBefore(value As String) As VueHTML
	value = CStr(value)
	If value.Length > 0 Then
		value = FormatText(value)
		SBBefore.Append(value)
		hasContent = True
	End If
	Return Me
End Sub


'remove a class
public Sub removeClass(className As String) As VueHTML
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
public Sub AddElement(el As VueHTML) As VueHTML
	If el <> Null Then
		Dim scode As String = el.tostring
		AddContent(scode)
		hasContent = True
	End If
	Return Me
End Sub

'add elements
Sub AddElements(lst As List) As VueHTML
	For Each el As VueHTML In lst
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

Sub SetVModel(varVModel As String) As VueHTML
	varVModel = varVModel.tolowercase
	SetAttr("v-model", varVModel)
	Return Me
End Sub

Sub SetOnDblClick(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:dblclick", methodName)
	Return Me
End Sub

Sub SetOnSubmit(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:submit", methodName)
	Return Me
End Sub

Sub SetOnKeyDown(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:keydown", methodName)
	Return Me
End Sub

Sub SetOnKeyUp(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:keyup", methodName)
	Return Me
End Sub

Sub SetOnInput(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:input", methodName)
	Return Me
End Sub

Sub SetOnFocus(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:focus", methodName)
	Return Me
End Sub

Sub SetOnBlur(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:blur", methodName)
	Return Me
End Sub

'set onclick event
Sub SetOnClick(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:click", methodName)
	Return Me
End Sub

Sub SetOnTouchStart(methodName As String) As VueHTML
	methodName = methodName.tolowercase
	SetAttr("v-on:touchstart", methodName)
	Return Me
End Sub

'add a child element
Sub AddChild(child As VueHTML) As VueHTML
	Dim childHTML As String = child.ToString
	SetText(childHTML)
	Return Me
End Sub

'add children
Sub AddChildren(children As List)
	For Each childx As VueHTML In children
		AddChild(childx)
	Next
End Sub



'define the opening of the element
private Sub Open() As String
	'update any loose attributes
	'If Required = True Then SetAttrLoose("required")
	'If Enabled = False Then SetAttrLoose("disabled")
	'If ReadOnly = True Then SetAttrLoose("readonly")
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
	Dim strValue As Object = properties.Get(strKey)
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

'return a key value string for an attribute
private Sub ToSingleQuoteProperty(sName As String, svalue As Object) As String
	sName = CStr(sName)
	sName = sName.Trim
	If sName.Length > 0 Then
		Dim script As String = $"${sName}='${svalue}'"$
		script = script.trim
		Return script
	Else
		Return ""
	End If	
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
Sub AddStyle(prop As String, value As String) As VueHTML
	AddStyleAttribute(prop,value)
	Return Me
End Sub

'set a style property
Sub AddStyleAttribute(sprop As String, svalue As String) As VueHTML
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
	hasContent = True
	Return Me
End Sub



'add a class to the element
Sub AddClass(value As String) As VueHTML
	'add classes delimited by space
	value = value.Replace(" ",";")
	Dim spClasses As List = StrParse(";",value)
	For Each strClass As String In spClasses
		strClass = strClass.Trim
		If strClass.Length > 0 Then 
			Classes.Put(strClass,strClass)
		End If
	Next
	hasContent = True
	Return Me
End Sub

'set attribute
public Sub AddAttribute(skey As String, svalue As Object) As VueHTML
	skey = CStr(skey)
	skey = skey.trim
	properties.Put(skey,svalue)
	hasContent = True
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
public Sub Join(delimiter As String, lst As List) As String
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
Sub SetParentID(sParentID As String) As VueHTML
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
	sout = sout.Replace("  >",">")
	sout = sout.Replace(" >",">")
	Return sout
End Sub

'add a hyperlink that sends an email
Sub AddMailTo(emailaddress As String,subject As String,caption As String) As VueHTML
	subject = subject.Replace(" ", "%20")
	Dim a As VueHTML
	a.Initialize("","a").setAttrHREF($"mailto:${emailaddress}?subject=${subject}"$).AddContent(caption).SetAttrTARGETblank(True)
	AddContent(a.ToString)
	Return Me
End Sub

Sub AddDiv(divid As String, divContent As String, divClass As String) As VueHTML
	Dim div As VueHTML
	div.Initialize(divid,"div").SetText(divContent).addclass(divClass)
	AddContent(div.HTML)
	Return Me
End Sub


'add a bold text
Sub AddBold(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{B}").Append(value).Append("{/B}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add italic text
Sub AddItalic(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{I}").Append(value).Append("{/I}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add underlined text
Sub AddUnderline(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{U}").Append(value).Append("{/U}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add subscript text
Sub AddSubScript(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUB}").Append(value).Append("{/SUB}")
	AddContent(sb.ToString)
	Return Me
End Sub

'add superscript text
Sub AddSuperScript(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("{SUP}").Append(value).Append("{/SUP}")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddSub(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sub>").Append(value).Append("</sub>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddKBD(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<kbd>").Append(value).Append("</kbd>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddCode(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<code>").Append(value).Append("</code>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddPre(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<pre>").Append(value).Append("</pre>")
	AddContent(sb.ToString)
	Return Me
End Sub


Sub AddSup(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<sup>").Append(value).Append("</sup>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddCite(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<cite>").Append(value).Append("</cite>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddEM(value As String) As VueHTML
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<em>").Append(value).Append("</em>")
	AddContent(sb.ToString)
	Return Me
End Sub

Sub AddStrong(value As String) As VueHTML
	Dim s As VueHTML
	s = CreateStrong("").SetText(value)
	AddElement(s)
	Return Me
End Sub


'add a break
Sub AddBreak(b As Boolean) As VueHTML  'ignore
	AddContent("{BR}")
	Return Me
End Sub

'add a hyperlink that opens to blank
Sub AddLink(href As String,caption As String,Target As String) As VueHTML
	Dim a As VueHTML
	a.Initialize("","a").SetAttrHREF(href).AddContent(caption).SetAttrTARGET(Target)
	AddElement(a)
	Return Me
End Sub

Sub AddAnchor(href As String,caption As String,Target As String) As VueHTML
	AddLink(href,caption,Target)
	Return Me
End Sub


Sub AppendH1(paraText As String) As VueHTML
	AddContent($"<h1>${paraText}</h1>"$)
	Return Me
End Sub

Sub AppendH2(paraText As String) As VueHTML
	AddContent($"<h2>${paraText}</h2>"$)
	Return Me
End Sub

Sub AppendH3(paraText As String) As VueHTML
	AddContent($"<h3>${paraText}</h3>"$)
	Return Me
End Sub

Sub AppendH4(paraText As String) As VueHTML
	AddContent($"<h4>${paraText}</h4>"$)
	Return Me
End Sub

Sub AppendSmall(paraText As String) As VueHTML
	AddContent($"<small>${paraText}</small>"$)
	Return Me
End Sub

Sub AppendH5(paraText As String) As VueHTML
	AddContent($"<h5>${paraText}</h5>"$)
	Return Me
End Sub

Sub AppendH6(paraText As String) As VueHTML
	AddContent($"<h6>${paraText}</h6>"$)
	Return Me
End Sub

'create input search
Sub CreateInputSearch(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid, "input").SetAttrTYPE("search")
	Return s
End Sub

'create input range
Sub CreateInputRange(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid, "input").SetAttrTYPE("range")
	Return s
End Sub


'create main
Sub CreateMain(mainid As String) As VueHTML
	Dim m As VueHTML
	m.Initialize(mainid, "main")
	Return m
End Sub


'create progress bar
Sub CreateProgressBar(pbid As String) As VueHTML
	Dim pb As VueHTML
	pb.Initialize(pbid, "progress")
	Return pb
End Sub


'create footer
Sub CreateFooter(fid As String) As VueHTML
	Dim f As VueHTML
	f.Initialize(fid, "footer")
	Return f
End Sub

'create nav
Sub CreateNav(nid As String) As VueHTML
	Dim n As VueHTML
	n.Initialize(nid, "nav")
	Return n
End Sub

'create datalist
Sub CreateDataList(nid As String) As VueHTML
	Dim n As VueHTML
	n.Initialize(nid, "datalist")
	Return n
End Sub

'create header
Sub CreateHeader(hid As String) As VueHTML
	Dim h As VueHTML
	h.Initialize(hid, "header")
	Return h
End Sub

'create section
Sub CreateSection(sid As String) As VueHTML
	Dim s As VueHTML = CreateDIV(sid)
	s.AddClass("section")
	Return s
End Sub


'create a div
Sub CreateDIV(did As String) As VueHTML
	Dim div As VueHTML
	div.Initialize(did,"div")
	Return div
End Sub

'create block quote
Sub CreateBlockQuote(bqid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(bqid,"blockquote")
	Return ul
End Sub

Sub SetCite(c As Object) As VueHTML
	AddAttribute("cite", c)
	Return Me
End Sub

'create pre
Sub CreatePRE(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "pre").AddClass("code-line")
	Return ul
End Sub

Sub CreateMARK(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "mark")
	Return ul
End Sub


Sub CreateTIME(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "time")
	Return ul
End Sub


Sub CreateDL(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "dl")
	Return ul
End Sub

Sub CreateDT(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "dt")
	Return ul
End Sub

Sub CreateDD(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "dd")
	Return ul
End Sub

Sub CreateOL(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "ol")
	Return ul
End Sub

Sub CreateUL(preid As String) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(preid, "ul")
	Return ul
End Sub


'create OL
Sub CreateOL1(ulid As String, items As List) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(ulid, "ol")
	For Each opt As Map In items
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		Dim thisoption As VueHTML = CreateLI("")
		optid = CStr(optid)
		optval = CStr(optval)
		thisoption.SetText(optval)
		thisoption.SetAttrVALUE(optid)
		ul.AddElement(thisoption)
	Next
	Return ul
End Sub

'create UL
Sub CreateUL1(ulid As String, items As List) As VueHTML
	Dim ul As VueHTML
	ul.Initialize(ulid, "ul")
	For Each opt As Map In items
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		optid = CStr(optid)
		optval = CStr(optval)
		Dim thisoption As VueHTML = CreateLI(optid)
		thisoption.SetText(optval)
		ul.AddElement(thisoption)
	Next
	Return ul
End Sub

'create li
Sub CreateLI(liid As String) As VueHTML
	Dim li As VueHTML
	li.Initialize(liid, "li")
	Return li
End Sub

'create image
Sub CreateIMG(imgid As String) As VueHTML
	Dim img As VueHTML
	img.Initialize(imgid, "img")
	Return img
End Sub

'create figcaption
Sub CreateFigCaption(fid As String) As VueHTML
	Dim f As VueHTML
	f.Initialize(fid, "figcaption")
	Return f
End Sub


'create figure
Sub CreateFigure(fid As String) As VueHTML
	Dim f As VueHTML
	f.Initialize(fid, "figure")
	Return f
End Sub

'create h
Sub CreateH(hid As String, size As Int) As VueHTML
	Dim hkey As String = "h" & CStr(size)
	Dim h As VueHTML
	h.Initialize(hid, hkey)
	Return h
End Sub


'create h1
Sub CreateH1(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,1)
	Return hdr
End Sub

'create h2
Sub CreateH2(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,2)
	Return hdr
End Sub

'create h3
Sub CreateH3(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,3)
	Return hdr
End Sub

'create h4
Sub CreateH4(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,4)
	Return hdr
End Sub

'create h5
Sub CreateH5(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,5)
	Return hdr
End Sub

'create h6
Sub CreateH6(hid As String) As VueHTML
	Dim hdr As VueHTML = CreateH(hid,6)
	Return hdr
End Sub


'create horizontal rule
Sub CreateHR(b As Boolean) As VueHTML
	Dim hr As VueHTML
	hr.Initialize("","hr")
	Return hr
End Sub

'create sub
Sub CreateSub(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid, "sub")
	Return s
End Sub

Sub CreateStrong(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid, "strong")
	Return s
End Sub

'create em
Sub CreateEM(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid, "em")
	Return s
End Sub


'create small
Sub CreateSmall(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid,"small")
	Return s
End Sub

'create a span
Sub CreateSpan(sid As String) As VueHTML
	Dim s As VueHTML
	s.Initialize(sid,"span")
	Return s
End Sub

'create an anchor
Sub CreateAnchor(aid As String) As VueHTML
	Dim a As VueHTML
	a.Initialize(aid,"a")
	Return a
End Sub

'create an article
Sub CreateArticle(aid As String) As VueHTML
	Dim a As VueHTML
	a.Initialize(aid,"article")
	Return a
End Sub

'create an aside
Sub CreateAside(aid As String) As VueHTML
	Dim a As VueHTML
	a.Initialize(aid,"aside")
	Return a
End Sub


'create paragraph
Sub CreateParagraph(pid As String) As VueHTML
	Dim p As VueHTML
	p.Initialize(pid, "p")
	Return p
End Sub

'create form
Sub CreateForm(fID As String) As VueHTML
	Dim frm As VueHTML
	frm.Initialize(fID, "form")
	Return frm
End Sub

'create legend
Sub CreateLegend(fID As String, sCaption As String) As VueHTML
	Dim fs As VueHTML
	fs.Initialize(fID, "legend").AddContent(sCaption)
	Return fs
End Sub

'create fieldset
Sub CreateFieldSet(fID As String, sCaption As String) As VueHTML
	Dim fs As VueHTML
	fs.Initialize(fID,"fieldset")
	Dim lgnd As VueHTML = CreateLegend("", sCaption)
	fs.AddElement(lgnd)
	Return fs
End Sub

'create container
Sub CreateContainer(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid,"div").AddClass("container")
	Return div
End Sub

'create container
Sub CreateCANVAS(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid,"canvas")
	Return div
End Sub

'create audio
Sub CreateAUDIO(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid,"audio")
	Return div
End Sub

'create video
Sub CreateVIDEO(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid,"video")
	Return div
End Sub

'create table
Sub CreateTABLE(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "table")
	Return div
End Sub


'create source
Sub CreateSOURCE(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "source")
	Return div
End Sub


'create tr
Sub CreateTR(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "tr")
	Return div
End Sub

Sub CreateTHEAD(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "thead")
	Return div
End Sub


Sub CreateTBODY(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "tbody")
	Return div
End Sub


Sub CreateCAPTION(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid,"caption")
	Return div
End Sub


'create td
Sub CreateTD(cid As String) As VueHTML
	cid = cid.tolowercase
	Dim div As VueHTML
	div.Initialize(cid, "td")
	Return div
End Sub


'create label
Sub CreateLabel(lid As String) As VueHTML
	lid = lid.tolowercase
	Dim lbl As VueHTML
	lbl.Initialize(lid, "label")
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
Sub CreateInput(tid As String) As VueHTML
	tid = tid.tolowercase
	Dim input As VueHTML
	input.Initialize(tid, "input")
	Return input
End Sub

'create text area
Sub CreateTextArea(tid As String) As VueHTML
	Dim ta As VueHTML
	ta.Initialize(tid, "textarea")
	Return ta
End Sub

'create an option
Sub CreateOption(oid As String) As VueHTML
	Dim o As VueHTML
	o.Initialize(oid, "option")
	Return o
End Sub


'create an option group
Sub CreateOptGroup(oid As String) As VueHTML
	Dim o As VueHTML
	o.Initialize(oid, "optgroup")
	Return o
End Sub


'create select
Sub CreateSelect(oid As String) As VueHTML
	Dim o As VueHTML
	o.Initialize(oid, "select")
	Return o
End Sub

'create code
Sub CreateCode(oid As String) As VueHTML
	Dim o As VueHTML
	o.Initialize(oid, "code")
	Return o
End Sub

'create select
Sub CreateSelect1(tid As String, options As List) As VueHTML
	Dim ta As VueHTML
	ta.Initialize(tid, "select")
	For Each opt As Map In options
		Dim optid As String = opt.Get("id")
		Dim optval As String = opt.Get("value")
		Dim thisoption As VueHTML = CreateOption("").SetText(optval)
		thisoption.SetParentID(tid).SetAttrVALUE(optid)
		ta.AddElement(thisoption)
	Next
	Return ta
End Sub

'create input text
Sub CreateInputText(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetAttrTYPE("text")
	Return input
End Sub

'create button
Sub CreateButton(btnID As String) As VueHTML
	Dim b As VueHTML
	b.Initialize(btnID, "button")
	Return b
End Sub

'create input button
Sub CreateInputButton(tid As String, tValue As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetAttrTYPE("button").setattrvalue(tValue)
	Return input
End Sub

'create input reset
Sub CreateInputReset(tid As String, tValue As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetAttrTYPE("reset").setattrvalue(tValue)
	Return input
End Sub

'create input submit
Sub CreateInputSubmit(tid As String, tValue As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("submit").setattrvalue(tValue)
	Return input
End Sub

'create input file
Sub CreateInputFile(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("file")
	Return input
End Sub

'create input date
Sub CreateInputDate(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("date")
	Return input
End Sub

'create input color
Sub CreateInputColor(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("color")
	Return input
End Sub


'create input email
Sub CreateInputEmail(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("email")
	Return input
End Sub

'create input password
Sub CreateInputPassword(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("password")
	Return input
End Sub

'create input checkbox
Sub CreateInputCheckBox(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("checkbox").SetAttr("tabindex","0")
	input.AddAttribute("autocomplete", "off")
	Return input
End Sub

Sub SetAttrAutoCompleteOFF(b As Boolean) As VueHTML
	SetAttr("autocomplete", "off")
	Return Me
End Sub

Sub SetAttrTabIndex(tbi As String) As VueHTML
	SetAttr("tabindex", tbi)
	Return Me	
End Sub


'create input radio
Sub CreateInputRadio(tid As String, tname As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("radio").SetAttrtabindex("0").SetattrNAME(tname)
	input.SetAttrautocomplete("off")
	Return input
End Sub

'create input tel
Sub CreateInputTel(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("tel")
	Return input
End Sub

'create input tel
Sub CreateInputUrl(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("url")
	Return input
End Sub


'create input number
Sub CreateInputNumber(tid As String) As VueHTML
	Dim input As VueHTML = CreateInput(tid).SetattrTYPE("number")
	Return input
End Sub

'create iframe
Sub CreateIFrame(ifid As String) As VueHTML
	Dim i As VueHTML
	i.Initialize(ifid, "iframe")
	Return i
End Sub

