###  PrettyURL: Generating pretty URLs and making http requests. by TILogistic
### 09/06/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/162947/)

Generate pretty URLs and make requests.  
  
**EDIT**:  

```B4X
Private Sub SetPrettyURL(URL As String, Parameters() As Object) As String  
    Dim Output As StringBuilder  
    Output.Initialize  
    Output.Append(URL.Trim)  
    If Parameters.Length = 0 Then Return Output.ToString  
    For Each s As String In Parameters  
        If Not(Output.ToString.CharAt(Output.ToString.Length-1)="/") Then Output.Append("/")  
        Output.Append(s)  
    Next  
    Return Output.ToString  
End Sub
```

  
  

```B4X
Public Sub TestGetRequestPrettyURL   
    Dim ServerURL As String = "https://jsonplaceholder.typicode.com"  
     
    Log("******** Option 1 *********")  
  
    Dim Parameters() As Object = Array("posts", 1)  
    Dim PrettyURL As String = SetPrettyURL(ServerURL, Parameters)  
    Log(PrettyURL)  
    Wait For (GetHttpRequest(PrettyURL)) Complete (DataResult As String)  
    Log(DataResult)  
     
    Log("******** Option 2 *********")  
  
    Dim PrettyURL As String = SetPrettyURL(ServerURL, Array("posts", 1))  
    Log(PrettyURL)  
    Wait For (GetHttpRequest(PrettyURL)) Complete (DataResult As String)  
    Log(DataResult)  
  
    Log("******** Option 3 *********")  
  
    Wait For (GetHttpRequest(SetPrettyURL(ServerURL, Array("posts", 1)))) Complete (DataResult As String)  
    Log(DataResult)  
End Sub  
  
Private Sub GetHttpRequest(URL As String) As ResumableSub  
    Dim Result As String  
    Dim j As HttpJob  
    Try  
        j.Initialize("", Me)  
        j.Download(URL)  
        j.GetRequest.SetHeader("Content-Type","application/json")  
        j.GetRequest.Timeout = 60 * DateTime.TicksPerSecond  
        Wait For (j) JobDone(j As HttpJob)  
        If j.Success Then  
            Result = j.GetString  
        End If  
    Catch  
        Log(LastException)  
    End Try  
    j.Release  
    Return Result  
End Sub
```

  
Output:  
![](https://www.b4x.com/android/forum/attachments/156647)  
  
**Regards.**