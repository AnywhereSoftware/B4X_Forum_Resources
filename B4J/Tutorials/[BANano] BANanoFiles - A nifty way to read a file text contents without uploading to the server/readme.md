### [BANano] BANanoFiles - A nifty way to read a file text contents without uploading to the server by Mashiane
### 05/09/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/117268/)

Ola  
  
**2010-05-09 Update**  
  
![](https://www.b4x.com/android/forum/attachments/93664)  
  
A Skeleton based demo is attached.  
  
I was checking the BANanoPromise example code as I needed a way to get a text file contents without having to upload to the server and the process it.  
  
So I extracted some portions of that code out and saved them in a class. Here is the class code:  
  

```B4X
public Sub readAsText(fr As String) As BANanoPromise  
    Dim promise As BANanoPromise 'ignore  
        
    ' calling a single upload  
    promise.CallSub(Me, "ReadFileAsText", Array(fr))  
    Return promise  
End Sub  
  
private Sub ReadFileAsText(FileToRead As Object)  
    ' make a filereader  
    Dim FileReader As BANanoObject  
    FileReader.Initialize2("FileReader", Null)  
    ' attach the file (to get the name later)  
    FileReader.SetField("file", FileToRead)  
    
    ' make a callback for the onload event  
    ' an onload of a FileReader requires a 'event' param  
    Dim event As Map  
    FileReader.SetField("onload", BANano.CallBack(Me, "OnLoad", Array(event)))  
    FileReader.SetField("onerror", BANano.CallBack(Me, "OnError", Array(event)))  
    ' start reading the DataURL  
    FileReader.RunMethod("readAsText", FileToRead)  
End Sub  
  
private Sub OnLoad(event As Map) As String 'ignore  
    ' getting our file again (set in UploadFileAndGetDataURL)  
    Dim FileReader As BANanoObject = event.Get("target")  
    Dim UploadedFile As BANanoObject = FileReader.GetField("file")  
    ' return to the then of the UploadFileAndGetDataURL  
    BANano.ReturnThen(CreateMap("name": UploadedFile.GetField("name"), "result": FileReader.Getfield("result")))  
End Sub  
  
private Sub OnError(event As Map) As String 'ignore  
    Dim FileReader As BANanoObject = event.Get("target")  
    Dim UploadedFile As BANanoObject = FileReader.GetField("file")  
    Dim Abort As Boolean = False  
    ' uncomment this if you want to abort the whole operatio  
    ' Abort = true  
    ' FileReader.RunMethod("abort", Null)  
    
    BANano.ReturnElse(CreateMap("name": UploadedFile.GetField("name"), "result": FileReader.GetField("error"), "abort": Abort))  
End Sub
```

  
  
To use this one needs a file input control and trap the change event. I think we know how that can be done.  
  
Here is how I have used it, my class name where the above code is saved is called vm, a banano library compilation.  
  
We have created a skeleton based layout and then we add our invisible file selector here.  
  
Define class in process globals  
  

```B4X
Private bf As BANanoFiles
```

  
  
Add our invisible component  
  

```B4X
bf.Initialize.AddFileSelect(Me, "body", "fuconnect")
```

  
  
When a button is clicked, activate the file select  
  

```B4X
Sub btnReadText_Click (event As BANanoEvent)  
    bf.ShowFileSelect("fuconnect")  
End Sub
```

  
  
Then trap the file selector change event and read the contents of the file  
  

```B4X
Sub fuconnect_change(e As BANanoEvent)  
    Dim fileList As List = bf.GetFileListFromTarget(e)  
    'no file is selected  
    If fileList.size = 0 Then Return  
    'only process 1 file  
    Dim fr As String = fileList.get(0)  
    '  
    Dim Result As Map  
    Dim promise As BANanoPromise = bf.readAsText(fr)  
    promise.Then(Result)  
        'get the json content  
        Dim txt As String = Result.get("result")  
        Log(txt)  
        '  
    promise.Else(Result)  
        Dim compError As String = Result.get("result")  
        Log(compError)  
    promise.End  
     
    'nully file component so we can select same file  
    bf.Nullify  
End Sub
```