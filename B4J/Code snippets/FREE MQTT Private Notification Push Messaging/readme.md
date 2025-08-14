### FREE MQTT Private Notification Push Messaging by aziznetstudio
### 07/01/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167596/)

hi b4x's communauty ,   
this is my first thread on b4x forum , and i'm so happy to do this ,first excuse me for my poor english and i want to give this gift to all with a best thank's to EREL and all supervisor and teams who make this possible , i'm in b4x since 2 years , to learn all time every days , and i can tell that i'm just in 20% knowledge with the best ever programing lanquage . i've make a lot of b4a and b4j apps , there is somes in playstore , somes b4j get good success , and now i begin to add here best of my knowledge to others totaly for free to cross a thanks to EREL and all others .  
  
for fisrt this is a tested MQTT push notification messaging with server app ( UI or not ) and receiver in client apps ( B4a/B4j ) i've not test b4i because i dont have it , the structure is very simple to learn and applies just change what you want ( broker name / room …. ) ,  
  
\* the good things in this app is to send private or global push ( send message to specific user if user for ex connect with you client app with email you can use it as txtTargetUser ) or send message to all connected users , i've test a stress and the message arrived to 31800 users same time without any problem ,   
\* second thing , i use AS\_FloatingActionMenu and AS\_Badges , the message arrive instantally and AS\_Badges show badge as number of push , if click on button or label associated show.  
  
 AS\_FloatingActionMenu with messages arrived and if click on message it turn to (alredy read massage) and badge turn to null , i've stor message arrived on list ( you can do it with filewrite or sql if you want )   
  
**1)this is server app :**   
  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 400  
#End Region  
  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private mqtt As MqttClient  
    Private serializator As B4XSerializator  
    Private BrokerUser As String = ""  
    Private BrokerPass As String = ""  
    Private BrokerName As String = "" 'ex:b4x/b4j '  
    Private txtTargetUser As TextField  
    Private txtMessageTitle As TextField  
    Private txtMessageBody As TextField  
    Private btnSend As Button  
    Private xui As XUI  
End Sub  
  
  
Sub AppStart (Form1 As Form, Args() As String)  
    ' UI Setup  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("MainPage")  
    MainForm.Show  
    mqtt.Initialize("mqtt_server", "tcp://broker you want to use : broker port ", "PushServer_" & Rnd(0, 99999))  
End Sub  
  
  
' Event for the "Send" button  
Private Sub btnSend_Click  
    Dim targetUser As String = txtTargetUser.Text  
    Dim msgTitle As String = txtMessageTitle.Text  
    Dim msgBody As String = txtMessageBody.Text  
  
  
    If targetUser.Trim = "" And msgBody.Trim = "" Then  
        xui.MsgboxAsync("Target User and Message Body cannot be empty for personal messages.", "Error")  
        Return  
    End If  
  
  
    ' Connect to the broker if not already connected  
    If Not(mqtt.Connected) Then  
        Dim mo As MqttConnectOptions  
        mo.Initialize(BrokerUser, BrokerPass) ' Use same credentials as your client  
        mqtt.Connect2(mo)  
        Wait For mqtt_Connected (Success As Boolean)  
        If Not(Success) Then  
            xui.MsgboxAsync("Could not connect to MQTT Broker.", "Connection Error")  
            Return  
        End If  
    End If  
      
    If targetUser.Trim <> "" Then  
        ' Send to specific user  
        Dim pushTopic As String = BrokerName & targetUser  
          
        ' Create a structured message using a Map  
        Dim messageMap As Map  
        messageMap.Initialize  
        messageMap.Put("title", msgTitle)  
        messageMap.Put("body", msgBody)  
        messageMap.Put("timestamp", DateTime.Now)  
          
        ' Serialize the Map to bytes  
        Dim payload() As Byte = serializator.ConvertObjectToBytes(messageMap)  
          
        ' Publish the message to the specific user's topic  
        mqtt.Publish(pushTopic, payload)  
        Log($"Message published to topic: ${pushTopic}"$)  
          
        xui.MsgboxAsync("Personal message sent to " & targetUser & " successfully!", "Success")  
    Else  
        ' Optionally, keep the broadcast functionality if no target user is specified  
        Dim broadcastTopic As String = "fetsync/broadcast"  
          
        ' Create a structured message using a Map to identify it as a broadcast  
        Dim broadcastMap As Map  
        broadcastMap.Initialize  
        broadcastMap.Put("type", "broadcast")  
        broadcastMap.Put("content", msgBody)  
          
        ' Serialize the Map to bytes  
        Dim broadcastPayload() As Byte = serializator.ConvertObjectToBytes(broadcastMap)  
          
        ' Publish the message to the broadcast topic  
        mqtt.Publish(broadcastTopic, broadcastPayload)  
        Log($"Broadcast message published to topic: ${broadcastTopic}"$)  
          
        xui.MsgboxAsync("Broadcast message sent successfully!", "Success")  
    End If  
End Sub  
  
  
  
  
' This sub is required for the Wait For call, even if empty  
Sub mqtt_Connected (Success As Boolean)  
    Log("Server MQTT Connected: " & Success)  
End Sub  
  
  
' Disconnect when the app closes  
Sub MainForm_CloseRequest (EventData As Event)  
    If mqtt.Connected Then  
        mqtt.Close  
    End If  
End Sub
```

  
  
  
**2)and this is client app in b4j / b4x :**   
  

```B4X
Sub mqtt_Connected(Success As Boolean)  
  
    If Success Then  
  
        Log("✅ Successfully connected to MQTT Broker")  
  
          
  
        ' Always set PushTopic correctly with the username  
  
        PushTopic = BrokerName&"/push/"&Labelusername.Text  
  
        Log($"Setting PushTopic to: ${PushTopic}"$)  
  
          
  
        ' Subscribe to personal push topic  
  
        mqtt.Subscribe(PushTopic, 1)  
  
        Log($"📱 Subscribed to push topic: ${PushTopic}"$)  
  
          
  
        ' Subscribe to broadcast messages  
  
        mqtt.Subscribe(BroadcastTopic, 1)  
  
        Log($"📢 Subscribed to broadcast topic: ${BroadcastTopic}"$)  
  
          
  
        Log("Push Receiver - " & Labelusername.Text & " (Connected)")  
  
    Else  
  
        Log("❌ Failed to connect to MQTT Broker: " & LastException.Message)  
  
    End If  
  
End Sub  
  
  
  
  
  
  
  
Sub mqtt_messagearrived(Topic As String, Payload() As Byte)  
  
    Log($"Message arrived on topic: ${Topic}"$)  
  
    Log($"PushTopic variable: ${PushTopic}"$)  
  
    Log($"Labelusername.Text: ${Labelusername.Text}"$)  
  
'    Log($"TargetUsername: ${TargetUsername}"$)  
  
    Log($"Topic matches PushTopic: ${Topic = PushTopic}"$)  
  
    Log($"Topic matches Labelusername: ${Topic = ("fetsync/push/" & Labelusername.Text)}"$)  
  
      
  
    ' Handle personal push messages  
  
    If Topic = PushTopic Then  
  
        Try  
  
            Dim messageMap As Map = serializator.ConvertBytesToObject(Payload)  
  
              
  
            Dim title As String = messageMap.GetDefault("title", "new message")  
  
            Dim body As String = messageMap.GetDefault("body", "you have a message ")  
  
              
  
            Log($"🔔 PUSH NOTIFICATION RECEIVED:"$)  
  
            Log($"   Title: ${title}"$)  
  
            Log($"   Body: ${body}"$)  
  
              
  
            ' Store the message  
  
            Dim pushMessage As Map  
  
            pushMessage.Initialize  
  
            pushMessage.Put("title", title)  
  
            pushMessage.Put("body", body)  
  
            pushMessage.Put("timestamp", DateTime.Now)  
  
            pushMessage.Put("read", False)  
  
              
  
            PushMessages.Add(pushMessage)  
  
              
  
            ' Update badge count  
  
            UpdateBadgeCount  
  
              
  
            ' Show notification popup for testing  
  
'            xui.MsgboxAsync(body, title)  
  
              
  
        Catch  
  
            Log("❌ Error processing push message: " & LastException.Message)  
  
        End Try  
  
          
  
        ' Handle broadcast messages  
  
    Else If Topic = BroadcastTopic Then  
  
        Try  
  
            Dim messageMap As Map = serializator.ConvertBytesToObject(Payload)  
  
              
  
            If messageMap.GetDefault("type", "") = "broadcast" Then  
  
                Dim content As String = messageMap.Get("content")  
  
                  
  
                Log($"📢 BROADCAST RECEIVED: ${content}"$)  
  
                  
  
                ' Store broadcast as a message  
  
                Dim broadcastMessage As Map  
  
                broadcastMessage.Initialize  
  
                broadcastMessage.Put("title", "important")  
  
                broadcastMessage.Put("body", content)  
  
                broadcastMessage.Put("timestamp", DateTime.Now)  
  
                broadcastMessage.Put("read", False)  
  
                broadcastMessage.Put("type", "broadcast")  
  
                  
  
                PushMessages.Add(broadcastMessage)  
  
                  
  
                ' Update badge count  
  
                UpdateBadgeCount  
  
                  
  
                ' Optionally show notification popup  
  
'                xui.MsgboxAsync(content, "important")  
  
            End If  
  
              
  
        Catch  
  
            Log("❌ Error processing broadcast message: " & LastException.Message)  
  
        End Try  
  
          
  
    Else  
  
        Log($"❓ Unknown topic: ${Topic}"$)  
  
    End If  
  
End Sub  
  
  
  
  
  
  
  
Private Sub UpdateBadgeCount  
  
    ' Only update if components are initialized  
  
    If Not(PushMessages.IsInitialized) Then  
  
        Log("PushMessages not initialized")  
  
        Return  
  
    End If  
  
      
  
    If Not(AS_Badges1.IsInitialized) Then  
  
        Log("AS_Badges1 not initialized")  
  
        Return  
  
    End If  
  
      
  
    If Not(Labelpushnotif.IsInitialized) Then  
  
        Log("Labelpushnotif not initialized")  
  
        Return  
  
    End If  
  
      
  
    ' Count unread messages  
  
    BadgeCount = 0  
  
    For Each msg As Map In PushMessages  
  
        If msg.Get("read") = False Then  
  
            BadgeCount = BadgeCount + 1  
  
        End If  
  
    Next  
  
      
  
    ' Update badge display  
  
    If BadgeCount > 0 Then  
  
        Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties  
  
        BadgeProperties.BackgroundColor = xui.Color_Red  
  
        BadgeProperties.Orientation = AS_Badges1.Orientation_TopRight  
  
        AS_Badges1.SetBadge2(Labelpushnotif, BadgeCount, BadgeProperties)  
  
    Else  
  
        ' Do not use RemoveBadge if it's not accessible  
  
        ' Rely on AutoRemove to hide the badge when count is 0  
  
        AS_Badges1.AutoRemove = True  
  
        ' Optionally, set badge to 0 to ensure it's hidden  
  
        Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties  
  
        BadgeProperties.BackgroundColor = xui.Color_Red  
  
        BadgeProperties.Orientation = AS_Badges1.Orientation_TopRight  
  
        AS_Badges1.SetBadge2(Labelpushnotif, 0, BadgeProperties)  
  
    End If  
  
      
  
    Log($"Badge count updated: ${BadgeCount} unread messages"$)  
  
End Sub  
  
  
  
  
  
Private Sub MarkAllMessagesAsRead  
  
    If PushMessages.IsInitialized Then  
  
        For Each msg As Map In PushMessages  
  
            msg.Put("read", True)  
  
        Next  
  
        UpdateBadgeCount  
  
        Log("All messages marked as read")  
  
    Else  
  
        Log("PushMessages not initialized - cannot mark as read")  
  
    End If  
  
End Sub  
  
  
  
  
  
  
  
  
  
  
  
Sub mqtt_Disconnected  
  
    Log("🔌 Disconnected from MQTT Broker")  
  
    MainForm.Title = "Push Receiver - " & Username & " (Disconnected)"  
  
      
  
    ' Auto-reconnect after 10 seconds  
  
    Sleep(10000)  
  
    Log("🔄 Attempting to reconnect…")  
  
    mqtt.Connect2(mo)  
  
End Sub
```

  
  
  
not that in client app you must add these library ( AS\_FloatingActionMenu , AS\_Badges, Jxui , JRandomaccesfiles , Jnetwork,Jmqtt)  
and in server app ( Jxui , JRandomaccesfiles , Jnetwork,Jmqtt)  
  
this is label click even ( you can do it with button or any other b4xview)  
  
  

```B4X
Private Sub Labelpushnotif_MouseClicked (EventData As MouseEvent)  
    DigitalFont3 = xui.CreateFont(fx.LoadFont(File.DirAssets, DigitalFontTTF, 12), 12)  
    FloatingActionMenu.Initialize(Me, "FloatingActionMenu", MainForm.RootPane) ' Adjust parent view as needed  
    FloatingActionMenu.Color = xui.Color_White  
    FloatingActionMenu.ItemProperties.SeperatorVisible = True  
    FloatingActionMenu.ItemProperties.xFont=DigitalFont3  
    FloatingActionMenu.TextColor = xui.Color_Black     ' Add messages to the menu  
    If PushMessages.IsInitialized = False Or PushMessages.Size = 0 Then  
        FloatingActionMenu.AddItem("no push message ",<<icon as you want >> , -1)  
    Else  
        Dim maxMessages As Int = Min(5, PushMessages.Size)  
        For i = PushMessages.Size - 1 To PushMessages.Size - maxMessages Step -1  
            Dim msg As Map = PushMessages.Get(i)  
            Dim msgt As String = msg.Get("msgt")  
            Dim msgb As String = msg.Get("msgb")  
            Dim isRead As Boolean = msg.Get("read")  
            Dim displayText As String = msgb  
            If displayText.Length > 30 Then  
                displayText = displayText.SubString2(0, 30) & "…"  
            End If  
            If Not(isRead) Then  
                displayText = "🔴 " & displayText  
            Else  
                displayText = "⚪ " & displayText  
            End If  
            FloatingActionMenu.AddItem(displayText,<<icon as you want >> , i)  
        Next  
       FloatingActionMenu.AddItem("make all readed ",<<icon as you want >>,  -2)  
    End If  
    Dim Height As Float = FloatingActionMenu.ItemProperties.Height * FloatingActionMenu.Size  
    Dim Left As Float = Labelpushnotif.Left  
    Dim Top As Float = Labelpushnotif.Top + Labelpushnotif.Height  
    FloatingActionMenu.ShowPicker(Left, Top, 250dip, Height)  
    FloatingActionMenu.OpenOrientation = FloatingActionMenu.OpenOrientation_BottomTop  
    Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)  
    Select Item.Value  
        Case -1 ' No notifications  
            Log("No notifications")  
        Case -2 ' Mark all as read  
            MarkAllMessagesAsRead  
        Case Else ' Specific message clicked  
            If Item.Value >= 0 And Item.Value < PushMessages.Size Then  
                Dim msg As Map = PushMessages.Get(Item.Value)  
                msg.Put("read", True) ' Mark as read  
                Dim msgt As String = msg.Get("msgt")  
                Dim msgb As String = msg.Get("msgb")  
                xui.MsgboxAsync(msgb,msgt)  
                UpdateBadgeCount  
            End If  
    End Select  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/165049)  
  
also you must add textfield or button as name in code or change it in code , i've use as badge in label named Labelpushnotif ,   
- image is from my app   
\* you can test it and any quastion i'm here ..  
\* you must subscribe to any broker service .  
\* you must create a layout as you want using name in code or change it .  
  
  
**Next Topic : using mqtt chat with imogies in message and send imeges between users in room whithout affecting broker** 