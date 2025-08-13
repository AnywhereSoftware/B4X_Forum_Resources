### FireStore StructuredQuery API REST by gregorio_adrian_gimenez
### 10/23/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143548/)

HI everyone!  
I share with you this code that allows you to make a query in a firestore database applying filters by fields  
It is complemented with this publication by Paolo <https://www.b4x.com/android/forum/threads/firestore-api-rest-support.129551/>  
This is the link to the firestore documentation <https://cloud.google.com/firestore/docs/reference/rest/v1beta1/StructuredQuery#Projection>  
  
![](https://www.b4x.com/android/forum/attachments/134851)  
  
  

```B4X
sub Class_Globals  
    Private user As FirebaseAuth  
    Public tokenIdServer as String  
    Private projectId As String = "XXXXXXXXXXXXX" ' Id FirebaseProject  
 End sub  
  
Public Sub Initialize  
    user.Initialize("user")  
End Sub  
  
Sub token  '  to execute a query you must request a token. You can call this sub in your code wherever you need it  
        user.GetUserTokenId(user.CurrentUser,False) ' The response raises Sub user_TokenAvailable  
End Sub  
  
  
Sub user_TokenAvailable (User As FirebaseUser, Success As Boolean, TokenId As String)  
    tokenIdServer= TokenId   '–> token to use in Sub query  
    code   ' when you get the token to perform the query, you call the sub code  
End Sub  
  
  
   sub code  
'create the structure to perform a filter query  
   Dim mapa As Map  
    mapa.Initialize  
   
    Dim data As List  
    data.Initialize  
    data.Add(CreateMap("collectionId":"test"))   'test-> collection Firestore  
   
    Dim mapafiltro As Map  
    mapafiltro.Initialize  
    mapafiltro.Put("field",CreateMap("fieldPath":"name"))  ' name field  
    mapafiltro.Put("op","EQUAL")  
    mapafiltro.Put("value",CreateMap("stringValue":"gregorio"))   'gregorio = value  
    mapa.Put("from",data)  
    mapa.Put("where",CreateMap("fieldFilter":mapafiltro))  
   
    query (mapa)  
end sub  
   
  
  
  
Public Sub query(runquery As Map) As ResumableSub  
 Try  
        Dim url As String = $"https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents:runQuery"$  
        Dim json As JSONGenerator  
        json.Initialize(CreateMap("structuredQuery": runquery))  
            Dim j As HttpJob : j.Initialize("",Me)  
            Log(json.ToString)  
            j.PostString(url,json.ToString)  
            j.GetRequest.SetHeader("Authorization","Bearer " & tokenIdServer)  
            j.GetRequest.SetContentType("application/json")    
            Wait For (j) JobDone(j As HttpJob)  
            Return GenerateResultquery(j)  
        Catch  
        Log(LastException)  
    End Try  
End Sub  
Private Sub GenerateResultquery(j As HttpJob) As String  
    Try  
    Dim response As String = ""  
    If j.Success Then  
        response = j.GetString  
        Log(j.GetString)  
    Else  
        response = j.ErrorMessage  
    End If  
   
    j.Release  
        Return response  
  
    Catch  
        Log(LastException)  
        End Try  
End Sub
```

  
  
  
  
regards