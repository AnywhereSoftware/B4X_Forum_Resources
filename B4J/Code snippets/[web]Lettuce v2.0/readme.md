### [web]Lettuce v2.0 by aeric
### 11/15/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/144169/)

**OLDER VERSiON:** <https://www.b4x.com/android/forum/threads/lettuce-io-working-with-redis.141509/>  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
#AdditionalJar: lettuce-core-6.1.8.RELEASE  
#AdditionalJar: reactor-core-3.4.19  
#AdditionalJar: reactive-streams-1.0.4  
#AdditionalJar: netty-common-4.1.85.Final  
#AdditionalJar: netty-buffer-4.1.85.Final  
#AdditionalJar: netty-codec-4.1.85.Final  
#AdditionalJar: netty-handler-4.1.85.Final  
#AdditionalJar: netty-resolver-4.1.85.Final  
#AdditionalJar: netty-transport-4.1.85.Final  
#AdditionalJar: netty-transport-native-unix-common-4.1.85.Final  
  
Sub Process_Globals  
     
End Sub  
  
Sub AppStart (Args() As String)  
    Dim value As String  
    Dim result As Long  
    Dim redis As Lettuce  
    redis.Initialize  
    redis.Path = "redis://localhost:6379/0"  
    redis.Create  
    redis.Connect  
    redis.WriteMap(CreateMap("key1": "Hello B4J", "key2": "12.25"))  
    redis.Set("key3", "36.9")  
    redis.Set("key4", "Test")  
     
    value = redis.Get("key3")  
    Log(value)  
     
    value = redis.set("key3", "96.3")  
    Log(value)  
     
    value = redis.Get("key3")  
    Log(value)  
     
    result = redis.Del("key3")  
    Log(result)  
  
    value = redis.Get("key3")  
    Log(value)  
     
    redis.Close  
    redis.Shutdown  
End Sub
```

  
  

```B4X
' Version: 2.0  
Sub Class_Globals  
    Private jo                 As JavaObject  
    Private redisClient     As JavaObject  
    Private connection         As JavaObject  
    Private syncCommands     As JavaObject  
    Private URL             As String  
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
```