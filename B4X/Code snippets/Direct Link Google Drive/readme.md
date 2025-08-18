###  Direct Link Google Drive by MarcoRome
### 07/04/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132247/)

Hi All.  
**For example, if you need to view a movie in exoplayer and the movie is on Google Drive, you can switch the Direct Link of Google Drive to Exoplayer ("uri").**  
Original link  
[MEDIA=googledrive]1VpD4ThDGw5xEjgjd32kECdgfcegklX-P[/MEDIA]  
  
Example code:  

```B4X
Dim link_drive As String = "https://drive.google.com/file/d/1VpD4ThDGw5xEjgjd32kECdgfcegklX-P/view?usp=sharing"  
    
    Dim splitta() As String = Regex.Split("/d/", link_drive)  
    Dim estrai As String = splitta(1)  
    Dim risultato_link() As String = Regex.Split("/", estrai)  
    Dim link_direct_drive As String = $"https://drive.google.com/uc?export=download&id=${risultato_link(0)}"$  
    Log(link_direct_drive)
```