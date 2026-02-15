B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Mini Object-Relational Mapper (ORM) class
' Version 4.03
Sub Class_Globals
	Private mSQL 					As SQL
	Private mID 					As Int
	Private mBatch 					As List
	Private mColumns 				As List
	Private mColumnsType			As Map
	Private mObject 				As String
	Private mTable 					As String
	Private mView					As String
	Private mStatement 				As String
	Private mDatabaseName 			As String
	Private mPrimaryKey 			As String
	Private mUniqueKey 				As String
	Private mForeignKey 			As String
	Private mConstraint 			As String
	Private mGroupBy 				As String
	Private mOrderBy 				As String
	Private mLimit 					As String
	Private mCondition 				As String
	Private mHaving 				As String
	Private mParameters() 			As Object
	Private mSettings				As ORMSettings
	Private mError 					As Exception
	Private mType 					As String
	Private mJournalMode 			As String = "DELETE"
	Private mDefaultUserId 			As String = "1"
	Private mShowExtraLogs 			As Boolean
	Private mUseTimestamps 			As Boolean ' may need to disable when working on view
	Private mAutoIncrement 			As Boolean = True
	Private mUseDataAuditUserId 	As Boolean
	Private mUpdateModifiedDate 	As Boolean
	Private mQueryAddToBatch 		As Boolean
	Private mQueryExecute 			As Boolean
	Private mQueryClearParameters 	As Boolean = True
	#If B4J
	Private mUseTimestampsAsTicks 	As Boolean
	Private mDateTimeMethods 		As Map = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
	Private mPool 					As ConnectionPool
	Private mCharSet 				As String = "utf8mb4"
	Private mCollate 				As String = "utf8mb4_unicode_ci"
	#End If
	Private mJournalMode 			As String = "DELETE"
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
	Public Const MYSQL 				As String = "MySQL"
	Public Const SQLITE 			As String = "SQLite"
	Public Const MARIADB 			As String = "MariaDB"
	Public Const COLOR_RED 			As Int = -65536
	Type ORMResult (Tag As Object, Columns As Map, Rows As List)
	Type ORMFilter (Column As String, Operator As String, Value As String)
	Type ORMJoin (Table2 As String, OnConditions As String, Mode As String)
	Type ORMTable (ResultSet As ResultSet, Columns As List, Rows As List, Results As List, Results2 As List, First As Map, First2 As Map, Last As Map, RowCount As Int) ' Columns = list of keys, Rows = list of values, Results = list of maps, Results2 = Results + map ("__order": ["column1", "column2", "column3"])
	Type ORMColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, UseFunction As Boolean, AllowNull As Boolean, Unique As Boolean, AutoIncrement As Boolean) ' B4i dislike word Nullable
	Type ORMSettings (DBDir As String, _
	DBFile As String, _
	DBType As String, _
	DBHost As String, _
	DBPort As String, _
	DBName As String, _
	DriverClass As String, _
	JdbcUrl As String, _
	User As String, _
	Password As String, _
	JournalMode As String, _
	MaxPoolSize As Int)
End Sub

'<code>DB.Initialize</code>
Public Sub Initialize
	Clear
	mView = ""
	mTable = ""
	mObject = ""
	mStatement = ""
	mDatabaseName = ""
	mBatch.Initialize
	mColumns.Initialize
	mSettings.Initialize
End Sub

' Create SQLite database
Public Sub InitializeSQLite As Boolean
	Try
		#If B4J
		mSQL.InitializeSQLite(mSettings.DBDir, mSettings.DBFile, True)
		#Else
		mSQL.Initialize(mSettings.DBDir, mSettings.DBFile, True)
		#End If
		If mJournalMode.EqualsIgnoreCase("WAL") Then
			mSQL.ExecQuerySingleResult("PRAGMA journal_mode = wal")
		End If
		Return True
	Catch
		Log(LastException)
		mError = LastException
		Return False
	End Try
End Sub

#If B4J
' Create MySQL or MariaDB database
Public Sub CreateDatabaseAsync As ResumableSub
	Try
		If mSQL.IsInitialized = False Then
			Wait For (InitSchemaAsync) Complete (Success As Boolean)
			If Success = False Then
				Return False
			End If
		End If
		Dim qry As String = $"CREATE DATABASE ${mSettings.DBName} CHARACTER SET ${mCharSet} COLLATE ${mCollate}"$
		mSQL.ExecNonQuery(qry)
		Return True
	Catch
		Log(LastException)
		mError = LastException
		Return False
	End Try
End Sub

' Connect to database name (MySQL, MariaDB)
Public Sub InitPool
	Try
		Dim JdbcUrl As String = mSettings.JdbcUrl
		JdbcUrl = JdbcUrl.Replace("{DbHost}", mSettings.DBHost)
		JdbcUrl = JdbcUrl.Replace("{DbName}", mSettings.DBName)
		JdbcUrl = IIf(mSettings.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", mSettings.DBPort))
		mPool.Initialize(mSettings.DriverClass, JdbcUrl, mSettings.User, mSettings.Password)
	Catch
		Log(LastException)
		mError = LastException
	End Try
End Sub

' Asynchronously initialize SQL object to database schema e.g information_schema (MySQL, MariaDB)
'<code>Wait For (DB.InitSchemaAsync) Complete (Success As Boolean)</code>
Public Sub InitSchemaAsync As ResumableSub
	Dim JdbcUrl As String = mSettings.JdbcUrl
	JdbcUrl = JdbcUrl.Replace("{DbHost}", mSettings.DBHost)
	JdbcUrl = JdbcUrl.Replace("{DbName}", "information_schema")
	JdbcUrl = IIf(mSettings.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", mSettings.DBPort))
	mSQL.InitializeAsync("DB", mSettings.DriverClass, JdbcUrl, mSettings.User, mSettings.Password)
	Wait For DB_Ready (Success As Boolean)
	If Success = False Then
		Log(LastException)
		mError = LastException
		Return False
	End If
	Return Success
End Sub

' Initialize SQL object to database schema e.g information_schema (MySQL, MariaDB)
'<code>DB.InitSchema</code>
Public Sub InitSchema
	Dim JdbcUrl As String = mSettings.JdbcUrl
	JdbcUrl = JdbcUrl.Replace("{DbHost}", mSettings.DBHost)
	JdbcUrl = JdbcUrl.Replace("{DbName}", "information_schema")
	JdbcUrl = IIf(mSettings.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", mSettings.DBPort))
	mSQL.Initialize2(mSettings.DriverClass, JdbcUrl, mSettings.User, mSettings.Password)
End Sub
#End If

' Check database file exists (SQLite)
Public Sub Exist As Boolean
	Dim DBFound As Boolean
	If File.Exists(mSettings.DBDir, mSettings.DBFile) Then
		DBFound = True
	End If
	Return DBFound
End Sub

#If B4J
' Check database exists (MySQL, MariaDB)
Public Sub ExistAsync As ResumableSub
	Dim DBFound As Boolean
	Try
		If mSQL.IsInitialized = False Then
			Wait For (InitSchemaAsync) Complete (Success As Boolean)
			If Success = False Then
				Return False
			End If
		End If
		Dim qry As String = "SELECT * FROM SCHEMATA WHERE SCHEMA_NAME = ?"
		Dim RS As ResultSet = mSQL.ExecQuery2(qry, Array As String(mSettings.DBName))
		Do While RS.NextRow
			DBFound = True
		Loop
		RS.Close
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Close
	Return DBFound
End Sub
#End If

' Connect to database server
' Note: SQLite uses DBDir and DBFile
Public Sub Open As SQL
	#If B4J
	Select mSettings.DBType
		Case SQLITE
			mSQL.InitializeSQLite(mSettings.DBDir, mSettings.DBFile, False)
		Case MYSQL, MARIADB
			Return mPool.GetConnection
	End Select
	#Else
	mSQL.Initialize(mSettings.DBDir, mSettings.DBFile, False)
	#End If
	Return mSQL
End Sub

#If B4J
' Connect to database server (asynchronously connection)
' Note: SQLite uses JdbcUrl
Public Sub OpenAsync As ResumableSub
	Try
		Select mSettings.DBType
			Case MYSQL, MARIADB
				mPool.GetConnectionAsync("Pool")
				Wait For Pool_ConnectionReady (DB1 As SQL)
				mSQL = DB1
			Case SQLITE
				mSQL.InitializeAsync("DB", mSettings.DriverClass, mSettings.JdbcUrl, mSettings.User, mSettings.Password)
				Wait For DB_Ready (Success As Boolean)
				If Success = False Then
					Log(LastException)
					mError = LastException
				End If
		End Select
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Return mSQL
End Sub
#End If

Public Sub Opened As Boolean
	Return mSQL <> Null And mSQL.IsInitialized
End Sub

' Close SQL object
Public Sub Close
	If mJournalMode.EqualsIgnoreCase("WAL") Then Return
	If Opened Then mSQL.Close
End Sub

' Check database can be connected
Public Sub Test As Boolean
	If Opened Then
		Close
		Return True
	End If
	Return False
End Sub

' Return server date
Public Sub GetDate As String
	Try
		Select mSettings.DBType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT CURDATE()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT DATE('now')"$
			Case Else
				Dim CurrentDateFormat As String = DateTime.DateFormat
				DateTime.DateFormat = "yyyy-MM-dd"
				Dim DateValue As String = DateTime.Date(DateTime.Now)
				DateTime.DateFormat = CurrentDateFormat
				Return DateValue
		End Select
		If mSQL.IsInitialized = False Then
			mSQL = Open
		End If
		Dim str As String = mSQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Close
	Return str
End Sub

' Return server date (ascynchronous connection)
Public Sub GetDate2 As ResumableSub
	Try
		Select mSettings.DBType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT CURDATE()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT DATE('now')"$
			Case Else
				DateTime.DateFormat = "yyyy-MM-dd"
				Return DateTime.Date(DateTime.Now)
		End Select
		If mSQL.IsInitialized = False Then
			mSQL = Open
		End If
		Dim str As String = mSQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Close
	Return str
End Sub

' Return server timestamp
Public Sub GetDateTime As String
	Try
		Select mSettings.DBType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT now()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT datetime('now')"$
			Case Else	
				Dim CurrentDateFormat As String = DateTime.DateFormat
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Dim DateValue As String = DateTime.Date(DateTime.Now)
				DateTime.DateFormat = CurrentDateFormat
				Return DateValue
		End Select
		If mSQL.IsInitialized = False Then
			mSQL = Open
		End If
		Dim str As String = mSQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Close
	Return str
End Sub

' Return server timestamp (ascynchronous connection)
Public Sub GetDateTime2 As ResumableSub
	Try
		Select mSettings.DBType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT now()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT datetime('now')"$
			Case Else
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Return DateTime.Date(DateTime.Now)
		End Select
		If mSQL.IsInitialized = False Then
			mSQL = Open
		End If
		Dim str As String = mSQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	Close
	Return str
End Sub

Public Sub setError (mMessage As Exception)
	mError = mMessage
End Sub

Public Sub getError As Exception
	Return mError
End Sub

#If B4J
Public Sub setCharSet (NewCharSet As String)
	mCharSet = NewCharSet
End Sub

Public Sub setCollate (NewCollate As String)
	mCollate = NewCollate
End Sub
#End If

Public Sub setJournalMode (Mode As String)
	mJournalMode = Mode
End Sub

' Return SQL query for Last Insert ID based on DBType
Public Sub getLastInsertIDQuery As String
	Select mSettings.DBType
		#If B4J
		Case MYSQL, MARIADB
			Dim qry As String = "SELECT LAST_INSERT_ID()"
		#End If
		Case SQLITE
			Dim qry As String = "SELECT LAST_INSERT_ROWID()"
		Case Else
			Dim qry As String = "SELECT 0"
	End Select
	Return qry
End Sub

'Set DBType to SQLite, MySQL or MariaDB
Public Sub setDbType (Name As String)
	Select Name.ToUpperCase
		Case "SQLITE"
			BLOB = "BLOB"
			INTEGER = "INTEGER"
			BIG_INT = "INTEGER"
			DECIMAL = "NUMERIC"
			VARCHAR = "TEXT"
			TEXT = "TEXT"
			DATE_TIME = "TEXT"
			TIMESTAMP = "TEXT"
			mType = SQLITE
		Case "MYSQL", "MARIADB"
			BLOB = "mediumblob"
			INTEGER = "int"
			BIG_INT = "bigint"
			DECIMAL = "decimal"
			VARCHAR = "varchar"
			TEXT = "text"
			DATE_TIME = "datetime"
			TIMESTAMP = "timestamp"
			If Name.EqualsIgnoreCase(MYSQL) Then mType = MYSQL Else mType = MARIADB
	End Select
End Sub

Public Sub getDbType As String
	Return mType
End Sub

Public Sub setSettings (Settings As ORMSettings)
	mSettings = Settings
	setDbType(mSettings.DBType)
End Sub

Public Sub getSettings As ORMSettings
	Return mSettings
End Sub

Public Sub setSQL (SQL As SQL)
	mSQL = SQL
End Sub

Public Sub getSQL As SQL
	Return mSQL
End Sub

Public Sub setTable (Table As String)
	mTable = Table
	mObject = mTable
	Reset
End Sub

Public Sub getTable As String
	Return mTable
End Sub

Public Sub setView (View As String)
	mView = View
	mObject = mView
	Reset
End Sub

Public Sub getView As String
	Return mView
End Sub

Public Sub setBatch (Batch As List)
	mBatch = Batch
End Sub

Public Sub getBatch As List
	Return mBatch
End Sub

Public Sub setColumns (Columns As List)
	mColumns = Columns
	SelectFromTableOrView
End Sub

Public Sub getColumns As List
	Return mColumns
End Sub

Public Sub setColumnsType (ColumnsType As Map)
	mColumnsType = ColumnsType
End Sub

Public Sub getColumnsType As Map
	Return mColumnsType
End Sub

Public Sub setShowExtraLogs (Value As Boolean)
	mShowExtraLogs = Value
End Sub

Public Sub setUpdateModifiedDate (Value As Boolean)
	mUpdateModifiedDate = Value
End Sub

Public Sub setUseTimestamps (Value As Boolean)
	mUseTimestamps = Value
End Sub

Public Sub getUseTimestamps As Boolean
	Return mUseTimestamps
End Sub

#If B4J
Public Sub setUseTimestampsAsTicks (Value As Boolean)
	mUseTimestampsAsTicks = Value
End Sub
#End If

Public Sub setUseDataAuditUserId (Value As Boolean)
	mUseDataAuditUserId = Value
End Sub

Public Sub setDefaultUserId (Value As String)
	mDefaultUserId = Value
End Sub

Public Sub setQueryAddToBatch (Value As Boolean)
	mQueryAddToBatch = Value
End Sub

Public Sub setQueryExecute (Value As Boolean)
	mQueryExecute = Value
End Sub

' Clear Parameters after Query
Public Sub setQueryClearParameters (Value As Boolean)
	mQueryClearParameters = Value
End Sub

Public Sub setAutoIncrement (Value As Boolean)
	mAutoIncrement = Value
End Sub

Public Sub Reset
	Clear
	ClearParameters
	mColumns.Initialize
	SelectAllFromObject
End Sub

'Clear some query related String variables but continue to reuse table/view
Private Sub Clear
	mLimit = ""
	mHaving = ""
	mGroupBy = ""
	mOrderBy = ""
	mCondition = ""
	mUniqueKey = ""
	mPrimaryKey = ""
	mForeignKey = ""
	mConstraint = ""
End Sub

' Clear Parameters
Private Sub ClearParameters
	mParameters = Array As Object()
End Sub

Public Sub Results As List
	Return ORMTable.Results
End Sub

Public Sub Results2 As List
	Return ORMTable.Results2
End Sub

' Query column id
Public Sub Find (ID As Int)
	Reset
	WhereParam("id = ?", ID)
	Query
End Sub

' Query by single condition
Public Sub Find2 (Condition As String, Value As Object)
	Reset
	WhereParam(Condition, Value)
	Query
End Sub

' Append new Condition WHERE/AND id = ID
' Existing parameters are preserved
Public Sub setId (ID As Int)
	mID = ID
	WhereParams(Array("id = ?"), Array(ID)) ' Use WhereParams to append extra condition
End Sub

Public Sub getId As Int
	Return mID
End Sub

' Returns first queried row
Public Sub getFirst As Map
	Return ORMTable.First
End Sub

' Returns first queried row with ordered keys
Public Sub getFirst2 As Map
	Return ORMTable.First2
End Sub

' (formerly known as SelectOnly)
' Return first queried row with specified columns
Public Sub FirstPick (Columns As List) As Map
	Dim NewMap As Map
	NewMap.Initialize
	For Each Col In Columns
		If ORMTable.First.ContainsKey(Col) Then
			NewMap.Put(Col, ORMTable.First.Get(Col))
		End If
	Next
	Return NewMap
End Sub

' Deprecated: Will be removed in future version
Public Sub SelectOnly (Columns As List) As Map
	Return FirstPick(Columns)
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

Private Sub SelectAllFromObject
	mStatement = $"SELECT * FROM ${mObject}"$
End Sub

Private Sub SelectFromTableOrView
	Dim ac As Boolean ' Add Comma
	Dim SB As StringBuilder
	sb.Initialize
	If mColumns.IsInitialized Then
		For Each Col In mColumns
			If ac Then sb.Append(", ")
			sb.Append(Col)
			ac = True
		Next
	End If
	Dim Cols As String = sb.ToString
	mStatement = $"SELECT ${IIf(Cols = "", "*", Cols)} FROM ${mObject}"$
End Sub

Public Sub IfNull (ColumnName As String, DefaultValue As Object, AliasName As String) As String
	Return $"IFNULL(${ColumnName}, '${DefaultValue}')"$ & IIf(AliasName = "", $" AS ${ColumnName}"$, $" AS ${AliasName}"$)
End Sub

Public Sub setGroupBy (Columns As List)
	Dim SB As StringBuilder
	sb.Initialize
	For Each Column As String In Columns
		If sb.Length > 0 Then sb.Append(", ") Else sb.Append(" GROUP BY ")
		sb.Append(Column)
	Next
	mGroupBy = SB.ToString
End Sub

Public Sub setHaving (Statements As List)
	Dim SB As StringBuilder
	SB.Initialize
	For Each statement In Statements
		If SB.Length > 0 Then SB.Append(" AND ") Else SB.Append(" HAVING ")
		SB.Append(statement)
	Next
	mHaving = SB.ToString
End Sub

Public Sub setOrderBy (Col As Map)
	If Col.IsInitialized Then
		Dim SB As StringBuilder
		SB.Initialize
		For Each key As String In Col.Keys
			If SB.Length > 0 Then SB.Append(", ")
			Dim value As String = Col.Get(key)
			If value.EqualsIgnoreCase("DESC") Then
				SB.Append(key & " " & value)
			Else
				SB.Append(key)
			End If
		Next
		mOrderBy = $" ORDER BY ${SB.ToString}"$
	End If
End Sub

Public Sub SortByLastId
	mOrderBy = $" ORDER BY id DESC"$
End Sub

Public Sub Create
	Dim SB As StringBuilder
	SB.Initialize
	Dim FirstColumn As Boolean = True
	For Each col As ORMColumn In mColumns
		If FirstColumn = False Then
			SB.Append(",").Append(CRLF)
		End If
		SB.Append(col.ColumnName)
		SB.Append(" ")
		Select mType
			Case SQLITE
				SB.Append(col.ColumnType)
			Case MYSQL, MARIADB
				Select col.ColumnType
					Case INTEGER, BIG_INT, DECIMAL, TIMESTAMP, DATE_TIME, TEXT, BLOB
						SB.Append(col.ColumnType)
					Case Else
						SB.Append(VARCHAR)
				End Select
				If col.ColumnLength.Length > 0 Then
					SB.Append("(").Append(col.ColumnLength).Append(")")
				End If
				If col.Collation.Length > 0 Then
					SB.Append(" ").Append(col.Collation)
				End If
		End Select
		
		If col.DefaultValue.Length > 0 Then
			Select col.ColumnType
				Case INTEGER, BIG_INT, TIMESTAMP, DATE_TIME
					Select mType
						Case SQLITE
							If col.DefaultValue.StartsWith("(") And col.DefaultValue.EndsWith(")") Then
								SB.Append(" DEFAULT ").Append(col.DefaultValue)
							Else
								SB.Append(" DEFAULT ").Append("(").Append(col.DefaultValue).Append(")")
							End If
						Case MYSQL, MARIADB
							SB.Append(" DEFAULT ").Append(col.DefaultValue)
					End Select
				Case Else
					If col.UseFunction Then
						If col.DefaultValue.StartsWith("(") And col.DefaultValue.EndsWith(")") Then
							SB.Append(" DEFAULT ").Append(col.DefaultValue)
						Else
							Select mType
								Case SQLITE
									SB.Append(" DEFAULT ").Append("(").Append(col.DefaultValue).Append(")")
								Case MYSQL, MARIADB
									SB.Append(" DEFAULT ").Append(col.DefaultValue)
							End Select
						End If
					Else
						SB.Append(" DEFAULT ").Append("'").Append(col.DefaultValue).Append("'")
					End If
			End Select
		End If
		
		If col.AllowNull Then SB.Append(" NULL") Else SB.Append(" NOT NULL")
		If col.Unique Then SB.Append(" UNIQUE")
		If col.AutoIncrement Then
			Select mType
				Case SQLITE
					SB.Append(" AUTOINCREMENT")
				Case MYSQL, MARIADB
					SB.Append(" AUTO_INCREMENT")
			End Select
		End If
		'sb.Append(",").Append(CRLF)
		FirstColumn = False
	Next
	
	Select mType
		Case SQLITE
			If mUseDataAuditUserId Then
				SB.Append(",").Append(CRLF)
				SB.Append("created_by " & INTEGER & " DEFAULT " & mDefaultUserId & ",").Append(CRLF)
				SB.Append("modified_by " & INTEGER & ",").Append(CRLF)
				SB.Append("deleted_by " & INTEGER).Append(CRLF)
			End If
			If mUseTimestamps Then
				SB.Append(",").Append(CRLF)
				SB.Append("created_date " & VARCHAR & " DEFAULT (datetime('now')),").Append(CRLF)
				SB.Append("modified_date " & VARCHAR & ",").Append(CRLF)
				SB.Append("deleted_date " & VARCHAR)
			End If
		Case MYSQL, MARIADB
			If mUseDataAuditUserId Then
				SB.Append(",").Append(CRLF)
				SB.Append("created_by " & INTEGER & " DEFAULT " & mDefaultUserId & ",").Append(CRLF)
				SB.Append("modified_by " & INTEGER & ",").Append(CRLF)
				SB.Append("deleted_by " & INTEGER).Append(CRLF)
			End If
			If mUseTimestamps Then
				' Use timestamp and datetime
				SB.Append(",").Append(CRLF)
				SB.Append("created_date " & TIMESTAMP & " DEFAULT CURRENT_TIMESTAMP,").Append(CRLF)
				SB.Append("modified_date " & DATE_TIME & " DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,").Append(CRLF)
				SB.Append("deleted_date " & DATE_TIME & " DEFAULT NULL")
			End If
	End Select

	Dim stmt As StringBuilder
	stmt.Initialize
	Select mObject
		Case mTable
			stmt.Append($"CREATE TABLE IF NOT EXISTS ${mTable} ("$)
		Case mView
			stmt.Append($"CREATE VIEW IF NOT EXISTS ${mView} AS "$)
	End Select
	
	' id column added by default
	Dim Pk As String = "id"
	If mPrimaryKey.Length > 0 And Not(mPrimaryKey.Contains(",")) Then
		Pk = mPrimaryKey
	End If
	If mAutoIncrement Then
		Select mType
			Case MYSQL, MARIADB
				stmt.Append($"${Pk} ${INTEGER}(11) NOT NULL AUTO_INCREMENT,"$).Append(CRLF)
			Case SQLITE
				stmt.Append($"${Pk} ${INTEGER},"$).Append(CRLF)
		End Select
	End If

	' Put the columns here
	stmt.Append(SB.ToString)

	If mAutoIncrement Then
		Select mType
			Case SQLITE
				stmt.Append(",").Append(CRLF)
				stmt.Append($"PRIMARY KEY(${Pk} AUTOINCREMENT)"$)
			Case MYSQL, MARIADB
				stmt.Append(",").Append(CRLF)
				stmt.Append($"PRIMARY KEY(${Pk})"$)
		End Select
	Else
		If mPrimaryKey.Length > 0 Then
			stmt.Append(",").Append(CRLF)
			stmt.Append($"PRIMARY KEY(${mPrimaryKey})"$)
		Else
			Dim chk As String = stmt.ToString
			If chk.EndsWith(",") Then
				LogColor("*** Contains comma", COLOR_RED)
				stmt.Remove(stmt.Length - 1, stmt.Length) ' remove the last comma
			Else
				LogColor("*** Good", COLOR_RED)
			End If
		End If
	End If
	
	If mUniqueKey.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mUniqueKey)
	End If
	
	If mForeignKey.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mForeignKey)
	End If
	
	If mConstraint.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mConstraint)
	End If
	
	If mObject = mTable Then stmt.Append(")")
	mStatement = stmt.ToString
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then Execute
End Sub

'Create using raw SQL statement
Public Sub Create2 (CreateStatement As String)
	ClearParameters
	mStatement = CreateStatement
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then Execute
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
	mPrimaryKey = keys.ToString
End Sub

' Add foreign key
'<code>DB.Foreign("category_id", "id", "tbl_categories", "", "")</code>
Public Sub Foreign (mKey As String, mReferences As String, mOnTable As String, mOnDelete As String, mOnUpdate As String)
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append( $"FOREIGN KEY (${mKey}) REFERENCES ${mOnTable} (${mReferences})"$ )
	If mOnDelete.Length > 0 Then SB.Append( " ON DELETE " & mOnDelete )
	If mOnUpdate.Length > 0 Then SB.Append( " ON UPDATE " & mOnUpdate )
	mForeignKey = SB.ToString
End Sub

' Add unique key
' mKey: Column name
' Optional: mAlias
Public Sub Unique (mKey As String, mAlias As String)
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("UNIQUE KEY")
	If mAlias.Length > 0 Then SB.Append(" " & mAlias)
	SB.Append($" (${mKey})"$)
	mUniqueKey = SB.ToString
End Sub

' Add constraint
' mKeyType: UNIQUE or PRIMARY KEY
' mKeys: Column names separated by comma
' Optional: mAlias
Public Sub Constraint (mKeyType As String, mKeys As String, mAlias As String)
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("CONSTRAINT")
	If mAlias.Length > 0 Then SB.Append(" " & mAlias)
	SB.Append(" " & mKeyType)
	SB.Append($"(${mKeys})"$)
	mConstraint = SB.ToString
End Sub

' Execute Non Query
Public Sub Execute
	ExecNonQuery
End Sub

' Execute Non Query with Object type parameters
Public Sub Execute2 (Parameter() As Object)
	mParameters = Parameter
	If mShowExtraLogs Then LogQuery2
	Execute
End Sub

Private Sub ExecQuery As ResultSet
	Try
		If ParametersCount = 0 Then
			If mShowExtraLogs Then LogQuery
			Dim RS As ResultSet = mSQL.ExecQuery(mStatement)
		Else
			If mShowExtraLogs Then LogQuery2
			' B4A requires String Array
			Dim StringParams(mParameters.Length) As String
			For i = 0 To mParameters.Length - 1
				StringParams(i) = mParameters(i)
			Next
			Dim RS As ResultSet = mSQL.ExecQuery2(mStatement, StringParams)
		End If
	Catch
		Log(LastException.Message)
		mError = LastException
	End Try
	Return RS
End Sub

Private Sub ExecNonQuery
	Try
		If ParametersCount = 0 Then
			If mShowExtraLogs Then LogQuery
			mSQL.ExecNonQuery(mStatement)
		Else
			If mShowExtraLogs Then LogQuery2
			mSQL.ExecNonQuery2(mStatement, mParameters)
		End If
	Catch
		Log(LastException)
		mError = LastException
	End Try
End Sub

' Execute Non Query batch <code>
'Wait For (DB.ExecuteBatch) Complete (Success As Boolean)</code>
Public Sub ExecuteBatchAsync As ResumableSub
	If mShowExtraLogs Then LogQuery3
	Dim SenderFilter As Object = mSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Return Success
End Sub

Public Sub AddNonQueryToBatch
	mBatch.Add(CreateMap("DB_Statement": mStatement, "DB_Parameters": mParameters))
	mSQL.AddNonQueryToBatch(mStatement, mParameters)
End Sub

' Append Parameters at the end
Public Sub AddParameters (Params() As Object)
	If Params.Length = 0 Then Return
	If mParameters.Length > 0 Then
		Dim NewArray(mParameters.Length + Params.Length) As Object
		For i = 0 To mParameters.Length - 1
			NewArray(i) = mParameters(i)
		Next
		For i = 0 To Params.Length - 1
			NewArray(mParameters.Length + i) = Params(i)
		Next
		mParameters = NewArray
	Else
		mParameters = Params
	End If
End Sub

' Initialize Parameters
Public Sub setParameters (Params() As Object)
	mParameters = Params
End Sub

' Example: Limit 10, 10 (second parameter is Offset)
Public Sub setLimit (Value As String)
	mLimit = Value
End Sub

Public Sub setJoin (OJoin As ORMJoin)
	Dim JOIN As String = " JOIN "
	If OJoin.Mode <> "" Then JOIN = " " & OJoin.Mode & " "
	Append(JOIN & OJoin.Table2 & " ON " & OJoin.OnConditions)
End Sub

' Execute Query
Public Sub Query
	Try
		If mCondition.Length > 0 Then mStatement = mStatement & mCondition
		If mGroupBy.Length > 0 Then mStatement = mStatement & mGroupBy
		If mHaving.Length > 0 Then mStatement = mStatement & mHaving
		If mOrderBy.Length > 0 Then mStatement = mStatement & mOrderBy
		If mLimit.Length > 0 Then mStatement = mStatement & $" LIMIT ${mLimit}"$ ' Limit 10, 10 <-- second parameter is OFFSET
		Dim RS As ResultSet = ExecQuery
		If mError.IsInitialized Then
			If Initialized(RS) Then RS.Close
			Return
		End If
		
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
				Else If mDateTimeMethods.ContainsKey(ct) Then
					If mUseTimestampsAsTicks Then
						Dim SQLTime As JavaObject = jrs.RunMethodJO(mDateTimeMethods.Get(ct), Array(i + 1))
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
				If mColumnsType.IsInitialized And mColumnsType.ContainsKey(ColumnName) Then
					Select mColumnsType.Get(ColumnName)
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
						Log(LastException.Message)
						Row(i) = RS.GetBlob2(i)
						LogColor("Converted to BLOB", COLOR_RED)
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
		RS.Close ' test 2025-09-18
		
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
		Log(LastException)
		LogColor("Are you missing ' = ?' in query?", COLOR_RED)
		mError = LastException
	End Try
	Clear
	If mQueryClearParameters Then ClearParameters
End Sub

Public Sub Query2 (Params() As Object)
	setParameters(Params)
	Query
End Sub

' Return an object without calling Query
' Note: ORMTable and ORMResults are not affected
Public Sub Scalar As Object
	If mCondition.Length > 0 Then mStatement = mStatement & mCondition
	If ParametersCount = 0 Then
		Return mSQL.ExecQuerySingleResult(mStatement)
	Else	
		Return mSQL.ExecQuerySingleResult2(mStatement, mParameters)
	End If
End Sub

' Similar to Scalar but passing Params
Public Sub Scalar2 (Params() As Object) As Object
	setParameters(Params)
	Return Scalar
End Sub

Public Sub Insert
	Dim cd As Boolean ' contains created_date
	Dim SB As StringBuilder
	Dim vb As StringBuilder
	SB.Initialize
	vb.Initialize
	For Each col As String In mColumns
		If SB.Length > 0 Then
			SB.Append(", ")
			vb.Append(", ")
		End If
		SB.Append(col)
		vb.Append("?")
		If col.EqualsIgnoreCase("created_date") Then cd = True
	Next
	' To handle varchar timestamps
	If mUseTimestamps And Not(cd) Then
		If SB.Length > 0 Then
			SB.Append(", ")
			vb.Append(", ")
		End If
		sb.Append("created_date")
		Select mType
			Case SQLITE
				vb.Append("(datetime('now'))")			
			Case MYSQL, MARIADB
				vb.Append("now()")
		End Select
	End If
	mStatement = $"INSERT INTO ${mObject} (${sb.ToString}) VALUES (${vb.ToString})"$
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then Execute
End Sub

Public Sub Insert2 (Params() As Object)
	setParameters(Params)
	Insert
End Sub

' Update must have at least 1 condition
Public Sub Save
	Dim BlnNew As Boolean
	If mCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim SB As StringBuilder
		sb.Initialize
		mStatement = $"UPDATE ${mObject} SET "$
		For Each col As String In mColumns
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
		mStatement = mStatement & sb.ToString
		' To handle varchar timestamps
		If mUpdateModifiedDate And Not(md) Then
			Select mType
				Case MYSQL, MARIADB
					mStatement = mStatement & ", modified_date = now()"
				Case SQLITE
					mStatement = mStatement & ", modified_date = (datetime('now'))"
			End Select
		End If
		mStatement = mStatement & mCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim sb, vb As StringBuilder
		sb.Initialize
		vb.Initialize
		For Each col As String In mColumns
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append(col)
			vb.Append("?")
			If col.EqualsIgnoreCase("created_date") Then cd = True
		Next
		' To handle varchar timestamps
		If mUseTimestamps And Not(cd) Then
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append("created_date")
			Select mType
				Case SQLITE
					vb.Append("(datetime('now'))")				
				Case MYSQL, MARIADB
					vb.Append("now()")
			End Select
		End If
		mStatement = $"INSERT INTO ${mObject} (${SB.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	ExecNonQuery
	If BlnNew Then
		' View does not support auto-increment id or ID is not autoincrement
		If mObject = mView Or mAutoIncrement = False Then Return
		Dim NewID As Int = getLastInsertID
		' Return new row
		Find(NewID)
	Else
		' Count numbers of ?
		Dim ParamChars As Int = CountChar("?", mCondition)
		Dim ParamCount As Int = ParametersCount
		SelectAllFromObject
		Dim ConditionParams(ParamChars) As Object
		For i = 0 To ParamChars - 1
			ConditionParams(i) = mParameters(ParamCount - ParamChars + i)
		Next
		mParameters = ConditionParams
		' Return row after update
		Query
	End If
End Sub

Public Sub Save2 (Params() As Object)
	setParameters(Params)
	Save
End Sub

' Same as Save but return row with custom id column
Public Sub Save3 (mColumn As String)
	Dim BlnNew As Boolean
	If mCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim SB As StringBuilder
		sb.Initialize
		mStatement = $"UPDATE ${mObject} SET "$
		For Each col As String In mColumns
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
		mStatement = mStatement & sb.ToString
		' To handle varchar timestamps
		If mUpdateModifiedDate And Not(md) Then
			Select mType
				Case MYSQL, MARIADB
					mStatement = mStatement & ", modified_date = now()"
				Case SQLITE
					mStatement = mStatement & ", modified_date = (datetime('now'))"
			End Select
		End If
		mStatement = mStatement & mCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim sb, vb As StringBuilder
		sb.Initialize
		vb.Initialize
		For Each col As String In mColumns
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append(col)
			vb.Append("?")
			If col.EqualsIgnoreCase("created_date") Then cd = True
		Next
		' To handle varchar timestamps
		If mUseTimestamps And Not(cd) Then
			If sb.Length > 0 Then
				sb.Append(", ")
				vb.Append(", ")
			End If
			sb.Append("created_date")
			Select mType
				Case MYSQL, MARIADB
					vb.Append("now()")
				Case SQLITE
					vb.Append("(datetime('now'))")
			End Select
		End If
		mStatement = $"INSERT INTO ${mObject} (${SB.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	ExecNonQuery
	If BlnNew Then
		' View does not support auto-increment id
		'If mObject = mView Then Return
		If mObject = mView Or mAutoIncrement = False Then Return
		Dim NewID As Int = getLastInsertID
		' Return new row
		Find2(mColumn & " = ?", NewID)
	Else
		' Count numbers of ?
		Dim ParamChars As Int = CountChar("?", mCondition)
		Dim ParamCount As Int = ParametersCount
		SelectAllFromObject
		Dim ConditionParams(ParamChars) As Object
		For i = 0 To ParamChars - 1
			ConditionParams(i) = mParameters(ParamCount - ParamChars + i)
		Next
		mParameters = ConditionParams
		' Return row after update
		Query
	End If
End Sub

Public Sub getLastInsertID As Object
	Select mType
		Case MYSQL, MARIADB
			mStatement = "SELECT LAST_INSERT_ID()"
		Case SQLITE
			mStatement = "SELECT LAST_INSERT_ROWID()"
		Case Else
			If mShowExtraLogs Then Log("Unknown DBType")
			Return -1
	End Select
	If mShowExtraLogs Then LogQuery
	Return mSQL.ExecQuerySingleResult(mStatement)
End Sub

' Adding new Condition
Public Sub setWhere (Statements As List)
	Dim SB As StringBuilder
	SB.Initialize
	For Each statement In Statements
		If SB.Length > 0 Then SB.Append(" AND ") Else SB.Append(" WHERE ")
		SB.Append(statement)
	Next
	mCondition = mCondition & SB.ToString
End Sub

' Set Condition with single condition and value
Public Sub WhereParam (Condition As String, Param As Object)
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(" WHERE ")
	SB.Append(Condition)
	mCondition = SB.ToString
	setParameters(Array As Object(Param))
End Sub

' Append new Conditions and Parameters
Public Sub WhereParams (Conditions() As Object, Params() As Object)
	Dim SB As StringBuilder
	SB.Initialize
	For Each condition As String In Conditions
		If SB.Length > 0 Then SB.Append(" AND ") Else SB.Append(" WHERE ")
		SB.Append(condition)
	Next
	mCondition = mCondition & SB.ToString
	AddParameters(Params)
End Sub

Public Sub Delete
	mStatement = $"DELETE FROM ${mObject}"$
	If mCondition.Length > 0 Then mStatement = mStatement & mCondition
	ExecNonQuery
	mCondition = ""
End Sub

Public Sub Drop
	Select mObject
		Case mTable
			mStatement = $"DROP TABLE IF EXISTS ${mObject}"$
		Case mView
			mStatement = $"DROP VIEW IF EXISTS ${mObject}"$
	End Select
	ExecNonQuery
	mCondition = ""
End Sub

Public Sub Destroy (ids() As Int) As ResumableSub
	If ids.Length < 1 Then Return False
	For i = 0 To ids.Length - 1
		mStatement = $"DELETE FROM ${mObject} WHERE id = ?"$
		If mShowExtraLogs Then LogQueryWithArg(ids(i))
		mSQL.AddNonQueryToBatch(mStatement, Array(ids(i)))
	Next
	Dim SenderFilter As Object = mSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Return Success
End Sub

Public Sub SoftDelete
	Select mType
		Case MYSQL, MARIADB
			mStatement = $"UPDATE ${mObject} SET deleted_date = now()"$
		Case SQLITE
			mStatement = $"UPDATE ${mObject} SET deleted_date = strftime('%s000', 'now')"$
		Case Else
			If mShowExtraLogs Then Log("Unknown DBType")
			Return
	End Select
	If mCondition.Length > 0 Then mStatement = mStatement & mCondition
	If mShowExtraLogs Then LogQuery
	mSQL.ExecNonQuery(mStatement)
End Sub

' Tests whether the table exists
Public Sub TableExists (TableName As String) As Boolean
	Select mType
		Case SQLITE
			' SQLite code extracted from DBUtils
			mStatement = $"SELECT count(name) FROM sqlite_master WHERE type = 'table' AND name = ? COLLATE NOCASE"$
			If mShowExtraLogs Then LogQueryWithArg(TableName)
			Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(TableName))
			Return count > 0
		Case MYSQL, MARIADB
			If mDatabaseName = "" Then
				If mShowExtraLogs Then Log("Unknown DatabaseName")
				Return False
			End If
			mStatement = $"SELECT count(TABLE_NAME) FROM TABLES WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
			If mShowExtraLogs Then LogQueryWithArg(Array As String(mDatabaseName, TableName))
			Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(mDatabaseName, TableName))
			Return count > 0
		Case Else
			If mShowExtraLogs Then Log("Unknown DBType")
			Return False
	End Select
End Sub

' Tests whether the view exists
Public Sub ViewExists (ViewName As String) As Boolean
	Try
		Select mType
			Case SQLITE
				mStatement = $"SELECT COUNT(name) FROM main.sqlite_master WHERE type = 'view' AND name = ? COLLATE NOCASE"$
				If mShowExtraLogs Then LogQueryWithArg(ViewName)
				Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(ViewName))
				Return count > 0
			Case MYSQL, MARIADB
				If mDatabaseName = "" Then
					If mShowExtraLogs Then Log("Unknown DatabaseName")
					Return False
				End If
				mStatement = $"SELECT COUNT(TABLE_NAME) FROM VIEWS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
				If mShowExtraLogs Then LogQueryWithArg(Array As String(mDatabaseName, ViewName))
				Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(mDatabaseName, ViewName))
				Return count > 0
			Case Else
				If mShowExtraLogs Then Log("Unknown DBType")
				Return False
		End Select
	Catch
		LogColor(LastException, COLOR_RED)
		mError = LastException
		Return False
	End Try
End Sub

' List tables
Public Sub ListTables As List
	Try
		Dim lst As List
		lst.Initialize
		Select mType
			Case SQLITE
				mStatement = "SELECT name FROM sqlite_master WHERE type = 'table'"
				Dim RS As ResultSet = mSQL.ExecQuery(mStatement)
				Do While RS.NextRow
					lst.Add(RS.GetString("name"))
				Loop
			Case MYSQL, MARIADB
				mStatement = "SELECT TABLE_NAME FROM TABLES WHERE TABLE_SCHEMA = ?"
				Dim RS As ResultSet = mSQL.ExecQuery2(mStatement, Array As String(mDatabaseName))
				Do While RS.NextRow
					lst.Add(RS.GetString("TABLE_NAME"))
				Loop
			Case Else
				If mShowExtraLogs Then Log("Unknown DBType")
				Return lst
		End Select
	Catch
		LogColor(LastException, COLOR_RED)
		mError = LastException
	End Try
	RS.Close
	Return lst
End Sub

' Show Create Table query
Public Sub ShowCreateTable (TableName As String) As String
	Try
		Select mType
			Case SQLITE
				mStatement = "SELECT sql FROM sqlite_master WHERE type = 'table' AND name = ?"
				Dim RS As ResultSet = mSQL.ExecQuery2(mStatement, Array As String(TableName))
				Do While RS.NextRow
					Return RS.GetString("sql")
				Loop
			Case MYSQL, MARIADB
				mStatement = $"SHOW CREATE TABLE ${TableName}"$
				Dim RS As ResultSet = mSQL.ExecQuery(mStatement)
				Do While RS.NextRow
					Return RS.GetString("CREATE TABLE")
				Loop
			Case Else
				If mShowExtraLogs Then Log("Unknown DBType")
				Return ""
		End Select
	Catch
		LogColor(LastException, COLOR_RED)
		mError = LastException
	End Try
	RS.Close
	Return ""
End Sub

' Append to the end of SQL statement
Public Sub Append (strSQL As String) As String
	mStatement = mStatement & strSQL
	Return mStatement
End Sub

' Set raw SQL statement. Call Reset first.
Public Sub setStatement (strSQL As String)
	mStatement = strSQL
End Sub

' Return SQL statement
Public Sub getStatement As String
	Return mStatement
End Sub

' Set DatabaseName
Public Sub setDatabaseName (DatabaseName As String)
	mDatabaseName = DatabaseName
End Sub

Public Sub getDatabaseName As String
	Return mDatabaseName
End Sub

' Print current SQL statement without parameters
Public Sub LogQuery
	Log(mStatement)
End Sub

' Print current SQL statement on first line
' Print current parameters as list on second line
Public Sub LogQuery2
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("[")
	Dim started As Boolean
	For Each Param In mParameters
		If started Then SB.Append(", ")
		SB.Append(Param)
		started = True
	Next
	SB.Append("]")
	Log(mStatement)
	Log(SB.ToString)
End Sub

' Print batch SQL statements and parameters
Public Sub LogQuery3
	For Each DBMap As Map In mBatch
		Dim SB As StringBuilder
		SB.Initialize
		SB.Append("[")
		Dim started As Boolean
		Dim Params() As Object = DBMap.Get("DB_Parameters") 
		For Each Param In Params
			If started Then SB.Append(", ")
			SB.Append(Param)
			started = True
		Next
		SB.Append("]")
		Log(DBMap.Get("DB_Statement"))
		If Params.Length > 0 Then Log(SB.ToString)
	Next
End Sub

' Print current SQL statement and parameters on one line
Public Sub LogQueryWithArg (Arg As Object)
	Log($"${mStatement} [${Arg}]"$)
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
	Return mParameters.Length
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

Public Sub CreateColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, UseFunction As Boolean, AllowNull As Boolean, IsUnique As Boolean, AutoIncrement As Boolean) As ORMColumn
	Dim t1 As ORMColumn
	t1.Initialize
	t1.ColumnName = ColumnName
	t1.ColumnType = ColumnType
	t1.ColumnLength = ColumnLength
	t1.Collation = Collation
	t1.DefaultValue = DefaultValue
	t1.UseFunction = UseFunction
	t1.AllowNull = AllowNull
	t1.Unique = IsUnique
	t1.AutoIncrement = AutoIncrement
	If t1.ColumnType = "" Then t1.ColumnType = VARCHAR
	If t1.ColumnType = VARCHAR And t1.ColumnLength = "" Then t1.ColumnLength = "255"
	If t1.ColumnType = BIG_INT And t1.ColumnLength = "" Then t1.ColumnLength = "20"
	If t1.ColumnType = INTEGER Then t1.ColumnLength = "11"
	If t1.ColumnType = TIMESTAMP Then t1.ColumnLength = ""
	If t1.ColumnLength = "0" Then t1.ColumnLength = ""
	Return t1
End Sub

' Name - Column Name (String)
' Type - Column Type (String) e.g INTEGER/DECIMAL/VARCHAR/TIMESTAMP
' Size - Column Length (String) e.g 255/10,2
' Collation - Collation for char (String) e.g COLLATE utf8mb4_unicode_ci
' Default - Default Value (String) e.g "Unknown", 0
' DefaultUseFunction - Not String Value e.g utc_timestamp(), datetime('now')
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
	t1.UseFunction = False
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
			Case "UseFunction".ToLowerCase, "Function".ToLowerCase
				t1.UseFunction = Props.Get(Key)
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