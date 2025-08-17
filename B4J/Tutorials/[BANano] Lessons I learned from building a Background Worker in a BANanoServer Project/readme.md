### [BANano] Lessons I learned from building a Background Worker in a BANanoServer Project by Mashiane
### 04/11/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166585/)

Hi Fam  
  
V7 of BANano came with background workers. I tested this and I was happy recently to actually use them in a solution.  
  
<https://www.b4x.com/android/forum/threads/banano-v7-using-background-workers-in-your-webapps-introduction.134544/#content>  
  
The beaty of these gems is them not affecting the main thread. This means they can help in speeding up your app. The UI wont be hogged as long processes will run in the background. Its multi-threading your app. These lessons are personal to my experience and I could be wrong and stand to be corrected.  
  
**Lesson 1 - A webworker is an app and cannot reference b4xlib**  
  
A webworker is a class object. So I thought I could add another class in my project and or refer to a b4xlib that the web worker will use, This did not work. It seems the web worker code should be self encompassing, i.e. all the code that it will use should be in it. For me this felt like a redundance as I had to use code that I already have in my project, but then I shifted my thought to think of it as an independent app. Yes, mine uses BANanoFetch but it just wasnt able to use stuff in my b4xlib without a compilation error.  
  
So all the code to execute fetches and all that was later inside the web worker.  
  
**Lesson 2: Some variables wont work if you put them on class globals**  
  
As my web worker was doing fetch calls, I hoped that defining a BANanoFetch object in class globals to be referenced anywhere would work. It did not. So define most variables locally where you use them.  
  
**Lesson 3: The process flow of the Background Worker.**  
  
3.1 Add the background worker in **Main > App** Start before building your app.  
  

```B4X
Server.BANano.AddBackgroundWorker("worker", "BROWSERGreenAPIWorker28")
```

  
  
3.2 Start the Background Worker in **BROWSERAPP. Initialize** and no where else. This is the main thread of the app it seems. You cannot start the worker from a button click event.  
  

```B4X
BANano.StartBackgroundWorker("worker", Null)
```

  
  
3.3. If you need to call the Background Worker anywhere in your app, call it via the BROWSERAPP. So anywhere in my app I call Main.MyApp.GetGreenApiContacts. The GetGreenApiContacts is a subroutine inside my background worker, however I also have a sub in my BROWSER app of the same name to call the one inside the background worker that does everything I need  
  
*GetGreenApiContacts in BROWSERAPP that calls the background worker*  
  

```B4X
Sub GetGreenApiContacts  
    BANano.RunBackgroundWorkerMethod("worker", "GetGreenApiContacts", "GetGreenApiContacts", Array(GA_Instance, GA_Token, DBAddress))  
End Sub
```

  
  
*GetGreenApiContacts inside Backround Worker that does the work*  
  

```B4X
Sub GetGreenApiContacts(sInstance As String, sToken As String, sDBAddress As String)  
    'get current chats, if one exist, we will update  
    Dim chats As Map = CreateMap()  
    'create the contact in the contacts table  
    FetchInitialize($"${sDBAddress}/records/chats"$)  
    SetContentTypeApplicationJSON  
    BANano.Await(fetchit("GET"))  
    If Response.ContainsKey("records") Then  
        Dim result As List = Response.Get("records")  
        For Each rec As Map In result  
            Dim schatid As String = rec.Get("chatid")  
            Dim sid As String = rec.Get("id")  
            chats.Put(schatid, sid)  
        Next  
    End If  
….  
BANano.SendFromBackgroundWorker("GetGreenApiContacts", "Done", Null)
```

  
  
  
3.4 The data sent from the background worker must be received by BROWSERAPP. So when my background worker sub finishes, it sends a message to the main thread.  
  
The ending line of my GetGreenApiContacts sub inside the background worker sub-routine has this added to it.  
  

```B4X
BANano.SendFromBackgroundWorker("GetGreenApiContacts", "Done", Null)
```

  
  
This will then ensure that the message is sent and is trapped by the following call in BROWSERApp.  
  

```B4X
public Sub BANano_MessageFromBackgroundWorker(WorkerName As String, Tag As String, Value As Object, Error As Object)                'ignoredeadcode  
    ' the Tag will define the type of message send by the Background Worker  
    Select Case Tag  
    Case "GetGreenApiContacts"  
'        'we are getting contacts from greenapi  
'        Dim sjson As String = BANano.ToJson(Value)  
'        App.DownloadTextFile(sjson, "conversations.json")  
        App.ShowToastSuccess($"Contacts have been extracted and updated."$)          
    End Select  
End Sub
```