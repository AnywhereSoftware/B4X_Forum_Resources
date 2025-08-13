###  Get mime type by extension by Alexander Stolte
### 09/06/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/150330/)

If something is missing, I will gladly add the function.  

```B4X
Log(GetMimeTypeByExtension("jpg"))
```

  

```B4X
Public Sub GetMimeTypeByExtension(Extension As String) As String  
    Extension = Extension.Replace(".","").ToLowerCase  
    Select Extension  
        Case "jpg","png","gif","bmp","ico","svg","webp"  
            Return "image/" & Extension  
        Case "mp4", "avi", "mpeg", "wmv", "mov", "flv", "webm", "mkv"  
            Return "video/" & Extension  
        Case "mp3", "wav", "ogg", "m4a", "aac", "flac", "wma", "aiff"  
            Return "audio/" & Extension  
        Case Else  
            Log("unknown mime type")  
            Return ""  
    End Select
```