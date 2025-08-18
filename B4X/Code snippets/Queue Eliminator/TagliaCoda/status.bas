B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	If Main.Last_rQueue<>Main.rQueue Then
		' next turn
		resp.Write(TextResponse(True))
	Else
		' don't change turn
		resp.Write(TextResponse(False))
	End If
	
	Main.Last_rQueue=Main.rQueue
End Sub

Private Sub TextResponse (Beep As Boolean) As String
	Dim Bp As String = ""
	If Beep Then Bp=$"var snd = new Audio("http://www.suonoelettronico.com/waves22/Doorbell.mp3");
	snd.play();"$
	
	Return $"<!doctype html>
<html lang="it">
<head><title>TURN</title></head>
<body>
<p style="font-size:xx-large; text-align:center;">Serve number</p>
<h1 style="font-size:150px; text-align:center;">${Main.rQueue}</h1>
</body>

<script language="javascript">
${Bp}
setInterval(function(){
   window.location.reload();
}, 3000);
</script>
</html>"$
End Sub
