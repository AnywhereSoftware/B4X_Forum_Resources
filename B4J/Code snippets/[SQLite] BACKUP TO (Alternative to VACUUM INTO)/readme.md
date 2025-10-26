### [SQLite] BACKUP TO (Alternative to VACUUM INTO) by aeric
### 10/17/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169069/)

```B4X
SQL.ExecNonQuery("BACKUP TO " & BackupPath)
```

  
  
I tried online backup API using .backup but it doesn't work.  
I searched for jdbc method and the above command works even the database is in used.  
This method doesn't vacuum the database.  
  
I think RESTORE FROM should also work.