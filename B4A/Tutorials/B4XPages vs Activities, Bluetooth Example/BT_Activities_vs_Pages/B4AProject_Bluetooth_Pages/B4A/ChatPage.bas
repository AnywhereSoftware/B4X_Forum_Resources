B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private txtInput As EditText
	Private txtLog As EditText
	Public btnSend As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("2")
End Sub

'Return True to close, False to cancel
Sub B4XPage_CloseRequest As ResumableSub
	If B4XPages.MainPage.ConnectionState = True Then
		Dim sf As Object = xui.Msgbox2Async("Disconnect?", "", "Yes", "", "No", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			Log("Deleted!!!")
			B4XPages.MainPage.Disconnect
			Return True
		Else
			Return False
		End If
	End If
	Return True
End Sub

Public Sub NewMessage (msg As String)
	LogMessage("You", msg)
End Sub

Sub txtInput_EnterPressed
	If btnSend.Enabled = True Then btnSend_Click
End Sub

Sub btnSend_Click
	B4XPages.MainPage.SendMessage(txtInput.Text)
	txtInput.SelectAll
	txtInput.RequestFocus
	LogMessage("Me", txtInput.Text)
End Sub

Sub LogMessage(From As String, Msg As String)
	txtLog.Text = txtLog.Text & From & ": " & Msg & CRLF
	txtLog.SelectionStart = txtLog.Text.Length
End Sub
