B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mISValid As Boolean
	Private mErrorPos As Int
	Private mErrorMsg As String
	Private Indent As String
	Private nSpaces As Int
End Sub
'Archive Project Modules - before creating B4xLib'Archive Modules: ide://run?File=C:\Java\jdk1.8.0_271\bin\java.exe&Args=-jar&Args=C:\NoInstApps\B4j\ArchiveProjectModules\ArchiveProjectModules.jar&Args=%PROJECT%\%PROJECT_NAME%.b4j

'Ported from <link>GitHub|https://github.com/Aftaab99/JSONFormatter/blob/master/src/formatter/JsonFormat.java</link>
Public Sub Initialize(Spaces As Int)
	nSpaces = Spaces
End Sub

Public Sub FormatJSON(JSON As String, Validate As Boolean) As String
	
	Dim C As Char
	Dim CurrentIndex As Int = 0
	Dim Output As StringBuilder
	Output.Initialize
	Dim InsideString As Boolean
	
	mISValid = True
	mErrorMsg = ""

	Indent = " ".As(JavaObject).RunMethod("repeat",Array(Max(0,nSpaces).As(Int)))
	
	Dim Character As JavaObject
	Character.InitializeStatic("java.lang.Character")
	
	
	For i = 0 To JSON.Length - 1
		C = JSON.CharAt(i)
		If C = "{" Or C = "[" Then
			Output.Append(C)
			Output.Append(CRLF)
			CurrentIndex = CurrentIndex + 1
			Output.Append(GetIndent(CurrentIndex))
		Else If C = "," Then
			Output.Append(C)
			Output.Append(CRLF)
			Output.Append(GetIndent(CurrentIndex))
		Else If C = $"""$ Then
			Output.Append(C)
			InsideString = Not(InsideString)
		Else If C = "}" Or C = "]" Then
			CurrentIndex = CurrentIndex - 1
			Output.Append(CRLF)
			Output.Append(GetIndent(CurrentIndex))
			Output.Append(C)
		Else If C = "\" Then
			Output.Append(C)
			i = i + 1
			Output.Append(JSON.CharAt(i))
		Else If Not(Character.RunMethod("isWhitespace",Array(C)) And Not(InsideString)) Then
			Output.Append(C)
		End If
	Next
	
	If Validate Then ValidateJSON(Output.ToString)
	
	Return Output
End Sub

Public Sub ValidateJSON(JSON As String)
	Dim Parser As JSONParser
	Parser.Initialize(JSON)
	Try
		If JSON.Trim.StartsWith("{") Then
			Parser.NextObject
		Else
			Parser.NextArray
		End If
		mISValid = True
	Catch
		mISValid = False
		mErrorMsg = LastException.Message
		If mErrorMsg.contains("character") Then
			Dim Pos As String = ExtractBetween(mErrorMsg,"character "," ")
			If IsNumber(Pos) Then mErrorPos = Pos
		End If
	End Try
End Sub

Private Sub GetIndent(Count As Int) As String
	Return Indent.As(JavaObject).RunMethod("repeat",Array(Max(0,Count).As(Int)))
End Sub

Private Sub ExtractBetween(Source As String, First As String, Last As String) As String
	Dim Pos1 As Int = Source.IndexOf(First) + First.Length
	If Pos1 = -1 Then Return ""
	Dim Pos2 As Int = Source.IndexOf2(Last,Pos1 + 1)
	If Pos2 = -1 Then Return ""
	Return Source.SubString2(Pos1,Pos2).Trim
End Sub

Public Sub getIsValid As Boolean
	Return mISValid
End Sub

Public Sub getErrorMessage As String
	Return mErrorMsg
End Sub

Public  Sub getErrorPos As Int
	Return mErrorPos
End Sub

Public Sub CompactString(Str As String) As String
	Str = Str.Replace(CRLF," ")
	
	Do While Str.Contains("  ")
		Str = Str.Replace("  "," ")
	Loop
	Return Str
End Sub