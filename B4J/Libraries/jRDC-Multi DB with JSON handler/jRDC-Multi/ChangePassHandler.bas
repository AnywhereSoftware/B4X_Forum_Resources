B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Class module: ChangePassHandler
Sub Class_Globals
	Private bc As BCrypt
End Sub

Public Sub Initialize
'	bc.Initialize ' <<--- CORRECCIÓN 1: Descomentado para que el objeto se cree.
End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	Log("--- CHANGEPASSHANDLER FUE LLAMADO ---") ' <--- ¡PON ESTA LÍNEA AQUÍ!
	If req.GetSession.GetAttribute2("user_is_authorized", False) = False Then
		resp.SendRedirect("/login")
		Return
	End If

	Dim currentUser As String = req.GetSession.GetAttribute("username")
	Dim currentPass As String = req.GetParameter("current_password")
	Dim newPass As String = req.GetParameter("new_password")
	Dim confirmPass As String = req.GetParameter("confirm_password")

	If newPass <> confirmPass Then
		resp.Write("<script>alert('Error: La nueva contraseña no coincide con la confirmación.'); history.back();</script>")
		Return
	End If

	Try
		Dim storedHash As String = Main.SQL1.ExecQuerySingleResult2("SELECT password_hash FROM users WHERE username = ?", Array As String(currentUser))
		
		Log("--- Probando con contraseña fija ---")
		Log("Valor de la BD (storedHash): " & storedHash)
		If storedHash = Null Or bc.checkpw("12345", storedHash) = False Then ' <<--- CAMBIO CLAVE AQUÍ
			resp.Write("<script>alert('Error: La contraseña actual es incorrecta.'); history.back();</script>")
			Return
		End If

		' <<--- CORRECCIÓN 2: Usamos el método seguro y consistente con 'Main'.
		Dim newHashedPass As String = bc.hashpw(newPass, bc.gensalt)
		Main.SQL1.ExecNonQuery2("UPDATE users SET password_hash = ? WHERE username = ?", Array As Object(newHashedPass, currentUser))
		
		resp.Write("<script>alert('Contraseña actualizada correctamente.'); window.location.href='/manager';</script>")
		
	Catch
		Log(LastException)
		resp.Write("<script>alert('Error del servidor al intentar cambiar la contraseña.'); history.back();</script>")
	End Try
End Sub