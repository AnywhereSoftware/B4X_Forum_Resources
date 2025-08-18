B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim FileName As String = req.GetParameter("id")
	FileName = FileName.SubString2(0, FileName.Length-1) 'cut / 
	Dim Folder As String = File.DirApp&"/www/"& ABMShared.AppName &"/images/my"
	If File.Exists(Folder, FileName) Then
		Dim out As InputStream = File.OpenInput(Folder, FileName)
		resp.SetHeader("Content-Type", "application/xxx")
		resp.SetHeader("Content-disposition", "filename=""" & FileName & """") ' "namefile"
		File.Copy2(out, resp.OutputStream)
	Else
		resp.Write("File not found")
	End If
End Sub