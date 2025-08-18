B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Filter class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

'Return True to allow the request to proceed.
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean
	If req.Secure Or req.FullRequestURI.Contains("basic4ppc.com") Then
		Return True
	Else
		resp.SendRedirect(req.FullRequestURI.Replace("http:", "https:") _
			.Replace(Main.srvr.Port, Main.srvr.SslPort))
		Return False
	End If
End Sub