### Daytime-depending event (here playing MP3-file) by GMan
### 10/24/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/172361/)

For one of my Apps (its for my girlie) i made a Welcome-Option, so every time she starts it there was a (nice) announcement.  
Women like these stuff :cool::rolleyes:  
  
i enhanced it a bit to play one Sound for every hour  
  
The soundfiles have to be in a "/mp3" folder in the objetcs folder.  
  

```B4X
    Dim MP As MediaPlayer  
    If DateTime.Time(DateTime.Now).StartsWith(8) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_morgen.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(9) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_morgen.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(10) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_morgen.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
        Log("Morgens " & DateTime.Time(DateTime.Now))  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(11) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_morgen.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
        Log("Morgens " & DateTime.Time(DateTime.Now))  
    End If  
   
    If DateTime.Time(DateTime.Now).StartsWith("12") Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","mahlzeit.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
  
    If DateTime.Time(DateTime.Now).StartsWith(13) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_tag.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
   
    If DateTime.Time(DateTime.Now).StartsWith(14) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_tag.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(15) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_tag.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(16) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","kaffeezeit.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(17) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","guten_tag.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
   
    If DateTime.Time(DateTime.Now).StartsWith(18) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","zeit_fuer_das_abendessen.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(19) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","Guten_Abend.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(20) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","Guten_Abend.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(21) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","Guten_Abend.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If  
    If DateTime.Time(DateTime.Now).StartsWith(22) Then  
        MP.Initialize("MP",xui.FileUri(File.DirApp & "/mp3","gute_nacht.mp3"))  
        MP.Volume=100  
        MP.Play  
        MP.Volume = 22  
    End If
```

  
  
The voice is from ChatGPT, command: Create a human voice file which says: Good Morning  
After creating, download it and save in the /mp3-folder in Objects.  
  
Then replace the filename with the one you named and downloaded it