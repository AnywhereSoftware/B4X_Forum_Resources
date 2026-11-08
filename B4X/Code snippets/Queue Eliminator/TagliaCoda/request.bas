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
	resp.Write(TextResponse)
End Sub

Private Sub TextResponse As String
	Return $"<!doctype html>
<html lang="it">
<head><title>Request</title></head>
<body>
<BR><BR>
<center><button style="font-size:50px; text-align:center;" type="button" onclick="myFunction()">Request a turn</button><br/><center>

<script type="text/javascript">
		function myFunction() {
			 window.location.href="/queue";
		};
</script>
</body>
</html>"$
End Sub

