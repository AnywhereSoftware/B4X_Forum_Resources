Type=Class
Version=2
B4J=true
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private timer1 As Timer
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	timer1.Initialize("timer1", 1000)
	timer1.Enabled = True
End Sub

Sub Timer1_Tick
	ws.RunFunction("ServerTime", Array As Object(DateTime.Time(DateTime.Now)))
	ws.Flush
End Sub

Sub Device_Message(Params As Map)
	Log("Device message: " & Params.Get("message"))
End Sub

Private Sub WebSocket_Disconnected
	timer1.Enabled = False
	Log("disconnected")
End Sub