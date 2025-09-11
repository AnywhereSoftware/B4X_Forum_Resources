B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Dim j As JSONGenerator
'	Dim rdcc As RDCConnector
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	' 1. --- Bloque de Seguridad ---
	If req.GetSession.GetAttribute2("user_is_authorized", False) = False Then
		resp.SendRedirect("/login")
		Return
	End If

	Dim Command As String = req.GetParameter("command")
	If Command = "" Then Command = "ping"
	Log($"Command: ${Command}"$)
	resp.ContentType = "text/html"
	Dim sb As StringBuilder
	sb.Initialize

	' --- Estilos y JavaScript ---
	sb.Append("<html><head><style>")
	sb.Append("body {font-family: sans-serif; margin: 2em; background-color: #f9f9f9;} ")
	sb.Append("h1, h2 {color: #333;} hr {margin: 2em 0; border: 0; border-top: 1px solid #ddd;} ")
	sb.Append("input {display: block; width: 95%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 4px;} ")
	sb.Append("button {padding: 10px 15px; border: none; background-color: #007bff; color: white; cursor: pointer; border-radius: 4px; margin-right: 1em;} ")
	sb.Append(".nav a, .logout a {text-decoration: none; margin-right: 10px; color: #007bff;} ")
	sb.Append(".output {background: #fff; padding: 1em; border: 1px solid #eee; border-radius: 8px; font-family: monospace; white-space: pre-wrap; word-wrap: break-word;} ")
	sb.Append("#changePassForm {background: #f0f0f0; padding: 1.5em; border-radius: 8px; max-width: 400px; margin-top: 1em;} ")
	sb.Append("</style>")
	sb.Append("<script>function toggleForm() {var form = document.getElementById('changePassForm'); if (form.style.display === 'none') {form.style.display = 'block';} else {form.style.display = 'none';}}</script>")
	sb.Append("</head><body>")

	' --- Cabecera, Botón y Formulario Oculto ---
	sb.Append("<h1>Panel de Administración jRDC</h1>")
	sb.Append($"Bienvenido, <b>${req.GetSession.GetAttribute("username")}</b><br>"$)
	sb.Append("<p class='nav'><a href='/manager?command=test'>Test</a> | <a href='/manager?command=ping'>Ping</a> | <a href='/manager?command=reload'>Reload</a> | <a href='/manager?command=rpm2'>Reiniciar (pm2)</a> | <a href='/manager?command=reviveBow'>Revive Bow</a></p><hr>")
'	sb.Append("<button onclick='toggleForm()'>Cambiar Contraseña</button>")
	sb.Append("<div id='changePassForm' style='display:none;'>")
	sb.Append("<h2>Cambiar Contraseña</h2><form action='/changepass' method='post'>")
	sb.Append("Contraseña Actual: <input type='password' name='current_password' required><br>")
	sb.Append("Nueva Contraseña: <input type='password' name='new_password' required><br>")
	sb.Append("Confirmar Nueva Contraseña: <input type='password' name='confirm_password' required><br>")
	sb.Append("<button type='submit'>Actualizar Contraseña</button> <button onclick='toggleForm()'>Cancelar</button></form></div>")

	' --- Resultado del Comando ---
	sb.Append("<h2>Resultado del Comando: '" & Command & "'</h2>")
	sb.Append("<div class='output'>")

	' =========================================================================
	' ### INICIO DE LÓGICA DE COMANDOS INTEGRADA ###
	' =========================================================================
	If Command = "reload" Then
		Private estaDB As String = ""
		For i = 0 To Main.listaDeCP.Size - 1
			Main.Connectors.Get(Main.listaDeCP.get(i)).As(RDCConnector).Initialize(Main.listaDeCP.get(i))
			If Main.listaDeCP.get(i) <> "DB1" Then estaDB = "." & Main.listaDeCP.get(i) Else estaDB = ""
			sb.Append($"Recargando config${estaDB}.properties ($DateTime{DateTime.Now})<br/>"$)
			sb.Append($"Queries en config.properties: <b>${Main.Connectors.Get(Main.listaDeCP.get(i)).As(RDCConnector).commands.Size}</b><br/>"$)
			sb.Append($"<b>JdbcUrl:</b> ${Main.Connectors.Get(Main.listaDeCP.get(i)).As(RDCConnector).config.Get("JdbcUrl")}</b><br/>"$)
			sb.Append($"<b>User:</b> ${Main.Connectors.Get(Main.listaDeCP.get(i)).As(RDCConnector).config.Get("User")}</b><br/>"$)
			sb.Append($"<b>ServerPort:</b> ${Main.srvr.Port}</b><br/><br/>"$)
		Next
	Else If Command = "test" Then
		Try
			Dim con As SQL = Main.Connectors.Get("DB1").As(RDCConnector).GetConnection("")
			sb.Append("Connection successful.</br></br>")
			Private estaDB As String = ""
			Log(Main.listaDeCP)
			For i = 0 To Main.listaDeCP.Size - 1
				If Main.listaDeCP.get(i) <> "" Then estaDB = "." & Main.listaDeCP.get(i)
				sb.Append($"Using config${estaDB}.properties<br/>"$)
			Next
			con.Close
		Catch
			resp.Write("Error fetching connection.")
		End Try
	Else If Command = "stop" Then
		' Public shl As Shell...
	Else If Command = "rsx" Then
		Log($"Ejecutamos ${File.DirApp}\start.bat"$)
		sb.Append($"Ejecutamos ${File.DirApp}\start.bat"$)
		Public shl As Shell
		shl.Initialize("shl","cmd",Array("/c",File.DirApp & "\start.bat " & Main.srvr.Port))
		shl.WorkingDirectory = File.DirApp
		shl.Run(-1)
	Else If Command = "rpm2" Then
		Log($"Ejecutamos ${File.DirApp}\reiniciaProcesoPM2.bat"$)
		sb.Append($"Ejecutamos ${File.DirApp}\reiniciaProcesoPM2.bat"$)
		Public shl As Shell
		shl.Initialize("shl","cmd",Array("/c",File.DirApp & "\reiniciaProcesoPM2.bat " & Main.srvr.Port))
		shl.WorkingDirectory = File.DirApp
		shl.Run(-1)
	Else If Command = "reviveBow" Then ' Para reiniciar bot de WhatsApp en pm2.
		Log($"Ejecutamos ${File.DirApp}\reiniciaProcesoBow.bat"$)
		sb.Append($"Ejecutamos ${File.DirApp}\reiniciaProcesoBow.bat<br><br>"$)
		sb.Append($"!!!BOW REINICIANDO!!!"$)
		Public shl As Shell
		shl.Initialize("shl","cmd",Array("/c",File.DirApp & "\reiniciaProcesoBow.bat " & Main.srvr.Port))
		shl.WorkingDirectory = File.DirApp
		shl.Run(-1)
	Else If Command = "paused" Then
		GlobalParameters.IsPaused = 1
		sb.Append("Servidor pausado.")
	Else If Command = "continue" Then
		GlobalParameters.IsPaused = 0
		sb.Append("Servidor reanudado.")
	Else If Command = "logs" Then
		If GlobalParameters.mpLogs.IsInitialized Then
			j.Initialize(GlobalParameters.mpLogs)
			sb.Append(j.ToString)
		End If
	Else If Command = "block" Then
		Dim BlockedConIP As String = req.GetParameter("IP")
		If GlobalParameters.mpBlockConnection.IsInitialized Then
			GlobalParameters.mpBlockConnection.Put(BlockedConIP, BlockedConIP)
			sb.Append("IP bloqueada: " & BlockedConIP)
		End If
	Else If Command = "unblock" Then
		Dim UnBlockedConIP As String = req.GetParameter("IP")
		If GlobalParameters.mpBlockConnection.IsInitialized Then
			GlobalParameters.mpBlockConnection.Remove(UnBlockedConIP)
			sb.Append("IP desbloqueada: " & UnBlockedConIP)
		End If
	Else If Command = "restartserver" Then
		Log($"Ejecutamos ${File.DirApp}/restarServer.bat"$)
		sb.Append("Reiniciando servidor...")
	Else If Command = "runatstartup" Then
		File.Copy("C:\jrdcinterface", "startup.bat", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp", "startup.bat")
		sb.Append("Script de inicio añadido.")
	Else If Command = "stoprunatstartup" Then
		File.Delete("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp", "startup.bat")
		sb.Append("Script de inicio eliminado.")
	Else If Command = "totalrequests" Then
		If GlobalParameters.mpTotalRequests.IsInitialized Then
			j.Initialize(GlobalParameters.mpTotalRequests)
			sb.Append(j.ToString)
		End If
	Else If Command = "totalblocked" Then
		If GlobalParameters.mpBlockConnection.IsInitialized Then
'			j.Initialize(Global.mpBlockConnection)
			sb.Append(j.ToString)
		End If
	Else If Command = "totalcon" Then
		If GlobalParameters.mpTotalConnections.IsInitialized Then
			j.Initialize(GlobalParameters.mpTotalConnections)
			sb.Append(j.ToString)
		End If
	Else If Command = "ping" Then
		sb.Append($"Pong ($DateTime{DateTime.Now})"$)
	End If
	' =========================================================================
	' ### FIN DE TU LÓGICA DE COMANDOS ###
	' =========================================================================
    
	' --- Cerramos la página y la enviamos ---
	sb.Append("</div><p class='logout'><a href='/logout'>Cerrar Sesión</a> | <a href=# onclick='toggleForm()'>Cambiar Contraseña</a></p></body></html>")
	resp.Write(sb.ToString)

	If GlobalParameters.mpLogs.IsInitialized Then GlobalParameters.mpLogs.Put(Command, "Manager : " & Command & "  - Time : " & DateTime.Time(DateTime.Now))
End Sub
