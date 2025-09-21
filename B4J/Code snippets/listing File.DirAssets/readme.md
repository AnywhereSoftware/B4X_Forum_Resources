### listing File.DirAssets by Daestrum
### 09/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168690/)

Normally if you try and do  

```B4X
Log(File.ListFiles(File.DirAssets))
```

  
  
you get message cant list DirAssets  
  

```B4X
Dim currentFilesFolder = File.DirApp.Replace("Objects","Files")  
Log(File.ListFiles(currentFilesFolder))
```

  
  
Seems to work fine (also for saving to the directory too in debug)  
  
Probably a good reason not to do it though.