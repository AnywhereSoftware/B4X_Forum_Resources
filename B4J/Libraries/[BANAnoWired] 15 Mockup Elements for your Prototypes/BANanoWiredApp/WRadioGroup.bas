B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public RadioGroup As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WRadioGroup
	ID = sid.ToLowerCase
	vue = v
	RadioGroup.Initialize(vue, ID).SetTag("wired-radio-group")
	Return Me
End Sub
'
'Sub SetSelectedColor(color As String) As WRadioGroup
'	SetStyle(CreateMap("--wired-item-selected-color":color))
'	Return Me
'End Sub

'set onselected event
Sub SetOnSelected(module As Object, methodName As String) As WRadioGroup
	RadioGroup.SetOnSelected(module, methodName)
	Return Me
End Sub

Sub SetWidth(w As String) As WRadioGroup
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WRadioGroup
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetStyle(m As Map) As WRadioGroup
	RadioGroup.SetStyle(m)
	Return Me
End Sub
'
'Sub SetSelectedBackgroundColor(color As String) As WRadioGroup
'	SetStyle(CreateMap("--wired-item-selected-bg":color))
'	Return Me
'End Sub

Sub SetSelected(sel As String) As WRadioGroup
	SetAttr(CreateMap("selected":sel))
	Return Me
End Sub

Sub AddItem(k As String, v As String) As WRadioGroup
	Dim we As WRadio
	we.Initialize(vue, k)
	we.SetName(k,False)
	we.SetValue(k,False).SetText(v)
	we.Pop(RadioGroup)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WRadioGroup
	RadioGroup.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WRadioGroup
	RadioGroup.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WRadioGroup
	RadioGroup.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WRadioGroup
	RadioGroup.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WRadioGroup
	RadioGroup.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WRadioGroup
	RadioGroup.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WRadioGroup
	RadioGroup.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WRadioGroup
	RadioGroup.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WRadioGroup
	RadioGroup.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WRadioGroup
	RadioGroup.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WRadioGroup
	RadioGroup.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return RadioGroup.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub