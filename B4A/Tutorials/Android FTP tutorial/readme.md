### Android FTP tutorial by Erel
### 08/25/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/10407/)

**Old and irrelevant tutorial. Follow this one instead: [[B4X] Net library (FTP, SMTP, POP) with Wait For](https://www.b4x.com/android/forum/threads/84821)**   
  
This tutorial covers the FTP object which is part of the Net library.  
The Net library is based on [Apache Commons Net](http://commons.apache.org/net/).  
  
Android OS doesn't allow us, the developers, to block the main thread for more than 5 seconds. When the main thread is busy for too long and is not able to handle the user events the "Application not responding" dialog appears.  
Therefore slow operations like network operations should be done in the background.  
The FTP library is built in such a way. All of the methods return immediately. When a task completes an event is raised. In fact you can submit several tasks one after another. The FTP protocol supports a single task at a time so the tasks will be processed serially.  
  
Using the FTP library is pretty simple.  
The first step is to initialize the FTP object. If this is an Activity module then you should do it in Activity\_Create when FirstTime is true.  
For Service modules it should be initialized in Service\_Create.  

```B4X
Sub Process_Globals  
    Dim FTP As FTP  
End Sub  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime Then  
        FTP.Initialize("FTP", "ftp.example.com", 21, "user", "password")  
    End If
```

FTP.Initialize doesn't connect to the server. Connection will be established implicitly together with the next task.  
  
**Download**  
  
Downloading a file is done by calling DownloadFile with the remote file path and the local file path.  
If you want to show the download progress then you should handle DownloadProgress event.  
When download completes the DownloadCompleted event is raised. The ServerPath is passed as the first parameter to all events. You can use it to distinguish between different tasks. Make sure to check the Success parameter. If Success is False then you can find the exception message by calling LastException.  
  

```B4X
    FTP.DownloadFile("/somefolder/files/1.zip", False, File.DirRootExternal, "1.zip")  
     
Sub FTP_DownloadProgress (ServerPath As String, TotalDownloaded As Long, Total As Long)  
    Dim s As String  
    s = "Downloaded " & Round(TotalDownloaded / 1000) & "KB"  
    If Total > 0 Then s = s & " out of " & Round(Total / 1000) & "KB"  
    Log(s)  
End Sub  
  
Sub FTP_DownloadCompleted (ServerPath As String, Success As Boolean)  
    Log(ServerPath & ", Success=" & Success)  
    If Success = False Then Log(LastException.Message)  
End Sub
```

**Upload**  
  
Uploading is similar to downloading.  

```B4X
    FTP.UploadFile(File.DirRootExternal, "1.txt", True, "/somefolder/files/1.txt")  
  
Sub FTP_UploadProgress (ServerPath As String, TotalUploaded As Long, Total As Long)  
    Dim s As String  
    s = "Uploaded " & Round(TotalUploaded / 1000) & "KB"  
    If Total > 0 Then s = s & " out of " & Round(Total / 1000) & "KB"  
    Log(s)  
End Sub  
  
Sub FTP_UploadCompleted (ServerPath As String, Success As Boolean)  
    Log(ServerPath & ", Success=" & Success)  
    If Success = False Then Log(LastException.Message)  
End Sub
```

**List files and folders**  
  
FTP.List sends a request for the list of files and folders in a specific path.  
The ListCompleted event is raised when the data is available.  
You can use code similar to the following code to get more information on the entries:  

```B4X
FTP.List("/")  
…  
Sub FTP_ListCompleted (ServerPath As String, Success As Boolean, Folders() As FTPEntry, Files() As FTPEntry)  
    Log(ServerPath)  
    If Success = False Then  
        Log(LastException)  
    Else  
        For i = 0 To Folders.Length - 1  
            Log(Folders(i).Name)  
        Next  
        For i = 0 To Files.Length - 1  
            Log(Files(i).Name & ", " & Files(i).Size & ", " & DateTime.Date(Files(i).Timestamp))  
        Next  
    End If  
End Sub
```

**Delete**  
Delete is done by calling FTP.Delete with the full path. Again an event will be raised when the task completes (DeleteCompleted).  
  
**Closing the connection**  
You can close the connection by calling FTP.Close. Close will wait for the other tasks to complete and then will close the connection. This happens in the background.  
FTP.CloseNow will immediately close the connection, failing the remaining tasks.  
  
Some notes:  
- At any given time there should be less than 15 waiting tasks. Otherwise you will get a RejectedExecutionException (this happens when the internal threads pool is exhausted).  
- The order of the completed tasks may be different than the order of submission.  
- The AsciiFile parameters sets the file transfer mode. If AsciiFile is true then every occurrence of an end of line character will be translated based on the server native end of line character. If your FTP server is Unix or Linux then the end of line character is the same as Android.  
In most cases you can set AsciiFile to false.  
  
The library is available for download here: <http://www.b4x.com/forum/additional-libraries-classes-official-updates/10892-new-net-library-android-ftp-smtp-pop3.html>