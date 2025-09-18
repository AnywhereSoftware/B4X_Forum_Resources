B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=9.71
@EndOfDesignText@
' Mini Object-Relational Mapper (ORM) class
' Version 3.50
Sub Class_Globals
	Private DBSQL 					As SQL
	Private DBID 					As Int
	Private DBBatch 				As List
	Private DBColumns 				As List
	Private DBColumnsType			As Map
	Private DBObject 				As String
	Private DBTable 				As String
	Private DBView					As String
	Private DBStatement 			As String
	Private DBPrimaryKey 			As String
	Private DBUniqueKey 			As String
	Private DBForeignKey 			As String
	Private DBConstraint 			As String
	Private DBGroupBy 				As String
	Private DBOrderBy 				As String
	Private DBLimit 				As String
	Private DBCondition 			As String
	Private DBHaving 				As String
	Private mType 					As String
	Private mError 					As String
	Private mJournalMode 			As String = "DELETE" 'ignore
	Private StrDefaultUserId 		As String = "1"
	Private DBParameters() 			As Object
	Private BlnShowExtraLogs 		As Boolean
	Private BlnUseTimestamps 		As Boolean ' may need to disable when working on view
	Private BlnAutoIncrement 		As Boolean
	Private BlnUseDataAuditUserId 	As Boolean
	Private BlnUpdateModifiedDate 	As Boolean
	Private BlnQueryAddToBatch 		As Boolean
	Private BlnQueryExecute 		As Boolean
	#If B4J
	Private BlnUseTimestampsAsTicks As Boolean
	Private DateTimeMethods 		As Map = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
	#End If
	Public BLOB 					As String
	Public INTEGER 					As String
	Public BIG_INT 					As String
	Public DECIMAL 					As String
	Public VARCHAR 					As String
	Public DATE_TIME 				As String ' datetime
	Public TIMESTAMP 				As String
	Public TEXT 					As String
	Public ORMTable 				As ORMTable
	Public ORMResult 				As ORMResult
	Public Const MYSQL 				As String = "MYSQL"
	Public Const SQLITE 			As String = "SQLITE"
	Public Const MARIADB 			As String = "MARIADB"
	Private Const COLOR_RED 		As Int = -65536		'ignore
	Private Const COLOR_GREEN 		As Int = -16711936	'ignore
	Private Const COLOR_BLUE 		As Int = -16776961	'ignore
	Private Const COLOR_MAGENTA 	As Int = -65281		'ignore
	Type ORMResult (Tag As Object, Columns As Map, Rows As List)
	Type ORMFilter (Column As String, Operator As String, Value As String)
	Type ORMJoin (Table2 As String, OnConditions As String, Mode As String)
	Type ORMTable (ResultSet As ResultSet, Columns As List, Rows As List, Results As List, Results2 As List, First As Map, First2 As Map, Last As Map, RowCount As Int) ' Columns = list of keys, Rows = list of values, Results = list of maps, Results2 = Results + map ("__order": ["column1", "column2", "column3"])
	Type ORMColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, AllowNull As Boolean, Unique As Boolean, AutoIncrement As Boolean) ' B4i dislike word Nullable
End Sub

'Initialize MiniORM
'<code>DB.Initialize("sqlite", Null)</code>
Public Sub Initialize (mDBType As String, mSQL As SQL)
	setDBType(mDBType)
	setSQL(mSQL)
	DBBatch.Initialize
	BlnAutoIncrement = True
End Sub

Public Sub setDBType (mDBType As String)
	mType = mDBType.ToUpperCase
	Select mType
		Case MYSQL, MARIADB
			BLOB = "mediumblob"
			INTEGER = "int"
			BIG_INT = "bigint"
			DECIMAL = "decimal"
			VARCHAR = "varchar"
			TEXT = "text"
			DATE_TIME = "datetime"
			TIMESTAMP = "timestamp"
		Case SQLITE
			BLOB = "BLOB"
			INTEGER = "INTEGER"
			BIG_INT = "INTEGER"
			DECIMAL = "NUMERIC"
			VARCHAR = "TEXT"
			TEXT = "TEXT"
			DATE_TIME = "TEXT"
			TIMESTAMP = "TEXT"
	End Select
End Sub

Public Sub getDBType As String
	Return mType
End Sub

Public Sub setJournalMode (Mode As String)
	mJournalMode = Mode
End Sub

Public Sub setSQL (mSQL As SQL)
	DBSQL = mSQL
End Sub

Public Sub getSQL As SQL
	Return DBSQL
End Sub

Public Sub setTable (mTable As String)
	DBTable = mTable
	DBObject = DBTable
	Reset
End Sub

Public Sub getTable As String
	Return DBTable
End Sub

Public Sub setView (mView As String)
	DBView = mView
	DBObject = DBView
	Reset
End Sub

Public Sub getView As String
	Return DBView
End Sub

Public Sub setBatch (mBatch As List)
	DBBatch = mBatch
End Sub

Public Sub getBatch As List
	Return DBBatch
End Sub

Public Sub setColumns (mColumns As List)
	DBColumns = mColumns
End Sub

Public Sub getColumns As List
	Return DBColumns
End Sub

Public Sub setColumnsType (mColumnsType As Map)
	DBColumnsType = mColumnsType
End Sub

Public Sub getColumnsType As Map
	Return DBColumnsType
End Sub

Public Sub setShowExtraLogs (Value As Boolean)
	BlnShowExtraLogs = Value
End Sub

Public Sub setUpdateModifiedDate (Value As Boolean)
	BlnUpdateModifiedDate = Value
End Sub

Public Sub setUseTimestamps (Value As Boolean)
	BlnUseTimestamps = Value
End Sub

Public Sub getUseTimestamps As Boolean
	Return BlnUseTimestamps
End Sub

#If B4J
Public Sub setUseTimestampsAsTicks (Value As Boolean)
	BlnUseTimestampsAsTicks = Value
End Sub
#End If

Public Sub setUseDataAuditUserId (Value As Boolean)
	BlnUseDataAuditUserId = Value
End Sub

Public Sub setDefaultUserId (Value As String)
	StrDefaultUserId = Value
End Sub

Public Sub setQueryAddToBatch (Value As Boolean)
	BlnQueryAddToBatch = Value
End Sub

Public Sub setQueryExecute (Value As Boolean)
	BlnQueryExecute = Value
End Sub

Public Sub setAutoIncrement (Value As Boolean)
	BlnAutoIncrement = Value
End Sub

Public Sub Close
	If mJournalMode.EqualsIgnoreCase("WAL") Then Return
	If DBSQL <> Null And DBSQL.IsInitialized Then DBSQL.Close
End Sub

Public Sub Reset
	Reset2
	ResetParameters
	DBColumns.Initialize
	SelectAllFromDBObject
End Sub

' Partially reset variables
' DBStatement is not reset
Private Sub Reset2
	DBHaving = ""
	DBOrderBy = ""
	DBCondition = ""
	DBUniqueKey = ""
	DBPrimaryKey = ""
	DBForeignKey = ""
	DBConstraint = ""
End Sub

Public Sub Results As List
	Return ORMTable.Results
End Sub

Public Sub Results2 As List
	Return ORMTable.Results2
End Sub

' Query column id
Public Sub Find (mID As Int)
	Reset
	WhereParam("id = ?", mID)
	Query
End Sub

' Query by single condition
Public Sub Find2 (mCondition As String, mValue As Object)
	Reset
	WhereParam(mCondition, mValue)
	Query
End Sub

Public Sub setError (mMessage As String)
	mError = mMessage
End Sub

Public Sub getError As String
	Return mError
End Sub

' Append new Condition WHERE id = mID
' Existing parameters are preserved
Public Sub setId (mID As Int)
	DBID = mID
	WhereParams(Array("id = ?"), Array(mID)) ' Use WhereParams to append extra condition
End Sub

Public Sub getId As Int
	Return DBID
End Sub

' Returns first queried row
Public Sub getFirst As Map
	Return ORMTable.First
End Sub

' Returns first queried row
Public Sub getFirst2 As Map
	Return ORMTable.First2
End Sub

' Returns new inserted row
Public Sub getLast As Map
	Return ORMTable.Last
End Sub

Public Sub getFirstId As Int
	Return getFirst.Get("id")
End Sub

' Returns number of rows in ORMTable
Public Sub getRowCount As Int
	Return ORMTable.RowCount
End Sub

' Returns True if ORMTable.RowCount > 0
Public Sub getFound As Boolean
	Return ORMTable.RowCount > 0
End Sub

' Clear Parameters
Private Sub ResetParameters
	DBParameters = Array As Object()
End Sub

Private Sub SelectAllFromDBObject
	DBStatement = $"SELECT * FROM ${DBObject}"$
End Sub

Private Sub SelectFromTableOrView
	Dim ac As Boolean ' Add Comma
	Dim sb As StringBuilder
	sb.Initialize
	If DBColumns.IsInitialized Then
		For Each Col In DBColumns
			If ac Then sb.Append(", ")
			sb.Append(Col)
			ac = True
		Next
	End If
	Dim Cols As String = sb.ToString
	DBStatement = $"SELECT ${IIf(Cols = "", "*", Cols)} FROM ${DBObject}"$
End Sub

Public Sub IfNull (ColumnName As String, DefaultValue As Object, AliasName As String) As String
	Return $"IFNULL(${ColumnName}, '${DefaultValue}')"$ & IIf(AliasName = "", $" AS ${ColumnName}"$, $" AS ${AliasName}"$)
End Sub

' Pass Columns and set DBStatement with SELECT FROM Table or View
Public Sub setSelect (Columns As List)
	DBColumns = Columns
	SelectFromTableOrView
End Sub

' Return map of only selected columns from a row
' Useful for filtering new row
Public Sub SelectOnly (Columns As List) As Map
	Dim NewMap As Map
	NewMap.Initialize
	If ORMTable.IsInitialized And ORMTable.First.IsInitialized Then
		For Each Col In Columns
			If ORMTable.First.ContainsKey(Col) Then
				NewMap.Put(Col, ORMTable.First.Get(Col))
			End If
		Next
	End If
	Return NewMap
End Sub

Public Sub setGroupBy (Columns As List)
	Dim sb As StringBuilder
	sb.Initialize
	For Each Column As String In Columns
		If sb.Length > 0 Then sb.Append(", ") Else sb.Append(" GROUP BY ")
		sb.Append(Column)
	Next
	DBGroupBy = sb.ToString
End Sub

Public Sub setHaving (mStatements As List)
	Dim sb As StringBuilder
	sb.Initialize
	For Each statement In mStatements
		If sb.Length > 0 Then sb.Append(" AND ") Else sb.Append(" HAVING ")
		sb.Append(statement)
	Next
	DBHaving = sb.ToString
End Sub

Public Sub setOrderBy (Col As Map)
	If Col.IsInitialized Then
		Dim sb As StringBuilder
		sb.Initialize
		For Each key As String In Col.Keys
			If sb.Length > 0 Then sb.Append(", ")
			Dim value As String = Col.Get(key)
			If value.EqualsIgnoreCase("DESC") Then
				sb.Append(key & " " & value)
			Else
				sb.Append(key)
			End If
		Next
		DBOrderBy = $" ORDER BY ${sb.ToString}"$
	End If
End Sub

Public Sub SortByLastId
	DBOrderBy = $" ORDER BY id DESC"$
End Sub

Public Sub Create
	Dim sb As StringBuilder
	sb.Initialize
	For Each col As ORMColumn In DBColumns
		sb.Append(col.ColumnName)
		sb.Append(" ")
		Select mType
			Case MYSQL, MARIADB
				Select col.ColumnType
					Case INTEGER, BIG_INT, DECIMAL, TIMESTAMP, DATE_TIME, TEXT, BLOB
						sb.Append(col.ColumnType)
					Case Else
						sb.Append(VARCHAR)
				End Select
				If col.ColumnLength.Length > 0 Then
					sb.Append("(").Append(col.ColumnLength).Append(")")
				End If
				If col.Collation.Length > 0 Then
					sb.Append(" ").Append(col.Collation)
				End If
			Case SQLITE
				sb.Append(col.ColumnType)
		End Select

		Select col.ColumnType
			Case INTEGER, BIG_INT, TIMESTAMP, DATE_TIME
				If mType = SQLITE And col.ColumnType.EqualsIgnoreCase("TEXT") Then
					If col.DefaultValue.Length > 0 Then sb.Append(" DEFAULT ").Append("'").Append(col.DefaultValue).Append("'")
				Else
					If col.DefaultValue.Length > 0 Then sb.Append(" DEFAULT ").Append(col.DefaultValue)
				End If
			Case Else
				If col.DefaultValue.Length > 0 Then sb.Append(" DEFAULT ").Append("'").Append(col.DefaultValue).Append("'")
		End Select
		If col.AllowNull Then sb.Append(" NULL") Else sb.Append(" NOT NULL")
		If col.Unique Then sb.Append(" UNIQUE")
		If col.AutoIncrement Then
			Select mType
				Case MYSQL, MARIADB
					sb.Append(" AUTO_INCREMENT")
				Case SQLITE
					sb.Append(" AUTOINCREMENT")
			End Select
		End If
		sb.Append(",").Append(CRLF)
	Next
	
	Select mType
		Case MYSQL, MARIADB
			If BlnUseDataAuditUserId Then
				sb.Append("created_by " & INTEGER & " DEFAULT " & StrDefaultUserId & ",").Append(CRLF)
				sb.Append("modified_by " & INTEGER & ",").Append(CRLF)
				sb.Append("deleted_by " & INTEGER & ",").Append(CRLF)
			End If
			If BlnUseTimestamps Then
				' Use timestamp and datetime
				sb.Append("created_date " & TIMESTAMP & " DEFAULT CURRENT_TIMESTAMP,").Append(CRLF)
				sb.Append("modified_date " & DATE_TIME & " DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,").Append(CRLF)
				sb.Append("deleted_date " & DATE_TIME & " DEFAULT NULL,")
			End If
		Case SQLITE
			If BlnUseDataAuditUserId Then
				sb.Append("created_by " & INTEGER & " DEFAULT " & StrDefaultUserId & ",").Append(CRLF)
				sb.Append("modified_by " & INTEGER & ",").Append(CRLF)
				sb.Append("deleted_by " & INTEGER & ",").Append(CRLF)
			End If
			If BlnUseTimestamps Then
				sb.Append("created_date " & VARCHAR & " DEFAULT (datetime('now')),").Append(CRLF)
				sb.Append("modified_date " & VARCHAR & ",").Append(CRLF)
				sb.Append("deleted_date " & VARCHAR & ",")
			End If
	End Select

	Dim stmt As StringBuilder
	stmt.Initialize
	Select DBObject
		Case DBTable
			stmt.Append($"CREATE TABLE ${DBTable} ("$)
		Case DBView
			stmt.Append($"CREATE VIEW ${DBView} ("$)
	End Select
	
	' id column added by default
	Dim Pk As String = "id"
	If DBPrimaryKey.Length > 0 Then
		Pk = DBPrimaryKey
	End If
	Select mType
		Case MYSQL, MARIADB
			If BlnAutoIncrement Then
				stmt.Append($"${Pk} ${INTEGER}(11) NOT NULL AUTO_INCREMENT,"$).Append(CRLF)
			Else
				stmt.Append($"${Pk} ${INTEGER}(11) NOT NULL,"$).Append(CRLF)
			End If
		Case SQLITE
			stmt.Append($"${Pk} ${INTEGER},"$).Append(CRLF)
	End Select

	' Put the columns here
	stmt.Append(sb.ToString)
	
	If DBPrimaryKey.Length > 0 Then
		stmt.Append(CRLF)
		Select mType
			Case MYSQL, MARIADB
				stmt.Append($"PRIMARY KEY(${Pk})"$)
			Case SQLITE
				If BlnAutoIncrement Then
					stmt.Append($"PRIMARY KEY(${Pk}${IIf(BlnAutoIncrement, " AUTOINCREMENT", "")})"$)
				Else
					stmt.Append($"PRIMARY KEY(${Pk})"$)
				End If
		End Select
	Else
		If BlnAutoIncrement Then
			stmt.Append(CRLF)
			stmt.Append($"PRIMARY KEY(${Pk})"$)
		Else
			stmt.Remove(stmt.Length - 1, stmt.Length) ' remove the last comma
		End If
	End If
	
	If DBUniqueKey.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(DBUniqueKey)
	End If
	
	If DBForeignKey.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(DBForeignKey)
	End If
	
	If DBConstraint.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(DBConstraint)
	End If
	
	stmt.Append(")")
	DBStatement = stmt.ToString
	If BlnQueryAddToBatch Then AddNonQueryToBatch
	If BlnQueryExecute Then Execute
End Sub

Public Sub Create2 (CreateStatement As String)
	DBStatement = CreateStatement
	ResetParameters
	If BlnQueryAddToBatch Then AddNonQueryToBatch
	If BlnQueryExecute Then Execute
End Sub

' Replace default primary key
Public Sub Primary (mKeys() As String)
	If mKeys.Length = 0 Then Return
	Dim keys As StringBuilder
	keys.Initialize
	For i = 0 To mKeys.Length - 1
		If i > 0 Then keys.Append(", ")
		keys.Append(mKeys(i))
	Next
	DBPrimaryKey = keys.ToString
End Sub

' Add foreign key
Public Sub Foreign (mKey As String, mReferences As String, mOnTable As String, mOnDelete As String, mOnUpdate As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append( $"FOREIGN KEY (${mKey}) REFERENCES ${mOnTable} (${mReferences})"$ )
	If mOnDelete.Length > 0 Then sb.Append( " ON DELETE " & mOnDelete )
	If mOnUpdate.Length > 0 Then sb.Append( " ON UPDATE " & mOnUpdate )
	DBForeignKey = sb.ToString
End Sub

' Add unique key
' mKey: Column name
' Optional: mAlias
Public Sub Unique (mKey As String, mAlias As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UNIQUE KEY")
	If mAlias.Length > 0 Then sb.Append(" " & mAlias)
	sb.Append($" (${mKey})"$)
	DBUniqueKey = sb.ToString
End Sub

' Add constraint
' mKeyType: UNIQUE or PRIMARY KEY
' mKeys: Column names separated by comma
' Optional: mAlias
Public Sub Constraint (mKeyType As String, mKeys As String, mAlias As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("CONSTRAINT")
	If mAlias.Length > 0 Then sb.Append(" " & mAlias)
	sb.Append(" " & mKeyType)
	sb.Append($"(${mKeys})"$)
	DBConstraint = sb.ToString
End Sub

' Execute Non Query
Public Sub Execute
	ExecNonQuery
End Sub

' Execute Non Query with Object type parameters
Public Sub Execute2 (Parameter() As Object)
	DBParameters = Parameter
	If BlnShowExtraLogs Then LogQuery2
	Execute
End Sub

Private Sub ExecQuery As ResultSet
	If ParametersCount = 0 Then
		If BlnShowExtraLogs Then LogQuery
		Dim RS As ResultSet = DBSQL.ExecQuery(DBStatement)
	Else
		If BlnShowExtraLogs Then LogQuery2
		Dim RS As ResultSet = DBSQL.ExecQuery2(DBStatement, DBParameters)
	End If
	Return RS
End Sub

Private Sub ExecNonQuery
	If ParametersCount = 0 Then
		If BlnShowExtraLogs Then LogQuery
		DBSQL.ExecNonQuery(DBStatement)
	Else
		If BlnShowExtraLogs Then LogQuery2
		DBSQL.ExecNonQuery2(DBStatement, DBParameters)
	End If
End Sub

' Execute Non Query batch <code>
'Wait For (DB.ExecuteBatch) Complete (Success As Boolean)</code>
Public Sub ExecuteBatch As ResumableSub
	If BlnShowExtraLogs Then LogQuery3
	Dim SenderFilter As Object = DBSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Return Success
End Sub

Public Sub AddNonQueryToBatch
	Dim paramsize As Int = ParametersCount
	Dim Args(paramsize) As Object
	Dim i As Int
	For Each Param In DBParameters
		Args(i) = Param
		i = i + 1
	Next
	DBBatch.Add(CreateMap("DBStatement": DBStatement, "DBParameters": Args))
	DBSQL.AddNonQueryToBatch(DBStatement, Args)
	'If BlnShowExtraLogs Then LogQuery2
End Sub

' Append Parameters at the end
Public Sub AddParameters (Params() As Object)
	'DBParameters = Merge(DBParameters, Params)
	If Params.Length = 0 Then Return
	If DBParameters.Length > 0 Then
		Dim NewArray(DBParameters.Length + Params.Length) As Object
		For i = 0 To DBParameters.Length - 1
			NewArray(i) = DBParameters(i)
		Next
		For i = 0 To Params.Length - 1
			NewArray(DBParameters.Length + i) = Params(i)
		Next
		DBParameters = NewArray
	Else
		DBParameters = Params
	End If
End Sub

' Initialize Parameters
Public Sub setParameters (Params() As Object)
	DBParameters = Params
End Sub

' Example: Limit 10, 10 (second parameter is Offset)
Public Sub setLimit (Value As String)
	DBLimit = Value
End Sub

Public Sub setJoin (OJoin As ORMJoin)
	Dim JOIN As String = " JOIN "
	If OJoin.Mode <> "" Then JOIN = " " & OJoin.Mode & " "
	Append(JOIN & OJoin.Table2 & " ON " & OJoin.OnConditions)
End Sub

' Execute Query
Public Sub Query
	Try
		If DBCondition.Length > 0 Then DBStatement = DBStatement & DBCondition
		If DBGroupBy.Length > 0 Then DBStatement = DBStatement & DBGroupBy
		If DBHaving.Length > 0 Then DBStatement = DBStatement & DBHaving
		If DBOrderBy.Length > 0 Then DBStatement = DBStatement & DBOrderBy
		If DBLimit.Length > 0 Then DBStatement = DBStatement & $" LIMIT ${DBLimit}"$ ' Limit 10, 10 <-- second parameter is OFFSET
		Dim RS As ResultSet = ExecQuery
		
		ORMResult.Initialize
		ORMResult.Columns.Initialize
		ORMResult.Rows.Initialize
		ORMResult.Tag = Null 'without this the Tag properly will not be serializable.
		
		ORMTable.Initialize
		ORMTable.ResultSet = RS
		ORMTable.Columns.Initialize
		ORMTable.Rows.Initialize
		ORMTable.Results.Initialize
		ORMTable.Results2.Initialize
		
		Dim cols As Int = RS.ColumnCount
		#If B4J
		For i = 0 To cols - 1
			ORMResult.Columns.Put(RS.GetColumnName(i), i)
			ORMTable.Columns.Add(RS.GetColumnName(i))
		Next
		Dim jrs As JavaObject = RS
		Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
		Do While RS.NextRow
			Dim Row(cols) As Object ' ORMResult (array of object)
			Dim Row2 As List 		' ORMTable (list of object)
			Row2.Initialize
			For i = 0 To cols - 1
				Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
				'check whether it is a blob field
				If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
					Row(i) = RS.GetBlob2(i)
				Else if ct = 2 Or ct = 3 Then
					Row(i) = RS.GetDouble2(i)
				Else If DateTimeMethods.ContainsKey(ct) Then
					If BlnUseTimestampsAsTicks Then
						Dim SQLTime As JavaObject = jrs.RunMethodJO(DateTimeMethods.Get(ct), Array(i + 1))
						If SQLTime.IsInitialized Then
							Row(i) = SQLTime.RunMethod("getTime", Null)
						Else
							Row(i) = Null
						End If
					Else
						Row(i) = RS.GetString2(i) ' Do not use getObject, otherwise return different date formats for datetime and timestamps
					End If
				Else
					Row(i) = jrs.RunMethod("getObject", Array(i + 1))
				End If
				Row2.Add(Row(i))
			Next
			ORMResult.Rows.Add(Row)
			ORMTable.Rows.Add(Row2)
		Loop
		#Else
		' Experimental
		Dim First As Boolean = True
		Dim Columns As Map
		Do While RS.NextRow
			If First Then
				Columns.Initialize
			End If
			Dim Row(cols) As Object ' ORMResult (array of object)
			Dim Row2 As List 		' ORMTable (list of object)
			Row2.Initialize
			For i = 0 To cols - 1
				' Experimental
				Dim ColumnName As String = RS.GetColumnName(i)
				If DBColumnsType.IsInitialized And DBColumnsType.ContainsKey(ColumnName) Then
					Select DBColumnsType.Get(ColumnName)
						Case BLOB
							Row(i) = RS.GetBlob2(i)
						Case DECIMAL
							Row(i) = RS.GetDouble2(i)
						Case INTEGER, BIG_INT
							Row(i) = RS.GetInt2(i)
						Case Else
							Row(i) = RS.GetString2(i)
					End Select
				Else
					' Let's take a risk and make a guess
					Try
						Dim s As String = RS.GetString2(i)
						If s <> Null And IsNumber(s) Then
							If s.Contains(".") Then ' assume a decimal value
								Row(i) = RS.GetDouble2(i)
							Else
								Dim num As Long = s
								If num < -2147483648 Or num > 2147483647 Then
									Row(i) = RS.GetLong2(i)
								Else
									Row(i) = RS.GetInt2(i)
								End If
							End If
						Else
							Row(i) = s
						End If
					Catch
						' Conversion from BLOB to String in Android will fail
						Log(LastException)
						Row(i) = RS.GetBlob2(i)
					End Try
				End If
				Row2.Add(Row(i))
				If First Then
					Columns.Put(ColumnName, Row(i))
					ORMTable.Columns.Add(ColumnName)
				End If
			Next
			ORMResult.Rows.Add(Row)
			ORMTable.Rows.Add(Row2)
			First = False
		Loop
		ORMResult.Columns = Columns
		#End If

		For Each Rows As List In ORMTable.Rows
			Dim Result As Map
			Dim Result2 As Map
			Result.Initialize
			Result2.Initialize
			Result2.Put("__order", ORMTable.Columns) ' secret is here! LOL
			For i = 0 To Rows.Size - 1
				Result.Put(ORMTable.Columns.Get(i), Rows.Get(i))
				Result2.Put(ORMTable.Columns.Get(i), Rows.Get(i))
			Next
			ORMTable.Results.Add(Result)
			ORMTable.Results2.Add(Result2)
		Next
		ORMTable.RowCount = ORMTable.Rows.Size
		If ORMTable.Results.Size > 0 Then
			ORMTable.First = ORMTable.Results.Get(0)
			ORMTable.First2 = ORMTable.Results2.Get(0)
			ORMTable.Last = ORMTable.Results.Get(ORMTable.Results.Size - 1)
		End If
		'RS.Close ' test 2023-10-24
	Catch
		Log(LastException.Message)
		'LogColor("Are you missing ' = ?' in query?", COLOR_RED)
		mError = LastException
	End Try
	#If B4J
	If Initialized(RS) Then RS.Close ' 2025-03-19
	#Else
	' B4A yet support Initialized() function
	If RS <> Null Or RS.IsInitialized Then RS.Close ' 2025-04-24
	#End If
	Reset2
	ResetParameters
End Sub

Public Sub Query2 (mParams() As Object)
	setParameters(mParams)
	Query
End Sub

' Return an object without calling Query
' Note: ORMTable and ORMResults are not affected
Public Sub Scalar As Object
	If DBCondition.Length > 0 Then DBStatement = DBStatement & DBCondition
	If ParametersCount = 0 Then
		Return DBSQL.ExecQuerySingleResult(DBStatement)
	Else	
		Return DBSQL.ExecQuerySingleResult2(DBStatement, DBParameters)
	End If
End Sub

' Similar to Scalar but passing Params
Public Sub Scalar2 (mParams() As Object) As Object
	setParameters(mParams)
	Return Scalar
End Sub

Public Sub Insert
	Dim cd As Boolean ' contains created_date
	Dim sb As StringBuilder
	Dim vb As StringBuilder
	sb.Initialize
	vb.Initialize
	For Each col As String In DBColumns
		If sb.Length > 0 Then
			sb.Append(", ")
			vb.Append(", ")
		End If
		sb.Append(col)
		vb.Append("?")
		If col.EqualsIgnoreCase("created_date") Then cd = True
	Next
	' To handle varchar timestamps
	If BlnUseTimestamps And Not(cd) Then
		If sb.Length > 0 Then
			sb.Append(", ")
			vb.Append(", ")
		End If
		sb.Append("created_date")
		Select mType
			Case MYSQL, MARIADB
				vb.Append("NOW()")
			Case SQLITE
				vb.Append("DATETIME('now')")
		End Select
	End If
	DBStatement = $"INSERT INTO ${DBObject} (${sb.ToString}) VALUES (${vb.ToString})"$
	If BlnQueryAddToBatch Then AddNonQueryToBatch
	If BlnQueryExecute Then Execute
End Sub

Public Sub Insert2 (mParams() As Object)
	setParameters(mParams)
	Insert
End Sub

' Update must have at least 1 condition
Public Sub Save
	Dim BlnNew As Boolean
	If DBCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim sb As StringBuilder
		sb.Initialize
		DBStatement = $"UPDATE ${DBObject} SET "$
		For Each col As String In DBColumns
			If sb.Length > 0 Then sb.Append(", ")
			If col.EqualsIgnoreCase("modified_date") Then md = True
			If col.Contains("=") Then
				sb.Append(col)
			Else If col.EndsWith("++") Then
				col = col.Replace("++", "").Trim
				sb.Append($"${col} = ${col} + 1"$)
			Else
				sb.Append(col & " = ?")
			End If
		Next
		DBStatement = DBStatement & sb.ToString
		' To handle varchar timestamps
		If BlnUpdateModifiedDate And Not(md) Then
			Select mType
				Case MYSQL, MARIADB
					DBStatement = DBStatement & ", modified_date = NOW()"
				Case SQLITE
					DBStatement = DBStatement & ", modified_date = DATETIME('now')"
			End Select
		End If
		DBStatement = DBStatement & DBCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim sb, vb As StringBuilder
		sb.Initialize
		vb.Initialize
		For Each col As String In DBColumns
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append(col)
			vb.Append("?")
			If col.EqualsIgnoreCase("created_date") Then cd = True
		Next
		' To handle varchar timestamps
		If BlnUseTimestamps And Not(cd) Then
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append("created_date")
			Select mType
				Case MYSQL, MARIADB
					vb.Append("NOW()")
				Case SQLITE
					vb.Append("DATETIME('now')")
			End Select
		End If
		DBStatement = $"INSERT INTO ${DBObject} (${sb.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	ExecNonQuery
	If BlnNew Then
		' View does not support auto-increment id
		If DBObject = DBView Then Return
		Dim NewID As Int = getLastInsertID
		' Return new row
		Find(NewID)
	Else
		' Count numbers of ?
		Dim ParamChars As Int = CountChar("?", DBCondition)
		Dim ParamCount As Int = ParametersCount
		DBStatement = $"SELECT * FROM ${DBObject}"$
		Dim ConditionParams(ParamChars) As Object
		For i = 0 To ParamChars - 1
			ConditionParams(i) = DBParameters(ParamCount - ParamChars + i)
		Next
		DBParameters = ConditionParams
		' Return row after update
		Query
	End If
End Sub

Public Sub Save2 (mParams() As Object)
	setParameters(mParams)
	Save
End Sub

' Same as Save but return row with custom id column
Public Sub Save3 (mColumn As String)
	Dim BlnNew As Boolean
	If DBCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim sb As StringBuilder
		sb.Initialize
		DBStatement = $"UPDATE ${DBObject} SET "$
		For Each col As String In DBColumns
			If sb.Length > 0 Then sb.Append(", ")
			If col.EqualsIgnoreCase("modified_date") Then md = True
			If col.Contains("=") Then
				sb.Append(col)
			Else If col.EndsWith("++") Then
				col = col.Replace("++", "").Trim
				sb.Append($"${col} = ${col} + 1"$)
			Else
				sb.Append(col & " = ?")
			End If
		Next
		DBStatement = DBStatement & sb.ToString
		' To handle varchar timestamps
		If BlnUpdateModifiedDate And Not(md) Then
			Select mType
				Case MYSQL, MARIADB
					DBStatement = DBStatement & ", modified_date = NOW()"
				Case SQLITE
					DBStatement = DBStatement & ", modified_date = DATETIME('now')"
			End Select
		End If
		DBStatement = DBStatement & DBCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim sb, vb As StringBuilder
		sb.Initialize
		vb.Initialize
		For Each col As String In DBColumns
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append(col)
			vb.Append("?")
			If col.EqualsIgnoreCase("created_date") Then cd = True
		Next
		' To handle varchar timestamps
		If BlnUseTimestamps And Not(cd) Then
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append("created_date")
			Select mType
				Case MYSQL, MARIADB
					vb.Append("NOW()")
				Case SQLITE
					vb.Append("DATETIME('now')")
			End Select
		End If
		DBStatement = $"INSERT INTO ${DBObject} (${sb.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	ExecNonQuery
	If BlnNew Then
		' View does not support auto-increment id
		If DBObject = DBView Then Return
		Dim NewID As Int = getLastInsertID
		' Return new row
		Find2(mColumn & " = ?", NewID)
	Else
		' Count numbers of ?
		Dim ParamChars As Int = CountChar("?", DBCondition)
		Dim ParamCount As Int = ParametersCount
		DBStatement = $"SELECT * FROM ${DBObject}"$
		Dim ConditionParams(ParamChars) As Object
		For i = 0 To ParamChars - 1
			ConditionParams(i) = DBParameters(ParamCount - ParamChars + i)
		Next
		DBParameters = ConditionParams
		' Return row after update
		Query
	End If
End Sub

Public Sub getLastInsertID As Object
	Select mType
		Case MYSQL, MARIADB
			DBStatement = "SELECT LAST_INSERT_ID()"
		Case SQLITE
			DBStatement = "SELECT LAST_INSERT_ROWID()"
		Case Else
			If BlnShowExtraLogs Then Log("Unknown DBType")
			Return -1
	End Select
	If BlnShowExtraLogs Then LogQuery
	Return DBSQL.ExecQuerySingleResult(DBStatement)
End Sub

' Adding new Condition
Public Sub setWhere (mStatements As List)
	Dim sb As StringBuilder
	sb.Initialize
	For Each statement In mStatements
		If sb.Length > 0 Then sb.Append(" AND ") Else sb.Append(" WHERE ")
		sb.Append(statement)
	Next
	DBCondition = DBCondition & sb.ToString
End Sub

' Set Condition with single condition and value
Public Sub WhereParam (mCondition As String, mParam As Object)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(" WHERE ")
	sb.Append(mCondition)
	DBCondition = sb.ToString
	setParameters(Array As Object(mParam))
End Sub

' Append new Conditions and Parameters
Public Sub WhereParams (mConditions() As Object, mParams() As Object)
	Dim sb As StringBuilder
	sb.Initialize
	For Each condition As String In mConditions
		If sb.Length > 0 Then sb.Append(" AND ") Else sb.Append(" WHERE ")
		sb.Append(condition)
	Next
	DBCondition = DBCondition & sb.ToString
	AddParameters(mParams)
End Sub

Public Sub Delete
	DBStatement = $"DELETE FROM ${DBObject}"$
	If DBCondition.Length > 0 Then DBStatement = DBStatement & DBCondition
	ExecNonQuery
	DBCondition = ""
End Sub

Public Sub Destroy (ids() As Int) As ResumableSub
	If ids.Length < 1 Then Return False
	For i = 0 To ids.Length - 1
		DBStatement = $"DELETE FROM ${DBObject} WHERE id = ?"$
		If BlnShowExtraLogs Then LogQueryWithArg(ids(i))
		DBSQL.AddNonQueryToBatch(DBStatement, Array(ids(i)))
	Next
	Dim SenderFilter As Object = DBSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Return Success
End Sub

Public Sub SoftDelete
	Select mType
		Case MYSQL, MARIADB
			DBStatement = $"UPDATE ${DBObject} SET deleted_date = now()"$
		Case SQLITE
			DBStatement = $"UPDATE ${DBObject} SET deleted_date = strftime('%s000', 'now')"$
		Case Else
			If BlnShowExtraLogs Then Log("Unknown DBType")
			Return
	End Select
	If DBCondition.Length > 0 Then DBStatement = DBStatement & DBCondition
	If BlnShowExtraLogs Then LogQuery
	DBSQL.ExecNonQuery(DBStatement)
End Sub

' Tests whether the table exists (SQLite)
Public Sub TableExists (TableName As String) As Boolean
	' SQLite code extracted from DBUtils
	DBStatement = $"SELECT count(name) FROM sqlite_master WHERE type = 'table' AND name = ? COLLATE NOCASE"$
	If BlnShowExtraLogs Then LogQueryWithArg(TableName)
	Dim count As Int = DBSQL.ExecQuerySingleResult2(DBStatement, Array As String(TableName))
	Return count > 0
End Sub

' Tests whether the table exists in the given database (MySQL)
Public Sub TableExists2 (TableName As String, DatabaseName As String) As Boolean
	DBStatement = $"SELECT count(TABLE_NAME) FROM TABLES WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
	If BlnShowExtraLogs Then LogQueryWithArg(Array As String(DatabaseName, TableName))
	Dim count As Int = DBSQL.ExecQuerySingleResult2(DBStatement, Array As String(DatabaseName, TableName))
	Return count > 0
End Sub

' Tests whether the view exists (SQLite)
Public Sub ViewExists (ViewName As String) As Boolean
	Try
		DBStatement = $"SELECT COUNT(name) FROM main.sqlite_master WHERE type = 'view' AND name = ? COLLATE NOCASE"$
		If BlnShowExtraLogs Then LogQueryWithArg(ViewName)
		Dim count As Int = DBSQL.ExecQuerySingleResult2(DBStatement, Array As String(ViewName))
		Return count > 0
	Catch
		LogColor(LastException, COLOR_RED)
		mError = LastException
		Return False
	End Try
End Sub

' Tests whether the view exists in the given database (MySQL)
Public Sub ViewExists2 (ViewName As String, DatabaseName As String) As Boolean
	Try
		DBStatement = $"SELECT COUNT(TABLE_NAME) FROM VIEWS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
		If BlnShowExtraLogs Then LogQueryWithArg(Array As String(DatabaseName, ViewName))
		Dim count As Int = DBSQL.ExecQuerySingleResult2(DBStatement, Array As String(DatabaseName, ViewName))
		Return count > 0
	Catch
		LogColor(LastException, COLOR_RED)
		mError = LastException
		Return False
	End Try
End Sub

' Append to the end of SQL statement
Public Sub Append (strSQL As String) As String
	DBStatement = DBStatement & strSQL
	Return DBStatement
End Sub

' Set raw SQL statement. Call Reset first.
Public Sub setStatement (strSQL As String)
	DBStatement = strSQL
End Sub

' Return SQL statement
Public Sub getStatement As String
	Return DBStatement
End Sub

' Print current SQL statement without parameters
Public Sub LogQuery
	Log(DBStatement)
End Sub

' Print current SQL statement and parameters
Public Sub LogQuery2
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("[")
	Dim started As Boolean
	For Each Param In DBParameters
		If started Then SB.Append(", ")
		SB.Append(Param)
		started = True
	Next
	SB.Append("]")
	Log(DBStatement)
	Log(SB.ToString)
End Sub

' Print SQL statements and parameters in DBBatch
Public Sub LogQuery3
	For Each DBMap As Map In DBBatch
		Dim SB As StringBuilder
		SB.Initialize
		SB.Append("[")
		Dim started As Boolean
		Dim Params() As Object = DBMap.Get("DBParameters") 
		For Each Param In Params
			If started Then SB.Append(", ")
			SB.Append(Param)
			started = True
		Next
		SB.Append("]")
		Log(DBMap.Get("DBStatement"))
		If Params.Length > 0 Then Log(SB.ToString)
	Next
End Sub

' Print current SQL statement without parameters
Public Sub LogQueryWithArg (Arg As Object)
	Log($"${DBStatement} [${Arg}]"$)
End Sub

Public Sub Split (str As String) As String()
	Dim ss() As String
	ss = Regex.Split(",", str)
	For Each s As String In ss
		s = s.Trim
	Next
	Return ss
End Sub

Private Sub ParametersCount As Int
	Return DBParameters.Length
End Sub

Private Sub CountChar (c As String, Word As String) As Int
	Dim count As Int
	For i = 0 To Word.Length - 1
		If c = Word.SubString2(i, i + 1) Then
			count = count + 1
		End If
	Next
	Return count
End Sub

Public Sub CreateColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, AllowNull As Boolean, IsUnique As Boolean, AutoIncrement As Boolean) As ORMColumn
	Dim t1 As ORMColumn
	t1.Initialize
	t1.ColumnName = ColumnName
	t1.ColumnType = ColumnType
	t1.ColumnLength = ColumnLength
	t1.Collation = Collation
	t1.DefaultValue = DefaultValue
	t1.AllowNull = AllowNull
	t1.Unique = IsUnique
	t1.AutoIncrement = AutoIncrement
	If t1.ColumnType = "" Then t1.ColumnType = VARCHAR
	If t1.ColumnType = VARCHAR And t1.ColumnLength = "" Then t1.ColumnLength = "255"
	If t1.ColumnType = BIG_INT And t1.ColumnLength = "" Then t1.ColumnLength = "20"
	'If t1.ColumnType = INTEGER Or t1.ColumnType = TIMESTAMP Or t1.ColumnLength = "0" Then t1.ColumnLength = ""
	If t1.ColumnType = INTEGER Then t1.ColumnLength = "11"
	If t1.ColumnType = TIMESTAMP Then t1.ColumnLength = ""
	If t1.ColumnLength = "0" Then t1.ColumnLength = ""
	Return t1
End Sub

' Name - Column Name (String)
' Type - Column Type (String) e.g INTEGER/DECIMAL/VARCHAR/TIMESTAMP
' Size - Column Length (String) e.g 255/10,2
' Collation - Collation for char (String) e.g COLLATE utf8mb4_unicode_ci
' Default - Default Value (String) e.g CURRENT_TIMESTAMP/now()/1
' Null - Allow Null (Boolean)
' Unique - Is Unique (Boolean)
' AutoIncrement - Auto increment (Boolean)
Public Sub CreateColumn2 (Props As Map) As ORMColumn
	Dim t1 As ORMColumn
	t1.Initialize
	t1.ColumnName = ""
	t1.ColumnType = ""
	t1.ColumnLength = ""
	t1.Collation = ""
	t1.DefaultValue = ""
	t1.AllowNull = True
	t1.Unique = False
	t1.AutoIncrement = False
	For Each Key As String In Props.Keys
		Select Key.ToLowerCase
			Case "ColumnName".ToLowerCase, "Name".ToLowerCase
				t1.ColumnName = Props.Get(Key)
			Case "ColumnType".ToLowerCase, "Type".ToLowerCase
				t1.ColumnType = Props.Get(Key)
			Case "ColumnLength".ToLowerCase, "ColumnSize".ToLowerCase, "Length".ToLowerCase, "Size".ToLowerCase
				t1.ColumnLength = Props.Get(Key)
			Case "Collation".ToLowerCase
				t1.Collation = Props.Get(Key)
			Case "DefaultValue".ToLowerCase, "Default".ToLowerCase
				t1.DefaultValue = Props.Get(Key)
			Case "Nullable".ToLowerCase, "Null".ToLowerCase, "AllowNull".ToLowerCase
				t1.AllowNull = Props.Get(Key)
			Case "Unique".ToLowerCase
				t1.Unique = Props.Get(Key)
			Case "AutoIncrement".ToLowerCase
				t1.AutoIncrement = Props.Get(Key)
			Case Else
				t1.ColumnName = Key
		End Select
	Next
	If t1.ColumnType = "" Then t1.ColumnType = VARCHAR
	If t1.ColumnType = VARCHAR And t1.ColumnLength = "" Then t1.ColumnLength = "255"
	If t1.ColumnType = BIG_INT And t1.ColumnLength = "" Then t1.ColumnLength = "20"
	'If t1.ColumnType = INTEGER Or t1.ColumnType = TIMESTAMP Or t1.ColumnLength = "0" Then t1.ColumnLength = ""
	If t1.ColumnType = INTEGER Then t1.ColumnLength = "11"
	If t1.ColumnType = TIMESTAMP Then t1.ColumnLength = ""
	If t1.ColumnLength = "0" Then t1.ColumnLength = ""
	Return t1
End Sub

Public Sub CreateFilter (Column As String, Operator As String, Value As String) As ORMFilter
	Dim t1 As ORMFilter
	t1.Initialize
	t1.Column = Column
	t1.Operator = Operator
	t1.Value = Value
	Return t1
End Sub

Public Sub CreateJoin (Table2 As String, OnConditions As String, Mode As String) As ORMJoin
	Dim t1 As ORMJoin
	t1.Initialize
	t1.Table2 = Table2
	t1.OnConditions = OnConditions
	t1.Mode = Mode
	Return t1
End Sub