### Folder size by LucaMs
### 03/05/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/159681/)

**[SIZE=6]Author: Erel[/SIZE]**  
  
Note that it ignores subfolders.  
  

```B4X
Sub SizeOfFilesInFolder(f As String) As Long  
   Dim total As Long  
   For Each filename As String In File.ListFiles(f)  
     If File.IsDirectory(f, filename) = False Then  
       total = total + File.Size(f, filename)  
     End If  
   Next  
   Return total  
End Sub
```