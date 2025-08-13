B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim root As Map = Main.htmx_middleware(req)
	root.Put("user", GetSystemProperty("user.name", "Just a ghost"))
	
	Main.answer(resp, "/landingpage.html", root)
	
	
End Sub
