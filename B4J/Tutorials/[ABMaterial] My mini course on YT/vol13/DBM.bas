B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
Sub Process_Globals
	Private pool As ConnectionPool
	Private SQLite As SQL
	Public UsePool As Boolean
End Sub

Sub InitializeSQLite(Dir As String, fileName As String, createIfNeeded As Boolean) 'ignore
	Log("init sqlite")
	SQLite.InitializeSQLite(Dir, fileName, createIfNeeded)
	UsePool = False
End Sub

Sub InitializeMySQL(jdbcUrl As String ,login As String, password As String, poolSize As Int) 'ignore
	Log("init mysql")
	UsePool = True
	Try
		pool.Initialize("com.mysql.jdbc.Driver", jdbcUrl, login, password)
	Catch
		Log("Last Pool Init Except: "&LastException.Message)
	End Try

	' change pool size...
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(poolSize))
End Sub

Sub GetSQL() As SQL 'ignore
	If UsePool Then
		Return pool.GetConnection
	Else
		Return SQLite
	End If
End Sub

Sub CloseSQL(mySQL As SQL) 'ignore
	If UsePool Then
		mySQL.Close
	End If
End Sub

Sub SQLSelect(SQL As SQL, Query As String, Args As List) As List 'ignore
	Dim l As List
	l.Initialize
	Dim cur As ResultSet
	Try
		cur = SQL.ExecQuery2(Query, Args)
	Catch
		Log(LastException)
		Return l
	End Try
	Do While cur.NextRow
		Dim res As Map
		res.Initialize
		For i = 0 To cur.ColumnCount - 1
			res.Put(cur.GetColumnName(i).ToLowerCase, cur.GetString2(i))
		Next
		l.Add(res)
	Loop
	cur.Close
	Return l
End Sub

Sub SQLCreate(SQL As SQL, Query As String) As Int 'ignore
	Dim res As Int
	Try
		SQL.ExecNonQuery(Query)
		res = 0
	Catch
		Log(LastException)
		res = -99999999
	End Try
	Return res
End Sub

Sub SQLInsert(SQL As SQL, Query As String) As Int 'ignore
	Dim res As Int
	Try
		SQL.ExecNonQuery(Query)
		If UsePool Then
			res = SQLSelectSingleResult(SQL, "SELECT LAST_INSERT_ID()")
		Else
			res = SQLSelectSingleResult(SQL, "SELECT last_insert_rowid()")
		End If
	Catch
		Log(LastException)
		res = -99999999
	End Try
	Return res
End Sub

Sub SQLUpdate(SQL As SQL, Query As String) As Int 'ignore
	Dim res As Int
	Try
		SQL.ExecNonQuery(Query)
		res = 0
	Catch
		Log(LastException)
		res = -99999999
	End Try
	Return res
End Sub

Sub SQLDelete(SQL As SQL, Query As String) As Int 'ignore
	Dim res As Int
	Try
		SQL.ExecNonQuery(Query)
		res = 0
	Catch
		Log(LastException)
		res = -99999999
	End Try
	Return res
End Sub

Sub SQLSelectSingleResult(SQL As SQL, Query As String) As String 'ignore
	Dim res As String
	Try
		res = SQL.ExecQuerySingleResult(Query)
	Catch
		Log(LastException)
		res = -99999999
	End Try
	If res = Null Then
		Return "0"
	End If
	Return res
End Sub

Sub SQLInsertOrUpdate(SQL As SQL, SelectQuery As String, InsertQuery As String, UpdateQuery As String) As Int 'ignore
	Dim foundres As Int = SQLSelectSingleResult(SQL, SelectQuery)
	If foundres = -99999999 Then
		Return foundres
	End If
	Dim res As Int
	If foundres = 0 Then
		res = SQLInsert(SQL, InsertQuery)
	Else
		res = SQLUpdate(SQL, UpdateQuery)
		If res = 0 Then
			res = foundres
		End If
	End If
	Return res
End Sub

Sub BuildSelectQuery(TableName As String, Fields As Map, WhereFields As Map, OrderFields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("SELECT ")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetKeyAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col)
	Next
	sb.Append(" FROM " & TableName)
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			Dim value As String = WhereFields.GetValueAt(i)
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & value)
		Next
	End If
	If OrderFields.IsInitialized Then
		sb.Append(" ORDER BY ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = OrderFields.GetKeyAt(i)
			If i > 0 Then
				sb.Append(", ")
			End If
			sb.Append(col)
		Next
	End If
	
	Return sb.ToString
End Sub

Sub BuildInsertQuery(TableName As String, Fields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("INSERT INTO " & TableName & "(")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetKeyAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col)
	Next
	sb.Append(") VALUES (")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetValueAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(""""&col&"""")
	Next
	sb.Append(")")
	Return sb.ToString
End Sub

Sub BuildDeleteQuery(TableName As String, WhereFields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("DELETE FROM " & TableName)
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			Dim value As String = WhereFields.GetValueAt(i)
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & value)
		Next
	End If
	Return sb.ToString
End Sub

Sub BuildUpdateQuery(TableName As String, Fields As Map, WhereFields As Map) As String 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE " & TableName & " SET ")
	For i = 0 To Fields.Size - 1
		Dim col As String = Fields.GetKeyAt(i)
		Dim value As String = Fields.GetValueAt(i)
		If i > 0 Then
			sb.Append(", ")
		End If
		sb.Append(col & "=" & value)
	Next
	If WhereFields.IsInitialized Then
		sb.Append(" WHERE ")
		For i = 0 To WhereFields.Size - 1
			Dim col As String = WhereFields.GetKeyAt(i)
			Dim value As String = WhereFields.GetValueAt(i)
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(col & "=" & value)
		Next
	End If
	Return sb.ToString
End Sub

Sub SetQuotes(str As String) As String 'ignore
	str = ABMShared.ReplaceAll(str, "'", "''")
	Return "'" & str & "'"
End Sub