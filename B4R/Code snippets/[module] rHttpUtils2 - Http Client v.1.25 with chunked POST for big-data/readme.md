### [module] rHttpUtils2 - Http Client v.1.25 with chunked POST for big-data by peacemaker
### 06/26/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/167557/)

Updated [Erel's module](https://www.b4x.com/android/forum/threads/module-rhttputils2-http-client.74785): for big data sending to a server i have added the sending POST request by chunks.  
  
NOTICE: the code was and is based on Arduino's HTTPClient object that … does not support "Transfer-Encoding: chunked" HTTP header ! If to add it by AddHeader method - a server's response is Error 400 (Bad request).  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 2000  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    Delay(2000)  
  
    If wifi.Connect2("yourwifi", "yourpassword") Then  
        Log("Connected to router.")  
    Else  
        Log("Failed to connect to router.")  
        Return  
    End If  
  
    HttpJob.Initialize("ChunkedExample")  
    HttpJob.AddHeader("Content-Type", "application/x-www-form-urlencoded")  
    'HttpJob.AddHeader("Transfer-Encoding", "chunked") 'main trouble - this header is not supported by Arduino HTTPClient !!!  
   
    'Chunk start  
    Dim postData() As Byte = "postbig=ABCDEFGHIJKLMN&param2=value2".GetBytes    'must be x-www-form-urlencoded  
    Dim totalLength As Int = postData.Length  
    Log("totalLength = ", totalLength)  
    HttpJob.PostChunkedStart("https://server.rcom/script.php")  
  
    'Sending a chunk of chunkLength in bytes  
    Dim i As Int = 0  
    Do While i < totalLength  
        Dim available As Int = totalLength - i  
        Log("available = ", available)  
        Dim chunkSize As Int = Min(HttpJob.chunkLength, available)  
        Log("chunkSize = ", chunkSize)  
        For j = 0 To HttpJob.chunkBuffer.Length - 1  
            HttpJob.chunkBuffer(j) = 0  
        Next  
        bc.ArrayCopy2(postData, i, HttpJob.chunkBuffer, 0, chunkSize)  
        HttpJob.PostChunkedSend(HttpJob.chunkBuffer, chunkSize)  
        i = i + chunkSize  
    Loop  
    HttpJob.PostChunkedFinish  
    '———————————–  
   
    'HttpJob.Post("https://server.rcom/script.php", "postbig=ABCDEFGHIJKLMN")    'regular post POST for test  
End Sub  
  
Sub JobDone (Job As JobResult)  
    Log("*******************************")  
    Log("JobName: ", Job.JobName)  
    If Job.Success Then  
        Log("Response: ", bc.SubString2(Job.Response, 0, Min(700, Job.Response.Length)))  
    Else  
        Log("ErrorMessage: ", Job.ErrorMessage)  
        Log("Status: ", Job.Status)  
        Log(Job.Response)  
    End If  
End Sub
```

  
  

```B4X
'version 1.25  
'added chunked POST request  
'© Erel, Peacemakerv  
Sub Process_Globals  
    Private requestCache(500) As Byte  
    Private responseCache(5000) As Byte  
    Private responseIndex As Int  
    Private mJobname(32) As Byte  
    Private mVerb(8) As Byte  
    Private bc As ByteConverter  
    Private ssl As Boolean  
    Private port As Int  
    Private hostIndex, hostLen, pathIndex, pathLen, payloadIndex, payloadLen, headersIndex, headersLen As Int  
    Private astream As AsyncStreams  
    Private socket As WiFiSocket  
    Private sslsocket As WiFiSSLSocket  
    Public EOL() As Byte = Array As Byte(13, 10)  
    Type JobResult (JobName() As Byte, ErrorMessage() As Byte, Success As Boolean, Response() As Byte, Status As Int)  
    Private ResponseTimer As Timer  
    Public ResponseTimeout As UInt = 8000  
   
    Dim raf As RandomAccessFile  
  
    'For chunks  
    Private isChunked As Boolean  
    Public chunkLength As Int = 7    'needed to save, edit for your need  
    Public chunkBuffer(chunkLength) As Byte  
End Sub  
  
Public Sub Initialize(JobName As String)  
    bc.ArrayCopy(JobName, mJobname)  
    headersIndex = 0  
    headersLen = 0  
    ResponseTimer.Initialize("ResponseTimer_Tick", ResponseTimeout)  
End Sub  
  
Private Sub ResponseTimer_Tick  
    Log("Response timeout timer fired.")  
    ParseResult  
End Sub  
  
Public Sub AddHeader(Key() As Byte, Value() As Byte)  
    Dim b() As Byte = JoinBytes(Array(Key, ": ".GetBytes, Value, EOL))  
    bc.ArrayCopy2(b, 0, requestCache, headersIndex + headersLen, b.Length)  
    headersLen = headersLen + b.Length  
End Sub  
  
Public Sub Download (Link() As Byte)  
    ParseLink(Link, Null)  
    bc.ArrayCopy("GET", mVerb)  
    SendRequest(0)  
End Sub  
  
Public Sub Post (Link() As Byte, Payload() As Byte)  
    ParseLink(Link, Payload)  
    bc.ArrayCopy("POST", mVerb)  
    SendRequest(0)  
End Sub  
  
' === SendRequest with chunks support ===  
  
Private Sub SendRequest (unused As Byte)  
    Dim host As String = bc.StringFromBytes(bc.SubString2(requestCache, hostIndex, hostIndex + hostLen))  
    Dim st As Stream = Null  
  
    Log("trying to connect to: ", host, " port: ", port, " ssl: ", ssl)  
  
    If ssl Then  
        sslsocket.Close  
        If sslsocket.ConnectHost(host, port) Then  
            st = sslsocket.Stream  
        End If  
    Else  
        socket.Close  
        If socket.ConnectHost(host, port) Then  
            st = socket.Stream  
        End If  
    End If  
  
    If st = Null Then  
        SetError("Failed to connect")  
        Return  
    End If  
  
    Log("connected: ", host)  
    responseIndex = 0  
    astream.Initialize(st, "Astream_NewData", "Astream_Error")  
  
    astream.Write(mVerb).Write(" ").Write(bc.SubString2(requestCache, pathIndex, pathIndex + pathLen)).Write(" HTTP/1.1").Write(EOL)  
    astream.Write("Host: ").Write(host).Write(EOL)  
    '——–for chunks, manually inserted header ——————–  
    If isChunked Then  
        astream.Write("Transfer-Encoding: chunked").Write(EOL)  
    End If  
    '—————————————  
    astream.Write("Connection: close").Write(EOL)  
   
    If isChunked = False Then  
        Dim payload() As Byte = bc.SubString2(requestCache, payloadIndex, payloadIndex + payloadLen)  
        If payload.Length > 0 Then  
            astream.Write("Content-Length: ").Write(NumberFormat(payload.Length, 0, 0)).Write(EOL)  
        End If  
    End If  
   
    If headersLen > 0 Then  
        astream.Write(bc.SubString2(requestCache, headersIndex, headersIndex + headersLen))  
    End If  
    astream.Write(EOL)  
    If isChunked = False Then  
        If payload.Length > 0 Then  
            astream.Write(payload)  
        End If  
    End If  
End Sub  
  
Private Sub AStream_NewData (Buffer() As Byte)  
    If ResponseTimer.Enabled = False Then ResponseTimer.Enabled = True  
    'Log("AStream_NewData: ", Buffer)  
    If responseIndex + Buffer.Length > responseCache.Length Then  
        Log("ResponseCache is full (", Buffer.Length, ")")  
        Return  
    End If  
    bc.ArrayCopy2(Buffer, 0, responseCache, responseIndex, Buffer.Length)  
    responseIndex = responseIndex + Buffer.Length  
End Sub  
  
Private Sub AStream_Error  
    ParseResult  
End Sub  
  
Private Sub ParseResult  
    ResponseTimer.Enabled = False  
    If responseIndex = 0 Then  
        SetError("Response not available.")  
        Return  
    End If  
  
    Dim response() As Byte = bc.SubString2(responseCache, 0, responseIndex)  
    Dim i As Int = bc.IndexOf(response, EOL)  
    Dim statusLine() As Byte = bc.SubString2(response, 0, i)  
    Dim i1 As Int = bc.IndexOf(statusLine, " ")  
    Dim i2 As Int = bc.IndexOf2(statusLine, " ", i1 + 1)  
    Dim status As Int = bc.StringFromBytes(bc.SubString2(statusLine, i1 + 1, i2))  
    If Floor(status / 100) = 3 Then 'handle redirections  
        i1 = bc.IndexOf(response, "Location:")  
        If i1 > -1 Then  
            i2 = bc.IndexOf2(response, EOL, i1 + 1)  
            Dim NewPath() As Byte = bc.Trim(bc.SubString2(response, i1 + 9, i2))  
            Log("Redirecting to: ", NewPath)  
            ParseLink(NewPath, bc.SubString2(requestCache, payloadIndex, payloadIndex + payloadLen))  
            CallSubPlus("SendRequest", 1, 0)  
            Return  
        End If  
    End If  
  
    Dim jr As JobResult  
    jr.Success = Floor(status / 100) = 2  
    i = bc.IndexOf(response, Array As Byte(13, 10, 13, 10))  
    jr.Response = bc.SubString(response, i + 4)  
    jr.JobName = mJobname  
    jr.ErrorMessage = Array As Byte()  
    jr.Status = status  
    isChunked = False  
    Main.JobDone(jr)  
End Sub  
  
Private Sub ParseLink (Link() As Byte, Payload() As Byte)  
    Dim hostStart As Int  
    If bc.StartsWith(Link, "https://")  Then  
        ssl = True  
        hostStart = 8  
    Else if bc.StartsWith(Link, "http://") Then  
        ssl = False  
        hostStart = 7  
    Else  
        SetError("Invalid link")  
        Return  
    End If  
  
    Dim i As Int = bc.IndexOf2(Link, "/", hostStart)  
    Dim path() As Byte  
    If i = -1 Then  
        i = Link.Length  
        path = "/"  
    End If  
  
    Dim host() As Byte = bc.SubString2(Link, hostStart, i)  
    If i < Link.Length Then path = bc.SubString(Link, i)  
  
    Dim colonStart As Int = bc.IndexOf(host, ":")  
    If colonStart > -1 Then  
        port = bc.StringFromBytes(bc.SubString(host, colonStart + 1))  
        host = bc.SubString2(host, 0, colonStart)  
    Else  
        If ssl Then port = 443 Else port = 80  
    End If  
  
    SetRequestCache(host, path, Payload)  
End Sub  
  
Private Sub SetRequestCache(host() As Byte, path() As Byte, payload() As Byte)  
    If payload = Null Then payload = Array As Byte()  
  
    payloadIndex = headersIndex + headersLen  
    payloadLen = payload.Length  
    bc.ArrayCopy2(payload, 0, requestCache, payloadIndex, payloadLen)  
  
    hostIndex = payloadIndex + payloadLen  
    hostLen = host.Length  
    bc.ArrayCopy2(host, 0, requestCache, hostIndex, hostLen)  
  
    pathIndex = hostIndex + hostLen  
    pathLen = path.Length  
    bc.ArrayCopy2(path, 0, requestCache, pathIndex, pathLen)  
End Sub  
  
Private Sub SetError (msg() As Byte)  
    Dim jr As JobResult  
    jr.JobName = mJobname  
    jr.ErrorMessage = msg  
    jr.Response = Array As Byte()  
    jr.Success = False  
    jr.Status = 0  
    Main.JobDone(jr)  
End Sub  
  
' === New methods for chunked POST ===  
  
Public Sub PostChunkedStart(Link() As Byte)  
    isChunked = True  
    Log("Starting chunk POST…")  
    ParseLink(Link, Null)  
    bc.ArrayCopy("POST", mVerb)  
    SendRequest(0)  
End Sub  
  
Public Sub PostChunkedSend(Buffer() As Byte, Length As Int)  
    If Length <= 0 Then  
        Log("Zero length, exit")  
        Return  
    End If  
  
    chunkLength = Length  
    isChunked = True  
   
    Log("Chunk being sent now: ", Buffer)  
    Dim hexLength() As Byte = ToHexString(chunkLength)  
    astream.Write(hexLength).Write(EOL)  
    astream.Write2(Buffer, 0, Length).Write(EOL)  
    Log("Chunk is sent")  
End Sub  
  
Public Sub PostChunkedFinish  
    Log("Chunks are finished")  
    chunkLength = 0  
    astream.Write("0".GetBytes).Write(EOL).Write(EOL)  
    isChunked = False  
    Log("Chunk posting is finished")  
End Sub  
  
'hex number  
Sub ToHexString(value As Int) As Byte()  
    Dim b(2) As Byte  
    raf.Initialize(b, False) 'big endian  
    raf.WriteInt16(value, 0)  
    Dim res() As Byte = bc.HexFromBytes(b)  
    Log("Hex chunk length = ", res)  
    Return res  
End Sub
```

  
  
> Writing at 0x0010dc64… (100 %)  
> Wrote 1049056 bytes (644586 compressed) at 0x00010000 in 7.6 seconds (effective 1097.5 kbit/s)…  
> Hash of data verified.  
> Leaving…  
> Hard resetting with RTC WDT…  
> New upload port: COM13 (serial)  
> Connected to router.  
> totalLength = 36  
> Starting chunk POST…  
> trying to connect to: pmaker.ru port: 443 ssl: 1  
> connected: pmaker.ru  
> available = 36  
> chunkSize = 7  
> Chunk being sent now: postbig  
> Hex chunk length = 0007  
> Chunk is sent  
> available = 29  
> chunkSize = 7  
> Chunk being sent now: =ABCDEF  
> Hex chunk length = 0007  
> Chunk is sent  
> available = 22  
> chunkSize = 7  
> Chunk being sent now: GHIJKLM  
> Hex chunk length = 0007  
> Chunk is sent  
> available = 15  
> chunkSize = 7  
> Chunk being sent now: N&param  
> Hex chunk length = 0007  
> Chunk is sent  
> available = 8  
> chunkSize = 7  
> Chunk being sent now: 2=value  
> Hex chunk length = 0007  
> Chunk is sent  
> available = 1  
> chunkSize = 1  
> Chunk being sent now: 2  
> Hex chunk length = 0001  
> Chunk is sent  
> Chunks are finished  
> Chunk posting is finished  
> \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
> JobName: ChunkedExample  
> Response: Firstly $\_SERVER['HTTP\_TRANSFER\_ENCODING']:  
> $\_POST:  
> Array  
> (  
>  [postbig] => ABCDEFGHIJKLMN  
>  [param2] => value2  
> )  
>   
> 'php://input':  
> postbig=ABCDEFGHIJKLMN&param2=value2

  
It's useful if MCU is generating big result data and RAM memory is not enough to save all the amount.  
Now the big result can be sent to a server line by line during result generation.  
  
  

```B4X
<?php  
echo("Firstly \$_SERVER['HTTP_TRANSFER_ENCODING']:\r\n");  
print_r($_SERVER['HTTP_TRANSFER_ENCODING']);  
echo("\r\n\r\n");  
  
echo("\$_POST:\r\n");  
print_r($_POST);  
echo("\r\n\r\n");  
  
$data = file_get_contents('php://input');  
echo("'php://input':\r\n");  
echo("\r\n\r\n");  
print_r($data);  
?>
```