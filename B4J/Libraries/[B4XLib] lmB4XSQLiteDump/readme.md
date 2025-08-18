### [B4XLib] lmB4XSQLiteDump by LucaMs
### 03/29/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/139497/)

Based on [this @KMatle's tutorial](https://www.b4x.com/android/forum/threads/backup-dump-sqlite-tables-via-jshell-bat-file.90415/post-571558), this library allows you to dump SQLite database tables.  
  
I used this yesterday to create the import-export feature of my lmSnippetManager DB. Paying attention to which tables to import first, due to the relationships, it is sufficient to replace the instructions in the generated files:  
  
"CREATE TABLE" to "CREATE TABLE IF NOT EXISTS"  
"INSERT INTO" to "INSERT OR REPLACE INTO"  
"CREATE INDEX" to "CREATE INDEX IF NOT EXISTS"  
  
The library already contains the sqlite3.exe file and generates the necessary .bat file.  
  
  
[Its name can be misleading; it is only for B4J]