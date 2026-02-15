B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Mini CSS Generator class
' Version 0.20
Sub Class_Globals
	Private rules As Map
	Private mediaQueries As Map
	Private variables As Map
	Private currentSelector As String
	Private prefix As String
	Private mIndent As String          ' Indentation string (default: "  ")
	Private mUseTabs As Boolean        ' Optional: use tabs instead of spaces
	Private mIndentSize As Int         ' Number of spaces (if not using tabs)
	Private mStartIndent As String
End Sub

Public Sub Initialize (Name As String)
	rules.Initialize
	mediaQueries.Initialize
	variables.Initialize
	currentSelector = ""
	prefix = ""
	mIndent = "  " ' Default 2 spaces
	mUseTabs = False
	mIndentSize = 2
	mStartIndent = ""
End Sub

' Add a new CSS rule
Public Sub AddRule (selector As String) As MiniCss
	currentSelector = selector
	If rules.ContainsKey(selector) = False Then
		Dim ruleMap As Map
		ruleMap.Initialize
		rules.Put(selector, ruleMap)
	End If
	
	Return Me
End Sub

' Add a property to current rule
Public Sub AddProperty (propertyName As String, value As Object) As MiniCss
	If currentSelector <> "" Then
		Dim ruleMap As Map = rules.Get(currentSelector)
		ruleMap.Put(propertyName, value)
	End If
	
	Return Me
End Sub

' Add multiple properties at once
Public Sub AddProperties (properties As Map) As MiniCss
	If currentSelector <> "" Then
		Dim ruleMap As Map = rules.Get(currentSelector)
		For Each key As String In properties.Keys
			ruleMap.Put(key, properties.Get(key))
		Next
	End If
	
	Return Me
End Sub

' Create a CSS variable
Public Sub AddVariable (name As String, value As String)
	variables.Put(name, value)
End Sub

' Add media query
Public Sub AddMediaQuery (condition As String) As MiniCss
	If mediaQueries.ContainsKey(condition) = False Then
		Dim queryMap As Map
		queryMap.Initialize
		mediaQueries.Put(condition, queryMap)
	End If
	
	Return Me
End Sub

' Add rule to current media query
Public Sub AddRuleToMedia (selector As String, properties As Map) As MiniCss
	Dim lastKey As String = GetLastMediaKey
	If lastKey <> "" Then
		Dim queryMap As Map = mediaQueries.Get(lastKey)
		queryMap.Put(selector, properties)
	End If
	
	Return Me
End Sub

' Set vendor prefixes
Public Sub SetPrefix (vPrefix As String)
	prefix = vPrefix
End Sub

' Generate final CSS string
Public Sub GenerateCSS As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(CRLF) ' new line
	
	' Add CSS variables (custom properties)
	Dim plural As Boolean ' adjusted by aeric
	If variables.Size > 0 Then
		If plural Then sb.Append(CRLF).Append(CRLF)
		sb.Append(mStartIndent)
		sb.Append(":root {").Append(CRLF)
		For Each varName As String In variables.Keys
			Dim varValue As String = variables.Get(varName)
			sb.Append(mStartIndent)
			sb.Append(mIndent).Append(varName).Append(": ").Append(varValue).Append(";").Append(CRLF)
		Next
		sb.Append(mStartIndent)
		sb.Append("}")
		plural = True
	End If
    
	' Add regular rules
	plural = False
	For Each selector As String In rules.Keys
		If plural Then sb.Append(CRLF).Append(CRLF)
		sb.Append(mStartIndent)
		sb.Append(selector).Append(" {").Append(CRLF)
		Dim ruleMap As Map = rules.Get(selector)
		For Each prop As String In ruleMap.Keys
			Dim value As Object = ruleMap.Get(prop)
			If prefix <> "" Then
				sb.Append(mStartIndent)
				sb.Append("  -").Append(prefix).Append("-").Append(prop).Append(": ").Append(value).Append(";").Append(CRLF)
			End If
			sb.Append(mStartIndent)
			sb.Append(mIndent).Append(prop).Append(": ").Append(value).Append(";").Append(CRLF)
		Next
		sb.Append(mStartIndent)
		sb.Append("}")
		plural = True
	Next
    
	' Add media queries
	For Each condition As String In mediaQueries.Keys
		sb.Append(CRLF).Append(CRLF)
		sb.Append(mStartIndent)
		sb.Append("@media ").Append(condition).Append(" {").Append(CRLF)
		Dim queryMap As Map = mediaQueries.Get(condition)
		For Each selector As String In queryMap.Keys
			sb.Append(mStartIndent)
			sb.Append(mIndent).Append(selector).Append(" {").Append(CRLF)
			Dim props As Map = queryMap.Get(selector)
			For Each prop As String In props.Keys
				Dim value As Object = props.Get(prop)
				sb.Append(mStartIndent)
				' Double indent for properties inside media query
				sb.Append(mIndent).Append(mIndent).Append(prop).Append(": ").Append(value).Append(";").Append(CRLF)
			Next
			sb.Append(mStartIndent)
			sb.Append("  }").Append(CRLF)
		Next
		sb.Append(mStartIndent)
		sb.Append("}")
	Next
	
	Return sb.ToString
End Sub

Public Sub SetStartIndent (IndentString As String)
	mStartIndent = IndentString
End Sub

' Generate CSS with minification
Public Sub GenerateMinifiedCSS As String
	Dim css As String = GenerateCSS
	' Remove comments, whitespace, line breaks (unchanged)
	css = css.Replace(CRLF, "")
	css = css.Replace(mIndent, "")   ' Remove current indent
	css = css.Replace(" { ", "{")
	css = css.Replace(" } ", "}")
	css = css.Replace(" : ", ":")
	css = css.Replace("; ", ";")
	' Also remove any other whitespace patterns
	Return css
End Sub

' Export to file
Public Sub ExportToFile (filePath As String, minify As Boolean)
	Dim css As String
	If minify Then
		css = GenerateMinifiedCSS
	Else
		css = GenerateCSS
	End If
    
	Dim out As OutputStream
	out = File.OpenOutput(File.DirApp, filePath, False)
	out.WriteBytes(css.GetBytes("UTF8"), 0, css.Length)
	out.Close
End Sub

' Clear all rules
Public Sub Clear
	rules.Clear
	mediaQueries.Clear
	variables.Clear
	currentSelector = ""
End Sub

' Set custom indentation string (e.g., "    " or vbTab)
Public Sub setIndent (IndentString As String)
	mIndent = IndentString
	mUseTabs = (IndentString = TAB)    ' Optional detection
End Sub

Public Sub getUseTab As Boolean
	Return mUseTabs
End Sub

' Set indentation by number of spaces
Public Sub setIndentSize (Size As Int)
	mIndentSize = Max(1, Size)
	mIndent = ""
	For i = 1 To mIndentSize
		mIndent = mIndent & " "
	Next
End Sub

' Switch to tab indentation
Public Sub setTabSize (Size As Int)
	mUseTabs = True
	mIndent = TAB
	mIndentSize = Size   ' store for reference (not used in string)
End Sub

' Get current indent string
Public Sub getIndent As String
	Return mIndent
End Sub

Private Sub GetLastMediaKey As String
	Dim keys As List
	keys.Initialize
	For Each key As String In mediaQueries.Keys
		keys.Add(key)
	Next
	If keys.Size > 0 Then
		Return keys.Get(keys.Size - 1)
	Else
		Return ""
	End If
End Sub

' Parse and add raw CSS string to current selector
Public Sub ParseRawCSS (cssString As String) As MiniCss
	If currentSelector = "" Then Return Me
    
	Dim properties() As String = Regex.Split(";", cssString)
    
	For Each prop As String In properties
		prop = prop.Trim
		If prop.Length > 0 Then
			Dim parts() As String = Regex.Split(":", prop)
			If parts.Length >= 2 Then
				Dim name As String = parts(0).Trim
				' Combine all parts after the first colon (in case value contains colons)
				Dim value As StringBuilder
				value.Initialize
				For i = 1 To parts.Length - 1
					If i > 1 Then value.Append(":")
					value.Append(parts(i))
				Next
				Dim finalValue As String = value.ToString.Trim
                
				' Remove trailing semicolon
				If finalValue.EndsWith(";") Then
					finalValue = finalValue.SubString2(0, finalValue.Length - 1)
				End If
                
				AddProperty(name, finalValue)
			End If
		End If
	Next
    
	Return Me
End Sub

' Parse full CSS block including nested rules
Public Sub ParseCSSBlock (selector As String, cssBlock As String) As MiniCss
	' Split into individual rule blocks
	cssBlock = cssBlock.Trim
    
	' Handle media queries
	If cssBlock.StartsWith("@media") Then
		Dim conditionStart As Int = cssBlock.IndexOf("(")
		Dim conditionEnd As Int = cssBlock.IndexOf2(")", conditionStart)
		If conditionStart > -1 And conditionEnd > -1 Then
			Dim condition As String = cssBlock.SubString2(conditionStart, conditionEnd + 1)
			AddMediaQuery(condition)
            
			' Extract inner content
			Dim blockStart As Int = cssBlock.IndexOf("{")
			Dim blockEnd As Int = cssBlock.LastIndexOf("}")
			If blockStart > -1 And blockEnd > -1 Then
				Dim innerCSS As String = cssBlock.SubString2(blockStart + 1, blockEnd)
				ParseInnerRules(innerCSS, True)
			End If
		End If
	Else
		' Regular CSS block
		AddRule(selector)
		ParseRawCSS(cssBlock)
	End If
    
	Return Me
End Sub

Private Sub ParseInnerRules (cssContent As String, isMediaQuery As Boolean)
	' This is a simplified parser for nested rules
	' For a full implementation, you'd need a proper CSS parser
	Dim lines() As String = Regex.Split("}", cssContent)
    
	For Each line As String In lines
		line = line.Trim
		If line.Length > 0 Then
			Dim braceIndex As Int = line.IndexOf("{")
			If braceIndex > -1 Then
				Dim innerSelector As String = line.SubString2(0, braceIndex).Trim
				Dim innerProps As String = line.SubString(braceIndex + 1).Trim
                
				If isMediaQuery Then
					' Add to current media query
					Dim propsMap As Map = ParseRawToMap(innerProps)
					Dim lastKey As String = GetLastMediaKey
					If lastKey <> "" Then
						Dim queryMap As Map = mediaQueries.Get(lastKey)
						queryMap.Put(innerSelector, propsMap)
					End If
				Else
					' Add as regular rule
					AddRule(innerSelector)
					ParseRawCSS(innerProps)
				End If
			End If
		End If
	Next
End Sub

Private Sub ParseRawToMap (cssString As String) As Map
	Dim result As Map
	result.Initialize
    
	Dim properties() As String = Regex.Split(";", cssString)
    
	For Each prop As String In properties
		prop = prop.Trim
		If prop.Length > 0 Then
			Dim colonIndex As Int = prop.IndexOf(":")
			If colonIndex > -1 Then
				Dim name As String = prop.SubString2(0, colonIndex).Trim
				Dim value As String = prop.SubString(colonIndex + 1).Trim
                
				' Remove trailing semicolon
				If value.EndsWith(";") Then
					value = value.SubString2(0, value.Length - 1)
				End If
                
				result.Put(name, value)
			End If
		End If
	Next
    
	Return result
End Sub