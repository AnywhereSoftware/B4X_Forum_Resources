B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	If req.Method = "POST" Then
		Main.syncData1.data = Bit.InputStreamToBytes(req.InputStream)
		Main.syncData1.dataVersion = Main.syncData1.dataVersion + 1
	Else
		resp.OutputStream.WriteBytes(Main.syncData1.data, 0, Main.syncData1.data.Length)
	End If
End Sub