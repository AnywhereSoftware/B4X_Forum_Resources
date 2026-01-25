### Set File Modified Date using JavaObject by aeric
### 01/20/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170069/)

```B4X
DateTime.DateFormat = "yyyy-MM-dd"  
DateTime.TimeFormat = "hh:mm a"  
Dim LastModifiedTime As Long = DateTime.DateTimeParse("2026-01-20", "10:05 pm")  
Dim jo As JavaObject  
jo.InitializeNewInstance("java.io.File", Array(File.Combine(File.DirApp, "dummy.txt")))  
jo.RunMethod("setLastModified", Array(LastModifiedTime))
```

  
  
Edit: Sorry, just found this code snippet actually already existed  
<https://www.b4x.com/android/forum/threads/file-copy-without-changing-the-time.47214/#post-292038>