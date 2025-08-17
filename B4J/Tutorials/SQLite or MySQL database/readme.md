### SQLite or MySQL database by peacemaker
### 10/12/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/155180/)

1. For any project where a database is required - it's very important to have possibility [to see the database data](https://www.b4x.com/android/forum/threads/build-sql-terminal-into-app-how-better.154353/), to debug the app.
2. If the app is used on a remote server host, and the database is getting bigger and bigger - it's not comfortable to see file-based SQLite database, as file copying is needed any time when changed data.
3. Server database like MySQL, MariaDB can be explored by web-db-managment tools, like "phpMyAdmin", that requires to have a web-server and PHP installed, configured, db user rights and user privileges done…
4. MySQL needs JDBC driver connector with connections pool, [DButils with extra settings](https://www.b4x.com/android/forum/threads/sql-dbutils-v-2-5-for-sqlite-and-mysql.155152/) and such network connection [may be broken any time](https://www.b4x.com/android/forum/threads/java-sql-sqlnontransientconnectionexception.155159). Security question is also here…

I tried all these steps and finally decided to use … just SQLite file database, but as the web-server and PHP are already installed - with the web-based database tool, like Adminer <https://www.adminer.org/> that supports SQLite db as well as default MySQL one.  
  
And now it's stable fast working, visible via a web-browser and does not need to setup many things…if to know all these on time.  
  
Attached the PHP-script set:  

- index.php - Adminer tool, latest version 4.8.1 (can be updated from the project web-site), used for access to MySQL or other web-base databases, with known host, db-name, login and password
- sqlite.php - script, where you need to setup the path to your SQLite db file and the password (with any login name), and use it for access to your server's SQLite database file
- other 2 files are dependencies of Adminer

Note: SQLite database name here is the full path to a file, like "/home/linuxusername/somefolder/db.sqlite3"  
![](https://www.b4x.com/android/forum/attachments/146797)  
![](https://www.b4x.com/android/forum/attachments/146796)