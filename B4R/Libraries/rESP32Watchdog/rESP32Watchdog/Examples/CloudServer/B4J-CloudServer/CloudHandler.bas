B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'File:	CloudHandler
'Class:	CloudHandler
Sub Class_Globals
	'No globals.
End Sub

'Initializes the object.
'NO parameter.
Public Sub Initialize
	End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	Log($"[CloudHandler Handle] Received request from: ${req.RemoteAddress}"$)
	
	' Get the url paremeter from ip:port/cloud?msg=TEXT
	Dim msg As String = req.GetParameter("msg")
	Log($"[CloudHandler Handle] msg=${msg}"$)
    
	' Optional: respond with something
	Dim response As String = $"HelloFromB4J@${DateTime.Time(DateTime.Now)}"$
	Log($"[CloudHandler Handle] Response: ${response}"$)
	resp.Write($"Response: ${response}"$)
End Sub
