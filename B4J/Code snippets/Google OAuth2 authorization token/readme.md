### Google OAuth2 authorization token by Erel
### 12/03/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/125176/)

Some of Google online services no longer allow the access token to be sent as a query parameter.  
  
You will get an error similar to:  
"The OAuth token was received in the query string, which this API forbids for response formats other than JSON or XML. If possible, try sending the OAuth token in the Authorization header instead."  
  
The solution is to send it in the authorization header. The secret that they don't tell you is that you need to add "Bearer " to the value:  

```B4X
'this code is from the tool that downloads the Google Sheet translation table and prepares it for the IDE.  
j.Download2($"https://www.googleapis.com/drive/v3/files/1fAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/export"$, _  
     Array As String("mimeType", "text/csv"))  
j.GetRequest.SetHeader("Authorization", "Bearer " & Token)  
Wait For (j) JobDone(j As HttpJob)
```