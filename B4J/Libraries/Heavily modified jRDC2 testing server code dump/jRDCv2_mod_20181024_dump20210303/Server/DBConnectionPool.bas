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

Sub Class_Globals
	Private poolClass As Object
	Private pool As JavaObject
End Sub

'Initializes the pool.
' poolType - 
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
Public Sub Initialize(poolType As String, jdbcUrl As String, aUser As String, aPassword As String)
	Initialize2(poolType, jdbcUrl, aUser, aPassword, 0)
End Sub

'Initializes the pool with a given pool size.
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
' poolSize - Maximum size of connection pool.
Public Sub Initialize2(poolType As String, jdbcUrl As String, aUser As String, aPassword As String, poolSize As Int)
	Dim thePoolClass(1) As Object
	If poolType.EqualsIgnoreCase("DB") And jdbcUrl.StartsWith("jdbc:hsqldb") Then
		thePoolClass(0) = HSQLDBConnectionPool
	End If
	If poolType.EqualsIgnoreCase("DB") And jdbcUrl.StartsWith("jdbc:h2") Then
		Dim thePoolClass2 As H2ConnectionPool
	End If
	Dim jo As JavaObject
	If poolSize > 0 Then
		pool = jo.InitializeNewInstance("org.hsqldb.jdbc.JDBCPool", Array As Object (poolSize))
	Else
		pool = jo.InitializeNewInstance("org.hsqldb.jdbc.JDBCPool", Null)
	End If
	pool.RunMethod("setUrl", Array As Object(jdbcUrl))
	pool.RunMethod("setUser", Array As Object(aUser))
	pool.RunMethod("setPassword", Array As Object(aPassword))
End Sub

'Retrieves a connection from the pool. Make sure to close the connection when you are done with it.
Public Sub GetConnection As SQL
	Dim newSQL As SQL
	Dim jo As JavaObject = newSQL
	jo.SetField("connection", pool.RunMethod("getConnection", Null))
	Return newSQL
End Sub

'Closes all unused pooled connections.
Public Sub ClosePool
	If pool.IsInitialized Then
		pool.RunMethod("close", Array As Object(0))
	End If
End Sub