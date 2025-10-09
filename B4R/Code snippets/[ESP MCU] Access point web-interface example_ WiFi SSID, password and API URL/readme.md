### [ESP MCU] Access point web-interface example: WiFi SSID, password and API URL by peacemaker
### 10/05/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168926/)

Just a pure-HTML web-interface example (for not to forget). If to call WebServer.Start - the AP will be started and you have to connect to it and open <http://192.168.4.1> standard IP address of ESP-family MCU by a web-browser.  
  

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private bc As ByteConverter  
    Private aSync As AsyncStreams  
    Private server As WiFiServerSocket  
    Private DoubleCRLF(4) As Byte = Array As Byte(13, 10, 13, 10)  
    Private currentBuffer(1700) As Byte    'setup for your web-form  
    Private bufferIndex As Int ' Use index instead of lock  
End Sub  
  
Sub Start  
    Main.Wifi.Disconnect  
    Log("Starting AP: ", others.APname, "; result = ", Main.WiFi.StartAccessPoint(others.APname))  
    Log("My IP: ", Main.WiFi.AccessPointIp)  
    server.Initialize(80, "server_NewConnection")  
    server.Listen  
  
    ClearBuffer  
End Sub  
  
Private Sub server_NewConnection (NewSocket As WiFiSocket)  
    Log("Socket connected")  
  
    ' Reset buffer for new connection  
    ClearBuffer  
  
    aSync.Initialize(NewSocket.Stream, "aSync_NewData", "aSync_Error")  
End Sub  
  
Private Sub aSync_NewData (Buffer() As Byte)  
    'Log("Received data chunk, length: ", Buffer.Length)  
   
    ' Append new data to current buffer (like in HttpJob)  
    If bufferIndex + Buffer.Length > currentBuffer.Length Then  
        Log("Buffer is full (", Buffer.Length, ")")  
        SendErrorResponse("Request too large")  
        Return  
    End If  
   
    bc.ArrayCopy2(Buffer, 0, currentBuffer, bufferIndex, Buffer.Length)  
    bufferIndex = bufferIndex + Buffer.Length  
   
    'Log("Total buffer size: ", bufferIndex)  
   
    ' Check if we have received a complete request  
    If IsCompleteRequest Then  
        Log("Complete request received, processing…")  
        ProcessCompleteRequest  
        ClearBuffer  
    Else  
        Log("Incomplete request, waiting for more data…")  
    End If  
End Sub  
  
Private Sub IsCompleteRequest As Boolean  
    If bufferIndex < 4 Then Return False  
   
    ' For GET requests, look for double CRLF  
    If bc.IndexOf2(currentBuffer, "GET", 0) <> -1 Then  
        Return bc.IndexOf2(currentBuffer, DoubleCRLF, 0) <> -1  
    End If  
   
    ' For POST requests, check Content-Length  
    If bc.IndexOf2(currentBuffer, "POST", 0) <> -1 Then  
        Dim headersEnd As Int = bc.IndexOf2(currentBuffer, DoubleCRLF, 0)  
        If headersEnd = -1 Then Return False  
        headersEnd = headersEnd + 4  
    
        ' Content-Length  
        Dim contentLength As Int = 0  
        Dim clHeader() As Byte = "Content-Length: ".GetBytes  
        Dim clIndex As Int = bc.IndexOf2(currentBuffer, clHeader, 0)  
        If clIndex <> -1 Then  
            Dim clLineEnd As Int = bc.IndexOf2(currentBuffer, CRLF, clIndex)  
            If clLineEnd <> -1 Then  
                Dim clValueBytes() As Byte = bc.SubString2(currentBuffer, clIndex + clHeader.Length, clLineEnd)  
                Dim clValueStr As String = bc.StringFromBytes(bc.Trim(clValueBytes))  
                contentLength = clValueStr  
            End If  
        End If  
    
        Dim totalLength As Int = headersEnd + contentLength  
        Log("Headers end: ", headersEnd, ", Content-Length: ", contentLength, ", Expected: ", totalLength)  
    
        Return bufferIndex >= totalLength  
    End If  
   
    Return False  
End Sub  
  
Private Sub ProcessCompleteRequest  
    Log("Processing complete request, total length: ", bufferIndex)  
   
    If bc.IndexOf2(currentBuffer, "GET", 0) <> -1 Then  
        If bc.IndexOf2(currentBuffer, "GET / ", 0) <> -1 Or bc.IndexOf2(currentBuffer, "GET /config", 0) <> -1 Then  
            SendHTMLForm  
        Else  
            aSync.Write("HTTP/1.1 404 Not Found").Write(CRLF).Write(CRLF)  
            aSync.Write("Page not found")  
        End If  
        CallSubPlus("CloseConnection", 100, 0)  
    Else If bc.IndexOf2(currentBuffer, "POST", 0) <> -1 Then  
        ProcessFormData  
        CallSubPlus("CloseConnection", 100, 0)  
    End If  
End Sub  
  
Private Sub SendHTMLForm  
    aSync.Write("HTTP/1.1 200 OK").Write(CRLF)  
    aSync.Write("Content-Type: text/html").Write(CRLF).Write(CRLF)  
   
    aSync.Write("<!DOCTYPE html>")  
    aSync.Write("<html><head>")  
    aSync.Write("<title>WiFi Configuration</title>")  
    aSync.Write("<meta charset='UTF-8'>")  
    aSync.Write("<style>")  
    aSync.Write("body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }")  
    aSync.Write(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); max-width: 500px; margin: 0 auto; }")  
    aSync.Write("h1 { color: #333; text-align: center; }")  
    aSync.Write(".form-group { margin-bottom: 20px; }")  
    aSync.Write("label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }")  
    aSync.Write("input[type='text'], input[type='password'] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }")  
    aSync.Write("input[type='submit'] { background: #007bff; color: white; padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; width: 100%; }")  
    aSync.Write("input[type='submit']:hover { background: #0056b3; }")  
    aSync.Write("</style>")  
    aSync.Write("</head><body>")  
   
    aSync.Write("<div class='container'>")  
    aSync.Write("<h1>WiFi Configuration</h1>")  
    aSync.Write(JoinStrings(Array As String("<h3>MCU MAC: ", Main.bc.HexFromBytes(others.MacArray), "</h3>")))  
    aSync.Write("<form method='POST' action='/save'>")  
   
    aSync.Write("<div class='form-group'>")  
    aSync.Write("<label for='ssid'>WiFi SSID <span style='color: red'>*</span>:</label>")  
    aSync.Write("<input type='text' id='ssid' name='ssid' placeholder='Enter WiFi network name' required maxlength='25'>")  
    aSync.Write("</div>")  
   
    aSync.Write("<div class='form-group'>")  
    aSync.Write("<label for='password'>WiFi Password:</label>")  
    aSync.Write("<input type='password' id='password' name='password' placeholder='Enter WiFi password' maxlength='25'>")  
    aSync.Write("</div>")  
   
    aSync.Write("<div class='form-group'>")  
    aSync.Write("<label for='api_url'>API URL <span style='color: red'>*</span>:</label>")  
    aSync.Write("<input type='text' id='api_url' name='api_url' placeholder='https://api.example.com/endpoint  ' required maxlength='150'>")  
    aSync.Write("</div>")  
   
    aSync.Write("<input type='submit' value='Save'>")  
    aSync.Write("</form>")  
    aSync.Write("</div>")  
   
    aSync.Write("</body></html>")  
End Sub  
  
Private Sub ProcessFormData  
    Log("=== DEBUG: ProcessFormData started ===")  
   
    Dim headersEnd As Int = bc.IndexOf2(currentBuffer, DoubleCRLF, 0)  
    Log("DEBUG: headersEnd position: ", headersEnd)  
   
    If headersEnd = -1 Then  
        Log("DEBUG: ERROR - No double CRLF found")  
        SendErrorResponse("No form data received")  
        Return  
    End If  
   
    headersEnd = headersEnd + 4  
    Log("DEBUG: headersEnd after adding 4: ", headersEnd)  
   
    If headersEnd >= bufferIndex Then  
        Log("DEBUG: ERROR - headersEnd >= bufferIndex")  
        SendErrorResponse("No form data after headers")  
        Return  
    End If  
   
    If headersEnd >= currentBuffer.Length Then  
        Log("DEBUG: ERROR - headersEnd >= currentBuffer.Length")  
        SendErrorResponse("Buffer overflow")  
        Return  
    End If  
   
    Dim postData() As Byte = bc.SubString2(currentBuffer, headersEnd, bufferIndex)  
    Log("DEBUG: postData length: ", postData.Length)  
   
    Dim postDataString As String = bc.StringFromBytes(postData)  
    Log("DEBUG: Raw POST data string: ", postDataString)  
   
    Log("DEBUG: Starting parameter extraction…")  
    Dim ssid(), password(), api_url() As Byte  
    ssid = ExtractParameterBytes(postData, "ssid=")  
    Log("DEBUG: SSID extracted, length: ", ssid.Length)  
   
    password = ExtractParameterBytes(postData, "password=")  
    Log("DEBUG: Password extracted, length: ", password.Length)  
   
    api_url = ExtractParameterBytes(postData, "api_url=")  
    Log("DEBUG: API URL extracted, length: ", api_url.Length)  
   
    If ssid.Length = 0 Or api_url.Length = 0 Then  
        Log("DEBUG: ERROR - SSID or API URL is empty")  
        SendErrorResponse("SSID and API URL are required")  
        Return  
    End If  
   
    Log("DEBUG: Saving to GlobalStore…")  
    GlobalStore.Put(0, ssid)  
    GlobalStore.Put(1, password)  
    GlobalStore.Put(2, api_url)  
   
    Log("DEBUG: Calling SaveSettings…")  
    others.SaveSettings  
   
    Log("DEBUG: Sending success response…")  
    SendSuccessResponse(ssid, api_url)  
   
    Log("DEBUG: Preparing for restart…")  
    others.restart(2)  
End Sub  
  
Private Sub ExtractParameterBytes(Data() As Byte, paramName() As Byte) As Byte()  
    Log("DEBUG: ExtractParameterBytes started, paramName: ", bc.StringFromBytes(paramName))  
    Log("DEBUG: Data length: ", Data.Length)  
   
    Dim startIndex As Int = bc.IndexOf(Data, paramName)  
    Log("DEBUG: startIndex after bc.IndexOf: ", startIndex)  
   
    If startIndex = -1 Then  
        Log("DEBUG: Parameter not found: ", bc.StringFromBytes(paramName))  
        Return Array As Byte()  
    End If  
   
    startIndex = startIndex + paramName.Length  
    Log("DEBUG: startIndex after adding paramName length: ", startIndex)  
   
    If startIndex >= Data.Length Then  
        Log("DEBUG: ERROR - startIndex exceeds data length")  
        Return Array As Byte()  
    End If  
   
    Dim endIndex As Int = bc.IndexOf2(Data, "&", startIndex)  
    Log("DEBUG: endIndex after bc.IndexOf2: ", endIndex)  
   
    If endIndex = -1 Then  
        endIndex = Data.Length  
        Log("DEBUG: No & found, setting endIndex to data length: ", endIndex)  
    End If  
   
    If endIndex > Data.Length Then  
        endIndex = Data.Length  
        Log("DEBUG: endIndex adjusted to data length: ", endIndex)  
    End If  
   
    Log("DEBUG: Final indices - start: ", startIndex, ", end: ", endIndex)  
   
    If endIndex > startIndex Then  
        Log("DEBUG: Extracting substring…")  
        Dim result() As Byte = bc.SubString2(Data, startIndex, endIndex)  
        Log("DEBUG: Result length after substring: ", result.Length)  
    
        If result.Length = 0 Then  
            Log("DEBUG: Empty result after substring")  
            Return Array As Byte()  
        End If  
    
        Log("DEBUG: Before URL decode, result: ", bc.StringFromBytes(result))  
    
        Dim decoded() As Byte  
        Dim success As Boolean = URL.SafeURLDecode(result, decoded)  
        If success And decoded.Length > 0 Then  
            Log("DEBUG: After URL decode, decoded length: ", decoded.Length)  
            Log("DEBUG: Decoded content: ", bc.StringFromBytes(decoded))  
            Return decoded  
        Else  
            Log("DEBUG: URL decode failed or empty, returning original data")  
            Return result  
        End If  
    Else  
        Log("DEBUG: Invalid indices - endIndex <= startIndex")  
        Return Array As Byte()  
    End If  
End Sub  
  
Private Sub SendSuccessResponse(ssid() As Byte, api_url() As Byte)  
    aSync.Write("HTTP/1.1 200 OK").Write(CRLF)  
    aSync.Write("Content-Type: text/html").Write(CRLF).Write(CRLF)  
    aSync.Write("<html><body>")  
    aSync.Write("<h2>Settings saved</h2>")  
    aSync.Write("<p>SSID: ").Write(bc.StringFromBytes(ssid)).Write("</p>")  
    aSync.Write("<p>API URL: ").Write(bc.StringFromBytes(api_url)).Write("</p>")  
    aSync.Write("<p>Device will restart…</p>")  
    aSync.Write("</body></html>")  
End Sub  
  
Private Sub SendErrorResponse(message As String)  
    aSync.Write("HTTP/1.1 400 Bad Request").Write(CRLF)  
    aSync.Write("Content-Type: text/html").Write(CRLF).Write(CRLF)  
    aSync.Write("<html><body>")  
    aSync.Write("<h2>Error</h2>")  
    aSync.Write("<p>").Write(message).Write("</p>")  
    aSync.Write("</body></html>")  
End Sub  
  
Private Sub CloseConnection(u As Byte)  
    Log("Close AP connection")  
    If server.Socket.Connected Then  
        server.Socket.Stream.Flush  
        server.Socket.Close  
    End If  
    ClearBuffer  
End Sub  
  
Private Sub aSync_Error  
    Log("Async stream error")  
    ClearBuffer  
    server.Listen  
End Sub  
  
Sub ClearBuffer  
    bufferIndex = 0  
    ' Clear buffer by setting all bytes to 0  
    For i = 0 To currentBuffer.Length - 1  
        currentBuffer(i) = 0  
    Next  
End Sub
```

  
  
Dependings:  
  

1. GlobalStore: <https://www.b4x.com/android/forum/threads/module-globalstore-global-objects-storage.73863/>
2. The entered fields can be saved from GlobalStore to a FLASH memory by [such code](https://www.b4x.com/android/forum/threads/rarduinonvs-nvs-library-for-esp32.149307/post-1035305).
3. URL.SafeURLDecode: here <https://www.b4x.com/android/forum/threads/rurl-urlencode-and-urldecode.134410/post-1035351>

  
p.s. BTW, how better to update ClearBuffer sub for zeroing the process\_global public buffer ?  
p.s.2 there are many DEBUG logging due to it was hard to fix errors during web-form code debug.  
  
![](https://www.b4x.com/android/forum/attachments/167590)![](https://www.b4x.com/android/forum/attachments/167591)