B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Class module: LogoutHandler
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	req.GetSession.Invalidate ' Cierra la sesión
	resp.SendRedirect("/login") ' Manda al usuario a la página de login
End Sub