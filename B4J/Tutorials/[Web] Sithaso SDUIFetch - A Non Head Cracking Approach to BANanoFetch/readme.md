### [Web] Sithaso SDUIFetch - A Non Head Cracking Approach to BANanoFetch by Mashiane
### 01/20/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163648/)

Hi Fam  
  
SDUIFetch is internal to SithasoDaisy. Its aim is to make it easier to use BANanoFetch as its a wrap on top of BANanoFetch, to make it easier to use. Well, after so many times of forgetting how BANanoFetch works, I opted for an easier approach.  
  
Imagine.  
  

```B4X
''execute the fetch  
Dim j As SDUIFetch  
'initialize the fetch with the base url  
j.Initialize("https://api.funtranslations.com/translate/minion.json")  
'add a parameters  
j.AddParameter("text", txtMessage.value)  
'set content type  
j.SetContentTypeApplicationJSON  
'add header  
j.AddHeader("X-Funtranslations-Api-Secret", "")  
j.NoCache = True  
'execute the post  
BANano.Await(J.PostWait)  
If j.Success Then  
    Dim Response As Map = j.response  
    If Response.ContainsKey("contents") Then  
        Dim minionTaal As String = j.GetRecursive(Response, "contents.translated")  
        txtConvert.Value = minionTaal  
    End If  
Else   
    txtConvert.Value = j.ErrorMessage  
End If
```

  
  
Internally this uses BANanoFetch but personally for me in a more easier apprieach.