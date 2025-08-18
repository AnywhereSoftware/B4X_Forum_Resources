### [module] rHttpUtils2 - Http Client by Erel
### 02/23/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/74785/)

The HttpJob module implements an http client. It is a simplified version of B4X HttpUtils2.  
  
Example:  

```B4X
Sub Process_Globals  
   Public Serial1 As Serial  
   Private wifi As ESP8266WiFi  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   Log("AppStart")  
   If wifi.Connect("dlink") Then  
     Log("Connected to router.")  
   Else  
     Log("Failed to connect to router.")  
     Return  
   End If  
   HttpJob.Initialize("Example")  
   HttpJob.Download("https://www.example.com")  
End Sub  
  
  
Sub JobDone (Job As JobResult)  
   Log("*******************************")  
   Log("JobName: ", Job.JobName)  
   If Job.Success Then  
     Dim bc As ByteConverter  
     Log("Response: ", bc.SubString2(Job.Response, 0, Min(200, Job.Response.Length))) 'truncate to 200 characters  
     If Job.JobName = "Example" Then  
       'send another request  
       'This time it is a POST request and we set the Content-Type header  
       HttpJob.Initialize("Example2")  
       'add headers before calling Post or Download (this is different than the standard HttpUtils2 library).  
       HttpJob.AddHeader("Content-Type", "application/x-www-form-urlencoded")  
       HttpJob.Post("https://www.b4x.com/print.php?key1=value1", "PostKey1=PostValue2&abc=def")  
     End If  
   Else  
     Log("ErrorMessage: ", Job.ErrorMessage)  
     Log("Status: ", Job.Status)  
     Log(Job.Response)  
   End If  
End Sub
```

  
  
**Usage**  
  
1. Initialize HttpJob and set the job name.  
2. Optionally add headers with HttpJob.AddHeader.  
3. Call Download to send a GET request or Post to send a POST request.  
4. Handle the JobDone event.  
  
**Notes**  
  
1. rHttpUtils2 doesn't support concurrent requests. You need to wait for the JobDone event before you can send another request.  
2. The request data is stored in *requestCache* and the response data is stored in *responseCache*. You can change their sizes if they are not large enough.  
3. SSL certificates are not verified. They are accepted automatically.  
4. WiFiSSLSocket doesn't work with all https sites.  
  
HttpJob module depends on rESP8266WiFi and rRandomAccessFile libraries.  
  
**Updates**  
  
V1.00 - Response timeout timer that closes the connection after the set time (2000ms by default). The timer starts after the first byte is received.  
  
**Library is now included as an internal b4xlib library.**