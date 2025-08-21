B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public CheckBox As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WCheckBox
	ID = sid.ToLowerCase
	vue = v
	CheckBox.Initialize(vue, ID).SetTag("wired-checkBox")
	Return Me
End Sub

Sub SetIconColor(color As String) As WCheckBox
	SetStyle(CreateMap("--wired-checkbox-icon-color":color))
	Return Me
End Sub

Sub SetWidth(w As String) As WCheckBox
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WCheckBox
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetStyle(m As Map) As WCheckBox
	CheckBox.SetStyle(m)
	Return Me
End Sub

Sub SetChecked(b As Boolean) As WCheckBox
	CheckBox.SetChecked(b)
	Return Me
End Sub


Sub SetDisabled(b As Boolean) As WCheckBox
	CheckBox.SetDisabled(b)
	Return Me
End Sub

Sub SetBackgroundColor(color As String) As WCheckBox
	CheckBox.SetStyle(CreateMap("background-color":color))
	Return Me
End Sub


'set onclick event
Sub SetOnChange(module As Object, methodName As String) As WCheckBox
	CheckBox.SetOnChange(module, methodName)
	Return Me
End Sub

Sub SetVModel(k As String) As WCheckBox
	CheckBox.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WCheckBox
	CheckBox.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WCheckBox
	CheckBox.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WCheckBox
	CheckBox.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WCheckBox
	CheckBox.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WCheckBox
	CheckBox.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WCheckBox
	CheckBox.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WCheckBox
	CheckBox.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WCheckBox
	CheckBox.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WCheckBox
	CheckBox.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return CheckBox.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub