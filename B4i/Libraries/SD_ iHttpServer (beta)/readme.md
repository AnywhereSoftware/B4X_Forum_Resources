### SD: iHttpServer (beta) by Star-Dust
### 03/29/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/126700/)

I started developing a version of the HttpServer Library for iOs. It is still a beta version and not complete, but already functional. You can start using it to test it. Includes WebSocket and QueryElement implementation  
Digest Auth will be added in the future. I have arrived at a first version of the server that allows Digest authentication.  
**NEW**: I have arrived at a first version of the server that allows Digest authentication. It is not included in the distributed version  
It is entirely written in B4i, it depends on the iNetwork library  
  
[SIZE=6]The library has been updated to be cross-platform and you can find it in[/SIZE][[SIZE=6] **this THREAD**[/SIZE]](https://www.b4x.com/android/forum/threads/b4x-xhttpserver-beta.129190/)  
  
  
**iHttpServer  
  
Author:** Star-Dust  
**Version:** 0.72  

- **QueryElement**

- **Events:**

- **change** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **click** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **dblclick** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **focus** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **focusin** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **focusout** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **keyup** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **mousedown** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **mouseenter** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **mouseleave** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **mousemove** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click
- **mouseup** (Resp As ServletResponse, Params As Map) ' QueryElement Event Click

- **Fields:**

- **Event\_change** As NSString\*
- **Event\_click** As NSString\*
- **Event\_dblclick** As NSString\*
- **Event\_focus** As NSString\*
- **Event\_focusin** As NSString\*
- **Event\_focusout** As NSString\*
- **Event\_keyup** As NSString\*
- **Event\_mousedown** As NSString\*
- **Event\_mouseenter** As NSString\*
- **Event\_mouseleave** As NSString\*
- **Event\_mousemove** As NSString\*
- **Event\_mouseup** As NSString\*
- **NoEvent** As B4IMap\*()

- **Functions:**

- **Class\_Globals** As NSString\*
- **CreateEvent** (ObjectName As NSString\*, Event As NSString\*, OtherEvent As B4IMap\*()) As B4IMap\*()
- **Eval** (Script As NSString\*, Params As B4IList\*) As NSString\*
- **EvalWithResult** (Script As NSString\*, Params As B4IList\*) As NSString\*
- **Initialize** (ba As B4I\*, Response As B4i\_servletresponse\*) As NSString\*
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **RunFunction** (function As NSString\*, ID As NSString\*, Params As B4IList\*) As NSString\*
 *Param = list or array: array as Object is wrong - array as Map is correct*- **RunFunctionWithResult** (function As NSString\*, ID As NSString\*, Params As B4IList\*) As NSString\*
- **RunMethod** (Method As NSString\*, ID As NSString\*, Params As B4IList\*) As NSString\*
 *Param = list or array: array as Object is wrong - array as Map is correct*- **RunMethodWithResult** (Method As NSString\*, ID As NSString\*, Params As B4IList\*) As NSString\*
 *Param = list or array: array as Object is wrong - array as Map is correct*- **SelectElement** (ID As NSString\*) As NSString\*
- **SetCommand** (etype As NSString\*, Method As NSString\*, property As NSString\*, ID As NSString\*, Params As B4IList\*, Arg As B4IList\*) As NSString\*
- **SetCSS** (id As NSString\*, Params As B4IList\*) As NSString\*
- **SetHtml** (id As NSString\*, Params As B4IList\*) As NSString\*
 *Public Sub SetHeight (Value As String)  
 End Sub*- **SetPropriety** (Property As NSString\*, Value As B4IList\*) As NSString\*

- **Properties:**

- **AutomaticEvents**

- **ServletRequest**

- **Fields:**

- **CharacterEncoding** As NSString\*
- **ConnectionAlive** As BOOL
- **ContentLength** As Long long
- **ContentType** As NSString\*
- **ID** As NSString\*
- **LogActive** As BOOL
- **LogFirstRefuse** As BOOL
- **MultipartFilename** As B4IMap\*
- **RequestCookies** As B4IMap\*
- **RequestHeader** As B4IMap\*
- **RequestParameter** As B4IMap\*
- **Timeout** As Long long

- **Functions:**

- **Class\_Globals** As NSString\*
- **Close** As NSString\*
- **Connected** As BOOL
- **GetHeader** (Name As NSString\*) As NSString\*
- **GetHeadersName** As NSObject\*
*can be used to iterate over Header  
Example  
<code>  
For Each Name As String In ServletRequest.GetHeadersName  
Log("Value = " & ServletRequest.GetHeader(Name))  
 Next</code>*- **GetInputStream** As B4IInputStream\*
- **GetMethod** As NSString\*
- **GetRequestHOST** As NSString\*
- **GetRequestURI** As NSString\*
- **GetWebSocketCompressDeflateAccept** As BOOL
- **GetWebSocketCompressGzipAccept** As BOOL
- **GetWebSocketMapData** As B4IMap\*
- **GetWebSocketStringData** As NSString\*
- **Initialize** (ba As B4I\*, CallBack As NSObject\*, EventName As NSString\*, Sck As B4ISocketWrapper\*) As NSString\*
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **ParameterMap** As B4IMap\*
- **RemoteAddress** As NSString\*
- **RemotePort** As Int

- **ServletResponse**

- **Fields:**

- **CharacterEncoding** As NSString\*
- **ContentLenght** As Int
- **ContentType** As NSString\*
- **Status** As Int

- **Functions:**

- **Class\_Globals** As NSString\*
- **Close** As NSString\*
- **Connected** As BOOL
- **Initialize** (ba As B4I\*, Req As B4i\_servletrequest\*, ast As B4IAsyncStreams\*, Sck As B4ISocketWrapper\*) As NSString\*
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **ResetCookies** As NSString\*
- **SendFile** (Dir As NSString\*, fileName As NSString\*) As NSString\*
 *don't use DirAssets*- **SendFile2** (Dir As NSString\*, fileName As NSString\*, Content\_Type As NSString\*) As NSString\*
- **SendNotFound** (filenameNotFound As NSString\*) As NSString\*
- **SendRaw** (Data As Unsigned char()) As NSString\*
- **SendRedirect** (Address As NSString\*) As NSString\*
- **SendString** (Text As NSString\*) As NSString\*
 *sending text with Header*- **SendWebSocketBinary** (Data As Unsigned char(), Masked As BOOL) As NSString\*
- **SendWebSocketClose** As NSString\*
- **SendWebSocketPing** As NSString\*
- **SendWebSocketPong** As NSString\*
- **SendWebSocketString** (Text As NSString\*, Masked As BOOL, Compressed As NSString\*) As NSString\*
*Cmpressed as Deflate=zlib, gzip, none - (set always none)*- **SetCookies** (Name As NSString\*, Value As NSString\*) As NSString\*
 *Set Cokies values on Browser*- **SetHeader** (Name As NSString\*, Value As NSString\*) As NSString\*
- **Write** (Text As NSString\*) As NSString\*
 *Sending text without header to dynamically send more text after the SendString*
- **Properties:**

- **OutputStream** As B4IOutputStream\* [read only]
- **Query** As B4i\_queryelement\* [read only]

- **httpServer**

- **Events:**

- **Handle** (req As ServletRequest, resp As ServletResponse)
- **HandleWebSocket** (req As ServletRequest, resp As ServletResponse)
- **NewConection** (req As ServletRequest)
- **SwitchToWebSocket** (req As ServletRequest, resp As ServletResponse)
- **UploadedFile** (req As ServletRequest, resp As ServletResponse)
- **UploadProgress** (resp As ServletResponse, Progress As Float) ' Progress = 0-1
- **WebSocketClose** (CloseCode As Int, CloseMessage As String)

- **Fields:**

- **DigestAuthentication** As BOOL
- **DigestPath** As NSString\*
- **htdigest** As B4IList\*
- **IgnoreNC** As BOOL
- **realm** As NSString\*
- **Timeout** As Int

- **Functions:**

- **Class\_Globals** As NSString\*
- **GetMyIP** As NSString\*
- **GetMyWifiIp** As NSString\*
- **Initialize** (ba As B4I\*, CallBack As NSObject\*, EventName As NSString\*) As NSString\*
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **Start** (Port As Int)
 *eg. Start(51051)*- **Stop** As NSString\*

  
**Sample**  
![](https://www.b4x.com/android/forum/attachments/109438) ![](https://www.b4x.com/android/forum/attachments/110139)