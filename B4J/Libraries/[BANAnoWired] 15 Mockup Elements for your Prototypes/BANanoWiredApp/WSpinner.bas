B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Spinner As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WSpinner
	ID = sid.ToLowerCase
	vue = v
	Spinner.Initialize(vue, ID).SetTag("wired-spinner")
	Return Me
End Sub

Sub SetSpinning(valueName As Object, bind As Boolean) As WSpinner
	If bind Then
		SetAttr(CreateMap(":spinning":valueName))
	Else
		SetAttr(CreateMap("spinning":valueName))
	End If
	Return Me
End Sub

Sub SetDuration(i As Int) As WSpinner
	SetAttr(CreateMap("duration":i))
	Return Me
End Sub

Sub SetWidth(w As String) As WSpinner
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WSpinner
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WSpinner
	Spinner.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WSpinner
	Spinner.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WSpinner
	Spinner.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WSpinner
	Spinner.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WSpinner
	Spinner.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WSpinner
	Spinner.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WSpinner
	Spinner.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WSpinner
	Spinner.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WSpinner
	Spinner.AddClass(c)
	Return Me
End Sub

Sub SetColor(color As String) As WSpinner
	Spinner.SetStyle(CreateMap("color":color))
	Return Me
End Sub


'set an attribute
Sub SetAttr(attr As Map) As WSpinner
	Spinner.SetAttr(attr)
	Return Me
End Sub

Sub SetStyle(m As Map) As WSpinner
	Spinner.SetStyle(m)
	Return Me
End Sub

Sub SetText(t As String) As WSpinner
	Spinner.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Spinner.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub