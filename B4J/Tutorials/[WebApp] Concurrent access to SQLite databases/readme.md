### [WebApp] Concurrent access to SQLite databases by Erel
### 11/21/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/39904/)

SQLite databases are very easy to use as they don't require any additional software or configuration.  
  
SQLite support for concurrent access is not comparable to server based databases such as MySQL and others.  
However they can still be perfect for small / medium solutions, especially if there aren't many writings (ExecNonQuery).  
  
B4J v2.00 adds support for concurrent access to SQLite databases. You need to follow these instructions:  
  
- Use a single SQL object that is shared by all classes. Don't use a ConnectionPool with SQLite database.  
- When you create the database you need to set the journal mode to wal:  

```B4X
sql.ExecQuerySingleResult("PRAGMA journal_mode = wal")
```

  
You only need to set the journal mode to wal once.  
Read more about wal mode: <https://www.sqlite.org/wal.html>  
  
This mode allows multiple readers and a single writer to access the database at the same time. B4J SQL library (when initialized with InitializeSQLite) will serialize writers access.  
  
- When writing to the database make sure to use transactions and always close the transaction: <http://www.b4x.com/b4j/help/jsql.html#sql_begintransaction>