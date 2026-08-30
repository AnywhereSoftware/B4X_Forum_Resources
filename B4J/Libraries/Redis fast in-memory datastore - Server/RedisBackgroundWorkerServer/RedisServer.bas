B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private RedisSer As RedisServer
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	' Initialize the embedded Redis server wrapper
	RedisSer.Initialize(4)

	' Set debug mode to print stack traces on errors
	RedisSer.SetDebugMode(False)

	'RedisSer.StartServerAsync("RedisSer", 6379) 'Accept only local loopback connections (This machine)
	RedisSer.StartServerExAsync("RedisSer", 6379) 'Accept connections across all network interfaces
End Sub

Sub RedisSer_ServerStarted (Success As Boolean, Port As Int)
	If Success Then
		Log("You can now connect any standard Redis client (like Jedis or RedisClient) to localhost:" & Port)
	End If
End Sub

Sub RedisSer_ServerStopped (Reason As String)
	Log("Embedded Redis Server Stopped. Reason: " & Reason)
End Sub

Sub RedisSer_ServerError (Error As String, StackTrace As String)
	Log("Redis Server Error: " & Error)
	If StackTrace <> "" Then
		Log("Stack Trace: " & StackTrace)
	End If
End Sub

Sub RedisSer_Log (Message As String)
	Log("Redis Server Log: " & Message)
End Sub
