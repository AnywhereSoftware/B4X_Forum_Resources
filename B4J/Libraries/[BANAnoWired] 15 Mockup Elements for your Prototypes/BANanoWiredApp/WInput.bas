B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Input As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WInput
	ID = sid.ToLowerCase
	vue = v
	Input.Initialize(vue, ID).SetTag("wired-input")
	'Input.SetStyle(CreateMap("width":"100%"))
	Return Me
End Sub

Sub SetType(t As String) As WInput
	Input.SetType(t)
	Return Me
End Sub


Sub SetWidth(w As String) As WInput
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WInput
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetPlaceholder(ph As String) As WInput
	SetAttr(CreateMap("placeholder": ph))
	Return Me
End Sub

Sub SetTypeSearch(b As Boolean) As WInput
	If b = False Then Return Me
	SetType("search")
	Return Me
End Sub

Sub SetTypePassword(b As Boolean) As WInput
	If b = False Then Return Me
	SetType("password")
	Return Me
End Sub


Sub SetTypeTel(b As Boolean) As WInput
	If b = False Then Return Me
	SetType("tel")
	Return Me
End Sub

Sub SetTypeEmail(b As Boolean) As WInput
	If b = False Then Return Me
	SetType("email")
	Return Me
End Sub

Sub SetTypeNumber(b As Boolean) As WInput
	If b = False Then Return Me
	SetType("number")
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WInput
	Input.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WInput
	Input.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WInput
	Input.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WInput
	Input.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WInput
	Input.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WInput
	Input.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WInput
	Input.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WInput
	Input.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WInput
	Input.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WInput
	Input.SetAttr(attr)
	Return Me
End Sub


Sub SetStyle(m As Map) As WInput
	Input.SetStyle(m)
	Return Me
End Sub

Sub SetText(t As String) As WInput
	Input.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Input.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub