B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' CSS Presets class (Common Styles)
' Version 0.20
Sub Class_Globals
	Private css As MiniCss
End Sub

Public Sub Initialize (vCSS As MiniCss)
	css = vCSS
End Sub

' Flexbox center alignment
Public Sub AddFlexCenter (selector As String)
	css.AddRule(selector)
	Dim props As Map
	props.Initialize
	props.Put("display", "flex")
	props.Put("justify-content", "center")
	props.Put("align-items", "center")
	css.AddProperties(props)
End Sub

' Card style
Public Sub AddCardStyle (selector As String)
	css.AddRule(selector)
	Dim props As Map
	props.Initialize
	props.Put("border-radius", "8px")
	props.Put("box-shadow", "0 2px 4px rgba(0,0,0,0.1)")
	props.Put("padding", "16px")
	props.Put("background-color", "white")
	props.Put("margin", "8px")
	css.AddProperties(props)
End Sub

' Button style
Public Sub AddButtonStyle (selector As String, primary As Boolean)
	css.AddRule(selector)
	Dim props As Map
	props.Initialize
    
	If primary Then
		props.Put("background-color", "#007bff")
		props.Put("color", "white")
	Else
		props.Put("background-color", "#6c757d")
		props.Put("color", "white")
	End If
    
	props.Put("border", "none")
	props.Put("padding", "10px 20px")
	props.Put("border-radius", "4px")
	props.Put("cursor", "pointer")
	props.Put("font-size", "14px")
	props.Put("transition", "background-color 0.3s")
    
	' Hover state
	css.AddProperties(props)
    
	' Add hover effect
	css.AddRule(selector & ":hover")
	Dim hoverProps As Map
	hoverProps.Initialize
	If primary Then
		hoverProps.Put("background-color", "#0056b3")
	Else
		hoverProps.Put("background-color", "#545b62")
	End If
	css.AddProperties(hoverProps)
End Sub

' Grid layout
Public Sub AddGridLayout (selector As String, columns As Int, gap As String)
	css.AddRule(selector)
	Dim props As Map
	props.Initialize
	props.Put("display", "grid")
	props.Put("grid-template-columns", "repeat(" & columns & ", 1fr)")
	props.Put("gap", gap)
	css.AddProperties(props)
End Sub

' Responsive text
Public Sub AddResponsiveText (selector As String)
	css.AddRule(selector)
	Dim props As Map
	props.Initialize
	props.Put("font-size", "clamp(1rem, 2.5vw, 2rem)")
	props.Put("line-height", "1.6")
	css.AddProperties(props)
End Sub