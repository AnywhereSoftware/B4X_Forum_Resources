### Backup & Restore SQLite using SaveAs by aeric
### 10/29/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/169127/)

This code snippet is based on tutorial [[B4X] TextEditor - Save and load external files](https://www.b4x.com/android/forum/threads/b4x-texteditor-save-and-load-external-files.132731/) here.  
Instead of writing a text file, we can make use of the same idea to backup and restore our SQLite database.  
Check post #4 for restore database.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private SQL1 As SQL  
    Private FileHandler1 As FileHandler  
    Private LblMessage As B4XView  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("1")  
    FileHandler1.Initialize  
    If File.Exists(File.DirInternal, "data.db") = False Then  
        File.Copy(File.DirAssets, "sample.db", File.DirInternal, "data.db")  
    End If  
    SQL1.Initialize(File.DirInternal, "data.db", False)  
End Sub  
  
Private Sub BtnBackup_Click  
    'DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"  
    'SQL1.ExecNonQuery2("UPDATE info SET modified = ?", Array As String(DateTime.Date(DateTime.Now)))  
   
    If File.Exists(File.DirInternal, "backup.db") Then File.Delete(File.DirInternal, "backup.db")  
    Dim BackupFilePath As String = File.Combine(File.DirInternal, "backup.db")  
    SQL1.ExecNonQuery2("VACUUM INTO ?", Array As String(BackupFilePath))  
   
    DateTime.DateFormat = "yyyyMMddHHmmss"  
    Dim timestamps As String = DateTime.Date(DateTime.Now)  
    Dim sf As Object = FileHandler1.SaveAs(File.OpenInput(File.DirInternal, "backup.db"), "application/vnd.sqlite3", timestamps & ".db")  
    Wait For (sf) Complete (Success As Boolean)  
    If Success Then LblMessage.Text = "File saved successfully" Else LblMessage.Text = "File failed to save"  
End Sub
```

  
  
Don't miss the manifest editor.  

```B4X
'FileProvider  
AddApplicationText(  
  <provider  
  android:name="android.support.v4.content.FileProvider"  
  android:authorities="$PACKAGE$.provider"  
  android:exported="false"  
  android:grantUriPermissions="true">  
  <meta-data  
  android:name="android.support.FILE_PROVIDER_PATHS"  
  android:resource="@xml/provider_paths"/>  
  </provider>  
)  
CreateResource(xml, provider_paths,  
   <files-path name="name" path="shared" />  
)
```