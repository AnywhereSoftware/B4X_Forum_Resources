### minor fix to GoogleDrive API for folder names with apostrophes by Dave O
### 05/07/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130495/)

I've been using the GoogleDrive API (created by [USER=88827]@mw71[/USER] and updated by [USER=14167]@fredo[/USER]) to help my app back up files to Google Drive. Works well.  
  
However, I discovered that folder names with embedded apostrophes (e.g. **Dave's Note 10**) cause an error because the apostrophe is also used as a delimiter in the SearchForFolderID sub:  
  

```B4X
        H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _  
             Array As String("access_token", myAccessToken, _  
                             "corpora", "user", _  
                             "q",$"mimeType='application/vnd.google-apps.folder' and name='${SearchFolder}' and trashed=false"$))
```

  
  
Luckily, B4X smart string literals let us embed quotes, so I replaced the apostrophes around the SearchFolder with quotes and it now allows embedded apostrophes just fine:  
  

```B4X
        H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _  
             Array As String("access_token", myAccessToken, _  
                             "corpora", "user", _  
                             "q",$"mimeType='application/vnd.google-apps.folder' and name="${SearchFolder}" and trashed=false"$))
```

  
  
Hope this helps!