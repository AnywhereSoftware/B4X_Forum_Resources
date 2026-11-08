B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'#############################################################
'# clsB4XSourceParser.bas
'# Parser for B4X source files: .bas, .b4a, .b4j, .b4i
'# Extracts: Subs, variables, parameters, constants
'#############################################################

#Region VERSIONS
' v. 1.00	09/03/2026
#End Region

Sub Class_Globals
	Type tParsedVariable(Name As String, VarType As String, Line As Int, SubName As String, IsParam As Boolean, FileName As String, Scope As String)
	Type tParsedSub(Name As String, Line As Int, FileName As String)
	Type tParsedConstant(Name As String, Value As String, Line As Int, FileName As String, Scope As String, SubName As String)
	Type tResult(Vars As List, Subs As List, Consts As List)

	Private mCurrentSub As String
	Private mCurrentFile As String
End Sub

Public Sub Initialize
End Sub

Public Sub ParseBasFile(Dir As String, FileName As String) As tResult
	' Local lists used to collect parsed elements
	Dim Vars As List
	Dim Subs As List
	Dim Consts As List

	Vars.Initialize
	Subs.Initialize
	Consts.Initialize

	' Normalize file name extension
	Dim LowerFileName As String = FileName.ToLowerCase
	If LowerFileName.EndsWith(".bas") = False And LowerFileName.EndsWith(".b4j") = False And LowerFileName.EndsWith(".b4a") = False And LowerFileName.EndsWith(".b4i") = False Then
		FileName = FileName & ".bas"
	End If

	' Check file existence
	If File.Exists(Dir, FileName) = False Then
		Log($"File ${Dir}\${FileName} not found."$)
		Return Null
	End If

	' Set parser state
	mCurrentFile = FileName
	mCurrentSub = ""

	Dim FileLines As List = File.ReadList(Dir, FileName)

	' Process file line by line
	For LineIndex = 0 To FileLines.Size - 1
		Dim RawLine As String = FileLines.Get(LineIndex).As(String)
		Dim Statements As List = SplitStatements(RawLine)

		For Each Stmt As String In Statements
			AnalyzeLine(Stmt.Trim, LineIndex + 1, Vars, Subs, Consts)
		Next
	Next

	' Build result structure
	Dim Result As tResult
	Result.Initialize
	Result.Vars = Vars
	Result.Subs = Subs
	Result.Consts = Consts
	Return Result
End Sub

' Splits a raw line into logical statements using ':' only when it is a true separator.
Private Sub SplitStatements(Line As String) As List
	Dim Parts As List
	Parts.Initialize

	Dim Current As StringBuilder
	Current.Initialize

	Dim InString As Boolean = False
	Dim InComment As Boolean = False
	Dim EscapeNext As Boolean = False

	Dim ParenDepth As Int = 0
	Dim BraceDepth As Int = 0
	Dim BracketDepth As Int = 0

	For i = 0 To Line.Length - 1
		Dim ch As String = Line.CharAt(i)

		' Handle escaped characters inside strings
		If EscapeNext Then
			Current.Append(ch)
			EscapeNext = False
			Continue
		End If

		' Backslash escape
		If ch = "\" Then
			EscapeNext = True
			Current.Append(ch)
			Continue
		End If

		' Everything after ' is a comment
		If InComment Then
			Current.Append(ch)
			Continue
		End If

		' Start of comment
		If ch = "'" And InString = False Then
			InComment = True
			Current.Append(ch)
			Continue
		End If

		' String delimiter
		If ch = """" Then
			InString = Not(InString)
			Current.Append(ch)
			Continue
		End If

		' Parentheses depth tracking
		If ch = "(" Then ParenDepth = ParenDepth + 1
		If ch = ")" And ParenDepth > 0 Then ParenDepth = ParenDepth - 1

		' Braces depth tracking
		If ch = "{" Then BraceDepth = BraceDepth + 1
		If ch = "}" And BraceDepth > 0 Then BraceDepth = BraceDepth - 1

		' Brackets depth tracking
		If ch = "[" Then BracketDepth = BracketDepth + 1
		If ch = "]" And BracketDepth > 0 Then BracketDepth = BracketDepth - 1

		' Real statement separator
		If ch = ":" And InString = False And InComment = False And ParenDepth = 0 And BraceDepth = 0 And BracketDepth = 0 Then
			Dim Part As String = Current.ToString.Trim
			If Part <> "" Then Parts.Add(Part)
			Current.Initialize
			Continue
		End If

		Current.Append(ch)
	Next

	Dim LastPart As String = Current.ToString.Trim
	If LastPart <> "" Then Parts.Add(LastPart)

	Return Parts
End Sub

' Analyzes a single logical statement and dispatches it to the correct parser.
Private Sub AnalyzeLine(Line As String, LineNumber As Int, Vars As List, Subs As List, Consts As List)
	If Line = "" Or Line.StartsWith("'") Then Return

	Dim LowerLine As String = Line.ToLowerCase

	' Sub declaration
	If LowerLine.StartsWith("sub ") Or LowerLine.StartsWith("public sub") Or LowerLine.StartsWith("private sub") Then
		ParseSubDeclaration(Line, LineNumber, Subs, Vars)
		Return
	End If

	' End Sub
	If LowerLine.StartsWith("end sub") Then
		mCurrentSub = ""
		Return
	End If

	' Constant declaration
	If LowerLine.Contains(" const ") Or LowerLine.StartsWith("public const") Or LowerLine.StartsWith("private const") Then
		ParseConstant(Line, LineNumber, Consts)
		Return
	End If

	' Variable declaration (excluding constants)
	If (LowerLine.StartsWith("dim ") Or LowerLine.StartsWith("private ") Or LowerLine.StartsWith("public ")) _
        And LowerLine.Contains(" const ") = False Then
		ParseVariableDeclaration(Line, LineNumber, Vars)
		Return
	End If
End Sub

' Parses a Sub declaration and extracts its name and parameters.
Private Sub ParseSubDeclaration(Line As String, LineNumber As Int, Subs As List, Vars As List)
	Dim SubIndex As Int = Line.ToLowerCase.IndexOf("sub")
	Dim NamePart As String = Line.SubString(SubIndex + 3).Trim

	Dim SubName As String = NamePart
	If SubName.Contains("(") Then
		SubName = SubName.SubString2(0, SubName.IndexOf("(")).Trim
	End If

	mCurrentSub = SubName

	Dim ParsedSub As tParsedSub
	ParsedSub.Initialize
	ParsedSub.Name = SubName
	ParsedSub.Line = LineNumber
	ParsedSub.FileName = mCurrentFile
	Subs.Add(ParsedSub)

	' Parse parameters if present
	If NamePart.Contains("(") And NamePart.Contains(")") Then
		Dim Params As String = NamePart.SubString2(NamePart.IndexOf("(") + 1, NamePart.IndexOf(")"))
		ParseParameters(Params, LineNumber, SubName, Vars)
	End If
End Sub

' Parses parameter declarations inside a Sub.
Private Sub ParseParameters(Params As String, LineNumber As Int, SubName As String, Vars As List)
	If Params.Trim = "" Then Return

	Dim ParamParts() As String = Regex.Split(",", Params)
	For Each ParamText As String In ParamParts
		ParamText = ParamText.Trim
		If ParamText.Contains(" As ") Then
			Dim ParamName As String = ParamText.SubString2(0, ParamText.IndexOf(" As ")).Trim
			Dim ParamType As String = ParamText.SubString(ParamText.IndexOf(" As ") + 4).Trim

			Dim ParsedVar As tParsedVariable
			ParsedVar.Initialize
			ParsedVar.Name = ParamName
			ParsedVar.VarType = ParamType
			ParsedVar.Line = LineNumber
			ParsedVar.SubName = SubName
			ParsedVar.IsParam = True
			ParsedVar.FileName = mCurrentFile
			ParsedVar.Scope = "Param"

			Vars.Add(ParsedVar)
		End If
	Next
End Sub

' Parses variable declarations (Dim, Private, Public).
Private Sub ParseVariableDeclaration(Line As String, LineNumber As Int, Vars As List)
	Dim CleanLine As String = Line.Replace("Dim ", "").Replace("Private ", "").Replace("Public ", "").Trim

	If CleanLine.Contains(" As ") Then
		Dim VarName As String = CleanLine.SubString2(0, CleanLine.IndexOf(" As ")).Trim

		Dim AfterAs As String = CleanLine.SubString(CleanLine.IndexOf(" As ") + 4).Trim

		' Remove assignment if present
		If AfterAs.Contains("=") Then
			AfterAs = AfterAs.SubString2(0, AfterAs.IndexOf("=")).Trim
		End If

		' Remove comment if present
		If AfterAs.Contains("'") Then
			AfterAs = AfterAs.SubString2(0, AfterAs.IndexOf("'")).Trim
		End If

		Dim VarType As String = AfterAs

		Dim ParsedVar As tParsedVariable
		ParsedVar.Initialize
		ParsedVar.Name = VarName
		ParsedVar.VarType = VarType
		ParsedVar.Line = LineNumber
		ParsedVar.SubName = mCurrentSub
		ParsedVar.IsParam = False
		ParsedVar.FileName = mCurrentFile
		ParsedVar.Scope = IIf(mCurrentSub = "", "Global", "Local")

		Vars.Add(ParsedVar)
	End If
End Sub

' Parses constant declarations (Public Const / Private Const).
Private Sub ParseConstant(Line As String, LineNumber As Int, Consts As List)
	' Constants are allowed only inside Class_Globals, Process_Globals or Globals
	Dim ls As String = mCurrentSub.ToLowerCase
	If ls <> "class_globals" And ls <> "process_globals" And ls <> "globals" Then Return

	Dim LowerLine As String = Line.ToLowerCase
	Dim IsPublic As Boolean = LowerLine.StartsWith("public const")
	Dim Scope As String = IIf(IsPublic, "Public", "Private")

	Dim CleanLine As String = Line.Replace("Public Const ", "").Replace("Private Const ", "").Trim

	If CleanLine.Contains("=") Then
		Dim ConstName As String = CleanLine.SubString2(0, CleanLine.IndexOf("=")).Trim
		Dim ConstValue As String = CleanLine.SubString(CleanLine.IndexOf("=") + 1).Trim

		Dim ParsedConst As tParsedConstant
		ParsedConst.Initialize
		ParsedConst.Name = ConstName
		ParsedConst.Value = ConstValue
		ParsedConst.Line = LineNumber
		ParsedConst.FileName = mCurrentFile
		ParsedConst.Scope = Scope
		ParsedConst.SubName = mCurrentSub

		Consts.Add(ParsedConst)
	End If
End Sub
