###  Supabase - Realtime by Alexander Stolte
### 11/28/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/156354/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
This is a very simple tutorial on how to use the Realtime module. A more detailed tutorial is coming soon.  
  
**Step 1**  
Click in your project on "Project -> Build configurations -> Conditional Symbols"  
Put [ICODE]SupabaseRealTime[/ICODE] and click ok  
  
**Step 2**  
Check in the libraries tab the following libs.:  
 B4A: WebSocket  
 B4I: iWebSocket  
 B4J: [jWebSocketClient V2.0+](https://www.b4x.com/android/forum/threads/jwebsocketclientv2.156357/post-963635)  
  
**Step 3**  
Initialize the SupabaseRealtime class  

```B4X
Sub Class_Globals  
    Public xSupabase As Supabase  
    Private Realtime As SupabaseRealtime  
End Sub  
  
#IF B4J  
Private Sub xlbl_Connect2Realtime_Click_MouseClicked (EventData As MouseEvent)  
#Else  
Private Sub xlbl_Connect2Realtime_Click  
#End If  
   
    Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)  
   
    If isLoggedIn = False Then  
   
        Wait For (xSupabase.Auth.LogIn_EmailPassword("test@gmail.com","Test123!!")) Complete (User As SupabaseUser)  
        If User.Error.Success Then  
            Log("successfully logged in with " & User.Email)  
        Else  
            Log("Error: " & User.Error.ErrorMessage)  
            Return  
        End If  
   
    End If  
   
    '********Realtime part************************  
    Realtime.Initialize(Me,"Realtime",xSupabase) 'Initializes the realtime class  
    Realtime.Connect 'Connect to the supabase realtime server  
   
    Wait For Realtime_Connected 'Client is connected  
    Log("Realtime_Connected")  
   
End Sub
```

  
  
**Supabase provides a globally distributed cluster of Realtime servers that enable the following functionality:**  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-postgres-changes.157673/>  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-broadcast.157674/>  
<https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-presence.157679/>  
  
**Supabase Dashboard**  
You need to turn on the realtime feature for each table, a description can be found here:  
<https://supabase.com/docs/guides/realtime>