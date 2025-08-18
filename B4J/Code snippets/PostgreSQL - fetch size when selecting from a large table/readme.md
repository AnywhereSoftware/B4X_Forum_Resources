### PostgreSQL - fetch size when selecting from a large table by Erel
### 09/14/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/134254/)

When making a select query, the PostgreSQL jdbc driver tries to get all results at once. This can lead to memory issues when there are many results.  
It is possible to set the cursor fetch size with this code:  

```B4X
Private Sub ExecQueryWithFetchSize(SQL As SQL, FetchSize As Int, Query As String, Args As List) As ResultSet  
    Dim connection As JavaObject = SQL.As(JavaObject).GetField("connection")  
    Dim statement As JavaObject = connection.RunMethod("prepareStatement", Array(Query))  
    statement.RunMethod("setFetchSize", Array(FetchSize))  
    If Args.IsInitialized Then  
        For i = 0 To Args.Size - 1  
            statement.RunMethod("setObject", Array(i + 1, Args.Get(i)))  
        Next  
    End If  
    Dim rs As ResultSet = statement.RunMethod("executeQuery", Null)  
    Dim ResultSetWrapper As JavaObject  
    ResultSetWrapper.InitializeStatic("anywheresoftware.b4j.objects.SQL$ResultSetWrapper").GetFieldJO("closePS") _  
        .RunMethod("put", Array(rs, statement))  
    Return rs  
End Sub
```

  
  
Note that you also need to create a transaction:  

```B4X
    postgres.BeginTransaction  
    Try  
    Dim rs As ResultSet = ExecQueryWithFetchSize(postgres, 200, "SELECT * FROM large_table")  
    Do While rs.NextRow  
       …  
    Loop  
    rs.Close  
    Catch  
     Log(LastException)  
    End Try  
    postgres.TransactionSuccessful
```

  
  
This is useful for a non-ui app. In a UI app you should use the async methods together with LIMIT and OFFSET (also possible in a non-ui app but is a bit more complicated).