B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Card As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WCard
	ID = sid.ToLowerCase
	vue = v
	Card.Initialize(vue, ID).SetTag("wired-card")
	SetStyle(CreateMap("margin": "0 0 8px"))
	Return Me
End Sub

Sub SetElevation(el As Int) As WCard
	SetAttr(CreateMap("elevation":el))
	Return Me
End Sub

Sub AddElement(el As WElement)
	SetText(el.ToString)
End Sub

Sub SetWidth(w As String) As WCard
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WCard
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetStyle(m As Map) As WCard
	Card.SetStyle(m)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WCard
	Card.SetDisabled(b)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WCard
	Card.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WCard
	Card.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WCard
	Card.SetID(iID,bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WCard
	Card.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WCard
	Card.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WCard
	Card.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WCard
	Card.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Card.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub