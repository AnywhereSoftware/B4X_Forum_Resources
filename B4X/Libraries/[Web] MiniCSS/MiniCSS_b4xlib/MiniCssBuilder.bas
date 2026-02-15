B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' CSS Builder Helper class (for fluent syntax)
' Version 0.20
Sub Class_Globals
	Private css As MiniCss
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (vCSS As MiniCss)
	css = vCSS
End Sub

Public Sub SetIndent (IndentString As String) As MiniCssBuilder
	css.SetIndent(IndentString)
	Return Me
End Sub

Public Sub SetIndentSize (Size As Int) As MiniCssBuilder
	css.SetIndentSize(Size)
	Return Me
End Sub

Public Sub SetUseTabs (Size As Int) As MiniCssBuilder
	css.TabSize = Size
	Return Me
End Sub

' Start building a rule
Public Sub Rule (selector As String) As MiniCssBuilder
	css.AddRule(selector)
	Return Me
End Sub

' Chainable property methods
Public Sub Width (value As String) As MiniCssBuilder
	css.AddProperty("width", value)
	Return Me
End Sub

Public Sub Height (value As String) As MiniCssBuilder
	css.AddProperty("height", value)
	Return Me
End Sub

Public Sub MaxWidth (value As String) As MiniCssBuilder
	css.AddProperty("max-width", value)
	Return Me
End Sub

Public Sub Margin (value As String) As MiniCssBuilder
	css.AddProperty("margin", value)
	Return Me
End Sub

Public Sub Padding (value As String) As MiniCssBuilder
	css.AddProperty("padding", value)
	Return Me
End Sub

Public Sub Color (value As String) As MiniCssBuilder
	css.AddProperty("color", value)
	Return Me
End Sub

Public Sub BackgroundColor (value As String) As MiniCssBuilder
	css.AddProperty("background-color", value)
	Return Me
End Sub

Public Sub FontSize (value As String) As MiniCssBuilder
	css.AddProperty("font-size", value)
	Return Me
End Sub

Public Sub FontFamily (value As String) As MiniCssBuilder
	css.AddProperty("font-family", value)
	Return Me
End Sub

Public Sub Border (value As String) As MiniCssBuilder
	css.AddProperty("border", value)
	Return Me
End Sub

Public Sub Display (value As String) As MiniCssBuilder
	css.AddProperty("display", value)
	Return Me
End Sub

Public Sub Flex (value As String) As MiniCssBuilder
	css.AddProperty("flex", value)
	Return Me
End Sub

Public Sub JustifyContent (value As String) As MiniCssBuilder
	css.AddProperty("justify-content", value)
	Return Me
End Sub

Public Sub AlignItems (value As String) As MiniCssBuilder
	css.AddProperty("align-items", value)
	Return Me
End Sub

' Custom property
Public Sub Property (name As String, value As String) As MiniCssBuilder
	css.AddProperty(name, value)
	Return Me
End Sub

' Add multiple properties
Public Sub Properties (props As Map) As MiniCssBuilder
	css.AddProperties(props)
	Return Me
End Sub


' Parse a raw CSS string and add properties
Public Sub ParseRaw (cssString As String) As MiniCssBuilder
	'If currentSelector = "" Then Return Me
    
	' Remove comments if any
	cssString = RemoveCSSComments(cssString)
    
	' Split by semicolon and parse each property
	Dim Props() As String = Regex.Split(";", cssString)
    
	For Each prop As String In Props
		prop = prop.Trim
		If prop.Length > 0 Then
			Dim colonIndex As Int = prop.IndexOf(":")
			If colonIndex > -1 Then
				Dim name As String = prop.SubString2(0, colonIndex).Trim
				Dim value As String = prop.SubString(colonIndex + 1).Trim
                
				' Remove trailing semicolon if present
				If value.EndsWith(";") Then
					value = value.SubString2(0, value.Length - 1)
				End If
                
				css.AddProperty(name, value)
			End If
		End If
	Next
    
	Return Me
End Sub

' Parse raw CSS with potential nested rules (like :hover, @media)
Public Sub ParseRawWithRules (selector As String, cssString As String) As MiniCssBuilder
	' Main rule
	Dim mainRuleEnd As Int = cssString.IndexOf("{")
	If mainRuleEnd > -1 Then
		' Extract main properties
		Dim ruleEnd As Int = cssString.IndexOf2("}", mainRuleEnd)
		If ruleEnd > -1 Then
			Dim mainContent As String = cssString.SubString2(mainRuleEnd + 1, ruleEnd)
            
			' Add the main rule
			Rule(selector)
			ParseRaw(mainContent)
            
			' Check for nested rules
			Dim remaining As String = cssString.SubString(ruleEnd + 1).Trim
			If remaining.Length > 0 Then
				ParseNestedRules(selector, remaining)
			End If
		End If
	Else
		' Simple properties without braces
		Rule(selector)
		ParseRaw(cssString)
	End If
    
	Return Me
End Sub

Private Sub ParseNestedRules (baseSelector As String, cssString As String)
	' This method can be expanded to handle :hover, :focus, @media, etc.
	' For now, it handles simple pseudo-classes
	Dim lines() As String = Regex.Split(CRLF, cssString)
    
	For Each line As String In lines
		line = line.Trim
		If line.Length > 0 Then
			If line.Contains("{") Then
				' Extract pseudo selector and content
				Dim braceIndex As Int = line.IndexOf("{")
				Dim pseudoSelector As String = line.SubString2(0, braceIndex).Trim
				Dim endBraceIndex As Int = line.IndexOf("}")
				If endBraceIndex > -1 Then
					Dim content As String = line.SubString2(braceIndex + 1, endBraceIndex)
                    
					' Combine with base selector
					Dim fullSelector As String
					If pseudoSelector.StartsWith("&") Then
						fullSelector = baseSelector & pseudoSelector.SubString(1)
					Else If pseudoSelector.StartsWith(":") Or pseudoSelector.StartsWith("[") Then
						fullSelector = baseSelector & pseudoSelector
					Else
						fullSelector = pseudoSelector
					End If
                    
					' Add the rule
					css.AddRule(fullSelector)
					ParseRaw(content)
				End If
			End If
		End If
	Next
End Sub

Private Sub RemoveCSSComments (cssString As String) As String
	' Remove single-line and multi-line comments
	Dim result As String = cssString
    
	' Remove multi-line comments /* ... */
	Do While result.IndexOf("/*") > -1
		Dim startComment As Int = result.IndexOf("/*")
		Dim endComment As Int = result.IndexOf2("*/", startComment)
		If endComment > -1 Then
			result = result.SubString2(0, startComment) & result.SubString(endComment + 2)
		Else
			Exit ' Malformed CSS
		End If
	Loop
    
	Return result
End Sub