B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "text/html"
	resp.Write($"RemoteServer is running ($DateTime{DateTime.Now})<br/>"$)
	Try
		Dim con As SQL = Main.rdcConnector1.GetConnection
		resp.Write("Connection successful.")
		con.Close
	Catch
		resp.Write("Error fetching connection.")
	End Try
End Sub