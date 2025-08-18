B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private x = 10, y = 10, vx = 10, vy = 10 As Int
	Private timer1 As Timer
	Private cvsWidth, cvsHeight As Int
	Private cvs As JQueryElement
	Private boxSize As Int = 90
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	Log("connected: " & Main.srvr.CurrentThreadIndex)
	ws = WebSocket1
	timer1.Initialize("timer1", 15)
	timer1.Enabled = True
	Dim fw As Future = cvs.GetWidth
	Dim fh As Future = cvs.GetHeight
	cvsHeight = fh.Value
	cvsWidth = fw.Value
	timer1.Enabled = True
	'set the document background color
	Dim jq As JQueryElement = ws.GetElementBySelector("body")
	
	jq.SetCSS("background-color", "#9eebf8")
	
End Sub

Private Sub WebSocket_Disconnected
		Log("disconnected: " & Main.srvr.CurrentThreadIndex)

	timer1.Enabled = False
End Sub

Sub Timer1_Tick
	ws.RunFunction("ClearRect", Array As Object(x, y, boxSize, boxSize))
	If x  + boxSize > cvsWidth Then
		vx = -1 * Abs(vx)
	Else If x < 5 Then
		vx = Abs(vx)
	End If
	If y  + boxSize > cvsHeight Then
		vy = -1 * Abs(vy)
	Else If y < 5 Then
		vy = Abs(vy)
	End If
	x = x + vx
	y = y + vy
	ws.RunFunction("DrawImage", Array As Object(x, y))
	ws.Flush
End Sub