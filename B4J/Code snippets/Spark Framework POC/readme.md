### Spark Framework POC by EnriqueGonzalez
### 08/24/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/133692/)

Hi! so i was chatting with [USER=27471]@ilan[/USER] about the idea of having multiple entries on the url parameters.   
<https://www.b4x.com/android/forum/threads/url-routing.133665/>  
  
Due my experience, i know this is not possible, until later in the day i found in some documentation on Stripe that Spark (jetty based) actually allows to do this.   
<http://sparkjava.com/>  
  
So I decided to test it and vuala! it worked!   
  
Called: <http://localhost:4000/hello/ilan/age/25>  
Code: Log($"hello ${name}, age ${age}"$)  
Logged: hello ilan, age 25  
  
Of course this is just a proof of concept, i actually can return only "world" (lol ?) to the browser  
  
if you want to run a spin download the jar from here:   
<https://jar-download.com/artifacts/com.sparkjava>  
as it will get you all the dependencies.  
  
this was just to demonstrate that for some reason Jetty doesnt allow parameters, but spark that is built on top of it allows. may be we are just missing something? only time will tell.  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes   
    #CommandLineArgs:  
    #MergeLibraries: True   
      
    #AdditionalJar: spark-core-2.9.3.jar  
    #AdditionalJar: slf4j-api-1.7.30.jar  
    #AdditionalJar: javax.servlet-api-3.1.0.jar  
    #AdditionalJar: jetty-server-9.4.31.v20200723.jar  
    #AdditionalJar: jetty-util-9.4.31.v20200723.jar  
    #AdditionalJar: jetty-http-9.4.31.v20200723.jar  
    #AdditionalJar: jetty-io-9.4.31.v20200723.jar  
#End Region  
  
Sub Process_Globals  
      
End Sub  
  
Sub AppStart (Args() As String)  
      
    Dim sp As JavaObject  
    sp.InitializeStatic("spark.Spark")  
    sp.RunMethod("port",Array(4000))  
      
    Dim event As Object = (Me).As(JavaObject).CreateEvent("spark.Route","getter","world")  
      
    sp.RunMethod("get",Array("/hello/:name/age/:age",event))  
      
    StartMessageLoop  
End Sub  
  
public Sub getter_Event (MethodName As String, Args() As Object) As Object  
    Dim req As JavaObject = Args(0)  
      
    Dim name As String = req.RunMethod("params",Array(":name"))  
    Dim age As String = req.RunMethod("params",Array(":age"))  
      
    Log($"hello ${name}, age ${age}"$)  
    Return ""  
End Sub
```