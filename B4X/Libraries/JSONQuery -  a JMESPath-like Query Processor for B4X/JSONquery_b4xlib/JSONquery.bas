B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' ===================================================================
' JSONQuery -  a JMESPath-like Query Processor for B4X
' ===================================================================
'
' A class that implements a subset of JMESPath functionality for querying JSON data.
' Supports basic path navigation, filters, functions, and pipe operations.
'
' @author         Stephan Mühl / Blueforcer
' @version        1.0.1
' @date           18.12.2024
' @license        MIT License

Sub Class_Globals
	Private parser As JSONParser
	Private lastError As String
	Private stepCounter As Int
	Private LoggerActive As Boolean = False
End Sub

Public Sub Initialize
	
End Sub

public Sub setDebugmode(active As Boolean)
	LoggerActive=active
End Sub

' Returns the last error message that was recorded.
Public Sub GetLastError As String
	Return lastError
End Sub

' Searches the provided JSON string using the given JMESPath-like expression.
' Returns the result as an object or Null if an error occurred or if input parameters are invalid.
Public Sub query(jsonString As String, expression As String) As Object
	If jsonString.Trim = "" Or expression = Null Then
		lastError = "Invalid input parameters"
		Return Null
	End If

	Try
		lastError=""
		stepCounter=0
		parser.Initialize(jsonString)
		Dim json As Map = parser.NextObject
		Dim output As Object = EvaluateExpression(json, expression)
		Logger("Output: " & output)
		Return output
	Catch
		lastError = LastException.Message
		Return Null
	End Try
End Sub

' Evaluates the given expression against the provided data object.
' Handles pipes, multi-selects, arrays, filters, and other operations defined in the expression syntax.
Private Sub EvaluateExpression(data As Object, expression As String) As Object
	If expression = Null Then Return Null
	expression = expression.Trim
	If expression = "" Then Return data
   
	Try
		Logger("EvaluateExpression called with expression: '" & expression & "'")
       
		' Check for nested function calls first
		If IsFunctionCall(expression) Then
			Return HandleFunctionCall(data, expression)
		End If
       
		' Handle pipe operations only if not inside a function call
		If expression.Contains("|") And Not(IsInsideFunction(expression)) Then
			Return HandlePipe(data, expression)
		End If
       
		' Split the expression by '.' and evaluate each part
		Dim parts As List = SplitExpression(expression)
		Dim result As Object = data
       
		For Each part As String In parts
			part = part.Trim
			If part = "" Then Continue
			Logger("Evaluating part: '" & part & "'")
			result = EvaluatePart(result, part)
			If result = Null Then
				Logger("Result became null while processing part: " & part)
				Exit
			End If
		Next
       
		Return result
	Catch
		lastError = LastException.Message
		Logger("Error in EvaluateExpression: " & lastError)
		Return Null
	End Try
End Sub


' helper to check if an expression is inside a function call
Private Sub IsInsideFunction(expr As String) As Boolean
	Dim openCount As Int = 0
	Dim closeCount As Int = 0
   
	For i = 0 To expr.Length - 1
		If expr.CharAt(i) = "(" Then
			openCount = openCount + 1
		Else If expr.CharAt(i) = ")" Then
			closeCount = closeCount + 1
		End If
	Next
   
	Return openCount <> closeCount
End Sub


' Splits an expression by '.' taking care to not split inside brackets or braces.
' Returns a list of expression parts.
'Splits an expression by '.' taking care to not split inside brackets, braces, or filter conditions.
Private Sub SplitExpression(expr As String) As List
	Dim result As List
	result.Initialize
	Dim current As StringBuilder
	current.Initialize
	Dim insideBracketCount As Int = 0
	Dim insideBraceCount As Int = 0    ' Counter für geschweifte Klammern
	Dim insideFilterCount As Int = 0
	Dim inQuote As Boolean = False

	For i = 0 To expr.Length - 1
		Dim c As String = expr.CharAt(i)
        
		' Handle quotes
		If c = "'" Or c = $"""$ Then
			inQuote = Not(inQuote)
		End If
        
		' Only count brackets if not in quotes
		If Not(inQuote) Then
			Select c
				Case "["
					insideBracketCount = insideBracketCount + 1
					' Check if this starts a filter expression
					If i < expr.Length - 1 And expr.CharAt(i + 1) = "?" Then
						insideFilterCount = insideFilterCount + 1
					End If
				Case "]"
					insideBracketCount = insideBracketCount - 1
					If insideFilterCount > 0 Then
						insideFilterCount = insideFilterCount - 1
					End If
				Case "{"
					insideBraceCount = insideBraceCount + 1
				Case "}"
					insideBraceCount = insideBraceCount - 1
			End Select
		End If

		' Only split on dot if we're not inside any structure
		If c = "." And Not(inQuote) And insideBracketCount = 0 And insideFilterCount = 0 And insideBraceCount = 0 Then
			result.Add(current.ToString)
			current.Initialize
		Else
			current.Append(c)
		End If
	Next

	' Add the last part
	Dim lastPart As String = current.ToString
	If lastPart.Length > 0 Then
		result.Add(lastPart)
	End If
    
	Return result
End Sub

' Handles pipe operations in expressions. Pipes pass the output of one expression as input to the next.
Private Sub HandlePipe(data As Object, expression As String) As Object
	If data = Null Or expression = Null Then Return Null
   
	Try
		Dim parts() As String = Regex.Split("\|", expression)
		Dim result As Object = data
       
		For Each part As String In parts
			part = part.Trim
			If part = "" Then Continue
           
			If part.StartsWith("[?") Then
				' Treat as filter expression
				result = HandleFilter(result, part)
			Else
				result = EvaluateExpression(result, part)
			End If
		Next
       
		Return result
	Catch
		lastError = LastException.Message
		Return Null
	End Try
End Sub


' Handles multi-select maps, applying them to data.
' If the data is a list, the multi-select map is applied to each element.
Private Sub HandleMultiSelect(data As Object, expression As String) As Object
	If data = Null Or expression = Null Then Return Null

	Try
		If data Is List Then
			Dim resultList As List
			resultList.Initialize
			
			For Each item As Object In data.As(List)
				If item Is List Then
					' Handle nested lists
					For Each subItem As Object In item.As(List)
						resultList.Add(CreateMultiSelectMap(subItem, expression))
					Next
				Else
					resultList.Add(CreateMultiSelectMap(item, expression))
				End If
			Next
			
			Return resultList
		Else
			Return CreateMultiSelectMap(data, expression)
		End If
	Catch
		lastError = "Multi-select error: " & LastException.Message
		Logger(lastError)
		Return Null
	End Try
End Sub




' Creates a map from a multi-select expression applied to a single object.

Private Sub CreateMultiSelectMap(data As Object, expression As String) As Map
	Try
		Dim result As Map
		result.Initialize

		' Extract the content inside the braces
		Dim content As String = expression.SubString2(expression.IndexOf("{") + 1, expression.LastIndexOf("}"))
		Logger("CreateMultiSelectMap - Multi-select content: '" & content & "'")

		' Split the content by commas while preserving structures
		Dim keyValuePairs() As String = SplitPreservingStructures(content, ",")

		For Each pair As String In keyValuePairs
			pair = pair.Trim
			If pair = "" Then Continue

			Dim colonIndex As Int = pair.IndexOf(":")
			If colonIndex = -1 Then Continue

			Dim key As String = pair.SubString2(0, colonIndex).Trim
			Dim valueExpr As String = pair.SubString2(colonIndex + 1, pair.Length).Trim

			' Remove double quotes if present
			If key.StartsWith("""") And key.EndsWith("""") Then
				key = key.SubString2(1, key.Length - 1)
			End If

			Logger("CreateMultiSelectMap - Processing key: '" & key & "' with expression: '" & valueExpr & "'")

			' Evaluate the expression to get the value
			Dim value As Object = EvaluateExpression(data, valueExpr)
			
			' Don't wrap single values in a list
			If not(value Is List) Then
				result.Put(key, value)
			Else
				' If it's already a list with one item, extract that item
				Dim valueList As List = value
				If valueList.Size = 1 Then
					result.Put(key, valueList.Get(0))
				Else
					result.Put(key, value)
				End If
			End If
		Next

		Return result
	Catch
		lastError = "CreateMultiSelectMap error: " & LastException.Message
		Logger(lastError)
		Return CreateEmptyMap
	End Try
End Sub
' Splits a string by a given delimiter while preserving nested structures (brackets, braces, quotes).
Private Sub SplitPreservingStructures(text As String, delimiter As String) As String()
	Dim result As List
	result.Initialize
   
	Dim current As StringBuilder
	current.Initialize
   
	Dim bracketCount As Int = 0
	Dim braceCount As Int = 0
	Dim inQuote As Boolean = False
   
	For i = 0 To text.Length - 1
		Dim c As String = text.CharAt(i)
       
		If c = "'" Then
			inQuote = Not(inQuote)
		End If
       
		If Not(inQuote) Then
			Select c
				Case "["
					bracketCount = bracketCount + 1
				Case "]"
					bracketCount = bracketCount - 1
				Case "{"
					braceCount = braceCount + 1
				Case "}"
					braceCount = braceCount - 1
			End Select
		End If
       
		If c = delimiter And Not(inQuote) And bracketCount = 0 And braceCount = 0 Then
			result.Add(current.ToString)
			current.Initialize
		Else
			current.Append(c)
		End If
	Next
   
	If current.Length > 0 Then
		result.Add(current.ToString)
	End If
   
	Dim arr(result.Size) As String
	For i = 0 To result.Size - 1
		arr(i) = result.Get(i)
	Next
	Return arr
End Sub

' Returns an empty Map.
Private Sub CreateEmptyMap As Map
	Dim m As Map
	m.Initialize
	Return m
End Sub


' Evaluates a single part of an expression against the data.
' Handles arrays, filters, wildcards, slices, and property accesses.
' Evaluates a single part of an expression against the data.
' Handles arrays, filters, wildcards, slices, and property accesses.
Private Sub EvaluatePart(data As Object, part As String) As Object
	If data = Null Or part = Null Then Return Null

	Try
		' If data is a list, handle each item individually
		If data Is List Then
			If part.StartsWith("[") And Not(part.StartsWith("[?")) Then
				Return HandleArrayAccess(data, part)
			Else If part.StartsWith("[?") Then
				Return HandleFilter(data, part)
			Else
				' Check if the part is a multi-select map
				If part.StartsWith("{") And part.EndsWith("}") Then
					Return HandleMultiSelect(data, part)
				Else If IsFunctionCall(part) Then
					Return HandleFunctionCall(data, part)
				Else
					Dim result As List
					result.Initialize
					For Each item As Object In data.As(List)
						Dim value As Object = EvaluatePart(item, part)
						result.Add(value)
					Next
					Return result
				End If
			End If
		End If
       
		' Handle function calls within parts (not entire expression)
		If IsFunctionCall(part) Then
			Return HandleFunctionCall(data, part)
		End If

		' Handle filter expressions within parts
		If part.Contains("[?") Then
			Return HandleFilterExpression(data, part)
		End If

		' Handle wildcard
		If part = "*" Then
			Return HandleWildcard(data)
		End If

		' Handle array slices
		If part.Contains("[") And part.Contains(":") Then
			Return HandleArraySlice(data, part)
		End If

		' Handle array access
		If part.Contains("[") And part.Contains("]") And Not(part.StartsWith("[?")) Then
			Return HandleArrayAccess(data, part)
		End If

		' Handle multi-select map - WICHTIG: Diese Prüfung muss VOR der Property Access Prüfung erfolgen
		If part.StartsWith("{") And part.EndsWith("}") Then
			Return HandleMultiSelect(data, part)
		End If

		' Handle property access
		Return HandlePropertyAccess(data, part)
	Catch
		lastError = LastException.Message
		Logger("EvaluatePart error: " & lastError)
		Return Null
	End Try
End Sub



Private Sub IsFunctionCall(expr As String) As Boolean
	Return Regex.IsMatch("^[a-zA-Z_][a-zA-Z0-9_]*\(.*\)$",expr)
End Sub


' Handles the execution of function calls in expressions. Parses the function name and arguments,
' processes them according to function-specific rules, and returns the result.
Private Sub HandleFunctionCall(data As Object, expr As String) As Object
	Try
		Logger("HandleFunctionCall with expression: " & expr)
		Dim openParen As Int = expr.IndexOf("(")
		Dim closeParen As Int = expr.LastIndexOf(")")
       
		Dim functionName As String = expr.SubString2(0, openParen).Trim
		Dim argString As String = expr.SubString2(openParen + 1, closeParen).Trim
       
		Logger("Function: " & functionName & ", Args: " & argString)
       
		' Parse all arguments first
		Dim args As List = ParseFunctionArguments(argString)
		
		' Special handling for join function
		If functionName.ToLowerCase = "join" Then
			Dim processedArgs As List
			processedArgs.Initialize
			
			If args.Size = 1 Then
				' In pipe context, use single argument as separator and data as array
				Dim separator As String = ParseValue(args.Get(0))
				Logger("Join - Using separator: '" & separator & "' with pipe data")
				processedArgs.Add(separator)
				processedArgs.Add(data)
			Else If args.Size = 2 Then
				' Standard case with two arguments
				Dim separator As String = ParseValue(args.Get(0))
				Logger("Join - Using separator: '" & separator & "'")
				Dim arrayExpr As String = args.Get(1)
				Dim arr As Object = EvaluateExpression(data, arrayExpr)
				processedArgs.Add(separator)
				processedArgs.Add(arr)
			Else
				lastError = "join() requires 1 or 2 arguments"
				Return Null
			End If
			
			Return EvaluateFunction(functionName, processedArgs)
		Else
			' Handle other functions as before
			For i = 0 To args.Size - 1
				Dim argValue As Object = args.Get(i)
				If argValue Is String And _
					((argValue.As(String).StartsWith("""") And argValue.As(String).EndsWith("""")) Or _
					(argValue.As(String).StartsWith("'") And argValue.As(String).EndsWith("'"))) Then
					args.Set(i, ParseValue(argValue))
				Else
					args.Set(i, EvaluateExpression(data, argValue))
				End If
			Next
			Return EvaluateFunction(functionName, args)
		End If
	Catch
		lastError = "Function call error: " & LastException.Message
		Logger("Error in HandleFunctionCall: " & lastError)
		Return Null
	End Try
End Sub

Private Sub ParseFunctionArguments(argString As String) As List
	Dim result As List
	result.Initialize
   
	Dim current As StringBuilder
	current.Initialize
	Dim insideBracketCount As Int = 0
	Dim insideBraceCount As Int = 0
	Dim insideParenCount As Int = 0
	Dim inQuote As Boolean = False

	For i = 0 To argString.Length - 1
		Dim c As String = argString.CharAt(i)
		If c = "'" Then inQuote = Not(inQuote)
		If c = $"""$ Then inQuote = Not(inQuote)

		If Not(inQuote) Then
			Select c
				Case "["
					insideBracketCount = insideBracketCount + 1
				Case "]"
					insideBracketCount = insideBracketCount - 1
				Case "{"
					insideBraceCount = insideBraceCount + 1
				Case "}"
					insideBraceCount = insideBraceCount - 1
				Case "("
					insideParenCount = insideParenCount + 1
				Case ")"
					insideParenCount = insideParenCount - 1
			End Select
		End If

		If c = "," And Not(inQuote) And insideBracketCount = 0 And insideBraceCount = 0 And insideParenCount = 0 Then
			result.Add(current.ToString.Trim)
			current.Initialize
		Else
			current.Append(c)
		End If
	Next
   
	Dim lastArg As String = current.ToString.Trim
	If lastArg <> "" Then result.Add(lastArg)
	Return result
End Sub



Private Sub EvaluateFunction(name As String, args As List) As Object
	name = name.ToLowerCase ' convert function name to lowercase for consistency
	Select name
		Case "length"
			Return FuncLength(args)
		Case "type"
			Return FuncType(args)
		Case "keys"
			Return FuncKeys(args)
		Case "values"
			Return FuncValues(args)
		Case "contains"
			Return FuncContains(args)
		Case "starts_with"
			Return FuncStartsWith(args)
		Case "ends_with"
			Return FuncEndsWith(args)
		Case "join"
			Return FuncJoin(args)
		Case "split"
			Return FuncSplit(args)
		Case "reverse"
			Return FuncReverse(args)
		Case Else
			lastError = "Unknown function: " & name
			Logger("EvaluateFunction error: " & lastError)
			Return Null
	End Select
End Sub

' contains(collection, value)
' Checks if a string contains a substring or if a list contains an element.
' Returns True/False
Private Sub FuncContains(args As List) As Object
	If args.Size <> 2 Then
		lastError = "contains() expects 2 arguments"
		Logger("FuncContains error: " & lastError)
		Return Null
	End If
	Dim collection As Object = args.Get(0)
	Dim value As Object = args.Get(1)
   
	If collection Is String Then
		If value Is String Then
			Logger("FuncContains - Checking if '" & collection & "' contains '" & value & "'")
			Return collection.As(String).Contains(value)
		Else
			Logger("FuncContains - Second argument is not a string")
			Return False
		End If
	Else If collection Is List Then
		Dim lst As List = collection
		For Each item As Object In lst
			If ObjectEquals(item, value) Then
				Logger("FuncContains - Found '" & value & "' in list")
				Return True
			End If
		Next
		Logger("FuncContains - '" & value & "' not found in list")
		Return False
	Else
		Logger("FuncContains - Collection is neither a string nor a list")
		Return False
	End If
End Sub



' starts_with(string, prefix)
' Returns True if string starts with the given prefix, else False.
Private Sub FuncStartsWith(args As List) As Object
	If args.Size <> 2 Then
		lastError = "starts_with() expects 2 arguments"
		Return Null
	End If
	Dim strVal As Object = args.Get(0)
	Dim prefix As Object = args.Get(1)
   
	If strVal Is String And prefix Is String Then
		Return strVal.As(String).StartsWith(prefix)
	Else
		Return False
	End If
End Sub

' ends_with(string, suffix)
' Returns True if string ends with the given suffix, else False.
Private Sub FuncEndsWith(args As List) As Object
	If args.Size <> 2 Then
		lastError = "ends_with() expects 2 arguments"
		Return Null
	End If
	Dim strVal As Object = args.Get(0)
	Dim suffix As Object = args.Get(1)
   
	If strVal Is String And suffix Is String Then
		Return strVal.As(String).EndsWith(suffix)
	Else
		Return False
	End If
End Sub

' join(separator, array)
' Joins elements of an array into a string separated by 'separator'.
' Expects array of strings.
Private Sub FuncJoin(args As List) As Object
	If args.Size <> 2 Then
		lastError = "join() expects 2 arguments"
		Return Null
	End If
   
	Try
		Dim separator As String = args.Get(0)
		Dim arr As Object = args.Get(1)
       
		Logger("Join - Separator: '" & separator & "'")
		Logger("Join - Array type: " & GetObjectType(arr))
       
		If arr Is List Then
			Dim lst As List = arr
			Dim sb As StringBuilder
			sb.Initialize
           
			For i = 0 To lst.Size - 1
				If i > 0 Then sb.Append(separator)
				Dim item As Object = lst.Get(i)
				If item <> Null Then
					sb.Append(item)
				End If
			Next
           
			Dim result As String = sb.ToString
			Logger("Join result: '" & result & "'")
			Return result
		End If
       
		lastError = "join() second argument must be an array"
		Return Null
	Catch
		lastError = "Error in join(): " & LastException.Message
		Return Null
	End Try
End Sub

' split(separator, string)
' Splits a string by the given separator into an array of substrings.
Private Sub FuncSplit(args As List) As Object
	If args.Size <> 2 Then
		lastError = "split() expects 2 arguments"
		Return Null
	End If
	Dim sep As Object = args.Get(0)
	Dim strVal As Object = args.Get(1)
   
	If sep Is String And strVal Is String Then
		Dim parts() As String = Regex.Split(sep, strVal)
		Dim lst As List
		lst.Initialize
		For Each p As String In parts
			lst.Add(p)
		Next
		Return lst
	Else
		lastError = "split() expects (string, string)"
		Return Null
	End If
End Sub

' reverse(string or array)
' Reverses a string or an array.
' If string is provided, returns the reversed string.
' If an array is provided, returns a new array with reversed elements.
Private Sub FuncReverse(args As List) As Object
	If args.Size <> 1 Then
		lastError = "reverse() expects 1 argument"
		Return Null
	End If
	Dim val As Object = args.Get(0)
   
	If val Is String Then
		Dim s As String = val
		Dim sb As StringBuilder
		sb.Initialize
		For i = s.Length - 1 To 0 Step -1
			sb.Append(s.CharAt(i))
		Next
		Return sb.ToString
	Else If val Is List Then
		Dim lst As List = val
		Dim reversed As List
		reversed.Initialize
		For i = lst.Size - 1 To 0 Step -1
			reversed.Add(lst.Get(i))
		Next
		Return reversed
	Else
		lastError = "reverse() expects a string or an array"
		Return Null
	End If
End Sub


' length(expr)
Private Sub FuncLength(args As List) As Object
	If args.Size <> 1 Then
		lastError = "length() expects 1 argument"
		Return Null
	End If
	Dim val As Object = args.Get(0)
	If val = Null Then Return 0
	If val Is String Then
		Return val.As(String).Length
	Else If val Is List Then
		Return val.As(List).Size
	Else If val Is Map Then
		Return val.As(Map).Size
	End If
	Return 0
End Sub

' type(expr)
Private Sub FuncType(args As List) As Object
	If args.Size <> 1 Then
		lastError = "type() expects 1 argument"
		Return Null
	End If
	Dim val As Object = args.Get(0)
	If val = Null Then
		Return "null"
	Else If val Is String Then
		Return "string"
	Else If val Is Boolean Then
		Return "boolean"
	Else If val Is Double Or val Is Int Then
		Return "number"
	Else If val Is List Then
		Return "array"
	Else If val Is Map Then
		Return "object"
	End If
	Return "unknown"
End Sub

' keys(expr)
Private Sub FuncKeys(args As List) As Object
	If args.Size <> 1 Then
		lastError = "keys() expects 1 argument"
		Return Null
	End If
	Dim val As Object = args.Get(0)
	If val Is Map Then
		Dim m As Map = val
		Dim lst As List
		lst.Initialize
		For Each k As String In m.Keys
			lst.Add(k)
		Next
		Return lst
	Else
		' keys auf Nicht-Map liefert Null
		Return Null
	End If
End Sub

' values(expr)
Private Sub FuncValues(args As List) As Object
	If args.Size <> 1 Then
		lastError = "values() expects 1 argument"
		Return Null
	End If
	Dim val As Object = args.Get(0)
	If val Is Map Then
		Dim m As Map = val
		Dim lst As List
		lst.Initialize
		For Each v As Object In m.Values
			lst.Add(v)
		Next
		Return lst
	Else

		Return Null
	End If
End Sub


' Recursively flattens nested lists into a single-level list.
Private Sub FlattenList(lst As List) As List
	Dim result As List
	result.Initialize
	For Each e As Object In lst
		If e Is List Then
			Dim subList As List = FlattenList(e)
			For Each se As Object In subList
				result.Add(se)
			Next
		Else
			result.Add(e)
		End If
	Next
	Return result
End Sub

' Handles property access on maps and projections on lists.
Private Sub HandlePropertyAccess(data As Object, part As String) As Object
	If data = Null Or part = Null Then Return Null

	If data Is Map Then
		Dim map1 As Map = data
		Logger("Keys available: " & map1.Keys) 'ignore
		If map1.ContainsKey(part) Then
			Dim value As Object = map1.Get(part)
			Logger("Accessing key '" & part & "': " & value)
			Return value
		Else
			Logger("Key '" & part & "' not found.")
			Return Null
		End If
	Else If data Is List Then
		Dim listData As List = data
		Dim projected As List
		projected.Initialize

		For Each item As Object In listData
			If item Is Map Then
				projected.Add(item.As(Map).GetDefault(part, Null))
			Else If item Is List Then
				Dim subResult As Object = HandlePropertyAccess(item, part)
				projected.Add(subResult)
			Else
				projected.Add(Null)
			End If
		Next

		Return projected
	End If

	Return Null
End Sub

' Handles filter expressions embedded in parts, such as propertyName[?condition].
Private Sub HandleFilterExpression(data As Object, part As String) As Object
	Try
		Dim bracketIndex As Int = part.IndexOf("[?")
		Dim endBracketIndex As Int = part.LastIndexOf("]")
		If bracketIndex = -1 Or endBracketIndex = -1 Then
			lastError = "Invalid filter syntax"
			Return Null
		End If

		Dim propertyName As String = part.SubString2(0, bracketIndex)
		Dim filterExp As String = part.SubString2(bracketIndex, endBracketIndex + 1)

		Dim intermediate As Object
		If propertyName.Trim = "" Then
			intermediate = data
		Else
			intermediate = EvaluatePart(data, propertyName)
		End If
       
		If intermediate = Null Then
			Return Null
		End If

		Return HandleFilter(intermediate, filterExp)
	Catch
		lastError = LastException.Message
		Return Null
	End Try
End Sub

' Handles wildcard operations.
Private Sub HandleWildcard(data As Object) As Object
	If data = Null Then Return Null

	Try
		Dim result As List
		result.Initialize

		If data Is Map Then
			Dim map1 As Map = data
			For Each value As Object In map1.Values
				result.Add(value)
			Next
		Else If data Is List Then
			Return data
		End If

		Return result
	Catch
		lastError = LastException.Message
		Return Null
	End Try
End Sub

' Handles array slice operations such as arr[start:end:step].
Private Sub HandleArraySlice(data As Object, expression As String) As Object
	If data = Null Or expression = Null Then Return Null

	Try
		Dim bracketIndex As Int = expression.IndexOf("[")
		Dim endBracketIndex As Int = expression.IndexOf2("]", bracketIndex)
		If bracketIndex = -1 Or endBracketIndex = -1 Or bracketIndex >= endBracketIndex Then
			lastError = "Invalid array slice syntax"
			Return Null
		End If

		Dim propertyName As String = expression.SubString2(0, bracketIndex)
		Dim sliceExpr As String = expression.SubString2(bracketIndex + 1, endBracketIndex)
		Dim parts() As String = Regex.Split(":", sliceExpr)

		If propertyName.Trim = "" Then
			If data Is List Then
				Dim arr As List = data
				Return SliceList(arr, parts)
			Else
				Return Null
			End If
		Else
			If data Is Map Then
				Dim map1 As Map = data
				If map1.ContainsKey(propertyName) Then
					Dim arr As List = map1.Get(propertyName)
					If arr = Null Then Return Null
					Return SliceList(arr, parts)
				End If
			Else If data Is List Then
				Dim listData As List = data
				Dim projected As List
				projected.Initialize
				For Each item As Object In listData
					If item Is Map Then
						Dim mapItem As Map = item
						If mapItem.ContainsKey(propertyName) Then
							Dim arr1 As Object = mapItem.Get(propertyName)
							If arr1 <> Null And arr1 Is List Then
								Dim sliced As List = SliceList(arr1, parts)
								projected.Add(sliced)
							Else
								projected.Add(Null)
							End If
						Else
							projected.Add(Null)
						End If
					Else
						projected.Add(Null)
					End If
				Next
				Return projected
			End If
		End If
	Catch
		lastError = LastException.Message
	End Try
	Return Null
End Sub

' Slices a list according to start:end:step parameters.
Private Sub SliceList(arr As List, parts() As String) As List
	Dim result As List
	result.Initialize

	Try
		Dim start As Int = 0
		Dim EndPos As Int = arr.Size
		Dim StepVal As Int = 1

		If parts.Length >= 1 And parts(0) <> "" Then start = parts(0)
		If parts.Length >= 2 And parts(1) <> "" Then EndPos = parts(1)
		If parts.Length >= 3 And parts(2) <> "" Then StepVal = parts(2)

		If start < 0 Then start = arr.Size + start
		If EndPos < 0 Then EndPos = arr.Size + EndPos
		If StepVal = 0 Then StepVal = 1

		For i = start To EndPos - 1 Step StepVal
			If i >= 0 And i < arr.Size Then
				result.Add(arr.Get(i))
			End If
		Next
	Catch
		lastError = "List slice error: " & LastException.Message
		Return CreateEmptyList
	End Try

	Return result
End Sub

' Returns an empty List.
Private Sub CreateEmptyList As List
	Dim lst As List
	lst.Initialize
	Return lst
End Sub

' Handles array access operations such as arr[index].
Private Sub HandleArrayAccess(data As Object, expression As String) As Object
	If data = Null Or expression = Null Then Return Null

	Try
		Dim bracketIndex As Int = expression.IndexOf("[")
		Dim endBracketIndex As Int = expression.IndexOf2("]", bracketIndex)
		If bracketIndex = -1 Or endBracketIndex = -1 Or bracketIndex >= endBracketIndex Then
			lastError = "Invalid array access syntax"
			Return Null
		End If

		Dim propertyName As String = expression.SubString2(0, bracketIndex)
		Dim indexStr As String = expression.SubString2(bracketIndex + 1, endBracketIndex)

		If propertyName.Trim = "" Then
			If data Is List Then
				Dim dataList As List = data
				If indexStr = "*" Then
					Return dataList
				Else If IsNumber(indexStr) Then
					Dim idx As Int = indexStr
					If idx >= 0 And idx < dataList.Size Then
						Return dataList.Get(idx)
					Else
						Return Null
					End If
				Else
					Return Null
				End If
			Else
				Return Null
			End If
		Else
			If data Is Map Then
				Dim mapData As Map = data
				If Not(mapData.ContainsKey(propertyName)) Then Return Null
				Dim arr As Object = mapData.Get(propertyName)
				If arr = Null Or Not(arr Is List) Then Return Null

				Dim arrList As List = arr
				If indexStr = "*" Then
					Return arrList
				Else If IsNumber(indexStr) Then
					Dim idx As Int = indexStr
					If idx >= 0 And idx < arrList.Size Then
						Return arrList.Get(idx)
					Else
						Return Null
					End If
				Else
					Return Null
				End If
			Else If data Is List Then
				Dim dataList As List = data
				Dim projected As List
				projected.Initialize

				For Each item As Object In dataList
					If item Is Map Then
						Dim itemMap As Map = item
						If itemMap.ContainsKey(propertyName) Then
							Dim arr As Object = itemMap.Get(propertyName)
							If arr <> Null And arr Is List Then
								Dim arrList As List = arr
								If indexStr = "*" Then
									projected.Add(arrList)
								Else If IsNumber(indexStr) Then
									Dim idx As Int = indexStr
									If idx >= 0 And idx < arrList.Size Then
										projected.Add(arrList.Get(idx))
									Else
										projected.Add(Null)
									End If
								Else
									projected.Add(Null)
								End If
							Else
								projected.Add(Null)
							End If
						Else
							projected.Add(Null)
						End If
					Else
						projected.Add(Null)
					End If
				Next

				Return projected
			Else
				Return Null
			End If
		End If

	Catch
		lastError = "Array access error: " & LastException.Message
	End Try

	Return Null
End Sub

' Handles filtering of lists based on conditions specified in expressions.
Private Sub HandleFilter(data As Object, filterExpr As String) As Object
	If data = Null Then Return Null
   
	Try
		' Extract the condition part between [? and ]
		Dim startIndex As Int = filterExpr.IndexOf("[?")
		Dim endIndex As Int = filterExpr.LastIndexOf("]")
		If startIndex = -1 Or endIndex = -1 Then
			lastError = "Invalid filter syntax"
			Return CreateEmptyList
		End If
        
		Dim condition As String = filterExpr.SubString2(startIndex + 2, endIndex).Trim
		Logger("HandleFilter - Extracted condition: '" & condition & "'")
           
		Dim result As List
		result.Initialize
       
		If data Is List Then
			Dim dataList As List = data
			For Each item As Object In dataList
				If EvaluateFilterCondition(item, condition) Then
					result.Add(item)
					Logger("HandleFilter - Item passed filter: " & item)
				Else
					Logger("HandleFilter - Item did not pass filter: " & item)
				End If
			Next
		Else If data Is Map Then
			' Handle case where data is a Map
			For Each value As Object In data.As(Map).Values
				If value Is List Then
					Dim filteredSubList As List = HandleFilter(value, filterExpr)
					If filteredSubList.Size > 0 Then
						result.AddAll(filteredSubList)
					End If
				End If
			Next
		End If
       
		Logger("HandleFilter - Filtered result size: " & result.Size)
		Return result
	Catch
		lastError = LastException.Message
		Logger("HandleFilter error: " & lastError)
		Return CreateEmptyList
	End Try
End Sub


' Evaluates a filter condition for a given item. A filter condition can be either a function call
' or a complex condition containing logical operators and comparisons.
Private Sub EvaluateFilterCondition(item As Object, condition As String) As Boolean
	If item = Null Or condition = Null Then Return False
	Try
		condition = condition.Trim
		Logger("EvaluateFilterCondition - Evaluating condition: '" & condition & "' for item: " & item.As(String))
		If IsFunctionCall(condition) Then
			Dim funcResult As Object = HandleFunctionCall(item, condition)
			If funcResult Is Boolean Then
				Logger("EvaluateFilterCondition - Function result: " & funcResult)
				Return funcResult
			Else
				Logger("EvaluateFilterCondition - Function did not return a boolean")
				Return False
			End If
		Else
			Return EvaluateComplexCondition(item, condition)
		End If
	Catch
		lastError = LastException.Message
		Logger("EvaluateFilterCondition error: " & lastError)
		Return False
	End Try
End Sub


' Evaluates a complex condition containing logical operators.
Private Sub EvaluateComplexCondition(item As Object, condition As String) As Boolean
	Try
		Dim orParts As List = SplitByLogicalOperator(condition, "||")
		For Each orPart As String In orParts
			Dim andParts As List = SplitByLogicalOperator(orPart.Trim, "&&")
			Dim andResult As Boolean = True
			For Each andPart As String In andParts
				If Not(EvaluateSingleCondition(item, andPart.Trim)) Then
					andResult = False
					Exit
				End If
			Next
			If andResult Then Return True
		Next
		Return False
	Catch
		lastError = LastException.Message
		Return False
	End Try
End Sub

' Evaluates a single condition without logical operators.
Private Sub EvaluateSingleCondition(item As Object, cond As String) As Boolean
	cond = cond.Trim
	Logger("EvaluateSingleCondition - Condition: '" & cond & "'")
   
	Dim ops() As String = Array As String(">=", "<=", "==", "!=", ">", "<")
	For Each op As String In ops
		Dim idx As Int = cond.IndexOf(op)
		If idx > -1 Then
			Dim leftStr As String = cond.SubString2(0, idx).Trim
			Dim rightStr As String = cond.SubString2(idx + op.Length, cond.Length).Trim
           
			Logger("EvaluateSingleCondition - Operator: '" & op & "', Left: '" & leftStr & "', Right: '" & rightStr & "'")
           
			Dim leftVal As Object = ResolveValue(item, leftStr)
			Dim rightVal As Object = ParseValue(rightStr)
           
			Logger("EvaluateSingleCondition - LeftVal: " & leftVal & ", RightVal: " & rightVal)
           
			If leftVal = Null Or rightVal = Null Then
				Logger("EvaluateSingleCondition - One of the values is Null")
				Return op = "!="
			End If
           
			Select op
				Case "=="
					Logger("EvaluateSingleCondition - Comparing " & leftVal & " == " & rightVal)
					Return ObjectEquals(leftVal, rightVal)
				Case "!="
					Logger("EvaluateSingleCondition - Comparing " & leftVal & " != " & rightVal)
					Return Not(ObjectEquals(leftVal, rightVal))
				Case ">="
					If IsNumber(leftVal) And IsNumber(rightVal) Then
						Logger("EvaluateSingleCondition - Comparing " & leftVal & " >= " & rightVal)
						Return ToNumber(leftVal) >= ToNumber(rightVal)
					End If
				Case "<="
					If IsNumber(leftVal) And IsNumber(rightVal) Then
						Logger("EvaluateSingleCondition - Comparing " & leftVal & " <= " & rightVal)
						Return ToNumber(leftVal) <= ToNumber(rightVal)
					End If
				Case ">"
					If IsNumber(leftVal) And IsNumber(rightVal) Then
						Logger("EvaluateSingleCondition - Comparing " & leftVal & " > " & rightVal)
						Return ToNumber(leftVal) > ToNumber(rightVal)
					End If
				Case "<"
					If IsNumber(leftVal) And IsNumber(rightVal) Then
						Logger("EvaluateSingleCondition - Comparing " & leftVal & " < " & rightVal)
						Return ToNumber(leftVal) < ToNumber(rightVal)
					End If
			End Select
			Logger("EvaluateSingleCondition - Operator '" & op & "' not applicable")
			Return False
		End If
	Next
   
	Dim val As Object = ResolveValue(item, cond)
	Logger("EvaluateSingleCondition - Value of '" & cond & "': " & val)
	If val = Null Then Return False
	If val Is Boolean Then Return val
	Return True
End Sub


' Converts an object to a number if possible.
Private Sub ToNumber(o As Object) As Double
	If o = Null Then Return 0
	Try
		Return o
	Catch
		Return 0
	End Try
End Sub

' Resolves a value by evaluating an expression against the given item.
Private Sub ResolveValue(item As Object, expr As String) As Object
	expr = expr.Trim
	Logger("ResolveValue - Expression: '" & expr & "'")
   
	If expr = "@" Then
		Logger("ResolveValue - Returning entire item")
		Return item
	End If
	If expr.StartsWith("@.") Then
		expr = expr.SubString(2)
		Logger("ResolveValue - Evaluating expression after '@.': '" & expr & "'")
		Return EvaluateExpression(item, expr)
	Else If expr.StartsWith("@") And expr.Length=1 Then
		Logger("ResolveValue - Returning entire item (expr = '@')")
		Return item
	Else
		Logger("ResolveValue - Evaluating expression: '" & expr & "'")
		Return EvaluateExpression(item, expr)
	End If
End Sub




' Splits a condition by logical operators (|| or &&) considering only the top-level context.
Private Sub SplitByLogicalOperator(cond As String, op As String) As List
	Dim result As List
	result.Initialize
	Dim insideBracketCount As Int = 0
	Dim current As StringBuilder
	current.Initialize

	For i = 0 To cond.Length - 1
		Dim c As String = cond.CharAt(i)
		If c = "[" Or c = "{" Then insideBracketCount = insideBracketCount + 1
		If c = "]" Or c = "}" Then insideBracketCount = insideBracketCount - 1

		If insideBracketCount=0 And i <= cond.Length - op.Length Then
			Dim subStr As String = cond.SubString2(i, i+op.Length)
			If subStr = op Then
				result.Add(current.ToString)
				current.Initialize
				i = i + op.Length - 1
			Else
				current.Append(c)
			End If
		Else
			current.Append(c)
		End If
	Next
	result.Add(current.ToString)

	Return result
End Sub

' Parses a value string into an object (string, boolean, numeric).
' Update ParseValue method to better handle string literals
Private Sub ParseValue(value As String) As Object
	If value = Null Then Return Null
	value = value.Trim

	Try
		' Handle quoted strings (both single and double quotes)
		If (value.StartsWith("'") And value.EndsWith("'")) Or (value.StartsWith($"""$) And value.EndsWith($"""$)) Then
			' Remove the quotes and return the inner string
			Return value.SubString2(1, value.Length - 1)
		End If

		If value.ToLowerCase = "true" Then Return True
		If value.ToLowerCase = "false" Then Return False

		If IsNumber(value) Then
			If value.Contains(".") Then
				Return value.As(Double)
			Else
				Return value.As(Double)
			End If
		End If

		Return value
	Catch
		lastError = "Value parsing error: " & LastException.Message
		Return Null
	End Try
End Sub

' Checks object equality for various data types.
Private Sub ObjectEquals(o1 As Object, o2 As Object) As Boolean
	If o1 = Null And o2 = Null Then Return True
	If o1 = Null Or o2 = Null Then Return False

	If IsNumber(o1) And IsNumber(o2) Then
		Dim d1 As Double = o1
		Dim d2 As Double = o2
		Return d1 = d2
	End If

	If (o1 Is String) And (o2 Is String) Then
		Return o1 = o2
	End If

	If (o1 Is Boolean) And (o2 Is Boolean) Then
		Return o1 = o2
	End If

	If (o1 Is List) And (o2 Is List) Then
		Return ListEquals(o1, o2)
	End If

	If (o1 Is Map) And (o2 Is Map) Then
		Return MapEquals(o1, o2)
	End If

	Return o1 = o2
End Sub

' Checks if two lists are equal by comparing each element.
Private Sub ListEquals(list1 As List, list2 As List) As Boolean
	If list1.Size <> list2.Size Then Return False
	For i = 0 To list1.Size - 1
		If Not(ObjectEquals(list1.Get(i), list2.Get(i))) Then Return False
	Next
	Return True
End Sub

' Checks if two maps are equal by comparing keys and values.
Private Sub MapEquals(map1 As Map, map2 As Map) As Boolean
	If map1.Size <> map2.Size Then Return False
	For Each key As String In map1.Keys
		If Not(map2.ContainsKey(key)) Then Return False
		If Not(ObjectEquals(map1.Get(key), map2.Get(key))) Then Return False
	Next
	Return True
End Sub

Private Sub GetObjectType(obj As Object) As String
	If obj = Null Then Return "Null"
	If obj Is List Then Return "List"
	If obj Is Map Then Return "Map"
	If obj Is String Then Return "String"
	If obj Is Int Then Return "Int"
	If obj Is Double Then Return "Double"
	Return "Unknown"
End Sub

private Sub Logger(entry As Object)
	If LoggerActive Then
		stepCounter=stepCounter+1
		Log(stepCounter & " - " & entry)
	End If
End Sub
