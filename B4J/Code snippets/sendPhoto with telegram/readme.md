### sendPhoto with telegram by jinyistudio
### 09/27/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/134628/)

:oops: Can't try it with httpjob, so use curl instead, because raspberry pi/linux can also use this command :rolleyes:  
  

```B4X
    Dim url As String = $"https://api.telegram.org/bot${pToken}/sendPhoto"$    
    Dim shl As Shell  
    shl.Initialize("TeleImage", "curl.exe", Array As String(url,"-F",$"chat_id=${chatid}"$,"-F",$"photo=@${imgDir}\${imgName}"$))  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(-1)
```