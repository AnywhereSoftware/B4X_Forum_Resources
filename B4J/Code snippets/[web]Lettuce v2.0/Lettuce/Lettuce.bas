B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.71
@EndOfDesignText@
' Version: 2.0
Sub Class_Globals
	Private jo 				As JavaObject
	Private redisClient 	As JavaObject
	Private connection 		As JavaObject
	Private syncCommands 	As JavaObject
	Private URL 			As String
End Sub

Public Sub Initialize
	jo.initializeStatic("io.lettuce.core.RedisClient")
End Sub

Public Sub setPath (mURL As String)
	URL = mURL
End Sub

Public Sub Create
	redisClient = jo.RunMethod("create", Array(URL))
End Sub

Public Sub Connect
	connection = redisClient.RunMethod("connect", Null)
End Sub


Public Sub Close
	connection.RunMethod("close", Null)
End Sub

Public Sub Shutdown
	redisClient.RunMethod("shutdown", Null)
End Sub

Public Sub Sync
	syncCommands = connection.RunMethod("sync", Null)
End Sub

Public Sub Async
	syncCommands = connection.RunMethod("async", Null)
End Sub

Public Sub WriteMap (Map As Map)
	For Each Key As String In Map.Keys
		Set(Key, Map.Get(Key))
	Next
End Sub

Public Sub Set (Key As String, Value As String)
	Sync
	syncCommands.RunMethod("set", Array(Key, Value))
End Sub

Public Sub Get (Key As String) As String
	Sync
	Return syncCommands.RunMethod("get", Array(Key))
End Sub

Public Sub Del (Key As String) As Long
	Sync
	Return syncCommands.RunMethod("del", Array(Array(Key)))
End Sub