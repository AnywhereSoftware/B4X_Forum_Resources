B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=1.06
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private Request As ServletRequest
	Private Response As ServletResponse
End Sub

Public Sub Initialize

End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	
	ShowDynamicPage
End Sub

Sub ShowDynamicPage
	Dim start As Long = DateTime.Now
	Response.ContentType = "text/html"
	Response.Write($"<center style="font-family: Arial">"$)
	Response.Write($"<link rel="stylesheet" type="text/css" href="/css/styles.css">"$)
	Response.Write($"<a href="/hello/world" title="Back"><img src='../images/logo.png' width=100 height=100></a><br>"$)
	Response.Write("<small>Click the image above to go back</small>")
	Response.Write($"<h3 class="blue">This page was generated<br/>dynamically</h3>"$)
	Response.Write("Your ip address is: " & Request.RemoteAddress & "<br/>")
	Response.Write("The time here is: " & DateTime.Time(DateTime.Now)).Write("<br/>")
	Response.Write("It took: ").Write(DateTime.Now - start).Write(" ms to create this page.<br><br>")
	Response.Write($"<a href="/dynamic" title="Reload">Refresh</a>"$)
	Response.Write("</center>")
End Sub