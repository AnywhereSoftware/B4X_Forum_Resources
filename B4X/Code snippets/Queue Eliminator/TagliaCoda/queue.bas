B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Dim nQueue As Int
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Main.nQueue=Main.nQueue+1
	nQueue=Main.nQueue
	
	CallSubDelayed(Main,"UpdateQueue")
	resp.Write(TextResponse)
	
End Sub

Private Sub TextResponse As String
	Return $"<!doctype html>
<html lang="it">
<head><title>Request</title></head>
<body>
<center>
<h1  style="font-size:150px; text-align:center;">${nQueue}</h1>
<p1  style="font-size:xx-large; text-align:center;">Your number queue</p1>
</center>
</body>
<script language="javascript">
setInterval(function(){
   window.location.href="/request";
}, 5000);
</script>
</html>"$
End Sub