B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.78
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private mTextEngine As BCTextEngine
	Private xui As XUI
	Public TOKEN_COMMENT = 1, TOKEN_STRING = 2, TOKEN_NUMBER = 3, TOKEN_IDENTIFIER = 4, TOKEN_KEYWORD = 5, TOKEN_ATTRIBUTE = 6 As Int
	Public TOKEN_PREPROCESSOR = 7, TOKEN_SUBNAME = 8, TOKEN_DEFAULT = 9, TOKEN_TYPE = 10, TOKEN_LINENUMBER = 11 As Int
	Private Keywords As B4XSet
	Private Operators As String = "&*+-/().<>="
	Private Separators As String = "' ,:{}" & TAB & Operators
	Public TokenColors As Map
	Public DefaultFont As B4XFont
	Public DefaultBoldFont As B4XFont
	Public FontSize As Int = 12
End Sub

Public Sub Initialize (TextEngine As BCTextEngine)
	mTextEngine = TextEngine
	Keywords = B4XCollections.CreateSet
	For Each keyword As String In Array("If", "Try", "Catch", "Dim", "While", "Until", "Step", "Then", "Else", "End", _
		"For", "Next", "Do", "Each", "In", "Type", "As", "Loop", "Return", "Array", "To", "Case", "Wait", _
		"Private", "Public", "Const", "End If", "End Sub", "End Try", "End Select", "Do While", "Do Until", "For Each", "And", "Or", "Mod", "Sub")
		Keywords.Add(keyword.ToLowerCase)
	Next
End Sub

Public Sub Parse (Code As String) As List
	Dim runs As List
	runs.Initialize
	#if B4J
	Dim fx As JFX
	Dim monospace As Font = fx.CreateFont("Consolas", FontSize, False, False)
	Dim MonospaceBold As Font = fx.CreateFont("Consolas", FontSize, True, False)
	#Else If B4A
	Dim monospace As Typeface = Typeface.CreateNew(Typeface.MONOSPACE, Typeface.STYLE_NORMAL)
	Dim MonospaceBold As Typeface = Typeface.CreateNew(Typeface.MONOSPACE, Typeface.STYLE_BOLD)
	#Else If B4i
	Dim monospace As Font = Font.CreateNew2("DevanagariSangamMN", FontSize)
	Dim MonospaceBold As Font = Font.CreateNew2("DevanagariSangamMN-Bold", FontSize)
	#End If
	DefaultFont = xui.CreateFont(monospace, FontSize)
	DefaultBoldFont = xui.CreateFont(MonospaceBold, FontSize)
	Dim LineNumber As Int
	For Each Line As String In Regex.Split("\r?\n", Code)
		LineNumber = LineNumber + 1
		runs.Add(CreateLineNumber(LineNumber))
		runs.AddAll(ParseLine(Line))
		CreateRun(CRLF, TOKEN_DEFAULT, runs)
	Next
	Return runs
End Sub

Private Sub CreateLineNumber(Number As Int) As BCTextRun
	Dim parent As BCTextRun = mTextEngine.CreateConnectedParent
	Dim cr As BCConnectedRuns = parent.Extra.Get(mTextEngine.EXTRA_CONNECTEDRUNS)
	cr.ConnectedWidth = 30dip
	CreateRun(Number, TOKEN_LINENUMBER, cr.Runs)
	Return parent
End Sub

Private Sub ParseLine (Line As String) As List
	Dim LineRuns As List
	LineRuns.Initialize
	Dim wordStart, i As Int
	Do While i <= Line.Length 
		Dim c As String
		If i = Line.Length Then c = " " Else c = Line.CharAt(i)
		If Separators.Contains(c) Or (i = wordStart + 1 And Separators.Contains(Line.CharAt(wordStart))) Then
			If i > wordStart Then
				Dim word As String = Line.SubString2(wordStart, i)
				i = DecideWordType(Line, word, i, LineRuns)
				wordStart = i
			End If
		End If
		i = i + 1
	Loop
	Return LineRuns
End Sub

Private Sub DecideWordType (Line As String, Word As String, i As Int, Runs As List) As Int
	Dim WordStart As Int = i - Word.Length
	Dim char0 As String = Word.CharAt(0)
	If char0 = "'" Then
		CreateRun(Line.SubString2(WordStart, Line.Length), TOKEN_COMMENT, Runs)
		i = Line.Length
	Else If char0 = """" Then
		Dim i2 As Int = WordStart + 1
		Do While i2 < Line.Length
			If Line.CharAt(i2) = """" Then
				If i2 = Line.Length - 1 Or Line.CharAt(i2 + 1) <> """" Then
					Exit
				Else If i2 < Line.Length - 1 Then
					i2 = i2 + 1
				End If
			End If
			i2 = i2 + 1
		Loop
		CreateRun(Line.SubString2(WordStart, i2 + 1), TOKEN_STRING, Runs)
		i = i2 + 1
	Else If Regex.IsMatch("\d", char0) Then
		Dim m As Matcher = Regex.Matcher("(0[Xx])([0123456789aAbBcCdDeEfF])+|(\d+([Ee][+-]?\d+)?(dip|%[xX]|%[yY])?)", Line.SubString(WordStart))
		If m.Find And m.GetStart(0) = 0 Then
			i = WordStart + m.GetEnd(0)
			Dim DotOffset As Int = 0
			If WordStart > 0 And Line.CharAt(WordStart - 1) = "." Then
				DotOffset = 1
				Runs.RemoveAt(Runs.Size - 1)
			End If
			CreateRun(Line.SubString2(WordStart - DotOffset, WordStart + m.GetEnd(0)), TOKEN_NUMBER, Runs)
		End If
	Else If Regex.IsMatch("\w", char0) Then
		
		Dim Added As Boolean
		If Keywords.Contains(Word.ToLowerCase) Then
			CreateRun(Word, TOKEN_KEYWORD, Runs)
			Added = True
		Else If Runs.Size > 1 Then
			Dim prev As BCTextRun = Runs.Get(Runs.Size - 2)
			If prev.Tag = TOKEN_KEYWORD Then 'ignore
				Dim PrevLower As String = prev.Text.ToLowerCase
				If PrevLower = "as" Or PrevLower = "is" Or PrevLower = "type" Then
					CreateRun(Word, TOKEN_TYPE, Runs)
					Added = True
				Else If PrevLower = "sub" Then
					CreateRun(Word, TOKEN_SUBNAME, Runs)
					Added = True
				End If
			End If
		End If
		If Added = False Then CreateRun(Word, TOKEN_IDENTIFIER, Runs)
	Else If char0 = "#" Then
		CreateRun(Word, TOKEN_ATTRIBUTE, Runs)
		CreateRun(Line.SubString(WordStart + Word.Length), TOKEN_STRING, Runs)
		i = Line.Length
	Else
		If Runs.Size > 0 Then
			Dim prev As BCTextRun = Runs.Get(Runs.Size - 1)
			If prev.Tag = TOKEN_DEFAULT Then 'ignore
				Runs.RemoveAt(Runs.Size - 1)
				Word = prev.Text & Word
			End If
		End If
		CreateRun(Word, TOKEN_DEFAULT, Runs)
	End If
	Return i
End Sub

Private Sub CreateRun(Word As String, TokenType As Int, Runs As List)
	Dim run As BCTextRun = mTextEngine.CreateRun(Word)
	If TokenColors.ContainsKey(TokenType) = False Then
		Log("Missing color for: " & TokenType)
	End If
	run.TextColor = TokenColors.Get(TokenType)
	run.Tag = TokenType
	If TokenType = TOKEN_SUBNAME Then
		run.TextFont = DefaultBoldFont
	Else
		run.TextFont = DefaultFont
	End If
	Runs.Add(run)
End Sub

