B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Combo As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WCombo
	ID = sid.ToLowerCase
	vue = v
	Combo.Initialize(vue, ID).SetTag("wired-combo")
	'Combo.SetStyle(CreateMap("width":"100%"))
	Return Me
End Sub

Sub SetSelectedColor(color As String) As WCombo
	SetStyle(CreateMap("--wired-item-selected-color":color))
	Return Me
End Sub

Sub SetPopupBG(color As String) As WCombo
	SetStyle(CreateMap("--wired-combo-popup-bg":color))
	Return Me
End Sub

'set onselected event
Sub SetOnSelected(module As Object, methodName As String) As WCombo
	Combo.SetOnSelected(module, methodName)
	Return Me
End Sub

Sub SetWidth(w As String) As WCombo
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WCombo
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetStyle(m As Map) As WCombo
	Combo.SetStyle(m)
	Return Me
End Sub

Sub SetSelectedBackgroundColor(color As String) As WCombo
	SetStyle(CreateMap("--wired-item-selected-bg":color))
	Return Me
End Sub

Sub SetSelected(sel As String) As WCombo
	SetAttr(CreateMap("selected":sel))
	Return Me
End Sub

Sub AddItem(k As String, v As String) As WCombo
	Dim we As WElement
	we.Initialize(vue, "").SetTag("wired-item")
	we.SetValue(k,False).SetText(v)
	we.SetName(k, False)
	we.Pop(Combo)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WCombo
	Combo.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WCombo
	Combo.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WCombo
	Combo.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WCombo
	Combo.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WCombo
	Combo.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WCombo
	Combo.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WCombo
	Combo.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WCombo
	Combo.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WCombo
	Combo.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WCombo
	Combo.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WCombo
	Combo.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Combo.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub