###  Net library (FTP, SMTP, POP) with Wait For by Erel
### 02/14/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/84821/)

Starting from v1.70 of Net, jNet and iNet libraries the asynchronous methods return a 'sender filter' object.  
This object can be passed as the sender filter parameter in a Wait For call.  
This makes it simpler to manage multiple requests.  
  
For example:  

```B4X
'ftp was previously initialized and its event name was set to ftp:  
'ftp.Initialize("ftp", "your.server", 21, "user", "password")  
Dim sf As Object = ftp.UploadFile(File.DirAssets, "somefile", False, "/somefile")  
Wait For (sf) ftp_UploadCompleted (ServerPath As String, Success As Boolean)  
If Success Then  
   Log("file was uploaded successfully")  
Else  
   Log("Error uploading file")  
End If
```

  
  
Multiple subs can wait for the same event. Thanks to the sender filter parameter, each event will be intercepted in the correct wait for call.  
  
The same technique can be used with all asynchronous methods in the Net library.  
  
Notes  
  
- B4i iNet and B4J jNet are internal libraries.  
- B4A library is available here: <https://www.b4x.com/android/forum/threads/new-net-library-android-ftp-smtp-and-pop3.10892/#content>  
  
Note that B4J and B4A libraries are identical.