B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket 'ignore
	Private username As JQueryElement
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	username.RunMethod("select", Null)
End Sub

Sub Enter_Click (Params As Map)
	Dim nf As Future = username.GetVal
	Dim name As String = nf.Value
	name = WebUtils.EscapeHtml(name.Trim)
	If ChatShared.AvoidDuplicates.ContainsKey(name.ToLowerCase) Then
		ws.Alert("Name already taken")
	Else If name.Length = 0 Then
		ws.Alert("Invalid name")
	Else
		ws.Session.SetAttribute("name", name)
		ChatShared.AvoidDuplicates.Put(name.ToLowerCase, name)
		WebUtils.RedirectTo(ws, "chat.html")
	End If
End Sub

Private Sub WebSocket_Disconnected
End Sub