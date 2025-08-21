B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=5.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Private users As List
	Private server As ServerSocket 'ignore
	
End Sub

Sub Globals
	Private txtMessage As EditText
	Private lstUsers As ListView
	Private txtLogs As EditText
	Private ime As IME
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("2")
	If users.IsInitialized Then NewUsers(users)
	If Starter.isServer Then Activity.Title = $"Server (${server.GetMyWifiIP})"$
	ime.Initialize("ime")
	ime.AddHandleActionEvent(txtMessage)
	ime.AddHeightChangedEvent
	lstUsers.SingleLineLayout.Label.TextSize = 14
	If FirstTime Then
		txtLogs.Text = "" 'don't restore old logs
	End If
End Sub

Sub ime_HeightChanged (NewHeight As Int, OldHeight As Int)
	lstUsers.Height = NewHeight - lstUsers.Top
	txtLogs.Height = NewHeight - txtLogs.Top
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		If Starter.isServer Then
			If Msgbox2("The broker will be closed. Continue?", "", "Yes", "Cancel", "No", Null) <> DialogResponse.POSITIVE Then
				Return True
			End If
		End If
	End If
	Return False
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If UserClosed Then
		CallSub(Starter, "Disconnect")
		StartActivity(Main)
	Else
	End If
End Sub

Sub ime_HandleAction As Boolean
	btnSend_Click
	Return True 'leave the keyboard open	
End Sub

Public Sub NewMessage(msg As Message)
	txtLogs.Text = $"${msg.From}: ${msg.Body}"$ & CRLF & txtLogs.Text
End Sub

Public Sub NewUsers(Users1 As List)
	users = Users1
	lstUsers.Clear
	For Each u As String In users
		lstUsers.AddSingleLine(u)
	Next
End Sub

Sub btnSend_Click
	If txtMessage.Text <> "" Then CallSub2(Starter, "SendMessage", txtMessage.Text)
	txtMessage.SelectAll
End Sub

Public Sub Disconnected
	Activity.Finish
End Sub