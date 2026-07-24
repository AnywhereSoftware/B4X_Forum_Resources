B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim code As String = req.GetParameter("code")
	SendAndWait(code, resp)
	StartMessageLoop
End Sub

Private Sub SendAndWait (code As String, resp As ServletResponse)
	CallSubDelayed3(Main.PyWorker, "Run_Eval", Me, code)
	Wait For Run_Eval (Result As PyWrapper)
	resp.ContentType = "text/html"
	resp.Write("Code: " & code)
	resp.Write("<br/>")
	If Result.IsSuccess Then
		resp.Write("Success: " & Result.Value)
	Else
		resp.Write("Error: " & Result.ErrorMessage)
	End If
	StopMessageLoop
End Sub