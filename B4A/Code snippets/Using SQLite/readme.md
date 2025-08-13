### Using SQLite by Cadenzo
### 10/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163877/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects.  
  
This example is using SQLite database in [GlobalClass](https://www.b4x.com/android/forum/threads/using-global-classes.163866/) with one table "Settings". You can add other tables.  
  

```B4X
Dim sUserName as String = GetSetting("name") 'getting the name'  
SetSettingInt("userage", 40) 'setting the age'
```

  
  

```B4X
'xGlobalClass (Main.cG)  
Sub Class_Globals  
    Private xui As XUI  
    Public s_DBfile As String '= "MyDB.db"  
    Public SQL1 As SQL  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Sub InitClass  
    'Database functions BEFORE Settings, because DB is needed there  
    Dim bDBExists As Boolean = CheckForDatabase("MyDB.db")  
    If bDBExists Then 'DB exists, so the App is not running first time  
        'Version control 'DB needs updates? new tables?  
    Else 'App is running firsttime, DB now created!  
        'SetSetting("FirstStart", DateTime.Now)  
    End If  
End Sub  
  
Public Sub CheckForDatabase(filename As String) As Boolean  
    Dim sDBPath As String = filename  
    'File.Delete(xui.DefaultFolder, sDBPath) ' only for testing, removes the database  
    Dim bDBexists As Boolean = File.Exists(xui.DefaultFolder, sDBPath)  
      
    'check if the database already exists  
    If bDBexists Then  
        SQL1.Initialize(xui.DefaultFolder, sDBPath, False)  
    Else  
        SQL1.Initialize(xui.DefaultFolder, sDBPath, True)  
        CreateDataBase 'and create it  
    End If  
    s_DBfile = sDBPath  
    Return bDBexists  
End Sub  
  
Sub CreateDataBase  
    Dim Query As String  
              
    Query = "CREATE TABLE Settings(Key Text, Value TEXT, ChangeTime INTEGER)"  
    SQL1.ExecNonQuery(Query)  
  
    'create other tables here…  
      
End Sub  
  
#Region "Database-methodes"  
Public Sub SQLExecute(sSql As String)  
    SQL1.ExecNonQuery(sSql)  
End Sub  
  
Public Sub SQLExecute2(sSql As String, arr() As Object)  
    SQL1.ExecNonQuery2(sSql, arr)  
End Sub  
  
Public Sub GetDBInt(query As String) As Int  
    Dim iRes As Int  
    Dim obj As Object = SQL1.ExecQuerySingleResult(query)  
    If obj = Null Then Return 0  
    Try  
        iRes = obj  
    Catch  
        Log(LastException) 'ToDo: In B4i exception if ""  
    End Try  
    Return iRes  
End Sub  
  
Public Sub GetDBInt2(query As String, args() As String) As Int  
    Dim sNumber As String = GetDBString2(query, args)  
    If IsNumber(sNumber) = False Then Return 0  
    Return sNumber  
End Sub  
  
Public Sub GetDBString(query As String) As String  
    Dim obj As Object = SQL1.ExecQuerySingleResult(query)  
    If obj = Null Then Return ""  
    Return obj  
End Sub  
  
Public Sub GetDBString2(query As String, args() As String) As String  
    Dim obj As Object = SQL1.ExecQuerySingleResult2(query, args)  
    If obj = Null Then Return ""  
    Return obj  
End Sub  
  
public Sub SetSetting(key As String, value As String)  
    Dim iNow As Long = DateTime.Now  
    Dim iLastChange As Long = GetDBLong("SELECT ChangeTime FROM Settings WHERE Key = '" & key  & "'")  
    If iLastChange = 0 Then  
        SQL1.ExecNonQuery2("INSERT INTO Settings VALUES (?, ?, ?)", Array As Object(key, value, iNow))  
    Else  
        SQL1.ExecNonQuery2("UPDATE Settings SET [Value] = ?, [ChangeTime] = ? WHERE [Key]='" & key & "'", Array As Object(value, iNow))  
    End If  
End Sub  
  
public Sub GetSetting(key As String) As String  
    Dim sVal As String  
    sVal = SQL1.ExecQuerySingleResult("SELECT Value FROM Settings WHERE Key = '" & key & "'")  
      
    If sVal = Null Then sVal = ""  
    If sVal = "null" Then sVal = ""  
    Return sVal  
End Sub  
  
public Sub GetSettingInt(key As String) As Long  
    Dim sVal As String = GetSetting(key)' map_Settings.Get(key)  
    Dim iVal As Long  
    Try  
        If IsNumber(sVal) = False Then Return 0  
        If sVal = "null" Or sVal = "" Then Return 0  
        iVal = sVal  
    Catch  
        Log(LastException)  
    End Try  
      
    Return iVal  
End Sub  
#End Region
```