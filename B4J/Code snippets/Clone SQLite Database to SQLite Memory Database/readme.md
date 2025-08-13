### Clone SQLite Database to SQLite Memory Database by tchart
### 03/29/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/146489/)

This is a prototype I wrote a while back that takes a source SQLite database and clones it to another SQLite database - in this case an in memory SQLite database.  
  
The code is prety straight forward, initialize the source (from) and destination (to) SQLite databases and call the CopySQLiteDB sub.  
  
**NOTE this can be used to clone to a regular SQLite DB as well.**  
  

```B4X
    Dim src_db As SQL  
    Dim dest_db As SQL  
   
    src_db.InitializeSQLite(File.DirApp,"report.sqlite",False)  
    dest_db.InitializeSQLite("", ":memory:",True)  
   
    DBUtils.CopySQLiteDB(src_db,dest_db)
```

  
  
You can then use the dest\_db SQL object as per normal.