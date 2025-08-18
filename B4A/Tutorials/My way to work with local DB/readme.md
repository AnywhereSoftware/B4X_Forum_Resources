### My way to work with local DB by LucaMs
### 03/17/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/139215/)

I save the SQLite DB used by my apps in the directory corresponding to File.DirInternal, which is the app's exclusive space.  
  
This, however, prevents you from accessing the DB from outside (directly from Windows explorer) and checking the changes made by the app.  
  
It would be possible to get that DB if it were in rp.GetSafeDirDefaultExternal (rp = RuntimePermissions). So what I do is:  
  
1 - create a new configuration file  
  
![](https://www.b4x.com/android/forum/attachments/126713)  
  
![](https://www.b4x.com/android/forum/attachments/126714)  
  
2 - create a conditional symbol in this file (whatever word I want; I use SafeDirExt)  
3 - initialize the DB as follows:  
  

```B4X
Sub Process_Globals  
    Private DB As SQL  
    Private DBDir As String  
    Private Const DBName As String = "NameOfMyDB.db"  
End Sub  
  
Public Sub Init  
    #If SafeDirExt  
        Dim rp As RuntimePermissions  
        DBDir = rp.GetSafeDirDefaultExternal("")  
    #Else  
        DBDir = File.DirInternal  
    #End If  
    If Not(File.Exists(DBDir, DBName)) Then  
        File.Copy(File.DirAssets, DBName, DBDir, DBName)  
    End If  
    DB.Initialize(DBDir, DBName, False)  
End Sub
```

  
  
When I run, I choose the configuration:  
  
![](https://www.b4x.com/android/forum/attachments/126715)  
  
  
*[You could also do the same thing using as a conditional statement: #If Debug but I prefer to work almost always in this mode]*