###  Firebase Cloud Messaging Subscribe and Unsubscribe Topic by Alexander Stolte
### 02/11/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/88828/)

With this 2 Functions you can Subscribe and Unsubscribe Users from a Topic. This is Useful for Server Apps.  
  
You need the Token from the User, the Token is the InstanceID and this ID is unique for each device, you can get this ID in the "Firebase Cloud Messaging" lib.  
  

```B4X
Public fm As FirebaseMessaging  
fm.Token
```

  
  
You can more read over this [here](https://developers.google.com/instance-id/reference/server#manage_relationship_maps_for_multiple_app_instances).  
  

```B4X
Private Sub SubscribeToTopic(Token() As String, TopicName As String) As ResumableSub  
      
    Dim Job As HttpJob  
    Job.Initialize("fcm", Me)  
    Dim m As Map = CreateMap("to": $"/topics/${TopicName}"$, "registration_tokens":Token)  
   
    Dim jg As JSONGenerator  
    jg.Initialize(m)  
   
    Job.PostString("https://iid.googleapis.com/iid/v1:batchAdd", jg.ToString)  
    Job.GetRequest.SetContentType("application/json")  
    Job.GetRequest.SetHeader("Authorization", "key=" & API_KEY)  
   
    Wait For (Job) JobDone(Job As HttpJob)  
      
    If Job.Success Then  
        Log(Job.GetString)  
        Log("sub war erfolgreich!!!")  
    Else  
        Log("sub war nicht erfolgreich")  
    End If  
    Job.Release  
   
End Sub  
  
Private Sub UnsubscribeTopic(Token() As String, TopicName As String) As ResumableSub  
      
    Dim Job As HttpJob  
    Job.Initialize("fcm", Me)  
    Dim m As Map = CreateMap("to": $"/topics/${TopicName}"$, "registration_tokens":Token)  
  
    Dim jg As JSONGenerator  
    jg.Initialize(m)  
   
    Job.PostString("https://iid.googleapis.com/iid/v1:batchRemove", jg.ToString)  
    Job.GetRequest.SetContentType("application/json")  
    Job.GetRequest.SetHeader("Authorization", "key=" & API_KEY)  
   
    Wait For (Job) JobDone(Job As HttpJob)  
      
    If Job.Success Then  
        Log(Job.GetString)  
        Log("sub war erfolgreich!!!")  
    Else  
        Log("sub war nicht erfolgreich")  
    End If  
    Job.Release  
   
End Sub
```

  
  
Greetings