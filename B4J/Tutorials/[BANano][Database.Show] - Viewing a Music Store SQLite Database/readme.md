### [BANano][Database.Show] - Viewing a Music Store SQLite Database by Mashiane
### 04/13/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/129668/)

Ola  
  
As you might be aware, one has been busy working on [Database.Show](https://www.b4x.com/android/forum/threads/database-show-webapp-using-bvad3-source-code-for-sale-50-00-coming-soon.129198/#post-814932), a BANano+Vuetify Database Viewer, Documentor, CRUD thingy.  
  
We have just closed off one of the milestones, MySQL and to jump the wagon to SQLite before to go over to MSSQL, we thought it would be cool to showcase how one could view his/her music store Sqlite Database using Database.Show.  
  
We found a nifty back-end db on the net that seemed to cover most of what we wanted to showcase.  
  
1. Select a SQLite database.  
2. The complete schema of the database is read, this includes fields, indexes, foreign keys etc.  
3. One is able to view also the data contained in the database.  
4. One is able to export tables to PDF, Excel, [JSON, CSV - coming soon]  
5. Document the schema of each table to PDF.  
6. You can customize the look and feel of your UX via theming, e.g. rounded elements, shaped elements etc.  
  
Yes, it might not be a phpMyAdmin replacement, but its throwing a small punch. ;)  
  
  
[MEDIA=youtube]f8YPM9PTajI[/MEDIA]  
  
  
**You wanna test this out? Well, here we go, we have a WebApp for that.**  
  
1. Download the executable WebApp [here](https://github.com/Mashiane/Database.Show). If you want the source code, visit this [link](https://www.b4x.com/android/forum/threads/database-show-webapp-using-bvad3-source-code-for-sale-50-00-coming-soon.129198/#post-814932).  
2. In the assets folder, update the myconfig.php file to point to your MySQL backend.  
3. In the assets folder, update the config.properties file ServerIP to point to your webserver.  
4. Import the attached .sql file to your MySQL.  
5. Run the app from your WebServer.  
  
Have fun!  
  
BTW: This is still work in progress, so if you find a bug, don't freak out!