# MicroSDSQLite Example Instructions

The package includes two separate B4A examples:

- `MicroSDSQLiteDirectExample` for `Mode 1: Direct Mode`
- `MicroSDSQLiteSafExample` for `Mode 2: SAF Mode`

Run the Direct Mode example first. It is the normal SQLite path and the best starting point.

## 1. Install The Library

Copy these files from the package `library` folder to your B4A Additional Libraries folder:

[CODE=text]
MicroSDSQLite.jar
MicroSDSQLite.xml
[/CODE]

Restart B4A after copying them.

In B4A, check `Tools` -> `Configure Paths` if you are not sure which Additional Libraries folder your IDE is using.

Quick check: open `MicroSDSQLite.xml` in that Additional Libraries folder and search for:

[CODE=text]
OpenSafDatabaseAtRelativePath
AttachDatabaseAtFullPath
[/CODE]

## 2. Run The Direct Mode Example

Open this B4A project:

[CODE=text]
examples\MicroSDSQLiteDirectExample\MicroSDSQLiteDirectExample.b4a
[/CODE]

Required B4A libraries:

[CODE=text]
Core
SQL
MicroSDSQLite
[/CODE]

What it does:

1. Finds the app-specific removable folder with `Store.ResolveRemovableSubDir`.
2. Creates the folder if needed.
3. Opens `direct-example.db` with `Store.OpenDatabase`.
4. Creates a `notes` table.
5. Inserts one row.
6. Reads the row count.
7. Closes with `Store.CloseDatabase(SQL1, True)`.

This example normally does not require Android all-files special access because it uses the app-specific removable folder.

## 3. Run The SAF Mode Example

Open this B4A project:

[CODE=text]
examples\MicroSDSQLiteSafExample\MicroSDSQLiteSafExample.b4a
[/CODE]

Required B4A libraries:

[CODE=text]
Core
SQL
MicroSDSQLite
[/CODE]

What it does:

1. Opens Android's folder picker the first time.
2. Saves the selected SAF folder URI.
3. Opens `MicroSDSQLiteSafExample/saf-example.db` under the selected folder with `Store.OpenSafDatabaseAtRelativePath`.
4. Creates a `notes` table.
5. Inserts one row.
6. Reads the row count.
7. Closes with `Store.CloseSafDatabase(SQL1)`.

Pick an allowed SD-card folder such as `Documents` or a folder under it. Android normally does not allow selecting the SD-card root with the SAF folder picker.

## 4. Close Rule

Do not call `SQL1.Close` directly for a database opened by MicroSDSQLite.

Use:

[CODE=text]
Store.CloseDatabase(SQL1, True)
[/CODE]

for Direct Mode.

Use:

[CODE=text]
Store.CloseSafDatabase(SQL1)
[/CODE]

for SAF Mode.

These manager methods close the B4A `SQL` object and release the library lock.

## 5. Recommended App Pattern

Keep one database touchpoint in your app.

Put all open, close, attach, detach, and query helper methods in one module. The example projects use a small database module for that pattern:

- `DbDirect.bas`
- `DbSaf.bas`

## 6. Build The Library From Source

The source package is separate from the main user package.

Extract:

[CODE=text]
MicroSDSQLite-source.zip
[/CODE]

Then run:

[CODE=powershell]
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\build.ps1
[/CODE]

To install from the build script, pass your own B4A Additional Libraries folder:

[CODE=powershell]
.\build.ps1 -Install -InstallDir "C:\Path\To\Your\B4A\AdditionalLibraries"
[/CODE]

Build outputs:

[CODE=text]
out\MicroSDSQLite.jar
out\MicroSDSQLite.xml
[/CODE]

## 7. More Reading

- `README.md` - start here for mode selection and beginner usage.
- `API_REFERENCE.md` - method, property, and event reference.
- `TEST_REPORT.md` - device test notes and 44 completed database checks.
