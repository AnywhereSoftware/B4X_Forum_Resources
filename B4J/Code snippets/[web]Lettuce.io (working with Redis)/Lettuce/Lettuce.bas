B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.71
@EndOfDesignText@
Sub Class_Globals
	Private jo As JavaObject
	Private URL As String
End Sub

Public Sub Initialize
	jo.initializeStatic("io.lettuce.core.RedisClient")
End Sub

Public Sub setPath (mURL As String)
	URL = mURL
End Sub

Public Sub WriteMap (Map As Map)
	Dim redisClient As JavaObject = jo.RunMethod("create", Array(URL))
	Dim connection As JavaObject = redisClient.RunMethod("connect", Null)
	For Each Key As String In Map.Keys
		Dim syncCommands As JavaObject = connection.RunMethod("sync", Null)
		syncCommands.RunMethod("set", Array(Key, Map.Get(Key)))
	Next
	connection.RunMethod("close", Null)
	redisClient.RunMethod("shutdown", Null)
End Sub