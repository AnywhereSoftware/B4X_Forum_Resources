### Load and Save Combobox value using SQLite by aeric
### 11/08/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164016/)

This is an example I created for someone who said he doesn't know how to do it.  
Maybe it will benefit another person.  
  
Note: For cross platform, it is better to use B4XComboBox.  
  
Main module:  
Declare SQL object  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
#AdditionalJar: sqlite-jdbc-3.7.2  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Public DB As SQL  
    Public DATA_FOLDER As String  
    Public DATA_FILE As String = "data.db"  
End Sub
```

  
  
B4XMainPage:  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private CbbTime As ComboBox  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' Copy db file if not exist  
    If File.Exists(Main.DATA_FOLDER, Main.DATA_FILE) = False Then  
        File.Copy(File.DirAssets, Main.DATA_FILE, Main.DATA_FOLDER, Main.DATA_FILE)  
    End If  
      
    Main.DATA_FOLDER = File.DirApp  
    Main.DB.InitializeSQLite(Main.DATA_FOLDER, Main.DATA_FILE, False)  
    ' Load value from DB  
    Dim strSQL As String = "SELECT * FROM settings WHERE name = ?"  
    Dim setting As String = "Fajr"  
    Dim value As String  
    Dim RS As ResultSet = Main.DB.ExecQuery2(strSQL, Array As String(setting))  
    Do While RS.NextRow  
        value = RS.GetString("value")  
    Loop  
    RS.Close  
    Main.DB.Close  
      
    ' Populate Combobox  
    Dim list1 As List  
    list1.Initialize  
    For i = 1 To 60  
        list1.Add(i)  
    Next  
    CbbTime.Items.AddAll(list1)  
      
    ' Set value to Combobox  
    CbbTime.Value = value  
End Sub  
  
Private Sub BtnSave_Click  
    ' Open DB  
    Main.DB.InitializeSQLite(Main.DATA_FOLDER, Main.DATA_FILE, False)  
      
    ' Save value to DB  
    Dim strSQL As String = "UPDATE settings SET value = ? WHERE name = ?"  
    Dim setting As String = "Fajr"  
    Dim value As String = CbbTime.Value  
    Main.DB.ExecNonQuery2(strSQL, Array As String(value, setting))  
    Main.DB.Close  
    xui.MsgboxAsync("Settings saved", "Success")  
End Sub
```