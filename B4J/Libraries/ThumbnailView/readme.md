### ThumbnailView by xulihang
### 03/12/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170565/)

I need to display images in thumbnail and manage them. I didn't find suitable libraries so I created one.  
  
![](https://www.b4x.com/android/forum/attachments/170544)  
  
Usage:  
  

```B4X
ThumbnailView1.Margin = 5  
ThumbnailView1.Padding = 5  
ThumbnailView1.RowNumber = 3  
ThumbnailView1.ColNumber = 3  
ThumbnailView1.Label = "{0}"  
ThumbnailView1.EnableThumbnailDatabase(File.DirApp,"thumbs.db")  
Dim imgDir As String = File.Combine(File.DirApp,"images")  
Dim filenames As List  
filenames = File.ListFiles(File.Combine(File.DirApp,"images"))  
ThumbnailView1.LoadThumbnails(imgDir,filenames)
```

  
  
You can specify the number of rows and columns, margin, padding and the image caption. If thumbnail database is enabled, it will store thumbnail images in a KeyValueStore.  
  
Versions:  
1.1.0 (2026-03-12): multiple selection with ctrl and shift and bugfixes  
1.0.0 (2026-03-11): Initial release