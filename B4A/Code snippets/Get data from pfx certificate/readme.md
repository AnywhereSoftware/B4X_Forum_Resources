### Get data from pfx certificate by nesam
### 07/30/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133008/)

SubName: pfx  
  
Description: access data from pfx file : pfx(File.DirAssets ,"xxxxx.pfx","password")  
  
  

```B4X
private Sub pfx(StoreDir As String, StoreFile As String, StorePassword As String)  
      
    Dim in As InputStream = File.OpenInput(StoreDir, StoreFile)  
      
    Dim keystore As JavaObject  
    keystore.InitializeStatic("java.security.KeyStore")  
    Dim password As Object = StorePassword.As(JavaObject).RunMethod("toCharArray", Null) 'ignore  
    Dim store As JavaObject = keystore.RunMethodJO("getInstance", Array("pkcs12"))  
    store.RunMethod("load", Array(in, password))  
  
    Dim aliases As JavaObject = store.RunMethod("aliases",Null)  
    Do While aliases.RunMethod("hasMoreElements", Null)  
        Dim b As String = aliases.RunMethod("nextElement", Null)  
        Log("aliases: "&b)  
        Dim NotAfter As JavaObject = store.RunMethodJO("getCertificate", Array(b)).RunMethod("getNotAfter", Null)  
        Dim SubjectDN As JavaObject = store.RunMethodJO("getCertificate", Array(b)).RunMethod("getSubjectDN", Null)  
        ' all other data in the same way…  
  
'        Log(("NotAfter: "&NotAfter))  
'        Log(("SubjectDN: "&SubjectDN))  
  
        Dim DN() As String=Regex.Split(",",SubjectDN)  'ignore  
        For Each data In DN  
            Dim temp() As String=Regex.Split("=",data)  
            Log(temp(0)&" - "&temp(1))  
        Next         
    Loop  
End Sub
```

  
  
Dependencies: -  
  
Tags: Access data from certificate in .pfx file.