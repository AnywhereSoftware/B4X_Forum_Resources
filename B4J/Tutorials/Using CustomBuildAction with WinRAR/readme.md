### Using CustomBuildAction with WinRAR by aeric
### 01/25/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137900/)

We can use *#CustomBuildAction* to archive some files and folders into a *ZIP* or *RAR* file (if you have *WinRAR* installed).  
  

```B4X
#If RELEASE  
#CustomBuildAction: 2, C:\Program Files\WinRAR\WinRAR.exe, a upload.zip www *.jar *.ini *.db help.html help.js comments.txt  
#End If
```

  
  
You can change *upload.zip* to other file name such as *publish.rar* and WinRAR will automatically archive the file using the format specified in the extension.  
You may however explicitly specify the file format using "*-afzip*" for zip file but it is optional.  
  
**RAR** format produces a bit **smaller file size** and allows us to **add comments** to the archive from a text file.  
  

```B4X
#If RELEASE  
#CustomBuildAction: 2, C:\Program Files\WinRAR\WinRAR.exe, a -afrar publish.rar www *.jar *.ini *.db help.html help.js -czcomments.txt  
#End If
```

  
  
You may want to read the WinRAR manual for the full commands list.  
  
Thanks to [USER=12970]@tchart[/USER] for a great tutorial on CustomBuildAction for B4J  
<https://www.b4x.com/android/forum/threads/using-custombuildaction-to-your-advantage.72945/>