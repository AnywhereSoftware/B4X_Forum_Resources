B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Class module
'Author: Oliver Ackermann
'Created on: 2018/05/08
'Based on: https://github.com/AnywhereSoftware/B4J_Server/blob/master/src/anywheresoftware/b4j/object/ConnectionPool.java
'Resources:
'  https://www.mchange.com/projects/c3p0/#configuration

Sub Class_Globals
	Private poolJO As JavaObject
	Private poolProperties As Map
End Sub

Public Sub Initialize
	Dim properties As Map
	properties.Initialize
	'
	'Basic Pool Configuration
	properties.Put("AquireIncrement", "int")
	properties.Put("InitialPoolSize", "int")
	properties.Put("MaxPoolSize", "int")
	properties.Put("MaxIdleTime", "int")
	properties.Put("MinPoolSize", "int")
	'
	'Managing Pool Size and Connection Age
	properties.Put("MaxConnectionAge", "int")
	'properties.Put("MaxIdleTime", "int")
	properties.Put("MaxIdleTimeExcessConnections", "int")
	'
	'Configure Connection Testing
	properties.Put("AutomaticTestTable", "string")
	properties.Put("IdleConnectionTestPeriod", "int")
	properties.Put("PreferredTestQuery", "string")
	properties.Put("TestConnectionOnCheckin", "boolean")
	properties.Put("TestConnectionOnCheckout", "boolean")
	'
	'Configuring Statement Pooling
	properties.Put("MaxStatements", "int")
	properties.Put("MaxStatementsPerConnection", "int")
	properties.Put("StatementCacheNumDeferredCloseThreads", "int")
	'
	'Configuring Recovery From Database Outages
	properties.Put("AcquireRetryAttempts", "int")
	properties.Put("AcquireRetryDelay", "int")
	properties.Put("BreakAfterAcquireFailure", "boolean")
	'
	'Configuring Unresolved Transaction Handling
	properties.Put("AutoCommitOnClose", "boolean")
	properties.Put("ForceIgnoreUnresolvedTransactions", "boolean")
	'
	'Configuring to Debug and Workaround Broken Client Applications
	properties.Put("DebugUnreturnedConnectionStackTraces", "boolean")
	properties.Put("UnreturnedConnectionTimeout", "int")
	'
	'Configuring To Avoid Memory Leaks On Hot Redeploy Of Clients
	properties.Put("PrivilegeSpawnedThreads", "boolean")
	'
	'Other DataSource Configuration
	properties.Put("CheckoutTimeout", "int")
	properties.Put("ForceSynchronousCheckins", "boolean")
	properties.Put("MaxAdministrativeTaskTime", "int")
	properties.Put("NumHelperThreads", "int")
	'
	poolProperties = properties
End Sub

'Creates the pool.
' driverClass - The JDBC driver class. Can be "".
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
Public Sub CreatePool(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String)
	CreatePool2(driverClass, jdbcUrl, aUser, aPassword, 0)
End Sub

'Initializes the pool with a given pool size.
' driverClass - The JDBC driver class. Can be "".
' jdbcUrl - JDBC connection url.
' aUser / aPassword - Connection credentials.
' poolSize - Maximum size of connection pool.
Public Sub CreatePool2(driverClass As String, jdbcUrl As String, aUser As String, aPassword As String, poolSize As Int)
	Dim jo As JavaObject
	poolJO = jo.InitializeNewInstance("com.mchange.v2.c3p0.ComboPooledDataSource", Null)
	poolJO.RunMethod("setDriverClass",Array As Object(driverClass))
	poolJO.RunMethod("setJdbcUrl", Array As Object(jdbcUrl))
	poolJO.RunMethod("setUser", Array As Object(aUser))
	poolJO.RunMethod("setPassword", Array As Object(aPassword))
	If poolSize > 0 Then poolJO.RunMethod("setMaxPoolSize", Array As Object(poolSize))
'	pool.Initialize(driverClass, jdbcUrl, aUser, aPassword)
'	poolJO = pool
'	If poolSize > 0 Then
'		poolJO.RunMethod("setMaxPoolSize", Array(poolSize))
'	End If
End Sub

Public Sub CreatePool3(options As Map)
	CreatePool2(options.Get("driver"), options.Get("url"), options.Get("user"), options.Get("password"), options.Get("poolsize"))
End Sub

'https://www.mchange.com/projects/c3p0/apidocs/com/mchange/v2/c3p0/AbstractComboPooledDataSource.html#setProperties-java.util.Properties-
'It is called after creating the pool object
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
		Log("Error: C3P0 connection pool does not support SQLite")
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
	Log("3CP0 ClosePool")
	If poolJO.IsInitialized Then
		poolJO.RunMethod("close", Null)
	End If
End Sub

'
'#if Java
'/**
' * Original source:  https://github.com/AnywhereSoftware/B4J_Server/blob/master/src/anywheresoftware/b4j/object/ConnectionPool.java
' */
'// Original code
'//package anywheresoftware.b4j.object;
'
'import java.beans.PropertyVetoException;
'import java.sql.SQLException;
'// Original code
'//import java.util.concurrent.Callable;
'// Added
'//import javax.sql.ConnectionPoolDataSource;
'
'import anywheresoftware.b4a.AbsObjectWrapper;
'/** Original code
'import anywheresoftware.b4a.BA;
'import anywheresoftware.b4a.BA.Events;
'import anywheresoftware.b4a.BA.ShortName;
'*/
'import anywheresoftware.b4j.objects.SQL;
'
'//import com.mchange.v2.c3p0.ComboPooledDataSource;
'import org.h2.jdbcx.JdbcConnectionPool;
'
'/**
' * Maintains a pool of database connections.
' */
'/** Original code
'@ShortName("ConnectionPool")
'@Events(values={"ConnectionReady (Success As Boolean, SQL As SQL)"})
'public class ConnectionPool extends AbsObjectWrapper<ComboPooledDataSource> {
'*/
'public class ConnectionPool extends AbsObjectWrapper<JdbcConnectionPool> {
'	//New
'	JdbcConnectionPool pool;
'	
'	/**
'	 * Initializes the pool.
'	 *DriverClass - The JDBC driver class.
'	 *JdbcUrl - JDBC connection url.
'	 *User / Password - Connection credentials.
'	 */
'	public void Initialize(String DriverClass, String JdbcUrl, String User, String Password) throws PropertyVetoException {
'		/** Original code
'		final ComboPooledDataSource pool = new ComboPooledDataSource();
'		setObject(pool);
'		pool.setDriverClass(DriverClass);
'		pool.setJdbcUrl(JdbcUrl);
'		pool.setUser(User);
'		pool.setPassword(Password);
'		pool.setMaxStatements(150);
'		pool.setMaxIdleTime(1800);
'		pool.setIdleConnectionTestPeriod(600);
'		pool.setCheckoutTimeout(20000);
'		pool.setTestConnectionOnCheckout(true);
'		**/
'		//final JdbcConnectionPool pool = JdbcConnectionPool.create(JdbcUrl, User, Password);
'		pool = JdbcConnectionPool.create(JdbcUrl, User, Password);
'		//setObject(Pool);
'	}
'	/**
'	 * Retrieves a connection from the pool. Make sure to close the connection when you are done with it.
'	 */
'	public SQL GetConnection() throws SQLException {
'		SQL s = new SQL();
'		//s.connection = getObject().getConnection();
'		s.connection = pool.getConnection();
'		return s;
'	}
'	/**
'	 * Asynchronously gets a SQL connection. This method is useful in UI applications as it prevents the main thread from freezing until the connection is available.
'	 *The ConnectionReady event will be raised when the connection is ready.
'	 */
'	 /** Not supported
'	public void GetConnectionAsync(final BA ba, final String EventName) {
'		BA.runAsync(ba, this, EventName.toLowerCase(BA.cul) + "_connectionready", new Object[] {false, null}, new Callable<Object[]>() {
'
'			@Override
'			public Object[] call() throws Exception {
'				return new Object[] {true, GetConnection()};
'			}
'			
'		});
'	}
'	**/
'	public void ClosePool() {
'		if (IsInitialized())
'			// Original code
'			//getObject().close();
'			//getObject().dispose();
'			pool.dispose();
'	}
'}
'#End If