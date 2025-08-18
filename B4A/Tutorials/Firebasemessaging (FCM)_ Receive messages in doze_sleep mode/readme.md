### Firebasemessaging (FCM): Receive messages in doze/sleep mode by KMatle
### 11/29/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/136433/)

Issue: Device doesn't receive FCM messages while in sleep/doze mode  
  
Important to know: Google uses 2 different api's with different keywords  
  
![](https://www.b4x.com/android/forum/attachments/122415)  
  
So:  
  
<https://fcm.googleapis.com/fcm/send> **= legacy mode**   
  
<https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send> **=v1**  
  
More info's: [FCM Docs](https://firebase.google.com/docs/cloud-messaging/migrate-v1)  
  
This is important as e.g. my examples pointed in the right direction but used the keywords wrong (due to examples I picked which didn't explain the difference)  
  
The correct way using "legacy" FCM messaging (in my scenario I use data messages. The notifications are created in the FCM service via NB6)  
  
Example to send to a topic:  

```B4X
    Dim m As Map = CreateMap("to": $"/topics/${Top}"$)  
    Dim data As Map = CreateMap("md": MyData)  
    Dim pri As Map=CreateMap("priority":"high") 'for v1  
    m.Put("data", data)  
    m.Put("priority", "high") ' for legacy!!!!!  
    m.Put("android", pri)  
     
    Dim jg As JSONGenerator  
    jg.Initialize(m)  
    Job.PostString("https://fcm.googleapis.com/fcm/send", jg.ToString)  
    Job.GetRequest.SetContentType("application/json;charset=UTF-8")  
    Job.GetRequest.SetHeader("Authorization", "key=" & API_KEY)
```

  
  
**Important is this line: "m.Put("priority", "high")" as an extra parameter (in v1 it is handled different). You can use both forms like me.**   
  
I've tested it the last hours on Android 11 (let my phone go into deep sleep) and it works fine (including swiping it)  
  
Additionally:  
  
1. Check the energy & network settings of your device and of your app! (compare it with e.g. WhatsApp)  
2. Use the FCM example fro the forum as it is (no autostart or foreground mode)  
3. There still may be delays as Google limits the "high priority" messages or your network is struggling  
4. You can still mix data and notification messages (should work either but there are limitations - see Google's docs)  
5. Even WhatsApp messages do come in late from time to time (e.g. when your Wifi/mobile network doesn't work well)