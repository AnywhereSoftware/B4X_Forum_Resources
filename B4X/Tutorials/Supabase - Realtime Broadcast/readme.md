###  Supabase - Realtime Broadcast by Alexander Stolte
### 11/28/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157674/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Send and receive messages using Realtime Broadcast  
<https://supabase.com/docs/guides/realtime/broadcast>  
  
**Setup**  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime.156354/>  
  
**Listening to Broadcast messages**  

```B4X
    Realtime _  
    .Channel("Room1","","") _  
    .On(Realtime.SubscribeType_Broadcast) _  
    .ReceiveOwnBroadcasts(False) _  
    .AcknowledgeBroadcasts(False) _  
    .Subscribe
```

  
**Sending Broadcast messages**  

```B4X
Channel1.SendBroadcast("cursor-pos",CreateMap("x":"198","y":"50"))
```

  
**Self-send messages**  
By default, broadcast messages are only sent to other clients. You can broadcast messages back to the sender by setting Broadcast's self parameter to true.  

```B4X
    Realtime _  
    .Channel("Room1","","") _  
    .On(Realtime.SubscribeType_Broadcast) _  
    .ReceiveOwnBroadcasts(True) _  
    .Subscribe
```

  
**Acknowledge messages**  
You can confirm that Realtime received your message by setting Broadcast's ack config to true.  

```B4X
    Realtime _  
    .Channel("Room1","","") _  
    .On(Realtime.SubscribeType_Broadcast) _  
    .AcknowledgeBroadcasts(True) _  
    .Subscribe
```

  
**Events**  

```B4X
Private Sub Realtime_BroadcastDataReceived(BroadcastData As SupabaseRealtime_BroadcastData)  
      
    Log("Broadcast data for event: " & BroadcastData.Event)  
    Log("Data:")  
    For Each k As String In BroadcastData.Payload.Keys  
        Log(k & ":" & BroadcastData.Payload.Get(k))  
    Next  
      
End Sub
```