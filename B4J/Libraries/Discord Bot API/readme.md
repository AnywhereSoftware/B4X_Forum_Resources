### Discord Bot API by Lieutenant-AMD
### 12/12/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/112107/)

It is a warpper of the [Javacord](https://github.com/Javacord/Javacord) library which allows to control a Discord bot, it is not finished i would add functions, objects and events.  
  
Here is an example of what can currently do:  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private Bot As BotDiscordAPI_Bot  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    'MainForm.RootPane.LoadLayout("Layout1") 'Load the layout file.  
    MainForm.Show  
    'Bot.Initialize("Bot", "NjUxNTA5NTYyMTY3MjYzMjMy.XewVgg.47FBDt5BjhbhgHGHF565GY") Replace with the good token!  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
Sub Bot_connected (InvitationLink As String)  
    Log("-")  
    Log("Bot invitation link: " & InvitationLink)  
    Log("-")  
End Sub  
  
Sub Bot_new_message (Message As BotDiscordAPI_Message, Channel As BotDiscordAPI_Channel, Author As BotDiscordAPI_Author)  
    If Message.GetText = "!ping" Then  
        Channel.SendMessage("pong")  
    Else If Message.GetText = "!PinMe" Then  
        Message.Pin  
    Else If Message.GetText = "!AddMeRole" Then  
        'Author.AddRole("654312413503553556") Replace with the good ID!  
    Else If Message.GetText = "!RemoveMeRole" Then  
        'Author.RemoveRole("654312413503553556") Replace with the good ID!  
    Else If Message.GetText = "!WhoAmI" Then  
        Channel.SendMessage("You are " & Author.GetName & " and your avatar is " & Author.GetAvatarUrl)  
    Else If Message.GetText = "!KickMe" And Author.IsServerAdmin = False Then  
        Author.Kick  
    Else If Message.GetText = "!BanMe" And Author.IsServerAdmin = False Then  
        Author.Ban  
    End If  
    
    If Author.IsThisBot Then  
        'Message.AddReaction("")  
    Else If Author.IsServerAdmin Then  
        'Message.AddReaction("")  
    Else '  
        'Message.AddReaction("")  
    End If  
End Sub
```

  
  
Download here: <https://drive.google.com/file/d/10_w7RcfWcVBl8foUD9fFY1nyYVWRcXpT/view?usp=sharing>