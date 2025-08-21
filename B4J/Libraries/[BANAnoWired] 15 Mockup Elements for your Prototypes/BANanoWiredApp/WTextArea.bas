B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public TextArea As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WTextArea
	ID = sid.ToLowerCase
	vue = v
	TextArea.Initialize(vue, ID).SetTag("wired-textarea")
	SetRows(8)
	Return Me
End Sub

Sub SetMaxRows(r As Int) As WTextArea
	SetAttr(CreateMap("maxrows":r))
	Return Me
End Sub

Sub SetRows(r As Int) As WTextArea
	SetAttr(CreateMap("rows":r))
	Return Me
End Sub

Sub SetWidth(w As String) As WTextArea
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WTextArea
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetPlaceholder(ph As String) As WTextArea
	SetAttr(CreateMap("placeholder": ph))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WTextArea
	TextArea.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WTextArea
	TextArea.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WTextArea
	TextArea.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WTextArea
	TextArea.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WTextArea
	TextArea.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WTextArea
	TextArea.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WTextArea
	TextArea.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WTextArea
	TextArea.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WTextArea
	TextArea.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WTextArea
	TextArea.SetAttr(attr)
	Return Me
End Sub


Sub SetStyle(m As Map) As WTextArea
	TextArea.SetStyle(m)
	Return Me
End Sub

Sub SetText(t As String) As WTextArea
	TextArea.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return TextArea.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub