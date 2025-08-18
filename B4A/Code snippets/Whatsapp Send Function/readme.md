### Whatsapp Send Function by Hamied Abou Hulaikah
### 09/22/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/122650/)

I hope this help someone:  

```B4X
Sub whatsappSend(mobile as string,msg as string)  
    Dim sendIntent As Intent  
    sendIntent.Initialize(sendIntent.ACTION_MAIN,"")  
    sendIntent.PutExtra("jid",mobile & "@s.whatsapp.net")  
    sendIntent.Action=sendIntent.ACTION_SEND  
    sendIntent.SetPackage("com.whatsapp")  
    sendIntent.SetType("text/plain")  
    sendIntent.PutExtra("android.intent.extra.TEXT",msg)  
    StartActivity(sendIntent)     
End Sub
```