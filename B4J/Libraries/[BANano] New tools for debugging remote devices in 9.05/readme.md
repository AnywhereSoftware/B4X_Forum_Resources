### [BANano] New tools for debugging remote devices in 9.05 by alwaysbusy
### 09/18/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/163153/)

We recently had a particular problem with a BANano Webapp running on a phone from a client which we could not reproduce on any of our devices. It was impossible for us to have this device in our office to debug it. If only we could see what is in his logs and his database locally on the phone…  
  
In BANano v9.05 we have build a very simple to use solution: receiving remote logs and databases on demand.  
  
De code in de WebApp is pretty simple:  

```B4X
' first in AppStart we tell the Transpiler we want this option  
BANano.TranspilerOptions.UseRemoteConsole("TheNameOfTheDatabaseOnTheDevice")  
  
' when the user encounters his problem, he just presses a button and his log for the last hour + his database is send to us in json format  
BANano.GetRemoteLog              
' …  
' the previous call raises this event when it has build the json file from his logs and database  
Sub BANano_RemoteLog(json As String)  
    BANano.Await(SendWaitRemoteLog(json))  
End Sub  
  
public Sub SendWaitRemoteLog(json As String)  
    Dim fetch As BANanoFetch  
    Dim fetchOptions As BANanoFetchOptions  
    Dim fetchResponse As BANanoFetchResponse  
      
    Dim data As Map  
    Dim Error As String  
      
    fetchOptions.Initialize  
    fetchOptions.Method = "POST"  
    fetchOptions.Body = json  
    fetchOptions.Headers = CreateMap("Content-type": "application/json; charset=UTF-8", "api_key": APIKey)  
      
    fetch.Initialize(APIUrl & "/v1/registration/uploadlog", fetchOptions)  
    fetch.Then(fetchResponse)  
        fetch.Return(fetchResponse.Json)  
    fetch.ThenWait(data)  
        If data.get("status") = "OK" Then  
            SKTools.ShowToast("Report send…", "info", 3000, True)  
        End If  
    fetch.ElseWait(Error)  
        Log(Error)  
        SKTools.ShowToast(Error, "info", 3000, True)          
    fetch.End  
End Sub
```

  
  
the json has two properties:  
log = {}  
db = {}  
  
our jServer REST API catches the json and saves it in our database:  

```B4X
public Sub UploadLog(req As ServletRequest, resp As ServletResponse) As String  
    Dim OTID As Int = req.GetSession.GetAttribute2("OTID", 0)  
    Dim Response As String  
    Dim bodyCode As String  
    Dim body As TextReader  
      
    resp.ContentType = "application/json"  
    Try  
        body.Initialize(req.InputStream)  
        bodyCode = body.ReadAll  
    Catch  
        Response = $"{"status": "NOK", "message": "JSON not valid"}"$          
        Return Response  
    End Try  
      
    If bodyCode.StartsWith("{") Then  
        Dim jsonP As JSONParser  
        Try  
            jsonP.Initialize(bodyCode)  
            DBMApp.InsertLog(400,OTID, 0, 0, 0, "PWA REMOTE LOG", "", req.FullRequestURI, 0, bodyCode)                          
            Response = $"{"status": "OK"}"$  
        Catch  
            Response = $"{"status": "NOK", "message": "JSON not valid"}"$          
        End Try  
    Else  
        Response = $"{"status": "NOK"}"$  
    End If  
      
    Return Response  
End Sub
```

  
  
We can then later analyze this report and for this we have created two new objects in BANanoSkeleton to read it easier: SKJsonEditor and SKRemoteLogView which looks something like this:  
![](https://www.b4x.com/android/forum/attachments/157063)  
The code behind this is also quite simple:  
  

```B4X
Sub BANano_Ready()  
    Dim layout As SKLayout  
    layout = layout.Initialize(Me, "body")  
      
    ' for this demo I just load such a json from a file on disk  
    Dim jsonMap As Map = BANano.Await(BANano.GetFileAsJSON("../test.json", Null))  
          
    Dim emptyM As Map  
    emptyM.Initialize  
          
    Dim DBMap As Map = jsonMap.GetDefault("db", emptyM)  
    Dim logMap As Map = jsonMap.GetDefault("log", emptyM)  
      
    If DBMap.Size > 0 Then         
        layout.AddFlexColumns(1,12,12,12, "center")  
        layout.LastRow.Column(1).MarginTop = "20px"  
  
        Dim jsonEditor As SKJsonEditor = layout.LastRow.Column(1).Add.JsonEditor("jsoneditor", "jsoneditor", "400px", "view")  
        jsonEditor.MarginLeft = "10px"  
        jsonEditor.Marginright = "10px"  
        jsonEditor.LoadJson(DBMap)  
    End If      
      
    If logMap.Size > 0 Then         
        layout.AddFlexColumns(1,12,12,12, "center")  
        layout.LastRow.Column(1).MarginTop = "20px"  
  
        Dim remotelog As SKRemoteLogViewer = layout.LastRow.Column(1).Add.RemoteLogViewer("remotelog", "remotelog", "600px")  
        remotelog.MarginLeft = "10px"  
        remotelog.Marginright = "10px"  
        remotelog.LoadJson(logMap)  
    End If      
End Sub
```

  
  
BANano 9.05 will be released in week or two.  
  
Alwaysbusy