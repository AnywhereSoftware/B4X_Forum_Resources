B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Class module: LoginHandler
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "text/html"
	' Suponiendo que el archivo login.html está en la carpeta www de tu proyecto
	Try
		resp.Write(File.ReadString(File.DirApp, "www/login.html"))
	Catch
		Log("Error: No se encontró el archivo www/login.html")
		resp.Write("Error: Archivo de login no encontrado.")
	End Try
End Sub