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
	Private DatabaseType As Int
	Public DBOK As Int = 0
	Public DBERROR As Int = -1
	Public DBNORESULTS As Int = -2
End Sub

Sub InitializeSQLite(Dir As String, fileName As String, createIfNeeded As Boolean)
	Log("init sqlite")
	SQLite.InitializeSQLite(Dir, fileName, createIfNeeded)
	UsePool = False
End Sub

Sub InitializeMySQLold(jdbcUrl As String ,login As String, password As String, poolSize As Int)
	Log("init mysql")
	UsePool = True
	Try
       pool.Initialize("com.mysql.jdbc.Driver",  jdbcUrl, login, password)
    Catch
       Log("Last Pool Init Except: "&LastException.Message)
    End Try

   ' change pool size...
    Dim jo As JavaObject = pool
    jo.RunMethod("setMaxPoolSize", Array(poolSize))	
End Sub

Sub GetSQL() As SQL
'	If UsePool Then
		Return pool.GetConnection		
'	Else
'		Return SQLite
'	End If	
End Sub

Sub CloseSQL(mySQL As SQL)
'	If UsePool Then
		mySQL.Close
	'	Log(" Close SQL batch: "&DateTime.Now)

'	End If	
End Sub

Public Sub ShowTimeRound(ms As Long) As String
 
	Dim seconds, minutes, minute, hours As Double
	
	seconds = Round(ms / 1000)
	minute = (seconds / 60) Mod 60
	
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600)
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	'Log	("Before time: "&  NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0)&" min: "&minute )

	
	Select True
		Case minute >= 1 And minute < 7.49
			minutes = 0
			 
		Case minute >= 7.5 And minute < 15.0
			minutes = 15.0
			
		Case minute >= 15.0 And minute < 22.5
			minutes = 15.0

		Case minute >= 22.5 And minute < 30.0
			minutes = 30.0

		Case minute >= 30.0 And minute < 37.5
			minutes = 30.0
			 
		Case minute >= 37.5 And minute < 45.0
			minutes = 45.0
			 
		Case minute >= 45.0 And minute < 52.5
			minutes = 45.0
			 
		Case minute >= 52.5 And minute < 59.9999
			minutes = 0.0
			hours = hours + 1
	End Select

	'Log	("After time:"&  NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) )
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) '& ":" & NumberFormat(seconds, 2, 0)
 
End Sub


Public Sub ShowTimeFormat(ms As Long) As String
 
	Dim seconds, minutes, hours As Double
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600)
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) '& ":" & NumberFormat(seconds, 2, 0)
 
End Sub


'Sub CreateTablesIfNeeded()
'	Dim SQL As SQL = GetSQL
'	Dim SQL_str As String
'	
'	' Create the tables
'	If UsePool Then
'		SQL_str = "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'abmfeedback' And table_name = 'cases';"
'		If SQLSelectSingleResult(SQL, SQL_str) = 0 Then
'			SQL_str = "CREATE TABLE Cases (CaseID INT NOT NULL AUTO_INCREMENT, CaseNumber VARCHAR(100), CaseType INT, CaseSummary VARCHAR(255), CaseDescription TEXT , CaseStatus INT, CaseUserID INT, CaseCreationDate VARCHAR(50), CaseFixedVersion VARCHAR(10), PRIMARY KEY (CaseID))"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE CasePoints(CasePID INT NOT NULL AUTO_INCREMENT, CasePCaseID INT, CasePUserID INT, CasePPoints INT, PRIMARY KEY (CasePID))"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE CaseAttachments(CaseAID INT NOT NULL AUTO_INCREMENT, CaseACaseID INT, CaseAType INT, CaseAValue VARCHAR(255), PRIMARY KEY (CaseAID))"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE CaseNotes (CaseNID INT NOT NULL AUTO_INCREMENT, CaseNCaseID INT, CaseNUserID INT, CaseNDescription TEXT, CaseNCreationDate VARCHAR(50), PRIMARY KEY (CaseNID))"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE Users (UserID INT NOT NULL AUTO_INCREMENT, UserName VARCHAR(255), UserLogin VARCHAR(255), UserPassword VARCHAR(100), UserType INT, UserActive INT, PRIMARY KEY (UserID))"
'			SQLCreate(SQL, SQL_str)
'			
'			' create the administrator, set your password!
'			SQL_str = "INSERT INTO Users (UserName, UserLogin, UserPassword, UserType, UserActive) VALUES ('Admin', 'Admin', 'Admin', 1, 0)"
'			SQLCreate(SQL, SQL_str)
'				
'		End If		
'	Else			
'		SQL_str = "SELECT count(name) FROM sqlite_master WHERE type='table' AND name='Cases'"
'		If SQLSelectSingleResult(SQL, SQL_str) = 0 Then
'			SQL_str = "PRAGMA journal_mode = wal" 'best mode for multithreaded apps.	
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE IF NOT EXISTS [Cases] ([CaseID] INTEGER PRIMARY KEY, [CaseNumber] TEXT, [CaseType] INTEGER, [CaseSummary] TEXT, [CaseDescription] TEXT, [CaseStatus] INTEGER, [CaseUserID] INTEGER, [CaseCreationDate] TEXT, [CaseFixedVersion] TEXT)"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE IF NOT EXISTS [CasePoints]([CasePID] INTEGER PRIMARY KEY, [CasePCaseID] INTEGER, [CasePUserID] INTEGER, [CasePPoints] INTEGER)"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE IF NOT EXISTS [CaseAttachments]([CaseAID] INTEGER PRIMARY KEY, [CaseACaseID] INTEGER, [CaseAType] INTEGER, [CaseAValue] TEXT)"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE IF NOT EXISTS [CaseNotes]([CaseNID] INTEGER PRIMARY KEY, [CaseNCaseID] INTEGER, [CaseNUserID] INTEGER, [CaseNDescription] TEXT, [CaseNCreationDate] TEXT)"
'			SQLCreate(SQL, SQL_str)
'			
'			SQL_str = "CREATE TABLE IF NOT EXISTS [Users] ([UserID] INTEGER PRIMARY KEY, [UserName] TEXT, [UserLogin] TEXT, [UserPassword] TEXT, [UserType] INTEGER, [UserActive] INTEGER)"
'			SQLCreate(SQL, SQL_str)
'			
'			' create the administrator, set your password!
'			SQL_str = "INSERT INTO [Users] (UserID, UserName, UserLogin, UserPassword, UserType, UserActive) VALUES (null, 'Admin', 'Admin', 'Admin', 1, 0)"
'			SQLCreate(SQL, SQL_str)
'		End If
'	End If	
'	CloseSQL(SQL)
'End Sub


Sub SQLSelect2(SQL As SQL, Query As String, Args As List) As List
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


Sub SQLSelect(SQL As SQL, Query As String) As List
	Dim l As List
	l.Initialize
	Dim cur As ResultSet
	Try
		cur = SQL.ExecQuery(Query)
	Catch
		Log(LastException)		
		Return l
	End Try	
	Do While cur.NextRow
		Dim res As Map
		res.Initialize
		For i = 0 To cur.ColumnCount - 1
			Try
				Dim mres As String
				mres = cur.GetString2(i)
			    res.Put(cur.GetColumnName(i).ToLowerCase, mres)
			Catch
				Log(" SQL Select error: "&cur.GetColumnName(i).ToLowerCase&" "&LastException.Message)
				Continue
			End Try	   
		Next
		l.Add(res)
	Loop
	cur.Close
'	Log(" SQLSelect query: "&Query)				
	
	Return l			
End Sub

Sub SQLCreate(SQL As SQL, Query As String) As Int
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

Sub SQLInsert(SQL As SQL, Query As String) As Int
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

Sub SQLUpdate(SQL As SQL, Query As String) As Int
	Dim res As Int
	Try
		SQL.ExecNonQuery(Query)				
		res = 0
	Catch
		Log(" UPD ERR: "&LastException)		
		res = -99999999
	End Try			
	Return res
End Sub

Sub SQLDelete(SQL As SQL, Query As String) As Int
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

Sub SQLSelectSingleResult(SQL As SQL, Query As String) As String
	Dim res As String
	Try
		res = SQL.ExecQuerySingleResult(  Query)		
	Catch
		Log(LastException)
		res = -99999999
	End Try	
	If res = Null Then
		Return "0"		
	End If
	Return res
End Sub

Sub SQLInsertOrUpdate(SQL As SQL, SelectQuery As String, InsertQuery As String, UpdateQuery As String) As Int
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

Sub BuildSelectQuery(TableName As String, Fields As Map, WhereFields As Map, OrderFields As Map) As String
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

Sub BuildInsertQuery(TableName As String, Fields As Map) As String
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
		sb.Append(col)
	Next
	sb.Append(")")

	Log(" Select qry: "&sb.ToString)
	Return sb.ToString
End Sub

Sub BuildDeleteQuery(TableName As String, WhereFields As Map) As String
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

Sub BuildUpdateQuery(TableName As String, Fields As Map, WhereFields As Map) As String
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
			Log("  where: "&col & "=" & value)
			
		Next
	End If	
	Log(" Update qry: "&sb.ToString)
	
	Return sb.ToString
End Sub

Sub SetQuotes(str As String) As String
	str = ABMShared.ReplaceAll(str, "'", "''")
	Return "'" & str & "'"	
End Sub


'***************************************************************************************************


'Sub InitializeSQLite2(Dir As String, fileName As String, createIfNeeded As Boolean) 'ignore
'	SQLite.InitializeSQLite2(Dir, fileName, createIfNeeded)
'	DatabaseType = 0
'End Sub

Sub InitializeMySQL(jdbcUrl As String ,login As String, password As String, poolSize As Int) 'ignore
	DatabaseType = 1
	UsePool = True
	Try
		pool.Initialize("com.mysql.jdbc.Driver", jdbcUrl, login, password)
	Catch
		Log("Last Pool Init Except: " & LastException.Message)
	End Try

	' change pool size...
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(poolSize))
End Sub

Sub InitializeMSSQL(jdbcUrl As String ,login As String, password As String, poolSize As Int) 'ignore
	DatabaseType = 2
	Try
		pool.Initialize("net.sourceforge.jtds.jdbc.Driver", jdbcUrl, login, password)
	Catch
		Log("Last Pool Init Except: " & LastException.Message)
	End Try

	' change pool size...
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(poolSize))
End Sub

Sub GetSQL2() As SQL
	If DatabaseType = 0 Then
		Return SQLite
	Else
		Return pool.GetConnection
	End If
End Sub

Sub CloseSQL2(mySQL As SQL)
	If DatabaseType <> 0 Then
		mySQL.Close
	End If
End Sub

Sub ABMGenSQLSelect(SQL As SQL, Query As String, Args As List) As List
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

Sub ABMGenSQLDelete(SQL As SQL, Query As String, Args As List) As Int
	If Main.isdemo Then
	   Return DBERROR	
	End If
	
	Dim res As Int
	Try
		SQL.ExecNonQuery2(Query, Args)
		res = DBOK
	Catch
		Log(LastException)
		res = DBERROR
	End Try
	Return res
End Sub

Sub ABMGenSQLInsert(SQL As SQL, Query As String, Args As List) As Int
	Dim res As Int
	Try
	'	Log(" sql insert q: "&Query)
	'	Log(" sql insert list: "&Args)
		
		Select Case DatabaseType
		Case 0
			
			SQL.ExecNonQuery2(Query,  Args)
			res	= ABMGenSQLSelectSingleResult(SQL, "SELECT last_insert_rowid()", Null)
		Case 1
			SQL.ExecNonQuery2(Query, Args)
			res = ABMGenSQLSelectSingleResult(SQL, "SELECT LAST_INSERT_ID()", Null)
		Case 2
		'	Dim  ABSQL As ABSQLExt
		'	res = ABSQL.ExecNonQuery3(SQL, Query, Args)
		End Select
	Catch
		Log("Last Insert error (edit): "&LastException)
		res = DBERROR
	End Try
	Return res
End Sub

Sub ABMGenSQLUpdate(SQL As SQL, Query As String, Args As List) As Int
	Dim res As Int
	Try
		SQL.ExecNonQuery2(Query, Args)
		res = DBOK
	Catch
		Log("UPD err: "&LastException.Message)
		res = DBERROR
	End Try
	Return res
End Sub

Sub ABMGenSQLSelectSingleResult(SQL As SQL, Query As String, Args As List) As String
	Dim res As String
	Try
		res = SQL.ExecQuerySingleResult2( Query, Args)
	Catch
		Log("Single result err: "&LastException.Message)
		res = DBERROR
	End Try
	If res = Null Then
		res = DBNORESULTS
	End If
	Return res
End Sub
















