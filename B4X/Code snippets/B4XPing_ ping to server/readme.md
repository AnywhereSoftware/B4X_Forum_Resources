###  B4XPing: ping to server by TILogistic
### 09/06/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/162944/)

Ping a server to indicate whether it is up or down, or if it is a valid server.  

```B4X
    Dim Ping As B4XPing  
    Ping.Initialize  
     
    Ping.TimeOut = 30 * DateTime.TicksPerSecond 'default 60 seconds  
    Ping.ListPorts = CreateMap("http":80, "https":443) 'default "http":80, "https":443, "ftp":21  
    Ping.DefaultPort = 443 'Default 80  
     
    Log("********** URL True **********")  
    Dim URL As String = "https://translate.google.com/?sl=auto&tl=es&op=translate"  
    Wait For (Ping.Server(URL)) Complete (Result As Boolean)  
    Log(URL)  
    Log(Result)  
   
    Dim URL As String = "b4x.com" 'DefaultPort  
    Wait For (Ping.Server(URL)) Complete (Result As Boolean)  
    Log(URL)  
    Log(Result)  
     
    Log("********** URL False **********")  
     
    Dim URL As String = "https://translate.googlexxxx.com/?sl=auto&tl=es&op=translate"  
    Wait For (Ping.Server(URL)) Complete (Result As Boolean)  
    Log(URL)  
    Log(Result)  
   
    Dim URL As String ="b4xxxx.com" 'DefaultPort  
    Wait For (Ping.Server(URL)) Complete (Result As Boolean)  
    Log(URL)  
    Log(Result)
```

  
![](https://www.b4x.com/android/forum/attachments/156644)  
  
Regards.