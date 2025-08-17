### SithasoDocxTemplator: Creating MS Word Documents from Dynamic Templates in JavaScript by Mashiane
### 11/15/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/144171/)

Hi the  
  
This was an interesting find: <https://docxtemplater.com/>, also its just so easy to use and understand.  
  
Below is my template. I am attempting to generate the API documentation for the SithasoDaisy ebook. This was easy to achieve using tables on the demo. And yes, I could fire up HTML2DOCX, but this is not what I wanted.  
  
I wanted to create a template that could suit my needs and all i will do is feed it content. The tables will have repeat rows {#properties} etc. These are stored as lists/arrays in the json file.  
  
![](https://www.b4x.com/android/forum/attachments/136023)  
  
An example of the output based on a HTML in the running app is like this…  
  
![](https://www.b4x.com/android/forum/attachments/136024)  
  
So I have JSON files (example attached) that have these definitions, when each component is selected, I am reading the JSON file and then generating the table above.  
  
To do this for the word documents, I will have to do a similar thing. In this case, I click on a button, the file is read and then a simple scripts generates the needed word document.  
  

```B4X
Sub apiprops_doc (e As BANanoEvent)  
    apiprops.ToolbarButtonLoading("doc", True)  
    Dim jsonFile As Map = banano.Await(banano.GetFileAsJSON($"./assets/${CompName}.json"$, Null))  
   
    Dim properties As List = jsonFile.Get("properties")  
    Dim events As List = jsonFile.Get("events")  
    Dim methods As List = jsonFile.Get("methods")  
    '  
    Dim doc As SithasoDocxTemplator  
    doc.Initialize(Me, "docx", "./assets/api.docx", $"${CompName}.docx"$)  
    doc.SetField("component", CompName.ToUpperCase)  
    doc.SetField("properties", properties)  
    doc.SetField("events", events)  
    doc.SetField("methods", methods)  
    banano.Await(doc.BuildWait)  
   
    apiprops.ToolbarButtonLoading("doc", False)  
End Sub
```

  
  
This is the complete code for the SithasoDocxTemplator  
  

```B4X
#IgnoreWarnings:32  
  
#Event: Finished  
  
Sub Class_Globals  
    Private fn As String  
    Private BANano As BANano            'ignore  
    Private mcallback As Object  
    Private eventName As String  
    Private tags As Map  
    Private ffn As String  
End Sub  
  
Public Sub Initialize(mcb As Object, event As String, tmpFile As String, target As String)  
    fn = tmpFile  
    mcallback = mcb  
    eventName = event  
    tags.Initialize  
    ffn = target  
End Sub  
  
Sub SetField(key As String, value As Object)  
    tags.Put(key,value)  
End Sub  
  
Sub BuildWait  
    Dim PizZipUtils As BANanoObject  
    PizZipUtils.Initialize("PizZipUtils")  
    '  
    Dim error, content As Object  
    Dim cb As BANanoObject = BANano.CallBack(Me, "generate", Array(error, content))  
    PizZipUtils.RunMethod("getBinaryContent", Array(fn, cb))  
End Sub  
  
Private Sub generate(error As Object, content As Object)            'ignore  
    If BANano.IsNull(error) = False Then  
        BANano.throw(error)  
        Return  
    End If  
    'start processing  
    Dim zip As BANanoObject  
    zip.Initialize2("PizZip", content)  
    '  
    Dim options As Map = CreateMap()  
    options.Put("paragraphLoop", True)  
    options.Put("linebreaks", True)  
    '  
    Dim doc As BANanoObject  
    doc.Initialize2("Docxtemplater", Array(zip, options))  
    '  
    doc.RunMethod("render", tags)  
    '  
    Dim blobOptions As Map = CreateMap()  
    blobOptions.Put("type", "blob")  
    blobOptions.Put("mimeType", "application/vnd.openxmlformats-officedocument.wordprocessingml.document")  
    blobOptions.Put("compression", "DEFLATE")  
    '  
    Dim blob As BANanoObject = doc.RunMethod("getZip", Null).RunMethod("generate", blobOptions)  
    BANano.RunJavascriptMethod("saveAs", Array(blob, ffn))  
   
    If SubExists(mcallback, $"${eventName}_finished"$) Then  
        CallSub(mcallback, $"${eventName}_finished"$)  
    Else  
        BANano.Console.Warn($"SithasoDocxTemplator: '${eventName}_finished' event does not exist!"$)  
    End If  
End Sub
```

  
  
Of course this can be adopted to work for ones use cases. So far this is good progress.  
  
![](https://www.b4x.com/android/forum/attachments/136027)