B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
' Database Connector class
' Version 1.17
Sub Class_Globals
	Private DB As SQL
	Private Conn As Conn
	#If B4J
	Private Pool As ConnectionPool
	#End If
	Type Conn ( _
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
	MaxPoolSize As Int)
End Sub

Public Sub Initialize (mConn As Conn)
	Conn = mConn
	#If B4A
	If Conn.DBDir = "" Then Conn.DBDir = File.DirInternal
	#Else If B4i
	If Conn.DBDir = "" Then Conn.DBDir = File.DirDocuments
	#Else If B4J
	If Conn.DBDir = "" Then Conn.DBDir = File.DirApp
	'Conn.JdbcUrl = Conn.JdbcUrl.Replace("{DbName}", Conn.DBName)
	Conn.JdbcUrl = Conn.JdbcUrl.Replace("{DbHost}", Conn.DBHost)
	Conn.JdbcUrl = IIf(Conn.DBPort.Length = 0, Conn.JdbcUrl.Replace(":{DbPort}", ""), Conn.JdbcUrl.Replace("{DbPort}", Conn.DBPort))
	Conn.JdbcUrl = IIf(Conn.DBDir.Length = 0, Conn.JdbcUrl.Replace("{DbDir}/", ""), Conn.JdbcUrl.Replace("{DbDir}", Conn.DBDir))
	Conn.JdbcUrl = IIf(Conn.DBFile.Length = 0, Conn.JdbcUrl.Replace("{DbFile}", ""), Conn.JdbcUrl.Replace("{DbFile}", Conn.DBFile))
	#End If
End Sub

' Create SQLite database
Public Sub DBCreate As ResumableSub
	Dim Success As Boolean
	Dim SQL1 As SQL
	Try
		#If B4A or B4i
		SQL1.Initialize(Conn.DBDir, Conn.DBFile, True)
		#Else
		SQL1.InitializeSQLite(Conn.DBDir, Conn.DBFile, True)
		#End If
		Success = True
	Catch
		Log(LastException.Message)
	End Try
	Close(SQL1)
	Return Success
End Sub

#If B4J
' Create SQLite database using WAL mode
Public Sub DBCreateSQLite As ResumableSub
	Dim Success As Boolean
	Dim SQL1 As SQL
	Try
		SQL1.Initialize(Conn.DriverClass, Conn.JdbcUrl)
		SQL1.ExecNonQuery("PRAGMA journal_mode = wal")
		Success = True
	Catch
		Log(LastException.Message)
	End Try
	Close(SQL1)
	Return Success
End Sub

' Create MySQL database using UTF8 charset
Public Sub DBCreateMySQL As ResumableSub
	Dim Success As Boolean
	Dim SQL1 As SQL
	Try
		Wait For (DBSchema) Complete (SQL1 As SQL)
		Dim qry As String = $"CREATE DATABASE ${Conn.DBName} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"$
		SQL1.ExecNonQuery(qry)
		Success = True
	Catch
		Log(LastException.Message)
	End Try
	Close(SQL1)
	Return Success
End Sub
#End If

' Check database file exists (SQLite)
Public Sub DBExist As Boolean
	Dim DBFound As Boolean
	If File.Exists(Conn.DBDir, Conn.DBFile) Then
		DBFound = True
	End If
	Return DBFound
End Sub

#If B4J
' Check database exists (MySQL)
Public Sub DBExist2 As ResumableSub
	Dim DBFound As Boolean
	Dim SQL1 As SQL
	Try
		Dim qry As String = "SELECT * FROM SCHEMATA WHERE SCHEMA_NAME = ?"
		Wait For (DBSchema) Complete (SQL1 As SQL)
		If SQL1 <> Null And SQL1.IsInitialized Then
			Dim rs As ResultSet = SQL1.ExecQuery2(qry, Array As String(Conn.DBName))
			Do While rs.NextRow
				DBFound = True
			Loop
			rs.Close
		End If
	Catch
		LogError(LastException.Message)
	End Try
	Close(SQL1)
	Return DBFound
End Sub
#End If

' Connect to database server
' Note: SQLite uses DBDir and DBFile
Public Sub DBOpen As SQL
	#If B4A or B4i
	If DBExist Then
		'File.Delete(Conn.DBDir, Conn.DBFile)
		DB.Initialize(Conn.DBDir, Conn.DBFile, False)
	End If
	#End If
	#If B4J
	Select Conn.DBType.ToUpperCase
		Case "MYSQL"
			If Conn.MaxPoolSize > 0 Then
				If Pool.IsInitialized = False Then
					Conn.JdbcUrl = Conn.JdbcUrl.Replace("{DbName}", Conn.DBName)
					Pool.Initialize(Conn.DriverClass, Conn.JdbcUrl, Conn.User, Conn.Password)
					Dim jo As JavaObject = Pool
					jo.RunMethod("setMaxPoolSize", Array(Conn.MaxPoolSize))
				End If
				DB = Pool.GetConnection
			Else
				DB.Initialize2(Conn.DriverClass, Conn.JdbcUrl, Conn.User, Conn.Password)
			End If
		Case "SQLITE"
			DB.InitializeSQLite(Conn.DBDir, Conn.DBFile, False)
	End Select
	#End If
	Return DB
End Sub

#If B4J
' Connect to database server (asynchronously connection)
' Note: SQLite uses JdbcUrl
Public Sub DBOpen2 As ResumableSub
	Try
		Select Conn.DBType.ToUpperCase
			Case "MYSQL"
				If Conn.MaxPoolSize > 0 Then
					If Pool.IsInitialized = False Then
						Conn.JdbcUrl = Conn.JdbcUrl.Replace("{DbName}", Conn.DBName)
						Pool.Initialize(Conn.DriverClass, Conn.JdbcUrl, Conn.User, Conn.Password)
						If Conn.MaxPoolSize > 0 Then
							Dim jo As JavaObject = Pool
							jo.RunMethod("setMaxPoolSize", Array(Conn.MaxPoolSize))
						End If
					End If
					Pool.GetConnectionAsync("Pool")
					Wait For Pool_ConnectionReady (DB1 As SQL)
					DB = DB1
				Else
					DB.InitializeAsync("DB", Conn.DriverClass, Conn.JdbcUrl, Conn.User, Conn.Password)
					Wait For DB_Ready (Success As Boolean)
					If Success = False Then
						Log(LastException)
					End If
				End If
			Case "SQLITE"
				DB.InitializeAsync("DB", Conn.DriverClass, Conn.JdbcUrl, Conn.User, Conn.Password)
				Wait For DB_Ready (Success As Boolean)
				If Success = False Then
					Log(LastException)
				End If
		End Select
	Catch
		LogError(LastException.Message)
	End Try
	Return DB
End Sub

' Connect to database schema (MySQL)
Public Sub DBSchema As ResumableSub
	Try
		Dim Schema As String = "information_schema"
		Dim JdbcUrl2 As String = Conn.JdbcUrl
		JdbcUrl2 = JdbcUrl2.Replace("{DbName}", Schema)
		JdbcUrl2 = JdbcUrl2.Replace("{DbHost}", Conn.DBHost)
		JdbcUrl2 = IIf(Conn.DBPort.Length = 0, JdbcUrl2.Replace(":{DbPort}", ""), JdbcUrl2.Replace("{DbPort}", Conn.DBPort))
		DB.InitializeAsync("DB", Conn.DriverClass, JdbcUrl2, Conn.User, Conn.Password)
		Wait For DB_Ready (Success As Boolean)
		If Success = False Then
			Log(LastException)
		End If
	Catch
		LogError(LastException.Message)
	End Try
	Return DB
End Sub
#End If

' Close DB object
Public Sub DBClose
	Select Conn.DBType.ToUpperCase
		Case "SQLITE"
			' Do not close SQLite object in multi-threaded server handler in release mode
			#If Not(server)
			If DB <> Null And DB.IsInitialized Then DB.Close
			#End If
		Case Else
			If DB <> Null And DB.IsInitialized Then DB.Close
	End Select
End Sub

' Check database can be connected
Public Sub DBTest As Boolean
	Dim con As SQL = DBOpen
	If con <> Null And con.IsInitialized Then
		con.Close
		Return True
	End If
	Return False
End Sub

' Close SQL object
Public Sub Close (SQL1 As SQL)
	Select Conn.DBType.ToUpperCase
		Case "SQLITE"
			' Do not close SQLite object in multi-threaded server handler in release mode
			#If Not(server)
			If SQL1 <> Null And SQL1.IsInitialized Then SQL1.Close
			#End If
		Case Else
			If SQL1 <> Null And SQL1.IsInitialized Then SQL1.Close
	End Select
End Sub

' Return server date
Public Sub GetDate As String
	Try
		Select Conn.DBType.ToUpperCase
			Case "MYSQL"
				Dim qry As String = $"SELECT CURDATE()"$
			Case "SQLITE"
				Dim qry As String = $"SELECT DATE('now')"$
			Case Else
				Dim CurrentDateFormat As String = DateTime.DateFormat
				DateTime.DateFormat = "yyyy-MM-dd"
				Dim DateValue As String = DateTime.Date(DateTime.Now)
				DateTime.DateFormat = CurrentDateFormat
				Return DateValue
		End Select
		Dim con As SQL = DBOpen
		Dim str As String = con.ExecQuerySingleResult(qry)
	Catch
		Log(LastException.Message)
	End Try
	Close(con)
	Return str
End Sub

' Return server date (ascynchronous connection)
Public Sub GetDate2 As ResumableSub
	Try
		Select Conn.DBType.ToUpperCase
			Case "MYSQL"
				Dim qry As String = $"SELECT CURDATE()"$
			Case "SQLITE"
				Dim qry As String = $"SELECT DATE('now')"$
			Case Else
				DateTime.DateFormat = "yyyy-MM-dd"
				Return DateTime.Date(DateTime.Now)
		End Select
		#If B4J
		Wait For (DBOpen2) Complete (con As SQL)
		#Else
		Dim con As SQL = DBOpen
		#End If
		Dim str As String = con.ExecQuerySingleResult(qry)
	Catch
		Log(LastException.Message)
	End Try
	Close(con)
	Return str
End Sub

' Return server timestamp
Public Sub GetDateTime As String
	Try
		Select Conn.DBType.ToUpperCase
			Case "MYSQL"
				Dim qry As String = $"SELECT NOW()"$
			Case "SQLITE"
				Dim qry As String = $"SELECT DATETIME('now')"$
			Case Else	
				Dim CurrentDateFormat As String = DateTime.DateFormat
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Dim DateValue As String = DateTime.Date(DateTime.Now)
				DateTime.DateFormat = CurrentDateFormat
				Return DateValue
		End Select
		Dim con As SQL = DBOpen
		Dim str As String = con.ExecQuerySingleResult(qry)
	Catch
		Log(LastException.Message)
	End Try
	Close(con)
	Return str
End Sub

' Return server timestamp (ascynchronous connection)
Public Sub GetDateTime2 As ResumableSub
	Try
		Select Conn.DBType.ToUpperCase
			Case "MYSQL"
				Dim qry As String = $"SELECT NOW()"$
			Case "SQLITE"
				Dim qry As String = $"SELECT DATETIME('now')"$
			Case Else
				DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
				Return DateTime.Date(DateTime.Now)
		End Select
		#If B4J
		Wait For (DBOpen2) Complete (con As SQL)
		#Else
		Dim con As SQL = DBOpen
		#End If		
		Dim str As String = con.ExecQuerySingleResult(qry)
	Catch
		Log(LastException.Message)
	End Try
	Close(con)
	Return str
End Sub

Public Sub getDBFolder As String
	Return Conn.DBDir
End Sub

' Return DBType
Public Sub getDBEngine As String
	Return Conn.DBType
End Sub

' Return SQL query for Last Insert ID based on DBType
Public Sub getLastInsertIDQuery As String
	Select Conn.DBType.ToUpperCase
		Case "MYSQL"
			Dim qry As String = "SELECT LAST_INSERT_ID()"
		Case "SQLITE"
			Dim qry As String = "SELECT LAST_INSERT_ROWID()"
		Case Else
			Dim qry As String = "SELECT 0"
	End Select
	Return qry
End Sub