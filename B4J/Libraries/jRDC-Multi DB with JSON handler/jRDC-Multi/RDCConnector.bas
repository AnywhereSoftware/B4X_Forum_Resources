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
	Dim commands As Map
	Public serverPort As Int
	Public usePool As Boolean = True
	Dim config As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(DB As String)
'	Log("RDCConnector Initialize")
	If DB.EqualsIgnoreCase("DB1") Then DB = "" 'Esto para el config.properties por default
	Dim config As Map = LoadConfigMap(DB)
	Log($"Inicializamos ${DB}, usuario: ${config.Get("User")}"$)
	pool.Initialize(config.Get("DriverClass"), config.Get("JdbcUrl"), config.Get("User"), config.Get("Password"))
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(5)) 'number of concurrent connections

'	com.mchange.v2.c3p0.ComboPooledDataSource [ 
'		acquireIncrement -> 3, 
'		acquireRetryAttempts -> 30, 
'		acquireRetryDelay -> 1000, 
'		autoCommitOnClose -> False, 
'		automaticTestTable -> Null, 
'		breakAfterAcquireFailure -> False, 
'		checkoutTimeout -> 20000, 
'		connectionCustomizerClassName -> Null, 
'		connectionTesterClassName -> com.mchange.v2.c3p0.impl.DefaultConnectionTester, 
'		contextClassLoaderSource -> caller, 
'		dataSourceName -> 2rvxvdb7cyxd8zlw6dyb|63021689, 
'		debugUnreturnedConnectionStackTraces -> False, 
'		description -> Null, 
'		driverClass -> oracle.jdbc.driver.OracleDriver, 
'		extensions -> {}, 
'		factoryClassLocation -> Null, 
'		forceIgnoreUnresolvedTransactions -> False, 
'		forceSynchronousCheckins -> False, 
'		forceUseNamedDriverClass -> False, 
'		identityToken -> 2rvxvdb7cyxd8zlw6dyb|63021689, 
'		idleConnectionTestPeriod -> 600, 
'		initialPoolSize -> 3, 
'		jdbcUrl -> jdbc:oracle:thin:@//10.0.0.110:1521/DBKMT, 
'		maxAdministrativeTaskTime -> 0, 
'		maxConnectionAge -> 0, 
'		maxIdleTime -> 1800, 
'		maxIdleTimeExcessConnections -> 0, 
'		maxPoolSize -> 5, 
'		maxStatements -> 150, 
'		maxStatementsPerConnection -> 0, 
'		minPoolSize -> 3, 
'		numHelperThreads -> 3, 
'		preferredTestQuery -> DBMS_SESSION.SET_IDENTIFIER('whatever'), 
'		privilegeSpawnedThreads -> False, 
'		properties -> {password=******, user=******}, 
'		propertyCycle -> 0, 
'		statementCacheNumDeferredCloseThreads -> 0, 
'		testConnectionOnCheckin -> False, 
'		testConnectionOnCheckout -> True, 
'		unreturnedConnectionTimeout -> 0, 
'		userOverrides -> {}, 
'		usesTraditionalReflectiveProxies -> False
'	]

'	Dim jo2 As JavaObject = pool
'	Log(jo2.GetField("END_TO_END_CLIENTID_INDEX"))

'	jo.RunMethod("setPreferredTestQuery", Array("BEGIN DBMS_SESSION.SET_IDENTIFIER('whatever'); END;"))
'	jo.RunMethod("setPreferredTestQuery", Array("alter session set current_schema=MYSCHEMA"))
'	jo2.RunMethod("setClientIdentifier",Array( "MAX")) ' Tiempo máximo de inactividad antes de cerrar una conexión
#if DEBUG
	DebugQueries = True
#else
	DebugQueries = False
#end if
	serverPort = config.Get("ServerPort")
	If DB = "" Then DB = "DB1"
	LoadSQLCommands(config, DB)
End Sub

Private Sub LoadConfigMap(DB As String) As Map
	Private DBX As String = ""
	If DB <> "" Then DBX = "." & DB
	Log("===========================================")
	Log($"Leemos el config${DBX}.properties"$)
	Return File.ReadMap("./", "config" & DBX & ".properties")
End Sub

Public Sub GetCommand(DB As String, Key As String) As String
	Log("==== GetCommand ====")
'	Log("|" & DB & "|" & Key & "|")
	commands = Main.commandsMap.get(DB).As(Map)
	If commands.ContainsKey("sql." & Key) = False Then
		Log("*** Command not found: " & Key)
	End If
'	Log(commands.ContainsKey("sql." & Key))
	Log("=========  Traemos """ & Key & """  ==========")
	Log(">>>>>>   " & commands.Get("sql." & Key) & "      <<<<<<")
	Return commands.Get("sql." & Key)
End Sub

Public Sub GetConnection(DB As String) As SQL
	Log("==== GetConnection ==== ")
	If DB.EqualsIgnoreCase("DB1") Then DB = "" 'Esto para el config.properties or default
	If DebugQueries Then LoadSQLCommands(LoadConfigMap(DB), DB)
	Return pool.GetConnection
End Sub

Private Sub LoadSQLCommands(config2 As Map, DB As String)
	Log("==== LoadSQLCommands ==== ")
	Log($"Cargamos los comandos desde el config.${DB}.properties"$)
	Dim newCommands As Map
	newCommands.Initialize
	For Each k As String In config2.Keys
		If k.StartsWith("sql.") Then
			newCommands.Put(k, config2.Get(k))
		End If
	Next
	commands = newCommands
'	Log($"Inicializado: ${DB} "$ & Main.commandsMap.IsInitialized)
	Main.commandsMap.Put(DB, commands)
End Sub
