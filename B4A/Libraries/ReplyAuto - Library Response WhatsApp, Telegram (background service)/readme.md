### ReplyAuto - Library Response WhatsApp, Telegram (background service) by jsaplication.mobile
### 03/05/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138920/)

Hello, I would like to introduce you to my new auto-response library for social networks, compatible with whatsapp, telegram works in the background  
  
A good part of the code was recovered from the NotificationListener library I made some modifications to adapt to my project and I'm making available to you the example and the ReplyAuto.rar library.  
  
Sorry for my English, I'm Brazilian and I'm in love with Basic4Android. no more conversations Let's go to the example.  
  
**Important** minSdkVersion="14" AND android:targetSdkVersion="29"  
  
  

```B4X
AddApplicationText(  
<service android:name="b4a.jsaplication.com.br.ReplyAuto"  
    android:label="ReplyAuto"  
          android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">  
     <intent-filter>  
         <action android:name="android.service.notification.NotificationListenerService" />  
     </intent-filter>  
 </service>)
```

  
  
  

```B4X
Sub ReplyAuto_NotificationPosted (SBN As StatusBarNotification)  
    'Log(SBN.Id) 'get Id Notification  
    'Log(SBN.PackageName) 'get PackageName Application posted Notification  
    'Log(SBN.Notification) 'get Notification object  
    'Log(SBN.Extras)  'get extras Notification  
    'Log(SBN.ContentIntent) 'get ContentIntent not used  
    'Log(SBN.Key) 'get Key  
    'LogColor(SBN.Title, Colors.Green)  
    'LogColor(SBN.Message, Colors.Green)  
      
    If SBN.PackageName == "com.whatsapp" Then  
        Dim whatsappkey As String = SBN.Key  
        Dim ww() As String = Regex.Split("\|", whatsappkey)  
        If ww(3) <> "null" Then  
            'rp.ClearNotification(SBN)  
            rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld WhatsApp")  
            Log("Reply Whatsapp Success")  
        End If  
    End If  
      
  
    If SBN.PackageName == "com.whatsapp.w4b" Then  
        Dim whatsappkey As String = SBN.Key  
        Dim ww() As String = Regex.Split("\|", whatsappkey)  
        If ww(3) <> "null" Then  
            'rp.ClearNotification(SBN)  
            rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld WhatsApp-Business")  
            Log("Reply Whatsapp Success")  
        End If  
    End If  
      
    If SBN.PackageName == "org.telegram.messenger.web" Then  
        Dim telegramkey As String = SBN.Key  
        Dim tt() As String = Regex.Split("\|", telegramkey)  
          
        If tt(2).Length <> "1" Then  
            rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld Telegram")  
            Log("Send Telegram Success")  
        End If  
    End If  
      
    If SBN.PackageName == "org.telegram.messenger" Then  
        Dim telegramkey As String = SBN.Key  
        Dim tt() As String = Regex.Split("\|", telegramkey)  
          
        If tt(2).Length <> "1" Then  
            rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld Telegram")  
            Log("Send Telegram Success")  
        End If  
    End If  
      
  
End Sub
```