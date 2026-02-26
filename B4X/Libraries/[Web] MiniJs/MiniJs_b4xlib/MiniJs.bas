B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
    Private jsCode As StringBuilder
    Private currentIndent As Int
End Sub

Public Sub Initialize
    jsCode.Initialize
    currentIndent = 0
End Sub

' Generate the complete JavaScript code
Public Sub Generate As String
    'Return jsCode.ToString
    Dim scriptBuilder As StringBuilder
	scriptBuilder.Initialize
	scriptBuilder.Append("<script>")
	scriptBuilder.Append(GetIndent).Append(jsCode)
	scriptBuilder.Append("</script>")
	Return scriptBuilder.ToString
End Sub

' Generate the complete JavaScript code without script tag
Public Sub Generate2 As String
    'Return jsCode.ToString
    Dim scriptBuilder As StringBuilder
	scriptBuilder.Initialize
	scriptBuilder.Append(GetIndent).Append(jsCode)
	Return scriptBuilder.ToString
End Sub

' Add a line of JavaScript code
Public Sub AddLine (code As String)
    Dim indentStr As String = GetIndent
    jsCode.Append(indentStr).Append(code).Append(CRLF)
End Sub

' Add raw code without formatting
Public Sub AddCode (code As String)
    jsCode.Append(code)
End Sub

' // comment
Public Sub AddComment (comment As String)
    AddLine("// " & comment)
End Sub

' /* multi-line comment */
Public Sub AddMultiLineComment (comment As String)
    AddLine("/*")
    Dim lines() As String = Regex.Split(CRLF, comment)
    For Each line As String In lines
        AddLine(" * " & line)
    Next
    AddLine(" */")
End Sub

' console.error(message, event)
Public Sub ConsoleError (message As String, event As String)
    AddLine($"console.error(${message}, ${event});"$)
End Sub

' console.log(message)
Public Sub ConsoleLog (message As String)
    AddLine($"console.log(${message});"$)
End Sub

' if (condition) statement
Public Sub AddConditionalCall (condition As String, call As String)
    AddLine($"if (${condition}) ${call}"$)
End Sub

' condition ? expressionIfTrue : expressionIfFalse
Public Sub AddTernary (condition As String, expressionIfTrue As String, expressionIfFalse As String)
    AddLine($"${condition} ? ${expressionIfTrue} : ${expressionIfFalse}"$)
End Sub

Private Sub GetIndent As String
    Dim sb As StringBuilder
    sb.Initialize
    For i = 0 To currentIndent - 1
        sb.Append("    ") ' 4 spaces per indent
    Next
    Return sb.ToString
End Sub

Public Sub IncreaseIndent
	currentIndent = currentIndent + 1
End Sub

Public Sub DecreaseIndent
	currentIndent = currentIndent - 1
End Sub

' Start a function
Public Sub StartFunction (name As String, parameters() As String)
	Dim paramList As String
	'paramList = ",".Join(parameters)
	For Each prm As String In parameters
		If paramList <> "" Then paramList = paramList & ", "
		paramList = paramList & prm
	Next
	AddLine($"function ${name} (${paramList}) {"$)
	currentIndent = currentIndent + 1
End Sub

' End a function
Public Sub EndFunction
    currentIndent = currentIndent - 1
    AddLine("}")
End Sub

' if (condition) {
Public Sub StartIf (condition As String)
    AddLine($"if (${condition}) {"$)
    currentIndent = currentIndent + 1
End Sub

' } else if (condition) {
Public Sub ElseIf (condition As String)
    currentIndent = currentIndent - 1
    AddLine($"} else if (${condition}) {"$)
    currentIndent = currentIndent + 1
End Sub

' } else {
Public Sub AddElse
    currentIndent = currentIndent - 1
    AddLine("} else {")
    currentIndent = currentIndent + 1
End Sub

' }
Public Sub EndIf
    currentIndent = currentIndent - 1
    AddLine("}")
End Sub

' for (initializer; condition; increment) {
' <code>script1.StartForLoop("let i = 0", "i < items.length", "i++")</code>
Public Sub StartForLoop (initializer As String, condition As String, increment As String)
    AddLine($"for (${initializer}; ${condition}; ${increment}) {"$)
    currentIndent = currentIndent + 1
End Sub

' }
Public Sub EndForLoop
    currentIndent = currentIndent - 1
    AddLine("}")
End Sub

' try {
Public Sub StartTry
    AddLine($"try {"$)
    currentIndent = currentIndent + 1
End Sub

' } catch (e) {
' <code>script1.AddCatch("e")</code>
Public Sub AddCatch (event As String)
	currentIndent = currentIndent - 1
    AddLine("} catch (" & event & ") {")
    currentIndent = currentIndent + 1
End Sub

' }
Public Sub EndTry
    currentIndent = currentIndent - 1
    AddLine("}")
End Sub

' objectName.methodName(args);
Public Sub AddMethodCall (objectName As String, methodName As String, args() As String)
	Dim argList As String
	If Initialized(args) Then
		For Each arg As String In args
			If argList <> "" Then argList = argList & ", "
			argList = argList & arg
		Next
	End If
	AddLine($"${objectName}.${methodName}(${argList});"$)
End Sub

' functionName(args);
Public Sub AddFunctionCall (functionName As String, args() As String)
	Dim argList As String
	If Initialized(args) Then
		For Each arg As String In args
			If argList <> "" Then argList = argList & ", "
			If ShouldQuote(arg) Then
				argList = argList & $"'${arg}'"$
			Else
				argList = argList & arg
			End If
		Next
	End If
	AddLine($"${functionName}(${argList});"$)
End Sub

' document.addEventListener('htmx:configRequest'), (evt) => {
' <code>script1.AddEventListener("htmx:configRequest", "evt")</code>
Public Sub AddEventListener (functionName As String, eventName As String)
	AddLine($"document.addEventListener('${functionName}', (${eventName}) => {"$)
End Sub

Private Sub ShouldQuote (arg As String) As Boolean
	' Check if argument should be quoted (simple string detection)
	Return arg.StartsWith("'") = False And arg.StartsWith(QUOTE) = False And _
           IsNumber(arg) = False And arg <> "true" And arg <> "false" And _
           arg <> "null" And arg <> "undefined"
End Sub

' const name = value; (isConst = True)
' let name = value;      (isConst = False)
Public Sub DeclareVariable (name As String, value As String, isConst As Boolean)
    Dim decl As String
    If isConst Then
        decl = "const"
    Else
        decl = "let"
    End If
    
    If value <> "" Then
        AddLine($"${decl} ${name} = ${value};"$)
    Else
        AddLine($"${decl} ${name};"$)
    End If
End Sub

' Create an object
' const name = { key1: value1, key2: value2 };
Public Sub CreateObject (name As String, properties As Map)
    AddLine($"const ${name} = {"$)
    currentIndent = currentIndent + 1
    
    Dim keys As List = properties.Keys
    For i = 0 To keys.Size - 1
        Dim key As String = keys.Get(i)
        Dim value As String = properties.Get(key)
        Dim lineEnd As String = ","
        If i = keys.Size - 1 Then lineEnd = ""
        
        AddLine($"${key}: ${value}${lineEnd}"$)
    Next
    
    currentIndent = currentIndent - 1
    AddLine("};")
End Sub

' Create an array
' const name = [ item1, item2 ];
Public Sub CreateArray (name As String, items As List)
    Dim itemsStr As String = "["
    For i = 0 To items.Size - 1
        itemsStr = itemsStr & items.Get(i)
        If i < items.Size - 1 Then itemsStr = itemsStr & ", "
    Next
    itemsStr = itemsStr & "]"
    
    AddLine($"const ${name} = ${itemsStr};"$)
End Sub

' document.dispatchEvent(new CustomEvent("eventName", { ... }))
Public Sub AddCustomEventDispatch (eventName As String, detailData As Map)
    AddLine("")
	AddLine("document.dispatchEvent(new CustomEvent('" & eventName & "', {")
    currentIndent = currentIndent + 1
    AddLine("detail: {")
    currentIndent = currentIndent + 1

	Dim nextKey As Int
	For Each key As String In detailData.Keys
		Dim lineEnd As String
		If nextKey < detailData.Size - 1 Then lineEnd = ","
		Dim value As Object = detailData.Get(key)
        If value Is String Then
            AddLine($"${key}: '${value}'${lineEnd}"$)
        Else If value Is Boolean Then
            Dim boolVal As String = value
            AddLine($"${key}: ${boolVal}${lineEnd}"$)
        Else
            AddLine($"${key}: ${value}${lineEnd}"$)
        End If
		nextKey = nextKey + 1
	Next

    currentIndent = currentIndent - 1
    AddLine("}")
    currentIndent = currentIndent - 1
    AddLine("}));")
End Sub