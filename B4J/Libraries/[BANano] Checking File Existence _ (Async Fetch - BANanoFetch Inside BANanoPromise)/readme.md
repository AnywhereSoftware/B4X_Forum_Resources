### [BANano] Checking File Existence : (Async Fetch - BANanoFetch Inside BANanoPromise) by Mashiane
### 10/18/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/155731/)

Hi  
  
This code is based on a response I got about something else I needed about files, fetch & promise.  
  
Anyway.. The code below will check if a file exists and return true / false. I need the file check to trap & report an error if the file does not exist.  
  

```B4X
private Sub FileExist(fn As String) As Boolean  
    Dim error As Object  
    Dim fetch As BANanoFetch  
    Dim fetchResponse As BANanoFetchResponse  
    Dim prom As BANanoPromise  
      '  
    Dim bfo As BANanoFetchOptions  
    bfo.Method = "HEAD"  
      
    '_prom = new Promise(function(resolve,reject) {  
    prom.NewStart  
    '_fetch=fetch(_fn,_bfo);  
    fetch.Initialize(fn, bfo)  
    '_fetch.then(function(_fetchresponse) {  
    fetch.Then(fetchResponse)  
    'resolve(_fetchresponse.ok);  
    BANano.ReturnThen(fetchResponse.OK)  
    '}).catch(function(_error) {  
    fetch.Else(error)  
    'reject(false);  
    BANano.ReturnElse(False)  
    '});  
    fetch.End  
    '});  
    prom.NewEnd  
        
    '_res=await _prom;  
    Dim res As Boolean = BANano.Await(prom)  
      Return res  
End Sub
```

  
  
Usage - checking a file on assets directory.  
  

```B4X
Dim fe As Boolean = BANano.Await(FileExist("./assets/dbFile.sql"))
```

  
  
Have Fun.