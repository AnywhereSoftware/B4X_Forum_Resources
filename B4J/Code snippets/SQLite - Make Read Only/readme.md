### SQLite - Make Read Only by tchart
### 09/02/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162877/)

Couldnt find this on the forum but if you need to force a SQLite database connection to be read only you can do the following.   
  

```B4X
    Dim DB As SQL  
    Dim jdbc_url As String = $"jdbc:sqlite:${File.Combine(File.DirApp,"test.db")}?open_mode=1"$  
    DB.Initialize("org.sqlite.JDBC",jdbc_url)  
      
    Try  
        DB.ExecNonQuery("CREATE TABLE table1 (col1 TEXT , col2 INTEGER, col3 INTEGER)")  
    Catch  
        Log("Database is read only")  
        Log(LastException)  
    End Try      
      
    DB.Close
```

  
  
You need to handle the exception which looks like this;  
  
**(SQLiteException) org.sqlite.SQLiteException: [SQLITE\_READONLY] Attempt to write a readonly database (attempt to write a readonly database)**