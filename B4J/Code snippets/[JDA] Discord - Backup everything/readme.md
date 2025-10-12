### [JDA] Discord - Backup everything by Magma
### 10/09/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168960/)

Yeap.. you are reading right - it is possible!  
  
But before see/use this snippet have in mind that there are some limitations and may be need to be more specific (threads, channels, etc) and save everything with different way…  
  
For this snippet I ve used wrapper/library created by [USER=42649]@DonManfred[/USER] (Many thanks for any help-guides gave me) and some javaobject after reading JDA Docs.  
  
Library here:<https://www.b4x.com/android/forum/threads/jda-java-discord-api-create-a-bot-for-discord.119003/>  
  
**using JDA-5.6.1**  
  
*Taking the following log error - but don't worry - continues working:*  
Cannot get methods of class: de.donmanfred.JDAwrapper, disabling cache.  
Error starting bot: java.lang.NullPointerException: Cannot read the array length because "params" is null  
  
  

```B4X
#AdditionalJar: JDA-5.6.1  
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
  
…  
    Private jda As JDA  
    Public bot_token As String = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  
….  
  
Sub InitializeBot  
    Try  
        ' 1. Gateway Intents  
        Dim joGI As JavaObject  
        joGI.InitializeStatic("net.dv8tion.jda.api.requests.GatewayIntent")  
        Dim intentGuildMessages  As Object = joGI.RunMethod("valueOf", Array("GUILD_MESSAGES"))  
        Dim intentMessageContent As Object = joGI.RunMethod("valueOf", Array("MESSAGE_CONTENT"))  
        Dim intentGuildMembers   As Object = joGI.RunMethod("valueOf", Array("GUILD_MEMBERS"))  
  
        Dim joIntents As JavaObject  
        joIntents.InitializeNewInstance("java.util.ArrayList", Null)  
        joIntents.RunMethod("add", Array(intentGuildMessages))  
        joIntents.RunMethod("add", Array(intentMessageContent))  
        joIntents.RunMethod("add", Array(intentGuildMembers))  
  
        ' 2. Build JDABuilder via JavaObject  
        Dim joBuilderClass As JavaObject  
        joBuilderClass.InitializeStatic("net.dv8tion.jda.api.JDABuilder")  
        Dim builderObj As JavaObject = joBuilderClass.RunMethod("createDefault", Array(bot_token, joIntents))  
  
        builderObj.RunMethod("setAutoReconnect", Array(True))  
        builderObj.RunMethod("setEnableShutdownHook", Array(True))  
  
        ' 3. Initialize JDA  
        jda.Initialize("JDA", builderObj.RunMethod("build", Null))  
        Dim joJDA As JavaObject = jda  
        joJDA.RunMethod("awaitReady", Null)  
  
        Log("Discord Bot started successfully!")  
    Catch  
        Log("Error starting bot: " & LastException.Message)  
    End Try  
End Sub
```

  
  
  

```B4X
Sub GrabAll(guild1 As Object) As ResumableSub  
   
 'saving at string only the channels  
    Dim output As String = ""  
  
    ' 1. Get Guild object !  
    Dim guildObj As Guild = guild1  
  
    ' 2. list all channels of guild  
    Dim channelsList As List = guildObj.GuildChannels  
   
  
    For Each gc As Object In channelsList  
       
       
        Dim joGC As JavaObject = gc  
        Dim chanType As JavaObject= joGC.RunMethod("getType", Null)  
        Dim chantype2 As String = chanType.RunMethod("name", Null)  
        Dim chanName As String = joGC.RunMethod("getName", Null)  
        Dim chanId   As String = joGC.RunMethod("getId",   Null)  
  
        output = output & $"Channel: ${chanName} [${chanId}] Type: ${chantype2}"$ & CRLF  
  
  
        'trigger them all!  
        ' 4. Archived public threads (if it is supported)  
        Try  
            Dim pubThreadss As JavaObject= joGC.RunMethod("retrieveArchivedPublicThreadChannels", Null)  
            Dim pubThreads As List=pubThreadss.RunMethod("complete", Null)  
            For Each t As Object In pubThreads  
                Dim joT As JavaObject = t  
                Dim tName As String = joT.RunMethod("getName", Null)  
                Dim tId   As String = joT.RunMethod("getId",   Null)  
                output = output & $"  Archived Public Thread: ${tName} [${tId}]"$ & CRLF  
            Next  
        Catch  
            ' skip if unsupported or no permission  
        End Try  
  
        ' 5. Archived private threads  
        Try  
            Dim privThreadss As JavaObject = joGC.RunMethod("retrieveArchivedPrivateThreadChannels", Null)  
            Dim privThreads As List = privThreadss.RunMethod("complete", Null)  
            For Each t As Object In privThreads  
                Dim joT As JavaObject = t  
                Dim tName As String = joT.RunMethod("getName", Null)  
                Dim tId   As String = joT.RunMethod("getId",   Null)  
                output = output & $"  Archived Private Thread: ${tName} [${tId}]"$ & CRLF  
            Next  
        Catch  
        End Try  
  
        ' 6. Archived private-joined threads  
        Try  
            Dim joinedThreadss As JavaObject = joGC.RunMethod("retrieveArchivedPrivateJoinedThreadChannels", Null)  
            Dim joinedThreads As List = joinedThreadss.RunMethod("complete", Null)  
            For Each t As Object In joinedThreads  
                Dim joT As JavaObject = t  
                Dim tName As String = joT.RunMethod("getName", Null)  
                Dim tId   As String = joT.RunMethod("getId",   Null)  
                output = output & $"  Archived Private-Joined Thread: ${tName} [${tId}]"$ & CRLF  
            Next  
        Catch  
        End Try  
  
        ' 3. Active threads  (don't change the order)  
        Dim activeThreads As List = guildObj.ThreadChannels 'guildObj.RunMethod("getThreadChannels", Null)  
        For Each at As Object In activeThreads  
            Dim joAT As JavaObject = at  
            Dim parentId As JavaObject= joAT.RunMethod("getParentChannel", Null)  
            Dim parentId2 As String = parentId.RunMethod("getId", Null)  
            Dim aName As String = joAT.RunMethod("getName", Null)  
            Dim aId   As String = joAT.RunMethod("getId",   Null)  
            output = output & $"  Active Thread (in ${parentId2}): ${aName} [${aId}]"$ & CRLF  
           
            'Save that if you want: $"– Messages in Thread [${aId}] –"$  
  
            ' Get history object  
            Dim historyJo As JavaObject = joThread.RunMethod("getHistory", Null)  
  
            Dim batch As List  
            Dim retrievedJos As JavaObject  
  
            ' First batch (newest 100)  
           
            retrievedJos =  historyJo.RunMethod("retrievePast", Array(100))  
            Dim retrievedjo As JavaObject=retrievedJos.RunMethod("complete", Null)  
            batch = retrievedjo  
  
            Do While batch.IsInitialized And batch.Size > 0  
               
              
                For Each m As Object In batch  
                    Dim joM    As JavaObject     = m  
                    Dim msgId As String             = joM.RunMethod("getId", Null) ' message id  
                    Dim authorJo As JavaObject      = joM.RunMethod("getAuthor", Null)  
                    Dim author   As String         = authorJo.RunMethod("getName", Null)  
                    Dim timeJo   As JavaObject      = joM.RunMethod("getTimeCreated", Null)  
                    Dim timeStr  As String       = timeJo.RunMethod("toString", Null)  
                    Dim content  As String       = joM.RunMethod("getContentDisplay", Null)  
                    'Dim line     As String     = $"  Message [${timeStr}] ${author}: ${content}"$  
                   
                    Dim dt As Long  
                    Dim aa() As String=Regex.Split("T",timeStr.Replace("Z",""))  'split the date from time  
                    dt=DateTime.DateTimeParse(aa(0),aa(1))  'turn it to long (datetime) - useful for searching  
                  
                    'save the strings if you want…. perhaps line…  
                   
                Next  
                If batch.Size < 100 Then Exit  
  
                ' Page older using the last message object  
                Dim oldestJo As JavaObject = batch.Get(batch.Size - 1)  
  
                retrievedJos = historyJo.RunMethod("retrievePast", Array(100))  
                retrievedjo= retrievedJos.RunMethod("complete", Null)  
                batch = retrievedjo  
            Loop  
           
  
        Next  
  
  
    Next  
  
    Return output  
End Sub
```

  
  
  
You can run the **graball**:  

```B4X
            wait for (GrabAll(currentGuild)) complete (res1 As String)  
            Log(res1)
```

  
  
Have in mind that if you have a huge Guild/Server… with thousand of messages/hundreds channels… may take many hours! (at mine takes 5-6hours)… perhaps you get **Rate Limit Error** - for that there is a way/tip… ;-) (OK i am gonna give you the tip: before read the messages of channels keep the channel id… so if need loop stop for a reason - then continue from that point)  
  
Also if you put your BOT in such loop - don't wait to answer you anything else - until the work end… so becareful!  
  
You can support/donate me (at my signature) and ofcourse [USER=42649]@DonManfred[/USER] for his work!  
I am waiting for his new library… hope to have it soon…