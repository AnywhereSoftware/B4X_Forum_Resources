B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.19
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private pool As ConnectionPool
	Private DebugQueries As Boolean
	Private commands As Map
	Public serverPort As Int
	Public mConfigFolder As String
	Public mConfigFile As String
End Sub

Public Sub Initialize (ConfigFolder As String, ConfigFile As String)
	mConfigFolder = ConfigFolder
	mConfigFile = ConfigFile
	Dim Config As Map = LoadConfigMap
	pool.Initialize(Config.Get("DriverClass"), Config.Get("JdbcUrl"), Config.Get("User"), _
		Config.Get("Password"))
#if DEBUG
	DebugQueries = True
#else
	DebugQueries = False
#end if
	serverPort = Config.Get("ServerPort")
	LoadSQLCommands(Config)
End Sub

Private Sub LoadConfigMap As Map
	Return File.ReadMap(mConfigFolder, mConfigFile)
End Sub

Public Sub GetCommand(Key As String) As String
	If commands.ContainsKey("sql." & Key) = False Then
		Log("*** Command not found: " & Key)
	End If
	Return commands.Get("sql." & Key)
End Sub

Public Sub GetConnection As SQL
	If DebugQueries Then ReloadSQLCommands
	Return pool.GetConnection
End Sub

'Reloads the sql commands from the configuration file.
Public Sub ReloadSQLCommands
	LoadSQLCommands(LoadConfigMap)
End Sub


Private Sub LoadSQLCommands(Config As Map)
	Dim newCommands As Map
	newCommands.Initialize
	For Each k As String In Config.Keys
		If k.StartsWith("sql.") Then
			newCommands.Put(k, Config.Get(k))
		End If
	Next
	commands = newCommands
End Sub