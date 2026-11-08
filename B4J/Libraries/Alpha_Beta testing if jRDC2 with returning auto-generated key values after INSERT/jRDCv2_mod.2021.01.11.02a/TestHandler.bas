B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
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
		'Below needed changing for SQLite to work. Do not close any connections when using
		' SQLite. SQLite implementation does not use a pool.
		If con <> Null And con.IsInitialized And Main.rdcConnector1.UsePool Then con.Close
	Catch
		resp.Write("Error fetching connection.")
	End Try
End Sub