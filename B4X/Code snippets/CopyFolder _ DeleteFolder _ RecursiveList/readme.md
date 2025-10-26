###  CopyFolder / DeleteFolder / RecursiveList by Erel
### 10/19/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/69820/)

A recursive sub that copies a complete folder.  
  

```B4X
Private Sub CopyFolder(Source As String, targetFolder As String)  
   If File.Exists(targetFolder, "") = False Then File.MakeDir(targetFolder, "")  
   For Each f As String In File.ListFiles(Source)  
     If File.IsDirectory(Source, f) Then  
       CopyFolder(File.Combine(Source, f), File.Combine(targetFolder, f))  
       Continue  
     End If  
     File.Copy(Source, f, targetFolder, f)  
   Next  
End Sub
```

  
  
Note that it will not work with the assets folder. You can instead create a zip file and unpack it with the Archiver library.  
  
Recursively deletes a folder and its sub folders:  

```B4X
Sub DeleteFolder (folder As String)  
   For Each f As String In File.ListFiles(folder)  
       If File.IsDirectory(folder, f) Then  
           DeleteFolder(File.Combine(folder, f))  
       End If  
       File.Delete(folder, f)  
   Next  
End Sub
```

  
  

```B4X
'Recursively lists the files in the given folder.  
'Relative - Whether paths collected are relative to the given folder, or absolute.  
Public Sub RecursiveList(Folder As String, Relative As Boolean) As List  
    Dim res As List  
    res.Initialize  
    Dim Root As String = IIf(Relative, Folder, "")  
    Dim f As String = IIf(Relative, "", Folder)  
    RecursiveListHelper(Root, f, res)  
    Return res  
End Sub  
  
Private Sub RecursiveListHelper(Root As String, Folder As String, Result As List)  
    For Each f As String In File.ListFiles(File.Combine(Root, Folder))  
        Result.Add(File.Combine(Folder, f))  
        If File.IsDirectory(File.Combine(Root, Folder), f) Then  
            RecursiveListHelper(Root, File.Combine(Folder, f), Result)  
        End If  
    Next  
End Sub
```