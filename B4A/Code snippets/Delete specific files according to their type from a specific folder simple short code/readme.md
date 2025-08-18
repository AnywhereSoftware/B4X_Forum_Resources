### Delete specific files according to their type from a specific folder simple short code by AlfaizDev
### 06/20/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141298/)

```B4X
Dim Dir As String=File.DirInternal  
For Each n As String In File.ListFiles(Dir)  
        Log(n)  
        If     n.Contains(".pdf") Then  
            If File.Exists(Dir,n) Then  
                File.Delete(Dir,n)  
                Log("del")  
            End If  
        End If  
    Next
```