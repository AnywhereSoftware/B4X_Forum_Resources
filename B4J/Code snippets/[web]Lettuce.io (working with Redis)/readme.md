### [web]Lettuce.io (working with Redis) by aeric
### 11/15/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141509/)

**UPDATE:** <https://www.b4x.com/android/forum/threads/lettuce-v2-0.144169/>  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
#AdditionalJar: lettuce-core-6.1.8.RELEASE  
#AdditionalJar: reactor-core-3.4.19  
#AdditionalJar: reactive-streams-1.0.4  
#AdditionalJar: netty-common-4.1.78.Final  
#AdditionalJar: netty-buffer-4.1.78.Final  
#AdditionalJar: netty-codec-4.1.78.Final  
#AdditionalJar: netty-handler-4.1.78.Final  
#AdditionalJar: netty-resolver-4.1.78.Final  
#AdditionalJar: netty-transport-4.1.78.Final  
#AdditionalJar: netty-transport-native-unix-common-4.1.78.Final  
  
Sub Process_Globals  
   
End Sub  
  
Sub AppStart (Args() As String)  
    Dim redis As Lettuce  
    redis.Initialize  
    redis.Path = "redis://localhost:6379/0"  
    redis.WriteMap(CreateMap("key1": "Hello B4J", "key2": "12.5"))  
End Sub
```

  
  

```B4X
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
```

  
  
**Additional Jars download links:**  
<https://repo1.maven.org/maven2/io/lettuce/lettuce-core/6.1.8.RELEASE/lettuce-core-6.1.8.RELEASE.jar>  
<https://repo1.maven.org/maven2/io/projectreactor/reactor-core/3.4.19/reactor-core-3.4.19.jar>  
<https://repo1.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.4/reactive-streams-1.0.4.jar>  
<https://jar-download.com/artifacts/io.netty/netty-handler>