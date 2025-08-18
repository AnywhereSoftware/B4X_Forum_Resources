B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private form1 As JQueryElement
	Private Result As JQueryElement
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	form1.RunMethod("ajaxForm", Null)
	ws.Session.SetAttribute("file_upload_sender", Me)
End Sub

Public Sub FileUploaded(parts As Map)
	Dim filePart As Part = parts.Get("file1")
	Result.SetText("File uploaded successfully: " & filePart.SubmittedFilename & _
		" size = " & NumberFormat(File.Size("", filePart.TempFile) / 1000, 0, 0) & "kb")
	Result.SetCSS("color", "black")
	File.Delete("", filePart.TempFile)
	ws.Flush 'this is a server event so we need to explicitly call Flush
End Sub

Public Sub FileError(Message As String)
	Result.SetText("Error uploading file: " & Message)
	Result.SetCSS("color", "red")
	ws.Flush
End Sub

Private Sub WebSocket_Disconnected
	'remote the class instance from the session
	ws.Session.RemoveAttribute("file_upload_sender")
End Sub