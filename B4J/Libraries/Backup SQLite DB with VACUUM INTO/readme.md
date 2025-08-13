### Backup SQLite DB with VACUUM INTO by Chris2
### 01/08/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/145313/)

Less of a tutorial, more to point out another option which doesn't seem to have a mention anywhere on here yet….  
  
I was searching for options to create a backup copy of an SQLite database. There are already options detailed [here](https://www.b4x.com/android/forum/threads/backup-dump-sqlite-tables-via-jshell-bat-file.90415/#content), and [here](https://www.b4x.com/android/forum/threads/class-clssqlitebackups.39523/#content), for example.  
But another option that seemed quite attractive was to use VACUUM INTO, as detailed on sqlite.org at <https://www.sqlite.org/lang_vacuum.html>  
  
The bit that stood out to me was;  
> The VACUUM command with an INTO clause is an alternative to the [backup API](https://www.sqlite.org/backup.html) for generating backup copies of a **live database**

It works when the database is open, with live \*.wal files for example, and handily produces just a single backup file that's been shrunk to its minimum size.  
  
Usage is pretty simple with the SQL library:  

```B4X
Dim filePath As String = "C:\Database"  
Dim fileName As String = "myDB.db"  
Dim backupPath As String = "C:\DBBackup\myDB-backup.db"      'backupPath must include the filename  
  
Dim sql As SQL  
sql.InitializeSQLite(filePath, fileName, False)  
sql.ExecNonQuery2("VACUUM INTO ?", Array(backupPath))
```

  
  
Notes:  
1. VACUUM INTO requires SQLite version 3.27.0 or later ([USER=2806]@Claudio Oliveira[/USER] handily keeps a list of the latest SQLite JDBC library versions [here](https://www.b4x.com/android/forum/threads/sqlite-jdbc-library-version-updates.133792/#content))  
2. VACUUM can not be executed from within a transaction.