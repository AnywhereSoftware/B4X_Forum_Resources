B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
End Sub

Private Sub WebSocket_Disconnected

End Sub