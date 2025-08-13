### B4J Single Instance checker (Windows & Linux) irrespective of the Java version and packager used by walt61
### 07/04/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/132842/)

This method was tested and works on my setup, even if the jar or exe is copied or renamed:  
- Windows 10, B4J 9.10 (and later), OpenJDK 11  
- Linux Mint Cinnamon 21.1, B4J 9.80, OpenJDK 11  
  

```B4X
#AdditionalJar: sqlite-jdbc-3.36.0.1  
  
Sub AppStart (Form1 As Form, Args() As String)  
  
    MainForm = Form1  
    MainForm.Show  
  
    If ImAlreadyRunning(File.DirData("ThisProgram"), "lock.sqlite") Then  
        fx.Msgbox(MainForm, "This program is already running", "No such luck")  
        ExitApplication  
        Return  
    End If  
  
'…  
  
End Sub  
  
Sub ImAlreadyRunning(dir As String, fileName As String) As Boolean  
  
    If File.Exists(dir, fileName) Then  
       ' Start of Linux-specific block. Turn it into comment if you don't need it.  
       ' Requires the jShell library to be added to the project, and /usr/bin/lsof must exist.  
        Dim os As String = GetSystemProperty("os.name", "").ToLowerCase  
        If (os.Contains("win") = False) And (os.Contains("mac") = False) And File.Exists("/usr/bin/lsof", "") Then  
            ' Linux. As per https://stackoverflow.com/questions/57986206/how-sqlite-can-be-used-after-deleting-local-database-file :  
            ' "On Linux or Unix systems, deleting a file via rm or through a file manager application will unlink the file from the  
            ' file system's directory structure; however, if the file is still open (in use by a running process) it will still be  
            ' accessible to this process and will continue to occupy space on disk."  
            '  
            ' Therefore, we're going to use the lsof command to check if the file is in use.  
            Try  
                Dim lsofShl As Shell  
                lsofShl.Initialize("", "/usr/bin/lsof", Array As String(File.Combine(dir, fileName)))  
                Dim lsofShlResult As ShellSyncResult = lsofShl.RunSynchronous(-1)  
                If lsofShlResult.Success And (lsofShlResult.ExitCode = 0) And lsofShlResult.StdOut.Contains(fileName) Then Return True  
            Catch  
                Log("ImAlreadyRunning - lsof failed: " & LastException)  
            End Try  
        End If  
        ' End of Linux-specific block.  
        Try  
            ' Note: at least on Windows 10, no exception is thrown if the sqlite file is in use by  
            ' another process. That's why the below 'Try' block with the SQL operations is there,  
            ' and why it doesn't just open the database. A successful File.Delete is inconclusive.  
            File.Delete(dir, fileName)  
        Catch  
            Return True  
        End Try  
    End If  
  
    Try  
        Dim sql1 As SQL  
        sql1.InitializeSQLite(dir, fileName, True)  
        sql1.BeginTransaction  
        sql1.ExecNonQuery("CREATE TABLE IF NOT EXISTS TblLock(ColInt int)")  
        sql1.ExecNonQuery("INSERT INTO TblLock (ColInt) VALUES (1)")  
        sql1.TransactionSuccessful ' This will cause exception "java.sql.SQLException: database is locked" if another instance was already running  
        ' IMPORTANT: do NOT close rs! (that's the whole point)  
        Dim rs As ResultSet = sql1.ExecQuery("SELECT * FROM TblLock")  
    Catch  
        Return True  
    End Try  
  
    Return False  
  
End Sub
```

  
  
Dependencies:  
- Internal library: jSQL  
- Additional jar: sqlite-jdbc-… : the latest one is 3.36.0.1 as per [USER=2806]@Claudio Oliveira[/USER] 's post: <https://www.b4x.com/android/forum/threads/new-sqlite-jdbc-version-3-36-0-1-2021-06-30.132348/>  
  
EDIT: added the 'Note' comment.  
EDIT 2023-07-04: added provisions for Linux.