### [BANano] [SithasoJsZIP] Compress & Download Files for your WebApps by Mashiane
### 02/04/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159026/)

Hi Fam  
  
**Assumptions**:  
  
You have a **file input**, you fire a change event and trap the selected file(s), you either loop through the files or just process one. This class helps you compress the files and then download them.  
  
First, [Download JSZIp](https://github.com/Stuk/jszip)  
  
Then Add it to your project  
  

```B4X
BANano.Header.AddJavascriptFile("jszip.min.js")
```

  
  
In your code…  
  
1. Initialize the class  
  

```B4X
'start a zip file compression  
    Dim compress As SithasoZip  
    compress.Initialize($"${prjName}.zip"$)
```

  
  
2. Add the file(s) This could be array fileinput.GetFiles / fileinput.GetFile  
  

```B4X
compress.AddFile(fn, fo)
```

  
  
3. Zip the files and download them.  
  

```B4X
'compress the files  
    banano.Await(compress.Compress)  
    compress.Download
```