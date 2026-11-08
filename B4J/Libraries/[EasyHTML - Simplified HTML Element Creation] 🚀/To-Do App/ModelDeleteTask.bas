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
	Dim Id As String = req.GetParameter("id")
	Log("Method: "&Method)
	Log("[ID Task] "&Id)
	If Method == "POST" Then
		Try
			Main.OpenDB
			Main.db.ExecNonQuery2("DELETE FROM tasks WHERE id = ?", Array(Id))
			Main.db.Close
		Catch
			Log(LastException)
		End Try
		
	End If
	
	resp.Write(Main.GetListTask)
End Sub