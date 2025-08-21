### [BANanoConnect] BANanoSQL+SQLite+MySQL+MSSQL Library by Mashiane
### 05/24/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/117956/)

Ola  
  
For a while I have been exploring backend connectivity using BANano for BANanoSQL, SQLite, MSSQL and MySQL. The purpose of this lib is for a one place for all your connectivity with these backends.  
  
This library as a couple of class utilities for connecting to BANAnoSQL, SQLite, MSSQL and MySQL. SQLite, MSSQL and MySQL use PHP.  
  
***BANAnoAlaSQLE*** - CRUD functionality for BANanoSQL  
***BANanoMSSQLE*** - CRUD functionality for MSSQL (uses PHP)  
***BANanoMySQLE*** - CRUD functionality for MySQL (uses PHP)  
***BANanoSQLite*** - CRUD functionality for SQLite (uses PHP)  
  
BANanoMSSQLE and BANanoMySQLE need a config file to be available in your Files. The file name is strictly **config.php.** This means you need to install PHP on your web server. You can do that using the [Web Platform Installer](https://www.microsoft.com/web/downloads/platform.aspx) on windows.  
  

```B4X
<?php  
const DB_HOST = 'localhost';  
const DB_NAME = 'expenses';  
const DB_USER = 'root';  
const DB_PASS = '';  
?>
```

  
  
In all instances of these classes, when Adding and Updating records to a database, you just need to pass a function the Map variable. This map variable should have the field names as keys. As these classes uses paramater queries, one also needs to pass the data types for those fields. The data types are **S**(string), **I**(integer), **B**(Blob) and **D**(double).  
  
With all these classes, you can run scripts to create a table, insert a record to a table, update the record and also delete records and also select all records from a table.  
  
PS:  
  
Other News: Read Only Access to embedded SQLite Databases  
  
[**BANanoSQLiteR**](https://www.b4x.com/android/forum/threads/bananosqliter-distributing-and-accessing-an-existing-sqlite-databases-part-2.118131/#post-739190) - this is usable in case one needs to embeds SQLite databases inside BANano through File > Import. This library is for cases where you want to use the database for READ ONLY purposes. It does not depend on PHP and you cannot persist your changes to it i.e. your changes are not permanent. This can be used to backup other databases as the database created can be downloaded using filesave.js. This library uses sql.js and filesave.js.