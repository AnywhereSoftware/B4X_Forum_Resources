B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private DateTimeMethods As Map
End Sub

Public Sub Initialize
	DateTimeMethods = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
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
	Dim errFlag As Boolean = False
	Dim errMsg As String = ""
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
			errFlag = True
			Log(LastException)
			resp.SendError(500, LastException.Message)
		End Try
	Else
		errFlag = True
		errMsg = $"jRDC ERROR: Command not found: ${cmd.Name}"$
		Log(errMsg)
		resp.SendError(500, errMsg)
	End If
	If Not(errFlag) Then
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
				Else If ct = 2005 Then			'Added from jRDC2 version 2.23
					row(i) = rs.GetString2(i)
				Else If DateTimeMethods.ContainsKey(ct) Then	'Added from jRDC2 version 2.22. See https://www.b4x.com/android/forum/threads/jrdc2-query-problem.98546/post-621407
					Dim SQLTime As JavaObject = jrs.RunMethodJO(DateTimeMethods.Get(ct), Array(i + 1))
					If SQLTime.IsInitialized Then
						row(i) = SQLTime.RunMethod("getTime", Null)
					Else
						row(i) = Null
					End If
				Else If ct = -155 Then			'See https://www.b4x.com/android/forum/threads/jrdc2-errors-when-querying-sql-server-datetimeoffset-column.129256/post-812054
					'Retrieve a  microsoft.sql.DateTimeOffset object and from it retrieve a java.sql.Timestamp
					'https://docs.microsoft.com/en-us/sql/connect/jdbc/reference/datetimeoffset-members?view=sql-server-ver15
					Dim SQLTime As JavaObject = jrs.RunMethodJO("getObject", Array(i + 1)).RunMethodJO("getTimestamp", Null)
					If SQLTime.IsInitialized Then
						row(i) = SQLTime.RunMethod("getTime", Null)
					Else
						row(i) = Null
					End If
				Else
					row(i) = jrs.RunMethod("getObject", Array(i + 1))
				End If
			Next
			res.Rows.Add(row)
		Loop
		rs.Close
		Dim data() As Byte = ser.ConvertObjectToBytes(res)
		resp.OutputStream.WriteBytes(data, 0, data.Length)
	End If ' If Not(errFlag)
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
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim cmd As DBCommand = m.Get("command")
	Dim limit As Int = m.Get("limit")
	Dim stmtObject As Object
	Dim rs As ResultSet
	Dim errFlag As Boolean = False
	Dim errMsg As String = ""
	Dim sqlStmt As String
	
	'Sanity check cmd.Name
	sqlStmt = Main.rdcConnector1.GetCommand(cmd.Name)
	If sqlStmt <> "" Then
		Try
			' Set up correct statement based on cmd.Parameters setting
			If cmd.Parameters = Null Or cmd.Parameters.Length = 0 Then
				stmtObject = con.CreateCallStatement(Main.rdcConnector1.GetCommand(cmd.Name), Null)
			Else
				stmtObject = con.CreateCallStatement(Main.rdcConnector1.GetCommand(cmd.Name), cmd.Parameters)
			End If
			rs = con.ExecCall(stmtObject)
		Catch
			If rs.IsInitialized Then rs.Close
			errFlag = True
			Log(LastException)
			resp.SendError(500, LastException.Message)
		End Try
	Else
		errFlag = True
		errMsg = $"jRDC ERROR: Command not found: ${cmd.Name}"$
		Log(errMsg)
		resp.SendError(500, errMsg)
	End If
	If Not(errFlag) Then
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
			res.Rows.Add(row)
		Loop
		rs.Close
		Dim data() As Byte = ser.ConvertObjectToBytes(res)
		resp.OutputStream.WriteBytes(data, 0, data.Length)
	End If ' If Not(errFlag)
	Return "call: " & cmd.Name
End Sub