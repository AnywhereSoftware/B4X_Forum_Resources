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
	If req.Method = "GET" Then
		Main.answer(resp, "/contactus.html", root)
	Else
		Dim client As String = req.GetParameter("name")
		root.Put("client", client)
		Main.answer(resp, "/contactus_answer.html", root)
	End If
End Sub