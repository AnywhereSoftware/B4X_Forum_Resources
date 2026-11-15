# MicroSDSQLite for B4A

MicroSDSQLite is a B4A library for using a normal SQLite `.db` file on removable Android storage, such as a microSD card, without copying the database into internal storage first.

## Version 1.2

Version 1.2 adds two storage-capacity helpers:

- `GetFreeBytes` returns the unallocated bytes on the storage volume containing a directory.
- `GetTotalBytes` returns the total capacity of that storage volume.

These complement `GetUsableBytes`, which reports the bytes available to the application. The SQLite, SAF, locking, permission, and database-management behavior is unchanged from version 1.1.

After the library opens the database, you use the normal B4A `SQL` object:

- `ExecQuery`
- `ExecQuery2`
- `ExecNonQuery`
- `ExecNonQuery2`
- transactions
- parameterized statements
- joins
- views
- triggers
- constraints
- BLOBs

The library has two storage modes.

## Which Mode Should I Use?

Use `Mode 1: Direct Mode` when your app can open the database through a real Android filesystem path.

Use `Mode 2: SAF Mode` when your app only has a Storage Access Framework folder URI from Android's folder picker and cannot use a real path.

[CODE=text]
Mode 1: Direct Mode
Best SQLite compatibility.
Uses a real path such as /storage/<volume-id>/Android/data/<package>/files/MyDb/app.db.
Use this first when it is available.

Mode 2: SAF Mode
Fallback mode for a picked SAF folder.
Uses a SAF document file descriptor and passes /proc/self/fd/<fd> to SQLite.
Use this when Direct Mode is not available.
[/CODE]

## Important Terms

`Store` is the example variable name for the MicroSDSQLite manager.

[CODE=b4x]
Sub Process_Globals
    Public SQL1 As SQL
    Public Store As MicroSDSQLite
End Sub
[/CODE]

The manager opens the database, closes it, manages the library lock file, and provides helper methods for removable storage paths.

Storage-capacity helpers accept an existing directory path and return `-1` through the normal library error path if the directory cannot be checked:

[CODE=b4x]
Dim usableBytes As Long = Store.GetUsableBytes(dbDir)
Dim freeBytes As Long = Store.GetFreeBytes(dbDir)
Dim totalBytes As Long = Store.GetTotalBytes(dbDir)
[/CODE]

`CloseDatabase` and `CloseSafDatabase` are MicroSDSQLite methods. They are not B4A/B4J SQL methods. Use them instead of calling `SQL1.Close` directly for databases opened by this library.

## Install

Copy these two files to your B4A Additional Libraries folder:

[CODE=text]
MicroSDSQLite.jar
MicroSDSQLite.xml
[/CODE]

Then restart B4A.

In your B4A project, select these libraries:

[CODE=text]
SQL
MicroSDSQLite
[/CODE]

If B4A reports unknown members, check that both the `.jar` and `.xml` files were replaced in the Additional Libraries folder that B4A is actually using.

## Mode 1: Direct Mode

Direct Mode opens SQLite through a real filesystem path. This is the most complete mode.

Use Direct Mode when:

- the database is in the app-specific removable folder, or
- Android allows your app to use a public/shared SD-card path, and
- `Store.OpenDatabase` or `Store.OpenDatabaseAtFullPath` succeeds on the real database file.

Direct Mode is the preferred mode when you need normal SQLite behavior such as:

- WAL files
- `.db-wal`
- `.db-shm`
- rollback journal files
- `ATTACH`
- `VACUUM`
- large maintenance operations

### App-Specific Removable Folder

This is the simplest Direct Mode path. It does not normally require special Android storage access.

The folder looks like this:

[CODE=text]
/storage/<volume-id>/Android/data/<your.package>/files/<your-folder>
[/CODE]

It is on the microSD card when Android returns it as the removable external files directory. It belongs to your app, so Android may remove it when the app is uninstalled.

Use `Store.ResolveRemovableSubDir` to get a child folder under that app-specific removable folder.

[CODE=b4x]
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
[/CODE]

### Public SD-Card Path

Direct Mode can also be used with a public/shared SD-card path when Android allows your app to access that path.

The library can supply the removable volume root:

[CODE=b4x]
Dim root As String = Store.GetRemovableVolumeRoot
[/CODE]

If Android returns this app-specific removable folder:

[CODE=text]
/storage/<volume-id>/Android/data/<your.package>/files
[/CODE]

then `GetRemovableVolumeRoot` returns:

[CODE=text]
/storage/<volume-id>
[/CODE]

That lets you build paths such as:

[CODE=b4x]
Dim dbPath As String = Store.CombinePath(root, "Download/app.db")
[/CODE]

For apps that use Android's all-files special access, the manifest line is:

[CODE=b4x]
AddPermission(android.permission.MANAGE_EXTERNAL_STORAGE)
[/CODE]

That permission is an Android topic, not a MicroSDSQLite feature. The library only provides small helper methods such as `IsManageAllFilesGranted` and `OpenManageAllFilesSettings`.

## Mode 2: SAF Mode

SAF Mode opens a database document under a folder selected with Android's Storage Access Framework folder picker.

Use SAF Mode when:

- the user must pick a folder with Android's folder picker,
- your app has a `content://...` SAF tree URI,
- your app does not have usable direct filesystem access to that folder, and
- copying the database into local app storage is not acceptable.

SAF Mode keeps the database on the card. It does not make a local working copy.

SAF Mode is more limited than Direct Mode:

- do not use WAL in SAF Mode,
- use one MicroSDSQLite manager for the open database session,
- target normal reads and writes,
- retest your own target devices.

[CODE=b4x]
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
[/CODE]

## Included Examples

The package includes two separate B4A example projects:

- `examples\MicroSDSQLiteDirectExample`
- `examples\MicroSDSQLiteSafExample`

Start with `MicroSDSQLiteDirectExample` if you want the best SQLite compatibility.

Use `MicroSDSQLiteSafExample` when you need the Android folder picker flow.

## Locking Rule

Keep one database touchpoint in your app. Put database open, close, attach, detach, and query helper methods in one module.

The library creates a cooperative lock file or SAF lock document while the database is open:

- Direct Mode: `<database>.microsdsqlite.lock` beside the database.
- SAF Mode: `<database>.microsdsqlite.lock` in the selected SAF folder.

This lock is for apps that cooperate with this library. SQLite's own locking still governs actual database concurrency.

## ATTACH

Use `ATTACH` only in Direct Mode.

Use the manager methods:

- `AttachDatabase`
- `AttachDatabaseAtFullPath`
- `DetachDatabase`
- `GetAttachedSchemas`

The attached database should be a real database path supplied by your app.

## What Was Tested

Testing was done on a Samsung SM-A166U running Android 16 / SDK 36 with removable microSD storage.

The database-function test passed 44 checks with 0 failures, including transactions, rollback, savepoints, constraints, BLOBs, joins, views, triggers, `ALTER TABLE`, `REINDEX`, locked `ATTACH`, cleanup, and `PRAGMA quick_check`.

The full list is in `TEST_REPORT.md`.

## More Files

- `API_REFERENCE.md` - complete method, property, and event reference.
- `EXAMPLE_INSTRUCTIONS.md` - how to run the included B4A examples.
- `TEST_REPORT.md` - device test notes and the 44 completed database checks.
- `FORUM_POST.md` - forum post text.
