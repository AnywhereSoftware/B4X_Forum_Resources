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
	resp.Write("Shutting down...")
	'https://www.b4x.com/android/forum/threads/additional-jserver-web-server-setting-snippets.72625/#post-461796
	'Dim jo As JavaObject = Main.srvr
	'jo.GetFieldJO("server").RunMethod("stop", Null)
	Log("About to call Main.Shutdown")
	CallSub(Main,"Shutdown")
End Sub