###  Websockets Client Connect and Reconnect by aminoacid
### 12/03/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/143855/)

Based on Erel's MQTT ConnctAndReconnet Sub: -  
  
This sub will attenpt to maintain a constant websockets connection. Set working=True and call the sub ONCE in your program:  
  
  

```B4X
Sub ws_ConnectAndReconnect  
    ws.Initialize("ws")  
    Do While working  
        If ws.Connected Then ws.Close  
        ws.Connect(wsURL)  
        wait for ws_Connected  
        Sleep(5)  
        If ws.Connected Then  
            ws.SendText(tmsg)  
            'ws.SendTextAsynch(tmsg)  
            Do While working And ws.Connected  
                Sleep(5000)  
            Loop  
        Else  
            Log("Cannot Connect")  
        End If  
        ws.Close  
        Sleep(15000)  
    Loop  
End Sub
```

  
  
  
[edit]  
 - Use ws.SendTextAsync(tmsg) instead of ws.SendText(tmsg) if you experience any issues with the application hanging.  
Note that ws.SendTextAsync requires jWebSocketsClient v1.12+ library