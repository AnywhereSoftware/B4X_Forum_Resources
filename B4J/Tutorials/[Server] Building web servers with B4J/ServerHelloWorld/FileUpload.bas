Type=Class
Version=1.06
B4J=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mreq As ServletRequest 'ignore
	Private mresp As ServletResponse 'ignore
End Sub

Public Sub Initialize

End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Try
		mreq = req
		mresp = resp
		If req.ContentType.StartsWith("multipart/form-data") Then
			'parse the multipart data
			Dim parts As Map = req.GetMultipartData(File.DirApp & "/www", 10000000)
			For i = 0 To parts.Size - 1
				Dim name As String = parts.GetKeyAt(i)
				Dim p As Part = parts.GetValueAt(i)
				Log("Name: " & name)
				If p.IsFile Then
					Log(p.TempFile & ": " & File.Size("", p.TempFile))
					Log(p.SubmittedFilename)
				Else
					Log(p.GetValue(req.CharacterEncoding))
				End If
			Next
		End If
		resp.Write("Form data was printed in the logs.")
	Catch
		resp.SendError(500, LastException)
	End Try
End Sub