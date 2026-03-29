B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Mini Object-Relational Mapper (ORM) class
' Version 5.00
Sub Class_Globals
	Private mSQL 					As SQL
	Private mID 					As Int
	Private mBatch 					As List
	Private mColumns				As List
	Private mConditions				As List
	Private mPrimaryKeys 			As List
	Private mColumnsType			As Map
	Private mObject 				As String
	Private mTable 					As String
	Private mView					As String
	Private mStatement 				As String
	Private mDatabaseName 			As String
	Private mUniqueKeys 			As String
	Private mForeignKeys 			As String
	Private mConstraints 			As String
	Private mGroupBy 				As String
	Private mOrderBy 				As String
	Private mLimit 					As String
	Private mHaving 				As String
	Private mCondition				As String
	Private mParameter				As String
	Private mParameters() 			As Object
	Private mSettings				As ORMSettings
	Private mError 					As Exception
	Private mDbType 				As String
	Private mJournalMode 			As String
	Private mDefaultUserId 			As String
	Private mAutoIncrement 			As Boolean
	Private mShowExtraLogs 			As Boolean
	Private mOptionalNull			As Boolean
	Private mUseTimestamps 			As Boolean ' may need to disable when working on view
	Private mUseDataAuditUserId 	As Boolean
	Private mUpdateModifiedDate 	As Boolean
	Private mQueryAddToBatch 		As Boolean
	Private mQueryExecute 			As Boolean
	Private mQueryClearParameters 	As Boolean
	#If B4J
	Private mCharSet 				As String
	Private mCollate 				As String
	Private mPool 					As ConnectionPool
	Private mDateTimeMethods 		As Map
	Private mUseTimestampsAsTicks 	As Boolean
	#End If
	Public BLOB 					As String
	Public INTEGER 					As String
	Public BIG_INT 					As String
	Public DECIMAL 					As String
	Public VARCHAR 					As String
	Public DATE_TIME 				As String
	Public TIMESTAMP 				As String
	Public TEXT 					As String
	Public ORMTable 				As ORMTable
	Public ORMResult 				As ORMResult
	Public Const MYSQL 				As String = "MySQL"
	Public Const SQLITE 			As String = "SQLite"
	Public Const MARIADB 			As String = "MariaDB"
	Public Const COLOR_RED 			As Int = 0xffff0000 '-65536
	Public Const COLOR_BLUE 		As Int = 0xff0000ff '-16776961
	Type ORMTable (ResultSet As ResultSet, Columns As List, Rows As List, Results As List, Results2 As List, First As Map, First2 As Map, Last As Map, Last2 As Map, RowCount As Int) ' Columns = list of keys, Rows = list of values, Results = list of maps, Results2 = Results + map ("__order": ["column1", "column2", "column3"])
	Type ORMColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, Constraint As String, UseFunction As Boolean, AllowNull As Boolean, Unique As Boolean, AutoIncrement As Boolean) ' B4i dislike word Nullable
	Type ORMResult (Tag As Object, Columns As Map, Rows As List)
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
	mBatch.Initialize
	mColumns.Initialize
	mSettings.Initialize
	mConditions.Initialize
	mPrimaryKeys.Initialize
	mView = ""
	mTable = ""
	mObject = ""
	mStatement = ""
	mDatabaseName = ""
	mJournalMode = "DELETE"
	mDefaultUserId = "1"
	mAutoIncrement = True
	mOptionalNull = True ' NULL is not added to column in CREATE
	mQueryExecute = True
	mQueryClearParameters = True
	#If B4J
	mCharSet = "utf8mb4"
	mCollate = "utf8mb4_unicode_ci"
	mDateTimeMethods = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
	#End If
	Clear
	setDbType(SQLITE) ' Default
End Sub

' Create SQLite database. formerly InitializeSQLite
Public Sub CreateSQLite As Boolean
	Try
		If mSettings.DBDir = "" Then
			#If B4J
			mSettings.DBDir = File.DirApp
			#Else If B4A
			mSettings.DBDir = File.DirInternal
			#Else If B4i
			mSettings.DBDir = File.DirDocuments
			#End If
		End If
		If mSettings.DBFile = "" Then
			mSettings.DBFile = "data.db"
		End If
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
	If mSettings.DBDir = "" Then
		#If B4J
		mSettings.DBDir = File.DirApp
		#Else If B4A
		mSettings.DBDir = File.DirInternal
		#Else If B4i
		mSettings.DBDir = File.DirDocuments
		#End If
	End If
	If mSettings.DBFile = "" Then
		mSettings.DBFile = "data.db"
	End If
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

' Open database connection
Public Sub Open As SQL
	#If B4J
	Select mDbType
		Case SQLITE
			If mSQL.IsInitialized Then Return mSQL
			mSQL.InitializeSQLite(mSettings.DBDir, mSettings.DBFile, False)
		Case MYSQL, MARIADB
			mSQL = mPool.GetConnection
	End Select
	#Else
	mSQL.Initialize(mSettings.DBDir, mSettings.DBFile, False)
	#End If
	Return mSQL
End Sub

#If B4J
' Connect to database server (asynchronously connection)
Public Sub OpenAsync As ResumableSub
	Try
		Select mDbType
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
		Select mDbType
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
		Select mDbType
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
		Select mDbType
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
		Select mDbType
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
	Select mDbType
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
			mDbType = SQLITE
		Case "MYSQL", "MARIADB"
			BLOB = "mediumblob"
			INTEGER = "int"
			BIG_INT = "bigint"
			DECIMAL = "decimal"
			VARCHAR = "varchar"
			TEXT = "text"
			DATE_TIME = "datetime"
			TIMESTAMP = "timestamp"
			If Name.EqualsIgnoreCase(MYSQL) Then mDbType = MYSQL Else mDbType = MARIADB
	End Select
End Sub

Public Sub getDbType As String
	Return mDbType
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

' May deprecate
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
	If mQueryAddToBatch Then mQueryExecute = False ' Only either one is True
End Sub

Public Sub setQueryExecute (Value As Boolean)
	mQueryExecute = Value
	If mQueryExecute Then mQueryAddToBatch = False ' Only either one is True
End Sub

' Clear Parameters after Query
Public Sub setQueryClearParameters (Value As Boolean)
	mQueryClearParameters = Value
End Sub

Public Sub setAutoIncrement (Value As Boolean)
	mAutoIncrement = Value
End Sub

Public Sub setOptionalNull (Value As Boolean)
	mOptionalNull = Value
End Sub

Public Sub Reset
	Clear
	ClearConditions
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
	mUniqueKeys = ""
	mForeignKeys = ""
	mConstraints = ""
End Sub

' Clear Conditions
Private Sub ClearConditions
	mCondition = ""
	mConditions.Clear
End Sub

' Clear Parameters
Private Sub ClearParameters
	mParameters = Array As Object()
End Sub

Public Sub Results As List
	Return ORMTable.Results
End Sub

'Deprecated
Public Sub Results2 As List
	Return ORMTable.Results2
End Sub

' Query column id
Public Sub Find (ID As Int)
	Find2("id = ?", ID)
End Sub

' Query by single condition
Public Sub Find2 (Statement As String, Parameter As Object)
	Reset
	WhereParam(Statement, Parameter)
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

' Returns first row in results
Public Sub First As Map
	Return ORMTable.First
End Sub

'Deprecated. Returns first row in results with ordered keys
Public Sub First2 As Map
	Return ORMTable.First2
End Sub

' Returns first row in results with specified columns
Public Sub First3 (Columns As List) As Map
	Dim NewMap As Map
	NewMap.Initialize
	For Each Col As String In Columns
		If First.ContainsKey(Col) Then
			NewMap.Put(Col, First.Get(Col))
		End If
	Next
	Return NewMap
End Sub

' Returns last row in results
Public Sub Last As Map
	Return ORMTable.Last
End Sub

'Deprecated. Returns last row in results with ordered keys
Public Sub Last2 As Map
	Return ORMTable.Last2
End Sub

' Returns last row in results with specified columns
Public Sub Last3 (Columns As List) As Map
	Dim NewMap As Map
	NewMap.Initialize
	For Each Col As String In Columns
		If Last.ContainsKey(Col) Then
			NewMap.Put(Col, Last.Get(Col))
		End If
	Next
	Return NewMap
End Sub

Public Sub FirstId As Int
	Return First.Get("id")
End Sub

' Returns number of rows in results
Public Sub RowCount As Int
	Return ORMTable.RowCount
End Sub

' Returns True if RowCount > 0
Public Sub Found As Boolean
	Return RowCount > 0
End Sub

Private Sub SelectAllFromObject
	mStatement = $"SELECT * FROM ${mObject}"$
End Sub

Private Sub SelectFromTableOrView
	Dim ac As Boolean ' Add Comma
	Dim SB As StringBuilder
	SB.Initialize
	If mColumns.IsInitialized Then
		For Each Col In mColumns
			If ac Then SB.Append(", ")
			SB.Append(Col)
			ac = True
		Next
	End If
	Dim Cols As String = SB.ToString
	mStatement = $"SELECT ${IIf(Cols = "", "*", Cols)} FROM ${mObject}"$
End Sub

'Example: IFNULL(amount, 0) AS total
'<code>DB.IfNull("amount", 0, "total")</code>
Public Sub IfNull (ColumnName As String, DefaultValue As Object, AliasName As String) As String
	Return $"IFNULL(${ColumnName}, '${DefaultValue}')"$ & IIf(AliasName = "", $" AS ${ColumnName}"$, $" AS ${AliasName}"$)
End Sub

'Example: GROUP BY id, age
'<code>DB.GroupBy = Array("id", "age")</code>
Public Sub setGroupBy (Columns As List)
	Dim SB As StringBuilder
	SB.Initialize
	For Each Column As String In Columns
		If SB.Length > 0 Then SB.Append(", ") Else SB.Append(" GROUP BY ")
		SB.Append(Column)
	Next
	mGroupBy = SB.ToString
End Sub

'Example: HAVING id > 5 AND age = 21
'<code>DB.Having = Array("id > 5", "age = 21")</code>
Public Sub setHaving (Statements As List)
	Dim SB As StringBuilder
	SB.Initialize
	For Each Statement As String In Statements
		If SB.Length > 0 Then SB.Append(" AND ") Else SB.Append(" HAVING ")
		SB.Append(Statement)
	Next
	mHaving = SB.ToString
End Sub

'Example: ORDER BY id, name DESC
'<code>DB.OrderBy = CreateMap("id": "", "name", "DESC")</code>
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

'Limit number of rows and offset
'Example: LIMIT 10, 10
'<code>DB.Limit = "10, 10"</code>
Public Sub setLimit (Value As String)
	If Value = "" Then
		mLimit = ""
	Else
		mLimit = " LIMIT " & Value
	End If
End Sub

Public Sub SortByLastId
	mOrderBy = " ORDER BY id DESC"
End Sub

' <code>DB.Columns.Add(CreateMap("Name": "product_price", "Type": DB.DECIMAL, "Size": "10,2", "Default": 0.0))</code>
' Name - Column Name (String)
' Type - Column Type (String) e.g INTEGER/DECIMAL/VARCHAR/TIMESTAMP
' Size - Column Length (String) e.g 255/10,2
' Collation - Collation for char (String) e.g COLLATE utf8mb4_unicode_ci
' Default - Default Value (String) e.g "Unknown", 0, utc_timestamp(), datetime('now')
' Function - Use function (Boolean)
' Unique - Is Unique (Boolean)
' Null - Allow Null (Boolean)
' AutoIncrement - Auto increment (Boolean)
Public Sub Map2Column (Props As Map) As ORMColumn
	Dim t1 As ORMColumn
	t1.Initialize
	t1.ColumnName = ""
	t1.ColumnType = ""
	t1.ColumnLength = ""
	t1.Collation = ""
	t1.DefaultValue = ""
	t1.Constraint = ""
	t1.UseFunction = False
	t1.AllowNull = True
	t1.Unique = False
	t1.AutoIncrement = False
	For Each Key As String In Props.Keys
		Select Key.ToLowerCase
			Case "n", "ColumnName".ToLowerCase, "Name".ToLowerCase
				t1.ColumnName = Props.Get(Key)
			Case "t", "ColumnType".ToLowerCase, "Type".ToLowerCase
				t1.ColumnType = Props.Get(Key)
			Case "s", "ColumnLength".ToLowerCase, "ColumnSize".ToLowerCase, "Length".ToLowerCase, "Size".ToLowerCase
				t1.ColumnLength = Props.Get(Key)
			Case "c", "Collation".ToLowerCase
				t1.Collation = Props.Get(Key)
			Case "d", "DefaultValue".ToLowerCase, "Default".ToLowerCase
				t1.DefaultValue = Props.Get(Key)
			Case "k", "Constraint".ToLowerCase
				t1.Constraint = Props.Get(Key)
			Case "f", "UseFunction".ToLowerCase, "Function".ToLowerCase
				t1.UseFunction = Props.Get(Key)
			Case "u", "Unique".ToLowerCase
				t1.Unique = Props.Get(Key)
			Case "an", "Nullable".ToLowerCase, "Null".ToLowerCase, "AllowNull".ToLowerCase
				t1.AllowNull = Props.Get(Key)
			Case "ai", "AutoIncrement".ToLowerCase
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

' Create table or view
' <code>
'DB.Table = "data"
'DB.Columns.Add(CreateMap("name": "col1"))
'DB.Columns = Array("col1", "col2") ' TEXT columns
'DB.Create</code>
Public Sub Create
	Dim SB As StringBuilder
	SB.Initialize
	Dim FirstColumn As Boolean = True
	Dim IsListOfString As Boolean
	Dim Columns As List
	Columns.Initialize
	If mColumns.Size > 0 Then ' Test first item only
		If GetType(mColumns.Get(0)) = "java.lang.String" Then 'Check mColumns is a String array
			IsListOfString = True
		Else
			'Log(mObject & " > " & GetType(mColumns.Get(0)))' expects anywheresoftware.b4a.objects.collections.Map$MyMap
			IsListOfString = False
		End If
		If IsListOfString Then
			For Each colName As String In mColumns
				Dim Col As ORMColumn = CreateColumn(colName, VARCHAR, "", "", "", "", False, True, False, False)
				Columns.Add(Col)
			Next
		Else
			For Each props As Map In mColumns
				Dim Col As ORMColumn = Map2Column(props)
				Columns.Add(Col)
			Next
		End If
	End If
	For Each Col As ORMColumn In Columns
		If FirstColumn = False Then
			SB.Append(",").Append(CRLF)
		End If
		SB.Append(Col.ColumnName)
		SB.Append(" ")
		Select mDbType
			Case SQLITE
				SB.Append(Col.ColumnType)
			Case MYSQL, MARIADB
				Select Col.ColumnType
					Case INTEGER, BIG_INT, DECIMAL, TIMESTAMP, DATE_TIME, TEXT, BLOB
						SB.Append(Col.ColumnType)
					Case Else
						SB.Append(VARCHAR)
				End Select
				If Col.ColumnLength.Length > 0 Then
					SB.Append("(").Append(Col.ColumnLength).Append(")")
				End If
				If Col.Collation.Length > 0 Then
					SB.Append(" ").Append(Col.Collation)
				End If
		End Select
		
		If Col.DefaultValue.Length > 0 Then
			Select Col.ColumnType
				Case INTEGER, BIG_INT, TIMESTAMP, DATE_TIME
					Select mDbType
						Case SQLITE
							If Col.DefaultValue.StartsWith("(") And Col.DefaultValue.EndsWith(")") Then
								SB.Append(" DEFAULT ").Append(Col.DefaultValue)
							Else
								SB.Append(" DEFAULT ").Append("(").Append(Col.DefaultValue).Append(")")
							End If
						Case MYSQL, MARIADB
							SB.Append(" DEFAULT ").Append(Col.DefaultValue)
					End Select
				Case Else
					If Col.UseFunction Then
						If Col.DefaultValue.StartsWith("(") And Col.DefaultValue.EndsWith(")") Then
							SB.Append(" DEFAULT ").Append(Col.DefaultValue)
						Else
							Select mDbType
								Case SQLITE
									SB.Append(" DEFAULT ").Append("(").Append(Col.DefaultValue).Append(")")
								Case MYSQL, MARIADB
									SB.Append(" DEFAULT ").Append(Col.DefaultValue)
							End Select
						End If
					Else
						SB.Append(" DEFAULT ").Append("'").Append(Col.DefaultValue).Append("'")
					End If
			End Select
		End If
		
		If Col.AllowNull Then
			If mOptionalNull = False Then SB.Append(" NULL")
		Else
			SB.Append(" NOT NULL")
		End If
		
		If Col.Unique Then SB.Append(" UNIQUE")
		If Col.AutoIncrement Then
			Select mDbType
				Case SQLITE
					SB.Append(" AUTOINCREMENT")
				Case MYSQL, MARIADB
					SB.Append(" AUTO_INCREMENT")
			End Select
		End If
		FirstColumn = False
	Next
	
	Select mDbType
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
				SB.Append("modified_date " & DATE_TIME)
				If mOptionalNull = False Then SB.Append(" DEFAULT NULL")
				SB.Append(" ON UPDATE CURRENT_TIMESTAMP,").Append(CRLF)
				SB.Append("deleted_date " & DATE_TIME)
				If mOptionalNull = False Then SB.Append(" DEFAULT NULL")
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
	
	' Auto increment id column added by default
	If mAutoIncrement Then
		Dim id As String = "id"
		If mPrimaryKeys.Size = 1 Then
			id = mPrimaryKeys.Get(0)
		End If
		Select mDbType
			Case MYSQL, MARIADB
				stmt.Append($"${id} ${INTEGER}(11) NOT NULL AUTO_INCREMENT,"$).Append(CRLF)
			Case SQLITE
				stmt.Append($"${id} ${INTEGER},"$).Append(CRLF)
		End Select
	End If

	' Put the columns here
	stmt.Append(SB.ToString)

	If mAutoIncrement Then
		Select mDbType
			Case SQLITE
				stmt.Append(",").Append(CRLF)
				stmt.Append($"PRIMARY KEY(${id} AUTOINCREMENT)"$)
			Case MYSQL, MARIADB
				stmt.Append(",").Append(CRLF)
				stmt.Append($"PRIMARY KEY(${id})"$)
		End Select
	Else
		If mPrimaryKeys.Size > 0 Then
			stmt.Append(",").Append(CRLF)
			Dim pk As StringBuilder
			pk.Initialize
			For Each Key As String In mPrimaryKeys
				If pk.Length > 0 Then pk.Append(", ")
				pk.Append(Key)
			Next
			stmt.Append($"PRIMARY KEY(${pk.ToString})"$)
		Else
			Dim chk As String = stmt.ToString
			If chk.EndsWith(",") Then
				LogColor("*** Contains comma", COLOR_RED)
				stmt.Remove(stmt.Length - 1, stmt.Length) ' remove the last comma
			Else
				LogColor("*** Good", COLOR_BLUE)
			End If
		End If
	End If
	
	If mUniqueKeys.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mUniqueKeys)
	End If
	
	If mForeignKeys.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mForeignKeys)
	End If
	
	If mConstraints.Length > 0 Then
		stmt.Append(",")
		stmt.Append(CRLF)
		stmt.Append(mConstraints)
	End If
	
	If mObject = mTable Then stmt.Append(")")
	mStatement = stmt.ToString
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then ExecNonQuery
	mPrimaryKeys.Initialize
End Sub

Public Sub setPrimary (Columns As List)
	If Columns.Size = 0 Then Return
	mPrimaryKeys = Columns
End Sub

' Get/Set Primary Key
' Example: PRIMARY KEY (order_id, product_id)
' <code>DB.Primary = Array("order_id", "product_id")</code>
Public Sub getPrimary As List
	Return mPrimaryKeys
End Sub

' Example: FOREIGN KEY (category_id)
' <code>DB.Foreign = "category_id"</code>
Public Sub setForeign (Column As String) '(ReferenceTable As String, Key As String, ReferenceKey As String, OnDelete As String, OnUpdate As String)
	mForeignKeys = $"FOREIGN KEY (${Column})"$
End Sub

Public Sub getForeign As String
	Return mForeignKeys
End Sub

' Add a references to the statement or append to the Foreign Key
' Example: REFERENCES tbl_categories (id)
' <code>DB.References("tbl_categories", "id")</code>
Public Sub References (Table As String, Column As String)
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(" ").Append("REFERENCES").Append(" ").Append(Table)
	If Column <> "" Then SB.Append(" ").Append("(").Append(Column).Append(")")
	If mForeignKeys.Contains("FOREIGN KEY") Then
		If mForeignKeys.Contains("REFERENCES") Then
			mStatement = mStatement & SB.ToString
		Else
			mForeignKeys = mForeignKeys & SB.ToString
		End If
	Else
		mStatement = mStatement & SB.ToString
	End If
End Sub

' Add table-level unique keys or indexes
' Example: UNIQUE (email, username)
'<code>DB.Unique = Array("email, username")</code>
Public Sub setUnique (Params As List)
	Dim Columns As String = IIf(Params.Size > 0, Params.Get(0), "")
	Dim ConstraintType As String = IIf(Params.Size > 1, "UNIQUE " & Params.Get(1), "UNIQUE")
	mUniqueKeys = $"${ConstraintType} (${Columns})"$
End Sub

' Add table-level constraints
' ConstraintType: UNIQUE KEY, FOREIGN KEY or PRIMARY KEY
' Columns: Column names separated by comma
' Example: CONSTRAINT UC_User UNIQUE (email, username)
'<code>DB.Constraint = Array("email, username", "UNIQUE KEY", "UC_User")</code>
Public Sub setConstraint (Params As List) ' (Columns As String, ConstraintType As String, AliasName As String)
	Dim Columns As String = IIf(Params.Size > 0, Params.Get(0), "")
	Dim ConstraintType As String = IIf(Params.Size > 1, " " & Params.Get(1), "")
	Dim Alias As String = IIf(Params.Size > 2, " " & Params.Get(2), "")
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("CONSTRAINT")
	SB.Append(Alias)
	SB.Append(ConstraintType)
	SB.Append($" (${Columns})"$)
	mConstraints = SB.ToString
End Sub

' Execute Non Query
Public Sub Execute
	ExecNonQuery
End Sub

' Execute Non Query with Object type parameters
Public Sub Execute2 (Parameter() As Object)
	mParameters = Parameter
	If mShowExtraLogs Then LogQuery2
	ExecNonQuery
End Sub

Private Sub ExecQuery As ResultSet
	Try
		Dim RS As ResultSet
		If Opened = False Then
			Return RS
		End If
		If ParametersCount = 0 Then
			If mShowExtraLogs Then LogQuery
			RS = mSQL.ExecQuery(mStatement)
		Else
			If mShowExtraLogs Then LogQuery2
			' B4A requires String Array
			Dim StringParams(mParameters.Length) As String
			For i = 0 To mParameters.Length - 1
				StringParams(i) = mParameters(i)
			Next
			RS = mSQL.ExecQuery2(mStatement, StringParams)
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

' Execute Non Query batch
'<code>Wait For (DB.ExecuteBatchAsync) Complete (Success As Boolean)</code>
Public Sub ExecuteBatchAsync As ResumableSub
	If mShowExtraLogs Then LogQuery3
	Dim SenderFilter As Object = mSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	mQueryExecute = True ' set back to Execute mode
	Return Success
End Sub

' Example: SQL1.ExecQuerySingleResult(mStatement)
'<code>Dim res As Int = DB.ExecuteScalar</code>
Public Sub ExecuteScalar As Object
	If mCondition.Length = 0 Then
		If getCondition.Length > 0 Then mStatement = mStatement & mCondition
	End If	
	Return mSQL.ExecQuerySingleResult(mStatement)
End Sub

' Example: SQL1.ExecQuerySingleResult2(mStatement, mParameters)
'<code>Dim res As Int = DB.ExecuteScalar2</code>
Public Sub ExecuteScalar2 As Object
	If mCondition.Length = 0 Then
		If getCondition.Length > 0 Then mStatement = mStatement & mCondition
	End If	
	Return mSQL.ExecQuerySingleResult2(mStatement, mParameters)
End Sub

' Example: SQL.AddNonQueryToBatch(Statement, Parameters)
' This is handled internally inside the library
Public Sub AddNonQueryToBatch
	mBatch.Add(CreateMap("DB_Statement": mStatement, "DB_Parameters": mParameters))
	mSQL.AddNonQueryToBatch(mStatement, mParameters)
End Sub

'Example: LEFT JOIN tbl_categories c ON p.category_id = c.id
'<code>DB.Join = Array("tbl_categories c", "p.category_id = c.id", "LEFT")</code>
Public Sub setJoin (Params As List)
	Dim Target As String = IIf(Params.Size > 0, Params.Get(0), "")
	Dim Statements As String = IIf(Params.Size > 1, Params.Get(1), "")
	Dim Modifier As String = IIf(Params.Size > 2, Params.Get(2), "")
	mStatement = mStatement & " " & Modifier.Replace("JOIN", "").Trim & " JOIN " & Target & " ON " & Statements
End Sub

' Add new Condition (disregard there are already some)
Public Sub setCondition (Statement As String)
	mConditions.Add(Statement)
End Sub

Public Sub getCondition As String
	Dim SB As StringBuilder
	SB.Initialize
	For Each Statement As String In mConditions
		If SB.Length = 0 Then SB.Append(" WHERE ") Else SB.Append(" AND ")
		SB.Append(Statement)
	Next
	mCondition = SB.ToString
	Return mCondition
End Sub

' Add new list of Conditions
' Formerly known as setWhere
Public Sub setConditions (Statements As List)
	mConditions.AddAll(Statements)
End Sub

Public Sub getConditions As List
	Return mConditions
End Sub

Public Sub setParameter (Param As Object)
	mParameter = Param
	Dim NewArray(mParameters.Length + 1) As Object
	For i = 0 To mParameters.Length - 1
		NewArray(i) = mParameters(i)
	Next
	NewArray(mParameters.Length) = Param
	mParameters = NewArray
End Sub

' Last Parameter
Public Sub getParameter As Object
	Return mParameter
End Sub

Public Sub setParameters (Params() As Object)
	mParameters = Params
	mParameter = mParameters(mParameters.Length - 1)
End Sub

Public Sub getParameters As Object()
	Return mParameters
End Sub

' Append Parameters at the end
Public Sub AppendParameters (Params() As Object)
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
	mParameter = mParameters(mParameters.Length - 1)
End Sub

' Add single condition and parameter
Public Sub WhereParam (Statement As String, Param As Object)
	setCondition(Statement)
	setParameter(Param)
End Sub

' Append new Conditions and Parameters
Public Sub WhereParams (Statements As List, Params() As Object)
	setConditions(Statements)
	AppendParameters(Params)
End Sub

' Execute Query
Public Sub Query
	Try
		mError = Null
		ORMResult.Initialize
		ORMResult.Columns.Initialize
		ORMResult.Rows.Initialize
		ORMResult.Tag = Null 'without this the Tag properly will not be serializable.
		ORMTable.Initialize
		ORMTable.Columns.Initialize
		ORMTable.Rows.Initialize
		ORMTable.Results.Initialize
		ORMTable.Results2.Initialize
		If getCondition.Length > 0 Then mStatement = mStatement & mCondition
		If mGroupBy.Length > 0 Then mStatement = mStatement & mGroupBy
		If mHaving.Length > 0 Then mStatement = mStatement & mHaving
		If mOrderBy.Length > 0 Then mStatement = mStatement & mOrderBy
		If mLimit.Length > 0 Then mStatement = mStatement & mLimit
		Dim RS As ResultSet = ExecQuery
		If mError.IsInitialized Then
			If Initialized(RS) Then RS.Close
			Return
		End If
		ORMTable.ResultSet = RS
		If RS.IsInitialized Then
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
			Dim Columns As Map
			Dim Filled As Boolean
			Do While RS.NextRow
				Dim Row(cols) As Object ' ORMResult (array of object)
				Dim Row2 As List 		' ORMTable (list of object)
				Row2.Initialize
				If Not(Filled) Then Columns.Initialize
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
					If Not(Filled) Then
						Columns.Put(ColumnName, Row(i))
						ORMTable.Columns.Add(ColumnName)
					End If
				Next
				ORMResult.Rows.Add(Row)
				ORMTable.Rows.Add(Row2)
				Filled = True
			Loop
			ORMResult.Columns = Columns
		#End If
		End If
		If Initialized(RS) Then RS.Close ' test 2025-09-18, 2026-03-25
		For Each Rows As List In ORMTable.Rows
			Dim Result As Map
			Dim Result2 As Map
			Result.Initialize
			Result2.Initialize
			Result2.Put("__order", ORMTable.Columns)
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
			ORMTable.Last2 = ORMTable.Results2.Get(ORMTable.Results.Size - 1)
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

'<code>DB.Query2 = Array("param1", "param2")</code>
Public Sub setQuery2 (Params() As Object)
	setParameters(Params)
	Query
End Sub

' Return an object without calling Query
' Note: ORMTable and ORMResults are not affected
Public Sub Scalar As Object
	If ParametersCount = 0 Then
		Return ExecuteScalar
	Else
		Return ExecuteScalar2
	End If
End Sub

' Similar to Scalar but passing Params
Public Sub setScalars (Params() As Object) As Object
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
		SB.Append("created_date")
		Select mDbType
			Case SQLITE
				vb.Append("(datetime('now'))")			
			Case MYSQL, MARIADB
				vb.Append("now()")
		End Select
	End If
	
	mStatement = $"INSERT INTO ${mObject} (${SB.ToString}) VALUES (${vb.ToString})"$
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then ExecNonQuery
End Sub

'<code>DB.Inserts = Array("param1", "param2")</code>
Public Sub setInserts (Params() As Object)
	setParameters(Params)
	Insert
End Sub

' Update must have at least 1 condition
Public Sub Save
	Dim BlnNew As Boolean
	If getCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim SB As StringBuilder
		SB.Initialize
		mStatement = $"UPDATE ${mObject} SET "$
		For Each col As String In mColumns
			If SB.Length > 0 Then SB.Append(", ")
			If col.EqualsIgnoreCase("modified_date") Then md = True
			If col.Contains("=") Then
				SB.Append(col)
			Else If col.EndsWith("++") Then
				col = col.Replace("++", "").Trim
				SB.Append($"${col} = ${col} + 1"$)
			Else
				SB.Append(col & " = ?")
			End If
		Next
		mStatement = mStatement & SB.ToString
		' To handle varchar timestamps
		If mUpdateModifiedDate And Not(md) Then
			Select mDbType
				Case MYSQL, MARIADB
					mStatement = mStatement & ", modified_date = now()"
				Case SQLITE
					mStatement = mStatement & ", modified_date = (datetime('now'))"
			End Select
		End If
		mStatement = mStatement & mCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim SB, vb As StringBuilder
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
			SB.Append("created_date")
			Select mDbType
				Case SQLITE
					vb.Append("(datetime('now'))")
				Case MYSQL, MARIADB
					vb.Append("now()")
			End Select
		End If
		mStatement = $"INSERT INTO ${mObject} (${SB.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then
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
	End If
End Sub

'<code>DB.Save = Array("param1", "param2")</code>
Public Sub setSave2 (Params() As Object)
	setParameters(Params)
	Save
End Sub

' Same as Save but returned row has custom primary key
'<code>DB.Save3 = "UserID"</code>
Public Sub setSave3 (IdColumn As String)
	Dim BlnNew As Boolean
	If getCondition.Length > 0 Then
		Dim md As Boolean ' contains modified_date
		Dim SB As StringBuilder
		SB.Initialize
		mStatement = $"UPDATE ${mObject} SET "$
		For Each col As String In mColumns
			If SB.Length > 0 Then SB.Append(", ")
			If col.EqualsIgnoreCase("modified_date") Then md = True
			If col.Contains("=") Then
				SB.Append(col)
			Else If col.EndsWith("++") Then
				col = col.Replace("++", "").Trim
				SB.Append($"${col} = ${col} + 1"$)
			Else
				SB.Append(col & " = ?")
			End If
		Next
		mStatement = mStatement & SB.ToString
		' To handle varchar timestamps
		If mUpdateModifiedDate And Not(md) Then
			Select mDbType
				Case MYSQL, MARIADB
					mStatement = mStatement & ", modified_date = now()"
				Case SQLITE
					mStatement = mStatement & ", modified_date = (datetime('now'))"
			End Select
		End If
		mStatement = mStatement & mCondition
	Else
		Dim cd As Boolean ' contains created_date
		Dim SB, vb As StringBuilder
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
			SB.Append("created_date")
			Select mDbType
				Case MYSQL, MARIADB
					vb.Append("now()")
				Case SQLITE
					vb.Append("(datetime('now'))")
			End Select
		End If
		mStatement = $"INSERT INTO ${mObject} (${SB.ToString}) VALUES (${vb.ToString})"$
		BlnNew = True
	End If
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then
		ExecNonQuery
		If BlnNew Then
			' View does not support auto-increment id
			'If mObject = mView Then Return
			If mObject = mView Or mAutoIncrement = False Then Return
			Dim NewID As Int = getLastInsertID
			' Return new row
			Find2(IdColumn & " = ?", NewID)
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
	End If
End Sub

Public Sub getLastInsertID As Object
	Select mDbType
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

Public Sub Delete
	mStatement = $"DELETE FROM ${mObject}"$
	If getCondition.Length > 0 Then mStatement = mStatement & mCondition
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then ExecNonQuery
End Sub

Public Sub Drop
	Select mObject
		Case mTable
			mStatement = $"DROP TABLE IF EXISTS ${mObject}"$
		Case mView
			mStatement = $"DROP VIEW IF EXISTS ${mObject}"$
	End Select
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then ExecNonQuery
End Sub

' Execute Delete statement by batch
Public Sub Destroy (ids() As Int) As ResumableSub
	If ids.Length < 1 Then Return False
	For Each id As Int In ids
		mID = id
		mStatement = $"DELETE FROM ${mObject}"$
		mConditions = Array("id = ?")
		mCondition = " WHERE id = ?"
		mStatement = mStatement & mCondition
		mParameter = mID
		mParameters = Array(id)
		If mShowExtraLogs Then LogQuery4(id)
		AddNonQueryToBatch
	Next
	Dim SenderFilter As Object = mSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Return Success
End Sub

Public Sub SoftDelete
	Select mDbType
		Case MYSQL, MARIADB
			mStatement = $"UPDATE ${mObject} SET deleted_date = now()"$
		Case SQLITE
			mStatement = $"UPDATE ${mObject} SET deleted_date = strftime('%s000', 'now')"$
		Case Else
			If mShowExtraLogs Then Log("Unknown DBType")
			Return
	End Select
	If getCondition.Length = 0 Then
		Log("Missing condition")
		Return
	End If
	mStatement = mStatement & mCondition
	If mShowExtraLogs Then LogQuery
	If mQueryAddToBatch Then AddNonQueryToBatch
	If mQueryExecute Then ExecNonQuery
End Sub

' Tests whether the table exists
Public Sub TableExists (TableName As String) As Boolean
	Select mDbType
		Case SQLITE
			' SQLite code extracted from DBUtils
			mStatement = $"SELECT count(name) FROM sqlite_master WHERE type = 'table' AND name = ? COLLATE NOCASE"$
			If mShowExtraLogs Then LogQuery4(TableName)
			Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(TableName))
			Return count > 0
		Case MYSQL, MARIADB
			If mDatabaseName = "" Then
				If mShowExtraLogs Then Log("Unknown DatabaseName")
				Return False
			End If
			mStatement = $"SELECT count(TABLE_NAME) FROM TABLES WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
			If mShowExtraLogs Then LogQuery4(Array As String(mDatabaseName, TableName))
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
		Select mDbType
			Case SQLITE
				mStatement = $"SELECT COUNT(name) FROM main.sqlite_master WHERE type = 'view' AND name = ? COLLATE NOCASE"$
				If mShowExtraLogs Then LogQuery4(ViewName)
				Dim count As Int = mSQL.ExecQuerySingleResult2(mStatement, Array As String(ViewName))
				Return count > 0
			Case MYSQL, MARIADB
				If mDatabaseName = "" Then
					If mShowExtraLogs Then Log("Unknown DatabaseName")
					Return False
				End If
				mStatement = $"SELECT COUNT(TABLE_NAME) FROM VIEWS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?"$
				If mShowExtraLogs Then LogQuery4(Array As String(mDatabaseName, ViewName))
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
		Select mDbType
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
		Select mDbType
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
	If mCondition.Length = 0 Then
		If getCondition.Length > 0 Then mStatement = mStatement & mCondition
	End If
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
Public Sub LogQuery4 (Arg As Object)
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

Private Sub CreateColumn (ColumnName As String, ColumnType As String, ColumnLength As String, Collation As String, DefaultValue As String, Constraint As String, UseFunction As Boolean, AllowNull As Boolean, IsUnique As Boolean, AutoIncrement As Boolean) As ORMColumn
	Dim t1 As ORMColumn
	t1.Initialize
	t1.ColumnName = ColumnName
	t1.ColumnType = ColumnType
	t1.ColumnLength = ColumnLength
	t1.Collation = Collation
	t1.DefaultValue = DefaultValue
	t1.Constraint = Constraint
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