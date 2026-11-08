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
	Log("TEST")
	resp.ContentType = "text/html"
	resp.Write($"<a href="/test">Test</a> | <a href="/manager?command=reload">Reload</a> | <a href="/manager?command=rpm2">Reiniciar</a> |  <a href="/manager?command=reviveBow">Revive Bow</a> | </br></br>"$)
	resp.Write($"RemoteServer is running on port <strong>${Main.srvr.Port}</strong> ($DateTime{DateTime.Now})<br/>"$)
	Try
'		Dim con As SQL = Main.rdcConnectorDB1.GetConnection("")
		Dim con As SQL = Main.Connectors.Get("DB1").As(RDCConnector).GetConnection("")
		resp.Write("Connection successful.</br></br>")
		Private estaDB As String = ""
		Log(Main.listaDeCP)
		For i = 0 To Main.listaDeCP.Size - 1
			If Main.listaDeCP.get(i) <> "" Then estaDB = "." & Main.listaDeCP.get(i)
			resp.Write($"Using config${estaDB}.properties</br>"$)
		Next
		con.Close
	Catch
		resp.Write("Error fetching connection.")
	End Try
End Sub