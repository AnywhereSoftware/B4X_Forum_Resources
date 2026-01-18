###  xHttpServer (Http Server + jQuery) by Star-Dust
### 01/12/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/129190/)

It is a personal project of mine that I started as a hobby on B4i and it has become an interesting project, so that I have modified it to be multiplatform.  
  
It is an http server, which allows a browser to navigate on html pages stored on the device. In addition, dynamic pages can also be created. Read the parameters of the GET and POST commands and read and write the COOKIES in the browser.  
It also implements the WebSocket, starting from an example published in this forum by [USER=1]@Erel[/USER] for the jServer library. I also made the jQueryElement class to interface with the JavaScript elements of the Browser page.  
(You can get the source of the [**QueryElement**](https://www.b4x.com/android/forum/threads/httpserver-and-b4x.126674/post-829378) class at this Post)  
  
Obviously it is not at the level of existing and established servers, but it is a project that I want to share and that I think can be useful since it is cross-platform. The examples are in post 2  
  
It is entirely written in B4X.   
It may have some bugs  
It does not support SSL / TLS. I didn't understand how it works.  
  
**aHttpServer  
  
Author:** Star-Dust  
**Version:** 0.80  

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

- **Event\_change** As String
- **Event\_click** As String
- **Event\_dblclick** As String
- **Event\_focus** As String
- **Event\_focusin** As String
- **Event\_focusout** As String
- **Event\_keyup** As String
- **Event\_mousedown** As String
- **Event\_mouseenter** As String
- **Event\_mouseleave** As String
- **Event\_mousemove** As String
- **Event\_mouseup** As String
- **NoEvent** As Map()

- **Functions:**

- **Class\_Globals** As String
- **CreateEvent** (ObjectName As String, Event As String, OtherEvent As Map()) As Map()
- **EscapeHtml** (Raw As String) As String
- **Eval** (Script As String, Params As List) As String
- **EvalWithResult** (Script As String, Params As List) As String
- **GetPropriety** (Property As String, Value As List) As String
- **GetVal** (ID As String, ValueList As List) As String
- **Initialize** (Response As ServletResponse) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RunFunction** (function As String, ID As String, Params As List) As String
 *Param = list or array: array as Map or String (array as Object is wrong)*- **RunFunctionWithResult** (function As String, ID As String, Params As List) As String
- **RunMethod** (Method As String, ID As String, Params As List) As String
 *Param = list or array: array as Object is wrong - array as Map is correct*- **RunMethodWithResult** (Method As String, ID As String, Params As List) As String
 *Param = list or array: array as Object is wrong - array as Map is correct*- **SelectElement** (ID As String) As String
- **SetCommand** (etype As String, Method As String, property As String, ID As String, Params As List, Arg As List) As String
- **SetCSS** (id As String, Params As List) As String
- **SetDialog** (id As String, Params As List) As String
*Public Sub GetWidth As Object  
 End Sub*- **SetHtml** (id As String, Params As List) As String
 *Public Sub SetHeight (Value As String)  
 End Sub*- **SetPropriety** (Property As String, Value As List) As String
- **SetText** (ID As String, TextList As List) As String
- **SetVal** (ID As String, ValueList As List) As String

- **Properties:**

- **AutomaticEvents**

- **ServletRequest**

- **Fields:**

- **CharacterEncoding** As String
- **ConnectionAlive** As Boolean
- **ContentLength** As Long
- **ContentType** As String
- **ID** As String
- **LogActive** As Boolean
- **LogFirstRefuse** As Boolean
- **MultipartFilename** As Map
- **RequestCookies** As Map
- **RequestHeader** As Map
- **RequestParameter** As Map
- **RequestPostDataRow** As List
- **Timeout** As Long

- **Functions:**

- **ArrayInsert** (DataSource As Byte(), Index As Int, DataInsert As Byte()) As Byte()
- **ArrayRemove** (Data As Byte(), Start As Int, Last As Int) As Byte()
- **Class\_Globals** As String
- **Close** As String
- **Connected** As Boolean
- **GetHeader** (Name As String) As String
- **GetHeadersName** As List
*can be used to iterate over Header  
 Example  
 <code>  
 For Each Name As String In ServletRequest.GetHeadersName  
 Log("Value = " & ServletRequest.GetHeader(Name))  
 Next</code>*- **GetInputStream** As InputStream
- **GetMethod** As String
- **GetRequestHOST** As String
- **GetRequestURI** As String
- **GetWebSocketCompressDeflateAccept** As Boolean
- **GetWebSocketCompressGzipAccept** As Boolean
- **GetWebSocketMapData** As Map
- **GetWebSocketStringData** As String
- **Initialize** (CallBack As Object, EventName As String, Sck As Socket) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **ParameterMap** As Map
- **RemoteAddress** As String
- **RemotePort** As Int
- **SubArray2** (Data As Byte(), Start As Int, Last As Int) As Byte()

- **ServletResponse**

- **Fields:**

- **CharacterEncoding** As String
- **ContentLenght** As Int
- **ContentType** As String
- **Status** As Int

- **Functions:**

- **Class\_Globals** As String
- **Close** As String
- **Connected** As Boolean
- **Initialize** (Req As ServletRequest, ast As AsyncStreams, Sck As Socket) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **ResetCookies** As String
- **SendFile** (Dir As String, fileName As String) As String
 *don't use DirAssets*- **SendFile2** (Dir As String, fileName As String, Content\_Type As String) As String
- **SendNotFound** (filenameNotFound As String) As String
- **SendRaw** (Data As Byte()) As String
- **SendRedirect** (Address As String) As String
- **SendString** (Text As String) As String
 *sending text with Header*- **SendWebSocketBinary** (Data As Byte(), Masked As Boolean) As String
- **SendWebSocketClose** As String
- **SendWebSocketPing** As String
- **SendWebSocketPong** As String
- **SendWebSocketString** (Text As String, Masked As Boolean, Compressed As String) As String
*Cmpressed as Deflate=zlib, gzip, none - (set always none)*- **SetCookies** (Name As String, Value As String) As String
 *Set Cokies values on Browser*- **SetHeader** (Name As String, Value As String) As String
- **Write** (Text As String) As String
 *Sending text without header to dynamically send more text after the SendString*
- **Properties:**

- **OutputStream** As OutputStream [read only]
- **Query** As QueryElement [read only]

- **httpServer**

- **Events:**

- **Handle** (req As ServletRequest, resp As ServletResponse)
- **HandleWebSocket** (req As ServletRequest, resp As ServletResponse)
- **NewConection** (req As ServletRequest)
- **SwitchToWebSocket** (req As ServletRequest, resp As ServletResponse)
- **UploadedFile** (req As ServletRequest, resp As ServletResponse)
- **WebSocketClose** (CloseCode As Int, CloseMessage As String)

- **Fields:**

- **CharacterEncoding** As String
- **DigestAuthentication** As Boolean
- **DigestPath** As String
- **htdigest** As List
- **IgnoreNC** As Boolean
- **realm** As String
- **Timeout** As Int

- **Functions:**

- **Class\_Globals** As String
- **GetMyIP** As String
- **GetMyWifiIp** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Start** (Port As Int)
 *eg. Start(51051)*- **Stop** As String

- **Properties:**

- **TempPath** As String [read only]