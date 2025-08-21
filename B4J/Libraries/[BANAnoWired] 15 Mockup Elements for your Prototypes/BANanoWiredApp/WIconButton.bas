B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public IconButton As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WIconButton
	ID = sid.ToLowerCase
	vue = v
	IconButton.Initialize(vue, ID).SetTag("wired-icon-button")
	Return Me
End Sub

Sub SetIconSize(size As String) As WIconButton
	SetStyle(CreateMap("--wired-icon-size":size))
	Return Me
End Sub

Sub SetStyle(m As Map) As WIconButton
	IconButton.SetStyle(m)
	Return Me
End Sub


Sub SetWidth(w As String) As WIconButton
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WIconButton
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetElevation(el As Int) As WIconButton
	SetAttr(CreateMap("elevation":el))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WIconButton
	IconButton.SetDisabled(b)
	Return Me
End Sub

Sub SetBackgroundColor(color As String) As WIconButton
	SetStyle(CreateMap("--wired-icon-bg-color":color))
	Return Me
End Sub

'set onclick event
Sub SetOnClick(module As Object, methodName As String) As WIconButton
	IconButton.SetOnClick(module, methodName)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WIconButton
	IconButton.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WIconButton
	IconButton.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WIconButton
	IconButton.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WIconButton
	IconButton.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WIconButton
	IconButton.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WIconButton
	IconButton.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WIconButton
	IconButton.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WIconButton
	IconButton.SetAttr(attr)
	Return Me
End Sub

Sub SetColor(color As String) As WIconButton
	IconButton.SetStyle(CreateMap("color":color))
	Return Me
End Sub

Sub SetText(t As String) As WIconButton
	IconButton.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return IconButton.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub