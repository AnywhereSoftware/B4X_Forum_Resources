### Firebase Push Messages (FCM) by Erel
### 10/28/2019
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/81025/)

This code uses rHttpUtils2 to send push messages. It is equivalent to the B4J/A/i code posted here: <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-firebase-cloud-messaging-fcm.67716/#content>  
  
Notes:  
- #StackBufferSize should be set to 500+.  
- The title and body messages are not escaped. You will need to manually escape the messages if they include quotes.  
  

```B4X
#Region Project Attributes  
   #AutoFlushLogs: True  
   #CheckArrayBounds: True  
   #StackBufferSize: 2000  
#End Region  
  
Sub Process_Globals  
   Public Serial1 As Serial  
   Private API_KEY() As Byte = "cccccccccc:APA91bH-y-L-I6jIyfxWvbM4cccccccccccBz-j-Vm1TIpAXmp1dE4p0WYQb2Z0Iq3JqXk-6Ek60RV3vucENceCrVo4VJwIVmHrq1Ktb2P9zCPxnDhT_DjDfV9o__wA51nhR4-uyxiLhcwg"  
   Private wifi As ESP8266WiFi  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   If wifi.Connect2("TP-LINK_D577", "xxxxxxxxx") Then  
       Log("Connected to router.")  
   Else  
       Log("Failed to connect to router.")  
       Return  
   End If  
   Log("AppStart")  
   'send the android message  
   SendMessage("general", "This is the title", "This is the body")  
End Sub  
  
Sub JobDone (jr As JobResult)  
   Log("JobDone: ", jr.JobName)  
   Log("Success: ", jr.Success)  
   If jr.JobName = "ios_general" Then  
     'send the ios message  
     SendMessage("ios_general", "This is the title", "This is the body")  
   End If  
End Sub  
  
Private Sub SendMessage(Topic() As Byte, Title() As Byte, Body() As Byte)  
   Dim bc As ByteConverter  
   HttpJob.Initialize(bc.StringFromBytes(Topic))  
   Dim buffer(300) As Byte 'must be large enough to hold the message payload  
   Dim raf As RandomAccessFile  
   raf.Initialize(buffer, True)  
   WriteBytes(raf, "{""data"":{""title"":""")  
   WriteBytes(raf, Title)  
   WriteBytes(raf, """,""body"":""")  
   WriteBytes(raf, Body)  
   WriteBytes(raf, """}")  
   'end of data  
   WriteBytes(raf, ",""to"":""\/topics\/")  
   WriteBytes(raf, Topic)  
   WriteBytes(raf, """")  
   WriteBytes(raf, ",""priority"": 10")  
   If bc.StartsWith(Topic, "ios_") Then  
     WriteBytes(raf, ",""notification"": {""title"": """)  
     WriteBytes(raf, Title)  
     WriteBytes(raf, """,""body"":""")  
     WriteBytes(raf, Body)  
     WriteBytes(raf, """, ""sound"": ""default""}")  
   End If  
   WriteBytes(raf, "}")  
   HttpJob.AddHeader("Authorization", JoinBytes(Array("key=".GetBytes, API_KEY)))  
   HttpJob.AddHeader("Content-Type", "application/json")  
   Log("stack: ", StackBufferUsage, ", buffer size:", raf.CurrentPosition)  
   HttpJob.Post("https://fcm.googleapis.com/fcm/send", bc.SubString2(buffer, 0, raf.CurrentPosition))  
End Sub  
  
Private Sub WriteBytes(raf As RandomAccessFile, Data() As Byte)  
   raf.WriteBytes(Data, 0, Data.Length, raf.CurrentPosition)  
End Sub
```

  
  
Depends on rHttpUtils2 module (add it with Project - Add existing module): <https://www.b4x.com/android/forum/threads/module-rhttputils2-http-client.74785/#content>  
Also depends on: rESP8266WiFi and rRandomAccessFile.  
It should be simple to convert it to use rEthernet instead of rESP8266WiFi.