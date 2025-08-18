B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket 'ignore
	Private btnSend, txt As JQueryElement
	Private users As JQueryElement
	Private tblMessages As JQueryElement
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	CallSubDelayed2(PushShared, "NewBrowserConnection", Me)
	tblMessages.RunMethod("dataTable", Array As Object( _
		CreateMap("bFilter": False, "bPaginate": False, "bSort": False, _
			"bAutoWidth": False, "aoColumns": Array As Object(CreateMap("sWidth": "20%"), CreateMap("sWidth": "80%")))))
	UpdateMessagesTable
End Sub

Private Sub btnSend_Click (Params As Map)
	Dim f As Future = txt.GetVal
	Dim msg As String = f.Value
	msg = msg.Trim
	If msg.Length > 0 Then
		CallSubDelayed3(PushShared, "NewMessage", msg, Null)
	End If
	txt.RunMethod("select", Null)
End Sub

Public Sub UpdateMessagesTable
	DBUtils.FillTable(ws, tblMessages, _
	PushShared.PushDB.ExecQuery("SELECT msg_id, text FROM messages ORDER BY time DESC LIMIT 10"))
	ws.Flush
End Sub

Public Sub UpdateConnectedIds(s As String)
	users.SetHtml(s)
	ws.Flush
End Sub

Private Sub WebSocket_Disconnected
	CallSubDelayed2(PushShared, "BrowserDisconnected", Me)
End Sub