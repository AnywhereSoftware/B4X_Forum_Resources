###  SQLite case insensitive searches with non-ASCII text by Erel
### 09/20/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122582/)

SQLite, without ICU extensions, doesn't include the information required to change the case of non-ASCII characters. This means that LIKE queries become case sensitive.  
  
A possible workaround if you want the query to be case insensitive, is to expand the search term yourself with all possible permutations.  
  

```B4X
Sub CreateCaseInsensitiveArgs (col As String, q As String, args As List) As String  
    Dim sb As StringBuilder  
    sb.Initialize  
    For i = 0 To Power(2, q.Length) - 1  
        If i > 0 Then sb.Append(" OR ")  
        sb.Append(col).Append(" LIKE ?")  
    Next  
    CreateCaseHelper("", q.ToLowerCase, args)  
    Return sb.ToString      
End Sub  
  
Sub CreateCaseHelper (prefix As String, q As String, args As List)  
    If q.Length = 0 Then  
        args.Add("%" & prefix & "%")  
        Return  
    End If  
    Dim f As String = q.SubString2(0, 1)  
    CreateCaseHelper(prefix & f, q.SubString(1), args)  
    CreateCaseHelper(prefix & f.ToUpperCase, q.SubString(1), args)  
End Sub
```

  
  
Usage example:  

```B4X
Sub mmSearch  
    Dim args As List  
    args.Initialize  
    Dim likes As String = CreateCaseInsensitiveArgs("col1", "Query", args)  
    Log(args)  
    Dim Cursor As ResultSet = SQL.ExecQuery2("SELECT * FROM table1 WHERE " & likes, args)  
    If Cursor.IsInitialized Then  
        Do While Cursor.NextRow  
            Log(Cursor.GetString("col1"))  
        Loop  
    End If  
    Cursor.Close  
End Sub
```

  
Full example here: <https://www.b4x.com/android/forum/threads/sqlite-like-case-insensitive-for-not-english-letters.122556/#post-765771>  
  
It is not suitable for long terms as the number of permutations is 2^n.