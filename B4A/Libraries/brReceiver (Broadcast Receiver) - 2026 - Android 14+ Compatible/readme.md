### brReceiver (Broadcast Receiver) - 2026 - Android 14+ Compatible by Jmu5667
### 08/13/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171791/)

Hello All  
  
Please find attached our new broadcast receiver, I developed this as new android's require it to be exported. I used co-pilot for some assistance. I am supplying the source also as I believe it is important to publish the source is your are giving a lib away. Also you can support it yourself. I used SLC to create the library.  
  
Thanks  
  
John.  
  
Usage  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim br As BroadcastReceiver  
     
End Sub  
  
Sub Service_Create  
  
    receiver_init  
    RegisterReceiver(br)  
     
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
       
     
End Sub  
  
Sub Service_Destroy  
    unRegisterReceiver(br)  
End Sub  
  
Sub receiver_init  
  
    br.Initialize("br")  
    br.addAction("add your intents here")  
    br.addAction("add your intents here")  
    br.SetPriority(2147483647)  
  
End Sub  
  
Sub br_OnReceive (Action As String, i As Object)  
     
    ' // do your stuff  
     
         
End Sub  
  
' // 2026.08.04 - Android 14+  
Sub RegisterReceiver(pBR As BroadcastReceiver)  
  
    Dim p As Phone  
  
    Try  
        If p.SdkVersion < 33 Then  
            pBR.RegisterReceiver(False)  
        Else  
            pBR.RegisterReceiver(True)  
        End If  
    Catch  
        Log(LastException.Message)  
    End Try  
     
End Sub  
  
' // 2026.08.04 - Android 14+  
Sub unRegisterReceiver(pBR As BroadcastReceiver)  
  
    Try  
        pBR.unregisterReceiver  
    Catch  
       log(LastException.Message}  
    End Try  
  
End Sub
```