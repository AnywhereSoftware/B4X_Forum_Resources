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
	Dim Method As String = req.Method
	Log("Method: "&Method)
	If Method == "GET" Then
		resp.Write(Main.GetListTask)
	End If
End Sub