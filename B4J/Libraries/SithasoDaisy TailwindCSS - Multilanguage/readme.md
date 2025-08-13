### SithasoDaisy TailwindCSS - Multilanguage by MichalK73
### 03/05/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/159675/)

Hello.  
  
I guess sometimes there comes a time to make our application multilingual. This can be done by compiling the same project with the descriptions corrected to another language and placing it in separate locations on the server with the appropriate link.  
I really liked multilingualism in ABMaterial, where the code dynamically substituted descriptions in a given language.  
I know that for now there is no such possibility in SithasoDaisy TailwindCSS, so somehow I had to manage on my own temporarily.  
How did I do it ?  
Initially, the entire application is in English. So all descriptions have been embedded in this language.  
In pgIndex added  
  

```B4X
Sub Process_Globals  
    …  
    …  
    …  
    Public landuage As String = "English"  
    Public lang As Map  
    Public first As Boolean = True  
End Sub
```

  
  
I added SDUISelect with language selection on the 1st page. Then handling it:  

```B4X
Private Sub language_Change (item As String)  
    pgIndex.landuage = item  
    pgIndex.lang = banano.Await( banano.GetFileAsJSON($"./assets/${item.ToLowerCase}.json"$, Null))  
    pgIndex.first=True  
    lang_Change  
End Sub  
  
Private Sub lang_Change  
    adres.Caption = pgIndex.lang.Get("adres.Caption")  
    SDUILabel2.Caption =  pgIndex.lang.Get("SDUILabel2.Caption")  
    chReply.Caption = pgIndex.lang.Get("chReply.Caption")  
    btnSend.Caption = pgIndex.lang.Get("btnSend.Caption")  
    btnReply.Caption = pgIndex.lang.Get("btnReply.Caption")  
    btnhelp.Caption = pgIndex.lang.Get("btnhelp.Caption")  
      
End Sub
```

  
  
As you can see, I had to declare all GUI objects that have a language entry.  
Now I have prepared json files for a particular language and placed them in assets so that SDUISelect of a language change will load the data into pgIndex.lang as MAP.  

```B4X
{  
    "adres.Caption": "Enter the name or  token",  
    "SDUILabel2.Caption": "Type a message",  
    "chReply.Caption": "Awaiting response",  
    "btnSend.Caption": "Send message",  
    "btnReply.Caption": "Check the answer",  
    "btnhelp.Caption": "Help/About",  
    "kododbioru.Caption": "Enter the answer code",  
    "wiadomosc.Caption": "Message",  
    "btnreply.Caption": "Checkout",  
    "btnexit.Caption": "Write message"  
}
```

  
This is how I prepared other json for different languages.  
  
I added a function for each module from the GUI.  

```B4X
Private Sub language_Change  
    kododbioru.Caption = pgIndex.lang.Get("kododbioru.Caption")  
    wiadomosc.Caption =  pgIndex.lang.Get("wiadomosc.Caption")  
    btnreply.Caption = pgIndex.lang.Get("btnreply.Caption")  
    btnexit.Caption = pgIndex.lang.Get("btnexit.Caption")  
  
End Sub
```

  
And I called her up at the Show.  

```B4X
'start building the page  
private Sub BuildPage  
    …  
    …  
    language_Change  
    …  
    …  
End Sub
```

  
  
  

```B4X
'** DO NOT DELETE  
'start building the page, here you load layouts / code your app  
private Sub BuildPage  
    'load the page layout  
    banano.LoadLayout("#body", "homelayout")  
    btncheck.TextColor= "black"  
    language.Value = pgIndex.landuage  
    If pgIndex.first Then  
        lang_Change  
    End If  
    …  
    …  
  
End Sub
```

  
Finally, I added support for changing the language as you return to the 1st page. The first tag is there to load the language data once and not always after the page loads.  
  
How does it work ? You can take a look at my**[SIZE=6] [/SIZE]**[**[SIZE=6]LINK APLICATION[/SIZE]**](https://121212.best)