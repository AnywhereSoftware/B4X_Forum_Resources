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
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Dim config As Map = LoadConfigMap
	pool.Initialize(config.Get("DriverClass"), config.Get("JdbcUrl"), config.Get("User"), _
		config.Get("Password"))
#if DEBUG
	DebugQueries = True
#else
	DebugQueries = False
#end if
	serverPort = config.Get("ServerPort")
	LoadSQLCommands(config)
End Sub

Private Sub LoadConfigMap As Map
	Return File.ReadMap(File.DirAssets, "config.properties")
End Sub

Public Sub GetCommand(Key As String) As String
	If commands.ContainsKey("sql." & Key) = False Then
		Log("*** Command not found: " & Key)
	End If
	Return commands.Get("sql." & Key)
End Sub

Public Sub GetConnection As SQL
	If DebugQueries Then LoadSQLCommands(LoadConfigMap)
	Return pool.GetConnection
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