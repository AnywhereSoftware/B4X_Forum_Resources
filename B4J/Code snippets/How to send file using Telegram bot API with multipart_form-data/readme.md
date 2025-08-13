### How to send file using Telegram bot API with multipart/form-data by Gandalf
### 02/01/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/145840/)

I got it working finally. So, for sending files to Telegram bot without using curl, you need to do the following:  
1. Download Erel's sample project of [[B4X] Post multipart requests / file uploads with progress](https://www.b4x.com/android/forum/threads/b4x-post-multipart-requests-file-uploads-with-progress.130181/)  
2. Slightly modify it as shown below (pay attention to my comments in code):  

```B4X
Private Sub Button1_Click  
    Dim fd As MultipartFileData  
    fd.Initialize  
    fd.KeyName = "document"        'DOCUMENT KEY IS USED FOR SENDING GENERAL FILES  
    fd.Dir = File.DirAssets        'SET YOUR FILE DIRECTORY  
    fd.FileName = "1.txt"        'SET YOUR FILENAME  
    Dim m As Map                'ADD A MAP FOR PARAMETERS  
    m.Initialize                'INIT IT  
    m.Put("chat_id", 12345678)    'PUT YOUR CHAT ID. ADD OTHER PARAMETERS TO THIS MAP IF NECESSARY  
    Dim job As HttpJob = CreateMultipartJob("https://api.telegram.org/YOURBOTKEYHERE/sendDocument", m, Array(fd))    'PUT YOUR BOT KEY HERE. NOTE "sendDocument" METHOD IS USED WITH PARAMETERS MAP  
    Wait For (job) JobDone (job As HttpJob)  
    Log(job)  
    File.Delete(xui.DefaultFolder, job.Tag)  
    job.Release  
End Sub  
  
Public Sub CreateMultipartJob(Link As String, NameValues As Map, Files As List) As HttpJob  
    Dim boundary As String = "—————————1461124740692"  
    TempCounter = TempCounter + 1  
    Dim TempFileName As String = "post-" & TempCounter  
    Dim stream As OutputStream = File.OpenOutput(xui.DefaultFolder, TempFileName, False)  
    Dim b() As Byte  
    Dim eol As String = Chr(13) & Chr(10)  
    Dim empty As Boolean = True  
    If NameValues <> Null And NameValues.IsInitialized Then  
        For Each key As String In NameValues.Keys  
            Dim value As String = NameValues.Get(key)  
            empty = MultipartStartSection (stream, empty)  
            Dim s As String = _  
$"–${boundary}  
Content-Disposition: form-data; name="${key}"  
  
${value}"$  
            b = s.Replace(CRLF, eol).GetBytes("UTF8")  
            stream.WriteBytes(b, 0, b.Length)  
        Next  
    End If  
    If Files <> Null And Files.IsInitialized Then  
        For Each fd As MultipartFileData In Files  
            empty = MultipartStartSection (stream, empty)  
            Dim s As String = _  
$"–${boundary}  
Content-Disposition: form-data; name="${fd.KeyName}"; filename="${fd.FileName}"  
Content-Type: ${fd.ContentType}  
  
"$  
            b = s.Replace(CRLF, eol).GetBytes("UTF8")  
            stream.WriteBytes(b, 0, b.Length)  
            Dim in As InputStream = File.OpenInput(fd.Dir, fd.FileName)  
            File.Copy2(in, stream)  
        Next  
    End If  
    empty = MultipartStartSection (stream, empty)  
    s = _  
$"–${boundary}–  
"$  
    b = s.Replace(CRLF, eol).GetBytes("UTF8")  
    stream.WriteBytes(b, 0, b.Length)  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    stream.Close  
    Dim length As Int = File.Size(xui.DefaultFolder, TempFileName)  
    Dim in As InputStream = File.OpenInput(xui.DefaultFolder, TempFileName)  
    Dim cin As CountingInputStream  
    cin.Initialize(in)  
    Dim req As OkHttpRequest = job.GetRequest  
    req.InitializePost(Link, cin, length)  
    req.SetContentType("multipart/form-data; boundary=" & boundary)  
    'req.SetContentEncoding("UTF8")                                        'COMMENT OR REMOVE THIS STRING - IT CAUSES ERROR RESPONSE FROM TELEGRAM  
    'req.RemoveHeaders("Connection")                                    'IF YOU WANT YOUR REQUEST TO LOOK MORE CURL-LIKE, UNCOMMENT THIS  
    'req.RemoveHeaders("Accept-Encoding")                                'AND THIS  
    'req.SetHeader("Accept", "*/*")                                        'AND THIS  
    TrackProgress(cin, length)  
    job.Tag = TempFileName  
    CallSubDelayed2(HttpUtils2Service, "SubmitJob", job)  
    Return job  
End Sub
```

  
  
3. All other subs leave unchanged.  
4. Enjoy.