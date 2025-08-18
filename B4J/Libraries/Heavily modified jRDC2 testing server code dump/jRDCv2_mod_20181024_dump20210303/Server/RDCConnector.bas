B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class module
Sub Class_Globals
	'Private pool As ConnectionPool
	Private pool As ConnectionPoolManager
	Private DebugQueries As Boolean
	Private commands As Map
	Public serverPort As Int
	'Added variables
	Private IPAddress As String
	Private noPoolSQL As SQL
	Public usePool As Boolean = True
	Private poolProperties As Map
	Private driverProperties As Map
	Private configLocation As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aPath As String)
	If aPath.Trim = "" Or aPath = Null Then aPath = File.DirAssets
	configLocation = aPath
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
		noPoolSQL.InitializeSQLite(filePath, fileName, createFlag)
		' See https://www.b4x.com/android/forum/threads/webapp-concurrent-access-to-sqlite-databases.39904/#content
		noPoolSQL.ExecNonQuery("PRAGMA journal_mode = wal")
		usePool = False
	Else
		Dim jdbcUrl As String = config.Get("JdbcUrl")
		Dim aUser As String = config.Get("User")
		Dim aPassword As String = config.Get("Password")
		If config.ContainsKey("UsePool") Then
			Dim tmp As String = config.Get("UsePool")
			If tmp.Trim.EqualsIgnoreCase("false") Or tmp.Trim = "0" Then usePool = False
		End If
		If usePool Then
			pool.Initialize
			Dim poolType As String = ""
			If config.ContainsKey("PoolType") Then
				poolType = config.Get("PoolType")
			End If
			Dim poolSize As Int = 0
			If config.ContainsKey("PoolSize") Then
				poolSize = config.Get("PoolSize")
			End If

			pool.CreatePool(poolType, driverClass, jdbcUrl, aUser, aPassword, poolSize)
			LoadPoolProperties(poolType, config)
			pool.SetProperties(poolProperties)
			If config.ContainsKey("DriverShortName") Then
				LoadDriverProperties(config.Get("DriverShortName"), config)
			End If
		Else
			noPoolSQL.Initialize2(driverClass, jdbcUrl, aUser, aPassword)
			Log("Using no pool with:")
			Log($"	Driver class: ${driverClass}"$)
			Log($"	JDBC URL: ${jdbcUrl}"$)
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

'Private Sub LoadConfigMap As Map
'	Return File.ReadMap(File.DirAssets, "config.properties")
'End Sub
Private Sub LoadConfigMap As Map
	If File.DirAssets.EqualsIgnoreCase(configLocation) = False And File.Exists(configLocation, "config.properties") = False Then
		File.Copy(File.DirAssets, "config.properties", configLocation, "config.properties")
	End If
	Return File.ReadMap(configLocation, "config.properties")
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
	If usePool Then
		Return pool.GetConnection
	Else
		Return noPoolSQL
	End If
End Sub

Public Sub ClosePool
	Log("RDCConnector ClosePool")
	If usePool Then
		pool.ClosePool
	End If
End Sub

Private Sub LoadSQLCommands(config As Map)
'	Dim newCommands As Map
'	newCommands.Initialize
'	For Each k As String In config.Keys
'		If k.StartsWith("sql.") Then
'			newCommands.Put(k, config.Get(k))
'		End If
'	Next
'	commands = newCommands
	Log("LoadSQLCommands")
	commands = ExtractProperties("sql.", config, "sql.", Null)
	If config.ContainsKey("DriverShortName") Then
		LoadDriverSQLCommands(config.Get("DriverShortName"), config)
	End If
	LogMap(commands)
End Sub

Private Sub LogMap(aMap As Map)
	For Each k As String In aMap.Keys
		Log($"Key: ${k}, Value: ${aMap.Get(k)}"$)
	Next
End Sub

Private Sub LoadDriverSQLCommands(driverShortName As String, config As Map)
'	If commands.IsInitialized = False Then commands.Initialize
'	For Each k As String In config.Keys
'		'Log("Command: " & k)
'		If k.StartsWith($"sql_${driverShortName}."$) Then
'			Log($"Found driver SQL property: ${k} with value ${config.Get(k)}"$)
'			commands.Put(k.Replace($"sql_${driverShortName}."$,"sql."), config.Get(k))
'		End If
'	Next
	Log("LoadDriverSQLCommands")
	commands = ExtractProperties($"sql_${driverShortName}."$, config, "sql.", commands)
End Sub

Private Sub LoadPoolProperties(poolType As String, config As Map)
	poolProperties = ExtractProperties($"pool.${poolType.ToLowerCase}."$, config, Null, Null)
End Sub

'Play with maps and see if they are case sensitive
Private Sub ExtractProperties(prefix As String, input As Map, newPrefix As String, output As Map) As Map
	Dim properties As Map
	If output = Null Or output.IsInitialized = False Then
		properties.Initialize
	Else
		properties = output
	End If
	If newPrefix.EqualsIgnoreCase(Null) Then newPrefix = ""
	Dim prefixLength As Int = prefix.Length
	For Each k As String In input.Keys
		If k.ToLowerCase.StartsWith(prefix) Then
			Log($"found ${prefix}"$)
			properties.Put($"${newPrefix}${k.SubString(prefixLength)}"$, input.Get(k))
		End If
	Next
	Return properties
End Sub

'Does not need to be that complicated. The property for JDBC driver is as string with the value separated from the
'property via an equals sign
'property=value
'Wrong. Hikari wants them separate in addDataSourceProperty method
'Tomcat wants string format
'Ugh
'Looks like Hikari sends two strings. Could make it a
'property=value
'and split it depending on pool's property mechanism
'Vibur uses setDriverProperties(Properties driverProperties), where Properties is java.utils.Properties
'can user Properties setProperty(String key, String value) method to prepare the a Properties object to pass onto
'setDriverProperties
'HSQLDB uses Properties
'Update: Hikari can use Properties
'setDataSourceProperties(Properties dsProperties)

Private Sub LoadDriverProperties(driverShortName As String, config As Map)
	driverProperties = ExtractProperties($"driver.${driverShortName}."$, config, Null, Null)
End Sub