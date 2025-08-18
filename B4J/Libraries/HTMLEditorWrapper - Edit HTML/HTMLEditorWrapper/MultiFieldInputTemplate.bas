B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
#Event: CompleteAndClosed(Result as int)
Sub Class_Globals
	
	Private xui As XUI
	Public mBase As B4XView
	Private xDialog As B4XDialog

	Public Label1 As B4XView
	Public Label2 As B4XView
	Public Label3 As B4XView
	Public Label4 As B4XView
	
	Private TextField1 As B4XView
	Private TextField2 As B4XView
	Public Pane1 As B4XView
	Public B4XPlusMinus1 As B4XPlusMinus
	Public B4XPlusMinus2 As B4XPlusMinus
	Public cbCenter As B4XView
	
	Dim tf1HintText,TF2HintText As String
	Public lblHintText As B4XView
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 500dip, 200dip)
	mBase.LoadLayout("multifieldinputtemplate")
	mBase.As(Node).StyleClasses.Add("multi-field-template")
	Label1.As(Node).StyleClasses.Add("multi-field-template")
	Label2.As(Node).StyleClasses.Add("multi-field-template")
	Label3.As(Node).StyleClasses.Add("multi-field-template")
	Label4.As(Node).StyleClasses.Add("multi-field-template")
	
	TextField1.As(Node).StyleClasses.Add("multi-field-template")
	TextField1.As(Node).StyleClasses.Add("multi-field-template")
	
	cbCenter.As(Node).StyleClasses.Add("multi-field-template")
	
End Sub

'Sub required for Template
Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

'Sub required for Template
Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	xDialog.PutAtTop = xui.IsB4A Or xui.IsB4i
	mBase.Color = Dialog.BackgroundColor
	
End Sub

'Sub required for Template
Private Sub DialogClosed(Result As Int) 'ignore
	
End Sub

Public Sub setField1Text(Text As String)
	TextField1.Text = Text
End Sub

Public Sub getField1Text As String
	If TextField1.Text.StartsWith("file:") Then
		
		Return TextField1.Text
	Else
		Return TextField1.Text
	End If
End Sub

Public Sub setField2Text(Text As String)
	TextField2.Text = Text
End Sub

Public Sub getField2Text As String
	Return TextField2.Text
End Sub

Public Sub SetHintText(TextField As Int,HintText As String)
	Select TextField
		Case 1
			tf1HintText = HintText
		Case 2
			TF2HintText = HintText
	End Select
End Sub

Private Sub textField1_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		lblHintText.Text = tf1HintText
	Else
		lblHintText.Text = ""
	End If
End Sub
Private Sub textField2_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		lblHintText.Text = TF2HintText
	Else
		lblHintText.Text = ""
	End If
End Sub

Private Sub textfield2_Action
	xDialog.Close (xui.DialogResponse_Positive)
End Sub
