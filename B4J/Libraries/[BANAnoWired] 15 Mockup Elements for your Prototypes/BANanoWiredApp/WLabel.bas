B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Label As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WLabel
	ID = sid.ToLowerCase
	vue = v
	Label.Initialize(vue, ID)
	Return Me
End Sub

Sub SetSizeH1(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h1")
	Return Me
End Sub

Sub SetSizeH2(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h2")
	Return Me
End Sub

Sub SetSizeH3(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h3")
	Return Me
End Sub

Sub SetSizeH4(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h4")
	Return Me
End Sub

Sub SetSizeH5(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h5")
	Return Me
End Sub

Sub SetSizeH6(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("h6")
	Return Me
End Sub


Sub SetSizeP(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("p")
	Return Me
End Sub

Sub SetSizeLabel(b As Boolean) As WLabel
	If b = False Then Return Me
	Label.SetTag("label")
	Return Me
End Sub

Sub SetVIf(vif As Object) As WLabel
	Label.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WLabel
	Label.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WLabel
	Label.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WLabel
	Label.SetName(nam, bind)
	Return Me
End Sub

Sub SetFor(fr As String) As WLabel
	SetAttr(CreateMap("for": fr))
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WLabel
	Label.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WLabel
	Label.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WLabel
	Label.SetAttr(attr)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WLabel
	Label.SetDisabled(b)
	Return Me
End Sub

'set onclick event
Sub SetOnClick(module As Object, methodName As String) As WLabel
	Label.SetOnClick(module, methodName)
	Return Me
End Sub

Sub SetText(t As String) As WLabel
	Label.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Label.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub