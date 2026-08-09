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
	Private Redis As Redis
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	Redis.Initialize(4)
	Redis.InitializePool("RedisEvents", "127.0.0.1", 6379, 2000, "", 0, 8, 8)
	'Redis.InitializePool("RedisEvents", "redis-12345.c123.eu-west-1-1.ec2.cloud.redislabs.com", 12345, 5000, "XXXXXXXXXXXXXXXXXXXXX", 0, 8, 8)
End Sub

Sub B4XPage_Disappear
	'Cleanly close pool, executor threads, and pub/sub connections on exit
	If Redis.IsInitialized Then
		Redis.Close
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub RedisEvents_PoolInitialized (Success As Boolean)
	Log("Redis Pool Initialized: " & Success)
	If Success Then
		'NONE HASH COMMAND
		Redis.SetAsync("my_test_key", "Hello from B4XPages!")

		'HASH COMMANDS
		Redis.HSetAsync("user:100", "name", "Peter")
		Redis.HSetAsync("user:100", "role", "developer")
		Redis.HSetAsync("user:100", "country", "UK")

		'HASH DELETE COMMAND
		Redis.HDelAsync("user:100", "country")

		'MORE EXAMPLES OF METHODS
		Redis.ExistsAsync("my_test_key")
		Redis.ExpireAsync("my_test_key", 60)
		Redis.HGetAllAsync("user:100")
		Redis.HExistsAsync("user:100", "name")
		'Redis.DelAsync("my_list")
		Redis.LPushAsync("my_list", "item_left")
		Redis.RPushAsync("my_list", "item_right")
		Redis.LRangeAsync("my_list", 0, -1)
		Redis.SAddAsync("my_set", "unique_member")
		Redis.SMembersAsync("my_set")

		'Subscribe to a channel for pub/sub messaging
		Redis.Subscribe("notifications_channel")
		
		TestRawPool
	End If
End Sub

Sub RedisEvents_CommandResult (Command As String, Success As Boolean, Result As Object)
	Log("Command: " & Command & " | Success: " & Success & " | Result: " & Result)
    
	'STRING LOGIC
	If Command = "SET" And Success Then
		Redis.GetAsync("my_test_key")
	Else If Command = "GET" And Success Then
		Log("Retrieved Value: " & Result)
	End If

	'HASH LOGIC
	If Command = "HSET" And Success Then
		Log("HSET completed. Fetching field 'name'...")
		Redis.HGetAsync("user:100", "name")
        
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

Sub RedisEvents_MessageReceived (Channel As String, Message As String)
	Log("Pub/Sub Message on channel [" & Channel & "]: " & Message)
End Sub

Sub RedisEvents_SubscribeError (Error As String)
	Log("Subscription Error: " & Error)
End Sub

Sub RedisEvents_TaskRejected (Command As String, Reason As String)
	Log("Task Rejected for command [" & Command & "]: " & Reason)
End Sub

'GetRawPool acts as a direct bridge to the full (400+ methods) raw power of the underlying Java Jedis library.
'As Long As you know the Java methods provided by Jedis (which you can look up in the official Jedis documentation Or GitHub repository), 
'you can use JavaObject to execute transactions, pipelining, Lua scripts, or any other advanced Redis features that are not built-in to this library
Sub TestRawPool
	' Get the raw JedisPool instance from the wrapper
	Dim rawPool As JavaObject = Redis.GetRawPool()
	
	If rawPool.IsInitialized Then
		Dim JedisConn As JavaObject
		Try
			' Borrow a raw connection synchronously from the pool
			JedisConn = rawPool.RunMethod("getResource", Null)
			
			' Execute a synchronous command directly on the raw connection
			Dim val As String = JedisConn.RunMethod("get", Array As Object("my_test_key"))
			Log("Raw Pool GET Result: " & val)
			
			' Execute a synchronous hash command
			JedisConn.RunMethod("hset", Array As Object("user:200", "status", "active"))
		Catch
			Log("Raw Pool Error: " & LastException.Message)
			' CRITICAL: Always close/return the connection to the pool to prevent leaks
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
