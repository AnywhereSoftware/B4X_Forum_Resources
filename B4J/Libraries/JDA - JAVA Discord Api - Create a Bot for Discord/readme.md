### JDA - JAVA Discord Api - Create a Bot for Discord by DonManfred
### 01/02/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/119003/)

With JDA you are able to create a Bot for Discord.  
<https://discord.com/>  
  
Find out more about Discord-Bots in the Discord-Developer-Portal  
<https://discord.com/developers/applications>  
  
Setup:  
You need to add the following jars to your Project.  

```B4X
#AdditionalJar:JDA-5.0.0-beta.2  
'#AdditionalJar: mysql-connector-java-5.1.34-bin  
#AdditionalJar: jackson-databind-2.10.1  
#AdditionalJar: jackson-core-2.10.1  
#AdditionalJar: jackson-annotations-2.11.0  
#AdditionalJar: okhttp-3.13.0  
#AdditionalJar: slf4j-api-1.7.25  
#AdditionalJar: slf4j-jdk14-1.7.25  
#AdditionalJar: commons-collections4-4.1  
#AdditionalJar: okio-2.6.0  
#AdditionalJar: kotlin-stdlib-1.3.41  
#AdditionalJar: kotlin-stdlib-jdk8-1.3.41  
#AdditionalJar: nv-websocket-client-2.14  
#AdditionalJar: trove4j-3.0.3
```

  
  
They are all inside the follwing zip which can be downloaded from my Dropbox as the file-size is more than 500kb.  
Download here:  
<https://www.dropbox.com/sh/bjx196xykrehhqc/AAApSa8Z3_TjGUKbefCRpvxga?dl=1>  
  
You´ll need to download the newest JDA.jar here:  
<https://github.com/DV8FromTheWorld/JDA/releases/tag/v5.0.0-beta.2>  
Download JDA-5.0.0-beta.2.jar and put it in your additional libs folder. Also remember to reference it using

```B4X
#additionaljar:JDA-5.0.0-beta.2
```

  
  
The following code is needed in your appstart  

```B4X
    Dim b As JDABuilder  
    b.Initialize2(token) ' String token from Developersite  
    b.setAutoReconnect(True).setEnableShutdownHook(True)  
    jda.Initialize("JDA",b.build)  
  
  
    Dim sh As DefaultShardManagerBuilder  
    sh.Initialize("ShardManager")  
    sh.setToken(token)  
    sh.build  
    jda.awaitReady
```

  
  
onReady is called when the JDA has finished initialisation and you can now use Api methods.  

```B4X
Sub JDA_onReady(event As Object)  
    Log($"JDA_onReady(${event})"$)  
End Sub
```

  
  
onMessageReceived is the main-entry point for you as the Developer.  
Every Message the Bot receives raises this Event. You even get Events for Message you send.  

```B4X
Sub JDA_onMessageReceived(event As Object)  
    Log($"JDA_onMessageReceived(${event})"$)  
    Dim ev As MessageReceivedEvent = event  
End Sub
```

  
  
onGuildMemberJoin is a Event which is raised the First Time a new User Logged in into your Discord Server.  
Or better. A user Logged in into one of the Guilds your Bot has Access to.  
  

```B4X
Sub JDA_onGuildMemberJoin(event As GuildMemberJoinEvent)  
    Log($"JDA_onGuildMemberJoin(${event})"$)  
    'Dim ev As GuildMemberJoinEvent = event  
    Log($"GuildMemberJoin.Member ${event.Member}"$)  
    Log($"GuildMemberJoin.User ${event.User}"$)  
End Sub
```

  
  
Please create a new Thread for any Question or Issues you have with this Library in the [B4J Questions Forum](https://www.b4x.com/android/forum/forums/b4j-questions.54/). Prefix your Thread with [JDA] please.  
  
You won´t get Support in this Thread.