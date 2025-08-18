###  Post multipart requests / file uploads with progress by Erel
### 04/27/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/130181/)

This code will work in B4A and B4J. It will not work in B4i.  
  

```B4X
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
    req.SetContentEncoding("UTF8")  
    TrackProgress(cin, length)  
    job.Tag = TempFileName  
    CallSubDelayed2(HttpUtils2Service, "SubmitJob", job)  
    Return job  
End Sub  
  
Private Sub MultipartStartSection (stream As OutputStream, empty As Boolean) As Boolean  
    If empty = False Then  
        stream.WriteBytes(Array As Byte(13, 10), 0, 2)  
    Else  
        empty = False  
    End If  
    Return empty  
End Sub  
  
Private Sub TrackProgress (cin As CountingInputStream, length As Int)  
    TrackerIndex = TrackerIndex + 1  
    Dim MyIndex As Int = TrackerIndex  
    Do While MyIndex = TrackerIndex  
        Log($"$1.2{cin.Count * 100 / length}%"$)  
        If cin.Count = length Then Exit  
        Sleep(100)  
    Loop  
End Sub
```

  
  
The progress is available inside TrackProgress. See the logs.  
  
See attached project. Note that you need to delete the temporary file after the job is completed.