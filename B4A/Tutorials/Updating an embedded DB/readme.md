### Updating an embedded DB by udg
### 01/01/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/126077/)

A common task we face while enhancing our apps is the need to update the structure of a running DB.   
This is relatively easy if you know for sure that your users will all go from version 1 to version 2 and then to version 3. But what happens if an user goes from version 1 straight to version 3 of your DB? Missing the "conversion" operations provided in the first update will eventually lead to crashes or impose to carry those former updates over to the next one.  
  
My solution is based on the standard module **DBUtils** and a couple of very simple subs I wrote: **DBUpdateVer** and **DBUpdateSchema**  
  
DBUtils provides two very useful subs in order to ease the DB update: ***GetDBVersion*** and ***SetDBVersion  
  
GetDBVersion*** "Gets the current version of the database. If the DBVersion table does not exist it is created and the current version is set to version 1."  
***SetDBVersion*** "Sets the database version to the given version number."  
  
That makes for the base mechanism used to track the current DB version in our app.  
  
Now, let's have a look at how the whole updating procedure works, starting with a few lines of code in the Starter module.  
  

```B4X
Sub Process_Globals  
…  
Private const DBNewVer As Int = 2    'DB version for our app's current release; manually updated when needed  
….  
  
Sub Service_Create  
…  
DBData.SQL1.Initialize(DBUtils.getdbfolder,"db/mydb.db",True)  
'check current DB version and eventually apply all the pending updates  
Dim DBCurver As Int = DBUtils.GetDBVersion(DBData.SQL1)  
If DBCurver < DBNewVer Then DBData.DBUpdateSchema(DBCurver, DBNewVer)  
…
```

  
The above code is really simple. First time the GetDBVersion sub is called, it creates a service table named "*DBVersion*", having a simple field ("*version*") initialized to value **1**. This means that, in order to create the first version of our own DB scheme, we should set DBNewVer to **2** in Starter Process\_Globals.  
  
Well, time to introduce **DBUpdateSchema** (I use to have a module named DBData or DBStuff where I collect everything DB-related needed by the app).  

```B4X
'Update DB schema to NewVer version, applying all the pending updates since OldVer. When done, update version value in table DBVersion.  
Public Sub DBUpdateSchema(oldver As Int, newver As Int)  
    For j = oldver+1 To newver  
        DBUpdateVer(j)  
    Next  
    DBUtils.SetDBVersion(SQL1, newver)  
End Sub
```

  
So, the above code calls repeatedly DBUpdateVer in order to apply changes at our DB in the same order they were deployed.  
This solves the case when an user goes straight from version 1 to version 3 (because updates from version 2 are applied before those for version 3).  
  
Lastly we can have a look at how **DBUpdateVer** is used to update our DB:  

```B4X
Private Sub DBUpdateVer(ver As Int)  
    Select ver  
        Case 2  
            SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT)")  
        Case 3  
            SQL1.ExecNonQuery("ALTER TABLE students ADD COLUMN school TEXT AFTER name;")  
    End Select  
End Sub
```

  
When we initially realease our app, only "Case 2" is part of the Select statement. This way we instruct the DBMS to create a table named "students" with two fileds.  
At a later time we decide we need some more info about a student, so we want to add the school they go to.  
Just add "Case 3" (which adds the new column to our table scheme) and update DBNewVer to **3** in the Starter module.  
  
Admittedly, the above is oversimplified. You will probably add calls to more functions in the Case clauses in order to initialize values, add indexes, copy values from old schemes to newer ones..  
  
That's all folks!