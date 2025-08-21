### get all image folders (path) by Alexander Stolte
### 06/01/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/118500/)

This code runs on my phone in release with 156ms. And i have over 1k folders and over 10k images.  
  

```B4X
    Dim tmp_lst As List : tmp_lst.Initialize     
    GetAllFolders(tmp_lst,File.DirRootExternal,File.DirRootExternal)  
      
    For Each image_path As String In tmp_lst  
        Log(image_path)  
    Next
```

  
  

```B4X
'https://www.b4x.com/android/forum/threads/recursive-directorystructures-and-what-to-do-with-this-filelist.40560/#content  
Public Sub GetAllFolders(tmp_lst As List,folder As String,root_path As String)  
    Dim lst As List = File.ListFiles(folder)  
    For i = 0 To lst.Size - 1  
        If File.IsDirectory(folder,lst.Get(i)) Then  
            Dim v As String = folder&"/"&lst.Get(i)  
            If FolderHasImages(v) = True Then  
                tmp_lst.Add(v.SubString(root_path.Length+1))  
                GetAllFolders(tmp_lst,v,root_path)  
            End If  
        End If  
    Next  
End Sub  
  
Private Sub FolderHasImages(folder As String) As Boolean  
    For Each tmp_file As String In File.ListFiles(folder)  
        If tmp_file.EndsWith(".jpg") Or tmp_file.EndsWith(".jpeg") Or tmp_file.EndsWith(".png") Or tmp_file.EndsWith(".gif") Or tmp_file.EndsWith(".bmp") = True Then Return True  
    Next  
    Return False  
End Sub
```