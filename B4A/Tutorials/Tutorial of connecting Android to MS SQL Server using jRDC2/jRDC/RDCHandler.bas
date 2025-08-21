B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
@EndOfDesignText@
'Handler class
Sub Class_Globals
	#if VERSION1
	Private const T_NULL = 0, T_STRING = 1, T_SHORT = 2, T_INT = 3, T_LONG = 4, T_FLOAT = 5 _
		,T_DOUBLE = 6, T_BOOLEAN = 7, T_BLOB = 8 As Byte
	Private bc As ByteConverter
	Private cs As CompressedStreams
	#end if
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
#if VERSION1
		Else if method = "query" Then
			in = cs.WrapInputStream(in, "gzip")
			q = ExecuteQuery(con, in, resp)
		Else if method = "batch" Then
			in = cs.WrapInputStream(in, "gzip")
			q = ExecuteBatch(con, in, resp)
#end if
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



Private Sub ExecuteQuery2 (con As SQL, in As InputStream,  resp As ServletResponse) As String
	Dim ser As B4XSerializator
	Dim m As Map = ser.ConvertBytesToObject(Bit.InputStreamToBytes(in))
	Dim cmd As DBCommand = m.Get("command")
	Dim limit As Int = m.Get("limit")
	Dim rs As ResultSet = con.ExecQuery2(Main.rdcConnector1.GetCommand(cmd.Name), cmd.Parameters)
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
	Try
		con.BeginTransaction
		For Each cmd As DBCommand In commands
			con.ExecNonQuery2(Main.rdcConnector1.GetCommand(cmd.Name), _
				cmd.Parameters)
		Next
		res.Rows.Add(Array As Object(0))
		con.TransactionSuccessful
	Catch
		con.Rollback
		Log(LastException)
		resp.SendError(500, LastException.Message)
	End Try
	Dim data() As Byte = ser.ConvertObjectToBytes(res)
	resp.OutputStream.WriteBytes(data, 0, data.Length)
	Return $"batch (size=${commands.Size})"$
End Sub

#if VERSION1

Private Sub ExecuteBatch(con As SQL, in As InputStream, resp As ServletResponse) As String
	Dim clientVersion As Float = ReadObject(in) 'ignore
	Dim numberOfStatements As Int = ReadInt(in)
	Dim res(numberOfStatements) As Int
	Try
		con.BeginTransaction
		For i = 0 To numberOfStatements - 1
			Dim queryName As String = ReadObject(in)
			Dim params As List = ReadList(in)
			con.ExecNonQuery2(Main.rdcConnector1.GetCommand(queryName), _
				params)
		Next
		con.TransactionSuccessful
		
		Dim out As OutputStream = cs.WrapOutputStream(resp.OutputStream, "gzip")
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
		resp.SendError(500, LastException.Message)
	End Try
	Return $"batch (size=${numberOfStatements})"$
End Sub

Private Sub ExecuteQuery (con As SQL, in As InputStream,  resp As ServletResponse) As String
	Dim clientVersion As Float = ReadObject(in) 'ignore
	Dim queryName As String = ReadObject(in)
	Dim limit As Int = ReadInt(in)
	Dim params As List = ReadList(in)
	Dim rs As ResultSet = con.ExecQuery2(Main.rdcConnector1.GetCommand(queryName), _
		params)
	If limit <= 0 Then limit = 0x7fffffff 'max int
	Dim jrs As JavaObject = rs
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	Dim cols As Int = rs.ColumnCount
	Dim out As OutputStream = cs.WrapOutputStream(resp.OutputStream, "gzip")
	WriteObject(Main.VERSION, out)
	WriteObject("query", out)
	WriteInt(rs.ColumnCount, out)
	
	For i = 0 To cols - 1
		WriteObject(rs.GetColumnName(i), out)
	Next
	
	Do While rs.NextRow And limit > 0
		WriteByte(1, out)
		For i = 0 To cols - 1
			Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
			'check whether it is a blob field
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
				WriteObject(rs.GetBlob2(i), out)
			Else
				WriteObject(jrs.RunMethod("getObject", Array(i + 1)), out)
			End If
		Next
	Loop
	WriteByte(0, out)
	out.Close
	rs.Close
	Return "query: " & queryName
End Sub

Private Sub WriteByte(value As Byte, out As OutputStream)
	out.WriteBytes(Array As Byte(value), 0, 1)
End Sub



Private Sub WriteObject(o As Object, out As OutputStream)
	Dim data() As Byte
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
	Else If GetType(o) = "[B" Then
		data = o
		out.WriteBytes(Array As Byte(T_BLOB), 0, 1)
		WriteInt(data.Length, out)	
	Else 'If o Is String Then (treat all other values as string)
		out.WriteBytes(Array As Byte(T_STRING), 0, 1)
		data = bc.StringToBytes(o, "UTF8")
		WriteInt(data.Length, out)
	End If
	If data.Length > 0 Then out.WriteBytes(data, 0, data.Length)
End Sub

Private Sub ReadObject(In As InputStream) As Object
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
			Dim len As Int = ReadInt(In)
			Dim data(len) As Byte
			Return ReadBytesFully(In, data, data.Length)
		Case Else
			Dim len As Int = ReadInt(In)
			Dim data(len) As Byte
			ReadBytesFully(In, data, data.Length)
			Return BytesToString(data, 0, data.Length, "UTF8")
	End Select
End Sub

Private Sub ReadBytesFully(In As InputStream, Data() As Byte, Len As Int) As Byte()
	Dim count = 0, Read As Int
	Do While count < Len And Read > -1
		Read = In.ReadBytes(Data, count, Len - count)
		count = count + Read
	Loop
	Return Data
End Sub

Private Sub WriteInt(i As Int, out As OutputStream)
	Dim data() As Byte
	data = bc.IntsToBytes(Array As Int(i))
	out.WriteBytes(data, 0, data.Length)
End Sub

Private Sub ReadInt(In As InputStream) As Int
	Dim data(4) As Byte
	Return bc.IntsFromBytes(ReadBytesFully(In, data, data.Length))(0)
End Sub

Private Sub ReadByte(In As InputStream) As Byte
	Dim data(1) As Byte
	In.ReadBytes(data, 0, 1)
	Return data(0)
End Sub

Private Sub ReadList(in As InputStream) As List
	Dim len As Int = ReadInt(in)
	Dim l1 As List
	l1.Initialize
	For i = 0 To len - 1
		l1.Add(ReadObject(in))
	Next
	Return l1
End Sub
#end If