B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private ws As WebSocket
	Private myNumber As Int
	Private timer1 As Timer
	'these variables will be set automatically.
	Private TxtNumber As JQueryElement 'matches an element with id = "txtnumber"
	Private Result As JQueryElement
	Private ServerTime As JQueryElement
End Sub

Public Sub Initialize
	myNumber = Rnd(1, 101)
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	timer1.Initialize("timer1", 1000)
	timer1.Enabled = True
End Sub

Private Sub WebSocket_Disconnected
	timer1.Enabled = False
End Sub

Sub btnGuess_Click (Params As Map)
	Log(ws.Secure)
	Dim s As Long = DateTime.Now
	Dim number As String = TxtNumber.GetVal.Value
	If IsNumber(number) Then
		Dim n As Int = number
		If n > myNumber Then
			Result.SetHtml("My number is smaller.")
		Else If n < myNumber Then
			Result.SetHtml("My number is larger.")
		Else
			Result.SetHtml("<b>Well done!!!</b>")
		End If
	Else
		Result.SetHtml("Please enter a valid number.")
	End If
	TxtNumber.RunMethod("select", Null)
	Log(ws.UpgradeRequest.RemoteAddress & ": " & (DateTime.Now - s))
End Sub

Sub Timer1_Tick
	ServerTime.SetHtml("Server time: " & DateTime.Time(DateTime.Now))
	ws.Flush 'required here as this is a server event
End Sub

Sub txtNumber_KeyUp(Params As Map)
	If Params.Get("which") = 13 Then 'ignore
		btnGuess_Click (Null)
	End If
End Sub

Sub btnReset_Click (Params As Map)
	myNumber = Rnd(1, 101)
End Sub
