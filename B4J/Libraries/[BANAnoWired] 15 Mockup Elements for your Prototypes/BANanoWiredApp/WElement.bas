B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12,9
Sub Class_Globals
	Public Element As VueHTML
	Public ID As String
	Private vue As BANanoVue
	Private BANano As BANano
	Public hasContent As Boolean
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WElement
	ID = sid.ToLowerCase
	Element.Initialize(ID,"div")
	vue = v
	hasContent = False
	If ID <> "" Then
		'we need to reference it
		SetRef(ID)
	End If
	Return Me
End Sub

Sub SetChecked(b As Boolean) As WElement
	SetAttr(CreateMap(":checked":b))
	Return Me
End Sub

Sub RemoveClass(className As String) As WElement
	Element.removeClass(className)
	Return Me	
End Sub

Sub Clear(b As Boolean) As WElement
	If b = False Then Return Me
	Element.Clear
	Return Me
End Sub

Sub SetIsHidden(b As Boolean) As WElement
	If b = False Then Return Me
	Element.AddClass("is-hidden")
	Return Me
End Sub

Sub SetType(t As String) As WElement
	Element.SetType(t)
	Return Me
End Sub

Sub SetKey(k As Object, bind As Boolean) As WElement
	If bind Then
		Element.SetAttr(":key", k)
	Else
		Element.SetAttr("key", k)
	End If
	Return Me
End Sub

Sub SetRef(varRef As String) As WElement
	If varRef <> "" Then
		SetAttr(CreateMap("ref": varRef))
	End If
	Return Me
End Sub

Sub SetVText(t As Object) As WElement
	SetAttr(CreateMap("v-text": t))
	Return Me
End Sub

Sub SetVElse(t As Object) As WElement
	SetAttr(CreateMap("v-else": t))
	Return Me
End Sub

Sub SetVElseIf(t As Object) As WElement
	SetAttr(CreateMap("v-else-if": t))
	Return Me
End Sub

Sub SetVOn(t As Object) As WElement
	SetAttr(CreateMap("v-on": t))
	Return Me
End Sub

Sub SetVBind(t As Object) As WElement
	SetAttr(CreateMap("v-bind": t))
	Return Me
End Sub

Sub SetVOnce(t As Object) As WElement
	SetAttr(CreateMap("v-once": t))
	Return Me
End Sub


'set for
Sub SetVFor(item As Object, dataSource As String) As WElement
	If vue.StateExists(dataSource) = False Then
		Log("WElement.SetVFor: The data source state has not been registered, register it first!")
		Return Me
	End If
	Dim sline As String = $"${item} in ${dataSource}"$
	SetAttr(CreateMap("v-for": sline))
	Return Me
End Sub

'set value
Sub SetValue(valueName As Object, bind As Boolean) As WElement
	If bind Then
		SetAttr(CreateMap(":value":valueName))
	Else
		SetAttr(CreateMap("value":valueName))
	End If
	Return Me
End Sub

'set template
Sub SetTemplate(tmp As Object) As WElement
	Element.Clear
	Element.SetText(tmp)
	Return Me
End Sub


Sub SetVHtml(h As Object) As WElement
	Element.SetAttr("v-html", h)
	Return Me
End Sub

Sub SetAutoComplete(auto As String) As WElement
	SetAttr(CreateMap("autocomplete": auto))
	Return Me
End Sub
'
Sub SetName(n As String, bind As Boolean) As WElement
	If bind Then
		SetAttr(CreateMap(":name": n))
	Else
		SetAttr(CreateMap("name": n))
	End If
	Return Me
End Sub

Sub SetID(n As String, bind As Boolean) As WElement
	If bind Then
		SetAttr(CreateMap(":id": n))
	Else
		SetAttr(CreateMap("id": n))
	End If
	Return Me
End Sub

Sub SetVIf(vif As String) As WElement
	vif = vif.ToLowerCase
	If vue.HasState(vif) = False Then
		Dim opt As Map = CreateMap()
		opt.Put(vif, False)
		vue.SetState(opt)
	End If
	Element.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As String) As WElement
	vif = vif.ToLowerCase
	If vue.HasState(vif) = False Then
		Dim opt As Map = CreateMap()
		opt.Put(vif, False)
		vue.SetState(opt)
	End If
	Element.SetVShow(vif)
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

'add a class
Sub AddClass(c As String) As WElement
	Element.AddClass(c)
	Return Me
End Sub

'render the element to parent element
Sub Render1(parent As String)
	BANano.GetElement(parent).Append(ToString)
End Sub

'set color
Sub SetColor(c As Object) As WElement
	SetStyle(CreateMap("color": c))
	Return Me
End Sub

Sub SetStyle(m As Map) As WElement
	Element.SetStyles(m)
	Return Me
End Sub

'add a child element
Sub AddChild(child As WElement) As WElement
	Dim childHTML As String = child.ToString
	Element.SetText(childHTML)
	Return Me
End Sub

'add children
Sub AddChildren(children As List)
	For Each childx As WElement In children
		AddChild(childx)
	Next
End Sub

'set padding
Sub SetBackgroundColor(p As Object) As WElement
	SetStyle(CreateMap("background-color":p))
	Return Me
End Sub


Sub SetPadding(p As Object) As WElement
	SetStyle(CreateMap("padding":p))
	Return Me
End Sub

Sub SetMaxWidth(mw As String) As WElement
	Element.SetStyle("max-width",mw)
	Return Me
End Sub

Sub SetTo(t As Object) As WElement
	Element.SetAttr("to", t)
	Return Me
End Sub

Sub SetHREF(h As String) As WElement
	Element.SetAttrHREF(h)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WElement
	Element.SetAttr(":disabled", b)
	Return Me
End Sub

Sub SetAttr(m As Map) As WElement
	For Each k As String In m.Keys
		Dim v As Object = m.Get(k)
		Element.SetAttr(k, v)
	Next
	Return Me
End Sub

Sub SetScrollBar(b As Boolean) As WElement
	Element.AddClass("md-scrollbar")
	Return Me
End Sub

Sub SetTagAppContent(b As Boolean) As WElement
	Element.SetTag("md-app-content")
	Return Me
End Sub

Sub SetDisplay4(b As Boolean) As WElement
	Element.AddClass("md-display-4")
	Return Me
End Sub

Sub SetDisplay3(b As Boolean) As WElement
	Element.AddClass("md-display-3")
	Return Me
End Sub

Sub SetDisplay2(b As Boolean) As WElement
	Element.AddClass("md-display-2")
	Return Me
End Sub

Sub SetDisplay1(b As Boolean) As WElement
	Element.AddClass("md-display-1")
	Return Me
End Sub

'md-headline
Sub SetHeadline(b As Boolean) As WElement
	Element.AddClass("md-headline")
	Return Me
End Sub

'md-title
Sub SetTitle(b As Boolean) As WElement
	Element.AddClass("md-title")
	Return Me
End Sub

Sub SetAppContent(b As Boolean) As WElement
	Element.SetTag("md-app-content")
	Return Me
End Sub

Sub SetTransparent(b As Boolean) As WElement
	Element.AddClass("md-transparent")
	Return Me
End Sub

Sub SetSRC(s As String) As WElement
	Element.SetSrc(s)
	Return Me
End Sub

Sub SetAlt(a As String) As WElement
	Element.SetAlt(a)
	Return Me
End Sub

Sub SetTagSpan(b As Boolean) As WElement
	Element.SetTag("span")
	Return Me
End Sub

Sub SetVModel(k As String) As WElement
	k = k.tolowercase
	If vue.HasState(k) = False Then
		Dim opt As Map = CreateMap()
		opt.Put(k, Null)
		vue.SetState(opt)
	End If
	Element.SetAttr("v-model", k)
	Return Me
End Sub


Sub SetTag(t As String) As WElement
	Element.SetTag(t)
	Return Me
End Sub

Sub AddElements(lst As List)
	For Each li As WElement In lst
		SetText(li.tostring)
	Next
End Sub

Sub AddElement(el As WElement)
	SetText(el.ToString)
End Sub

Sub SetText(t As String) As WElement
	Element.SetText(t)
	hasContent = True
	Return Me
End Sub

'add to parent element
Sub Pop(p As WElement)
	p.Element.AddElement(Element)
	p.hasContent = True
End Sub

Sub ToString As String
	Return Element.tostring
End Sub

'add to app template
Sub Render
	vue.SetTemplate(ToString)
End Sub

'Triggered when input value changed
Sub SetOnInput(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:input": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub

'Triggered when input gets focus
Sub SetOnFocus(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:focus": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub

'Triggered when input loses focus
Sub SetOnBlur(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:blur": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub

'set pointer
Sub SetPointer(b As Boolean) As WElement
	Element.SetPointer(True)
	Return Me
End Sub

'set onclick event
Sub SetOnClick(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:click": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	SetPointer(True)
	Return Me
End Sub

'set onchange event
Sub SetOnChange(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:change": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub

'set onselected event
Sub SetOnSelected(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:selected": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub

'set ontouch start event
Sub SetOnTouchStart(module As Object, methodName As String) As WElement
	methodName = methodName.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, e)
	SetAttr(CreateMap("v-on:touchstart": methodName))
	'add to methods
	vue.SetMethod(methodName, cb)
	Return Me
End Sub