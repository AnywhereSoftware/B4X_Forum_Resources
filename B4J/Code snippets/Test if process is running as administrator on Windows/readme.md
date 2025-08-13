### Test if process is running as administrator on Windows by Erel
### 02/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/159254/)

```B4X
Private Sub IsRunningAsAdmin As Boolean  
    Try  
        Dim f As String = GetEnvironmentVariable("SYSTEMDRIVE", "") & "\isadmin.txt"  
        File.WriteString(f, "", "test")  
        File.Delete(f, "")  
        Return True  
    Catch  
        Return False  
    End Try  
End Sub
```

  
  
A bit hacky but should work. Windows only.