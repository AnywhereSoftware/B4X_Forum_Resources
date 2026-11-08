B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.2
@EndOfDesignText@

Sub Process_Globals
	Type TColInfo (CID As Int,Name As String, _
		Typ As String, NotNull As Boolean, PK As Boolean)
	
	Private XUI As XUI
	
	Public SQLite As SQL
	Public SQLCipher As SQLCipher
	
	Private rs As ResultSet
	Public DatabaseName As String
	Private TableName As String
	Public TableInfo As List
	Public  ColumnInfo As Map
	Public ColumnValues As Map
	Private WhereValues As Map
	Private InsertList As List	
	
	Private ColInfo As TColInfo
End Sub

#region BASIC
' Initialize SQL or SQLCipheripher
' Prior open Database in starter module
Public Sub Initialize(DBName As String, TName As String, _
		Cipher As Boolean, PW As String) As Boolean
	Try
		' variables
		ColumnInfo.Initialize
		ColumnValues.Initialize
		WhereValues.Initialize
		InsertList.Initialize
		TableInfo.Initialize
		
		TableName = TName
		DatabaseName= DBName
		
		' open database
		If openDatabase(DBName,Cipher,PW) Then
			' initialize maps & list
			If SQLite.IsInitialized Or SQLCipher.IsInitialized Then
				getColInfo
				getTableNames
			End If
		End If
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub
#end region

#region Insert update delete select
' INSERT new record by column
' set MAP ColumnValues before call
' returns true if inserted
' returns false if error
public Sub insertRecord As Boolean
	Try
		If ColumnInfo.Size>0 And ColumnValues.Size>0 Then
			' buld column names and values
			Dim counter As Int = 0
			Dim strColumns,strValues As String
			Dim colName As String
			For x = 0 To ColumnValues.Size -1
				' get col info
					Dim	ColInfo As TColInfo
					Dim colName As String = ColumnValues.GetKeyAt(x)
					For y = 0 To ColumnInfo.Size-1
						If ColumnInfo.GetKeyAt(y) = colName Then	
							ColInfo = ColumnInfo.Get(colName)
							Exit
						End If
					Next						
					' set column name
					strColumns = strColumns & ColInfo.Name
					' set column value
					If ColInfo.Typ = "TEXT" Then
						strValues = strValues & "'" & _
							ColumnValues.get(ColInfo.Name) & "'"
					Else
					strValues = strValues & "[" & ColInfo.Name & "] ="
					End If
					' set counter
					counter = counter + 1
					If counter < ColumnValues.Size Then
						strColumns=strColumns & ","
						strValues=strValues  & ","
					End If
			Next
			' insert new row
			If strColumns<>"" And strValues<>"" Then
				' build sql string
				Dim strSQL As String = _
					"INSERT INTO [" & TableName & "]" _
					& " (" & strColumns & ")" _
					& " VALUES (" & strValues & ")"
				If SQLite.IsInitialized Then
					SQLite.ExecNonQuery(strSQL)
				End If
				If SQLCipher.IsInitialized Then
					SQLCipher.ExecNonQuery(strSQL)
				End If
			End If
			rs = SQLCipher.ExecQuery("SELECT * FROM TEST")
			Do While rs.NextRow
				Log(rs.GetString("ColText"))
				Log(rs.Getint("ColInteger"))
			Loop
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' Update record with changed values
' set MAP ColumnValues before call
' returns true if updated
' returns false if error
public Sub UpdateRecord(WhereValue As String) As Boolean
	Try
		If ColumnInfo.Size>0 And ColumnValues.Size>0 And WhereValue <> "" Then
			' buld column names and values
			Dim counter As Int = 0
			Dim strColumns,strValues As String
			Dim colName As String
			For x = 0 To ColumnValues.Size -1
				' get col info
					Dim	ColInfo As TColInfo
					Dim colName As String = ColumnValues.GetKeyAt(x)
					For y = 0 To ColumnInfo.Size-1
						If ColumnInfo.GetKeyAt(y) = colName Then	
							ColInfo = ColumnInfo.Get(colName)
							Exit
						End If
					Next						
					' set column name
					strColumns = strColumns & "[" & ColInfo.Name & "] ="
					' set column value
					If ColInfo.Typ = "TEXT" Then
						strColumns = strColumns & "'" & _
							ColumnValues.get(ColInfo.Name) & "'"
					Else
						strColumns = strColumns & ColumnValues.Get(ColInfo.Name)
					End If
					' set counter
					counter = counter + 1
					If counter < ColumnValues.Size Then
						strColumns=strColumns & ","
						strValues=strValues  & ","
					End If
			Next
	
			' update row
			If strColumns<>"" Then
				' build sql string
				Dim strSQL As String = _
					"UPDATE [" & TableName & "] SET " _
					& strColumns _
					& " WHERE " & WhereValue
				If SQLite.IsInitialized Then
					SQLite.ExecNonQuery(strSQL)
				End If
				If SQLCipher.IsInitialized Then
					SQLCipher.ExecNonQuery(strSQL)
				End If

				Return True
			Else
				Return False
			End If
		Else
			Return False
		End If
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' If record exists do Update if not do Insert
' set MAP ColumnValues beforedcall
' returns true if added or updated
' returns false if error
public Sub saveRecord(WhereValue As String) As Boolean
	Try
		If WhereValue <> "" Then
			If existsRecord(WhereValue) Then
				If ColumnValues.Size > 0 Then
					Return UpdateRecord(WhereValue)
				Else
					Return False
				End If
			Else
				If ColumnValues.Size > 0 Then
					Return insertRecord
				Else
					Return False
				End If
			End If
		End If
		Return False
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' delete record
' returns true if deleted
' returns false if error
public Sub deleteRecord(WhereValue As String) As Boolean
	Try
		If WhereValue <> "" Then
			Dim strSQL As String
			strSQL = "DELETE FROM [" & TableName & "] WHERE " & WhereValue
			If SQLite.IsInitialized Then
				SQLite.ExecNonQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				SQLCipher.ExecNonQuery(strSQL)
			End If
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' select a record
' using LIKE use pattern ? or %
' returns result set
' returns Null if error
public Sub selectRecord(WhatValue As String,WhereValue As String) As ResultSet
	Try
		If WhatValue <> "" And WhereValue <> "" Then
			Dim strSQL As String
			strSQL = "SELECT " & WhatValue & " FROM [" & TableName & "] WHERE " & WhereValue
			Log(strSQL)
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuery(strSQL)
			End If

			Return Null
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

' select distinct record
' returns result set
' returns Null if error
public Sub selectRecordDistinct(WhatValue As String,WhereValue As String) As ResultSet
	Try
		If WhatValue<>"" And WhereValue <> "" Then
			Dim strSQL As String
			strSQL = "SELECT DISTINCT" & WhatValue & _
				 " FROM [" & TableName & "] WHERE " & WhereValue
			Log(strSQL)
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuery(strSQL)
			End If
			Return Null
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub
#end region

#region select special
' check if record exists
' for WhereValue use PK Column
' returns 1 if found
' returns 0 if not found
' returns -1 if error
public Sub existsRecord(WhereValue As String) As Int
	Try
		If WhereValue <> "" Then
			Dim strSQL As String
			Dim rs As ResultSet
			strSQL = "SELECT rowid FROM [" & TableName & "] WHERE " & WhereValue
			Log(strSQL)
			If SQLite.IsInitialized Then
				rs = SQLite.ExecQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				rs = SQLCipher.ExecQuery(strSQL)
			End If

			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

' select records between 2 dates
' returns resultset
' returns Null if error
Public Sub dateDifference( _
		ColName As String, _
		startDate As String, endDate As String, _
		nDays As Int,nMonth As Int, nyears As Int) As ResultSet
	Try
		Dim strSQL As String
	If ColName <> "" Then
			If nDays=0 And nMonth=0 And nyears=0 Then
				strSQL= "SELECT *,rowid FROM [" & TableName & "]" _
					 & " WHERE [" & ColName & "] BETWEEN " _
					 & "'" & startDate & "' AND '" & endDate & "'"
			else if nDays <> 0 Then
				strSQL = "SELECT *, rowid FROM [" & TableName & "]" _
					& " WHERE [" & ColName & "]" _
					& " >=  date('" & startDate & "','" & nDays & " days')"
			else if nMonth <> 0 Then
				strSQL = "SELECT *, rowid FROM [" & TableName & "]" _
					& " WHERE [" & ColName & "] " _
					& " >=  date('" & startDate & "','" & nMonth & " month')"
			else if nyears <> 0 Then
				strSQL = "SELECT *, rowid FROM [" & TableName & "]" _
					& " WHERE [" & ColName & "]" _
					& " >=  date('" & startDate & "','" & nyears & " years')"
			End If
			Log(strSQL)
			If SQLite.IsInitialized Then
				rs = SQLite.ExecQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				rs = SQLCipher.ExecQuery(strSQL)
			End If
			Log(rs.RowCount)
			Return rs
		End If
		Return Null
	Catch
		Log(LastException)
		rs.close
		Return Null
	End Try
End Sub

' select records from/til startdate
' Parameter: Operand  like >=
' returns resultset
' returns Null if error
Public Sub dateFromTo( _
		ColName As String, _
		startDate As String, _
		Operand As String) As ResultSet
	Try
		Dim strSQL As String
		If ColName <> "" And Operand <>"" Then
			strSQL= "SELECT *,rowid FROM [" & TableName & "]" _
				 & " WHERE [" & ColName & "] " _
				 & Operand & " date('" & startDate & "')"
			Log(strSQL)
			If SQLite.IsInitialized Then
				rs = SQLite.ExecQuery(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				rs = SQLCipher.ExecQuery(strSQL)
			End If
			Return rs
		End If
		Return Null
	Catch
		Log(LastException)
		rs.close
		Return Null
	End Try
End Sub

' select max value
' returns value or -1 if error
public Sub maxValue(ColumnName As String, WhereValue As String ) As Object
	Try
		If ColumnName <> "" Then
			Dim strSQL As String
			strSQL = "SELECT max([" & ColumnName & "]) FROM [" & TableName & "]"
			If WhereValue <> "" Then
				strSQL=strSQL & " WHERE " & WhereValue
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuerySingleResult(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuerySingleResult(strSQL)
			End If
			Log(strSQL)
			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

' select min value
' returns value or -1 if error
public Sub minValue(ColumnName As String, WhereValue As String ) As Object
	Try
		If ColumnName <> "" Then
			Dim strSQL As String
			strSQL = "SELECT min([" & ColumnName & "]) FROM [" & TableName & "]"
			If WhereValue <> "" Then
				strSQL=strSQL & " WHERE " & WhereValue
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuerySingleResult(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuerySingleResult(strSQL)
			End If
			Log(strSQL)
			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

' select sum value
' returns value or -1 if error
public Sub sumValue(ColumnName As String, WhereValue As String ) As Object
	Try
		If ColumnName <> "" Then
			Dim strSQL As String
			strSQL = "SELECT sum([" & ColumnName & "]) FROM [" & TableName & "]"
			If WhereValue <> "" Then
				strSQL=strSQL & " WHERE " & WhereValue
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuerySingleResult(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuerySingleResult(strSQL)
			End If
			Log(strSQL)
			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

' select average value
' returns value or -1 if error
public Sub averageValue(ColumnName As String, WhereValue As String ) As Object
	Try
		If ColumnName <> "" Then
			Dim strSQL As String
			strSQL = "SELECT avg([" & ColumnName & "]) FROM [" & TableName & "]"
			If WhereValue <> "" Then
				strSQL=strSQL & " WHERE " & WhereValue
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuerySingleResult(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuerySingleResult(strSQL)
			End If
			Log(strSQL)
			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub

' select count value
' returns value or -1 if error
public Sub countValue(ColumnName As String, WhereValue As String ) As Object
	Try
		If ColumnName <> "" Then
			Dim strSQL As String
			strSQL = "SELECT count([" & ColumnName & "]) FROM [" & TableName & "]"
			If WhereValue <> "" Then
				strSQL=strSQL & " WHERE " & WhereValue
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuerySingleResult(strSQL)
			End If
			If SQLCipher.IsInitialized Then
				Return SQLCipher.ExecQuerySingleResult(strSQL)
			End If
			Log(strSQL)
			Return rs.rowcount
		Else
			Return -1
		End If
	Catch
		Log(LastException)
		Return -1
	End Try
End Sub
#end region

#region special
' check Null Value
' returns "" if NUll
' returns orgigin value if not null
public Sub checkNull(Value As Object) As Object
	If Value = Null Then
		Return ""
	Else
		Return Value
	End If
End Sub

' set Dtabase compact mode
' Action =  NONE, AUTO, INC FULL
public Sub setDBcompactMode(Action As String) As Boolean
	Try
		Dim strSQL As String
		Select Action.ToLowerCase
			Case "none"
				strSQL = "PRAGMA auto_vacuum = 0"
			Case "inc"
				strSQL = "PRAGMA auto_vacuum = 1"
			Case "full"
				strSQL = "PRAGMA auto_vacuum = 2"
		End Select
		If SQLite <> Null Then
			If SQLite.IsInitialized Then
				SQLite.ExecNonQuery(strSQL)
			End If
		End If
		If SQLCipher <> Null Then
			If SQLCipher.IsInitialized Then
				SQLCipher.ExecNonQuery(strSQL)
			End If
		End If
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' compact Database
public Sub compactDB As Boolean
	Try
		Dim strSQL As String = "VACUUM"
		If SQLite <> Null Then
			If SQLite.IsInitialized Then
				SQLite.ExecNonQuery(strSQL)
			End If
		End If
		If SQLCipher <> Null Then
			If SQLCipher.IsInitialized Then
				SQLCipher.ExecNonQuery(strSQL)
			End If
		End If
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' get column info
' set variable TableName before call
' returns values in MAP ColumnInfo
' Key=COlumnName, Value=Col Info as type TColInfo
public Sub getColInfo
	Try
		' initialize maps & list
		ColumnInfo.Initialize
		ColumnValues.Initialize
		' set values to variables
		' create SQL string
		Dim strSql As String= "PRAGMA table_info(" & TableName & ")"
		' load result set
		If SQLite.isinitialized  And TableName <> "" Then
			rs = SQLite.ExecQuery(strSql)
		else If SQLCipher.IsInitialized And TableName <> "" Then
			rs = SQLCipher.ExecQuery(strSql)
		End If
		' load col info into map
		Do While rs.NextRow
			Dim ColInfo As TColInfo
			ColInfo.CID = rs.Getstring("cid")
			ColInfo.Name = rs.GetString("name")
			ColInfo.Typ = rs.GetString("type")
			If rs.Getint("notnull") = 1 Then
				ColInfo.NotNull = True
			Else
				ColInfo.NotNull = False
			End If
			If rs.Getint("pk") = 1 Then
				ColInfo.PK = True
			Else
				ColInfo.PK = False
			End If
			ColumnInfo.Put(ColInfo.Name,ColInfo)
		Loop
		rs.close
	Catch
		Log(LastException)
	End Try
End Sub

' get table names
' returns values in MAP TableInfo
' Key=TableName, Value=Infos as Type TableInfo
public Sub getTableNames
	Try
		' initialize maps & list
		TableInfo.Initialize
		' set values to variables
		' create SQL string
		Dim strSql As String = " SELECT name FROM sqlite_master WHERE type='table'"
		' load result set
		If SQLite.isinitialized Then
			rs = SQLite.ExecQuery(strSql)
		else If SQLCipher.IsInitialized Then
			rs = SQLCipher.ExecQuery(strSql)
		End If
		' load table name into list
		TableInfo.Clear
		Do While rs.NextRow
			TableInfo.Add(rs.GetString("name"))
		Loop
		rs.close
	Catch
		Log(LastException)
	End Try
End Sub

' open database
public Sub openDatabase(DBName As String, Cipher As Boolean, PW As String) As Boolean
	Try
		SQLCipher.Close
		SQLite.Close
		
		' copy database file to writable folder
		File.Copy(File.DirAssets,DBName,File.DirInternal,DBName)
	
		' open Database with the passwort, leave last parameter empty
		' we do not want to create an new db.
		If File.Exists(File.DirInternal,DBName) Then
			If Cipher And PW <>"" Then
				SQLCipher.Initialize(File.dirinternal,DBName,False,PW,"")
				Log("DB Cipher is open: " & SQLCipher.IsInitialized)
				Return SQLCipher.IsInitialized
			Else
				SQLite.Initialize(File.dirinternal,DBName,False)
				Log("DB is SQLite open: " & SQLite.IsInitialized)
				Return SQLite.IsInitialized
			End If
		End If
		Return False
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' close database
public Sub closeDatabase(Cipher As Boolean) As Boolean
	Try
		If Cipher Then
			SQLCipher.close
			Return True
		Else
			SQLite.close
			Return True
			End If
		Return False
	Catch
		Log(LastException)
		Return False
	End Try
End Sub
#end region
