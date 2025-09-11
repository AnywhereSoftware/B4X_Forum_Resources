B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Handler genérico para peticiones desde clientes B4A/B4i (DBRequestManager)
' Determina la base de datos a utilizar dinámicamente a partir de la URL de la petición.
' Versión con validación de parámetros y errores en texto plano.
Sub Class_Globals
	' Estas constantes y variables solo se compilan si se usa la #if VERSION1,
	' lo que sugiere que es para dar soporte a una versión antigua del protocolo de comunicación.
'	#if VERSION1
	' Constantes para identificar los tipos de datos en la serialización personalizada (protocolo V1).
	Private const T_NULL = 0, T_STRING = 1, T_SHORT = 2, T_INT = 3, T_LONG = 4, T_FLOAT = 5 _
		,T_DOUBLE = 6, T_BOOLEAN = 7, T_BLOB = 8 As Byte
	' Utilidades para convertir entre tipos de datos y arrays de bytes.
	Private bc As ByteConverter
	' Utilidad para comprimir/descomprimir streams de datos (usado en V1).
	Private cs As CompressedStreams
'	#end if

	' Mapa para convertir tipos de columna JDBC de fecha/hora a métodos de obtención de datos.
	Private DateTimeMethods As Map
	' Objeto que gestiona las conexiones a las diferentes bases de datos definidas en config.properties.
	Private Connector As RDCConnector
End Sub

' Se ejecuta una vez cuando se crea una instancia de esta clase.
Public Sub Initialize
	' Inicializa el mapa que asocia los códigos de tipo de columna de fecha/hora de JDBC
	' con los nombres de los métodos correspondientes para leerlos correctamente.
	DateTimeMethods = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
End Sub

' Método principal que maneja cada petición HTTP que llega a este servlet.
Sub Handle(req As ServletRequest, resp As ServletResponse)
	' === INICIO DE LA LÓGICA DINÁMICA ===
	' Extrae la URI completa de la petición (ej. /DB1/endpoint).
	Dim URI As String = req.RequestURI
	' Variable para almacenar la "llave" o identificador de la base de datos (ej. "DB1").
	Dim dbKey As String

	' Comprueba si la URI tiene contenido y empieza con "/".
	If URI.Length > 1 And URI.StartsWith("/") Then
		' Extrae la parte de la URI que viene después del primer "/".
		dbKey = URI.Substring(1)
		' Si la llave contiene más "/", se queda solo con la primera parte.
		' Esto permite URLs como /DB1/clientes o /DB2/productos, extrayendo "DB1" o "DB2".
		If dbKey.Contains("/") Then
			dbKey = dbKey.SubString2(0, dbKey.IndexOf("/"))
		End If
	Else
		' Si la URI está vacía o es "/", usa "DB1" como la base de datos por defecto.
		dbKey = "DB1"
	End If

	' Convierte la llave a mayúsculas para que no sea sensible a mayúsculas/minúsculas (ej. "db1" se convierte en "DB1").
	dbKey = dbKey.ToUpperCase

	' Verifica si la llave de la base de datos extraída existe en la configuración de conectores.
	If Main.Connectors.ContainsKey(dbKey) = False Then
		' Si no existe, crea un mensaje de error claro.
		Dim ErrorMsg As String = $"Invalid DB key specified in URL: '${dbKey}'. Valid keys are: ${Main.listaDeCP}"$
		' Registra el error en el log del servidor.
		Log(ErrorMsg)
		' Envía una respuesta de error 400 (Bad Request) al cliente en formato de texto plano.
		SendPlainTextError(resp, 400, ErrorMsg)
		' Termina la ejecución de este método.
		Return
	End If
	' === FIN DE LA LÓGICA DINÁMICA ===

	Log("********************* " & dbKey & "  ********************")
	' Guarda el tiempo de inicio para medir la duración de la petición.
	Dim start As Long = DateTime.Now
	' Variable para almacenar el nombre del comando SQL a ejecutar.
	Dim q As String
	' Obtiene el stream de entrada de la petición, que contiene los datos enviados por el cliente.
	Dim in As InputStream = req.InputStream
	' Obtiene el parámetro "method" de la URL (ej. ?method=query2).
	Dim method As String = req.GetParameter("method")
	' Obtiene el conector correspondiente a la base de datos seleccionada.
	Connector = Main.Connectors.Get(dbKey)
	' Declara la variable para la conexión a la base de datos.
	Dim con As SQL
	Try
		' Obtiene una conexión del pool de conexiones.
		con = Connector.GetConnection(dbKey)
		Log("Metodo: " & method)
		' Determina qué función ejecutar basándose en el parámetro "method".
		If method = "query2" Then
			' Ejecuta una consulta usando el protocolo más nuevo (B4XSerializator).
			q = ExecuteQuery2(dbKey, con, in, resp)
			'#if VERSION1
		Else if method = "query" Then
			' Protocolo antiguo: descomprime el stream y ejecuta la consulta.
			in = cs.WrapInputStream(in, "gzip")
			q = ExecuteQuery(dbKey, con, in, resp)
		Else if method = "batch" Then
			' Protocolo antiguo: descomprime el stream y ejecuta un lote de comandos.
			in = cs.WrapInputStream(in, "gzip")
			q = ExecuteBatch(dbKey, con, in, resp)
			'#end if
		Else if method = "batch2" Then
			' Ejecuta un lote de comandos usando el protocolo más nuevo.
			q = ExecuteBatch2(dbKey, con, in, resp)
		Else
			' Si el método es desconocido, lo registra y envía un error.
			Log("Unknown method: " & method)
			SendPlainTextError(resp, 500, "unknown method")
		End If
	Catch
		' Si ocurre cualquier error en el bloque Try, lo captura.
		Log(LastException)
		' Envía un error 500 (Internal Server Error) al cliente con el mensaje de la excepción.
		SendPlainTextError(resp, 500, LastException.Message)
	End Try
	' Asegura que la conexión a la BD se cierre y se devuelva al pool.
	If con <> Null And con.IsInitialized Then con.Close
	' Registra en el log el comando ejecutado, cuánto tiempo tardó y la IP del cliente.
	Log($"Command: ${q}, took: ${DateTime.Now - start}ms, client=${req.RemoteAddress}"$)
End Sub

' Ejecuta una consulta única usando el protocolo V2 (B4XSerializator).
Private Sub ExecuteQuery2 (DB As String, con As SQL, in As InputStream,  resp As ServletResponse) As String
	' Objeto para deserializar los datos enviados desde el cliente.
	Dim ser As B4XSerializator
	' Convierte el stream de entrada a un array de bytes y luego a un objeto Mapa.
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	' Extrae el objeto DBCommand del mapa.
	Dim cmd As DBCommand = m.Get("command")
	' Extrae el límite de filas a devolver.
	Dim limit As Int = m.Get("limit")

	' Obtiene la sentencia SQL correspondiente al nombre del comando desde config.properties.
	Dim sqlCommand As String = Connector.GetCommand(DB, cmd.Name)

	' <<< INICIO NUEVA VALIDACIÓN: VERIFICAR SI EL COMANDO EXISTE >>>
	' Comprueba si el comando no fue encontrado en el archivo de configuración.
	If sqlCommand = Null Or sqlCommand = "null" Or sqlCommand.Trim = "" Then
		Dim errorMessage As String = $"El comando '${cmd.Name}' no fue encontrado en el config.properties de '${DB}'."$
		Log(errorMessage)
		' Envía un error 400 (Bad Request) al cliente informando del problema.
		SendPlainTextError(resp, 400, errorMessage)
		Return "error" ' Retorna un texto para el log.
	End If
	' <<< FIN NUEVA VALIDACIÓN >>>

	' --- INICIO VALIDACIÓN DE PARÁMETROS ---
	' Comprueba si el SQL espera parámetros o si se recibieron parámetros.
	If sqlCommand.Contains("?") Or (cmd.Parameters <> Null And cmd.Parameters.Length > 0) Then
		' Cuenta cuántos '?' hay en la sentencia SQL para saber cuántos parámetros se esperan.
		Dim expectedParams As Int = sqlCommand.Length - sqlCommand.Replace("?", "").Length
		' Cuenta cuántos parámetros se recibieron.
		Dim receivedParams As Int
		If cmd.Parameters = Null Then receivedParams = 0 Else receivedParams = cmd.Parameters.Length
		
		' Compara el número de parámetros esperados con los recibidos.
		If expectedParams <> receivedParams Then
			Dim errorMessage As String = $"Número de parametros equivocado para "${cmd.Name}". Se esperaban ${expectedParams} y se recibieron ${receivedParams}."$
			Log(errorMessage)
			' Si no coinciden, envía un error 400 al cliente.
			SendPlainTextError(resp, 400, errorMessage)
			Return "error"
		End If
	End If
	' --- FIN VALIDACIÓN ---

	' Ejecuta la consulta SQL con los parámetros proporcionados.
	Dim rs As ResultSet = con.ExecQuery2(sqlCommand, cmd.Parameters)
	' Si el límite es 0 o negativo, lo establece a un valor muy alto (máximo entero).
	If limit <= 0 Then limit = 0x7fffffff 'max int
	' Obtiene el objeto Java subyacente del ResultSet para acceder a métodos adicionales.
	Dim jrs As JavaObject = rs
	' Obtiene los metadatos del ResultSet (información sobre las columnas).
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	' Obtiene el número de columnas del resultado.
	Dim cols As Int = rs.ColumnCount
	' Crea un objeto DBResult para empaquetar la respuesta.
	Dim res As DBResult
	res.Initialize
	res.columns.Initialize
	res.Tag = Null
	' Llena el mapa de columnas con el nombre de cada columna y su índice.
	For i = 0 To cols - 1
		res.columns.Put(rs.GetColumnName(i), i)
	Next
	' Inicializa la lista de filas.
	res.Rows.Initialize
	' Itera sobre cada fila del ResultSet, hasta llegar al límite.
	Do While rs.NextRow And limit > 0
		Dim row(cols) As Object
		' Itera sobre cada columna de la fila actual.
		For i = 0 To cols - 1
			' Obtiene el tipo de dato de la columna según JDBC.
			Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
			' Maneja diferentes tipos de datos para leerlos de la forma correcta.
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then ' Tipos BLOB/binarios
				row(i) = rs.GetBlob2(i)
			Else If ct = 2005 Then ' Tipo CLOB (texto largo)
				row(i) = rs.GetString2(i)
			Else if ct = 2 Or ct = 3 Then ' Tipos numéricos que pueden tener decimales
				row(i) = rs.GetDouble2(i)
			Else If DateTimeMethods.ContainsKey(ct) Then ' Tipos de Fecha/Hora
				' Obtiene el objeto de tiempo/fecha de Java.
				Dim SQLTime As JavaObject = jrs.RunMethodJO(DateTimeMethods.Get(ct), Array(i + 1))
				If SQLTime.IsInitialized Then
					' Lo convierte a milisegundos (Long) para B4X.
					row(i) = SQLTime.RunMethod("getTime", Null)
				Else
					row(i) = Null
				End If
			Else ' Para todos los demás tipos de datos
				' Usa getObject que funciona para la mayoría de los tipos estándar.
				row(i) = jrs.RunMethod("getObject", Array(i + 1))
			End If
		Next
		' Añade la fila completa a la lista de resultados.
		res.Rows.Add(row)
		limit = limit - 1
	Loop
	' Cierra el ResultSet para liberar recursos.
	rs.Close
	' Serializa el objeto DBResult completo a un array de bytes.
	Dim data() As Byte = ser.ConvertObjectToBytes(res)
	' Escribe los datos serializados en el stream de respuesta.
	resp.OutputStream.WriteBytes(data, 0, data.Length)
	' Devuelve el nombre del comando para el log.
	Return "query: " & cmd.Name
End Sub

' Ejecuta un lote de comandos (INSERT, UPDATE, DELETE) usando el protocolo V2.
Private Sub ExecuteBatch2(DB As String, con As SQL, in As InputStream, resp As ServletResponse) As String
	Dim ser As B4XSerializator
	' Deserializa el mapa que contiene la lista de comandos.
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	' Obtiene la lista de objetos DBCommand.
	Dim commands As List = m.Get("commands")
	' Prepara un objeto DBResult para la respuesta (aunque para batch no devuelve datos, solo confirmación).
	Dim res As DBResult
	res.Initialize
	res.columns = CreateMap("AffectedRows (N/A)": 0)
	res.Rows.Initialize
	res.Tag = Null
	Try
		' Inicia una transacción. Todos los comandos del lote se ejecutarán como una unidad.
		con.BeginTransaction
		' Itera sobre cada comando en la lista.
		For Each cmd As DBCommand In commands
			' Obtiene la sentencia SQL para el comando actual.
			Dim sqlCommand As String = Connector.GetCommand(DB, cmd.Name)

			' <<< INICIO NUEVA VALIDACIÓN: VERIFICAR SI EL COMANDO EXISTE DENTRO DEL BATCH >>>
			If sqlCommand = Null Or sqlCommand = "null" Or sqlCommand.Trim = "" Then
				con.Rollback ' Deshace la transacción si un comando es inválido.
				Dim errorMessage As String = $"El comando '${cmd.Name}' no fue encontrado en el config.properties de '${DB}'."$
				Log(errorMessage)
				SendPlainTextError(resp, 400, errorMessage)
				Return "error"
			End If
			' <<< FIN NUEVA VALIDACIÓN >>>

			' --- INICIO VALIDACIÓN DE PARÁMETROS DENTRO DEL BATCH ---
			If sqlCommand.Contains("?") Or (cmd.Parameters <> Null And cmd.Parameters.Length > 0) Then
				Dim expectedParams As Int = sqlCommand.Length - sqlCommand.Replace("?", "").Length
				Dim receivedParams As Int
				If cmd.Parameters = Null Then receivedParams = 0 Else receivedParams = cmd.Parameters.Length

				' Si el número de parámetros no coincide, deshace la transacción y envía error.
				If expectedParams <> receivedParams Then
					con.Rollback
					Dim errorMessage As String = $"Número de parametros equivocado para "${cmd.Name}". Se esperaban ${expectedParams} y se recibieron ${receivedParams}."$
					Log(errorMessage)
					SendPlainTextError(resp, 400, errorMessage)
					Return "error"
				End If
			End If
			' --- FIN VALIDACIÓN ---
			
			' Ejecuta el comando (no es una consulta, no devuelve filas).
			con.ExecNonQuery2(sqlCommand, cmd.Parameters)
		Next
		' Añade una fila simbólica al resultado para indicar éxito.
		res.Rows.Add(Array As Object(0))
		' Si todos los comandos se ejecutaron sin error, confirma la transacción.
		con.TransactionSuccessful
	Catch
		' Si cualquier comando falla, se captura el error.
		con.Rollback ' Se deshacen todos los cambios hechos en la transacción.
		Log(LastException)
		SendPlainTextError(resp, 500, LastException.Message)
	End Try
	' Serializa y envía la respuesta al cliente.
	Dim data() As Byte = ser.ConvertObjectToBytes(res)
	resp.OutputStream.WriteBytes(data, 0, data.Length)
	' Devuelve un resumen para el log.
	Return $"batch (size=${commands.Size})"$
End Sub

' Código compilado condicionalmente para el protocolo antiguo (V1).
'#if VERSION1

' Ejecuta un lote de comandos usando el protocolo V1.
Private Sub ExecuteBatch(DB As String, con As SQL, in As InputStream, resp As ServletResponse) As String
	' Lee y descarta la versión del cliente.
	Dim clientVersion As Float = ReadObject(in) 'ignore
	' Lee cuántos comandos vienen en el lote.
	Dim numberOfStatements As Int = ReadInt(in)
	Dim res(numberOfStatements) As Int ' Array para resultados (aunque no se usa).
	Try
		con.BeginTransaction
		' Itera para procesar cada comando del lote.
		For i = 0 To numberOfStatements - 1
			' Lee el nombre del comando y la lista de parámetros usando el deserializador V1.
			Dim queryName As String = ReadObject(in)
			Dim params As List = ReadList(in)
			
			Dim sqlCommand As String = Connector.GetCommand(DB, queryName)

			' <<< INICIO NUEVA VALIDACIÓN: VERIFICAR SI EL COMANDO EXISTE (V1) >>>
			If sqlCommand = Null Or sqlCommand = "null" Or sqlCommand.Trim = "" Then
				con.Rollback
				Dim errorMessage As String = $"El comando '${queryName}' no fue encontrado en el config.properties de '${DB}'."$
				Log(errorMessage)
				SendPlainTextError(resp, 400, errorMessage)
				Return "error"
			End If
			' <<< FIN NUEVA VALIDACIÓN >>>
			
			' --- INICIO VALIDACIÓN DE PARÁMETROS DENTRO DEL BATCH (V1) ---
			If sqlCommand.Contains("?") Or (params <> Null And params.Size > 0) Then
				Dim expectedParams As Int = sqlCommand.Length - sqlCommand.Replace("?", "").Length
				Dim receivedParams As Int
				If params = Null Then receivedParams = 0 Else receivedParams = params.Size

				If expectedParams <> receivedParams Then
					con.Rollback
					Dim errorMessage As String = $"Número de parametros equivocado para "${queryName}". Se esperaban ${expectedParams} y se recibieron ${receivedParams}."$
					Log(errorMessage)
					SendPlainTextError(resp, 400, errorMessage)
					Return "error"
				End If
			End If
			' --- FIN VALIDACIÓN ---
			
			' Ejecuta el comando.
			con.ExecNonQuery2(sqlCommand, params)
		Next
		' Confirma la transacción.
		con.TransactionSuccessful
		
		' Comprime la salida antes de enviarla.
		Dim out As OutputStream = cs.WrapOutputStream(resp.OutputStream, "gzip")
		' Escribe la respuesta usando el serializador V1.
		WriteObject(Main.VERSION, out)
		WriteObject("batch", out)
		WriteInt(res.Length, out)
		For Each r As Int In res
			WriteInt(r, out)
		Next
		out.Close
	Catch
		con.Rollback
		Log(LastException)
		SendPlainTextError(resp, 500, LastException.Message)
	End Try
	Return $"batch (size=${numberOfStatements})"$
End Sub

' Ejecuta una consulta única usando el protocolo V1.
Private Sub ExecuteQuery(DB As String, con As SQL, in As InputStream,  resp As ServletResponse) As String
	Log("======================  ExecuteQuery =====================")
	' Deserializa los datos de la petición usando el protocolo V1.
	Dim clientVersion As Float = ReadObject(in) 'ignore
	Dim queryName As String = ReadObject(in)
	Dim limit As Int = ReadInt(in)
	Dim params As List = ReadList(in)
	' Obtiene la sentencia SQL.
	Dim theSql As String = Connector.GetCommand(DB, queryName)
'	Log(444 & "|" & theSql)
	
	' <<< INICIO NUEVA VALIDACIÓN: VERIFICAR SI EL COMANDO EXISTE (V1) >>>
	If theSql = Null Or theSql ="null" Or theSql.Trim = "" Then
		Dim errorMessage As String = $"El comando '${queryName}' no fue encontrado en el config.properties de '${DB}'."$
		Log(errorMessage)
		SendPlainTextError(resp, 400, errorMessage)
		Return "error"
	End If
	' <<< FIN NUEVA VALIDACIÓN >>>

	' --- INICIO VALIDACIÓN DE PARÁMETROS (V1) ---
	If theSql.Contains("?") Or (params <> Null And params.Size > 0) Then
		Dim expectedParams As Int = theSql.Length - theSql.Replace("?", "").Length
		Dim receivedParams As Int
		If params = Null Then receivedParams = 0 Else receivedParams = params.Size

		If expectedParams <> receivedParams Then
			Dim errorMessage As String = $"Número de parametros equivocado para "${queryName}". Se esperaban ${expectedParams} y se recibieron ${receivedParams}."$
			Log(errorMessage)
			SendPlainTextError(resp, 400, errorMessage)
			Return "error"
		End If
	End If
	' --- FIN VALIDACIÓN ---

	' Ejecuta la consulta.
	Dim rs As ResultSet = con.ExecQuery2(theSql, params)
	If limit <= 0 Then limit = 0x7fffffff 'max int
	Dim jrs As JavaObject = rs
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	Dim cols As Int = rs.ColumnCount
	' Comprime el stream de salida.
	Dim out As OutputStream = cs.WrapOutputStream(resp.OutputStream, "gzip")
	' Escribe la cabecera de la respuesta V1.
	WriteObject(Main.VERSION, out)
	WriteObject("query", out)
	WriteInt(rs.ColumnCount, out)
	' Escribe los nombres de las columnas.
	For i = 0 To cols - 1
		WriteObject(rs.GetColumnName(i), out)
	Next
	
	' Itera sobre las filas del resultado.
	Do While rs.NextRow And limit > 0
		' Escribe un byte '1' para indicar que viene una fila.
		WriteByte(1, out)
		' Itera sobre las columnas de la fila.
		For i = 0 To cols - 1
			Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
			' Maneja los tipos de datos binarios de forma especial.
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
				WriteObject(rs.GetBlob2(i), out)
			Else
				' Escribe el valor de la columna.
				WriteObject(jrs.RunMethod("getObject", Array(i + 1)), out)
			End If
		Next
		limit = limit - 1
	Loop
	' Escribe un byte '0' para indicar el fin de las filas.
	WriteByte(0, out)
	out.Close
	rs.Close
	
	Return "query: " & queryName
End Sub

' Escribe un único byte en el stream de salida.
Private Sub WriteByte(value As Byte, out As OutputStream)
	out.WriteBytes(Array As Byte(value), 0, 1)
End Sub

' Serializador principal para el protocolo V1. Escribe un objeto al stream.
Private Sub WriteObject(o As Object, out As OutputStream)
	Dim data() As Byte
	' Escribe un byte de tipo seguido de los datos.
	If o = Null Then
		out.WriteBytes(Array As Byte(T_NULL), 0, 1)
	Else If o Is Short Then
		out.WriteBytes(Array As Byte(T_SHORT), 0, 1)
		data = bc.ShortsToBytes(Array As Short(o))
	Else If o Is Int Then
		out.WriteBytes(Array As Byte(T_INT), 0, 1)
		data = bc.IntsToBytes(Array As Int(o))
	Else If o Is Float Then
		out.WriteBytes(Array As Byte(T_FLOAT), 0, 1)
		data = bc.FloatsToBytes(Array As Float(o))
	Else If o Is Double Then
		out.WriteBytes(Array As Byte(T_DOUBLE), 0, 1)
		data = bc.DoublesToBytes(Array As Double(o))
	Else If o Is Long Then
		out.WriteBytes(Array As Byte(T_LONG), 0, 1)
		data = bc.LongsToBytes(Array As Long(o))
	Else If o Is Boolean Then
		out.WriteBytes(Array As Byte(T_BOOLEAN), 0, 1)
		Dim b As Boolean = o
		Dim data(1) As Byte
		If b Then data(0) = 1 Else data(0) = 0
	Else If GetType(o) = "[B" Then ' Si el objeto es un array de bytes (BLOB)
		data = o
		out.WriteBytes(Array As Byte(T_BLOB), 0, 1)
		' Escribe la longitud de los datos antes de los datos mismos.
		WriteInt(data.Length, out)
	Else ' Trata todo lo demás como un String
		out.WriteBytes(Array As Byte(T_STRING), 0, 1)
		data = bc.StringToBytes(o, "UTF8")
		' Escribe la longitud del string antes del string.
		WriteInt(data.Length, out)
	End If
	' Escribe los bytes del dato.
	If data.Length > 0 Then out.WriteBytes(data, 0, data.Length)
End Sub

' Deserializador principal para el protocolo V1. Lee un objeto del stream.
Private Sub ReadObject(In As InputStream) As Object
	' Lee el primer byte para determinar el tipo de dato.
	Dim data(1) As Byte
	In.ReadBytes(data, 0, 1)
	Select data(0)
		Case T_NULL
			Return Null
		Case T_SHORT
			Dim data(2) As Byte
			Return bc.ShortsFromBytes(ReadBytesFully(In, data, data.Length))(0)
		Case T_INT
			Dim data(4) As Byte
			Return bc.IntsFromBytes(ReadBytesFully(In, data, data.Length))(0)
		Case T_LONG
			Dim data(8) As Byte
			Return bc.LongsFromBytes(ReadBytesFully(In, data, data.Length))(0)
		Case T_FLOAT
			Dim data(4) As Byte
			Return bc.FloatsFromBytes(ReadBytesFully(In, data, data.Length))(0)
		Case T_DOUBLE
			Dim data(8) As Byte
			Return bc.DoublesFromBytes(ReadBytesFully(In, data, data.Length))(0)
		Case T_BOOLEAN
			Dim b As Byte = ReadByte(In)
			Return b = 1
		Case T_BLOB
			' Lee la longitud, luego lee esa cantidad de bytes.
			Dim len As Int = ReadInt(In)
			Dim data(len) As Byte
			Return ReadBytesFully(In, data, data.Length)
		Case Else ' T_STRING
			' Lee la longitud, luego lee esa cantidad de bytes y los convierte a string.
			Dim len As Int = ReadInt(In)
			Dim data(len) As Byte
			ReadBytesFully(In, data, data.Length)
			Return BytesToString(data, 0, data.Length, "UTF8")
	End Select
End Sub

' Se asegura de leer exactamente la cantidad de bytes solicitada del stream.
Private Sub ReadBytesFully(In As InputStream, Data() As Byte, Len As Int) As Byte()
	Dim count = 0, Read As Int
	' Sigue leyendo en un bucle hasta llenar el buffer, por si los datos llegan en partes.
	Do While count < Len And Read > -1
		Read = In.ReadBytes(Data, count, Len - count)
		count = count + Read
	Loop
	Return Data
End Sub

' Escribe un entero (4 bytes) en el stream.
Private Sub WriteInt(i As Int, out As OutputStream)
	Dim data() As Byte
	data = bc.IntsToBytes(Array As Int(i))
	out.WriteBytes(data, 0, data.Length)
End Sub

' Lee un entero (4 bytes) del stream.
Private Sub ReadInt(In As InputStream) As Int
	Dim data(4) As Byte
	Return bc.IntsFromBytes(ReadBytesFully(In, data, data.Length))(0)
End Sub

' Lee un solo byte del stream.
Private Sub ReadByte(In As InputStream) As Byte
	Dim data(1) As Byte
	In.ReadBytes(data, 0, 1)
	Return data(0)
End Sub

' Lee una lista de objetos del stream (protocolo V1).
Private Sub ReadList(in As InputStream) As List
	' Primero lee la cantidad de elementos en la lista.
	Dim len As Int = ReadInt(in)
	Dim l1 As List
	l1.Initialize
	' Luego lee cada objeto uno por uno y lo añade a la lista.
	For i = 0 To len - 1
		l1.Add(ReadObject(in))
	Next
	Return l1
End Sub
'#end If

' Envía una respuesta de error en formato de texto plano.
' Esto evita la página de error HTML por defecto que genera resp.SendError.
' resp: El objeto ServletResponse para enviar la respuesta.
' statusCode: El código de estado HTTP (ej. 400 para Bad Request, 500 para Internal Server Error).
' errorMessage: El mensaje de error que se enviará al cliente.
Private Sub SendPlainTextError(resp As ServletResponse, statusCode As Int, errorMessage As String)
	Try
		' Establece el código de estado HTTP (ej. 400, 500).
		resp.Status = statusCode
		
		' Define el tipo de contenido como texto plano, con codificación UTF-8 para soportar acentos.
		resp.ContentType = "text/plain; charset=utf-8"
		
		' Obtiene el OutputStream de la respuesta para escribir los datos directamente.
		Dim out As OutputStream = resp.OutputStream
		
		' Convierte el mensaje de error a un array de bytes usando UTF-8.
		Dim data() As Byte = errorMessage.GetBytes("UTF8")
		
		' Escribe los bytes en el stream de salida.
		out.WriteBytes(data, 0, data.Length)
		
		' Cierra el stream para asegurar que todos los datos se envíen correctamente.
		out.Close
	Catch
		' Si algo falla al intentar enviar la respuesta de error, lo registra en el log
		' para que no se pierda la causa original del problema.
		Log("Error sending plain text error response: " & LastException)
	End Try
End Sub
