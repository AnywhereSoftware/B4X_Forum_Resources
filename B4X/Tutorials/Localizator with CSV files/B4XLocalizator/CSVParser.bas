B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private CurrentIndex As Int
End Sub

Public Sub Initialize
	
End Sub

Public Sub GenerateString (Table As List, SeparatorChar As String) As String
	Dim eol As String = Chr(10)
	If Table.Size = 0 Then Return ""
	Dim sb As StringBuilder
	sb.Initialize
	For Each row() As String In Table
		For i = 0 To row.Length - 1
			Dim Wrap As Boolean
			Dim word As String = row(i)
			If word.Contains(SeparatorChar) Then Wrap = True
			If word.Contains(QUOTE) Then
				Wrap = True
				word = word.Replace(QUOTE, $""""$)
			End If
			If Wrap Then
				sb.Append(QUOTE).Append(word).Append(QUOTE)
			Else
				sb.Append(word)
			End If
			sb.Append(SeparatorChar)
		Next
		sb.Remove(sb.Length - 1, sb.Length)
		sb.Append(eol)
	Next
	sb.Remove(sb.Length - eol.Length, sb.Length)
	Return sb.ToString
End Sub

Public Sub Parse (Input As String, SeparatorChar As String, SkipFirstRow As Boolean) As List
	SeparatorChar = SeparatorChar.CharAt(0)
	Dim Result As List
	Result.Initialize
	If Input = "" Then Return Result
	CurrentIndex = 0 '<--- go back to the headers line if SkipFirstRow = False
	Dim count As Int = ReadLine(Input, Null, True, SeparatorChar)
	If SkipFirstRow = False Then CurrentIndex = 0
	Do While CurrentIndex < Input.Length
		Dim row(count) As String
		ReadLine(Input, row, False, SeparatorChar)
		Result.Add(row)
	Loop
	Return Result
End Sub

Private Sub ReadLine(Input As String, Row() As String, JustCount As Boolean, Sep As String) As Int
	Dim InsideQuotes As Boolean
	Dim sb As StringBuilder
	sb.Initialize
	Dim count As Int
	Do While CurrentIndex <= Input.Length
		Dim c As String
		If CurrentIndex < Input.Length Then
			c = Input.CharAt(CurrentIndex)
		Else
			c = Chr(10)
		End If
		If InsideQuotes Then
			If c = QUOTE Then
				'double quotes
				If CurrentIndex < Input.Length - 1 And Input.CharAt(CurrentIndex + 1) = QUOTE Then
					sb.Append(QUOTE)
					CurrentIndex = CurrentIndex + 1
				Else
					InsideQuotes = False
				End If
			Else
				sb.Append(c)
			End If
		Else
			If c = Chr(13) Then
				CurrentIndex = CurrentIndex + 1
				Continue
			Else If c = Chr(10) Then
				If JustCount = False Then Row(count) = sb.ToString
				count = count + 1
				CurrentIndex = CurrentIndex + 1
				Exit
			Else If c = Sep Then
				If JustCount = False Then Row(count) = sb.ToString
				sb.Remove(0, sb.Length)
				count = count + 1
				InsideQuotes = False
			Else If c = QUOTE Then
				InsideQuotes = True
			Else
				sb.Append(c)
			End If
		End If
		CurrentIndex = CurrentIndex + 1
	Loop
	Return count
End Sub