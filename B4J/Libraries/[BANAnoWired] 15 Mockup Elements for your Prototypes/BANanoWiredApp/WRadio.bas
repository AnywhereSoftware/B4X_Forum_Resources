B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Radio As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WRadio
	ID = sid.ToLowerCase
	vue = v
	Radio.Initialize(vue, ID).SetTag("wired-radio")
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WRadio
	Radio.SetDisabled(b)
	Return Me
End Sub

Sub SetIconColor(color As String) As WRadio
	SetStyle(CreateMap("--wired-radio-icon-color":color))
	Return Me
End Sub

Sub SetBackgroundColor(color As String) As WRadio
	Radio.SetStyle(CreateMap("background-color":color))
	Return Me
End Sub

Sub SetWidth(w As String) As WRadio
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WRadio
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetStyle(m As Map) As WRadio
	Radio.SetStyle(m)
	Return Me
End Sub


'set onclick event
Sub SetOnChange(module As Object, methodName As String) As WRadio
	Radio.SetOnChange(module, methodName)
	Return Me
End Sub

Sub SetVModel(k As String) As WRadio
	Radio.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WRadio
	Radio.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WRadio
	Radio.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WRadio
	Radio.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WRadio
	Radio.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WRadio
	Radio.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WRadio
	Radio.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WRadio
	Radio.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WRadio
	Radio.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WRadio
	Radio.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Radio.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub