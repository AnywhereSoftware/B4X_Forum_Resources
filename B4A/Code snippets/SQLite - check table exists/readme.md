### SQLite - check table exists by Alexander Stolte
### 03/22/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/115243/)

Before we can insert items, we should check, whether the table exists.  
  

```B4X
Public Sub CheckTableExists(sql As SQL,DBName As String) As Boolean   
    If sql.ExecQuerySingleResult("SELECT count(*) FROM sqlite_master WHERE type='table' AND name ='" & DBName & "'") = 0 Then  
        Return False  
        Else  
        Return True  
    End If   
End Sub
```