### (B4A-B4J Chargeable) Amir_Retrofit by alimanam3386
### 06/11/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/118890/)

[Type-safe HTTP client for Android and Java by Square, Inc.](https://github.com/square/retrofit)  
  
**The best android library for HTTP client. Easier and faster !**?  

- Amir\_Retrofit (including rxJava)
- Amir\_RetroMin (Simple Version of Amir\_Retrofit, just use it for simple apps)
- jAmir\_Retrofit (B4J)

  
***Some of the Retrofit features :***  

- Methods : GET - POST - PUT - PATCH - DELETE - HEAD - OPTIONS
- Cache And Cookie
- Streaming Download
- Support Proxy
- Response And Request Progress
- Support JSON/XML/Gzip/Deflate
- NetworkUtils (Amir\_RetrofitUtils)
- Do Requests In Background
- Customize SSL Validation
- Support Multipart
- Support Form-URL-Encoded

And so many other things…  
  
Retrofit also works with OkHttpClient. OkHttp is a pure HTTP/SPDY client responsible for any low-level network operations, caching, requests and responses manipulation. In contrast, Retrofit is a high-level REST abstraction build on top of OkHttp. Retrofit is strongly coupled with OkHttp and makes intensive use of it.  
  
**Amir\_Retrofit is using RxJava, but what is RxJava?**  
RxJava is a Java VM implementation of ReactiveX a library for composing asynchronous and event-based programs by using observable sequences.  
The building blocks of RxJava are Observables and Subscribers. Observable is used for emitting items and Subscriber is used for consuming those items. Maybe some of you will think: „Hmmm this is so similar to standard Observable pattern“. And yes it is, but RxJava does it much better and has more options. For example, Observables often don’t start emitting items until someone subscribes to them. This is a great feature because this way you should save your performances.  
  
API handling can be tedious if not completed in a good way. Loading data into an Android app can lag the UI thread if not done on a separate thread. RxJava2 and Retrofit2 are very powerful libraries that solve this problem. However, when you first get started with these libraries it can be very difficult to understand how to implement them in your application **(Working with Amir\_Retrofit will be so much easy ?)**.  
  
How if you don't wanna use RxJava?  
At first, I am telling you, do not stop using RxJava it's really awesome.  
but if you don't want it, simply you can use Amir\_RetroMin (RetroMin is just Retrofit Without RxJava and using default CallBack) or just use Retrofit.CallBack.METHODS. Example :  
  

```B4X
Retrofit.CallBack.Get("URL",QueryMap).Enqueue("EventName",Tag) 'Tag can be Null
```

  
  
  
**Amir\_Retrofit includes Gson , what is Gson? :**  
Google Gson is a simple Java-based library to serialize Java objects to JSON and vice versa. It is an open-source library developed by Google.  
The following points highlight why you should be using this library −  

- **Standardized** − Gson is a standardized library that is managed by Google.
- **Efficient** − It is a reliable, fast, and efficient extension to the Java standard library.
- **Optimized** − The library is highly optimized.
- **Support Generics** − It provides extensive support for generics.
- **Supports complex inner classes** − It supports complex objects with deep inheritance hierarchies.

```B4X
Dim Gson As Amir_Json : Gson.Initialize  
Log(Gson.ToJson(OBJECT)) 'Log json value  
Dim MyObject As Object = Gson.FromJson(JsonString)
```

  
  

```B4X
'Post json by Retrofit  
Retrofit.Json("EventName","URL",Retrofit.toJson(OBJECT))
```

  
  
**Retrofit BaseUrl :**  
The specified endpoint values are resolved against this value using HttpUrl resolve. The behaviour of this matches that of an "<a href="">"  
link on a website resolving on the current URL.  
  
*Note: Base URLs should always end in '/'*  
  
A trailing '/' ensures that endpoints values which are relative paths will correctly  
append themselves to a base which has path components.  
  
For example:  
*Base URL*: <http://example.com/api/>  
*Endpoint*: foo/bar/  
*Result*: <http://example.com/api/foo/bar/>  
  
You can set this on RetrofitBuilder with :  
[ICODE]Builder.Initialize.BaseUrl("<http://example.com/api/>")[/ICODE]  
  
Or if you are using default Builder use Retrofit.Initialize2 :  
[ICODE]Retrofit.Initialize2("<http://example.com/api/>")[/ICODE]  
  
**Retrofit Builder :**  
Amir\_RetrofitBuilder will set your Retrofit options such as supporting cache,cookie,proxy. for example:  
  

```B4X
Dim Builder As Amir_RetrofitBuilder  
Builder.Initialize2  
'Or Builder.Initialize.BaseUrl("BaseUrl")  
Builder.addCache(True).addCookie(True)  
Builder.addHeader(CreateMap("Header":"Value"))  
  
Dim Retrofit As Amir_Retrofit  
Retrofit.Initialize(Builder)
```

  
  
or you can use Retrofit.Initialize2 to use default Retrofit Builder.  
  
  
**Retrofit Events :**  

```B4X
'RxJava Events  
Sub EventName_onCompleted  
Sub EventName_onError (Error As String,Code As Int)  
Sub EventName_onNext (ResponseBody As Amir_ResponseBody)  
  
'CallBack Events  
Sub EventName_onFailure (Call As Amir_CallBack,Message As String)  
Sub EventName_onResponse (Call As Amir_CallBack,Response As Amir_RetrofitResponse,Body As Amir_ResponseBody)  
  
'Download Events  
Sub EventName_onCompleted  
Sub EventName_onError (Error As String,Code As Int)  
Sub EventName_onCancel  
Sub EventName_onStart (Key As String)  
Sub EventName_onProgress (key As String,progress As Int,downloadedsize As Long,totalsize As Long)  
Sub EventName_onSucess (key As String,path As String,Name As String,FileSize As Long)  
  
'Upload Events  
Sub EventName_onCompleted  
Sub EventName_onError (Error As String)  
Sub EventName_onNext (ResponseBody As Amir_ResponseBody)  
'Request Body Should be a ProgressRequestBodyObservable  
Sub EventName_onProgressUpdate (Progress As Float,uploaded As Float,total As Float)  
  
'Response Progress  
'You can enable this event in Builder :  
' Builder.addResponseProgress(True,"EventName",Null)  
Sub EventName_onResponseProgress(bytesRead As long,contentLength As long,done As boolean,Chain As Object,Response As Object)
```

  
  
Or simply you can use SingleEventCallAdapter for basic Events just like OkHttpClient JobDone (you will have other events as well) :  

```B4X
'Builder.SingleEventCallAdapterFactory(True)  
Sub EventName_onDone (isSuccess As Boolean,Message As String,Response As Amir_ResponseBody)  
Sub EventName_onDownloadDone (isSuccess As Boolean,Message As String,Path As String,Name As String)
```

  
  
**AXPostMan** :  
  
A Simple app written with B4J and jAmir\_Retrofit. Send your requests and Generate B4A/B4J Retrofit Code !  
  
![](https://www.b4x.com/android/forum/attachments/95494)  
  
![](https://www.b4x.com/android/forum/attachments/95495)  
  
As you know PostMan is a HTTP client for testing web services. simply AXPostMan will test your API With jAmir\_Retrfoti and also you can generate B4A-B4J Retrofit codes to use it on your project.  
you can download AXPostMan and test it now.  
  
***I am developing this tool for now so may it has some bugs. remember bugs are not effected Amir\_Retrofit lib. let me know if you find any problem***  
  
[**Download AXPostMan**](https://www.dropbox.com/s/34kxz4it5xxvabw/axpostman1.00%20%28amir_retrofit%29.jar?dl=0)  
  
**Simple Retrofit usage :**   

```B4X
Retrofit.Get("EventName","URL",QueryMap) 'Get  
Retrofit.Post("EventName","URL",FieldsMap) 'Post  
Retrofit.PostMultipart("EventName","URL",MultipartList) 'Post Multipart  
Retrofit.Download("EventName","URL") 'Download  
Retrofit.Upload("EventName","URL",Retrofit.RB.WithFile("*/*","FileDir","FileName")) 'Upload File
```

  
  
I spent a lot of time for this lib & tool so for support me you can make me more happy ? the price is $10  
  
[**[SIZE=6]Pay[/SIZE]**](https://www.paypal.me/amirRecyclerView/10)  
  
*After payment please send me an email ( [EMAIL]alimanam@gmail.com[/EMAIL] )*  
  
thanks