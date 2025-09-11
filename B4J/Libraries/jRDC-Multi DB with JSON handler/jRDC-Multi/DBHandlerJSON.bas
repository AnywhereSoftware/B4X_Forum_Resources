B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Handler class for JSON requests from Web Clients (JavaScript/axios)
Sub Class_Globals
	' Declara una variable privada para mantener una instancia del conector RDC.
	' Este objeto maneja la comunicación con la base de datos.
	Private Connector As RDCConnector
End Sub

' Subrutina de inicialización de la clase. Se llama cuando se crea un objeto de esta clase.
' En este caso, no se necesita ninguna inicialización específica.
Public Sub Initialize

End Sub

' Este es el método principal que maneja las peticiones HTTP entrantes (req) y prepara la respuesta (resp).
Sub Handle(req As ServletRequest, resp As ServletResponse)
	Log("============== DB1JsonHandler ==============")
	' --- Headers CORS (Cross-Origin Resource Sharing) ---
	' Estos encabezados son necesarios para permitir que un cliente web (ej. una página con JavaScript)
	' que se encuentra en un dominio diferente pueda hacer peticiones a este servidor.
	resp.SetHeader("Access-Control-Allow-Origin", "*") ' Permite peticiones desde cualquier origen.
	resp.SetHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS") ' Métodos HTTP permitidos.
	resp.SetHeader("Access-Control-Allow-Headers", "Content-Type") ' Encabezados permitidos en la petición.

	' El método OPTIONS es una "petición de comprobación previa" (preflight request) que envían los navegadores
	' para verificar los permisos CORS antes de enviar la petición real (ej. POST).
	' Si es una petición OPTIONS, simplemente terminamos la ejecución sin procesar nada más.
	If req.Method = "OPTIONS" Then Return

	' Establece "DB1" como el nombre de la base de datos por defecto.
	Dim DB As String = "DB1"
	' Obtiene el objeto conector para la base de datos por defecto desde el objeto Main.
	Connector = Main.Connectors.Get(DB)
	' Declara una variable para la conexión SQL.
	Dim con As SQL

	' Inicia un bloque Try...Catch para manejar posibles errores durante la ejecución.
	Try
		' Obtiene el valor del parámetro 'j' de la petición. Se espera que contenga una cadena JSON.
		Dim jsonString As String = req.GetParameter("j")
		' Verifica si el parámetro 'j' es nulo o está vacío.
		If jsonString = Null Or jsonString = "" Then
			' Si falta el parámetro, envía una respuesta de error 400 (Bad Request) y termina la ejecución.
			SendErrorResponse(resp, 400, "Falta el parametro 'j' en el URL")
			Return
		End If

		' Crea un objeto JSONParser para analizar la cadena JSON.
		Dim parser As JSONParser
		parser.Initialize(jsonString)
		' Convierte la cadena JSON en un objeto Map, que es como un diccionario (clave-valor).
		Dim RootMap As Map = parser.NextObject

		' Extrae los datos necesarios del JSON.
		Dim execType As String = RootMap.GetDefault("exec", "") ' Tipo de ejecución: "executeQuery" o "executeCommand".
		Dim queryName As String = RootMap.Get("query")          ' Nombre del comando SQL (definido en config.properties).

		' Se obtiene "params" como una Lista en lugar de un Mapa.
		Dim paramsList As List = RootMap.Get("params")

		' Si la lista de parámetros es nula (no se proporcionó en el JSON),
		' la inicializamos como una lista vacía para evitar errores más adelante.
		If paramsList = Null Or paramsList.IsInitialized = False Then
			paramsList.Initialize
		End If

		' Verifica si en el JSON se especificó un nombre de base de datos diferente con la clave "dbx".
		If RootMap.Get("dbx") <> Null Then DB = RootMap.Get("dbx") ' Si se especifica, usamos la BD indicada, si no, se queda "DB1".

		' Valida que el nombre de la base de datos (DB) exista en la lista de conexiones configuradas en Main.
		If Main.listaDeCP.IndexOf(DB) = -1 Then
			SendErrorResponse(resp, 400, "Parametro 'DB' invalido. El nombre '" & DB & "' no es válido.")
			' Se añade Return para detener la ejecución si la BD no es válida.
			Return
		End If

		' Obtiene una conexión a la base de datos del pool de conexiones.
		con = Connector.GetConnection(DB)
		' Obtiene la cadena SQL del archivo de configuración usando el nombre de la consulta (queryName).
		Dim sqlCommand As String = Connector.GetCommand(DB, queryName)

		' <<< INICIO VALIDACIÓN: VERIFICAR SI EL COMANDO EXISTE >>>
		' Comprueba si el comando SQL (query) especificado en el JSON fue encontrado en el archivo de configuración.
		If sqlCommand = Null Or sqlCommand = "null" Or sqlCommand.Trim = "" Then
			' Si no se encontró el comando, crea un mensaje de error claro.
			Dim errorMessage As String = $"El comando '${queryName}' no fue encontrado en el config.properties de '${DB}'."$
			' Registra el error en el log del servidor para depuración.
			Log(errorMessage)
			' Envía una respuesta de error 400 (Bad Request) al cliente en formato JSON.
			SendErrorResponse(resp, 400, errorMessage)
			' Cierra la conexión a la base de datos antes de salir para evitar fugas de conexión.
			If con <> Null And con.IsInitialized Then con.Close
			' Detiene la ejecución del método Handle para esta petición.
			Return
		End If
		' <<< FIN VALIDACIÓN >>>

		' Comprueba el tipo de ejecución solicitado ("executeQuery" o "executeCommand").
		If execType.ToLowerCase = "executequery" Then
			' Declara una variable para almacenar el resultado de la consulta.
			Dim rs As ResultSet

			' Si el comando SQL contiene placeholders ('?'), significa que espera parámetros.
			' Se usa 'paramsList' directamente en lugar de 'orderedParams'.
			If sqlCommand.Contains("?") Or paramsList.Size > 0 Then
				' =================================================================
				' === VALIDACIÓN DE CONTEO DE PARÁMETROS ==========================
				' =================================================================
				' Calcula cuántos parámetros espera la consulta contando el número de '?'.
				Dim expectedParams As Int = sqlCommand.Length - sqlCommand.Replace("?", "").Length
				' Obtiene cuántos parámetros se recibieron de la lista.
				Dim receivedParams As Int = paramsList.Size
				
				Log($"expectedParams: ${expectedParams}, receivedParams: ${receivedParams}"$)
				
				If expectedParams <> receivedParams Then
					' Si no coinciden, envía un error 400 detallado.
					SendErrorResponse(resp, 400, $"Número de parametros equivocado para '${queryName}'. Se esperaban  ${expectedParams} y se recibieron ${receivedParams}."$)
					' Cierra la conexión antes de salir para evitar fugas.
					If con <> Null And con.IsInitialized Then con.Close
					' Detiene la ejecución para evitar un error en la base de datos.
					Return
				End If
				' =================================================================
				' Ejecuta la consulta pasando el comando SQL y la lista de parámetros.
				rs = con.ExecQuery2(sqlCommand, paramsList)
			Else
				' Si no hay '?', ejecuta la consulta directamente sin parámetros.
				rs = con.ExecQuery(sqlCommand)
			End If

			' --- Procesamiento de resultados ---
			' Prepara una lista para almacenar todas las filas del resultado.
			Dim ResultList As List
			ResultList.Initialize
			' Usa un objeto JavaObject para acceder a los metadatos del resultado (info de columnas).
			Dim jrs As JavaObject = rs
			Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
			' Obtiene el número de columnas en el resultado.
			Dim cols As Int = rsmd.RunMethod("getColumnCount", Null)

			' Itera sobre cada fila del resultado (ResultSet).
			Do While rs.NextRow
				' Crea un mapa para almacenar los datos de la fila actual (columna -> valor).
				Dim RowMap As Map
				RowMap.Initialize
				' Itera sobre cada columna de la fila.
				For i = 1 To cols
					' Obtiene el nombre de la columna.
					Dim ColumnName As String = rsmd.RunMethod("getColumnName", Array(i))
					' Obtiene el valor de la columna.
					Dim value As Object = jrs.RunMethod("getObject", Array(i))
					' Añade la pareja (nombre_columna, valor) al mapa de la fila.
					RowMap.Put(ColumnName, value)
				Next
				' Añade el mapa de la fila a la lista de resultados.
				ResultList.Add(RowMap)
			Loop
			' Cierra el ResultSet para liberar recursos de la base de datos.
			rs.Close

			' Envía una respuesta de éxito con la lista de resultados en formato JSON.
			SendSuccessResponse(resp, CreateMap("result": ResultList))

		Else If execType.ToLowerCase = "executecommand" Then
			' Si es un comando (INSERT, UPDATE, DELETE), también valida los parámetros.
			If sqlCommand.Contains("?") Then
				' =================================================================
				' === VALIDACIÓN DE CONTEO DE PARÁMETROS (para Comandos) ==========
				' =================================================================
				Dim expectedParams As Int = sqlCommand.Length - sqlCommand.Replace("?", "").Length
				Dim receivedParams As Int = paramsList.Size
				If expectedParams <> receivedParams Then
					SendErrorResponse(resp, 400, $"Número de parametros equivocado para '${queryName}'. Se esperaban  ${expectedParams} y se recibieron ${receivedParams}."$)
					' Cierra la conexión antes de salir.
					If con <> Null And con.IsInitialized Then con.Close
					' Detiene la ejecución.
					Return
				End If
				' =================================================================
			End If

			' Ejecuta el comando que no devuelve resultados (NonQuery) con sus parámetros.
			con.ExecNonQuery2(sqlCommand, paramsList)
			' Envía una respuesta de éxito con un mensaje de confirmación.
			SendSuccessResponse(resp, CreateMap("message": "Command executed successfully"))

		Else
			' Si el valor de 'exec' no es ni "executeQuery" ni "executeCommand", envía un error.
			SendErrorResponse(resp, 400, "Parametro  'exec' inválido. '" & execType & "' no es un valor permitido.")
		End If

	Catch
		' Si ocurre cualquier error inesperado en el bloque Try...
		' Registra la excepción completa en el log del servidor para diagnóstico.
		Log(LastException)
		' Envía una respuesta de error 500 (Internal Server Error) con el mensaje de la excepción.
		SendErrorResponse(resp, 500, LastException.Message)
	End Try
    
	' Este bloque se ejecuta siempre al final, haya habido error o no, *excepto si se usó Return antes*.
	' Comprueba si el objeto de conexión fue inicializado y sigue abierto.
	If con <> Null And con.IsInitialized Then
		' Cierra la conexión para devolverla al pool y que pueda ser reutilizada.
		' Esto es fundamental para no agotar las conexiones a la base de datos.
		con.Close
	End If
End Sub


' --- Subrutinas de ayuda para respuestas JSON ---

' Construye y envía una respuesta JSON de éxito.
Private Sub SendSuccessResponse(resp As ServletResponse, dataMap As Map)
	' Añade el campo "success": true al mapa de datos para indicar que todo salió bien.
	dataMap.Put("success", True)
	' Crea un generador de JSON.
	Dim jsonGenerator As JSONGenerator
	jsonGenerator.Initialize(dataMap)
	' Establece el tipo de contenido de la respuesta a "application/json".
	resp.ContentType = "application/json"
	' Escribe la cadena JSON generada en el cuerpo de la respuesta HTTP.
	resp.Write(jsonGenerator.ToString)
End Sub

' Construye y envía una respuesta JSON de error.
Private Sub SendErrorResponse(resp As ServletResponse, statusCode As Int, errorMessage As String)
	' Personaliza el mensaje de error si es un error común de parámetros de Oracle o JDBC.
	If errorMessage.Contains("Índice de columnas no válido") Or errorMessage.Contains("ORA-17003") Then errorMessage = "NUMERO DE PARAMETROS EQUIVOCADO: " & errorMessage
	' Crea un mapa con el estado de error y el mensaje.
	Dim resMap As Map = CreateMap("success": False, "error": errorMessage)
	' Genera la cadena JSON a partir del mapa.
	Dim jsonGenerator As JSONGenerator
	jsonGenerator.Initialize(resMap)
	' Establece el código de estado HTTP (ej. 400 para error del cliente, 500 para error del servidor).
	resp.Status = statusCode
	' Establece el tipo de contenido y escribe la respuesta de error.
	resp.ContentType = "application/json"
	resp.Write(jsonGenerator.ToString)
End Sub
