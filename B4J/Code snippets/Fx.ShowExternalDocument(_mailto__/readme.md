### Fx.ShowExternalDocument("mailto:"... by RauchG
### 03/11/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/128507/)

While searching for the Mailto String formatting, I found this tool.  
<https://mailto.now.sh/>  
  

```B4X
    Dim mMailAdress As String = "?"                                '"xxx@xxx.de"  
    Dim mMailSubject As String = "Einkauf" & "%20Real"            'Leerzeichen = %20  
    Dim mMailBody As String = "xxx%0A%0Aaaa%0A%0Abbb"            'Zeilenumbruch, 1x = %0A, 2x %0A%0A  
  
    Fx.ShowExternalDocument("mailto:" & mMailAdress & "subject=" & mMailSubject & "&body=" & mMailBody)
```