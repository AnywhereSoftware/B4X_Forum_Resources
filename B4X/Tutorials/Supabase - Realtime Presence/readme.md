###  Supabase - Realtime Presence by Alexander Stolte
### 11/28/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157679/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Share state between users with Realtime Presence.  
<https://supabase.com/docs/guides/realtime/presence>  
  
**Setup**  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime.156354/>  
  
**Sync and track state**  
Listen to the sync, join, and leave events triggered whenever any client joins or leaves the channel or changes their slice of state:  

```B4X
    Realtime _  
    .Channel("Room1","","") _  
    .On(Realtime.SubscribeType_Presence) _  
    .Event(Realtime.Event_Sync) _  
    .On(Realtime.SubscribeType_Presence) _  
    .Event(Realtime.Event_Join) _  
    .On(Realtime.SubscribeType_Presence) _  
    .Event(Realtime.Event_Leave) _  
    .Subscribe
```

  
**Sending state**  
You can send state to all subscribers using track:  

```B4X
Channel1.Track(CreateMap("user":"user-1","online_at":DateUtils.TicksToString(DateTime.Now)))
```

  
**Stop tracking**  
You can stop tracking presence using the untrack() method. This will trigger the sync and leave event handlers.  

```B4X
Channel1.Untrack
```

  
**Events**  

```B4X
Private Sub Realtime_PresenceDataReceived(PresenceData As SupabaseRealtime_PresenceData)  
      
    Log("Presence data:")  
      
    Dim json As JSONGenerator  
    json.Initialize(PresenceData.Joins)  
    Log("Joins: " & json.ToString)  
      
    json.Initialize(PresenceData.Leaves)  
    Log("Leaves: " & json.ToString)  
      
End Sub
```