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

	' HTXML sends application/x-www-form-urlencoded Content-Type
	Dim Task As String = req.GetParameter("task")
	Log("Method: "&Method)
	If Method == "POST" Then
		Try
			Main.OpenDB
			Main.db.ExecNonQuery2("INSERT INTO tasks (task) VALUES (?)", Array(Task))
			Main.db.Close
		Catch
			Log(LastException)
		End Try
	End If
	
	resp.Write(Main.GetListTask)
End Sub
