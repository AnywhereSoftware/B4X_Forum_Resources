B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Form As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WForm
	ID = sid.ToLowerCase
	vue = v
	Form.Initialize(vue, ID).SetTag("form")
	Return Me
End Sub

Sub SetVIf(vif As Object) As WForm
	Form.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WForm
	Form.SetVIf(vif)
	Return Me
End Sub


Sub SetStyle(m As Map) As WForm
	Form.SetStyle(m)
	Return Me
End Sub


Sub SetName(nam As String, bind As Boolean) As WForm
	Form.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WForm
	Form.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WForm
	Form.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WForm
	Form.SetAttr(attr)
	Return Me
End Sub

Sub ToString As String
	Return Form.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub