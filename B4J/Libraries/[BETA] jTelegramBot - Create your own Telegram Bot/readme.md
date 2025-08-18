### [BETA] jTelegramBot - Create your own Telegram Bot by DonManfred
### 01/09/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/103821/)

jTelegramBot is a partially wrapper build on [this github project](https://github.com/Eng-Fouad/JTelegramBot).  
> This project is licensed under The MIT License (MIT). See [LICENSE](https://github.com/Eng-Fouad/JTelegramBot/blob/master/LICENSE) for more details.

  
Note that the development has stopped. If you miss something in the lib you need to add it by yourself. The Source is attached to this post.  
  
links about Telegram Bots  
<https://core.telegram.org/bots>  
  
**JTelegramBot  
Author:** DonManfred (Wrapper)  
**Version:** 0.31  
  
**Setup:**  
- To get the Example running you first need to adapt the Initialize line with your Bots Name and ApiToken.  

```B4X
Sub AppStart (Args() As String)  
    jtb.Initialize("JTB","yourbotname","youtbottoken")  
    glmap.Initialize  
    jtb.startAsync  
    StartMessageLoop  
End Sub
```

  
- The Example is using Static Filenames for the Document, MP3, Photo, Sticker send.  
Make sure to adapt the path and Filenames to match Files you want to use.  
  

```B4X
    If message.Text = "/buttons" Then  
        Dim mark As InlineKeyboardMarkup  
        mark.initialize(jtb.CreateDummyKeyboard)  
        Dim buttons As Message = jtb.sendMessage(jtb.byId(from.Id),"Click the Button!","MARKDOWN",False,False,message.MessageId,mark)  
        glmap.Put(buttons.MessageId,buttons)  
    else If message.Text = "/location" Then  
        jtb.sendChatAction(jtb.byId(from.Id),jtb.ChatActionFIND_LOCATION)  
        jtb.sendLocation(jtb.byId(from.Id),50.8337006,6.441118,False,message.MessageId,Null)  
    else If message.Text = "/url" Then  
        jtb.sendMessage(jtb.byId(from.Id),"[jTelegramBot Thread](https://www.b4x.com/android/forum/threads/jtelegrambot.103778/#post-650611)","MARKDOWN",False,False,message.MessageId,Null)  
    else If message.Text = "/plainurl" Then  
        bld.sendMessage(chat.Id,"Link without Preview [jTelegramBot Thread](https://www.b4x.com/android/forum/threads/jtelegrambot.103778/#post-650611)",message.MessageId,False,True,Null,jtb.parsemodeMARKDOWN)  
    else If message.Text = "/text" Then  
        jtb.sendMessage(jtb.byId(from.Id),$"Testtext <b>Bold</b>, <i>Italic</i>  
    new row…"$,"HTML",True,False,message.MessageId,Null)  
    else If message.Text = "/document" Then  
        jtb.sendChatAction(jtb.byId(from.Id),jtb.ChatActionUPLOAD_DOCUMENT)  
        jtb.sendDocument(jtb.byId(from.Id),jtb.MediaByFile(File.DirApp,"mydocument.zip"),"DocumentCaption",False,message.MessageId,Null)  
    else If message.Text = "/photo" Then  
        jtb.sendChatAction(jtb.byId(from.Id),jtb.ChatActionUPLOAD_PHOTO)  
        jtb.sendPhoto(jtb.byId(from.Id),jtb.MediaByFile(File.DirApp,"myimage.png"),"DocumentCaption",False,message.MessageId,replbld.forceReply)  
    else If message.Text = "/audio" Then  
        jtb.sendChatAction(jtb.byId(from.Id),jtb.ChatActionUPLOAD_VIDEO)  
        jtb.sendAudio(jtb.byId(from.Id),jtb.MediaByFile(File.DirApp,"myaudio.mp3"),223,"Fleedwood Mac","Eyes of the World",False,message.MessageId,replbld.forceReply)  
    else If message.Text = "/sticker" Then  
        jtb.sendSticker(jtb.byId(from.Id),jtb.MediaByFile(File.DirApp,"mysticker.webp"),False,message.MessageId,Null)  
    else If message.Text = "/start" Then  
        jtb.sendMessage(jtb.byId(from.Id),$" Hello ${chat.Username}  
`Command   | Result  
———-|————————-  
/location | Returns a Locationobject  
/document | Returns a Document  
/photo    | Returns a Photo  
/audio    | Returns a Audiofile  
/url      | Returns a URL with Preview  
/plainurl | Returns a URL without Preview  
/buttons  | Shows some buttons To Click on  
`  
Thank you For choosing Me :-)"$,"MARKDOWN",False,False,message.MessageId,Null)
```

  
  
In this example you need to replace the following Filereferences:  
- mydocument.zip  
- myimage.png  
- myaudio.mp3  
- mysticker.webp  
  
Due to the Size of the needed Additional JARs they can be downloaded  
[[SIZE=7]HERE[/SIZE]](https://www.dropbox.com/sh/vis9hve1zoo3nwt/AAAaqz2aLQaU5CnDr3RkQNE1a?dl=0).  
  
[SIZE=5]For any Question/Issue you have please [Create a new Thread in the B4J Questionsforum](https://www.b4x.com/android/forum/forums/b4j-questions.54/).[/SIZE]