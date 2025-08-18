B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'version 1.01
Sub Process_Globals
	Public DB_REAL, DB_INTEGER, DB_BLOB, DB_TEXT As String
	DB_REAL = "REAL"
	DB_INTEGER = "INTEGER"
	DB_BLOB = "BLOB"
	DB_TEXT = "TEXT"
	Dim HtmlCSS As String = "table {width: 100%;border: 1px solid #cef;text-align: left; }" _
		& " th { font-weight: bold;	background-color: #acf;	border-bottom: 1px solid #cef; }" _ 
		& "td,th {	padding: 4px 5px; }" _
		& ".odd {background-color: #def; } .odd td {border-bottom: 1px solid #cef; }" _
		& "a { text-decoration:none; color: #000;}"
End Sub

Private Sub EscapeField(f As String) As String
	Return "[" & f & "]"
End Sub

'Creates a new table with the given name.
'FieldsAndTypes - A map with the fields names as keys and the types as values.
'You can use the DB_... constants for the types.
'PrimaryKey - The column that will be the primary key. Pass empty string if not needed.
Public Sub CreateTable(SQL As SQL, TableName As String, FieldsAndTypes As Map, PrimaryKey As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For i = 0 To FieldsAndTypes.Size - 1
		Dim field, ftype As String
		field = FieldsAndTypes.GetKeyAt(i)
		ftype = FieldsAndTypes.GetValueAt(i)
		If i > 0 Then sb.Append(", ")
		sb.Append(EscapeField(field)).Append(" ").Append(ftype)
		If field = PrimaryKey Then sb.Append(" PRIMARY KEY")
	Next
	sb.Append(")")
	Dim query As String
	query = "CREATE TABLE IF NOT EXISTS " & EscapeField(TableName) & " " & sb.ToString
	Log("CreateTable: " & query)
	SQL.ExecNonQuery(query)
End Sub

'Deletes the given table.
Public Sub DropTable(SQL As SQL, TableName As String)
	Dim query As String
	query = "DROP TABLE IF EXISTS " & EscapeField(TableName)
	Log("DropTable3: " & query)
	SQL.ExecNonQuery(query)
End Sub


'Inserts the data to the table.
'ListOfMaps - A list with maps as items. Each map represents a record where the map keys are the columns names
'and the maps values are the values.
'Note that you should create a new map for each record (this can be done by calling Dim to redim the map).
Public Sub InsertMaps(SQL As SQL, TableName As String, ListOfMaps As List)
	Dim sb, columns, values As StringBuilder
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return
	End If
	SQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			sb.Initialize
			columns.Initialize
			values.Initialize
			Dim listOfValues As List
			listOfValues.Initialize
			sb.Append("INSERT INTO [" & TableName & "] (")
			Dim m As Map
			m = ListOfMaps.Get(i1)
			For i2 = 0 To m.Size - 1
				Dim col As String
				Dim value As Object	
				col = m.GetKeyAt(i2)
				value = m.GetValueAt(i2)
				If i2 > 0 Then
					columns.Append(", ")
					values.Append(", ")
				End If
				columns.Append(EscapeField(col))
				
				values.Append("?")
				listOfValues.Add(value)
			Next
			sb.Append(columns.ToString)
			sb.Append(") VALUES (")
			sb.Append(values.ToString)
			sb.Append(")")
			'If i1 = 0 Then Log("InsertMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
			SQL.ExecNonQuery2(sb.ToString, listOfValues)
		Next
		SQL.TransactionSuccessful
	Catch
		Log(LastException)
		SQL.Rollback
	End Try
End Sub

' updates a single field in a record
' Field is the column name
Public Sub UpdateRecord(SQL As SQL, TableName As String, Field As String, NewValue As Object, _
	WhereFieldEquals As Map)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ").Append(EscapeField(Field)) _
		.Append(" = ? WHERE ")
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	Dim args As List
	args.Initialize
	args.Add(NewValue)
	For i = 0 To WhereFieldEquals.Size - 1
		If i > 0 Then sb.Append(" AND ")
		sb.Append(EscapeField(WhereFieldEquals.GetKeyAt(i))).Append(" = ?")
		args.Add(WhereFieldEquals.GetValueAt(i))
	Next
	'Log("UpdateRecord: " & sb.ToString)
	SQL.ExecNonQuery2(sb.ToString, args)
End Sub

' updates multiple fields in a record
' in the Fields map the keys are the column names
Public Sub UpdateRecord2(SQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map)
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return
	End If
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ")
	Dim args As List
	args.Initialize
	For i=0 To Fields.Size-1
		If i<>Fields.Size-1 Then
			sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?,")
		Else
			sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?")
		End If
		args.Add(Fields.GetValueAt(i))
	Next
    
	sb.Append(" WHERE ")
	For i = 0 To WhereFieldEquals.Size - 1
		If i > 0 Then 
			sb.Append(" AND ")
		End If
		sb.Append(EscapeField(WhereFieldEquals.GetKeyAt(i))).Append(" = ?")
		args.Add(WhereFieldEquals.GetValueAt(i))
	Next
	'Log("UpdateRecord: " & sb.ToString)
	SQL.ExecNonQuery2(sb.ToString, args)
End Sub

'Executes the query and returns the result as a list of arrays.
'Each item in the list is a strings array.
'StringArgs - Values to replace question marks in the query. Pass Null if not needed.
'Limit - Limits the results. Pass 0 for all results.
Public Sub ExecuteMemoryTable(SQL As SQL, Query As String, StringArgs() As String, Limit As Int) As List
	Dim cur As ResultSet
	If StringArgs = Null Then 
		Dim StringArgs(0) As String
	End If
	cur = SQL.ExecQuery2(Query, StringArgs)
	'Log("ExecuteMemoryTable: " & Query)
	Dim table As List
	table.Initialize
	Do While cur.NextRow
		Dim values(cur.ColumnCount) As String
		For col = 0 To cur.ColumnCount - 1
			values(col) = cur.GetString2(col)
		Next
		table.Add(values)
		If Limit > 0 AND table.Size >= Limit Then Exit
	Loop
	cur.Close
	Return table
End Sub

'Executes the query and returns a Map with the column names as the keys 
'and the first record values As the entries values.
'The keys are lower cased.
'Returns an uninitialized map if there are no results.
Public Sub ExecuteMap(SQL As SQL, Query As String, StringArgs() As String) As Map
	Dim res As Map
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	'Log("ExecuteMap: " & Query)
	If cur.NextRow = False Then
		Log("No records found.")
		Return res
	End If
	res.Initialize
	For i = 0 To cur.ColumnCount - 1
		res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
	Next
	cur.Close
	Return res
End Sub

'Executes the query and fills the list with the values in the first column.
Public Sub ExecuteList(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, List1 As List)
	List1.Clear
	Dim Table As List
	Table = ExecuteMemoryTable(SQL, Query, StringArgs, Limit)
	If Table.Size = 0 Then Return
	Dim Cols() As String
	For i = 0 To Table.Size - 1
		Cols = Table.Get(i)
		List1.Add(Cols(0))
	Next
End Sub

'Executes the given query and creates a Map that you can pass to JSONGenerator and generate JSON text.
'DBTypes - Lists the type of each column in the result set.
'Usage example: (don't forget to add a reference to the JSON library)
'	Dim gen As JSONGenerator
'	gen.Initialize(DBUtils.ExecuteJSON(SQL, "SELECT Id, Birthday FROM Students", Null, _
'		0, Array As String(DBUtils.DB_TEXT, DBUtils.DB_INTEGER)))
Public Sub ExecuteJSON (SQL As SQL, Query As String, StringArgs() As String, Limit As Int, DBTypes As List) As Map
	Dim table As List
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log("ExecuteJSON: " & Query)
	Dim table As List
	table.Initialize
	Do While cur.NextRow
		Dim m As Map
		m.Initialize
		For i = 0 To cur.ColumnCount - 1
			Select DBTypes.Get(i)
				Case DB_TEXT
					m.Put(cur.GetColumnName(i), cur.GetString2(i))
				Case DB_INTEGER
					m.Put(cur.GetColumnName(i), cur.GetLong2(i))
				Case DB_REAL
					m.Put(cur.GetColumnName(i), cur.GetDouble2(i))
				Case Else
					Log("Invalid type: " & DBTypes.Get(i))
			End Select
		Next
		table.Add(m)
		If Limit > 0 And m.Size >= Limit Then Exit
	Loop
	cur.Close
	Dim root As Map
	root.Initialize
	root.Put("root", table)
	Return root
End Sub



'Creates a html text that displays the data in a table.
'The style of the table can be changed by modifying HtmlCSS variable.
Public Sub ExecuteHtml(SQL As SQL, Query As String, StringArgs() As String, Limit As Int) As String
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log("ExecuteHtml: " & Query)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<html><body>").Append(CRLF)
	sb.Append("<style type='text/css'>").Append(HtmlCSS).Append("</style>").Append(CRLF)
	sb.Append("<table><thead><tr>").Append(CRLF)
	For i = 0 To cur.ColumnCount - 1
		sb.Append("<th>").Append(cur.GetColumnName(i)).Append("</th>")
	Next
	sb.Append("</thead>")
	
'	For i = 0 To cur.ColumnCount - 1
'		If i = 1 Then
'			sb.Append("<th style='width:200px;'>").Append(cur.GetColumnName(i)).Append("</th>")
'		Else
'			sb.Append("<th>").Append(cur.GetColumnName(i)).Append("</th>")
'		End If
'	Next
		
	sb.Append("</tr>").Append(CRLF)
	Dim row As Int
	Do While cur.NextRow
		If row Mod 2 = 0 Then
			sb.Append("<tr>")
		Else
			sb.Append("<tr class='odd'>")
		End If
		For i = 0 To cur.ColumnCount - 1
			sb.Append("<td>")
			sb.Append(cur.GetString2(i))
			sb.Append("</td>")
		Next
		sb.Append("</tr>").Append(CRLF)
		row = row + 1
	Loop
	cur.Close
	sb.Append("</table></body></html>")
	Return sb.ToString
End Sub

Public Sub DeleteRecord(SQL As SQL, TableName As String, WhereFieldEquals As Map)
   Dim sb As StringBuilder
   sb.Initialize
   sb.Append("DELETE FROM [").Append(TableName).Append("] WHERE ")
   If WhereFieldEquals.Size = 0 Then
      Log("WhereFieldEquals map empty!")
      Return
   End If
   Dim args As List
   args.Initialize
   For i = 0 To WhereFieldEquals.Size - 1
      If i > 0 Then sb.Append(" AND ")
      sb.Append("[").Append(WhereFieldEquals.GetKeyAt(i)).Append("] = ?")
      args.Add(WhereFieldEquals.GetValueAt(i))
   Next
  ' Log("DeleteRecord: " & sb.ToString)
   SQL.ExecNonQuery2(sb.ToString, args)
End Sub

#if Not(UI)
Public Sub FillTable(ws As WebSocket, jq As JQueryElement, rs As ResultSet)
	Dim data As List
	data.Initialize
	Do While rs.NextRow
		Dim row As List
		row.Initialize
		For c = 0 To rs.ColumnCount - 1
			Dim val As String = rs.GetString2(c)
			row.Add($"$Xml{val}"$)
		Next
		data.Add(row)
	Loop
	rs.Close
	ws.Eval("$(arguments[0]).dataTable().fnClearTable()", Array As Object(jq.Id))
	ws.Eval("$(arguments[0]).dataTable().fnAddData(arguments[1])", Array As Object(jq.Id, data))
End Sub
#End If
