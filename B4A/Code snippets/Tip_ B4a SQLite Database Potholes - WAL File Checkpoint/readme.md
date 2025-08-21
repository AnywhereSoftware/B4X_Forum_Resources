### Tip: B4a SQLite Database Potholes - WAL File Checkpoint by rgarnett1955
### 07/03/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/119750/)

Hi B4X'ers  
  
I just thought I'd post this tip to warn of a problem I came across when using an sqLite data base created and populated using sqLite Studio. The steps I used were.  
  

1. Created an sqLite db using sqLite Studio on Win 10 pc
2. Set the DB to use the Write Ahead Log journal method (WAL File)
3. Populated tables from csv files using sqLite Studio
4. Added this db to the files tab in b4a
5. Installed app on Android phone
6. Opened one of the tables - there were no records. Hmm!!

  
To cut a long story short, the problem was that the new record transactions had been committed to the database WAL file hadn't been written back to the main database file. As B4A only copies the main db file it didn't have the WAL file and so there was no data.  
  
To fix the problem I used the sqLite Expert Professional DB Manager to open the DB instead of using sqLite Studio. Sqlite expert does a write-back (checkpoint) into the main db when you close the program or close the DB from within the program. Another way would be to run the following query on the PC using sqLite Studio:  
  
 **PRAGMA** *schema.***wal\_checkpoint;**   
  
Do this before installing the app and you should pick up all of the data. The WAL file will most likely be deleted or at least have zero bytes.  
  
I don't know what happens if you don't use WAL. I always use WAL as it has performed well in all my apps.  
  
Best regards  
  
Rob