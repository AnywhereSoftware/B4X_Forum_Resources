### [BANano+jSERVER=BANanoServer] Going full circle by alwaysbusy
### 10/27/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/111406/)

**INTRODUCTION**  
  
B4J has an excellent jetty based server: the jServer library. BANanoServer uses this lib and provides you with a lot of goodies to make building WebApps with B4J very simple.  
  
**NOTE**: This library is in the full BANano library zip file.  
  
**NOTE**: You can still use BANano without the BANanoServer Library as it did before in case you want to use another backend like PHP, but only having to program in one language has huge advantages and is what RAD is al about. :)  
  
When you will look at the code of BANanoServer, ABM users will recognize the powerful Caching system, Root and http2 filters. In BANano, all that code is removed from your own projects *view* (but still accessible as it is an open source .b4xlib).  
  
Some 'easy-to-use' methods to communicate between the browser and the server are added. (to call methods from each other and to exchange files).  
  
**EDIT:** in te zip with the library is a Template.bjl file to use in a BANanoServer object. Note that a B4J jServer project (where BANanoServer is based on) **must be a Non-UI project!** So you can normally not use the abstract Designer. But with a 'hack', if you cpy a bjl file in an Non-UI project, you can use the Abstract Desgner by clicking on the 'open designer' link in the files panel.  
![](https://www.b4x.com/android/forum/attachments/88070)  
  
Unfortunately, in the abstract designer, you can not use the Tools - Generate Members (it gives an error). You can however still use the individual Generate you get by right-clicking on a control:  
  
![](https://www.b4x.com/android/forum/attachments/88071)  
  
**EDIT 2:** It looks like one can get around that second remark (Tools - Generate Members b y adding the jFX library to the project. Just don't use it and(you should see the remark "Library 'jFX' is not used. (warning #32)". I've looked into the jars and the generated code appears to be the same (correct [USER=1]@Erel[/USER]?), just some extra (not used) classes are added to the fat jar.  
  
A BANano+BANanoServer WebApp basically exists of the following components:  
  
> **SERVERpage**: the server side of a web page that can run ALL of the B4J code and B4J libraries  
> **BROWSERPage**: the browser side of a the web page that can run 99% of all the B4J code and BANano Libraries (no B4J libraries).  
> **SHAREDCode**: code that can contain both B4J and BANano code. Useful e.g. to write just one class that both sides need to use. It will be compiled to Java AND to JavaScript (by BANano).

  
And here is how the communication works. You will see the similarity I tried to archive between the SERVERPage and BROWSERPage classes to make it very easy for even a novice programmer.  
  
**Main** (Setting up de server and BANano):  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
   #CommandLineArgs:  
   #MergeLibraries: True  
   #IgnoreWarnings: 16, 10, 14, 15  
#End Region  
  
Sub Process_Globals  
   ' must be public in Main because everyone has to use this one.  
   Public Server As BANanoServer  
End Sub  
  
Sub AppStart (Args() As String)  
   ' initialize the BANano Server  
   Server.Initialize  
   ' for our caching  
   Server.SessionMaxInactiveIntervalSeconds = 60  
   Server.CacheScavengePeriodSeconds = 30  
   ' for our upload  
   Server.UploadAllowedFileTypes = "ZIP;JPG"  
   Server.UploadMaxSize = 1024*1024*5 ' 5 MB  
   ' Other important ones  
   ' the prefix of our BROWSER (BANano only code) classes that miror their SERVER counterpart (default is "BROWSER")  
   Server.BROWSERPrefix = "BROWSER" ' IMPORTANT to set this one if you do not use this default Prefix!  
     
   ' initialize BANano  
   Server.BANano.Initialize("BANano", "BANanoServer" ,1)  
   Server.BANano.TranspilerOptions.SetStaticFolder("www")  
   ' some B4J typical libs we want to be ignored by the Transpiler  
   Server.BANano.TranspilerOptions.IgnoreB4JLibrary("Json")  
  
   ' transpile all the BANano b4J code to javascript  
   Server.BANano.BuildForServer(Server.OutputFolder)  
  
   ' add your SERVER classes, not the BROWSER parts:  
   Server.AddWebSocket("/ws/" & Server.BANano.StaticFolder & "/about" , "SERVERAbout")  
  
   ' set the start page one will go to if they enter the site by the root  
   Server.StartPage = "about"  
  
   ' lets start the B4J server  
   If Server.PortSSL <> 0 Then  
       Server.StartServerHTTP2("keystore.jks", "SSLKeyStorePassword", "SSLKeyManagerPassword")  
   Else  
       Server.StartServer  
   End If  
   StartMessageLoop  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
   Return True  
End Sub
```

  
  
**SERVERAbout** (a SERVERPage that talks with its BROWSERPage counterpart):  

```B4X
' B4J compatible ONLY code, no BANano allowed.  
'WebSocket class  
Sub Class_Globals  
   Private ws As WebSocket  
   Private CacheReport As BANanoCacheReport  
   ' a class used by both the SERVER and the BROWSER  
   Private Human As SHAREDHuman  
End Sub  
  
Public Sub Initialize  
   Human.Initialize  
End Sub  
  
Private Sub WebSocket_Connected (WebSocket1 As WebSocket)  
   Log("Connected")  
  
   ws = WebSocket1  
  
   ' Lets update the cache with this class  
   CacheReport = Main.Server.UpdateFromCache(Me, ws)  
   Log("PageID: " & CacheReport.BANPageID)  
   Log("Comes From Cache:" & CacheReport.ComesFromCache)  
   Log("Is a reconnecting socket: " & CacheReport.IsReconnected)  
  
   ' We can already send stuff to the browser, using normal B4J jServer code with Future  
   Dim fut As Future = ws.RunFunctionWithResult("AddInTheBrowser", Array(20, 30))  
   ws.Flush  
   Log("BROWSER says sum of 20+30=" & fut.Value)  
  
   ' or if no result is expected back  
   ws.RunFunction("BROWSERTest", Array("Hello from the SERVER!"))  
   ws.Flush  
  
   ' IMPORTANT lets tell the browser we are ready to receive call from the browser  
   ' Uses the classic WebSocket_Connected and WebSocket_DisConnected events on the browser size  
   ' Use Main.Server.SendReady(ws, "ws") if you use the advanced events OnOpen, OnMessage, OnServerReady, …  
   Main.server.SendConnected(ws)  
End Sub  
  
Private Sub WebSocket_Disconnected  
   Log("disconnected")  
End Sub  
' event raised to distribute incoming events coming from the BROWSER  
public Sub BANano_ParseEvent(params As Map)  
   Main.Server.ParseEvent(Me, ws, CacheReport.BANPageID, params)  
End Sub  
' event raised when a file has been uploaded  
public Sub BANano_Uploaded(status As Int, fileName As String)  
   Log(fileName & " = " & status)  
   Select Case status  
       Case 200 ' OK  
       Case 500 ' was not a POST call  
       Case 501 ' file to big  
       Case 502 ' file type not allowed  
   End Select  
End Sub  
  
' called from the BROWSER  
public Sub AddOnTheServer(first As Int, second As Int) As Int  
   Return first + second  
End Sub  
  
' called from the BROWSER  
public Sub SERVERTest(msg As String)  
   Log("BROWSER says '" & msg & "'")  
End Sub  
  
' called from the BROWSER  
public Sub GetHuman() As String  
   ' make a human that the browser can retrieve  
   Human.Name = "Alain"  
   Human.Gender = "Male"  
   Return Human.ToJSON  
End Sub  
  
' called from the BROWSER  
public Sub SetHuman(HumanStr As String)  
   Human.FromJson(HumanStr)  
   Log("Human.Name (changed in the browser) is " & Human.Name)  
End Sub
```

  
  
**BROWSERAbout** (a BROWSERPage that talks with its SERVERPage counterpart):  

```B4X
'BANano compatible ONLY code. You can not use typical B4J libraries here.  Use their BANano version (if it exists)  
'Making changes in a this module/class in B4J debug mode will NOT have any effect until recompiled!  
#Region BANano  
   ' <————– IMPORTANT! This is because we want this module to be transpiled by BANano  
#End Region  
  
Sub Class_Globals  
   Private BANano As BANano 'ignore  
   Private ws As BANanoWebSocket  
   ' a class used by both the SERVER and the BROWSER  
   Private Human As SHAREDHuman  
   ' BANano Custom View objects that are on the UploadForm layout  
   Private SKButton1 As SKButton 'ignore  
   Private SKTextBox1 As SKTextBox 'ignore  
   Private SKLabel1 As SKLabel 'ignore  
End Sub  
  
'Initializes the object. You can NOT add extra parameters!  
Public Sub Initialize  
   ' does the browser support websockets?  
   If ws.IsSupported Then  
       ' here we connect to our SERVERAbout websocket class using the 'classic' B4J Websocket events WebSocket_Connected and WebSocket_Disconnected  
       ws.Initialize("ws://" & BANano.Location.GetHost & "/ws/" & BANano.StaticFolder & "/about")  
   End If  
   Human.Initialize  
End Sub  
  
' Server says socket is ready  
Sub WebSocket_Connected()  
   Log("Connected")  
   Log("My B4J PageId: " & BANano.GetPageID)  
   ' load de layoout for the upload  
   BANano.LoadLayout("#body", "UploadForm")  
  
   ' running a method on the server and wait for the result  
   Dim value As Int = 0  
   Dim prom As BANanoPromise = ws.RunFunctionWithResult("AddOnTheServer", Array(3 , 6))  
   prom.Then(value)  
       Log("SERVER says sum of 3+6=" & value)  
   prom.end  
  
   ' getting the human class from the server  
   Dim humanJson As String  
   Dim promHuman As BANanoPromise = ws.RunFunctionWithResult("GetHuman", Null)  
   promHuman.Then(humanJson)  
       Human.FromJson(humanJson)  
       ' making a change to the object  
       Human.Name = "Alain Bailleul"  
       ' and sending it back  
       ws.RunFunction("SetHuman", Array(Human.ToJSON))  
       Log("Hello Human " & Human.Name & " (" & Human.Gender & ")")  
   promHuman.end  
  
   ' note that this will be logged BEFORE the sum and the Human retrieval.  If you want it AFTER then it has to be put inside the Promise  
   ws.RunFunction("SERVERTest", Array("Hello from the BROWSER!"))  
  
   ' get some assets from the server/internet  
   Dim Files As List = Array("./assets/B4X.jpg", "https://jsonplaceholder.typicode.com/posts", "./assets/UTF8.txt")  
   Dim responses() As String  
   Dim dataUrlProm As BANanoPromise = BANano.GetFileAsDataURL(Files.Get(0), Null)  
   Dim jsonObjProm As BANanoPromise = BANano.GetFileAsJSON(Files.Get(1), Null)  
   Dim textProm As BANanoPromise = BANano.GetFileAsText(Files.Get(2), Null, "UTF-8")  
   ' return when all 3 promises are done  
   Dim prom As BANanoPromise = BANano.PromiseAll(Array(dataUrlProm, jsonObjProm, textProm))  
   prom.Then(responses)  
       For i = 0 To responses.Length - 1  
           Log(Files.Get(i) & ":")  
           Log(responses(i))  
       Next  
   prom.end  
End Sub  
  
Sub WebSocket_Disconnected(event As BANanoEvent)  
   Log("Websocket closed")  
End Sub  
  
' called from the SERVER  
public Sub AddInTheBrowser(first As Int, second As Int) As Int  
   Return first + second  
End Sub  
  
' called from the SERVER  
public Sub BROWSERTest(msg As String)  
   Log("SERVER says '" & msg & "'")  
End Sub  
  
' uploading a file to our server  
Sub SKButton1_Click (event As BANanoEvent)  
   Dim Response As BANanoObject  
   ' get the file object  
   Dim theFile As BANanoObject = SKTextBox1.File  
   If theFile = Null Then  
       BANano.Alert("Please select a file first!")  
       Return  
   End If  
   ' prevent big uploads  
   If theFile.GetField("size") > 1024 * 1024 * 5 Then  
       BANano.Alert("File is to big!")  
       Return  
   End If  
   ' returns a promise  
   Dim prom As BANanoPromise = BANano.UploadFile(theFile)  
   prom.Then(Response)  
       SKLabel1.Text = "Upload status: " & Response.GetField("status").Result  
   prom.Else(Response)  
       Log(Response)  
   prom.end  
End Sub
```

  
  
**SHAREDHuman** (a SHAREDCode class that can be used both in a BROWSERPage and SERVERPage class):  

```B4X
'This class is shared between the BANanoServer and BANAno  
'Use to specify which code is specific for the BANanoServer (B4J) and the BANano Browser part  
'  #If #B4J  
'  
'  #Else  
'  
'  #End If  
'Making changes in a this module/class in B4J debug mode will NOT have any effect on the BANano side until recompiled!  
#Region BANano  
   ' <————– IMPORTANT! This is because we want the non specific B4J code in this module to be transpiled by BANano  
#End Region  
  
Sub Class_Globals  
   Public Name As String  
   Public Gender As String  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
  
End Sub  
  
public Sub ToJSON() As String  
   Dim m As Map = CreateMap("name": Name, "gender": Gender)  
  
   #If B4J  
       Dim json As JSONGenerator  
   #Else 'if BANANO  
       Dim json As BANanoJSONGenerator  
   #End If  
   json.Initialize(m)  
   Return json.ToString  
End Sub  
  
public Sub FromJson(jsonStr As String)  
   Dim m As Map  
   #if B4J  
       Dim json As JSONParser  
   #Else 'if BANAno  
       Dim json As BANanoJSONParser  
   #End If  
   json.Initialize(jsonStr)  
   m = json.NextObject  
  
   Name = m.Get("name")  
   Gender = m.Get("gender")  
End Sub
```

  
  
**NOTE:** a server.ini file can be put next ot the .jar (in the Objects folder when debugging). This is an example:  

```B4X
Host=localhost  
Port=55056  
PortSSL=0  
CacheScavengePeriodSeconds=900  
SessionMaxInactiveIntervalSeconds=900
```

  
  
Alwaysbusy