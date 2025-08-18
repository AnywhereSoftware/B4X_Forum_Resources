Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=1.80
@EndOfDesignText@
#Region Module Attributes
	#FullScreen: False
	#IncludeTitle: True
#End Region

'Activity module
Sub Process_Globals
End Sub

Sub Globals
	Private txtInput As EditText
	Private txtLog As EditText
	Private btnSend As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("2")
End Sub

Public Sub NewMessage (msg As String)
	LogMessage("You", msg)
End Sub

Sub Activity_Resume
	UpdateState
End Sub

Public Sub UpdateState
	btnSend.Enabled = Starter.Manager.ConnectionState
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If UserClosed Then
		Starter.Manager.Disconnect
	End If
End Sub

Sub txtInput_EnterPressed
	If btnSend.Enabled = True Then btnSend_Click
End Sub
Sub btnSend_Click
	Starter.Manager.SendMessage(txtInput.Text)
	txtInput.SelectAll
	txtInput.RequestFocus
	LogMessage("Me", txtInput.Text)
End Sub

Sub LogMessage(From As String, Msg As String)
	txtLog.Text = txtLog.Text & From & ": " & Msg & CRLF
	txtLog.SelectionStart = txtLog.Text.Length
End Sub