Type=Class
Version=1.06
B4J=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mreq As ServletRequest 'ignore
	Private mresp As ServletResponse 'ignore
End Sub

Public Sub Initialize

End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	mreq = req
	mresp = resp
	resp.ContentType = "text/html"
	resp.Write("<p>Thank you ").Write(req.GetParameter("firstname")).Write("!").Write("<br/>")
	resp.Write("The following parameters were sent:<br/>").Write(Main.PrintAllParameters(req))
	resp.Write("<a href='/'>Back</a>")
	Log(Main.PrintAllParameters(req))
	If req.GetParameter("ajax") = True Then
		If Regex.IsMatch(".+@.+\..+", req.GetParameter("email")) = False Then
			resp.SendError(500, "Invalid email address.")
		End If
	End If
	
End Sub

