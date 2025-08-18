B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
	
End Sub

Public Sub Initialize

End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "application/json"
	Dim jg As JSONGenerator
	Dim responeMap As Map
	Dim userName As String = req.GetParameter("username").Trim
	Dim password As String = req.GetParameter("password")
	Dim success As Boolean
	success = DB.CheckCredentials(userName, password)
	responeMap.Initialize
	responeMap.Put("success", success)
	If success = False Then
		responeMap.Put("errorMessage", "user name or password do not match")
	End If
	jg.Initialize(responeMap)
	resp.Write(jg.ToString)
	req.GetSession.SetAttribute("registered", success)
	req.GetSession.SetAttribute("name", userName)
	Log("SigningHelper: " & jg.ToString)
End Sub