B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Button As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WButton
	ID = sid.ToLowerCase
	vue = v
	Button.Initialize(vue, ID).SetTag("wired-button")
	Return Me
End Sub


Sub SetStyle(m As Map) As WButton
	Button.SetStyle(m)
	Return Me
End Sub


Sub SetWidth(w As String) As WButton
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WButton
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetElevation(el As Int) As WButton
	SetAttr(CreateMap("elevation":el))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WButton
	Button.SetDisabled(b)
	Return Me
End Sub

Sub SetBackgroundColor(color As String) As WButton
	Button.SetStyle(CreateMap("background-color":color))
	Return Me
End Sub


'set onclick event
Sub SetOnClick(module As Object, methodName As String) As WButton
	Button.SetOnClick(module, methodName)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WButton
	Button.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WButton
	Button.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WButton
	Button.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WButton
	Button.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WButton
	Button.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WButton
	Button.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WButton
	Button.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WButton
	Button.SetAttr(attr)
	Return Me
End Sub

Sub SetColor(color As String) As WButton
	Button.SetStyle(CreateMap("color":color))
	Return Me
End Sub

Sub SetText(t As String) As WButton
	Button.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Button.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub