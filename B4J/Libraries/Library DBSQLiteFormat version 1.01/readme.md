###  Library DBSQLiteFormat version 1.01 by T201016
### 04/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170894/)

I am making my tested library available for use: **DBSQLiteFormat V.1.01**  
I use it to work with external SQLite databases.  
In my projects, I check the compatibility of the database structure before using it.  
My main assumption was that both databases should contain the same (identical) structure.  
  
The main tasks of the library are:  
**- comparison of the correct SQLite3 file format.**  
 Each valid SQLite database file starts at 16 bytes,  
 Hexadecimal: 53 51 4c 69 74 65 20 66 6f 72 6d 61 74 20 33 00.  
  
**- comparison of field name compatibility in both databases;**   
Tests whether the string contains the given string parameter.  
  
**- comparison of the compatibility of the structure of the external SQLite database with the structure of the main SQLite database;**  
  
In version 1.01 the library DBSQLiteFormat so far it does not conflict with the DBUtils library.  
Have a good day.  
  

```B4X
'Initiation in:  
Sub Process_Globals | Sub Process_Globals  
    Public SQL1 As SQL  
    Public dbsf As DBSQLiteFormat  
    SQL1.InitializeSQLite(DBDir, DBFileName, False)  
    …  
  
'How to use:  
    Dim OpenFile As String  
    OpenFile = modProjUtils.ChooseFile(True, "Select a file corresponding to the database structure „Project‟", MainForm, File.DirApp, "DBFileName.db", _  
    "SQLite (*.db | *.db3 | *.dbsqlite | *.sqlite | *.sqlite3)", Array As String("*.db","*.db3","*.dbsqlite","*.sqlite","*.sqlite3"))  
  
    If OpenFile.Length > 0 And dbsf.ValidSQLiteFormat(File.GetFileParent(OpenFile), File.GetName(OpenFile), SQL1) Then  
        lblMsg.Text = "Open DB-SQLite …"
```