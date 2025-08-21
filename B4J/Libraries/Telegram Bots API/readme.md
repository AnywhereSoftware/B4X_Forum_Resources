### Telegram Bots API by somed3v3loper
### 04/08/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/66458/)

Hello all ,  
  
I started wrapping this project <https://github.com/pengrad/java-telegram-bot-api> a while ago after failing to make a multipart post that Telegram needs to send a photo :D  
the project seems to be huge so I wrapped only features I needed at the current time .  
I will try to keep this library updated with most requested features if any :D  
  
  
  
  
**[SIZE=7]Even newer :1.12 [/SIZE]**  
  
[SIZE=7]A new version with some features is released   
Thank you [kostefar](https://www.b4x.com/android/forum/members/kostefar.93248/) :)[/SIZE]  
  
  
**[SIZE=7]NEW : 1.06 :[/SIZE]**  
[SIZE=4]**I got busy so I almost stopped working on this library but for my own needs I updated it partially :D I don't remember my updates but If you wanted some feature that was missing , you might want to try this version .  
If the feature you are looking for is still missing , You can motivate me with a donation to implement it :)**[/SIZE]  
  
  
  
**[SIZE=4]NEW : 1.05 : [/SIZE]**  
[SIZE=7]Two new modifications :[/SIZE]  
1- Initialize method modified to accommodate timeout setting tele.Initialize(Token,EventName,connectTimeout,writeTimeout,readTimeout)  
an attempt to solve issue reported by  
[SIZE=4]**[u2005k](https://www.b4x.com/android/forum/members/u2005k.68032/)**[/SIZE]  
here <https://www.b4x.com/android/forum/threads/telegram-bots-api.66458/#post-432967>  
  
2- error event  

```B4X
Sub tele_error(error As String)  
    Log("FROM B4J: "&error)  
End Sub
```

not sure if it would work as it should :D  
  
  
[SIZE=3]**NEW : Version 1.03 : Just re wrapping a newer (not the latest) version of original library.  
I get timeout error but it might be due to partial block on Telegram here .  
Can someone please test?**[/SIZE]  
  
  
  
**SMMTeleBot  
Author:** SMM  
**Version:** 1.01  

- **Audio**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **duration As Integer**
- **fileId As String**
- **fileSize As Integer**
- **mimeType As String**
- **performer As String**
- **title As String**

- **Chat**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **firstName As String**
- **id As Long**
- **lastName As String**
- **title As String**
- **type As String**
- **username As String**

- **Contact**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **firstName As String**
- **lastName As String**
- **phoneNumber As String**
- **userId As Integer**

- **Document**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **fileId As String**
- **fileName As String**
- **fileSize As Integer**
- **mimeType As String**
- **thumb As CPhotoSize**

- **Location**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **latitude As Float**
- **longitude As Float**

- **Message**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **audio As CAudio**
- **caption As String**
- **channelChatCreated As Boolean**
- **chat As CChat**
- **contact As CContact**
- **date As Integer**
- **deleteChatPhoto As Boolean**
- **document As CDocument**
- **forwardDate As Integer**
- **forwardFrom As CUser**
- **from As CUser**
- **groupChatCreated As Boolean**
- **leftChatParticipant As CUser**
- **location As CLocation**
- **messageId As Integer**
- **migrateFromChatId As Long**
- **migrateToChatId As Long**
- **newChatParticipant As CUser**
- **newChatPhoto As CPhotoSize[]**
- **newChatTitle As String**
- **photo As CPhotoSize[]**
- **replyToMessage As CMessage**
- **sticker As CSticker**
- **supergroupChatCreated As Boolean**
- **text As String**
- **video As CVideo**
- **voice As CVoice**

- **PhotoSize**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **fileId As String**
- **fileSize As Integer**
- **height As Integer**
- **width As Integer**

- **SMMTeleBot**
Events:

- **\_updates** (updates As List)
- **sent** (result As Message)

- **Methods:**

- **GetUpdatesList** (offset As Int, limit As Int, timeout As Int)
- **Initialize** (Token As String, EventName As String)
- **rgetUpdatesList** (offset As Int, limit As Int, timeout As Int) **As List**
- **sendMessage** (chatId As String, MessageText As String)
- **sendPhoto** (chatId As String, folder As String, filename As String, caption As String, reply\_to\_message\_id As Integer, bForceReply As Boolean, bReplyKeyboardHide As Boolean)
- **sendVideo** (chatId As String, folder As String, filename As String, caption As String, reply\_to\_message\_id As Integer, bForceReply As Boolean, bReplyKeyboardHide As Boolean, duration As Int)

- **Sticker**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **fileId As String**
- **fileSize As Integer**
- **height As Integer**
- **thumb As CPhotoSize**
- **width As Integer**

- **Update**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **chosenInlineResult As ChosenInlineResult**
- **inlineQuery As InlineQuery**
- **message As Message**
- **updateId As Integer**

- **User**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **firstName As String**
- **id As Integer**
- **lastName As String**
- **username As String**

- **Video**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **duration As Integer**
- **fileId As String**
- **fileSize As Integer**
- **height As Integer**
- **mimeType As String**
- **thumb As CPhotoSize**
- **width As Integer**

- **Voice**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **duration As Integer**
- **fileId As String**
- **fileSize As Integer**
- **mimeType As String**

- **sendResponse**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **isOk As Boolean**
- **message As Message**

  
Extract all files inside archive to your Additional Libraries folder  
  
  

```B4X
Dim tele As SMMTeleBot  
tele.Initialize(smmtoken,"tele")  
  
tele.getUpdatesList(0,20,9000)  
  
Sub tele_updates(updates As List)  
    If updates.IsInitialized Then  
        For up = 0 To updates.Size-1  
            Dim u As Update =updates.Get(up)  
            Log(u.updateId)  
            Dim mmmm As Message =u.message  
            Log(mmmm.text&"this message was sent on"&DateTime.Date( DateUtils.UnixTimeToTicks( mmmm.date)))  
  
        Next  
    Else  
        Log("No updates")  
    End If  
  
End Sub  
Sub tele_sent(some As Message)  
  
    Log(some.IsInitialized)  
    If some.IsInitialized Then  
    Log(some.caption&" message sent: "&DateTime.Time(DateUtils.UnixTimeToTicks(some.date))&CRLF&some.video.duration)  
  
    Else  
        Log("Fail")  
    End If  
  
  
End Sub
```

  
  
It is still a work in progress please note that bugs and errors are very likely to happen :) If you got any problem or you think a feature should be ported please post it here or send me PM .