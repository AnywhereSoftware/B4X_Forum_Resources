B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Dim captcha As jEasyCaptcha
End Sub

Public Sub Initialize
	captcha.Initialize(320,90, 5) 
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "image/gif"
	resp.setHeader("Pragma", "No-cache")
	resp.setHeader("Cache-Control", "no-cache")
	
	req.GetSession.SetAttribute("captcha",captcha.toString)
	captcha.setFont("Elephant", 18)
	captcha.WriteOut(resp.OutputStream)
	
End Sub