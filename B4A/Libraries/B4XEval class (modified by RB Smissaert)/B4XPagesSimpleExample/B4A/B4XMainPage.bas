B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private edtExpression As B4XView
	Private btnCalculate As B4XView
	Private lblResult As B4XView
	
	Type EvalReturn(dValue As Double, _
					bError As Boolean)
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("P_MainPage")

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Sub B4XPage_Appear

End Sub

Sub Eval_Function (Name As String, Values As List) As Double
	
	Select Name 'it will be lower case
		Case "min"
			Dim d As Double = Values.Get(0)
			For Each n As Double In Values
				If n < d Then d = n
			Next
			Return d
		Case "max"
			Dim d As Double = Values.Get(0)
			For Each n As Double In Values
				If n > d Then d = n
			Next
			Return d
		Case "sin"
			Return SinD(Values.Get(0))
		Case Else
			'Log("Invalid function: " & Name)
			Dim e As B4XEval = Sender
			e.Error = True
			Return 0
	End Select
	
End Sub

Sub btnCalculate_Click
	
	Dim e As B4XEval
	Dim tER As EvalReturn
	Dim strExpression As String
	
	e.Initialize(Me, "Eval")
	
	strExpression = edtExpression.Text
	
	tER = e.Eval(strExpression)
	
	If tER.bError Then
		lblResult.Text = "Error"
	Else
		lblResult.Text = tER.dValue
	End If
	
End Sub