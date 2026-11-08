B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Filter class
Sub Class_Globals
	Dim jspconvert As JSPsupport
End Sub

Public Sub Initialize
	jspconvert.Initialize
End Sub

'Return True to allow the request to proceed.
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean
	Dim pathjsp As String = File.Combine(File.DirApp & "/www/jsp","home.jsp")
	jspconvert.webExchange(req, resp, pathjsp)
	Log("HERE")
End Sub