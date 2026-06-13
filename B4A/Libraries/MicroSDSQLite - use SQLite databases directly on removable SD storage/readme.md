### MicroSDSQLite - use SQLite databases directly on removable SD storage by Tim Chapman
### 06/07/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171192/)

Hi everyone,  
  
I am sharing a B4A library called MicroSDSQLite.  
  
It is for apps that need to use a normal SQLite `.db` file on Android removable storage, such as a microSD card, without first copying the database into internal storage.  
  
After the database is opened, you use the normal B4A `SQL` object:  
  
- `ExecQuery`  
- `ExecQuery2`  
- `ExecNonQuery`  
- `ExecNonQuery2`  
- transactions  
- joins  
- views  
- triggers  
- constraints  
- BLOBs  
  
**The two modes**  
  
The library has two modes.  
  
**Mode 1: Direct Mode**  
  
Use Direct Mode when your app can open the database through a real Android filesystem path.  
  
This is the best SQLite mode. Use it when it is available.  
  
Direct Mode supports the normal SQLite sidecar files that SQLite itself creates and manages, such as:  
  
- `app.db-wal`  
- `app.db-shm`  
- `app.db-journal`  
  
Direct Mode can be used with the app-specific removable folder:  
  

```B4X
/storage/<volume-id>/Android/data/<your.package>/files/<your-folder>
```

  
  
The library can find that folder with:  
  

```B4X
Dim dbDir As String = Store.ResolveRemovableSubDir("MyDatabase")
```

  
  
Direct Mode can also use a public/shared SD-card path if Android allows your app to access that path.  
  
The library can supply the removable volume root:  
  

```B4X
Dim root As String = Store.GetRemovableVolumeRoot
```

  
  
Apps that use Android all-files special access can add the normal Android manifest permission:  
  

```B4X
AddPermission(android.permission.MANAGE_EXTERNAL_STORAGE)
```

  
  
That permission is an Android storage topic, not a MicroSDSQLite feature. The library only provides helper methods to check the setting and open Android's settings page.  
  
**Mode 2: SAF Mode**  
  
Use SAF Mode when your app only has a Storage Access Framework folder URI from Android's folder picker and cannot use a real filesystem path.  
  
SAF Mode keeps the `.db` file on the card. It does not make a local working copy.  
  
SAF Mode is more limited than Direct Mode:  
  
- no WAL support  
- one manager should own the open database session  
- intended for normal reads and writes  
- should be tested on the target devices  
  
**Basic Direct Mode example**  
  

```B4X
Sub Process_Globals  
    Public SQL1 As SQL  
    Public Store As MicroSDSQLite  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Store.Initialize("Store")  
  
    Dim dbDir As String = Store.ResolveRemovableSubDir("MyDatabase")  
    If dbDir = "" Then  
        Log("No mounted removable storage folder was found for this app.")  
        Return  
    End If  
  
    If Store.EnsureDirectory(dbDir) = False Then  
        Log("Could not create database folder: " & Store.LastError)  
        Return  
    End If  
  
    If Store.OpenDatabase(SQL1, dbDir, "app.db", True) = False Then  
        Log("Open failed: " & Store.LastError)  
        Return  
    End If  
  
    SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT)")  
    SQL1.ExecNonQuery2("INSERT INTO notes(body) VALUES (?)", Array As Object("Hello from Direct Mode"))  
  
    Store.CloseDatabase(SQL1, True)  
End Sub
```

  
  
**Basic SAF Mode example**  
  

```B4X
Sub Process_Globals  
    Public SQL1 As SQL  
    Public Store As MicroSDSQLite  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Store.Initialize("Store")  
  
    If File.Exists(File.DirInternal, "saf_uri.txt") Then  
        Store.SetSafFolderUri(File.ReadString(File.DirInternal, "saf_uri.txt"))  
        OpenSafDatabase  
    Else  
        Store.PickSafFolder  
    End If  
End Sub  
  
Sub Store_SafFolderSelected (Success As Boolean, FolderUri As String)  
    If Success = False Then  
        Log("Folder was not selected: " & Store.LastError)  
        Return  
    End If  
  
    File.WriteString(File.DirInternal, "saf_uri.txt", FolderUri)  
    Store.SetSafFolderUri(FolderUri)  
    OpenSafDatabase  
End Sub  
  
Private Sub OpenSafDatabase  
    If Store.HasSafFolderPermission = False Then  
        Store.PickSafFolder  
        Return  
    End If  
  
    If Store.OpenSafDatabaseAtRelativePath(SQL1, "MyDatabase/app.db", True) = False Then  
        Log("SAF open failed: " & Store.LastError)  
        Return  
    End If  
  
    SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT)")  
    SQL1.ExecNonQuery2("INSERT INTO notes(body) VALUES (?)", Array As Object("Hello from SAF Mode"))  
  
    Store.CloseSafDatabase(SQL1)  
End Sub
```

  
  
**Important close rule**  
  
Use the library close methods:  
  
- Direct Mode: `Store.CloseDatabase(SQL1, True)`  
- SAF Mode: `Store.CloseSafDatabase(SQL1)`  
  
Do not call `SQL1.Close` directly for a database opened by MicroSDSQLite. The library close methods also release the manager lock.  
  
**Locking / one touchpoint**  
  
The library is designed around one database touchpoint in the app.  
  
Direct Mode creates a cooperative lock file beside the database:  
  

```B4X
<database>.microsdsqlite.lock
```

  
  
SAF Mode creates a temporary SAF lock document in the selected folder.  
  
The lock is cooperative. Other apps can monitor it, but unrelated apps can ignore it. SQLite's own locking still governs actual database concurrency.  
  
**Included examples**  
  
The package includes two separate B4A example projects:  
  
- `MicroSDSQLiteDirectExample`  
- `MicroSDSQLiteSafExample`  
  
This is intentional. The two modes have different setup paths, so the examples are separate.  
  
**Tested**  
  
Tested on:  
  
- Samsung SM-A166U  
- Android 16 / SDK 36  
- removable microSD storage  
  
The database-function test passed 44 checks with 0 failures. The full list is included in `TEST\_REPORT.md`.  
  
**Attachments**  
  
- `MicroSDSQLite-B4A-v1.1.zip` - main package with library files, docs, and both examples.  
- `MicroSDSQLiteExamples.zip` - convenience zip with the two B4A example projects only.  
- `MicroSDSQLite-source.zip` - Java source, XML metadata, and build script.  
  
To install, copy both `MicroSDSQLite.jar` and `MicroSDSQLite.xml` from the main package's `library` folder to your B4A Additional Libraries folder, restart B4A, then open one of the included example projects.