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
	Dim start As Long = DateTime.Now
	resp.ContentType = "text/html"
	resp.Write("<img src='images/logo.png'/ width=100 height=100><br/>") 'this file will be loaded from the www folder
	resp.Write("<b>Hello world!!!</b><br/>")
	resp.Write("Your ip address is: " & req.RemoteAddress & "<br/>")	
	resp.Write("The time here is: " & DateTime.Time(DateTime.Now)).Write("<br/>")
	resp.Write("It took: ").Write(DateTime.Now - start).Write(" ms to create this page.<br/>")
	resp.Write("<a href='/'>Back</a>")
End Sub