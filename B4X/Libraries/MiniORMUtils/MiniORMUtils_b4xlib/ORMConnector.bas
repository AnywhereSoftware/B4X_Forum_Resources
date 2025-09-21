B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Database Connector class
' Version 3.70
Sub Class_Globals
	Private SQL 			As SQL
	Private CN 				As ConnectionInfo
	Private mType			As String
	Private mError			As Exception
	Private mJournalMode 	As String = "DELETE" 'ignore
	#If B4J
	Private Pool 			As ConnectionPool
	Private mCharacterSet 	As String = "utf8mb4"
	Private mCollate 		As String = "utf8mb4_unicode_ci"
	Private Const MYSQL 	As String = "MYSQL"
	Private Const MARIADB 	As String = "MARIADB"
	#End If
	Private Const SQLITE 	As String = "SQLITE"
	Type ConnectionInfo ( _
	DBDir As String, _
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

Public Sub Initialize (Info As ConnectionInfo)
	mType = Info.DBType.ToUpperCase
	CN.Initialize
	#If B4J
	If mType = SQLITE Then
		CN.DBDir = IIf(Info.DBDir = "", File.DirApp, Info.DBDir)
		CN.DBFile = IIf(Info.DBFile = "", "data.db", Info.DBFile)
		CN.JdbcUrl = Info.JdbcUrl.Replace("{DbDir}", Info.DBDir)
		CN.JdbcUrl = CN.JdbcUrl.Replace("{DbFile}", CN.DBFile)
	End If
	If mType = MYSQL Or mType = MARIADB Then
		CN.User = Info.User
		CN.DBHost = Info.DBHost
		CN.DBPort = Info.DBPort
		CN.DBName = Info.DBName
		CN.JdbcUrl = Info.JdbcUrl
		CN.Password = Info.Password
		CN.DriverClass = Info.DriverClass
	End If
	#Else
	Dim xui As XUI
	CN.DBDir = IIf(Info.DBDir = "", xui.DefaultFolder, Info.DBDir)
	CN.DBFile = IIf(Info.DBFile = "", "data.db", Info.DBFile)
	#End If
End Sub

#If B4J
' Create MySQL or SQLite database
Public Sub DBCreate As ResumableSub
	Try
		Select mType
			Case MYSQL, MARIADB
				If SQL.IsInitialized = False Then
					Wait For (InitSchema) Complete (Success As Boolean)
					If Success = False Then
						Return False
					End If
				End If
				Dim qry As String = $"CREATE DATABASE ${CN.DBName} CHARACTER SET ${mCharacterSet} COLLATE ${mCollate}"$
				SQL.ExecNonQuery(qry)
			Case SQLITE
				Select mJournalMode.ToUpperCase
					Case "WAL"
						'SQL1.Initialize(CN.DriverClass, CN.JdbcUrl)
						'SQL1.ExecNonQuery("PRAGMA journal_mode = wal")
						SQL.InitializeSQLite(CN.DBDir, CN.DBFile, True)
						SQL.ExecQuerySingleResult("PRAGMA journal_mode = wal")
					Case "DELETE"
						SQL.InitializeSQLite(CN.DBDir, CN.DBFile, True)
				End Select
		End Select
	Catch
		Log(LastException)
		mError = LastException
		Return False
	End Try
	DBClose
	Return True
End Sub
#Else
' Create SQLite database
Public Sub DBCreate As Boolean
	Try
		SQL.Initialize(CN.DBDir, CN.DBFile, True)
		If mJournalMode.EqualsIgnoreCase("WAL") Then
		SQL.ExecQuerySingleResult("PRAGMA journal_mode = wal")
		End If
	Catch
		Log(LastException)
		mError = LastException
		Return False
	End Try
	DBClose
	Return True
End Sub
#End If

#If B4J
' Connect to database name (MySQL, MariaDB)
Public Sub InitPool
	Try
		Dim JdbcUrl As String = CN.JdbcUrl
		JdbcUrl = JdbcUrl.Replace("{DbHost}", CN.DBHost)
		JdbcUrl = JdbcUrl.Replace("{DbName}", CN.DBName)
		JdbcUrl = IIf(CN.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", CN.DBPort))
		Pool.Initialize(CN.DriverClass, JdbcUrl, CN.User, CN.Password)
	Catch
		Log(LastException)
		mError = LastException
	End Try
End Sub

' Asynchronously initialize database schema (MySQL, MariaDB)
Public Sub InitSchema As ResumableSub
	Dim JdbcUrl As String = CN.JdbcUrl
	JdbcUrl = JdbcUrl.Replace("{DbHost}", CN.DBHost)
	JdbcUrl = JdbcUrl.Replace("{DbName}", "information_schema")
	JdbcUrl = IIf(CN.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", CN.DBPort))
	SQL.InitializeAsync("DB", CN.DriverClass, JdbcUrl, CN.User, CN.Password)
	Wait For DB_Ready (Success As Boolean)
	If Success = False Then
		Log(LastException)
		mError = LastException
		Return False
	End If
	Return Success
End Sub

' Initialize database schema (MySQL, MariaDB)
Public Sub InitSchema2
	Dim JdbcUrl As String = CN.JdbcUrl
	JdbcUrl = JdbcUrl.Replace("{DbHost}", CN.DBHost)
	JdbcUrl = JdbcUrl.Replace("{DbName}", "information_schema")
	JdbcUrl = IIf(CN.DBPort.Length = 0, JdbcUrl.Replace(":{DbPort}", ""), JdbcUrl.Replace("{DbPort}", CN.DBPort))
	SQL.Initialize2(CN.DriverClass, JdbcUrl, CN.User, CN.Password)
End Sub
#End If

' Check database file exists (SQLite)
Public Sub DBExist As Boolean
	Dim DBFound As Boolean
	If File.Exists(CN.DBDir, CN.DBFile) Then
		DBFound = True
	End If
	Return DBFound
End Sub

#If B4J
' Check database exists (MySQL)
Public Sub DBExist2 As ResumableSub
	Dim DBFound As Boolean
	Try
		If SQL.IsInitialized = False Then
			Wait For (InitSchema) Complete (Success As Boolean)
			If Success = False Then
				Return False
			End If
		End If
		Dim qry As String = "SELECT * FROM SCHEMATA WHERE SCHEMA_NAME = ?"
		Dim RS As ResultSet = SQL.ExecQuery2(qry, Array As String(CN.DBName))
		Do While RS.NextRow
			DBFound = True
		Loop
		RS.Close
	Catch
		Log(LastException)
		mError = LastException
	End Try
	DBClose
	Return DBFound
End Sub
#End If

' Connect to database server
' Note: SQLite uses DBDir and DBFile
Public Sub DBOpen As SQL
	#If B4J
	Select mType
		Case MYSQL, MARIADB
			Return Pool.GetConnection
		Case SQLITE
			SQL.InitializeSQLite(CN.DBDir, CN.DBFile, False)
	End Select
	#Else
	If DBExist Then
		SQL.Initialize(CN.DBDir, CN.DBFile, False)
	End If	
	#End If
	Return SQL
End Sub

#If B4J
' Connect to database server (asynchronously connection)
' Note: SQLite uses JdbcUrl
Public Sub DBOpen2 As ResumableSub
	Try
		Select mType
			Case MYSQL, MARIADB
				Pool.GetConnectionAsync("Pool")
				Wait For Pool_ConnectionReady (DB1 As SQL)
				SQL = DB1
			Case SQLITE
				SQL.InitializeAsync("DB", CN.DriverClass, CN.JdbcUrl, CN.User, CN.Password)
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
	Return SQL
End Sub
#End If

Public Sub DBOpened As Boolean
	Return SQL <> Null And SQL.IsInitialized
End Sub

' Close SQL object
Public Sub DBClose
	If mJournalMode.EqualsIgnoreCase("WAL") Then
		Return
	End If
	If DBOpened Then
		SQL.Close
	End If
End Sub

' Check database can be connected
Public Sub Test As Boolean
	If DBOpened Then
		DBClose
		Return True
	End If
	Return False
End Sub

' Close SQL object
Public Sub Close (mSQL As SQL)
	If mJournalMode.EqualsIgnoreCase("WAL") Then Return
	If mSQL <> Null And mSQL.IsInitialized Then mSQL.Close
End Sub

' Return server date
Public Sub GetDate As String
	Try
		Select mType
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
		If SQL.IsInitialized = False Then
			SQL = DBOpen
		End If
		Dim str As String = SQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	DBClose
	Return str
End Sub

' Return server date (ascynchronous connection)
Public Sub GetDate2 As ResumableSub
	Try
		Select mType
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
		If SQL.IsInitialized = False Then
			SQL = DBOpen
		End If
		Dim str As String = SQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	DBClose
	Return str
End Sub

' Return server timestamp
Public Sub GetDateTime As String
	Try
		Select mType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT NOW()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT DATETIME('now')"$
			Case Else	
				Dim CurrentDateFormat As String = DateTime.DateFormat
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Dim DateValue As String = DateTime.Date(DateTime.Now)
				DateTime.DateFormat = CurrentDateFormat
				Return DateValue
		End Select
		If SQL.IsInitialized = False Then
			SQL = DBOpen
		End If
		Dim str As String = SQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	DBClose
	Return str
End Sub

' Return server timestamp (ascynchronous connection)
Public Sub GetDateTime2 As ResumableSub
	Try
		Select mType
			#If B4J
			Case MYSQL, MARIADB
				Dim qry As String = $"SELECT NOW()"$
			#End If
			Case SQLITE
				Dim qry As String = $"SELECT DATETIME('now')"$
			Case Else
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Return DateTime.Date(DateTime.Now)
		End Select
		If SQL.IsInitialized = False Then
			SQL = DBOpen
		End If
		Dim str As String = SQL.ExecQuerySingleResult(qry)
	Catch
		Log(LastException)
		mError = LastException
	End Try
	DBClose
	Return str
End Sub

Public Sub setError (mMessage As Exception)
	mError = mMessage
End Sub

Public Sub getError As Exception
	Return mError
End Sub

#If B4J
Public Sub setCharacterSet (NewCharSet As String)
	mCharacterSet = NewCharSet
End Sub

Public Sub setCollate (NewCollate As String)
	mCollate = NewCollate
End Sub
#End If

Public Sub setJournalMode (Mode As String)
	mJournalMode = Mode
End Sub

Public Sub getDBFolder As String
	Return CN.DBDir
End Sub

Public Sub getDBType As String
	Return mType
End Sub

' Return SQL query for Last Insert ID based on DBType
Public Sub getLastInsertIDQuery As String
	Select mType
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