###  BCTextEngine - Create Named Link by Alexander Stolte
### 06/01/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118508/)

```B4X
Public Sub CreateNamedLink(name As String,url As String,color As String) As String  
    Return "" & name & ""  
End Sub
```

  
  

```B4X
bbcv.Text = "[Alignment=Center]" & "Bitte " & CreateNamedLink("Anmelden","https://yourniceurl","#2D8879") & "/" & CreateNamedLink("Registrieren","https://yourniceurl","#2D8879") & " um ein kommentar zu schreiben" & "[/Alignment]"
```

  
![](https://www.b4x.com/android/forum/attachments/95081)