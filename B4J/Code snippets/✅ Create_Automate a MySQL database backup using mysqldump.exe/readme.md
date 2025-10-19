### ✅ Create/Automate a MySQL database backup using mysqldump.exe by Peter Simpson
### 10/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169066/)

**SubName:** Create a single .sql backup file of a MySQL database that is ready to restore.  
**Description:** You can use the following code to create a backup of MySQL databases, the backup file is saved in a folder on your desktop called 'Backup Database'. The code below creates an .sql file that you can use to restore/recreate your MySQL database. MySQLDumpPath **NEEDS** to point to any mysqldump.exe file.  
  

```B4X
Sub Process_Globals  
    Private OUTPUT_FILE As String  
End Sub  
  
Public Sub BackupMySQL  
    'Configuration  
    Dim DB_USER As String = DBUsername  
    Dim DB_PASS As String = DBPassword  
    Dim DB_HOST As String = DBLocation  
    Dim DB_NAME As String = DBName  
  
    'Desktop backup folder location  
    Dim DesktopPath As String = $"C:\Users\${GetSystemProperty("user.name", "default")}\desktop\Backup Database"$  
  
    If File.Exists(DesktopPath, "") = False Then  
        File.MakeDir(File.GetFileParent(DesktopPath), File.GetName(DesktopPath))  
    End If  
  
    ' Timestamped output file  
    Dim DATESTAMP As String = $"${NumberFormat(DateTime.GetDayOfMonth(DateTime.Now),2,0)}-${NumberFormat(DateTime.GetMonth(DateTime.Now),2,0)}-${DateTime.GetYear(DateTime.Now)}_${NumberFormat(DateTime.GetHour(DateTime.Now),2,0)}${NumberFormat(DateTime.GetMinute(DateTime.Now),2,0)}"$  
    OUTPUT_FILE = File.Combine(DesktopPath, DB_NAME & "_backup_" & DATESTAMP & ".sql")  
  
    'Build MySQLDump Arguments  
    Dim Args As List  
        Args.Initialize  
        Args.Add("–host=" & DB_HOST)  
        Args.Add("-u" & DB_USER)  
        Args.Add("-p" & DB_PASS)  
        Args.Add("–routines")                'Include stored procedures and functions  
        Args.Add("–triggers")                'Include triggers  
        Args.Add("–events")                'Include scheduled events  
        Args.Add("–single-transaction")    'Ensures consistency for InnoDB tables  
        Args.Add("–quick")                    'Essential for large tables/memory management  
        Args.Add("–lock-tables")            'Lock tables - Uncomment this line after commenting out the line below          
        'Args.Add("–skip-lock-tables")        'Skip locking tables (useful for live DBs)  
        Args.Add("–complete-insert")        'Ensures all column names are included  
        Args.Add("–extended-insert")        'Compact insert statements  
        Args.Add("–add-drop-table")        'Adds DROP TABLE before CREATE TABLE  
        Args.Add("–set-gtid-purged=OFF")    'Avoids GTID errors on some setups  
        Args.Add(DB_NAME)  
  
    'Examples of some mysqldump.exe locations  
    'Dim MySQLDumpPath As String = "C:\Program Files (x86)\MySQL\MySQL for Visual Studio 1.2.7\Dependencies\mysqldump.exe"  
    'Dim MySQLDumpPath As String = "C:\Program Files\MySQL\MySQL Server <YOUR SERVER VERSION>\bin\mysqldump.exe"  
    Dim MySQLDumpPath As String = File.Combine(File.DirApp, "..\files\mysqldump.exe")  
  
    'Initialise and run Shell  
    Dim Shl As Shell  
        Shl.Initialize("BackupEvent", MySQLDumpPath, Args)  
        Shl.WorkingDirectory = File.GetFileParent(OUTPUT_FILE)  
        Shl.Run(-1)  
End Sub  
  
Private Sub BackupEvent_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success Then  
        File.WriteString(File.GetFileParent(OUTPUT_FILE), File.GetName(OUTPUT_FILE), StdOut)  
        Log("Backup successful! File saved to: " & OUTPUT_FILE)  
    Else  
        Log("Backup failed. Exit code: " & ExitCode)  
        Log("Error output: " & StdErr)  
    End If  
End Sub
```

  
  
  
**Enjoy…**