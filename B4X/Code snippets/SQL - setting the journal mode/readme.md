###  SQL - setting the journal mode by Erel
### 11/21/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/136211/)

The modes are explained here: <https://www.sqlite.org/pragma.html#pragma_journal_mode>  
The two cases where it is important to set the journal mode:  
1. WAL - B4J server solutions: <https://www.b4x.com/android/forum/threads/webapp-concurrent-access-to-sqlite-databases.39904/#content>  
2. DELETE - when it is important that the database will be made of a single file.  
  

```B4X
sql.ExecQuerySingleResult("PRAGMA journal_mode = delete")  
Log("Current mode: " & sql.ExecQuerySingleResult("PRAGMA journal_mode"))
```