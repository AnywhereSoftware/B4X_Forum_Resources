B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Toggle As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WToggle
	ID = sid.ToLowerCase
	vue = v
	Toggle.Initialize(vue, ID).SetTag("wired-toggle")
	Return Me
End Sub

Sub SetOffColor(color As String) As WToggle
	SetStyle(CreateMap("--wired-toggle-off-color":color))
	Return Me
End Sub

Sub SetOnColor(color As String) As WToggle
	SetStyle(CreateMap("--wired-toggle-on-color":color))
	Return Me
End Sub

Sub SetWidth(w As String) As WToggle
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WToggle
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetStyle(m As Map) As WToggle
	Toggle.SetStyle(m)
	Return Me
End Sub

Sub SetChecked(b As Boolean) As WToggle
	Toggle.SetChecked(b)
	Return Me
End Sub


Sub SetDisabled(b As Boolean) As WToggle
	Toggle.SetDisabled(b)
	Return Me
End Sub

Sub SetBackgroundColor(color As String) As WToggle
	Toggle.SetStyle(CreateMap("background-color":color))
	Return Me
End Sub


'set onclick event
Sub SetOnChange(module As Object, methodName As String) As WToggle
	Toggle.SetOnChange(module, methodName)
	Return Me
End Sub

Sub SetVModel(k As String) As WToggle
	Toggle.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WToggle
	Toggle.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WToggle
	Toggle.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WToggle
	Toggle.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WToggle
	Toggle.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WToggle
	Toggle.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WToggle
	Toggle.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WToggle
	Toggle.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WToggle
	Toggle.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WToggle
	Toggle.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Toggle.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub