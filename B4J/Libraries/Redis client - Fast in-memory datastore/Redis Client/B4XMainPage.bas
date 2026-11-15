B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

'Install the in-memory server from the link below
'https://www.memurai.com/get-memurai?version=windows-redis

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private RedisCli As RedisClient
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	RedisCli.Initialize(4)
	RedisCli.InitializePool("RedisCli", "127.0.0.1", 6379, 2000, "", 0, 8, 8)
	'RedisCli.InitializePool("RedisCli", "redis-12345.c123.eu-west-1-1.ec2.cloud.redislabs.com", 12345, 5000, "XXXXXXXXXXXXXXXXXXXXX", 0, 8, 8)
End Sub

Sub B4XPage_Disappear
	'Cleanly close pool, executor threads, and pub/sub connections on exit
	If RedisCli.IsInitialized Then
		RedisCli.Close
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub RedisCli_PoolInitialized (Success As Boolean)
	Log("Redis Pool Initialized: " & Success)
	If Success Then
		TestReadWriteData
		Sleep(50)

		RedisCli.KeysAsync("*")
		Sleep(50)
		
		RedisCli.InfoAsync("")
		Sleep(50)
		
		RedisCli.DBSizeAsync
		Sleep(50)

		'Uncomment the lines below to see how RedisCli.GetRawPool() method is used, and to see results...
		TestRedisRawPool
		Sleep(50)
		
		'TestRedisDiagnostics		
		'Sleep(50)
	End If
End Sub

Sub RedisCli_CommandResult (Command As String, Success As Boolean, Result As Object)
	Log("Command: " & Command & " | Success: " & Success & " | Result: " & Result)
	
	'KEYS
	If Command = "KEYS" Then
		If Success Then
			Log("Redis Keys Result:")
			Dim keysList As List = Result
			For i = 0 To keysList.Size - 1
				Log((i + 1) & ") " & keysList.Get(i))
			Next
		Else
			Log("Failed to fetch Redis keys: " & Result)
		End If
	End If
	
'	'SERVER STATS
'	If Command = "INFO" Then
'		If Success Then
'			Log("Redis Info Result:")
'			Log(Result)
'		Else
'			Log("Failed to fetch Redis info: " & Result)
'		End If
'	End If

	'SERVER STATS
	If Command = "DBSIZE" Then
		If Success Then
			Log("Redis DBSize Result:")
			Log(Result)
		Else
			Log("Failed to fetch Redis info: " & Result)
		End If
	End If
    
	'STRING LOGIC
	If Command = "SET" And Success Then
		RedisCli.GetAsync("my_test_key")
	Else If Command = "GET" And Success Then
		Log("Retrieved Value: " & Result)
	End If

	'HASH LOGIC
	If Command = "HSET" And Success Then
		Log("HSET completed. Fetching field 'name'...")
		RedisCli.HGetAsync("user:100", "name")
        
	Else If Command = "HGET" And Success Then
		Log("Retrieved Hash Field Value: " & Result)
	End If

	'HASH DELETE LOGIC
	If Command = "HDEL" And Success Then
		Log("Hash field deleted successfully. Result: " & Result)
	Else If Command = "HDEL" And Success = False Then
		Log("Failed to delete hash field. Error: " & Result)
	End If

	'ADDITIONS RESULT HANDLING FOR NEW METHODS
	If Command = "EXISTS" And Success Then
		Log("Key Exists: " & Result)
	Else If Command = "EXPIRE" And Success Then
		Log("Expire set successfully. Result: " & Result)
	Else If Command = "HGETALL" And Success Then
		Dim allFields As Map = Result
		Log("Retrieved All Hash Fields Count: " & allFields.Size)
	Else If Command = "HEXISTS" And Success Then
		Log("Hash Field Exists: " & Result)
	Else If Command = "LPUSH" And Success Then
		Log("LPUSH list length: " & Result)
	Else If Command = "RPUSH" And Success Then
		Log("RPUSH list length: " & Result)
	Else If Command = "LRANGE" And Success Then
		Dim listItems As List = Result
		Log("LRANGE items count: " & listItems.Size)
	Else If Command = "SADD" And Success Then
		Log("SADD added count: " & Result)
	Else If Command = "SMEMBERS" And Success Then
		Dim setMembers As List = Result
		Log("SMEMBERS items count: " & setMembers.Size)
	End If
End Sub

Sub RedisCli_MessageReceived (Channel As String, Message As String)
	Log("Pub/Sub Message on channel [" & Channel & "]: " & Message)
End Sub

Sub RedisCli_Error (Error As String)
	Log("Error: " & Error)
End Sub

Sub RedisCli_TaskRejected (Command As String, Reason As String)
	Log("Task Rejected for command [" & Command & "]: " & Reason)
End Sub

'Test reading and writing data to the Redis in-memory server
Sub TestReadWriteData
	'NONE HASH COMMAND
	RedisCli.SetAsync("my_test_key", "Hello from B4XPages!")

	'HASH COMMANDS
	RedisCli.HSetAsync("user:100", "name", "Peter")
	RedisCli.HSetAsync("user:100", "role", "developer")
	RedisCli.HSetAsync("user:100", "country", "UK")

	'HASH DELETE COMMAND
	RedisCli.HDelAsync("user:100", "country")

	'MORE EXAMPLES OF METHODS
	RedisCli.ExistsAsync("my_test_key")
	RedisCli.ExpireAsync("my_test_key", 60)
	RedisCli.HGetAllAsync("user:100")
	RedisCli.HExistsAsync("user:100", "name")
	'Redis.DelAsync("my_list")
	RedisCli.LPushAsync("my_list", "item_left")
	RedisCli.RPushAsync("my_list", "item_right")
	RedisCli.LRangeAsync("my_list", 0, -1)
	RedisCli.SAddAsync("my_set", "unique_member")
	RedisCli.SMembersAsync("my_set")

	'Subscribe to a channel for pub/sub messaging
	RedisCli.Subscribe("notifications_channel")
End Sub

'GetRawPool acts as a direct bridge to the full (400+ methods) raw power of the underlying Java Jedis library.
'As Long As you know the Java methods provided by Jedis (which you can look up in the official Jedis documentation Or GitHub repository), 
'you can use JavaObject to execute transactions, pipelining, Lua scripts, or any other advanced Redis features that are not built-in to this library
Sub TestRedisRawPool 'ignore
	' Get the raw JedisPool instance from the wrapper
	Dim RawPool As JavaObject = RedisCli.GetRawPool()
	
	If RawPool.IsInitialized Then
		Dim JedisConn As JavaObject

		Try
			'Borrow a raw connection synchronously from the pool
			JedisConn = RawPool.RunMethod("getResource", Null)
			
			'Execute a synchronous command directly on the raw connection
			Dim Val As String = JedisConn.RunMethod("get", Array As Object("my_test_key"))
			Log("Raw Pool GET Result: " & Val)
			
			'Execute a synchronous hash command
			JedisConn.RunMethod("hset", Array As Object("user:200", "status", "active"))
			
			'Execute KEYS * command
			Dim keysResult As JavaObject = JedisConn.RunMethod("keys", Array As Object("*"))
			Log("--- RAW POOL KEYS ---")
			If keysResult.IsInitialized Then
				'Jedis returns a java.util.Set for keys()
				Dim keysArray() As Object = keysResult.RunMethod("toArray", Null)
				For i = 0 To keysArray.Length - 1
					Log((i + 1) & ") " & keysArray(i))
				Next
			End If
			
			'Execute INFO command to get server details
			Dim infoResult As String = JedisConn.RunMethod("info", Null)
			Log("--- RAW POOL INFO ---")
			Log(infoResult)
		Catch
			Log("Raw Pool Error: " & LastException.Message)
			
			'CRITICAL: Always close/return the connection to the pool to prevent leaks
			If JedisConn.IsInitialized Then
				Try
					JedisConn.RunMethod("close", Null)
				Catch
					Log("Error closing raw connection: " & LastException.Message)
				End Try
			End If
		End Try
	Else
		Log("Raw pool is not initialized yet.")
	End If
End Sub

'Read basic diagnostics from the Redis server
Sub TestRedisDiagnostics 'ignore
	' Get the raw JedisPool instance from the wrapper
	Dim RawPool As JavaObject = RedisCli.GetRawPool()
	
	If RawPool.IsInitialized Then
		Dim JedisConn As JavaObject
		Try
			' Borrow a raw connection synchronously from the pool
			JedisConn = RawPool.RunMethod("getResource", Null)
			
			' 1. Server Memory Resource Usage (Using INFO memory)
			Dim memInfo As String = JedisConn.RunMethod("info", Array As Object("memory"))
			Log("--- RAW POOL MEMORY INFO ---")
			Log(memInfo)
			
			' 2. Client Connections (Using INFO clients)
			Dim clientInfo As String = JedisConn.RunMethod("info", Array As Object("clients"))
			Log("--- RAW POOL CLIENTS INFO ---")
			Log(clientInfo)
			
			' 3. Database Statistics and Key Expirations
			Dim dbSize As Long = JedisConn.RunMethod("dbSize", Null)
			Log("Total Keys in DB: " & dbSize)
			
			Dim ttl As Long = JedisConn.RunMethod("ttl", Array As Object("my_test_key"))
			Log("Key TTL (seconds): " & ttl)
			
			' 4. Server Persistence / Last Save Diagnostics (Using INFO persistence)
			Dim persistInfo As String = JedisConn.RunMethod("info", Array As Object("persistence"))
			Log("--- RAW POOL PERSISTENCE INFO ---")
			Log(persistInfo)
			
			' 5. Server Stats / Operations and Network Throughput (Using INFO stats)
			Dim statsInfo As String = JedisConn.RunMethod("info", Array As Object("stats"))
			Log("--- RAW POOL STATS INFO ---")
			Log(statsInfo)
			
			' 6. CPU Usage Diagnostics (Using INFO cpu)
			Dim cpuInfo As String = JedisConn.RunMethod("info", Array As Object("cpu"))
			Log("--- RAW POOL CPU INFO ---")
			Log(cpuInfo)
			
			' 7. Replication Status (Using INFO replication)
			Dim replInfo As String = JedisConn.RunMethod("info", Array As Object("replication"))
			Log("--- RAW POOL REPLICATION INFO ---")
			Log(replInfo)
		Catch
			Log("Raw Pool Diagnostics Error: " & LastException.Message)
		End Try
		
		' CRITICAL: Always close/return the connection to the pool to prevent leaks
		If JedisConn.IsInitialized Then
			Try
				JedisConn.RunMethod("close", Null)
			Catch
				Log("Error closing raw connection: " & LastException.Message)
			End Try
		End If
	Else
		Log("Raw pool is not initialized yet.")
	End If
End Sub
