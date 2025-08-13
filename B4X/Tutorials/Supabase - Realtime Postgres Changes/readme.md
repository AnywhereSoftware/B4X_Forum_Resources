###  Supabase - Realtime Postgres Changes by Alexander Stolte
### 11/28/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157673/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Listen to Postgres changes using Supabase Realtime.  
<https://supabase.com/docs/guides/realtime/postgres-changes>  
  
**Setup**  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime.156354/>  
  
**Listening to ALL events**  

```B4X
    Realtime _  
    .Channel("public","dt_Chat","") _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_ALL) _  
    .Subscribe 'subscribe to a topic - In this example we subscibe to all database changes on dt_Tasks  
  
    Wait For Realtime_Subscribed 'Successfully subscribed  
    Log("Subscribed to topic")
```

  
**Listening to INSERT events**  

```B4X
    Realtime _  
    .Channel("public","dt_Chat","") _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_INSERT) _  
    .Subscribe
```

  
**Listening to UPDATE events**  

```B4X
    Realtime _  
    .Channel("public","dt_Chat","") _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_UPDATE) _  
    .Subscribe
```

  
**Listening to DELETE events**  

```B4X
    Realtime _  
    .Channel("public","dt_Chat","") _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_DELETE) _  
    .Subscribe
```

  
**Listening to multiple changes**  

```B4X
    Realtime _  
    .Channel("public","dt_Chat","") _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_INSERT) _  
     .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_UPDATE) _  
    .Subscribe
```

  
**Filtering for specific changes**  
Filters are there to react only to certain changes. e.g. we want to have only all changes from the chat room with id 3.  
In the following example we subscribe to all database changes with room\_id = 3  

```B4X
    Realtime _  
    .Channel("public","dt_Chat",Realtime.BuildFilter("room_id",Realtime.Filter_Equal,"3")) _  
    .On(Realtime.SubscribeType_PostgresChanges) _  
    .Event(Realtime.Event_ALL) _  
    .Subscribe
```

  
**Events**  

```B4X
Private Sub Realtime_DataReceived(Data As SupabaseRealtime_Data)  
   
    If Data.EventType = Realtime.Event_UPDATE Then 'A record in the database was changed  
   
        For Each k As String In Data.Records.Keys  
            Log($"Column: "${k}" Value: "${Data.Records.Get(k)}""$)  
        Next  
   
    End If  
   
End Sub
```