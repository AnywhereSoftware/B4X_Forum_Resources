B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Class module: DoLoginHandler
Sub Class_Globals
	Private bc As BCrypt
End Sub

Public Sub Initialize
'	bc.Initialize
End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	' Limpiamos el input del usuario para evitar errores
	Dim u As String = req.GetParameter("username").Trim.ToLowerCase
	Dim p As String = req.GetParameter("password")

	Try
		' Buscamos el hash en la base de datos usando el usuario limpio
		Dim storedHash As String = Main.SQL1.ExecQuerySingleResult2("SELECT password_hash FROM users WHERE username = ?", Array As String(u))

		' Verificamos la contraseña contra el hash
		If storedHash <> Null And bc.checkpw(p, storedHash) Then
			' CREDENCIALES CORRECTAS
			' 1. Autorizamos la sesión
			req.GetSession.SetAttribute("user_is_authorized", True)
			' 2. ¡Y guardamos el nombre de usuario! (Esta es la línea que faltaba)
			req.GetSession.SetAttribute("username", u)
			
			resp.SendRedirect("/manager")
		Else
			' Credenciales incorrectas
			resp.SendRedirect("/login")
		End If
	Catch
		Log(LastException)
		resp.SendRedirect("/login")
	End Try
End Sub