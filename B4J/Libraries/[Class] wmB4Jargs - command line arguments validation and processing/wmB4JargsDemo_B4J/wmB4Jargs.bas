B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Ctrl + click to create the B4Xlib: ide://run?File=%ADDITIONAL%\B4XLibMaker.jar&Args=|%ADDITIONAL%\B4XLibMakerSettings.txt|wmB4Jargs

#Region Changes
' B4XLibMakerVersion=0.01

'- 2025-01-28: initial version
#End Region ' Changes

Sub Class_Globals

	Type wmB4JargsResult(firstError As Int, errorMsg As String, offendingArg As String, offendingArgIndex As Int, valuesMap As Map)

	Public Const WMB4JARGS_UNKNOWN_ARGUMENT As Int = 1
	Public Const WMB4JARGS_MISSING_VALUE As Int = 2
	Public Const WMB4JARGS_VALUE_NOT_NUMERIC As Int = 3
	Public Const WMB4JARGS_INVALID_VALUE As Int = 4
	Public Const WMB4JARGS_MISSING_REQUIRED_ARGUMENT As Int = 5

	' You can change the values in your calling code, e.g. to localise them
	Public mapErrorMessages As Map = CreateMap(WMB4JARGS_UNKNOWN_ARGUMENT: "Unknown argument", _
												WMB4JARGS_MISSING_VALUE: "Missing value for argument", _
												WMB4JARGS_VALUE_NOT_NUMERIC: "Argument must have a numeric value", _
												WMB4JARGS_INVALID_VALUE: "Invalid argument value", _
												WMB4JARGS_MISSING_REQUIRED_ARGUMENT: "Required argument is missing" _
												)

	Private validationMap As Map
	Private abbrToNameMap As Map
	Private nameToAbbrMap As Map
	Private helpMap As Map

End Sub

' B4Xlib information:
' - Dependencies: none
' - Additional jars needed: none
' - Contains Type definition: wmB4JargsResult
Public Sub B4XLibInfo
	' This method is only used to document dependencies, additional jars, etc
End Sub

Public Sub Initialize

	validationMap.Initialize
	abbrToNameMap.Initialize
	nameToAbbrMap.Initialize
	helpMap.Initialize

End Sub

' Adds a standalone argument that doesn't need a value:
' - argName: the full name of the argument, e.g. 'nodetailsneeded'
' - abbreviation: the argument's abbreviated name, e.g. 'n'
' - helpText: the text to display with method PrintHelp
' - required: if True, the argument must be specified
' Example: see 'Parse'
Public Sub AddStandaloneArg(argName As String, abbreviation As String, helpText As String, required As Boolean)

	validationMap.Put(argName, IIf(required, CreateMap("required": True), Null))
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' Adds an argument that needs a numeric value:
' - argName: the full name of the argument, e.g. 'somenumber'
' - abbreviation: the argument's abbreviated name, e.g. 'sn'
' - helpText: the text to display with method PrintHelp
' - required: if True, the argument must be specified
' - mustBeNumber: if True, the given value must be numeric
' Example: see 'Parse'
Public Sub AddValueArg(argName As String, abbreviation As String, helpText As String, required As Boolean, mustBeNumber As Boolean)

	Dim m As Map = CreateMap("hasvalue": True)
	If required Then m.Put("required", True)
	If mustBeNumber Then m.Put("isnumber", True)

	validationMap.Put(argName, m)
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' Adds an argument that needs a value from a list of permitted values:
' - argName: the full name of the argument, e.g. 'somenumber'
' - abbreviation: the argument's abbreviated name, e.g. 'sn'
' - helpText: the text to display with method PrintHelp
' - required: if True, the argument must be specified
' - permittedValues: the list with permitted values
' - mustBeNumber: if True, the given value must be numeric
' Example: see 'Parse'
Public Sub AddPermittedValuesArg(argName As String, abbreviation As String, helpText As String, required As Boolean, permittedValues As List, mustBeNumber As Boolean)

	Dim m As Map = CreateMap("hasvalue": True, "permittedvalues": permittedValues)
	If required Then m.Put("required", True)
	If mustBeNumber Then m.Put("isnumber", True)

	validationMap.Put(argName, m)
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' First add the arguments' definitions with the 'Add...' methods.
' Then, call this method.
'
' This method returns a variable of type wmB4JargsResult; if the validation was successful, member 'valuesMap' is a map that contains:
' - keys: argument full names IN LOWERCASE (this indicates that the argument was specified)
' - values: the value that was found for non-standalone arguments; otherwise, True
'
' If the validation failed, the other members of the returned variable are filled; member 'firstError' contains one of the 'WMB4JARGS_...' constants
'
' Example: <code>
'Dim wmB4Jargs1 As wmB4Jargs
'wmB4Jargs1.Initialize
'wmB4Jargs1.AddStandaloneArg("--nodetails", "-n", "This argument stands alone and does not need a value", False)
'wmB4Jargs1.AddValueArg("--number", "-u", "The 'number' argument needs a numeric value", False, True)
'wmB4Jargs1.AddPermittedValuesArg("--selectednumber", "-s", "'SelectedNumber' needs an integer value between 1 and 5 (both included)", False, Array(1, 2, 3, 4, 5), True)
'wmB4Jargs1.AddPermittedValuesArg("--animal", "-a", "The 'animal' argument needs one of these values: Ape, Bear, Cat", True, Array("Ape", "Bear", "Cat"), False)
'
'' Valid args would e.g. be: Animal cat NODETAILS number 7 s 3
'Dim parseResult As wmB4JargsResult = wmUtils1.Parse(Args)
'If parseResult.firstError <> 0 Then
'	Log("Error(s): " & parseResult)
'Else
'	Log("SelectedNumber is: " & parseResult.valuesMap.GetDefault("selectednumber", "<none selected>"))
'End If</code>
Public Sub Parse(Args() As String) As wmB4JargsResult

	Dim lst As List
	lst.Initialize
	lst.AddAll(Args)
	Return ParseList(lst)

End Sub

' Like Parse, but accepts a list as parameter instead of a string array.
Public Sub ParseList(Args As List) As wmB4JargsResult

	Dim i As Int
	Dim j As Int
	Dim iEnd As Int = Args.Size - 1
	Dim arg As String
	Dim result As wmB4JargsResult
	Dim foundValue As Boolean
	Dim needNumberValue As Boolean

	result.Initialize
	result.offendingArgIndex = -1
	result.valuesMap.Initialize

	For i = 0 To iEnd
		arg = Args.Get(i).As(String).ToLowerCase
		' Check if this is an abbreviated arg; if so, continue to work with the full name
		If abbrToNameMap.ContainsKey(arg) Then
			arg = abbrToNameMap.Get(arg).As(String).ToLowerCase
		End If
		' Check if this is a valid argument
		If validationMap.ContainsKey(arg) = False Then
			If result.firstError = 0 Then
				AddErrorInfoToResult(result, WMB4JARGS_UNKNOWN_ARGUMENT)
				result.offendingArg = arg
				result.offendingArgIndex = i
			End If
			Continue
		End If
		' Check if details have been provided; if not, this argument is ok now
		Dim detailsMap As Map = validationMap.Get(arg).As(Map)
		If (detailsMap.IsInitialized = False) Or (detailsMap = Null) Then
			result.valuesMap.Put(arg, True)
			Continue
		End If
		' If the argument isn't expected to have a value, this argument is ok now
		If detailsMap.GetDefault("hasvalue", False).As(Boolean) = False Then
			result.valuesMap.Put(arg, True)
			Continue
		End If
		' A value is expected; check if one has been provided
		If i >= iEnd Then
			If result.firstError = 0 Then
				AddErrorInfoToResult(result, WMB4JARGS_MISSING_VALUE)
				result.offendingArg = arg
				result.offendingArgIndex = i
			End If
			Continue
		End If
		' Increase 'i' and get the specified value at that index
		i = i + 1
		Dim specifiedValue As String = Args.Get(i).As(String)
		' If 'isnumber' was specified and is True, the value must be numeric
		If detailsMap.GetDefault("isnumber", False).As(Boolean) Then
			If IsNumber(specifiedValue) = False Then
				If result.firstError = 0 Then
					AddErrorInfoToResult(result, WMB4JARGS_VALUE_NOT_NUMERIC)
					result.offendingArg = arg
					result.offendingArgIndex = i - 1 ' Return the index of the argument, not that of its value
				End If
				Continue
			End If
			needNumberValue = True
		Else
			needNumberValue = False
		End If
		' If no list with permitted values was provided, this argument is ok now
		If detailsMap.ContainsKey("permittedvalues") = False Then
			result.valuesMap.Put(arg, specifiedValue)
			Continue
		End If
		' Validate the specified value
		foundValue = False
		If detailsMap.Get("permittedvalues") Is List Then
			Dim lstPermittedValues As List = detailsMap.Get("permittedvalues").As(List)
		Else
			' Make list from array
			Dim arrPermittedValues() As Object = detailsMap.Get("permittedvalues")
			Dim lstPermittedValues As List
			lstPermittedValues.Initialize
			For j = 0 To (arrPermittedValues.Length - 1)
				If needNumberValue Then
					Dim dbl As Double = arrPermittedValues(j).As(Double)
					Dim dblInt As Int = Floor(dbl)
					If dbl = dblInt Then
						' No decimals, integer number
						lstPermittedValues.Add(dbl.As(Int))
					Else
						' Double
						lstPermittedValues.Add(dbl)
					End If
				Else
					lstPermittedValues.Add(arrPermittedValues(j).As(String))
				End If
			Next
		End If
		If needNumberValue Then
			If lstPermittedValues.IndexOf(specifiedValue.As(Int)) >= 0 Then
				foundValue = True
				result.valuesMap.Put(arg, specifiedValue)
			End If
		Else
			For Each onePermittedValue As String In lstPermittedValues
				If onePermittedValue.EqualsIgnoreCase(specifiedValue) Then
					foundValue = True
					result.valuesMap.Put(arg, specifiedValue)
					Exit
				End If
			Next
		End If
		' Was the specifed value permitted?
		If foundValue = False Then
			If result.firstError = 0 Then
				AddErrorInfoToResult(result, WMB4JARGS_INVALID_VALUE)
				result.offendingArg = arg
				result.offendingArgIndex = i - 1 ' Return the index of the argument, not that of its value
			End If
			Continue
		End If
	Next

	If result.firstError = 0 Then
		For Each key As String In validationMap.Keys
			Dim detailsMap As Map = validationMap.Get(key).As(Map)
			If detailsMap.IsInitialized And detailsMap.GetDefault("required", False).As(Boolean) Then
				If result.valuesMap.ContainsKey(key) = False Then
					AddErrorInfoToResult(result, WMB4JARGS_MISSING_REQUIRED_ARGUMENT)
					result.offendingArg = key
					result.offendingArgIndex = -1
					Return result
				End If
			End If
		Next
	End If

	Return result

End Sub

' Displays help text in two columns; the left one is for the argument names, the right one for their help texts:
' - rightColStart: the position at which the right column must start
' - maxLen: the maximum line length; lines will be broken up if their length exceeds this value
' - emptyLineBeforeEachArg: if True, an empty line is displayed before each argument's data
'
' Example: <code>wmB4Jargs1.PrintHelp("Arguments:", 15, 80, True)</code>
Public Sub PrintHelp(title As String, rightColStart As Int, maxLen As Int, emptyLineBeforeEachArg As Boolean)

	Dim lstHelp As List
	lstHelp.Initialize

	Dim lstKeys As List
	lstKeys.Initialize
	For Each oneKey As String In validationMap.Keys
		lstKeys.Add(oneKey)
	Next
	lstKeys.SortCaseInsensitive(True)

	If (rightColStart < 10) Or (maxLen < 40) Or (rightColStart >= maxLen) Then
		rightColStart = 15
		maxLen = 80
	End If

	Log(title)

	For Each oneKey As String In lstKeys
		Dim detailsMap As Map = validationMap.Get(oneKey).As(Map)
		Dim required As Boolean = detailsMap.IsInitialized And detailsMap.GetDefault("required", False).As(Boolean)
		Dim openBracket As String = IIf(required, "", "[")
		Dim closeBracket As String = IIf(required, "", "]")
		Dim txt As String = helpMap.GetDefault(oneKey, "").As(String)
		Dim abbr As String = nameToAbbrMap.GetDefault(oneKey, "")
		Dim m As Map = CreateMap("left": IIf(abbr = "", "", openBracket & abbr & closeBracket & ", ") & openBracket & oneKey & closeBracket, "right": txt)
		lstHelp.Add(m)
	Next

	PrintHelpList(lstHelp, rightColStart, maxLen, emptyLineBeforeEachArg)

End Sub

#Region Helpers
Private Sub AddErrorInfoToResult(result As wmB4JargsResult, firstError As Int)

	result.firstError = firstError
	result.errorMsg = mapErrorMessages.GetDefault(result.firstError, "")

End Sub

' Note: this method is present in classes wmUtils and wmB4Jargs
Private Sub PrintHelpList(lstHelp As List, rightColStart As Int, maxLen As Int, emptyLineBeforeEachEntry As Boolean)

	Dim maxLenRight As Int

	If maxLen <= rightColStart Then
		rightColStart = 31
		maxLen = 80
	End If
	maxLenRight = maxLen - rightColStart + 1

	For Each m As Map In lstHelp
		If emptyLineBeforeEachEntry Then Log(" ")
		Dim sLeft As String = m.GetDefault("left", "").As(String)
		Dim sRight As String = m.GetDefault("right", "").As(String)
		' If there is no text for the right hand column, just process the left hand one and continue
		If sRight = "" Then
			Dim lstLeft As List = PrintHelpSplitString(sLeft, maxLen)
			For Each oneLine As String In lstLeft
				Log(oneLine)
			Next
			Continue
		End If
		' Init output
		Dim output As String = ""
		If sLeft.Length >= rightColStart Then
			Log(sLeft)
		Else
			output = sLeft
		End If
		' Split sRight
		Dim lstRight As List = PrintHelpSplitString(sRight, maxLenRight)
		' Process sRight's parts
		For Each oneLine As String In lstRight
			Do While output.Length < rightColStart
				output = output & " "
			Loop
			output = output & oneLine
			Log(output)
			output = ""
		Next
	Next

End Sub

' Note: this method is present in classes wmUtils and wmB4Jargs
Private Sub PrintHelpSplitString(str As String, maxLen As Int) As List

	Dim result As List
	Dim lstSplit As List = Regex.Split(" ", str)
	Dim line As String = ""
	Dim s As String

	result.Initialize
	For Each oneWord As String In lstSplit
		oneWord = oneWord.Trim
		s = (line & " " & oneWord).As(String).Trim
		If s.Length > maxLen Then
			result.Add(line)
			line = oneWord
		Else
			line = s
		End If
	Next
	result.Add(line)

	Return result

End Sub
#End Region ' Helpers