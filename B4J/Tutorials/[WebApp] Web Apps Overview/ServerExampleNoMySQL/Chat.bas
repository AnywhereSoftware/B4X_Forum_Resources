B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private txt, ChatTxt, Users, btnSend, btnLogout As JQueryElement
	Private name As String
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	name = ws.Session.GetAttribute2("name", "")
	If name = "" Then
		'name not found. Go to the login page. This will happen if the user goes to the chat page directly.
		WebUtils.RedirectTo(ws, "index.html")
	Else
		'remove the attribute
		'the user will be redirected to the login page next time.
		ws.Session.SetAttribute("name", "")
		CallSubDelayed3(ChatShared, "NewConnection", Me, name)
		txt.RunMethod("select", Null)
	End If
End Sub

'Called from ChatShared when the list of members changes.
Public Sub UpdateMembersList (data As String)
	Users.SetHtml(data)
	ws.Flush 'server event so we need to flush
End Sub

Sub btnSend_Click (Params As Map)
	Dim fmsg As Future = txt.GetVal
	Dim msg As String = fmsg.Value
	If msg.Trim.Length > 0 Then
		Dim line As String = WebUtils.ReplaceMap("<b>$NAME$</b>: $H_MSG$<br/>", CreateMap("NAME": name, "H_MSG": msg.Trim))
		'Notify ChatShared that there is a new message
		CallSubDelayed3(ChatShared, "NewMessage", name, line)
	End If
	txt.RunMethod("select", Null)
End Sub

'Called from ChatShared when there is a new message
Sub NewMessage(Msg As String)
	ChatTxt.RunMethod("append", Array As Object(Msg))
	ws.RunFunction("scrollDown", Null)
	ws.Flush
End Sub

Sub btnLogout_Click (Params As Map)
	WebUtils.RedirectTo(ws, "index.html")
End Sub

Private Sub WebSocket_Disconnected
	If name <> "" Then CallSubDelayed3(ChatShared, "Disconnect", Me, name)
End Sub