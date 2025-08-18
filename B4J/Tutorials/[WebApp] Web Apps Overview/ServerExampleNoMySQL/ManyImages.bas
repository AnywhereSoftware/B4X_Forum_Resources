B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim page As StringBuilder
	page.Initialize
	Dim jo As JavaObject = req
	page.Append($"
	<html>
		<body>
			<script type="text/javascript">
				before = (new Date()).getTime();
				 window.onload = function () 
			    { 
			        var after = (new Date()).getTime();
				    var sec = (after-before)/1000;
				    var p = document.getElementById("total");
				    p.innerHTML = sec + " seconds.";
			    }
			</script>
			<h1>Protocol: ${jo.RunMethod("getProtocol", Null)}, Total Time: <span id="total">...</span></h1>
			<table style="width:100%">
				${CreateRows}
			</table>
		</body>
	</html>
"$)
	resp.ContentType = "text/html"
	resp.Write(page.ToString)
End Sub

Private Sub CreateRows As String
	Dim sb As StringBuilder
	sb.Initialize
	For x = 1 To 10
		sb.Append($"<tr>"$).Append(CRLF)
		For y = 1 To 10
			sb.Append($"<td><img src="/smiley/smiley.png?nocache=${Rnd(1, 99999999)}"/></td>"$)
			sb.Append(CRLF)
		Next
		sb.Append("</tr>")
	Next
	Return sb.ToString
End Sub