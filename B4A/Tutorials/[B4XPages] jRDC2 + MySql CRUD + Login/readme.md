### [B4XPages] jRDC2 + MySql CRUD + Login by josejad
### 04/24/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/127239/)

Hi all:  
  
[MEDIA=youtube]ueG0kZ-GgoI[/MEDIA]  
  
I'm starting (at last) to work with B4XPages, so I've started to adapt the [B4XPages + B4XDrawer](https://www.b4x.com/android/forum/threads/b4x-b4xpages-b4xdrawer.120246/) example.  
I think I’ve seen more examples with php + mysql, but no projects with Jrdc2.  
  
Maybe the dummy data and the UI are too basic, but you can get some ideas.  
  
**What do we need?**  
- A mysql database. You can use XAMPP, LARAGON or any other project to set it up. See attached a sql file to import in your database. The database name will be B4X.  
- B4J to create the jRDC2 server  
- B4A 9.9+ to support B4XPages. As always, you should update B4A to the last versión (10.5 when this post have been write)  
  
**Steps:**  
- Import the sql file to you database. You can use phpMyAdmin, HeidiSQL, etc…  
- Configure jRDC2 server. Open the attached B4J file and change your user and password in the config file.  
[SPOILER="Configuring jRDC2"]  
<https://www.b4x.com/android/forum/threads/b4x-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/>  
[/SPOILER]  
- Open B4A, and change the rdcLink const in the jRDC2 class to match the IP of the computer where you’re running the jRDC2 server (B4J)  

```B4X
Sub Class_Globals  
    'CHANGE THE IP TO MATCH YOUR B4J SERVER  
    Private const rdcLink As String = "http://192.168.1.131:8090/rdc"  
End Sub
```

  
- To add, edit… we will use [B4XPreferencesDialog](https://www.b4x.com/android/forum/threads/b4x-b4xpreferencesdialog-cross-platform-forms.103842/). You should use the [Form Builder](https://www.b4x.com/android/forum/threads/b4x-forms-builder-designer-for-b4xpreferencesdialog.104670/) to build the forms. It's important that the key values match with database's fields names, due to we will construct a map from the rs returned from the db, and it will be easier to work this way, passing this map to the B4XPreferences dialog.  
  
I've commented the code the best I can.  
If you think there are some mistakes or you know some way to improve the example, you're welcome to do it.  
I've tried to make the B4J project too, but I've never used B4J and I get too many errors. If someone want to do it, we will learn something more. (or B4i)  
EDIT: Updated project and now it works with B4J and B4A (maybe in B4i)  
  
The password for all the users is: 1234 (stored as md5)  
  
[SPOILER="SQL sentences"]  
sql.Login = SELECT \* FROM B4X.users WHERE `username` = ? AND `password` = md5(?)  
sql.getEvents = SELECT \* FROM B4X.events WHERE `month` = ? AND `id\_user` = ?  
sql.updateEvents = UPDATE B4X.events SET `month`=?,`event\_type`=?,`description`=? WHERE `id` = ?  
sql.deleteEvents = DELETE FROM B4X.events WHERE `id` = ?  
sql.addEvents = INSERT INTO B4X.events(`id\_user`, `month`, `event\_type`, `description`, `value`) VALUES (?, ?, ?, ?, ?)  
[/SPOILER]