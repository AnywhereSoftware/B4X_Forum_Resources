### BANanoSQLiteR - Distributing and accessing an existing SQLite Databases - Part 2 by Mashiane
### 05/23/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/118131/)

Ola  
  
[**Download**](https://github.com/Mashiane/BANanoSQLiteR)  
  
[Part 1 is here.](https://www.b4x.com/android/forum/threads/banano-distributing-and-accessing-an-existing-sqlite-databases-part-1.102110/#content)  
  
At some stage we explored how one can distribute / embed SQLite database on their BANano app. These databases are mainly for read only access purposes where one just wants to display data.  
  
Here we explore part 2 of the tutorial, however now made into a library. This does not depend on PHP but just two js libs, sql.js and filesave.js.  
  
We are logging everything the demo does to console.log.  
  
[MEDIA=youtube]EiscaVqeHVI[/MEDIA]  
  
  
In this exercise, we open an existing database. Whatever changes we make to it will not be persisted, unless of course we download the file. We might even be able to use this to backup a BANanoSQL database.  
  
1. We will open the database. Ensure the database is loaded under your Files tab.  
2. We will create a table called users with auto increment fields.  
3. We will add some records to the users table.  
4. We will select and view all records from the users table.  
5. We will update an existing record.  
6. We will delete an existing record  
  
We will explore how we can create an in-memory db and then backup an existing BANanoSQL db to it and then download the content.  
  
Ta!