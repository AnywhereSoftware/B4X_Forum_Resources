B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private pool As ConnectionPool
	Private DebugQueries As Boolean
	Private commands As Map
	Private IPAddress As String
	Public serverPort As Int
	Private SQLite As SQL
	Public UsePool As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Dim config As Map = LoadConfigMap
	
	'Server configuration options
	IPAddress = ""
	If config.ContainsKey("IPAddress") Then
		Dim m As Matcher = Regex.Matcher("(\d+\.\d+\.\d+\.\d+)", config.Get("IPAddress"))
		If m.Find Then
			IPAddress = m.Group(1)
		Else
			Log($"jRDC ERROR: Invalid IPAddress format in configuration file: ${IPAddress}"$)
		End If
	End If
	serverPort = config.Get("ServerPort")
	
	'Initialize database
	'Either SQLite or standard JDBC
	Dim driverClass As String = config.Get("DriverClass")
	If driverClass.ToLowerCase.Contains("sqlite") Then
		'SQLite configration and initialization
		Dim filePath As String = ""
		Dim fileName As String = "test.db"
		Dim m As Matcher = Regex.Matcher("jdbc:sqlite:(.+)", config.Get("JdbcUrl"))
		If m.Find Then
			Dim aFile As String = m.Group(1)
			filePath = File.GetFileParent(aFile)
			fileName = File.GetName(aFile)
		End If
		Dim createFlag As Boolean = True
		If config.ContainsKey("CreateFile") Then
			Dim aFlag As String = config.Get("CreateFile")
			If aFlag.EqualsIgnoreCase("True") Or aFlag.EqualsIgnoreCase("1") Then 
				createFlag = True
			Else
				createFlag = False
			End If
		End If
#if DEBUG
		Log($"SQLite DB's path: ${filePath}, file name: ${fileName}, create flag: ${createFlag}"$)
#End If
		SQLite.InitializeSQLite(filePath, fileName, createFlag)
		' See https://www.b4x.com/android/forum/threads/webapp-concurrent-access-to-sqlite-databases.39904/#content
		SQLite.ExecNonQuery("PRAGMA journal_mode = wal")
		UsePool = False
	Else
		'JDBC configuration and initialization using pools
		UsePool = True
		pool.Initialize(config.Get("DriverClass"), config.Get("JdbcUrl"), config.Get("User"), _
		config.Get("Password"))
		If config.ContainsKey("PoolSize") Then
			If IsNumber(config.Get("PoolSize")) Then
				Dim poolSize As Int = config.Get("PoolSize")
				Dim jo As JavaObject = pool
				jo.RunMethod("setMaxPoolSize", Array(poolSize))
			End If
		End If
	End If

#if DEBUG
	DebugQueries = True
#else
	DebugQueries = False
#end if
	LoadSQLCommands(config)
End Sub

Public Sub HasIPAddress As Boolean
	Return Not(IPAddress = "")
End Sub

Public Sub GetIPAddress As String
	Return IPAddress
End Sub

Private Sub LoadConfigMap As Map
	Return File.ReadMap(File.DirAssets, "config.properties")
End Sub

'Modified to return empty string ("") if command not found
Public Sub GetCommand(Key As String) As String
	Dim cmd As String = ""
	If commands.ContainsKey("sql." & Key) Then
		cmd = commands.Get("sql." & Key)
	End If
	Return cmd
End Sub

Public Sub GetConnection As SQL
	If DebugQueries Then LoadSQLCommands(LoadConfigMap)
	If UsePool Then
		Return pool.GetConnection
	Else
		Return SQLite
	End If
End Sub


Private Sub LoadSQLCommands(config As Map)
	Dim newCommands As Map
	newCommands.Initialize
	For Each k As String In config.Keys
		If k.StartsWith("sql.") Then
			newCommands.Put(k, config.Get(k))
		End If
	Next
	commands = newCommands
End Sub