### SQLite Using Vacuum Into To Make a Copy of an Open DB by Mahares
### 01/24/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145678/)

**Description:**  
This snippet in B4A is the full code that allows you to make a vacuumed copy of an open SQLite database and reduces its size. SInce this feature was introduced in SQLite version 27, the code checks and makes sure you are you using a device that has a version of 27 and higher. It is particularly uuseful if the open database has ballooned in size due to multiple updates, inserts and/or deletions.  

```B4X
Sub VacuumToaFile  
    Dim backupfile As String = "testbackup.db"  
    If File.Exists(xui.DefaultFolder, backupfile) Then  
        File.Delete(xui.DefaultFolder, backupfile)  
    End If  
  
    Dim sqliteversion As String =SQL.ExecQuerysingleresult( "SELECT SQLite_version()")  
'    Log(sqliteversion)  
    Dim sv() As String =Regex.Split("\.", sqliteversion)  
    If  sv(1) >= 27  Then  
'        SQL.ExecNonQuery2("VACUUM INTO ?", Array($"${xui.DefaultFolder}/${backupfile}"$))    'this works too  
        SQL.ExecNonQuery2("VACUUM INTO ?", Array(File.combine(xui.defaultfolder,backupfile)))  'this works too  
        Log($"Main database was vacuumed into a new file: ${backupfile}"$)  
        For Each f As String In File.ListFiles(xui.DefaultFolder)  
            If f.EndsWith(".db") And f.Contains("backup") Then  
                Log(f)  
            End If  
        Next  
    Else  
        Log($"Device SQLlte version is earlier than version 27. Cannot vacuum into a new file"$)  
    End If  
End Sub
```

  
If the vesrsion is earlier than 27, you can still vacuum a database using: SQL1.ExecNonQuery("Vacuum") to reduce the size of the open database itself without making a copy.  
[USER=108242]@Chris2[/USER] has a similar snippet for B4J. If you like to check it out it is here:  
<https://www.b4x.com/android/forum/threads/backup-sqlite-db-with-vacuum-into.145313/>  
  
**Tags:** SQLite, Vacuum  
****Dependency:**** SQL Library