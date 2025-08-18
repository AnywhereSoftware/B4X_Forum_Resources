B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "text/html"
	resp.Write($"RemoteServer is running ($DateTime{DateTime.Now})<br/>"$)
	resp.Write("Restarting server...")
	CallSub(Main,"Restart")
End Sub