# MicroSDSQLite API Reference

Read `README.md` first if you are choosing between the two modes.

This library exposes one B4A class:

[CODE=text]
MicroSDSQLite
[/CODE]

The examples use this variable name:

[CODE=b4x]
Sub Process_Globals
    Public SQL1 As SQL
    Public Store As MicroSDSQLite
End Sub
[/CODE]

`Store` is not a built-in B4A object. It is only the variable name used for the MicroSDSQLite manager.

## Required B4A Libraries

[CODE=text]
SQL
MicroSDSQLite
[/CODE]

## Initialize

[CODE=text]
Initialize (EventName As String)
[/CODE]

Initializes the manager and sets the B4A event prefix.

This follows the normal B4A pattern used by libraries that raise events. It only controls callback sub names. It does not change method names such as `OpenDatabase` or `CloseDatabase`.

Example:

[CODE=b4x]
Store.Initialize("Store")
[/CODE]

In this example, `Store` is both the variable name and the event prefix. The event prefix is the string passed to `Initialize`.

With `Store.Initialize("Store")`, the event subs are:

- `Store_SafFolderSelected`
- `Store_ManageAllFilesResult`
- `Store_Error`

If you used this instead:

[CODE=b4x]
Store.Initialize("Db")
[/CODE]

then the event subs would be:

- `Db_SafFolderSelected`
- `Db_ManageAllFilesResult`
- `Db_Error`

The event suffixes are fixed. The prefix is chosen by the app.

## Events

The event sub names below assume this initialization:

[CODE=b4x]
Store.Initialize("Store")
[/CODE]

If you choose a different event prefix, replace `Store_` with your prefix.

### SafFolderSelected

[CODE=b4x]
Sub Store_SafFolderSelected (Success As Boolean, FolderUri As String)
End Sub
[/CODE]

Raised after `PickSafFolder`.

- `Success As Boolean` - True if the user selected a folder.
- `FolderUri As String` - Android SAF tree URI.

### ManageAllFilesResult

[CODE=b4x]
Sub Store_ManageAllFilesResult (Granted As Boolean)
End Sub
[/CODE]

Raised after returning from `OpenManageAllFilesSettings`.

- `Granted As Boolean` - True if Android reports all-files access for this app.

### Error

[CODE=b4x]
Sub Store_Error (Operation As String, Message As String)
End Sub
[/CODE]

Raised when the manager records an error.

- `Operation As String` - method or operation name.
- `Message As String` - error message.

The latest error is also available through `LastError`.

## Properties

### LastError As String

Last error message recorded by the manager.

### HasOpenDatabase As Boolean

True while a Mode 1 Direct Mode database is open through this manager.

### AttachedDatabaseCount As Int

Number of Direct Mode attached databases currently locked by this manager.

### ManagedDir As String

Directory of the current Direct Mode database, or an empty string.

### ManagedFileName As String

File name of the current Direct Mode database, or an empty string.

### ManagedPath As String

Full path of the current Direct Mode database, or an empty string.

### LockPath As String

Full path of the current Direct Mode lock file, or an empty string.

### SafFolderUri As String

Current SAF tree URI, or an empty string.

### SafDatabaseUri As String

Current SAF database document URI, or an empty string.

### SafFdPath As String

`/proc/self/fd/...` path used by SQLite for the current SAF Mode database session, or an empty string.

### HasOpenSafDatabase As Boolean

True while a Mode 2 SAF Mode database is open through this manager.

## General Methods

### IsInitialized

[CODE=text]
IsInitialized As Boolean
[/CODE]

Returns True after `Initialize` has been called.

### CombinePath

[CODE=text]
CombinePath (Parent As String, Child As String) As String
[/CODE]

Combines a parent path and a child path.

The child path must not contain `..`.

### EnsureDirectory

[CODE=text]
EnsureDirectory (Dir As String) As Boolean
[/CODE]

Creates the directory if it does not exist.

### IsDirectoryWritable

[CODE=text]
IsDirectoryWritable (Dir As String) As Boolean
[/CODE]

Tests direct write access by creating and deleting a small temporary file.

### GetUsableBytes

[CODE=text]
GetUsableBytes (Dir As String) As Long
[/CODE]

Returns usable bytes for the directory, or `-1` on failure.

This is the space available to the application and can be less than the unallocated space reported by `GetFreeBytes`.

### GetFreeBytes

[CODE=text]
GetFreeBytes (Dir As String) As Long
[/CODE]

Returns the unallocated bytes on the storage volume containing the directory, or `-1` on failure.

### GetTotalBytes

[CODE=text]
GetTotalBytes (Dir As String) As Long
[/CODE]

Returns the total capacity of the storage volume containing the directory, or `-1` on failure.

## Storage Path Helpers

### GetExternalFilesDirs

[CODE=text]
GetExternalFilesDirs As String()
[/CODE]

Returns Android app-specific external files directories.

### GetExternalFilesDirInfo

[CODE=text]
GetExternalFilesDirInfo As String
[/CODE]

Returns a readable list of app-specific external directories, removable state, mount state, write state, and usable bytes.

### GetPrimaryAppSpecificRoot

[CODE=text]
GetPrimaryAppSpecificRoot As String
[/CODE]

Returns the primary app-specific external files directory, or an empty string.

### GetRemovableAppSpecificRoot

[CODE=text]
GetRemovableAppSpecificRoot As String
[/CODE]

Returns the first mounted removable app-specific external files directory, or an empty string.

Example shape:

[CODE=text]
/storage/<volume-id>/Android/data/<your.package>/files
[/CODE]

### ResolveRemovableSubDir

[CODE=text]
ResolveRemovableSubDir (SubFolder As String) As String
[/CODE]

Combines the removable app-specific root with a child folder path.

Example shape:

[CODE=text]
/storage/<volume-id>/Android/data/<your.package>/files/<SubFolder>
[/CODE]

This is the simplest Direct Mode location.

### GetRemovableVolumeRoot

[CODE=text]
GetRemovableVolumeRoot As String
[/CODE]

Best-effort helper that derives the removable volume root from Android's removable app-specific directory.

If Android returns:

[CODE=text]
/storage/<volume-id>/Android/data/<your.package>/files
[/CODE]

then this method returns:

[CODE=text]
/storage/<volume-id>
[/CODE]

This method supplies a path only. It does not grant access to public/shared storage.

### GetVolumeRootFromAppSpecificDir

[CODE=text]
GetVolumeRootFromAppSpecificDir (AppSpecificDir As String) As String
[/CODE]

Derives a storage volume root from an app-specific external directory path.

## Optional Android All-Files Helpers

These helpers are only for apps that choose to use Android's all-files special access for public/shared direct paths.

### IsManageAllFilesGranted

[CODE=text]
IsManageAllFilesGranted As Boolean
[/CODE]

Returns Android's all-files access state for this app package.

### OpenManageAllFilesSettings

[CODE=text]
OpenManageAllFilesSettings
[/CODE]

Opens Android settings so the user can enable all-files access for this app. Raises `<EventName>_ManageAllFilesResult`.

## Mode 1: Direct Mode Database Methods

Direct Mode uses a real filesystem path.

### OpenDatabase

[CODE=text]
OpenDatabase (Sql As SQL, Dir As String, FileName As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Opens `Dir/FileName`.

- `Sql As SQL` - B4A SQL object to initialize.
- `Dir As String` - directory path.
- `FileName As String` - database file name only.
- `CreateIfNecessary As Boolean` - True creates a missing database.

### OpenDatabaseAtFullPath

[CODE=text]
OpenDatabaseAtFullPath (Sql As SQL, FullPath As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Opens the complete database path.

- `FullPath As String` - full path to the `.db` file.

### CloseDatabase

[CODE=text]
CloseDatabase (Sql As SQL, CheckpointWal As Boolean) As Boolean
[/CODE]

Closes the supplied B4A SQL object and releases Direct Mode locks.

- `CheckpointWal As Boolean` - True runs a best-effort WAL checkpoint before closing.

Use this instead of calling `SQL1.Close` directly for Direct Mode databases opened by this library.

### ReleaseLockOnly

[CODE=text]
ReleaseLockOnly As Boolean
[/CODE]

Releases the Direct Mode manager lock without touching a SQL object.

Use only for recovery paths where SQL has already been closed or was never opened.

### DeleteLockFileIfNotHeld

[CODE=text]
DeleteLockFileIfNotHeld (Dir As String, FileName As String) As Boolean
[/CODE]

Deletes a stale Direct Mode lock file for `Dir/FileName` if this process is not currently holding it.

## Mode 1: Direct Mode ATTACH Methods

ATTACH methods are for Direct Mode only.

### AttachDatabase

[CODE=text]
AttachDatabase (Sql As SQL, Dir As String, FileName As String, SchemaName As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Locks and attaches a developer-supplied second database to the current managed Direct Mode SQL connection.

- `Sql As SQL` - open SQL object for the main database.
- `Dir As String` - directory of the database to attach.
- `FileName As String` - database file name to attach.
- `SchemaName As String` - SQLite schema name, such as `aux`.
- `CreateIfNecessary As Boolean` - True creates the attached database if missing.

### AttachDatabaseAtFullPath

[CODE=text]
AttachDatabaseAtFullPath (Sql As SQL, FullPath As String, SchemaName As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Same as `AttachDatabase`, but uses the full path to the database to attach.

### DetachDatabase

[CODE=text]
DetachDatabase (Sql As SQL, SchemaName As String) As Boolean
[/CODE]

Detaches a schema attached through this manager and releases that attached database lock.

### GetAttachedSchemas

[CODE=text]
GetAttachedSchemas As String()
[/CODE]

Returns schema names currently attached through this manager.

## Mode 2: SAF Mode Folder Methods

### PickSafFolder

[CODE=text]
PickSafFolder
[/CODE]

Opens Android's folder picker and persists read/write access to the selected tree. Raises `<EventName>_SafFolderSelected`.

### SetSafFolderUri

[CODE=text]
SetSafFolderUri (FolderUri As String) As Boolean
[/CODE]

Sets a previously saved SAF tree URI.

### HasSafFolderPermission

[CODE=text]
HasSafFolderPermission As Boolean
[/CODE]

Returns True when the current SAF tree URI still has persisted read/write permission.

## Mode 2: SAF Mode Database Methods

### OpenSafDatabase

[CODE=text]
OpenSafDatabase (Sql As SQL, DatabaseName As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Opens or creates `DatabaseName` directly in the selected SAF folder.

- `Sql As SQL` - B4A SQL object to initialize.
- `DatabaseName As String` - database file name only.
- `CreateIfNecessary As Boolean` - True creates a missing database.

### OpenSafDatabaseAtRelativePath

[CODE=text]
OpenSafDatabaseAtRelativePath (Sql As SQL, RelativePath As String, CreateIfNecessary As Boolean) As Boolean
[/CODE]

Opens or creates a database under the selected SAF tree.

- `RelativePath As String` - file name or child path, such as `Databases/app.db`.
- Parent folders are created only when `CreateIfNecessary=True`.

### CloseSafDatabase

[CODE=text]
CloseSafDatabase (Sql As SQL) As Boolean
[/CODE]

Closes the supplied B4A SQL object, closes the SAF file descriptor, and releases the SAF lock document.

Use this instead of calling `SQL1.Close` directly for SAF Mode databases opened by this library.

### ReleaseSafLockOnly

[CODE=text]
ReleaseSafLockOnly As Boolean
[/CODE]

Releases the SAF Mode manager lock without touching a SQL object.

Use only for recovery paths where SQL has already been closed or was never opened.

### DeleteSafLockFileIfExists

[CODE=text]
DeleteSafLockFileIfExists (DatabaseName As String) As Boolean
[/CODE]

Deletes a stale SAF lock document for `DatabaseName` in the selected SAF folder if this process is not currently holding it.

### DeleteSafLockFileAtRelativePath

[CODE=text]
DeleteSafLockFileAtRelativePath (RelativePath As String) As Boolean
[/CODE]

Deletes a stale SAF lock document for a database under the selected SAF tree if this process is not currently holding it.
