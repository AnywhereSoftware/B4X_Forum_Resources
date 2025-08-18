### Download file via HTTP with resume by peacemaker
### 09/20/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/122491/)

Here my results in big project (impossible to publish) that may be useful as the code snippet for community to develop more.  
  
When working with FTP server - there may be troubles with mobile Internet quality and a corrupted file must be fully re-downloaded. For big files it's impossible to finish practically. So it needs to resume downloading starting the final file size.  
1) Here is PHP script for the HTTP server implementation of partial downloading (only starting the offset up to the file end)  
2) And B4A code snippet for working with it.  
  

```B4X
'it's FTP structure just for clear understanding the code  
Type FTPEntry2(Name As String, Timestamp As Long, Size As Long, FTPpath As String, LocalPath As String, status As String, DeleteAfter As Boolean)    'writable file info structure (FTP FTPEntry structure is read-only)  
…  
  
Sub Global_Download_File(f As FTPEntry2)  
    If Not(Starter.InternetConnected) Then Return  
    If f.Size < BIGFILESIZE/10 And Not(f.status.ToLowerCase.Contains("error")) Then   'small file is downloaded via FTP as main way  
        FTP1.DownloadFile(f.FTPpath, False, others.GetPath(f.LocalPath), f.Name)  
        Return       
    End If  
    'dowloading big files over HTTP with resume  
    Dim su As StringUtils  
    Dim APIURL As String = "https://webserver/api.php?username=" & su.EncodeUrl(Starter.DeviceID, "UTF8") & "&download=" & su.EncodeUrl(f.FTPpath, "UTF8")  
    Dim j As HttpJob  
    j.Initialize(f.Name, Me)  
   
    Dim fsize As Long  
    If File.Exists(f.LocalPath, "") Then  
        fsize = File.Size(f.LocalPath, "")  
    End If  
   
    'fistly request the HEAD to get the file size to compare later after downloading  
    j.Head(APIURL)  
    Wait For (j) JobDone(j As HttpJob)  
    If Not(j.Success) Then  
        Dim StatusCode As String = j.Response.StatusCode  
        others.AddToLog("HTTP HEAD error: " & StatusCode & "; " & j.JobName)  
        j.Release  
        CallSubDelayed(Me, "Check_AndDownload")  
        Return  
    End If  
    Dim headers As Map = j.Response.GetHeaders  
    Dim L As List = headers.Get("content-length")  
    Dim head_size As Long = L.Get(0)    'full size of the file to compare after downloading  
    If head_size = 0 Then  
        others.AddToLog("HTTP HEAD zero size: " & f.FTPpath)  
        CallSubDelayed(Me, "Check_AndDownload")  
        Return  
    End If  
   
    'now GETting the file—————————  
    If fsize > head_size Then    're-downloading  
        File.Delete(f.LocalPath, "")  
        fsize = 0  
    End If  
    j.Download(APIURL): j.GetRequest.SetHeader("Range", "bytes=" & fsize & "-")  
    Log("Downloading via HTTP: " & f.FTPpath)  
    Wait For (j) JobDone(j As HttpJob)  
    If Not(j.Success) Then  
        Dim StatusCode As String = j.Response.StatusCode  
        others.AddToLog("HTTP GET error: " & StatusCode & "; " & f.FTPpath)  
        f.status = "download_error"  
        Dim out As OutputStream = File.OpenOutput(others.GetPath(f.LocalPath), f.Name, True)   'True !!!  
        File.Copy2(j.GetInputStream, out)  
        out.Close '<—— very important  
        j.Release  
        If Starter.InternetConnected Then  
            If Not(StatusCode.StartsWith("4")) Then    'client errors  
                Log("resume HTTP downloading: " & f.FTPpath)  
                CallSubDelayed2(Me, "Global_Download_File", f)    'resume download  
                Return  
            End If  
        End If  
        CallSubDelayed(Me, "Check_AndDownload")  
        Return  
    End If  
    f.status = "OK"  
    Dim out As OutputStream = File.OpenOutput(others.GetPath(f.LocalPath), f.Name, True)   'True !!!  
    File.Copy2(j.GetInputStream, out)  
    out.Close '<—— very important  
    j.Release  
  
    fsize = File.Size(f.LocalPath, "")    'current local file's size after download  
    If fsize = head_size Then    'fully downloaded  
        f.status = "downloaded_ok"  
        CallSubDelayed3(Me, "FTP1_DownloadCompleted", f.FTPpath, True)    'finish processing file  
    Else    'resume downloading  
        f.status = "error_interrupted_download"  
        If Starter.InternetConnected Then  
            CallSubDelayed2(Me, "Global_Download_File", f)    'resume downloading  
        End If  
    End If  
End Sub
```

  
  
Most FTP code is related to [this project](https://www.b4x.com/android/forum/threads/automated-synchronous-ftp-client.122000).  
[AddtoLog, GetPath, GetFileName](https://www.b4x.com/android/forum/threads/super-others-my-42-common-usage-subs.98529/)  
  
[SPOILER="Postman's requests and headers"]  
![](https://www.b4x.com/android/forum/attachments/100220)  
![](https://www.b4x.com/android/forum/attachments/100221)  
[/SPOILER]