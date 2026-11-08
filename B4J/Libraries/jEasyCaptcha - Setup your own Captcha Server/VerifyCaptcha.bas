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
	
	Dim verCode As String = req.GetParameter("code")
	Dim sessionCode As String = req.getSession().getAttribute("captcha")
	
	Log("sessionCode=" & sessionCode)
	
	Dim json As String
	
	If (verCode = Null) Or (sessionCode.Contains(verCode) = False) Then
		json = $"{"result":"false"}"$		
	Else
		json = $"{"result":"true"}"$
	End If
	
	Log(json)
End Sub