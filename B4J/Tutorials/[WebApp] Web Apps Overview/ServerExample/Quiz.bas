B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private Questions_Div As JQueryElement
	Private btnPrev, btnNext As JQueryElement
	Private Question As JQueryElement
	Private questionIndex As Int = 0
	Private questions As List
	Private startTime As Long
	Type QuestionData(Question As String, Answers(4) As Int, CorrectIndex As Int, UserAnswerIndex As Int)
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	'create the questions and answers
	questions = CreateQuestions(5)
	SetPage
	startTime = DateTime.Now
End Sub

Private Sub SetPage
	Log("Current page: " & questionIndex)
	If questionIndex = questions.Size Then
		'calculate the score
		ws.Alert(WebUtils.ReplaceMap("Your score is: $SCORE$" & CRLF & "It took you $SECONDS$ seconds", _
			CreateMap("SCORE": CalcScore, "SECONDS": NumberFormat((DateTime.Now - startTime) / 1000, 0, 0))))
		questionIndex = questionIndex - 1 'return to the last page
	End If
	Dim qd As QuestionData = questions.Get(questionIndex)
	For i = 0 To qd.Answers.Length - 1
		'choose the label that is associated with the radio button
		Dim jq As JQueryElement = ws.GetElementBySelector("label[for=a" & i & "]")
		jq.SetHtml(qd.Answers(i))
		jq = ws.GetElementById("a" & i)
		jq.SetProp("checked", i = qd.UserAnswerIndex)
	Next
	btnPrev.SetProp("disabled", questionIndex = 0)
	btnNext.SetProp("disabled", qd.UserAnswerIndex = -1)
	Question.SetHtml(qd.Question)
End Sub

Private Sub CalcScore As Int
	Dim correct As Int
	For Each qd As QuestionData In questions
		If qd.UserAnswerIndex = qd.CorrectIndex Then correct = correct + 1
	Next
	Return correct / questions.Size * 100
End Sub
'we can handle all child events by catching the parent event
Private Sub Questions_Div_Change (Params As Map)
	Dim target As String = Params.Get("target") 'find the checked radio
	Dim index As Int = target.SubString(1) 'remove the 'a'
	Dim qd As QuestionData = questions.Get(questionIndex)
	qd.UserAnswerIndex = index
	btnNext.SetProp("disabled", False) 'enable the next button
End Sub

Private Sub BtnNext_Click (Params As Map)
	questionIndex = questionIndex + 1
	SetPage
End Sub

Private Sub BtnPrev_Click (Params As Map)
	questionIndex = questionIndex - 1
	SetPage
End Sub


Private Sub CreateQuestions (NumberOfQuestions As Int) As List
	Dim res As List
	res.Initialize
	For i = 1 To NumberOfQuestions
		Dim qd As QuestionData
		qd.Initialize
		qd.CorrectIndex = Rnd(0, 4) 'the values will be between 0 to 3
		Dim firstNumber As Int = Rnd(0, 20)
		Dim SecondNumber As Int = Rnd(0, 20)
		qd.Question = WebUtils.ReplaceMap("<i>Question #$I$:</i> $N1$ * $N2$ ?", _
			CreateMap("I": i, "N1": firstNumber, "N2": SecondNumber))
		Dim correct As Int = firstNumber * SecondNumber
		qd.Answers(qd.CorrectIndex) = correct
		Dim AlreadyUsed As Map = CreateMap(correct: "")
		For q = 0 To qd.Answers.Length - 1
			If q = qd.CorrectIndex Then Continue
			qd.Answers(q) = CreateGuess(AlreadyUsed, correct)
		Next
		qd.UserAnswerIndex = -1
		res.Add(qd)
	Next
	Return res
End Sub

Private Sub CreateGuess (AlreadyUsed As Map, Correct As Int) As Int
	Dim g As Int = Max(0, Rnd(Correct - 30, Correct + 30))
	If AlreadyUsed.ContainsKey(g) Then Return CreateGuess(AlreadyUsed, Correct)
	AlreadyUsed.Put(g, "")
	Return g
End Sub

Private Sub WebSocket_Disconnected

End Sub