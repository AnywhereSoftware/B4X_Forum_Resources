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
'  http://hsqldb.org/doc/src/org/hsqldb/jdbc/JDBCPool.html
'  Connection properties: http://hsqldb.org/doc/guide/dbproperties-chapt.html
'  Connection properties set via setProperties of the pool

Sub Class_Globals
	Private poolJO As JavaObject
	Private poolProperties As Map
End Sub

Public Sub Initialize
	Dim properties As Map
	properties.Initialize
	properties.Put("LoginTimeout", "int")
	poolProperties = properties
End Sub

'Creates the pool.
' driverClass - The JDBC driver class. Can be "".
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
Public Sub CreatePool(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String)
	CreatePool2(driverClass, jdbcUrl, aUser, aPassword, 0)
End Sub

'Creates the pool with a given pool size.
' driverClass - The JDBC driver class. Can be "".
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
' poolSize - Maximum size of connection pool.
Public Sub CreatePool2(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String, poolSize As Int)
	Dim jo As JavaObject
	If poolSize > 0 Then
		poolJO = jo.InitializeNewInstance("org.hsqldb.jdbc.JDBCPool", Array As Object (poolSize))
	Else
		poolJO = jo.InitializeNewInstance("org.hsqldb.jdbc.JDBCPool", Null)
	End If
	poolJO.RunMethod("setUrl", Array As Object(jdbcUrl))
	poolJO.RunMethod("setUser", Array As Object(aUser))
	poolJO.RunMethod("setPassword", Array As Object(aPassword))
End Sub

Public Sub CreatePool3(options As Map)
	CreatePool2(options.Get("driver"), options.Get("url"), options.Get("user"), options.Get("password"), options.Get("poolsize"))
End Sub

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
	If jdbcUrl.StartsWith("jdbc:hsqldb:") Then Return True
	Log($"JdbcURL ${jdbcUrl} not supported by HSQLDB connection pool"$)
	Return False
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
		poolJO.RunMethod("close", Array As Object(0))
	End If
End Sub