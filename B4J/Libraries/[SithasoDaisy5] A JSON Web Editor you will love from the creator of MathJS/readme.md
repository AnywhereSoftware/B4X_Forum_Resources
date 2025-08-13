### [SithasoDaisy5] A JSON Web Editor you will love from the creator of MathJS by Mashiane
### 03/27/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166338/)

Hi Fam  
  
This has been one of those components that I postponed to do. The creator of [MathJS](https://github.com/josdejong/mathjs), a javascript library that I have been using for a while, also created a JSON Editor. I decided to try the ES6 version and it was not as scary as I thought. This is wrapped from this Svelte [Github](https://github.com/josdejong/svelte-jsoneditor) project.  
  
So this was awesome, internally, we call.  
  

```B4X
BANano.Header.AddJavascriptES6File("jsoneditor.min.js")  
.  
.  
.  
jEditor = BANano.ImportWait("jsoneditor.min.js")  
    jEditor.RunMethod("createJSONEditor", Array(Options))
```

  
  
the jEditor BANanoObject will expose all the exports / methods that one can execute. Mind blowing.  
  
  
![](https://www.b4x.com/android/forum/attachments/162973)  
  
As always, you drop the component in your layout and pass the json editor a json string or map  
  

```B4X
Sub Show(MainApp As SDUI5App)  
    app = MainApp  
    BANano.LoadLayout(app.PageView, "jsoneditorview")  
    pgIndex.UpdateTitle("SDUI5JsonEditor")  
    '  
    Dim j As Map = CreateMap()  
    j.Put("data", Array(1, 2, 3))  
    j.Put("boolean", True)  
    j.Put("color", "#82b92c")  
    j.Put("null", Null)  
    j.Put("number", 123)  
    j.Put("object", CreateMap("a":"b", "c": "d"))  
    j.Put("string", "Hello World")  
    jEdit.Json = j  
    BANano.Await(jEdit.Refresh)  
End Sub
```