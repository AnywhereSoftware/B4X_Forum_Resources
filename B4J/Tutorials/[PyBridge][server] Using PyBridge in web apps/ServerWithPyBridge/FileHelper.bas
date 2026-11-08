B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Handler class
Sub Class_Globals
 
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	'get the callback module from the session (multiple modules can use this handler)
	Dim callback As Object = req.GetSession.GetAttribute("file_upload_sender")
	Try
		Dim data As Map = req.GetMultipartData(File.DirTemp, 5 * 1024 * 1024)
		CallSubDelayed2(callback, "FileUploaded", data)
	Catch
		CallSubDelayed2(callback, "FileError", LastException.Message)
		resp.SendError(500, LastException.Message)
	End Try
End Sub