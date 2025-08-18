B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Class module
'Author: Oliver Ackermann
'Created on: 2018/05/08

Sub Class_Globals
	Private pools As Map
	Private pool As Object 'Connection pool object
	Private poolJO As JavaObject
	Private standardConnection As Boolean
	Private activePool As Boolean
	Private defaultPoolType As String
End Sub

'Initialze ConnectionPoolWrapper
Public Sub Initialize
	Reset
End Sub

Private Sub Reset
	Dim H2Pool As H2ConnectionPool
	H2Pool.Initialize
	Dim HSQLPool As HSQLDBConnectionPool
	HSQLPool.Initialize
	Dim HikariPool As HikariConnectionPool
	HikariPool.Initialize
	Dim C3P0Pool As C3P0ConnectionPool
	C3P0Pool.Initialize
	Dim TomcatPool As TomcatConnectionPool
	TomcatPool.Initialize
	Dim ViburPool As ViburConnectionPool
	ViburPool.Initialize
	pools.Initialize
	pools.Put("H2", H2Pool)
	pools.Put("HSQLDB", HSQLPool)
	pools.Put("Hikari", HikariPool)
	pools.Put("C3P0", C3P0Pool)
	pools.Put("Tomcat", TomcatPool)
	pools.Put("Vibur", ViburPool)
	defaultPoolType = "C3P0"
	standardConnection = False
	activePool = False
End Sub

'Create a given pool type
' poolType - type of connection pool to create.
' driverClass - JDBC driver class.
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
' poolSize - Maximum size of connection pool.
Public Sub CreatePool(poolType As String, driverClass As String, jdbcUrl As String, aUser As String, aPassword As String, poolSize As Int)
	'Check poolType
	If pools.ContainsKey(poolType) = False Then
		Log($"Warning: Connection pool type ${poolType} not supported"$)
		If poolType = defaultPoolType Then
			Log($"	Error: Default pool type ${poolType} not supported."$)
			Return
		Else
			Log($"	Switching to default pool type ${defaultPoolType}"$)
			If pools.ContainsKey(defaultPoolType) Then
				poolType = defaultPoolType
			Else
				Log($"	Error: Default pool type ${defaultPoolType} not supported."$)
				Return
			End If
		End If
	End If
	Dim thePool As Object = pools.Get(poolType)
	
	'Check jdbcUrl
	If jdbcUrl.StartsWith("jdbc:") = False Then
		Log($"Error: Invalid JDBC URL: ${jdbcUrl}"$)
		Return
	End If
	If SubExists(thePool, "SupportUrl") And CallSub2(thePool, "SupportUrl", jdbcUrl) = False Then
		Log($"Error: Unsupported JDBC URL: ${jdbcUrl}"$)
		Return
	End If
	
	'Initialize pool
	Dim options As Map
	options.Initialize
	options.Put("driver", driverClass)
	options.Put("url", jdbcUrl)
	options.Put("user", aUser)
	options.Put("password", aPassword)
	options.Put("poolsize", poolSize)
	CallSub2(thePool, "CreatePool3", options)
	
	'See if we can use own GetConnection without use of CallSub
	If SubExists(thePool, "IsStandardConnection") And CallSub(thePool, "IsStandardConnection") Then
		standardConnection = True
		Log($"Info: ${poolType} supports getConnection JavaObject method."$)
		poolJO = CallSub(thePool, "GetPoolJO")
	Else
		Log($"Info: ${poolType} does not support getConnection JavaObject Method."$)
		Log($"Info: Checking if ${poolType} has alternative GetConnection method."$)
		If SubExists(thePool, "GetConnection") = False Then
			Log($"Error: ${poolType} has no GetConnection method."$)
			Return
		End If
	End If
	
	'Everthing looks good sofar
	pool = thePool
	activePool = True
End Sub

Public Sub SetProperties(properties As Map)
	CallSub2(pool, "SetProperties", properties)
End Sub

'Retrieves a connection from the pool. Make sure to close the connection when you are done with it.
Public Sub GetConnection As SQL
	Dim newSQL As SQL
	If standardConnection Then
		Dim jo As JavaObject = newSQL
		jo.SetField("connection", poolJO.RunMethod("getConnection", Null))
	Else
		newSQL = CallSub(pool, "GetConnection")
	End If
	Return newSQL
End Sub

'Closes all unused pooled connections.
Public Sub ClosePool
	Log("ConnectionManager ClosePool")
	If activePool Then
		Log("About to call Connection Pool's ClosePool")
		CallSub(pool, "ClosePool")
		Log("Returned from Connection Pool's ClosePool")
	End If
	Log("Re-initializing Connection Pool Manager")
	Reset
	Log("Done")
End Sub