### HMS / Huwaei Push Kit by Erel
### 11/01/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124100/)

Start here: <https://www.b4x.com/android/forum/threads/hms-huawei-sdk.124034/#post-775059>  
  
HMS push notifications are similar to iOS push notifications. These are "notification" messages. They are intercepted by the OS which then displays a notification. The app is not started and no code runs.  
This is different than FCM messages which start the app in the background.  
  
Adding support for push notifications is very simple:  
1. Follow the instructions in the link above.  
2. Subscribe to a topic with:  

```B4X
Wait For (hms.Subscribe("test")) Complete (Success As Boolean)  
Log("subscribe: " & Success)
```

  
3. If you want to get the device token:  

```B4X
Wait For (hms.GetPushToken("1031999")) Complete (Token As String) 'the parameter is the app id.  
 Log("token: " & Token)
```

  
  
You can now send messages from the console or with the attached B4J program.  
  
To use the B4J program, you need to set two parameters:  
ClientId and ClientSecret.  
  
Go to HUAWEI developer console (not AppGallery Connect): <https://developer.huawei.com/consumer/en/console>  
  
You need the OAuth 2.0 client id and secret values. As far as I remember, the OAuth credentials were created automatically.  
  
![](https://www.b4x.com/android/forum/attachments/102327)  
  
When you send with the B4J tool, you should see a response such as:  

```B4X
{"code":"80000000","msg":"Success","requestId":"160422173759081617000407"}
```

  
  
It can take several minutes for the notification to appear.  
  
The notification message can be customized in many ways. The json structure is documented here: <https://developer.huawei.com/consumer/en/doc/development/HMSCore-References-V5/https-send-api-0000001050986197-V5>