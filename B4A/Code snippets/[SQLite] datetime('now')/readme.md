### [SQLite] datetime('now') by aeric
### 10/03/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/110136/)

**B4A Code**  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: LocalTime  
    #VersionCode: 1  
    #VersionName: 1.0  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    Dim DB As SQL  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Dim qry As String  
    Dim rs As ResultSet  
    DB.Initialize(File.DirInternal, "Test.db", True)  
    'qry = "SELECT datetime('now')"                ' 2019-10-03 02:11:07  
    'qry = "SELECT datetime('now', 'utc')"        ' 2019-10-02 18:12:02  
    qry = "SELECT datetime('now', 'localtime')"    ' 2019-10-03 10:15:52  
    rs = DB.ExecQuery(qry)  
    Do While rs.NextRow  
        Log(rs.GetString2(0))  
    Loop     
    rs.Close  
    DB.Close  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```