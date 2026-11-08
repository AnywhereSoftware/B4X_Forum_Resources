B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Ctrl + click to create the B4Xlib: ide://run?File=%ADDITIONAL%\B4XLibMaker.jar&Args=|%ADDITIONAL%\B4XLibMakerSettings.txt|wmB4Jargs

#Region Changes
' B4XLibMakerVersion=0.02

'- 2025-01-28: initial version
'- 2026-05-31: added mLogValues
'- 2026-05-31: added method PrintHelp2
'- 2026-05-31: added methods AddMultipleValuesArg, ParseCaseInsensitive, and ParseListCaseInsensitive
'  NOTE: THIS CHANGE IS BACKWARDS INCOMPATIBLE, AS ORIGINALLY THE Parse... METHODS RETURNED A MAP WITH ALL KEYS IN LOWERCASE;
'        AS OF NOW, ONLY THE Parse...CaseInsensitive METHODS DOWNSHIFT THE KEYS; THE OTHERS WILL RETURN THE KEYS 'AS PASSED'
'- 2026-05-31: arguments with a value can now be passed as 'name value' or 'name=value'
'- 2026-05-31: corrected the example in the help text for method Parse
#End Region ' Changes

Sub Class_Globals

	Type wmB4JargsResult(firstError As Int, errorMsg As String, offendingArg As String, offendingArgIndex As Int, valuesMap As Map)

	Public Const WMB4JARGS_UNKNOWN_ARGUMENT As Int = 1
	Public Const WMB4JARGS_MISSING_VALUE As Int = 2
	Public Const WMB4JARGS_VALUE_NOT_NUMERIC As Int = 3
	Public Const WMB4JARGS_INVALID_VALUE As Int = 4
	Public Const WMB4JARGS_MISSING_REQUIRED_ARGUMENT As Int = 5
	Public Const WMB4JARGS_INVALID_NUMBER_OF_VALUES As Int = 6

	' You can change the values in your calling code, e.g. to localise them
	Public mapErrorMessages As Map = CreateMap(WMB4JARGS_UNKNOWN_ARGUMENT: "Unknown argument", _
												WMB4JARGS_MISSING_VALUE: "Missing value for argument", _
												WMB4JARGS_VALUE_NOT_NUMERIC: "Argument must have a numeric value", _
												WMB4JARGS_INVALID_VALUE: "Invalid argument value", _
												WMB4JARGS_MISSING_REQUIRED_ARGUMENT: "Required argument is missing", _
												WMB4JARGS_INVALID_NUMBER_OF_VALUES: "Invalid number of values" _
												)

	Private validationList As List ' Contains the keys from the 'Add...' methods in the order in which they arrived
	Private validationMap As Map
	Private abbrToNameMap As Map
	Private nameToAbbrMap As Map
	Private helpMap As Map

	Private mLogValues As Boolean = False

End Sub

' B4Xlib information:
' - Dependencies: none
' - Additional jars needed: none
' - Contains Type definition: wmB4JargsResult
Public Sub B4XLibInfo
	' This method is only used to document dependencies, additional jars, etc
End Sub

Public Sub Initialize

	validationList.Initialize
	validationMap.Initialize
	abbrToNameMap.Initialize
	nameToAbbrMap.Initialize
	helpMap.Initialize

End Sub

' Adds a standalone argument that doesn't need a value:
' - argName: the full name of the argument, e.g. 'nodetailsneeded'
' - abbreviation: the argument's abbreviated name, e.g. 'n'
' - helpText: the text to display with methods PrintHelp/PrintHelp2
' - required: if True, the argument must be specified
' Example: see 'Parse'
Public Sub AddStandaloneArg(argName As String, abbreviation As String, helpText As String, required As Boolean)

	validationList.Add(argName)
	validationMap.Put(argName, IIf(required, CreateMap("required": True), Null))
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' Adds an argument that needs a numeric value:
' - argName: the full name of the argument, e.g. 'somenumber'
' - abbreviation: the argument's abbreviated name, e.g. 'sn'
' - helpText: the text to display with methods PrintHelp/PrintHelp2
' - required: if True, the argument must be specified
' - mustBeNumber: if True, the given value must be numeric
' Example: see 'Parse'
Public Sub AddValueArg(argName As String, abbreviation As String, helpText As String, required As Boolean, mustBeNumber As Boolean)

	Dim m As Map = CreateMap("hasvalue": True)
	If required Then m.Put("required", True)
	If mustBeNumber Then m.Put("isnumber", True)

	validationList.Add(argName)
	validationMap.Put(argName, m)
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' Adds an argument that needs a value from a list of permitted values:
' - argName: the full name of the argument, e.g. 'somenumber'
' - abbreviation: the argument's abbreviated name, e.g. 'sn'
' - helpText: the text to display with methods PrintHelp/PrintHelp2
' - required: if True, the argument must be specified
' - permittedValues: the list with permitted values
' - mustBeNumber: if True, the given value must be numeric
' Example: see 'Parse'
Public Sub AddPermittedValuesArg(argName As String, abbreviation As String, helpText As String, required As Boolean, permittedValues As List, mustBeNumber As Boolean)

	Dim m As Map = CreateMap("hasvalue": True, "permittedvalues": permittedValues)
	If required Then m.Put("required", True)
	If mustBeNumber Then m.Put("isnumber", True)

	validationList.Add(argName)
	validationMap.Put(argName, m)
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' Adds an argument that needs multiple values:
' - argName: the full name of the argument, e.g. 'manyvalues'
' - abbreviation: the argument's abbreviated name, e.g. 'mv'
' - helpText: the text to display with methods PrintHelp/PrintHelp2
' - required: if True, the argument must be specified
' - minimumNumValues: the minimum number of values; a value less than 1 means 'no minimum'
' - maximumNumValues: the maximum number of values; a value less than 1 means 'no maximum'
'
' Any validation for the argument's values must be done by the calling code.
' When parsing this type of argument, all data are considered values until the next known
' argument name (or abbreviation) is encountered, for instance, when using this:
'   AddStandaloneArg("--saarg", "-sa", "", False)
'   AddMultipleValuesArg("--mvarg", "-mv", "", False, 0, 0)
' and the program is run with command line arguments
'   --mvarg 1 2 3 --saarg
' then the value for '--mvarg' returned to the caller in the valuesMap created by the
' Parse... methods will be a List containing items 1, 2, and 3.
'
' Example: see 'Parse'
Public Sub AddMultipleValuesArg(argName As String, abbreviation As String, helpText As String, required As Boolean, minimumNumValues As Int, maximumNumValues As Int)

	Dim m As Map = CreateMap("hasvalue": True, "multiplevalues": True, "minnumvalues": IIf(minimumNumValues > 0, minimumNumValues, 0), "maxnumvalues": IIf(maximumNumValues > 0, maximumNumValues, 0))
	If required Then m.Put("required", True)

	validationList.Add(argName)
	validationMap.Put(argName, m)
	abbrToNameMap.Put(abbreviation, argName)
	nameToAbbrMap.Put(argName, abbreviation)
	helpMap.Put(argName, helpText)

End Sub

' First add the arguments' definitions with the 'Add...' methods.
' Then, call one of the 'Parse...' methods.
'
' This method returns a variable of type wmB4JargsResult; if the validation was successful, member 'valuesMap' is a map that contains:
' - keys: argument full names (this indicates that the argument was specified):
'   - if a Parse...CaseInsensitive method was used, the keys are shifted to lowercase;
'   - otherwise, they are used 'as is'
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
'wmB4Jargs1.AddMultipleValuesArg("--multiple", "-m", "2 to 4 values that must be validated by the caller", False, 2, 4)
'
'' Valid args would e.g. be: --Animal=cat --NODETAILS --multiple a b c --number 7 -s 3
'Dim parseResult As wmB4JargsResult = wmB4Jargs1.ParseCaseInsensitive(Args)
'If parseResult.firstError <> 0 Then
'	Log("Error(s): " & parseResult)
'Else
'	Log("Animal is: " & parseResult.valuesMap.Get("--animal"))
'	Log("SelectedNumber is: " & parseResult.valuesMap.GetDefault("--selectednumber", "<none selected>"))
'	If parseResult.valuesMap.ContainsKey("--multiple") Then
'		Log("Multiple (a List) is: " & parseResult.valuesMap.Get("--multiple").As(List))
'	End If
'End If</code>
Public Sub Parse(Args() As String) As wmB4JargsResult

	Dim lst As List
	lst.Initialize
	lst.AddAll(Args)
	Return DoParseList(lst, False)

End Sub

' Like Parse, but treats the argument names (full and abbreviated) case-insensitively
Public Sub ParseCaseInsensitive(Args() As String) As wmB4JargsResult

	Dim lst As List
	lst.Initialize
	lst.AddAll(Args)
	Return DoParseList(lst, True)

End Sub

' Like Parse, but accepts a List as parameter instead of a String Array.
Public Sub ParseList(Args As List) As wmB4JargsResult

	Return DoParseList(Args, False)

End Sub

' Like Parse, but accepts a List as parameter instead of a String Array,
' and treats the argument names (full and abbreviated) case-insensitively
Public Sub ParseListCaseInsensitive(Args As List) As wmB4JargsResult

	Return DoParseList(Args, True)

End Sub

Private Sub DoParseList(lstArgs As List, ignoreCase As Boolean) As wmB4JargsResult

	Dim i As Int
	Dim j As Int
	Dim arg As String
	Dim result As wmB4JargsResult
	Dim foundValue As Boolean
	Dim needNumberValue As Boolean

	If mLogValues Then
		Log("==== Values: ====")
		For i = 0 To (lstArgs.Size - 1)
			Log(i & ": " & lstArgs.Get(i))
		Next
		Log("=================")
	End If

	result.Initialize
	result.offendingArgIndex = -1
	result.valuesMap.Initialize

	' Prepare for case sensitive/insensitive processing
	Dim tmpAbbrToNameMap As Map
	Dim tmpValidationMap As Map
	If ignoreCase Then
		tmpAbbrToNameMap.Initialize
		For Each key As String In abbrToNameMap.Keys
			tmpAbbrToNameMap.Put(key.ToLowerCase, abbrToNameMap.Get(key))
		Next
		tmpValidationMap.Initialize
		For Each key As String In validationMap.Keys
			tmpValidationMap.Put(key.ToLowerCase, validationMap.Get(key))
		Next
	Else
		tmpAbbrToNameMap = abbrToNameMap
		tmpValidationMap = validationMap
	End If

	' Check if the data contain 'key=value' items (as opposed to 'key value');
	' if so, split them into 2 items: one for the key, and one for the value
	Dim Args As List
	Args.Initialize
	For i = 0 To (lstArgs.Size - 1)
		arg = lstArgs.Get(i).As(String)
		' Check if argument can be found as name or abbreviation
		Dim tmpArg As String = IIf(ignoreCase, arg.ToLowerCase, arg)
		If tmpValidationMap.ContainsKey(tmpArg) Then
			' Valid arg name
			Args.Add(arg)
			Continue
		End If
		If tmpAbbrToNameMap.ContainsKey(tmpArg) Then
			' Valid arg abbreviation
			Args.Add(arg)
			Continue
		End If
		' Argument cannot be found as name or abbreviation, look for "="
		Dim iEq As Int = arg.IndexOf("=")
		If iEq < 0 Then
			' No '=' found, no need to check further
			Args.Add(arg)
			Continue
		End If
		' "=" found, get the parts before and after it
		Dim sBefore As String = arg.SubString2(0, iEq)
		Dim sAfter As String = IIf(iEq = (arg.Length - 1), "", arg.SubString(iEq + 1))
		' Check if the 'before' part can be found as name or abbreviation
		tmpArg = IIf(ignoreCase, sBefore.ToLowerCase, sBefore)
		If tmpValidationMap.ContainsKey(tmpArg) Then
			' Valid arg name
			Args.Add(sBefore)
			Args.Add(sAfter)
			Continue
		End If
		If tmpAbbrToNameMap.ContainsKey(tmpArg) Then
			' Valid arg abbreviation
			Args.Add(sBefore)
			Args.Add(sAfter)
			Continue
		End If
		' No dice
		Args.Add(arg)
	Next

	' Process the data
	Dim iEnd As Int = Args.Size - 1
	For i = 0 To iEnd
		arg = Args.Get(i).As(String)
		If ignoreCase Then arg = arg.ToLowerCase
		''''''''''''
		' Check if this is an abbreviated argument; if so, continue to work with the full name
		''''''''''''
		If tmpAbbrToNameMap.ContainsKey(arg) Then
			arg = tmpAbbrToNameMap.Get(arg).As(String)
			If ignoreCase Then arg = arg.ToLowerCase
		End If
		''''''''''''
		' Check if this is a valid argument
		''''''''''''
		If tmpValidationMap.ContainsKey(arg) = False Then
			If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_UNKNOWN_ARGUMENT, arg, i)
			Continue
		End If
		''''''''''''
		' Check if details have been provided; if not, this argument is ok now
		''''''''''''
		Dim detailsMap As Map = tmpValidationMap.Get(arg).As(Map)
		If (detailsMap.IsInitialized = False) Or (detailsMap = Null) Then
			result.valuesMap.Put(arg, True)
			Continue
		End If
		''''''''''''
		' If the argument isn't expected to have a value, this argument is ok now
		''''''''''''
		If detailsMap.GetDefault("hasvalue", False).As(Boolean) = False Then
			result.valuesMap.Put(arg, True)
			Continue
		End If
		''''''''''''
		' Handle an argument with multiple values (added with method AddMultipleValuesArg)
		''''''''''''
		If detailsMap.GetDefault("multiplevalues", False).As(Boolean) Then
			Dim minNumValues As Int = detailsMap.Get("minnumvalues").As(Int)
			If (i >= iEnd) And (minNumValues > 0) Then
				If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_INVALID_NUMBER_OF_VALUES, arg, i)
				Continue
			End If
			' Get the argument's values: iterate through Args until the next 
			' known argument name (or abbreviation) is found
			Dim lstValues As List
			lstValues.Initialize
			Dim iValues As Int
			For iValues = (i + 1) To iEnd
				Dim val As String = Args.Get(iValues).As(String)
				If ignoreCase Then val = val.ToLowerCase
				If tmpAbbrToNameMap.ContainsKey(val) Then
					' This is an abbreviated argument; continue to work with the full name
					val = tmpAbbrToNameMap.Get(val).As(String)
					If ignoreCase Then val = val.ToLowerCase
				End If
				If tmpValidationMap.ContainsKey(val) Then
					' We have reached a known argument name, so we have collected all values
					i = iValues - 1 ' Move i to the previous item (for the main loop)
					Exit
				Else
					' Not a known argument name, so this is a value
					lstValues.Add(val)
					i = i + 1 ' Move i up (for the main loop)
				End If
			Next
			' Check if the number of values is within the specified limits
			Dim maxNumValues As Int = detailsMap.Get("maxnumvalues").As(Int)
			If (minNumValues > 0) And (lstValues.Size < minNumValues) Or _
				(maxNumValues > 0) And (lstValues.Size > maxNumValues) Then
				If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_INVALID_NUMBER_OF_VALUES, arg, i)
				Continue
			End If
			' Store the list of values
			result.valuesMap.Put(arg, lstValues)
			Continue
		End If ' Multiple values argument processing
		''''''''''''
		' A single value is expected; check if one has been provided
		''''''''''''
		If i >= iEnd Then
			If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_MISSING_VALUE, arg, i)
			Continue
		End If
		''''''''''''
		' Increase 'i' and get the specified value at that index
		''''''''''''
		i = i + 1
		Dim specifiedValue As String = Args.Get(i).As(String)
		' If 'isnumber' was specified and is True, the value must be numeric
		If detailsMap.GetDefault("isnumber", False).As(Boolean) Then
			If IsNumber(specifiedValue) = False Then
				If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_VALUE_NOT_NUMERIC, arg, i - 1) ' Return the index of the argument, not that of its value
				Continue
			End If
			needNumberValue = True
		Else
			needNumberValue = False
		End If
		''''''''''''
		' If no list with permitted values was provided, this argument is ok now
		''''''''''''
		If detailsMap.ContainsKey("permittedvalues") = False Then
			result.valuesMap.Put(arg, specifiedValue)
			Continue
		End If
		''''''''''''
		' Validate the specified value
		''''''''''''
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
		''''''''''''
		' Was the specifed value permitted?
		''''''''''''
		If foundValue = False Then
			If result.firstError = 0 Then AddErrorInfoToResult(result, WMB4JARGS_INVALID_VALUE, arg, i - 1) ' Return the index of the argument, not that of its value
			Continue
		End If
	Next

	If result.firstError = 0 Then
		For Each key As String In tmpValidationMap.Keys
			Dim detailsMap As Map = tmpValidationMap.Get(key).As(Map)
			If detailsMap.IsInitialized And detailsMap.GetDefault("required", False).As(Boolean) Then
				If result.valuesMap.ContainsKey(key) = False Then
					AddErrorInfoToResult(result, WMB4JARGS_MISSING_REQUIRED_ARGUMENT, key, -1)
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
' The argument names are sorted alphabetically (case-insensitively).
'
' Example: <code>wmB4Jargs1.PrintHelp("Arguments:", 15, 80, True)</code>
Public Sub PrintHelp(title As String, rightColStart As Int, maxLen As Int, emptyLineBeforeEachArg As Boolean)

	DoPrintHelp(title, rightColStart, maxLen, emptyLineBeforeEachArg, "", "", True)

End Sub

' Like PrintHelp, with these additions:
' - preface: text that will be displayed before the arguments' details are shown
' - epilogue: text that will be displayed after the arguments' details are shown
' - sortArgNames: if False, the arguments' details will be displayed in the order
'   in which they were provided with the 'Add...' methods
Public Sub PrintHelp2(title As String, rightColStart As Int, maxLen As Int, emptyLineBeforeEachArg As Boolean, preface As String, epilogue As String, sortArgNames As Boolean)

	DoPrintHelp(title, rightColStart, maxLen, emptyLineBeforeEachArg, preface, epilogue, sortArgNames)

End Sub

Private Sub DoPrintHelp(title As String, rightColStart As Int, maxLen As Int, emptyLineBeforeEachArg As Boolean, preface As String, epilogue As String, sortArgNames As Boolean)

	Dim lstHelp As List
	lstHelp.Initialize

	Dim lstKeys As List

	If sortArgNames Then
		lstKeys.Initialize
		For Each oneKey As String In validationMap.Keys
			lstKeys.Add(oneKey)
		Next
		lstKeys.SortCaseInsensitive(True)
	Else
		lstKeys = validationList
	End If

	If (rightColStart < 10) Or (maxLen < 40) Or (rightColStart >= maxLen) Then
		rightColStart = 15
		maxLen = 80
	End If

	Log(title)
	If preface <> "" Then Log(preface)

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

	If epilogue <> "" Then Log(epilogue)

End Sub

#Region Getters/Setters
' Default=False; if set to True, the Parse... methods will log all the passed arguments before parsing them
Public Sub setLogValuesBeforeParsing(val As Boolean)

	mLogValues = val

End Sub

' Default=False; if set to True, the Parse... methods will log all the passed arguments before parsing them
Public Sub getLogValuesBeforeParsing As Boolean

	Return mLogValues

End Sub
#End Region ' Getters/Setters

#Region Helpers
Private Sub AddErrorInfoToResult(result As wmB4JargsResult, firstError As Int, offendingArg As String, offendingArgIndex As Int)

	result.firstError = firstError
	result.errorMsg = mapErrorMessages.GetDefault(result.firstError, "")
	result.offendingArg = offendingArg
	result.offendingArgIndex = offendingArgIndex

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