### DropBox Storage Class by Robert Valentino
### 10/03/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168910/)

In same form of Koofr storage class I did DropBox now I can bop from one to another  
  

```B4X
'            Public        DropBoxToken    As String  = <your drop box DropBoxToken>  
              
            Dim DropBox As cDropBox  
              
            DropBox.Initialize(DropBoxToken) ' your token here  
  
            ' Upload  
            'Dim ok As Boolean = Dropbox.UploadFile(File.DirRootExternal, "test.txt", "/test.txt")  
            'Log(ok)  
  
            ' Download  
            'ok = Dropbox.DownloadFile("/test.txt", File.DirRootExternal, "downloaded.txt")  
            'Log(ok)  
  
            ' List files  
            wait for (DropBox.ListFiles("/BBs/BBsViewer")) Complete(files As List)  
              
'            Dim files As List = Dropbox.ListFiles("")  
              
            For Each DBFile As cDropBoxListFileItem In files  
                   Log($"DBFile: ${DBFile.Name}  ${IIf(DBFile.IsDir, "Is Directory", DBFile.LastModified)}"$)  
            Next  
              
            wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)  
              
            Log(IIf(Exists, "Directory Exists", "Does Not Exists"))  
              
            If  Exists = False Then  
                wait for (DropBox.CreateDirectory("/BBs")) Complete(Success As Boolean)  
              
                If  Success Then  
                    wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)  
              
                    Log(IIf(Exists, "Directory Exists", "Does Not Exists"))                 
                End If  
            End If  
  
            wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)  
              
            Log(IIf(Exists, "Directory Exists", "Does Not Exists"))  
  
            If  Exists = False Then  
                wait for (DropBox.CreateDirectory("/BBs/BBsViewer")) Complete(Success As Boolean)  
              
                If  Success Then  
                    wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)  
              
                    Log(IIf(Exists, "Directory Exists", "Does Not Exists"))                 
                End If  
            End If  
  
            ' Delete  
            'ok = Dropbox.DeleteFile("/test.txt")  
            'Log(ok)
```