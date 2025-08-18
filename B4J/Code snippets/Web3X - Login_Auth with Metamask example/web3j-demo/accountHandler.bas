B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim address As String = req.GetParameter("address")
	
	resp.Write($"<H1>${address}</H1> <p>This is your account!</p>"$)
End Sub