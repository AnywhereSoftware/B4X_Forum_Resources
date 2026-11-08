B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Class module
'Author: Oliver Ackermann
'Created on: 2018/05/07
'Based on: https://github.com/AnywhereSoftware/B4J_Server/blob/master/src/anywheresoftware/b4j/object/ConnectionPool.java
'Resources:
'  https://tomcat.apache.org/tomcat-8.5-doc/jdbc-pool.html

Sub Class_Globals
	Private poolJO As JavaObject
	Private poolProperties As Map
End Sub

Public Sub Initialize
	Dim properties As Map
	properties.Initialize
	'
	'Common Attributes
	properties.Put("MaxActive", "int")
	properties.Put("MaxIdle", "int")
	properties.Put("MinIdle", "int")
	properties.Put("InitialSize", "int")
	properties.Put("MaxWait", "int")
	properties.Put("TestOnBorrow", "boolean")
	properties.Put("TestOnConnect", "boolean")
	properties.Put("TestOnReturn", "boolean")
	properties.Put("TestWhileIdle", "boolean")
	properties.Put("ValidationQuery", "string")
	properties.Put("ValidationQueryTimeout", "int")
	properties.Put("TimeBetweenEvictionRunsMillis", "int")
	properties.Put("MinEvictableIdleTimeMillies", "int")
	properties.Put("RemoveAbandoned", "boolean")
	properties.Put("RemoveAbandonedTimeout", "int")
	properties.Put("LogAbandoned", "boolean")
	properties.Put("ConnectionProperties", "string")
	'
	'Tomcat JDBC Enhanced Attributes
	properties.Put("InitSQL", "string")
	properties.Put("ValidationInterval", "int")
	properties.Put("JmxEnabled", "boolean")
	properties.Put("FairQueue", "boolean")
	properties.Put("AbandonWhenPercentageFull", "int")
	properties.Put("MaxAge", "int")
	properties.Put("UseEquals", "boolean")
	properties.Put("SuspectTimeout", "int")
	properties.Put("RollbackOnReturn", "boolean")
	properties.Put("CommitOnReturn", "boolean")
	properties.Put("LogValidationErrors", "boolean")
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
	Dim propertiesJO As JavaObject           
	propertiesJO = jo.InitializeNewInstance("org.apache.tomcat.jdbc.pool.PoolProperties", Null)
	propertiesJO.RunMethod("setDriverClassName",Array As Object(driverClass))
	propertiesJO.RunMethod("setUrl", Array As Object(jdbcUrl))
	propertiesJO.RunMethod("setUsername", Array As Object(aUser))
	propertiesJO.RunMethod("setPassword", Array As Object(aPassword))
	If poolSize > 0 Then propertiesJO.RunMethod("setMaxActive", Array As Object(poolSize))
	poolJO = jo.InitializeNewInstance("org.apache.tomcat.jdbc.pool.DataSource", Array As Object(propertiesJO))
End Sub

Public Sub CreatePool3(options As Map)
	CreatePool2(options.Get("driver"), options.Get("url"), options.Get("user"), options.Get("password"), options.Get("poolsize"))
End Sub

'https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/DataSourceFactory.html
'Can use DataSourceFactory with Properties to create pool. Properties needed before pool creation

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

'set connection properties for underlyinng JDBC driver
'https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/DataSource.html
'setConnectionProperties(property As String)

'Check if JDBC URL is supported
Public Sub SupportUrl(jdbcUrl As String) As Boolean
	If jdbcUrl.StartsWith("jdbc:sqlite") Then
		Log("Error: Tomcat JDBC connection pool does not support SQLite")
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
		poolJO.RunMethod("close", Null)
	End If
End Sub