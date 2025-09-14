B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9
@EndOfDesignText@
'Static code module
'Ver. 2.00 02/02/2024
Sub Process_Globals
End Sub

'Returns the position of the first occurrence of one string within another. 
'Returns -1 if not found.
Public Sub InStr(Start As Int, Text As String, SearchFor As String, CaseSensitive As Boolean) As Int
	Dim Result As Int
	If Start > Text.Length - 1 Then Return - 1
	If CaseSensitive Then
		Result = Text.IndexOf2(SearchFor, Start)
	Else
		Result = Text.ToLowerCase.IndexOf2(SearchFor.ToLowerCase, Start)
	End If
	Return Result
End Sub

'Returns the position of the first occurrence of one string within another, from the end of string.
'Returns -1 if not found.
'Start: pass -1 to search from the end of Text.

Public Sub InStrRev(Start As Int, Text As String, SearchFor As String, CaseSensitive As Boolean) As Int
	Dim Result As Int
	If Start = - 1 Then Start = Text.Length
	Dim Text2 As String = Text.SubString2(0, Start)
	If CaseSensitive Then
		Result = Text2.LastIndexOf(SearchFor)
	Else
		Result = Text2.ToLowerCase.LastIndexOf(SearchFor.ToLowerCase)
	End If
	Return Result
End Sub

'Returns a specified number of characters from the left side of a string.
Public Sub Left(Text As String, Length As Int) As String
	Return Text.SubString2(0, Length - 1)
End Sub

'Returns a specified number of characters from the right side of a string.
Public Sub Right(Text As String, Length As Int) As String
	Return Text.SubString(Text.Length - Length)
End Sub

'Returns a string created by joining the substrings contained in the array Strings.
Public Sub Join(Strings() As String, Delimiter As String) As String
	Dim sbResult As StringBuilder
	sbResult.Initialize
	For i = 0 To Strings.Length - 1
		sbResult.Append(Strings(i))
		If i < Strings.Length - 1 Then
			sbResult.Append(Delimiter)
		End If
	Next
	Return sbResult.ToString
End Sub

'Returns a copy of a String without leading spaces.
Public Sub LTrim(Text As String) As String
	Return Text.SubString(Text.IndexOf(Text.Trim))
End Sub

'Returns a copy of a String without trailing spaces.
Public Sub RTrim(Text As String) As String
	Dim Trimmed As String = Text.Trim ' ciao lunga 4
	Dim EndIndex As Int = Text.IndexOf(Trimmed) + Trimmed.Length
	Return Text.SubString2(0, EndIndex)
End Sub

'Returns or replace a specified number of characters from a string.
'Length is "optional": pass -1 if not required.
'ReplaceWith is also "optional": pass an empty string if not required.
Public Sub Mid(Text As String, Start As Int, Length As Int, ReplaceWith As String) As String
	Dim Result As String
	
	If ReplaceWith.Length = 0 Then
		If Length <= 0 Then
			Result = Text.SubString(Start)
		Else
			Result = Text.SubString2(Start, Start + Length)
		End If
	Else
		If Length < 0 Then Length = 0
		Result = Text.SubString2(0, Start) & ReplaceWith & Text.SubString(Start + Length)
	End If
	
	Return Result
End Sub

'Returns a string in which a specified substring has been replaced with another substring a specified number of times.
'Expression - String expression containing substring to replace.
'Find - Substring being searched for.
'Replacement - Replacement substring.
'Start - Position within expression where substring search is to begin.
'Count - Number of substring substitutions to perform. Pass -1 to replace all.
Public Sub Replace(Expression As String, Find As String, Replacement As String, Start As Int, Count As Int, CaseSensitive As Boolean) As String
	Dim Expression2, Find2 As String
		
	If CaseSensitive Then
		Expression2 = Expression
		Find2 = Find
	Else
		Expression2 = Expression.ToLowerCase
		Find2 = Find.ToLowerCase
	End If
	
	If Start > 0 Then
		Expression2 = Expression2.SubString(Start)
	End If
	
	Dim Pos As Int
	Dim Counter As Int
	
	If Count = -1 Then
		Return Expression2.Replace(Find2, Replacement)
	Else
		Pos = Expression2.IndexOf(Find2)
		Do While (Pos <> -1) And (Counter < Count)
			Expression2 = Expression2.SubString2(0, Pos) & Replacement & Expression2.SubString(Pos + Find2.Length)
			Pos = Expression2.IndexOf2(Find2, Pos + Find2.Length)
			Counter = Counter + 1
		Loop
	End If
	
	Return Expression2
End Sub

'Returns a string consisting of the specified number of spaces.
Public Sub Space(Number As String) As String
	Dim sbResult As StringBuilder
	sbResult.Initialize
	
	For i = 1 To Number
		sbResult.Append(" ")
	Next
	
	Return sbResult.ToString
End Sub

'Returns a zero-based, one-dimensional array containing a specified number of substrings.
'Limit: If -1 all substrings are returned, otherwise it returns the number of substrings indicated,
'in which the first ones respect the indicated delimiter string and the last one represents all
'the residual part of the original string.
Public Sub Split(Expression As String, Delimiter As String, Limit As Int, CaseSensitive As Boolean) As String()
	Dim Result() As String
	
	If Limit < 2 And Limit <> - 1 Then
		Dim Result(1) As String
		Result(0) = Expression
		Return Result
	End If
	
	Dim Words() As String
	
	If CaseSensitive Then
		Words = Regex.Split(Delimiter, Expression)
	Else
		Words = Regex.Split2(Delimiter, Regex.CASE_INSENSITIVE, Expression)
	End If
	
	If Limit = - 1 Or Limit >= Words.Length Then
		Result = Words
	Else
		Dim Result(Limit) As String
		For i = 0 To Limit - 2
			Result(i) = Words(i)
		Next
		Dim sb As StringBuilder
		sb.Initialize
		For i = Limit - 1 To Words.Length - 1
			sb.Append(Words(i))
			If i < Words.Length - 1 Then
				sb.Append(Delimiter)
			End If
		Next
		Result(Limit - 1) = sb.ToString
	End If
	
	Return Result
End Sub

'Returns a string in which the character order of a specified string is reversed.
Public Sub StrReverse(Text As String) As String
	Dim sbResult As StringBuilder
	sbResult.Initialize
	For i = Text.Length - 1 To 0 Step - 1
		sbResult.Append(Text.SubString2(i, i + 1))
	Next
	Return sbResult.ToString
End Sub