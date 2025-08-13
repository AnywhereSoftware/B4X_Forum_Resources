### B4J - GoogleTranslateDB by T201016
### 05/20/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/148060/)

Hello to all forum users,  
I am pleased to present my next project "**B4JGoogleTranslateDB**".  
  
It was created for my own needs of translating applications into other languages.  
Surely you will find many similar solutions on the forum,  
mine is as follows:  
  
Required Libraries:  
![](https://www.b4x.com/android/forum/attachments/142153)  
  
and a text file that contains lines with the text to be translated:  
![](https://www.b4x.com/android/forum/attachments/142154)  
The rest is intuitive I hope :)  
  
Application source code uses library (B4XCheckInternet v1.10)  
which is not freeware. :( It is modeled on the idea of [USER=51832]@LucaMs[/USER] with a similar name (*B4XCheckInternetLM*).  
*My library version has a different dialog that fits my application.*  
  
The source code also contains an example of using my translation method,  
i.e. Main.loc.Localize(…):  
  

```B4X
Sub TitleBarAndMoreRefresh  
    TitleBarCV1.setMinimizeIcon(Main.loc.Localize("Minimalizuj"))  
    TitleBarCV1.setMaximizeIcon(Main.loc.Localize("Maksymalizuj"))  
    TitleBarCV1.setCloseIcon(Main.loc.Localize("Zamknij"))  
    …
```

  
  
Regards  
  
If any of my posts were helpful, please consider a donation of any amount  
 [![](https://www.b4x.com/android/forum/attachments/btn_donate-png.133028/)](https://www.paypal.me/T201016).. or clicking the Like button would be appreciated too.