B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private CurrentIndex As Int
	Private mMaxcount As Int
End Sub

Public Sub Initialize
	
End Sub

Public Sub getMaxcount As Int
	Return mMaxcount
End Sub

'For Rows as Arrays
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

'For Rows As Lists
Public Sub GenerateString2 (Table As List, SeparatorChar As String) As String
	Dim eol As String = Chr(10)
	If Table.Size = 0 Then Return ""
	Dim sb As StringBuilder
	sb.Initialize
	For Each row As List In Table
		For i = 0 To row.Size - 1
			Dim Wrap As Boolean
			Dim word As String = row.Get(i)
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

'Returns a list of arrays
Public Sub Parse (Input As String, SeparatorChar As String, SkipFirstRow As Boolean) As List
	SeparatorChar = SeparatorChar.CharAt(0)
	Dim Result As List
	Result.Initialize
	If Input = "" Then Return Result
	CurrentIndex = 0
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

'Returns a list of lists.
Public Sub ParseIrregular(Text As String, Delimiter As String) As List
	
	Dim Result As List
	Result.Initialize
	
	'Remove extra spaces
	Text = Regex.Replace($"\"\s+${Delimiter}"$,Text,$"\"${Delimiter}"$)
	Text = Regex.Replace($"${Delimiter}\s+\""$,Text,$"${Delimiter}\""$)

	Dim INQuotes As Boolean
	For i = 0 To Text.Length - 2
		If ((Text.CharAt(i) = Delimiter Or Text.CharAt(i) = CRLF) And Text.CharAt(i+1) = QUOTE) Or (i = 0 And Text.CharAt(i) = QUOTE) Then
			INQuotes = True
			Continue
		End If
		If Text.CharAt(i) = QUOTE And (Text.CharAt(i+1) = Delimiter Or Text.CharAt(i+1) = CRLF) Then
			INQuotes = False
			Continue
		End If
		
		If INQuotes Then
			If Text.CharAt(i) = Delimiter Then Text = Text.SubString2(0,i) & Chr(2) & Text.SubString(i+1)
			
			'Attempt to allow quotes within quotes.  Too messy
'			If Text.CharAt(i) = QUOTE And Text.CharAt(i+1) <> Delimiter Then
'				Text = Text.SubString2(0,i) & Chr(3) & Text.SubString(i+1)
'			End If
		End If
	Next
	
	Dim Rows As List = Regex.Split(CRLF,Text)
	mMaxcount = 0
	
	
	For i = 0 To Rows.Size - 1
		Dim Row As String = Rows.Get(i)
		mMaxcount = Max(mMaxcount,StringCount(Row,Delimiter,False))
'		Rows.Set(i,Row)
	Next
	
	For Each R As String In Rows
		Dim L As List
		L.Initialize
		Dim NewRow As List = FixedSizedSplit(Delimiter,R,mMaxcount+1)
		For i = 0 To NewRow.Size - 1
			Dim S As String = NewRow.Get(i)
			If S <> "" Then
				If S.Contains(Chr(2)) Then
					Do While S.CharAt(0) = QUOTE And S.CharAt(S.Length - 1) = QUOTE
						S=S.SubString2(1,S.Length - 1)
					Loop
					Do While S.Contains($""""$)
						S = S.Replace($""""$,$"""$)
					Loop
					S = S.Replace(Chr(2),Delimiter)
					NewRow.Set(i,S)
				End If
				'Attempt to allow quotes within quotes.  Too messy
'				If S.Contains(Chr(3)) Then
'					S = S.Replace(Chr(3),QUOTE)
'					Log(S)
'					Do While S.CharAt(0) = QUOTE And S.CharAt(S.Length - 1) = QUOTE
'						S=S.SubString2(1,S.Length - 1)
'					Loop
'					Log(S)
'					Do While S.Contains($""""$)
'						S = S.Replace($""""$,$"""$)
'					Loop
'					Log(S)
'					NewRow.Set(i,S)
'				End If
			End If
		Next
		L.AddAll(NewRow)
		
'		If RemoveNum Then
'			Dim NewText As String = L.Get(0)
'			If NewText.Contains(") ") Then
'				Dim Pos As Int = NewText.IndexOf(") ")
'				If Pos < 5 Then NewText = NewText.SubString(Pos + 2)
'				L.Set(0,NewText)
'			End If
'		End If
		Result.Add(L)
	Next
	
	Return Result
End Sub

Private Sub StringCount(StringToSearch As String,TargetStr As String,IgnoreCase As Boolean) As Int
	If IgnoreCase Then
		StringToSearch = StringToSearch.ToLowerCase
		TargetStr = TargetStr.ToLowerCase
	End If

	Return (StringToSearch.Length - StringToSearch.Replace(TargetStr,"").Length) / TargetStr.Length

End Sub

Private Sub FixedSizedSplit(Delim As String,Str As String, Len As Int) As List
	Dim Sp() As String = Regex.Split(Delim,Str)
	Dim L As List
	L.Initialize
	
	For i = 0 To Sp.Length - 1
		L.Add(Sp(i))
	Next
	
	For i = i To Len - 1
		L.Add("")
	Next
	Return L
End Sub