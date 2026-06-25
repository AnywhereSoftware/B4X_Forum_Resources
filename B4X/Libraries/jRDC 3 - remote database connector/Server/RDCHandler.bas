B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
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
		Else
			Log("Unknown method: " & method)
			resp.SendError(500, "unknown method")
		End If
	Catch
		Log(LastException)
		resp.SendError(500, LastException.Message)
	End Try
	If con <> Null And con.IsInitialized Then con.Close
	Log($"Command: ${q}, took: ${DateTime.Now - start}ms, client=${req.RemoteAddress}"$)
End Sub

Private Sub CommandFromRequest(rc As Object, version As Float) As DBCommand
	Dim res As DBCommand
	If version < 3 Then
		res = rc
	Else
		Dim c As Map = rc
		Dim res As DBCommand
		res.Name = c.Get("name")
		res.Parameters = c.Get("parameters")
	End If
	If res.Parameters = Null Then
		res.Parameters = Array()
	End If
	Return res
End Sub

Private Sub ExecuteQuery2 (con As SQL, in As InputStream,  resp As ServletResponse) As String
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim version As Float = m.Get("version")
	Dim cmd As DBCommand = CommandFromRequest(m.Get("command"), version)
	Dim limit As Int = m.GetDefault("limit", 0)
	Dim rs As ResultSet = con.ExecQuery2(Main.rdcConnector1.GetCommand(cmd.Name), cmd.Parameters)
	If limit <= 0 Then limit = 0x7fffffff 'max int
	Dim jrs As JavaObject = rs
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	Dim cols As Int = rs.ColumnCount
	Dim columns(cols) As Object
	For i = 0 To cols - 1
		columns(i) = rs.GetColumnName(i)
	Next
	Dim lres As ListOfArrays = LOAUtils.CreateEmpty(columns)
	Do While rs.NextRow And lres.Size < limit
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
		lres.AddRow(row)
	Loop
	rs.Close
	If version < 3 Then
		Dim res As DBResult
		res.Initialize
		res.columns.Initialize
		res.Tag = Null 'without this the Tag properly will not be serializable.
		For i = 0 To cols - 1
			res.columns.Put(columns(i), i)
		Next
		res.Rows = lres.mInternalArray.SubList(lres.mFirstDataRowIndex, lres.mInternalArray.Size)
		Dim data() As Byte = ser.ConvertObjectToBytes(res)
	Else
		Dim data() As Byte = ser.ConvertObjectToBytes(lres.mInternalArray)
	End If
	resp.OutputStream.WriteBytes(data, 0, data.Length)
	Return "query: " & cmd.Name
End Sub

Private Sub ExecuteBatch2(con As SQL, in As InputStream, resp As ServletResponse) As String
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim raw_commands As List = m.Get("commands")
	Dim commands As List = B4XCollections.CreateList(Null)
	Dim version As Float = m.Get("version")
	For Each rc As Object In raw_commands
		commands.Add(CommandFromRequest(rc, version))
	Next
	
	Try
		con.BeginTransaction
		For Each cmd As DBCommand In commands
			con.ExecNonQuery2(Main.rdcConnector1.GetCommand(cmd.Name), _
				cmd.Parameters)
		Next
		con.TransactionSuccessful
		
	Catch
		con.Rollback
		Log(LastException)
		resp.SendError(500, LastException.Message)
		Return ""
	End Try
	If version < 3 Then
		Dim res As DBResult
		res.Initialize
		res.columns = CreateMap("AffectedRows (N/A)": 0)
		res.Rows.Initialize
		res.Rows.Add(Array As Object(0))
		res.Tag = Null
		Dim data() As Byte = ser.ConvertObjectToBytes(res)
	Else
		Dim res2 As ListOfArrays = LOAUtils.CreateEmpty(Array("batch"))
		Dim data() As Byte = ser.ConvertObjectToBytes(res2.mInternalArray)
	End If
	resp.OutputStream.WriteBytes(data, 0, data.Length)
	Return $"batch (size=${commands.Size})"$
End Sub
