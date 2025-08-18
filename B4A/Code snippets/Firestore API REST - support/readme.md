### Firestore API REST - support by Paolodc
### 04/09/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129551/)

Hello comunity! I'm delighted to share my methods to use simply Firestore using B4A(maybe also with B4I and B4J, but I don't use them).  
As result of my tiring research to use it, I've decided to help everyone who need to implement Firesore in his own projects.  
  
There are four subs that you can use to create and delete a document, to get both document and values , and to both patch and put new value in different keys.  
  
[FONT=arial]**Three warning:**[/FONT]  
1) {projectId} - you put into that your project id  
2) You have to start "collection" parameter directly with document's name without "/". Ex: ("mydocument/numerone")  
3) When you create o put new values you must have one user token.  
See this forum if you don't know what is it: <https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users.67875/#content>  
  
**Read document:**  

```B4X
Public Sub getDocument(Coleccion As String) As ResumableSub  
     
    Dim link As String = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/${Coleccion}"$  
  
         
    Dim okHttp As HttpJob  
    okHttp.Initialize("HTTP", Me)  
     
    okHttp.Download(link & "info_chats")  
    Wait For (okHttp) JobDone(j As HttpJob)  
         
    If j.Success Then  
         
        Log(j.GetString)  
        Dim jsonString As JSONParser  
        jsonString.Initialize(j.GetString)  
        Dim map As Map = jsonString.NextObject  
  
        Return map  
         
    Else  
        Log(j.ErrorMessage)  
    End If  
  
End Sub
```

  
Example:  

```B4X
Wait For (getDocument("server/names")) Complete(m As Map)
```

  
  
  
 **values:**  

```B4X
Public Sub patchValues(Token As String, collection As String, Campos As Map) As ResumableSub  
     
    Dim url As String = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents${collection}"$'?documentId=${Documento}"$  
    Dim Json As JSONGenerator  
    Json.Initialize(CreateMap("fields":Campos))  
     
    Dim j As HttpJob : j.Initialize("",Me)  
    Log(Json.ToString)  
     
    j.PatchString(url,Json.ToString)  
    j.GetRequest.SetHeader("Authorization","Bearer " & Token)  
    j.GetRequest.SetContentType("application/json")  
     
    Wait For (j) JobDone(j As HttpJob)  
    Return GenerateResult(j)  
  
End Sub
```

  
Example:  

```B4X
Wait For (patchValues(UserTokenId, "info_chats/id_group_chat1", CreateMap("name" : CreateMap("stringValue": "Paolo")))) Complete(m As Map)
```

  
  
  
**Create document:**  

```B4X
Public Sub createDocument(Token As String, collection As String, Documento As String, Campos As Map) As ResumableSub  
     
    Dim url As String = $"https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/${collection}?documentId=${Documento}"$  
    Dim json As JSONGenerator  
    json.Initialize(CreateMap("fields":Campos))  
     
    Dim j As HttpJob : j.Initialize("",Me)  
    Log(json.ToString)  
    j.PostString(url,json.ToString)  
    j.GetRequest.SetHeader("Authorization","Bearer " & Token)  
    j.GetRequest.SetContentType("application/json")  
     
    Wait For (j) JobDone(j As HttpJob)  
    Return GenerateResult(j)  
  
End Sub
```

  
Example:  

```B4X
Wait For (Firestore.createDocument(UserTokenId, "info_chats","Profile", CreateMap("name" : CreateMap("stringValue": "Paolo")))) Complete(m As Map)
```

  
  
  
**Deletedocument:**  

```B4X
Public Sub deleteDocument(Token As String, collection As String) As ResumableSub  
     
    Dim url As String = $"https://firestore.googleapis.com/v1/projects/{projectid}/databases/(default)/documents/${collection}"$'?documentId=${Documento}"$  
  
    Dim j As HttpJob : j.Initialize("",Me)  
    j.Delete(url)  
    j.GetRequest.SetHeader("Authorization","Bearer " & Token)  
     
    Wait For (j) JobDone(j As HttpJob)  
    Return GenerateResult(j)  
  
End Sub
```

  
Example:  

```B4X
Wait For (Firestore.deleteDocument(UserTokenId, "info_chats/Profile")) Complete(m As Map)
```

  
  
  
There is one more thing to say. I use a function to convert httpjson job to Map. Actually you mustn't use it but to reduce all code I suggest get it.  

```B4X
Private Sub GenerateResult(j As HttpJob) As Map  
    Dim response As String = ""  
    If j.Success Then  
        response = j.GetString  
        Log(j.GetString)  
    Else  
        response = j.ErrorMessage  
    End If  
      
    Dim parser As JSONParser  
    parser.Initialize(response)  
    Dim tmp_result As Map = parser.NextObject  
    tmp_result.Put("success",j.Success)  
      
    j.Release  
    Return tmp_result  
End Sub
```

  
  
  
  
Oh, yes! This is the way to code with B4A.  
I'hope I have help someone with this.  
  
See you at my next creations!  
  
PS: I apologize for my wrong english, I'm studying it.  
[FONT=book antiqua]PaoloDc ???[/FONT]