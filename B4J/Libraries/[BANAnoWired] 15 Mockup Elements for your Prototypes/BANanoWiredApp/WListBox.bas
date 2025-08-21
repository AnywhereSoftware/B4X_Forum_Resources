B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public ListBox As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WListBox
	ID = sid.ToLowerCase
	vue = v
	ListBox.Initialize(vue, ID).SetTag("wired-listbox")
	'ListBox.SetStyle(CreateMap("width":"100%"))
	Return Me
End Sub

Sub SetSelectedColor(color As String) As WListBox
	SetStyle(CreateMap("--wired-item-selected-color":color))
	Return Me
End Sub

Sub SetWidth(w As String) As WListBox
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WListBox
	SetStyle(CreateMap("height":h))
	Return Me
End Sub


Sub SetStyle(m As Map) As WListBox
	ListBox.SetStyle(m)
	Return Me
End Sub

Sub SetSelectedBackgroundColor(color As String) As WListBox
	SetStyle(CreateMap("--wired-item-selected-bg":color))
	Return Me
End Sub

Sub SetSelected(sel As String) As WListBox
	SetAttr(CreateMap("selected":sel))
	Return Me
End Sub

Sub AddItem(k As String, v As String) As WListBox
	Dim we As WElement
	we.Initialize(vue, "").SetTag("wired-item")
	we.SetValue(k,False).SetText(v)
	we.SetName(k, False)
	we.Pop(ListBox)
	Return Me
End Sub

Sub SetHorizontal(b As Boolean) As WListBox
	If b = False Then Return Me
	SetAttr(CreateMap("horizontal":"horizontal"))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WListBox
	ListBox.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WListBox
	ListBox.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WListBox
	ListBox.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WListBox
	ListBox.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WListBox
	ListBox.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WListBox
	ListBox.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WListBox
	ListBox.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WListBox
	ListBox.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WListBox
	ListBox.AddClass(c)
	Return Me
End Sub

'set onselected event
Sub SetOnSelected(module As Object, methodName As String) As WListBox
	ListBox.SetOnSelected(module, methodName)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WListBox
	ListBox.SetAttr(attr)
	Return Me
End Sub

Sub SetText(t As String) As WListBox
	ListBox.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return ListBox.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub