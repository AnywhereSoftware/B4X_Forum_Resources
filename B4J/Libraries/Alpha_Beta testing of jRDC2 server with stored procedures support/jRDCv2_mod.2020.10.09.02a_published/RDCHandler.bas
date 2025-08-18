B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private DateTimeMethods As Map
	Private ParameterTypes As Map
End Sub

Public Sub Initialize
	DateTimeMethods = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
	ParameterTypes = CreateMap("IN":"IN", "OUT":"OUT", "INOUT":"INOUT")
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim start As Long = DateTime.Now
	Dim q As String 
	Dim in As InputStream = req.InputStream
	Dim method As String = req.GetParameter("method")
	Dim con As SQL
	Try
		con = Main.rdcConnector1.GetConnection
		If method = "query2" Then
			q = ExecuteQuery2(con, in, resp)
		Else if method = "batch2" Then
			q = ExecuteBatch2(con, in, resp)
		Else if method = "call2" Then
			q = ExecuteCall2(con, in, resp)
		Else
			Log("Unknown method: " & method)
			resp.SendError(500, "unknown method")
		End If
	Catch
		Log(LastException)
		resp.SendError(500, LastException.Message)
	End Try
	'Below needed changing for SQLite to work. Do not close any connections when using
	' SQLite. SQLite implementation does not use a pool.
	'If con <> Null And con.IsInitialized Then con.Close
	If con <> Null And con.IsInitialized And Main.rdcConnector1.UsePool Then con.Close
	Log($"Command: ${q}, took: ${DateTime.Now - start}ms, client=${req.RemoteAddress}"$)
End Sub



Private Sub ExecuteQuery2 (con As SQL, in As InputStream,  resp As ServletResponse) As String
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim cmd As DBCommand = m.Get("command")
	Dim limit As Int = m.Get("limit")
	Dim rs As ResultSet
	Dim errMsg As String
	Dim sqlStmt As String
	
	'Sanity check cmd.Name
	sqlStmt = Main.rdcConnector1.GetCommand(cmd.Name)
	If sqlStmt <> "" Then
		Try
			' Call correct Query function based on cmd.Parameters setting
			If cmd.Parameters = Null Or cmd.Parameters.Length = 0 Then
				rs = con.ExecQuery(Main.rdcConnector1.GetCommand(cmd.Name))
			Else
				rs = con.ExecQuery2(Main.rdcConnector1.GetCommand(cmd.Name), cmd.Parameters)
			End If
		Catch
			If rs.IsInitialized Then rs.Close
			Log(LastException)
			errMsg = LastException.Message
		End Try
	Else
		errMsg = $"jRDC ERROR: Command not found: ${cmd.Name}"$
	End If
	If errMsg = "" Then
		Dim res As DBResult = ProcessRS(rs, limit)
		rs.Close
		Dim data() As Byte = ser.ConvertObjectToBytes(res)
		resp.OutputStream.WriteBytes(data, 0, data.Length)
	Else
		Log(errMsg)
		resp.SendError(500, errMsg)
	End If
	Return "query: " & cmd.Name
End Sub

Private Sub ExecuteBatch2(con As SQL, in As InputStream, resp As ServletResponse) As String
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim commands As List = m.Get("commands")
	Dim res As DBResult
	res.Initialize
	res.columns = CreateMap("AffectedRows (N/A)": 0)
	res.Rows.Initialize
	res.Tag = Null
	Dim errFlag As Boolean = False
	Dim errMsg As String = ""
	Dim sqlStmt As String
	Try
		con.BeginTransaction
		For Each cmd As DBCommand In commands
			'Sanity check cmd.Name
			sqlStmt = Main.rdcConnector1.GetCommand(cmd.Name)
			If sqlStmt <> "" Then
				' Call correct NonQuery function based on cmd.Parameters setting
				If cmd.Parameters = Null Or cmd.Parameters.Length = 0 Then
					con.ExecNonQuery(Main.rdcConnector1.GetCommand(cmd.Name))
				Else
					con.ExecNonQuery2(Main.rdcConnector1.GetCommand(cmd.Name), cmd.Parameters)
				End If
			Else
				errFlag = True
				errMsg = $"jRDC ERROR: Command not found: ${cmd.Name}"$				
				Exit
			End If
		Next
		If Not(errFlag) Then
			res.Rows.Add(Array As Object(0))
			con.TransactionSuccessful
			Dim data() As Byte = ser.ConvertObjectToBytes(res)
			resp.OutputStream.WriteBytes(data, 0, data.Length)
		Else
			con.Rollback
			Log(errMsg)
			resp.SendError(500, errMsg)
		End If
	Catch
		con.Rollback
		Log(LastException)
		resp.SendError(500, LastException.Message)
	End Try
	Return $"batch (size=${commands.Size})"$
End Sub

Private Sub ExecuteCall2 (con As SQL, in As InputStream,  resp As ServletResponse) As String
	'https://www.ibm.com/developerworks/data/library/techarticle/dm-0802tiwary/index.html
	Dim jsql As JavaObject = con
	Dim jcon As JavaObject = jsql.GetFieldJO("connection")
	Dim conmeta As JavaObject = jcon.RunMethod("getMetaData", Null)
	Dim supportsNamedParameters As Boolean = conmeta.RunMethod("supportsNamedParameters", Null)
	Log($"ExecuteCall2: Connection supports named parameters = ${supportsNamedParameters}"$)
	
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim cmd As DBCommand = m.Get("command")
	Dim limit As Int = m.Get("limit")
	Dim stmtObject As JavaObject
	Dim rs As ResultSet
	Dim errMsg As String = ""
	Dim sqlStmt As String
	
	'Sanity check cmd.Name
	sqlStmt = Main.rdcConnector1.GetCommand(cmd.Name)
	If sqlStmt <> "" Then
		Try
			' Set up correct statement based on cmd.Parameters setting
			Log("Creating CallableStatement")
			'Let the SQL library create the CallableStatement for us
			stmtObject = con.CreateCallStatement(sqlStmt, Null)
			If cmd.Parameters <> Null And cmd.Parameters.Length > 0 Then
				Dim parameterMap As Map
				For x = 0 To cmd.Parameters.Length - 1
					If cmd.Parameters(x) Is Map Then
						parameterMap = cmd.Parameters(x)
						'See if user wants to set SQL type for this parameter
						Dim sqlType As String
						Dim sqlTypeClass As JavaObject
						Dim sqlTypeOrdinal As Int
						If parameterMap.ContainsKey("sqlType") Then
							'Get SQL type information
							If Not(Main.SQLDataTypeClassNames.ContainsKey(parameterMap.GetDefault("sqlTypeClass", "JDBC"))) Then
								errMsg = $"The SQL type class ${parameterMap.Get("sqlTypeClass")} not supported"$
								Exit
							End If
							sqlType = parameterMap.Get("sqlType")
							sqlTypeClass = Main.SQLDataTypeClasses.Get(parameterMap.GetDefault("sqlTypeClass", "JDBC"))
							Try
								sqlTypeOrdinal = sqlTypeClass.GetField(sqlType)
								Log($"sqlTypeOrdinal = ${sqlTypeOrdinal}"$)
							Catch
								errMsg = LastException
								Exit
							End Try
						End If
					
						Dim pType As String = parameterMap.GetDefault("type", "IN") 'Fetch parameter type. Default to IN
						If Not(ParameterTypes.ContainsKey(pType)) Then
							errMsg = $"Unsupported parameter type: ${pType}"$
							Exit
						End If
						
						'Register OUT parameter (either OUT or INOUT)
						If pType.Contains("OUT") Then
							If sqlType = "" Then
								errMsg = "OUT parameters must have their SQL types declared"
								Exit
							End If
							If parameterMap.ContainsKey("name") Then
								Log($"Registering out parameter named ${parameterMap.Get("name")}, with SQL type: ${sqlTypeOrdinal}"$)
								stmtObject.RunMethod("registerOutParameter", Array (parameterMap.Get("name"), sqlTypeOrdinal))		
							Else
								Log($"Registering out parameter index ${x+1}, with SQL type: ${sqlTypeOrdinal}"$)
								stmtObject.RunMethod("registerOutParameter", Array (x+1, sqlTypeOrdinal))
							End If
						End If
						
						'Register IN parameter (either IN or INOUT)
						If pType.Contains("IN") Then
							If parameterMap.ContainsKey("name") Then 'Named parameter
								If parameterMap.ContainsKey("value") Then 'With value
									If sqlType = "" Then
										Log($"Setting named parameter ${parameterMap.Get("name")} to value: ${parameterMap.Get("value")}"$)
										stmtObject.RunMethod("setObject", Array (parameterMap.Get("name"), parameterMap.Get("value")))
									Else
										Log($"Setting named parameter ${parameterMap.Get("name")} to value: ${parameterMap.Get("value")} having sqlTypeOrdial ${sqlTypeOrdinal}"$)
										stmtObject.RunMethod("setObject", Array (parameterMap.Get("name"), parameterMap.Get("value"), sqlTypeOrdinal))
									End If
								Else 'Named parameter without value
									If sqlType <> "" Then
										Log($"Setting named parameter ${parameterMap.Get("name")} to SQL NULL having sqlTypeOrdial ${sqlTypeOrdinal}"$)
										stmtObject.RunMethod("setNull", Array (x+1, sqlTypeOrdinal))
									Else
										errMsg = "Setting parameter to SQL NULL requires SQL type to be set"
										Exit
									End If
								End If
							Else ' Parameter is not named
								If parameterMap.ContainsKey("value") Then 'With value
									If sqlType = "" Then
										Log($"Setting parameter ${x+1} to value: ${parameterMap.Get("value")}"$)
										stmtObject.RunMethod("setObject", Array (x+1, parameterMap.Get("value")))
									Else
										Log($"Setting parameter ${x+1} to value: ${parameterMap.Get("value")} having sqlTypeOrdial ${sqlTypeOrdinal}"$)
										stmtObject.RunMethod("setObject", Array (x+1, parameterMap.Get("value"), sqlTypeOrdinal))
									End If
								Else 'Indexed parameter without value
									If sqlType <> "" Then
										Log($"Setting parameter ${x+1} to SQL NULL having sqlTypeOrdial ${sqlTypeOrdinal}"$)
										stmtObject.RunMethod("setNull", Array (x+1, sqlTypeOrdinal))
									Else
										errMsg = "Setting parameter to SQL NULL requires SQL type to be set"
										Exit
									End If
								End If
							End If
						End If 'Finished registering IN parameter
						
					Else ' cmd.Parameters(x) is not a Map
						Log($"Setting standard parameter value of ${cmd.Parameters(x)} for index ${x+1}"$)
						stmtObject.RunMethod("setObject", Array (x+1, cmd.Parameters(x)))
					End If
				Next
			End If
			If errMsg = "" Then
				Log("Executing CallableStatement")
				Dim returnArray(2) As Object

				'Get any returned result sets
				Dim resultSets As List
				resultSets.Initialize
				Dim hadResults As Boolean = stmtObject.RunMethod("execute", Null)
				Log($"CallableStatement returned one or more result sets: ${hadResults}"$)
				Do While hadResults
					rs = stmtObject.RunMethod("getResultSet", Null)
					resultSets.Add(ProcessRS(rs, limit))
					rs.Close
					hadResults = stmtObject.RunMethod("getMoreResults", Null)
				Loop

				'Get out parameters
				Dim outParams As Map
				outParams.Initialize
				If cmd.Parameters <> Null And cmd.Parameters.Length > 0 Then
					Dim parameterMap As Map
					For x = 0 To cmd.Parameters.Length - 1
						If cmd.Parameters(x) Is Map Then
							parameterMap = cmd.Parameters(x)
							Dim pType As String = parameterMap.GetDefault("type", "IN")
							If pType.Contains("OUT") Then
								If parameterMap.ContainsKey("name") Then
									Log($"Output named parameter ${parameterMap.Get("name")} has value of: ${stmtObject.RunMethod("getObject", Array (parameterMap.Get("name")))}"$)
									outParams.Put(parameterMap.Get("name"), stmtObject.RunMethod("getObject", Array (parameterMap.Get("name"))))
								Else
									Log($"Output parameter index ${x+1} has value of: ${stmtObject.RunMethod("getObject", Array (x+1))}"$)
									outParams.Put(x+1, stmtObject.RunMethod("getObject", Array (x+1)))
								End If
							End If
						End If
					Next
					If outParams.Size > 0 Then
						Log($"CallableStatement returned ${outParams.Size} OUT parameters"$)
					End If
				End If
				stmtObject.RunMethod("close", Null)
				
				returnArray(0) = resultSets
				returnArray(1) = outParams
				Dim data() As Byte = ser.ConvertObjectToBytes(returnArray)
				resp.OutputStream.WriteBytes(data, 0, data.Length)
			Else 'If errMessage = ""
				stmtObject.RunMethod("close", Null)	
				Log(errMsg)
				resp.SendError(500, errMsg)
			End If
		Catch
			If rs.IsInitialized Then rs.Close
			If stmtObject.IsInitialized Then stmtObject.RunMethod("close", Null)
			Log(LastException)
			resp.SendError(500, LastException.Message)
		End Try
	Else
		errMsg = $"jRDC ERROR: Command not found: ${cmd.Name}"$
		Log(errMsg)
		resp.SendError(500, errMsg)
	End If
	Return "call: " & cmd.Name
End Sub

Private Sub ProcessRS(rs As ResultSet, limit As Int) As DBResult
	If limit <= 0 Then limit = 0x7fffffff 'max int
	Dim jrs As JavaObject = rs
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	Dim cols As Int = rs.ColumnCount
	Dim res As DBResult
	res.Initialize
	res.columns.Initialize
	res.Tag = Null 'without this the Tag properly will not be serializable.
	For i = 0 To cols - 1
		res.columns.Put(rs.GetColumnName(i), i)
	Next
	res.Rows.Initialize
	
	Do While rs.NextRow And limit > 0
		Dim row(cols) As Object
		For i = 0 To cols - 1
			Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
			'check whether it is a blob field
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
				row(i) = rs.GetBlob2(i)
			Else if ct = 2 Or ct = 3 Then
				row(i) = rs.GetDouble2(i)
			Else If DateTimeMethods.ContainsKey(ct) Then
				Dim SQLTime As JavaObject = jrs.RunMethodJO(DateTimeMethods.Get(ct), Array(i + 1))
				If SQLTime.IsInitialized Then
					row(i) = SQLTime.RunMethod("getTime", Null)
				Else
					row(i) = Null
				End If
			Else
				row(i) = jrs.RunMethod("getObject", Array(i + 1))
			End If
		Next
		res.rows.Add(row)
	Loop
	Return res
End Sub