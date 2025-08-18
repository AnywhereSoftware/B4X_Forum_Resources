B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	
	Dim Session As String = req.GetSession.Id
	
	Dim SessionCount As String = Main.DB.ExecQuerySingleResult("select count(*) from Session")
	
	resp.Write(SessionCount)
	
End Sub