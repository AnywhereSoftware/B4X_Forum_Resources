B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Tabs As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WTabs
	ID = sid.ToLowerCase
	vue = v
	Tabs.Initialize(vue, ID).SetTag("wired-tabs")
	SetStyle(CreateMap("margin": "0 auto"))
	Return Me
End Sub

Sub SetSelected(el As String) As WTabs
	SetAttr(CreateMap("selected":el))
	Return Me
End Sub

Sub AddItem(itemID As String, itemLabel As String, itemContent As WElement)
	Dim item As WElement
	item.Initialize(vue, itemID).SetName(itemID,False)
	item.SetTag("wired-tab")
	Dim h4 As WLabel
	h4.Initialize(vue,"").SetSizeH4(True).SetText(itemLabel)
	h4.Pop(item)
	itemContent.Pop(item)
	item.Pop(Tabs) 
End Sub

Sub SetElevation(el As Int) As WTabs
	SetAttr(CreateMap("elevation":el))
	Return Me
End Sub

Sub SetWidth(w As String) As WTabs
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WTabs
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetStyle(m As Map) As WTabs
	Tabs.SetStyle(m)
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WTabs
	Tabs.SetDisabled(b)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WTabs
	Tabs.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WTabs
	Tabs.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WTabs
	Tabs.SetID(iID,bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WTabs
	Tabs.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WTabs
	Tabs.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WTabs
	Tabs.SetAttr(attr)
	Return Me
End Sub

Sub SetSelectedBG(color As String) As WTabs
	SetStyle(CreateMap("--wired-item-selected-bg":color))
	Return Me
End Sub

Sub SetSelectedColor(color As String) As WTabs
	SetStyle(CreateMap("--wired-item-selected-color":color))
	Return Me
End Sub

Sub SetText(t As String) As WTabs
	Tabs.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Tabs.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub