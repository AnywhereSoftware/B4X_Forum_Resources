B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Slider As WElement
	Public ID As String
	Private vue As BANanoVue
End Sub

Public Sub Initialize(v As BANanoVue, sid As String) As WSlider
	ID = sid.ToLowerCase
	vue = v
	Slider.Initialize(vue, ID).SetTag("wired-slider")
	Return Me
End Sub

Sub SetKnobZeroColor(color As String) As WSlider
	SetStyle(CreateMap("--wired-slider-knob-zero-color":color))
	Return Me
End Sub

Sub SetKnobColor(color As String) As WSlider
	SetStyle(CreateMap("--wired-slider-knob-color":color))
	Return Me
End Sub

Sub SetBarColor(color As String) As WSlider
	SetStyle(CreateMap("--wired-slider-bar-color":color))
	Return Me
End Sub

Sub SetKnobRadius(r As Int) As WSlider
	SetAttr(CreateMap("knobradius":r))
	Return Me
End Sub

Sub SetMin(i As Int) As WSlider
	SetAttr(CreateMap("min":i))
	Return Me
End Sub

Sub SetMax(i As Int) As WSlider
	SetAttr(CreateMap("max":i))
	Return Me
End Sub

Sub SetWidth(w As String) As WSlider
	SetStyle(CreateMap("width":w))
	Return Me
End Sub

Sub SetHeight(h As String) As WSlider
	SetStyle(CreateMap("height":h))
	Return Me
End Sub

Sub SetDisabled(b As Boolean) As WSlider
	Slider.SetDisabled(b)
	Return Me
End Sub

Sub SetVModel(k As String) As WSlider
	Slider.SetVModel(k)
	Return Me
End Sub

Sub SetValue(k As String, bind As Boolean) As WSlider
	Slider.SetValue(k,bind)
	Return Me
End Sub

Sub SetVIf(vif As Object) As WSlider
	Slider.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As Object) As WSlider
	Slider.SetVIf(vif)
	Return Me
End Sub

Sub SetID(iID As String, bind As Boolean) As WSlider
	Slider.SetID(iID,bind)
	Return Me
End Sub

Sub SetName(nam As String, bind As Boolean) As WSlider
	Slider.SetName(nam, bind)
	Return Me
End Sub

Sub SetKey(k As String, bind As Boolean) As WSlider
	Slider.SetKey(k, bind)
	Return Me
End Sub

'add a class
Sub AddClass(c As String) As WSlider
	Slider.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As WSlider
	Slider.SetAttr(attr)
	Return Me
End Sub

'set onclick event
Sub SetOnChange(module As Object, methodName As String) As WSlider
	Slider.SetOnChange(module, methodName)
	Return Me
End Sub

Sub SetStyle(m As Map) As WSlider
	Slider.SetStyle(m)
	Return Me
End Sub

Sub SetText(t As String) As WSlider
	Slider.SetText(t)
	Return Me
End Sub

Sub ToString As String
	Return Slider.tostring
End Sub

Sub Render
	vue.SetTemplate(ToString)
End Sub

Sub Pop(p As WElement)
	p.SetText(ToString)
End Sub