### Synchronous HTTP Request Library by tchart
### 11/14/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/136028/)

**IMPORTANT NOTE  
There are many reasons you shouldnt use this library e.g. it will hold up your main thread. This is especially important for UI applications.  
  
\*\*\* Please dont turn this thread into a sermon regarding synchronous vs asynchronous calls. It is for specific use cases \*\*\***  
  
This is a wrapper for this library; <https://github.com/kevinsawicki/http-request>  
  
An important distinction here is that this library does synchronous http requests. It will block your thread. It will affect UI. Basically you shouldnt use this unless you know why you need this library.  
  
However if you have a console application, background process or some kind of application that needs to make many http calls in a specific order then this library will simplify your workflow.  
  
Code Examples;  
  
Generic GET - Return Status Code  
  

```B4X
Dim req As HttpRequestWrapper  
  
req.Initialize(URL,req.METHOD_GET)  
  
req.trustAllCerts  
req.trustAllHosts  
req.followRedirects(True)  
  
req.connectTimeout(1000)  
req.readTimeout(1000)  
  
Return req.code
```

  
  
Generic Get - Return Body  
  

```B4X
Dim ParameterMap As Map ' These are your query strings  
ParameterMap.Initialize  
ParameterMap.Put(token,"ABCDEF")  
  
Dim req As HttpRequestWrapper  
        
req.Initialize(URL,req.METHOD_GET)  
        
req.trustAllCerts  
req.trustAllHosts  
req.followRedirects(True)  
  
If ParameterMap.Size > 0 Then req.form(ParameterMap)  
  
Dim contentType As String = req.contentType  
  
Dim body As String  
body = req.body  
  
Return body
```

  
  
Generic Post  
  

```B4X
Dim ParameterMap As Map ' These are your query strings  
ParameterMap.Initialize  
ParameterMap.Put(token,"ABCDEF")  
  
Dim req As HttpRequestWrapper  
  
req.Initialize(URL,req.METHOD_POST)  
  
req.trustAllCerts  
req.trustAllHosts  
req.followRedirects(True)  
  
If ParameterMap.Size > 0 Then req.form(ParameterMap)  
  
Dim contentType As String = req.contentType  
Dim body As String = req.body  
  
Return body
```