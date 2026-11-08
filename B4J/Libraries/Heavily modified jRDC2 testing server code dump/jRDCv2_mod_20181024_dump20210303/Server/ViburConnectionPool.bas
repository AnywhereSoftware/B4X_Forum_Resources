B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Class module
'Author: Oliver Ackermann
'Created on: 2018/05/11
'Based on: https://github.com/AnywhereSoftware/B4J_Server/blob/master/src/anywheresoftware/b4j/object/ConnectionPool.java
'Resources:
'  http://www.vibur.org/
'  driverProperties used to set connection properties

Sub Class_Globals
	Private poolJO As JavaObject
	Private poolProperties As Map
End Sub

Public Sub Initialize
	Dim properties As Map
	properties.Initialize
	'
	'Pool Sizing and Fairness Settings
	properties.Put("PoolInitialSize", "int")
	properties.Put("PoolMaxSize", "int")
	properties.Put("PoolFair", "boolean")
	properties.Put("PoolEnableConnectionTracking", "boolean")
	'
	'Connection Timeouts and Retries Settings
	properties.Put("ConnectionTimeOutInMs", "int")
	properties.Put("LoginTimeoutInSeconds", "int")
	properties.Put("AquireRetryDealyInMs", "int")
	properties.Put("AquireRetryAttempt", "int")
	'
	'Connection Validation Settings
	properties.Put("ConnectionIdleLimitInSeconds", "int")
	properties.Put("ValidateTimeoutInSeconds", "int")
	properties.Put("TestConnectionQuery", "string")
	properties.Put("InitSQL", "string")
	'
	'Slow SQL Queries and Large ResultSets Logging Settings
	properties.Put("LogQueryExecutionLongerThanMs", "int")
	properties.Put("LogStackTraceForLongQueryExecution", "boolean")
	properties.Put("LogLargeResultSet", "int")
	properties.Put("LogStackTraceForLargeResultSet", "boolean")
	properties.Put("IncludeQueryParameters", "boolean")
	'
	'Slow getConnection() Calls and Timeouts Logging Settings
	properties.Put("LogConnectionLongerThanMs", "int")
	properties.Put("LogStackTraceForLongConnection", "boolean")
	properties.Put("LogTakenConnectionsOnTimeout", "boolean")
	properties.Put("LogAllStackTracesOnTimeout", "boolean")
	'
	'Connection Default Behavior Settings
	properties.Put("ClearSQLWarnings", "boolean")
	properties.Put("ResetDefaultsAfterUse", "boolean")
	'
	'JDBC Statement Caching Settings
	properties.Put("StatementCacheMaxSize", "int")
	'
	'JMX Related Settings
	properties.Put("EnableJMX", "boolean")
	poolProperties = properties
End Sub

'Creates the pool.
' driverClass - The JDBC driver class.
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
Public Sub CreatePool(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String)
	CreatePool2(driverClass, jdbcUrl, aUser, aPassword, 0)
End Sub

'Creates the pool.
' driverClass - The JDBC driver class.
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
' poolSize - Maximum size of connection pool. Pool's default used when < 1.
Public Sub CreatePool2(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String, poolSize As Int)
	Dim jo As JavaObject
	poolJO = jo.InitializeNewInstance("org.vibur.dbcp.ViburDBCPDataSource", Null)
	poolJO.RunMethod("setDriverClassName",Array As Object(driverClass))
	poolJO.RunMethod("setJdbcUrl", Array As Object(jdbcUrl))
	poolJO.RunMethod("setUsername", Array As Object(aUser))
	poolJO.RunMethod("setPassword", Array As Object(aPassword))
	If poolSize > 0 Then poolJO.RunMethod("setPoolMaxSize", Array As Object(poolSize))
	poolJO.RunMethod("start", Null)
End Sub

Public Sub CreatePool3(options As Map)
	CreatePool2(options.Get("driver"), options.Get("url"), options.Get("user"), options.Get("password"), options.Get("poolsize"))
End Sub

'https://github.com/vibur/vibur-dbcp/blob/master/src/main/java/org/vibur/dbcp/ViburDBCPDataSource.java
'Can use Properties object to create pool
Public Sub SetProperties(properties As Map)
	Dim intValue As Int
	Dim booleanValue As Boolean
	Dim variableType As String
	
	For Each k As String In properties.Keys
		If poolProperties.ContainsKey(k) Then
			variableType = poolProperties.Get(k)
			If variableType = "int" Then
				intValue = properties.Get(k)
				poolJO.RunMethod($"set${k}"$, Array As Object(intValue))
			Else If variableType = "string" Then
				poolJO.RunMethod($"set${k}"$, Array As Object(properties.Get(k)))
			Else If variableType = "boolean" Then
				booleanValue = properties.Get(k)
				GetPoolJO.RunMethod($"set${k}"$, Array As Object(booleanValue))
			Else
				Log($"Connection pool property ${k} has unsupported variable type of ${variableType}"$)
			End If
		Else
			Log("Warning: Property ${k} not supported")
		End If
		Log($"Property: ${k}, Value: ${properties.Get(k)}"$)
	Next
End Sub

'Check if JDBC URL is supported
Public Sub SupportUrl(jdbcUrl As String) As Boolean
	If jdbcUrl.StartsWith("jdbc:sqlite") Then
		Log("Error: Vibur connection pool does not support SQLite")
		Return False
	End If
	Return True
End Sub

'See if pool's java object supports standard getConnection method
Public Sub IsStandardConnection As Boolean
	Return True
End Sub

'Get pool's underlying java object. Used if IsStandardConnection is True
Public Sub GetPoolJO As JavaObject
	Return poolJO
End Sub

'Retrieves a connection from the pool. Make sure to close the connection when you are done with it.
Public Sub GetConnection As SQL
	Dim newSQL As SQL
	Dim jo As JavaObject = newSQL
	jo.SetField("connection", poolJO.RunMethod("getConnection", Null))
	Return newSQL
End Sub

'Closes all unused pooled connections.
Public Sub ClosePool
	If poolJO.IsInitialized Then
		poolJO.RunMethod("terminate", Null)
	End If
End Sub