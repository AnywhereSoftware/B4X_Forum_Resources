B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Progress As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WProgress
	ID = sid.ToLowerCase
	vue = v
	Progress.Initialize(vue, ID).SetTag("wired-progress")
	'Progress.SetStyle(CreateMap("width":"100%"))
	Return Me
End Sub

Sub SetLabelColor(color As String) As WProgress
	SetStyle(CreateMap("--wired-progress-label-color":color))
	Return Me
End Sub

Sub SetColor(color As String) As WProgress
	SetStyle(CreateMap("--wired-progress-color":color))
	Return Me
End Sub

Sub SetFontSize(fs As String) As WProgress
	SetStyle(CreateMap("--wired-progress-font-size": fs))
	Return Me
End Sub

Sub SetPercentage(b As Boolean) As WProgress
	If b = False Then Return Me
	SetAttr(CreateMap("percentage":"percentage"))
	Return Me
End Sub

Sub SetMin(i As Int) As WProgress
	SetAttr(CreateMap("min":i))
	Return Me
End Sub

Sub SetMax(i As Int) As WProgress
	SetAttr(CreateMap("max":i))
	Return Me
End Sub


Sub SetWidth(w As String) As WProgress
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WProgress
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WProgress
	Progress.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WProgress
	Progress.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WProgress
	Progress.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WProgress
	Progress.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WProgress
	Progress.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WProgress
	Progress.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WProgress
	Progress.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WProgress
	Progress.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WProgress
	Progress.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WProgress
	Progress.SetAttr(attr)
	Return Me
End Sub


Sub SetStyle(m As Map) As WProgress
	Progress.SetStyle(m)
	Return Me
End Sub

Sub SetText(t As String) As WProgress
	Progress.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Progress.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub